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

# ## 包含 指定 模块
function( include_everything_package package_name package_path )
    if( NOT ${package_name}_FOUND )
        find_package( ${package_name} REQUIRED PATHS "${package_path}" GLOBAL )
    endif()
endfunction()

include_path_package()
include_setTargetProperty_package()
include_string_package()
include_targetLink_package()
include_addSubdirectory_package()

include_everything_package( test "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" )
