target_sources(Hadron
PRIVATE
    CSoundInterface.cpp 
    CSoundInterface.h 
    Hadron.cpp 
    Hadron.h 
    HadronPlugin.cpp 
    HadronPlugin.h 
    HadronProgram.cpp 
    HadronProgram.h 
    PluginParameter.h 
)

add_subdirectory(GUI)

if (WIN32)
    set(CSOUND_WIN_DIRECTORY ${CSOUND_DIRECTORY}/win/Csound_Hadron)
    target_include_directories(Hadron PRIVATE "${CSOUND_WIN_DIRECTORY}/include")
    if (WIN_ARCHITECTURE STREQUAL "x86")
    	target_link_libraries(Hadron PRIVATE "${CSOUND_WIN_DIRECTORY}/bin32/csound64_hadron32.lib")
    else()
    	target_link_libraries(Hadron PRIVATE "${CSOUND_WIN_DIRECTORY}/bin64/csound64_hadron64.lib")
    endif()
endif()

if (APPLE)
    set(CSOUND_MACOS_SCRIPTS ${CSOUND_DIRECTORY}/OSX)
    set(CSOUND_MACOS_FRAMEWORK ${CSOUND_MACOS_SCRIPTS}/Csound_framework/6_18/CsoundLib64.framework)
    set(CSOUND_MACOS_DIRECTORY ${CSOUND_MACOS_FRAMEWORK}/Versions/6.0)

    # CsoundLib64.framework is not committed to the repo (issue #2), so fetch it
    # and rewrite its install names here, at configure time. Relinking has to
    # happen before the plugin is linked: the linker copies the framework's
    # LC_ID_DYLIB into the plugin binary, so rewriting it afterwards is too late.
    #
    # Both scripts are idempotent - fetch returns immediately once the framework
    # is present, relink takes about 0.2s - so re-configuring stays cheap.
    execute_process(
        COMMAND "${CSOUND_MACOS_SCRIPTS}/fetch-csound-framework.sh"
        RESULT_VARIABLE csound_fetch_result)
    if (NOT csound_fetch_result EQUAL 0)
        message(FATAL_ERROR "fetch-csound-framework.sh failed (${csound_fetch_result})")
    endif()

    execute_process(
        COMMAND "${CSOUND_MACOS_SCRIPTS}/relink-csound-framework.sh"
        RESULT_VARIABLE csound_relink_result)
    if (NOT csound_relink_result EQUAL 0)
        message(FATAL_ERROR "relink-csound-framework.sh failed (${csound_relink_result})")
    endif()

    target_include_directories(Hadron PRIVATE "${CSOUND_MACOS_DIRECTORY}/Headers")
    #target_link_libraries(Hadron PRIVATE "${CSOUND_MACOS_DIRECTORY}/libcsnd6.6.0.dylib")
    target_link_libraries(Hadron PRIVATE "${CSOUND_MACOS_DIRECTORY}/CsoundLib64")

    # The framework is copied into the plugin bundles from ../CMakeLists.txt:
    # add_custom_command(TARGET ...) has to be called from the directory that
    # created the target, and JUCE creates the format targets there.
endif()
