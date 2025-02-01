cmake_minimum_required( VERSION 3.19 )

# ## 配置指定目标的 用户 tools 库
function( add_subdirectory_tools_lib )
    set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../userLib/tools" )
    add_subdirectory( ${root_path} )
endfunction()

# # 追加路径到项目列表，同时校验去除参数当中重复的路径
function( append_sub_directory_cmake_project_path path_dir_s )
    set( exis_dir_path_s ) # 保存已经加载的列表

    foreach( out_dir ${${path_dir_s}} )
        get_filename_component( absolutePath "${out_dir}" ABSOLUTE ) # 全路径
        message( STATUS "正在添加路径 :\t" ${absolutePath} )
        add_subdirectory( ${absolutePath} )
        list( APPEND exis_dir_path_s ${absolutePath} )
    endforeach()
endfunction()
