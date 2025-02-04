cmake_minimum_required( VERSION 3.19 )

# ## 把工具库加入 cmake 项目内
function( add_subdirectory_tools_lib )
    set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../userLib/tools" )
    append_sub_directory_cmake_project_path( root_path )
endfunction()

# ## 把测试库加入 cmake 项目内
function( add_subdirectory_test_code_project )
    set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../testCode/" )
    get_path_cmake_dir_path( lib_list "${root_path}" "CMakeLists.txt" )
    filter_path_repetition( list_result lib_list )
    append_sub_directory_cmake_project_path( list_result )
endfunction()

# # 追加路径到项目列表，同时校验去除参数当中重复的路径
function( append_sub_directory_cmake_project_path path_dir_s )
    # 获取列表
    get_in_cmakeFunction_call_load_sub_directory_project_list( _load_list )

    foreach( out_dir ${${path_dir_s}} )
        get_filename_component( absolutePath "${out_dir}" ABSOLUTE ) # 全路径
        list( FIND _load_list "${absolutePath}" index )

        if( index EQUAL -1 AND IS_DIRECTORY "${absolutePath}" AND EXISTS "${absolutePath}" )
            message( STATUS "正在添加路径 :\t" "${absolutePath}" )
            add_subdirectory( "${absolutePath}" )
            list( APPEND _load_list "${absolutePath}" )
        endif()
    endforeach()

    # 重新配置列表
    set( property_name "addend_sub_directory_list_property" )
    get_property( _my_addend_sub_directory_list_is_define GLOBAL PROPERTY "${property_name}" DEFINED )

    if( _my_addend_sub_directory_list_is_define )
        set_property( GLOBAL PROPERTY "${property_name}" ${_load_list} )
    else()
        define_property( GLOBAL PROPERTY "${property_name}" )
        set_property( GLOBAL PROPERTY "${property_name}" ${_load_list} )
    endif()
endfunction()

# # 获取使用 append_sub_directory_cmake_project_path 加载子项目列表的项目路径列表
function( get_in_cmakeFunction_call_load_sub_directory_project_list result_list_ )
    set( property_name "addend_sub_directory_list_property" )
    get_property( _my_addend_sub_directory_list_is_define GLOBAL PROPERTY "${property_name}" DEFINED )

    if( _my_addend_sub_directory_list_is_define )
        get_property( _my_addend_sub_directory_list GLOBAL PROPERTY "${property_name}" )
        set( ${result_list_} ${_my_addend_sub_directory_list} PARENT_SCOPE )
        return()
    endif()

    define_property( GLOBAL PROPERTY "${property_name}" )
endfunction()

message( "----\n\t\t调用:(${CMAKE_CURRENT_LIST_FILE}[${CMAKE_CURRENT_FUNCTION}]:${CMAKE_CURRENT_FUNCTION_LIST_LINE})行 ->\n\t\t\t消息:列表加载完毕" )
