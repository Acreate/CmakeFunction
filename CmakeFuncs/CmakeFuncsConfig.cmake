cmake_minimum_required( VERSION 3.19 )

include( CMakeParseArguments )

set( Project_Run_Bin_Path "${CMAKE_HOME_DIRECTORY}/builder/${CMAKE_BUILD_TYPE}/${CMAKE_CXX_COMPILER_ARCHITECTURE_ID}_${CMAKE_CXX_COMPILER_ID}_bin/" )
set( Project_Run_Pbd_Path "${CMAKE_HOME_DIRECTORY}/builder/${CMAKE_BUILD_TYPE}/${CMAKE_CXX_COMPILER_ARCHITECTURE_ID}_${CMAKE_CXX_COMPILER_ID}_pbd/" )
set( Project_Run_Static_Lib_Path "${CMAKE_HOME_DIRECTORY}/builder/${CMAKE_BUILD_TYPE}/${CMAKE_CXX_COMPILER_ARCHITECTURE_ID}_${CMAKE_CXX_COMPILER_ID}_lib/" )
set( Project_Install_Path "${CMAKE_HOME_DIRECTORY}/builder/install/" )

find_package( addSubdirectory REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
find_package( path REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
find_package( setTargetProperty REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
find_package( string REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
find_package( targetLink REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
find_package( qt REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )

get_filename_component( abs "${CMAKE_CURRENT_LIST_FILE}" ABSOLUTE )
string( FIND "${abs}" "${CMAKE_HOME_DIRECTORY}" index )

if( NOT ${index} EQUAL -1 )
    string( LENGTH "${abs}" _orgStrLen )
    string( LENGTH "${CMAKE_HOME_DIRECTORY}" _findStrLen )
    math( EXPR _subLen "${_orgStrLen} - ${_findStrLen}" )
    string( SUBSTRING "${abs}" ${_findStrLen} ${_subLen} abs )
    set( abs ".${abs}" )
endif()

message( "----\n\t\t调用:(${abs}[${CMAKE_CURRENT_FUNCTION}]:${CMAKE_CURRENT_LIST_LINE})行 ->\n\t\t\t消息:列表加载完毕" )
