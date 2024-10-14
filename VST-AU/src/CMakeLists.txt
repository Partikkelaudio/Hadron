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
