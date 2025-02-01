cmake_minimum_required( VERSION 3.19 )

# ## 根据目录获取一个文件夹名称
function( get_current_dir_name out_name in_path )
    string( REGEX REPLACE ".*/(.*)" "\\1" CURRENT_FOLDER ${in_path} )
    set( ${out_name} ${CURRENT_FOLDER} PARENT_SCOPE )
endfunction()

# ## 根据目录获取一个文件夹名称
function( get_parent_dir_name out_name in_path )
    string( REGEX REPLACE ".*/(.*)/(.*)" "\\1" CURRENT_FOLDER ${in_path} )
    set( ${out_name} ${CURRENT_FOLDER} PARENT_SCOPE )
endfunction()

# ## 在目录中查找目录，并且在目标目录中找到 file_name 的文件名
# ## 若存在，则返回所在目录的路径
# ## 文件名不区分大小写
function( get_path_cmake_dir_path out_list check_path_dir file_name )
    set( for_each_list_dirs ${${out_list}} )

    if( IS_DIRECTORY "${check_path_dir}" )
        # # 获取所有目录
        file( GLOB_RECURSE file_get_file_paths "${check_path_dir}/*" )

        foreach( current_path_file ${file_get_file_paths} )
            string( REGEX REPLACE ".+/(.*)" "\\1" out_file_name ${current_path_file} )

            if( "${file_name}" STREQUAL "${out_file_name}" )
                string( REGEX REPLACE "(.+)/.*" "\\1" out_path_file ${current_path_file} )
                list( APPEND for_each_list_dirs "${out_path_file}" )
            endif()
        endforeach()

        set( ${out_list} ${for_each_list_dirs} PARENT_SCOPE )
    endif()
endfunction()

# # 查找指定路径的 *.cpp *.c *.hpp *.h 文件
# # check_path : 路径
# # out_file_list : 返回值
function( get_path_cxx_and_c_sources check_path out_file_list )
    set( for_each_list_dirs ${${out_file_list}} )
    file( GLOB_RECURSE file_get_names
        "${check_path}/*.cpp"
        "${check_path}/*.c"
        "${check_path}/*.hpp"
        "${check_path}/*.h"
    )

    foreach( get_file_name ${file_get_names} )
        file( REAL_PATH "${get_file_name}" out_value_path )
        list( APPEND for_each_file_list ${out_value_path} )
    endforeach()

    set( ${out_file_list} ${for_each_file_list} PARENT_SCOPE )
endfunction()

# ## 查找匹配拓展名的文件
# ## check_path : 检查路径
# ## find_expansion : 拓展名列表
# ## out_file_list : 返回输出
function( get_path_sources check_path find_expansion out_file_list )
    set( for_each_list_dirs ${${out_file_list}} )

    foreach( types_name ${find_expansion} )
        # message( "检测源码路径 : ${check_path}/${types_name}" )
        file( GLOB_RECURSE file_get_names "${check_path}/*.${types_name}" )

        foreach( get_file_name ${file_get_names} )
            # message( "发现文件 : ${get_file_name}" )
            list( APPEND for_each_file_list ${get_file_name} )
        endforeach()
    endforeach()

    set( ${out_file_list} ${for_each_file_list} PARENT_SCOPE )
endfunction()

# ## 使用全局的安装文件方式拷贝文件
# ## @dest_dir_path 目标目录
# ## @... 多个文件
function( user_install_copy_file dest_dir_path )
    math( EXPR resultIndex "${ARGC}-1" OUTPUT_FORMAT DECIMAL )

    foreach( item RANGE 1 ${resultIndex} )
        list( GET ARGV ${item} outListIndexValue )
        install( FILES ${outListIndexValue} DESTINATION "${dest_dir_path}/${baseName}" )
    endforeach()
endfunction()

function( copy_dir_path_cmake_file_command source_path target_path )
    get_absolute_path( result_abs_path ${source_path} )

    if( EXISTS ${source_path} )
        set( copy_file_target_dir "${Project_Run_Bin_Path}/${PROJECT_NAME}" )
        set( copy_file_src_dir "${result_abs_path}" )
        file( COPY "${result_abs_path}" DESTINATION "${copy_file_target_dir}" )
        message( "执行拷贝任务：${result_abs_path} 拷贝到: ${copy_file_target_dir}" )
    else()
        message( "路径 ${result_abs_path} 不存在，拷贝命令失效" )
    endif()
endfunction()

# # 拷贝目录到指定路径
function( copy_dir_path_cmake_add_custom_command_POST_BUILD_command builder_target copy_dir_target paste_dir_target )
    get_absolute_path( result_abs_path ${source_path} )

    if( EXISTS ${source_path} )
        add_custom_command(
            TARGET ${builder_target} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E echo "执行拷贝任务：${result_abs_path} 拷贝到: ${paste_dir_target}"
            COMMAND ${CMAKE_COMMAND} -E copy_directory "${result_abs_path}/" "${paste_dir_target}"
        )
    else()
        add_custom_command(
            TARGET ${builder_target} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E echo "执行拷贝任务：${result_abs_path} 拷贝到: ${paste_dir_target}"
        )
    endif()
endfunction()

# # 拷贝目录到指定路径
function( copy_dir_path_cmake_add_custom_command_PRE_BUILD_command builder_target copy_dir_target paste_dir_target )
    get_absolute_path( result_abs_path ${source_path} )

    if( EXISTS ${source_path} )
        add_custom_command(
            TARGET ${builder_target} PRE_BUILD
            COMMAND ${CMAKE_COMMAND} -E echo "执行拷贝任务：${result_abs_path} 拷贝到: ${paste_dir_target}"
            COMMAND ${CMAKE_COMMAND} -E copy_directory "${result_abs_path}/" "${paste_dir_target}"
        )
    else()
        add_custom_command(
            TARGET ${builder_target} PRE_BUILD
            COMMAND ${CMAKE_COMMAND} -E echo "执行拷贝任务：${result_abs_path} 拷贝到: ${paste_dir_target}"
        )
    endif()
endfunction()

# # 拷贝目录到指定路径
function( copy_dir_path_cmake_add_custom_command_PRE_LINK_command builder_target copy_dir_target paste_dir_target )
    get_absolute_path( result_abs_path ${source_path} )

    if( EXISTS ${source_path} )
        add_custom_command(
            TARGET ${builder_target} PRE_LINK
            COMMAND ${CMAKE_COMMAND} -E echo "执行拷贝任务：${result_abs_path} 拷贝到: ${paste_dir_target}"
            COMMAND ${CMAKE_COMMAND} -E copy_directory "${result_abs_path}/" "${paste_dir_target}"
        )
    else()
        add_custom_command(
            TARGET ${builder_target} PRE_LINK
            COMMAND ${CMAKE_COMMAND} -E echo "执行拷贝任务：${result_abs_path} 拷贝到: ${paste_dir_target}"
        )
    endif()
endfunction()

# # 配置模板到指定路径
function( configure_temp_files trget_name target_path )
    set( rootPath "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../temp/cmake_in" )
    configure_file( "${rootPath}/cmake_to_c_cpp_header_env.h.in" "${target_path}/cmake_to_c_cpp_header_env.h" ) # # 项目信息
endfunction()

# # 过滤重复路径
function( filter_path_repetition result_list path_dir_s )
    set( exis_dir_path_s ) # 保存已经加载的列表

    foreach( out_dir ${${path_dir_s}} )
        set( load_project_path TRUE ) # 是否存在
        get_filename_component( absolutePath "${out_dir}" ABSOLUTE ) # 全路径

        foreach( check_exis_path ${exis_dir_path_s} )
            if( ${check_exis_path} STREQUAL ${absolutePath} )
                set( load_project_path FALSE ) # 是否存在
                break()
            endif()
        endforeach()

        if( ${load_project_path} ) # # 校验可以加载即可
            list( APPEND exis_dir_path_s ${absolutePath} )
        endif()
    endforeach()

    set( ${result_list} ${exis_dir_path_s} PARENT_SCOPE )
endfunction()

# # 返回模板根目录
function( get_temp_file_dir_path result_dir_path )
    get_filename_component( absolutePath "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../temp/" ABSOLUTE ) # 全路径
    set( ${result_dir_path} "${absolutePath}/" PARENT_SCOPE )
endfunction()

# # 获取路径的全路径
function( get_absolute_path result_dir_path in_path )
    get_filename_component( absolutePath "${in_path}" ABSOLUTE ) # 全路径
    set( ${result_dir_path} "${absolutePath}" PARENT_SCOPE )
endfunction()

# # 返回路径分隔符
function( get_cmake_separator result_path_sep )
    get_filename_component( absolutePath "${CMAKE_CURRENT_FUNCTION_LIST_DIR}" ABSOLUTE ) # 全路径
    get_filename_component( absoluteParentPath "${CMAKE_CURRENT_FUNCTION_LIST_DIR}" NAME ) # 父路径
    string( LENGTH ${absoluteParentPath} fileNameLen )
    string( LENGTH ${absolutePath} absoluteFileNameLen )
    math( EXPR beginIndex "${absoluteFileNameLen}-${fileNameLen}" OUTPUT_FORMAT DECIMAL )
    string( SUBSTRING ${absolutePath} 0 ${beginIndex} resultSubString )
    math( EXPR satrtIndex "${beginIndex}-1" OUTPUT_FORMAT DECIMAL )
    string( SUBSTRING ${absolutePath} ${satrtIndex} 1 resultSep )
    set( ${result_path_sep} "${resultSep}" PARENT_SCOPE )
endfunction()
