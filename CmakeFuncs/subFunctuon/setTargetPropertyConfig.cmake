cmake_minimum_required( VERSION 3.19 )

# ## 设置程序输出位置
function( set_target_BIN_out_path_property target_obj out_path )
    set_target_properties( ${target_obj} PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY ${out_path}

        # RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
        # RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
        # RUNTIME_OUTPUT_DIRECTORY_RELEASE ${out_path}
        # RUNTIME_OUTPUT_DIRECTORY_DEBUG ${out_path}
    )
endfunction()

# ## 设置静态库输出位置
function( set_target_Static_Lib_out_path_property target_obj out_path )
    set_target_properties( ${target_obj} PROPERTIES
        LIBRARY_OUTPUT_DIRECTORY ${out_path}

        # LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
        # LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
        # LIBRARY_OUTPUT_DIRECTORY_RELEASE ${out_path}
        # LIBRARY_OUTPUT_DIRECTORY_DEBUG ${out_path}
        ARCHIVE_OUTPUT_DIRECTORY ${out_path}

        # ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
        # ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
        # ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${out_path}
        # ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${out_path}
    )
endfunction()

# ## 设置 pbd 输出位置
function( set_target_PDB_out_path_property target_obj out_path )
    set_target_properties( ${target_obj} PROPERTIES
        PDB_OUTPUT_DIRECTORY ${out_path}

        # PDB_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
        # PDB_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
        # PDB_OUTPUT_DIRECTORY_RELEASE ${out_path}
        # PDB_OUTPUT_DIRECTORY_DEBUG ${out_path}
    )
    set_target_properties( ${target_obj} PROPERTIES
        COMPILE_PDB_OUTPUT_DIRECTORY ${out_path}

        # COMPILE_PDB_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
        # COMPILE_PDB_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
        # COMPILE_PDB_OUTPUT_DIRECTORY_RELEASE ${out_path}
        # COMPILE_PDB_OUTPUT_DIRECTORY_DEBUG ${out_path}
    )
endfunction()

# ## 设置程序为命令行窗口
function( set_target_WIN32_cmd_windows target_obj )
    if( WIN32 )
        set_target_properties( ${target_obj} PROPERTIES WIN32_EXECUTABLE FALSE )
    endif()
endfunction()

# ## 设置程序为窗口
function( set_target_WIN32_show_windows target_obj )
    if( WIN32 )
        set_target_properties( ${target_obj} PROPERTIES WIN32_EXECUTABLE TRUE )
    endif()
endfunction()
