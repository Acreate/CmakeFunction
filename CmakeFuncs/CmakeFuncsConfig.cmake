cmake_minimum_required( VERSION 3.19 )

# ## 包含 addSubdirectory 模块
function( include_addSubdirectory_package )
    if( NOT addSubdirectory_FOUND )
        find_package( addSubdirectory REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
    endif()
endfunction()

# ## 包含 path 模块
function( include_path_package )
    if( NOT path_FOUND )
        find_package( path REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
    endif()
endfunction()

# ## 包含 setTargetProperty 模块
function( include_setTargetProperty_package )
    if( NOT setTargetProperty_FOUND )
        find_package( setTargetProperty REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
    endif()
endfunction()

# ## 包含 string 模块
function( include_string_package )
    if( NOT stringy_FOUND )
        find_package( string REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
    endif()
endfunction()

# ## 包含 targetLink 模块
function( include_targetLink_package )
    if( NOT targetLink_FOUND )
        find_package( targetLink REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
    endif()
endfunction()

# ## 包含 targetLink 模块
macro( include_qt_package )
    find_package( qt REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" )
endmacro()

include_path_package()
include_setTargetProperty_package()
include_string_package()
include_targetLink_package()
include_addSubdirectory_package()
include_qt_package()

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
