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
    set(CSOUND_MACOS_DIRECTORY ${CSOUND_DIRECTORY}/OSX/Csound_framework/6_18/CsoundLib64.framework/Versions/6.0)
    target_include_directories(Hadron PRIVATE "${CSOUND_MACOS_DIRECTORY}/Headers")
    #target_link_libraries(Hadron PRIVATE "${CSOUND_MACOS_DIRECTORY}/libcsnd6.6.0.dylib")
    target_link_libraries(Hadron PRIVATE "${CSOUND_MACOS_DIRECTORY}/CsoundLib64")
endif()