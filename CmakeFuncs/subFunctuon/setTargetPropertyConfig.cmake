cmake_minimum_required( VERSION 3.19 )

# ## 设置程序输出位置
function( set_target_BIN_out_path_property target_obj out_path )
    set_target_properties( "${target_obj}" PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${out_path}"

        # RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
        # RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
        # RUNTIME_OUTPUT_DIRECTORY_RELEASE ${out_path}
        # RUNTIME_OUTPUT_DIRECTORY_DEBUG ${out_path}
    )
endfunction()

# ## 设置静态库输出位置
function( set_target_Static_Lib_out_path_property target_obj out_path )
    set_target_properties( "${target_obj}" PROPERTIES
        LIBRARY_OUTPUT_DIRECTORY "${out_path}"

        # LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
        # LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
        # LIBRARY_OUTPUT_DIRECTORY_RELEASE ${out_path}
        # LIBRARY_OUTPUT_DIRECTORY_DEBUG ${out_path}
        ARCHIVE_OUTPUT_DIRECTORY "${out_path}"

        # ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
        # ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
        # ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${out_path}
        # ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${out_path}
    )
endfunction()

# ## 设置 pbd 输出位置
function( set_target_PDB_out_path_property target_obj out_path )
    set_target_properties( "${target_obj}" PROPERTIES
        PDB_OUTPUT_DIRECTORY "${out_path}"

        # PDB_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
        # PDB_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
        # PDB_OUTPUT_DIRECTORY_RELEASE ${out_path}
        # PDB_OUTPUT_DIRECTORY_DEBUG ${out_path}
    )
    set_target_properties( "${target_obj}" PROPERTIES
        COMPILE_PDB_OUTPUT_DIRECTORY "${out_path}"

        # COMPILE_PDB_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
        # COMPILE_PDB_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
        # COMPILE_PDB_OUTPUT_DIRECTORY_RELEASE ${out_path}
        # COMPILE_PDB_OUTPUT_DIRECTORY_DEBUG ${out_path}
    )
endfunction()

# ## 设置 pbd 输出位置
function( enable_target_PDB_propertie target_obj )
    set_target_properties( "${target_obj}" PROPERTIES
        CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Zi"
        CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /DEBUG /OPT:REF /OPT:ICF"
        CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /DEBUG /OPT:REF /OPT:ICF"
    )
endfunction()

# ## 设置程序为命令行窗口
function( set_target_WIN32_cmd_windows target_obj )
    if( WIN32 )
        set_target_properties( "${target_obj}" PROPERTIES WIN32_EXECUTABLE FALSE )
    endif()
endfunction()

# ## 设置程序为窗口
function( set_target_WIN32_show_windows target_obj )
    if( WIN32 )
        set_target_properties( "${target_obj}" PROPERTIES WIN32_EXECUTABLE TRUE )
    endif()
endfunction()

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
