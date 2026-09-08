cmake_minimum_required(VERSION 3.22)

set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Default build type: Release")

# Build for both Intel and Apple Silicon. Without this the build silently
# inherits the host architecture, which is how the previously shipped plugins
# ended up arm64-only. Set before project() so the compiler checks run against
# both slices. The embedded CsoundLib64.framework is universal already.
if (APPLE)
    set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64"
        CACHE STRING "Build universal binaries for Intel and Apple Silicon")

    # Oldest macOS the plugin runs on. Unset, this inherits the build host,
    # which makes the Intel slice useless: built on Sonoma it would refuse to
    # load on the Intel Macs that are the only reason to ship that slice.
    #
    # 10.13 is the lowest value everything in the build supports. The embedded
    # CsoundLib64.framework and every dylib under it are built for 10.9 on
    # x86_64, JUCE 8.0.2 refuses to build below 10.11, and Hadron uses no C++17
    # library feature carrying a macOS availability limit. The arm64 slice is
    # bumped to 11.0 by the toolchain, since no arm64 Mac predates it.
    set(CMAKE_OSX_DEPLOYMENT_TARGET "10.13"
        CACHE STRING "Oldest supported macOS (arm64 is raised to 11.0 automatically)")
endif()

project(Hadron VERSION 1.0.1)

# Install the built plugin into the user plug-in folders as the last build step,
# so a build is immediately testable in a host:
#
#     AU  -> ~/Library/Audio/Plug-Ins/Components/Hadron.component
#     VST -> ~/Library/Audio/Plug-Ins/VST/Hadron.vst
#
# This is ON by default on macOS. To build without installing:
#
#     cmake -S VST-AU -B <build dir> -DCOPY_PLUGIN_AFTER_BUILD=0
#
# Note that it overwrites whatever is already installed there, including a
# release build, and that a Debug build installs a Debug plugin.
#
# It defaults to OFF elsewhere because the Windows destination is
# %ProgramFiles%/Steinberg/Vstplugins, which needs an elevated shell and would
# otherwise fail the build. Set it to 1 there if you want it and can write to
# that directory.
if (APPLE)
    set(hadron_copy_default ON)
else()
    set(hadron_copy_default OFF)
endif()

option(COPY_PLUGIN_AFTER_BUILD
    "Install the plugin into the user plug-in folders after each build"
    ${hadron_copy_default})

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(HADRON_PROJECT_DIR ${CMAKE_CURRENT_SOURCE_DIR} )
cmake_path(GET HADRON_PROJECT_DIR PARENT_PATH PARENT_DIR)
set(CSOUND_DIRECTORY "${PARENT_DIR}/CsoundMod")

# If you've installed JUCE somehow (via a package manager, or directly using the CMake install
# target), you'll need to tell this project that it depends on the installed copy of JUCE. If you've
# included JUCE directly in your source tree (perhaps as a submodule), you'll need to tell CMake to
# include that subdirectory as part of the build.

add_subdirectory(vendor)

# If you are building a VST2 or AAX plugin, CMake needs to be told where to find these SDKs on your
# system. This setup should be done before calling `juce_add_plugin`.

if (WIN32)
    juce_set_vst2_sdk_path(../../vst2.4)
endif()

if (APPLE)
    juce_set_vst2_sdk_path(../../vstsdk2.4)
endif()

# `juce_add_plugin` adds a static library target with the name passed as the first argument
# (AudioPluginExample here). This target is a normal CMake target, but has a lot of extra properties set
# up by default. As well as this shared code static library, this function adds targets for each of
# the formats specified by the FORMATS arguments. This function accepts many optional arguments.
# Check the readme at `docs/CMake API.md` in the JUCE repo for the full list.

juce_add_plugin(Hadron
    # VERSION ...                               # Set this if the plugin version is different to the project version
    # ICON_BIG ...                              # ICON_* arguments specify a path to an image file to use as an icon for the Standalone
    # ICON_SMALL ...
    COMPANY_NAME partikkelaudio                 # Specify the name of the plugin's author
    IS_SYNTH FALSE                              # Is this a synth or an effect?
    NEEDS_MIDI_INPUT TRUE                       # Does the plugin need midi input?
    # NEEDS_MIDI_OUTPUT TRUE/FALSE              # Does the plugin need midi output?
    # IS_MIDI_EFFECT TRUE/FALSE                 # Is this plugin a MIDI effect?
    # EDITOR_WANTS_KEYBOARD_FOCUS TRUE/FALSE    # Does the editor need keyboard focus?
    # COPY_PLUGIN_AFTER_BUILD is deliberately NOT set here. It would install the
    # bundle before the Csound framework is embedded into it; see the call to
    # juce_enable_copy_plugin_step below.
    PLUGIN_MANUFACTURER_CODE PaAu               # A four-character manufacturer id with at least one upper-case character
    PLUGIN_CODE 7263                            # A unique four-character plugin id with exactly one upper-case character
                                                # GarageBand 10.3 requires the first letter to be upper-case, and the remaining letters to be lower-case
    FORMATS AU VST
    PRODUCT_NAME "Hadron")        # The name of the final executable, which can differ from the target name

target_compile_definitions(Hadron PRIVATE JUCE_MODAL_LOOPS_PERMITTED=1)

juce_generate_juce_header(Hadron)

add_subdirectory(src)

if (APPLE)
    # Copy CsoundLib64.framework into each plugin bundle at Contents/Frameworks,
    # which is where the install name written by relink-csound-framework.sh
    # points. src/CMakeLists.txt does the fetching and relinking; only this part
    # has to be here, because add_custom_command(TARGET ...) must be called from
    # the directory that created the target.
    #
    # Iterating JUCE's own list of format targets keeps this in step with the
    # FORMATS given to juce_add_plugin above.
    get_target_property(hadron_plugin_targets Hadron JUCE_ACTIVE_PLUGIN_TARGETS)
    if (NOT hadron_plugin_targets)
        message(FATAL_ERROR
            "no JUCE plugin targets found; the Csound framework would not be "
            "embedded and the built plugin would not load")
    endif()

    foreach (plugin_target IN LISTS hadron_plugin_targets)
        add_custom_command(TARGET ${plugin_target} POST_BUILD
            COMMAND "${CSOUND_DIRECTORY}/OSX/embed-csound-framework.sh"
                    "$<TARGET_BUNDLE_DIR:${plugin_target}>"
            COMMENT "Embedding CsoundLib64.framework into ${plugin_target}"
            VERBATIM)
    endforeach()
endif()

# Registered here, after the POST_BUILD step above, and never as
# juce_add_plugin's COPY_PLUGIN_AFTER_BUILD. POST_BUILD commands run in the
# order they are added, and juce_add_plugin adds its copy from inside itself,
# so setting the keyword there would install the bundle before the Csound
# framework is embedded into it: the installed plugin would be missing
# CsoundLib64 and would fail to load, while the one in the build tree worked.
# Deferring the copy this way is what JUCE's own CMake docs prescribe for
# builds that modify the bundle. JUCE's copy uses file(INSTALL), which
# preserves the framework's symlinks.
if (COPY_PLUGIN_AFTER_BUILD)
    juce_enable_copy_plugin_step(Hadron)
endif()

# `target_compile_definitions` adds some preprocessor definitions to our target. In a Projucer
# project, these might be passed in the 'Preprocessor Definitions' field. JUCE modules also make use
# of compile definitions to switch certain features on/off, so if there's a particular feature you
# need that's not on by default, check the module header for the correct flag to set here. These
# definitions will be visible both to your code, and also the JUCE module code, so for new
# definitions, pick unique names that are unlikely to collide! This is a standard CMake command.

target_compile_definitions(Hadron
    PUBLIC
        # JUCE_WEB_BROWSER and JUCE_USE_CURL would be on by default, but you might not need them.
        JUCE_WEB_BROWSER=0  # If you remove this, add `NEEDS_WEB_BROWSER TRUE` to the `juce_add_plugin` call
        JUCE_USE_CURL=0     # If you remove this, add `NEEDS_CURL TRUE` to the `juce_add_plugin` call
        JUCE_VST3_CAN_REPLACE_VST2=0)

# If your target needs extra binary assets, you can add them here. The first argument is the name of
# a new static library target that will include all the binary resources. There is an optional
# `NAMESPACE` argument that can specify the namespace of the generated binary data class. Finally,
# the SOURCES argument should be followed by a list of source files that should be built into the
# static library. These source files can be of any kind (wav data, images, fonts, icons etc.).
# Conversion to binary-data will happen when your target is built.

juce_add_binary_data(HadronData
	SOURCES 
	assets/Background_495x269.png
	assets/Documentation_Link_18x18.png
	assets/Exp_slider_mask_Alpha_32x167.png
	assets/Expression_Slider_Knob_32x17.png
	assets/Loading.png
	assets/REC_hover_off.png
	assets/REC_hover_on.png
	assets/REC_idle_off.png
	assets/REC_idle_on.png
)

# `target_link_libraries` links libraries and JUCE modules to other libraries or executables. Here,
# we're linking our executable target to the `juce::juce_audio_utils` module. Inter-module
# dependencies are resolved automatically, so `juce_core`, `juce_events` and so on will also be
# linked automatically. If we'd generated a binary data target above, we would need to link to it
# here too. This is a standard CMake command.

target_link_libraries(Hadron
    PRIVATE
        HadronData
        juce::juce_audio_utils
    PUBLIC
        juce::juce_recommended_config_flags
        juce::juce_recommended_lto_flags
        juce::juce_recommended_warning_flags)
