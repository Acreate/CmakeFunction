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

# # ## 根据目录获取一个文件夹名称
# function( get_current_dir_name out_name in_path )
# string( REGEX REPLACE ".*/(.*)" "\\1" CURRENT_FOLDER ${in_path} )
# set( ${out_name} ${CURRENT_FOLDER} PARENT_SCOPE )
# endfunction()

# # ## 根据目录获取一个文件夹名称
# function( get_parent_dir_name out_name in_path )
# string( REGEX REPLACE ".*/(.*)/(.*)" "\\1" CURRENT_FOLDER ${in_path} )
# set( ${out_name} ${CURRENT_FOLDER} PARENT_SCOPE )
# endfunction()

# # ## 在目录中查找目录，并且在目标目录中找到 file_name 的文件名
# # ## 若存在，则返回所在目录的路径
# # ## 文件名不区分大小写
# function( get_path_cmake_dir_path out_list check_path_dir file_name )
# set( for_each_list_dirs ${${out_list}} )

# if( IS_DIRECTORY "${check_path_dir}" )
# # # 获取所有目录
# file( GLOB_RECURSE file_get_file_paths "${check_path_dir}/*" )

# foreach( current_path_file ${file_get_file_paths} )
# string( REGEX REPLACE ".+/(.*)" "\\1" out_file_name ${current_path_file} )

# if( "${file_name}" STREQUAL "${out_file_name}" )
# string( REGEX REPLACE "(.+)/.*" "\\1" out_path_file ${current_path_file} )
# list( APPEND for_each_list_dirs "${out_path_file}" )
# endif()
# endforeach()

# set( ${out_list} ${for_each_list_dirs} PARENT_SCOPE )
# endif()
# endfunction()

# # # 查找指定路径的 *.cpp *.c *.hpp *.h 文件
# # # check_path : 路径
# # # out_file_list : 返回值
# function( get_path_cxx_and_c_sources check_path out_file_list )
# set( for_each_list_dirs ${${out_file_list}} )
# file( GLOB_RECURSE file_get_names
# "${check_path}/*.cpp"
# "${check_path}/*.c"
# "${check_path}/*.hpp"
# "${check_path}/*.h"
# )

# foreach( get_file_name ${file_get_names} )
# file( REAL_PATH "${get_file_name}" out_value_path )
# list( APPEND for_each_file_list ${out_value_path} )
# endforeach()

# set( ${out_file_list} ${for_each_file_list} PARENT_SCOPE )
# endfunction()

# # ## 查找匹配拓展名的文件
# # ## check_path : 检查路径
# # ## find_expansion : 拓展名列表
# # ## out_file_list : 返回输出
# function( get_path_sources check_path find_expansion out_file_list )
# set( for_each_list_dirs ${${out_file_list}} )

# foreach( types_name ${find_expansion} )
# # message( "检测源码路径 : ${check_path}/${types_name}" )
# file( GLOB_RECURSE file_get_names "${check_path}/*.${types_name}" )

# foreach( get_file_name ${file_get_names} )
# # message( "发现文件 : ${get_file_name}" )
# list( APPEND for_each_file_list ${get_file_name} )
# endforeach()
# endforeach()

# set( ${out_file_list} ${for_each_file_list} PARENT_SCOPE )
# endfunction()

# # ## 设置程序输出位置
# function( set_target_BIN_out_path_property target_obj out_path )
# set_target_properties( ${target_obj} PROPERTIES
# RUNTIME_OUTPUT_DIRECTORY ${out_path}

# # RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
# # RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
# # RUNTIME_OUTPUT_DIRECTORY_RELEASE ${out_path}
# # RUNTIME_OUTPUT_DIRECTORY_DEBUG ${out_path}
# )
# endfunction()

# # ## 设置静态库输出位置
# function( set_target_Static_Lib_out_path_property target_obj out_path )
# set_target_properties( ${target_obj} PROPERTIES
# LIBRARY_OUTPUT_DIRECTORY ${out_path}

# # LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
# # LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
# # LIBRARY_OUTPUT_DIRECTORY_RELEASE ${out_path}
# # LIBRARY_OUTPUT_DIRECTORY_DEBUG ${out_path}
# ARCHIVE_OUTPUT_DIRECTORY ${out_path}

# # ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
# # ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
# # ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${out_path}
# # ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${out_path}
# )
# endfunction()

# # ## 设置 pbd 输出位置
# function( set_target_PDB_out_path_property target_obj out_path )
# set_target_properties( ${target_obj} PROPERTIES
# PDB_OUTPUT_DIRECTORY ${out_path}

# # PDB_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
# # PDB_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
# # PDB_OUTPUT_DIRECTORY_RELEASE ${out_path}
# # PDB_OUTPUT_DIRECTORY_DEBUG ${out_path}
# )
# set_target_properties( ${target_obj} PROPERTIES
# COMPILE_PDB_OUTPUT_DIRECTORY ${out_path}

# # COMPILE_PDB_OUTPUT_DIRECTORY_MINSIZEREL ${out_path}
# # COMPILE_PDB_OUTPUT_DIRECTORY_RELWITHDEBINFO ${out_path}
# # COMPILE_PDB_OUTPUT_DIRECTORY_RELEASE ${out_path}
# # COMPILE_PDB_OUTPUT_DIRECTORY_DEBUG ${out_path}
# )
# endfunction()

# # ## 设置程序为命令行窗口
# function( set_target_WIN32_cmd_windows target_obj )
# if( WIN32 )
# set_target_properties( ${target_obj} PROPERTIES WIN32_EXECUTABLE FALSE )
# endif()
# endfunction()

# # ## 设置程序为窗口
# function( set_target_WIN32_show_windows target_obj )
# if( WIN32 )
# set_target_properties( ${target_obj} PROPERTIES WIN32_EXECUTABLE TRUE )
# endif()
# endfunction()

# # ## 标准化项目名称
# function( normal_project_name noormal_name org_name )
# string( REPLACE " " "_" var_replace ${org_name} )
# string( REPLACE "/" "_" var_replace ${var_replace} )
# set( ${noormal_name} ${var_replace} PARENT_SCOPE )
# endfunction()

# # # 追加路径到项目列表，同时校验去除参数当中重复的路径
# function( append_sub_directory_cmake_project_path path_dir_s )
# set( exis_dir_path_s ) # 保存已经加载的列表

# foreach( out_dir ${${path_dir_s}} )
# get_filename_component( absolutePath "${out_dir}" ABSOLUTE ) # 全路径
# message( STATUS "正在添加路径 :\t" ${absolutePath} )
# add_subdirectory( ${absolutePath} )
# list( APPEND exis_dir_path_s ${absolutePath} )
# endforeach()
# endfunction()

# # # 过滤重复路径
# function( filter_path_repetition result_list path_dir_s )
# set( exis_dir_path_s ) # 保存已经加载的列表

# foreach( out_dir ${${path_dir_s}} )
# set( load_project_path TRUE ) # 是否存在
# get_filename_component( absolutePath "${out_dir}" ABSOLUTE ) # 全路径

# foreach( check_exis_path ${exis_dir_path_s} )
# if( ${check_exis_path} STREQUAL ${absolutePath} )
# set( load_project_path FALSE ) # 是否存在
# break()
# endif()
# endforeach()

# if( ${load_project_path} ) # # 校验可以加载即可
# list( APPEND exis_dir_path_s ${absolutePath} )
# endif()
# endforeach()

# set( ${result_list} ${exis_dir_path_s} PARENT_SCOPE )
# endfunction()

# # # 返回模板根目录
# function( get_temp_file_dir_path result_dir_path )
# get_filename_component( absolutePath "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../temp/" ABSOLUTE ) # 全路径
# set( ${result_dir_path} "${absolutePath}/" PARENT_SCOPE )
# endfunction()

# # # 获取路径的全路径
# function( get_absolute_path result_dir_path in_path )
# get_filename_component( absolutePath "${in_path}" ABSOLUTE ) # 全路径
# set( ${result_dir_path} "${absolutePath}" PARENT_SCOPE )
# endfunction()

# # # 返回路径分隔符
# function( get_cmake_separator result_path_sep )
# get_filename_component( absolutePath "${CMAKE_CURRENT_FUNCTION_LIST_DIR}" ABSOLUTE ) # 全路径
# get_filename_component( absoluteParentPath "${CMAKE_CURRENT_FUNCTION_LIST_DIR}" NAME ) # 父路径
# string( LENGTH ${absoluteParentPath} fileNameLen )
# string( LENGTH ${absolutePath} absoluteFileNameLen )
# math( EXPR beginIndex "${absoluteFileNameLen}-${fileNameLen}" OUTPUT_FORMAT DECIMAL )
# string( SUBSTRING ${absolutePath} 0 ${beginIndex} resultSubString )
# math( EXPR satrtIndex "${beginIndex}-1" OUTPUT_FORMAT DECIMAL )
# string( SUBSTRING ${absolutePath} ${satrtIndex} 1 resultSep )
# set( ${result_path_sep} "${resultSep}" PARENT_SCOPE )
# endfunction()

# # # 切分字符串
# # # result_list 返回切分后的字符串列表
# # # src_str 被切分的源字符串
# # # target_str 被切分的匹配字符串
# function( string_splite result_list src_str target_str )
# set( spliteResult )

# while( true )
# string( FIND ${src_str} ${target_str} resultIndex )

# if( ${resultIndex} EQUAL -1 )
# break()
# endif()

# string( SUBSTRING ${src_str} 0 ${resultIndex} subResult )
# list( APPEND spliteResult ${subResult} )
# math( EXPR resultIndex "${resultIndex}+1" OUTPUT_FORMAT DECIMAL )
# string( SUBSTRING ${src_str} ${resultIndex} -1 subResult )
# set( src_str ${subResult} )
# endwhile()

# set( ${${result_list}} ${spliteResult} PARENT_SCOPE )
# endfunction()

# cmake_minimum_required( VERSION 3.19 )

# # ## 配置指定目标的 soil2
# function( set_target_link_glm_lib target_obj )
# target_include_directories( ${target_obj} PUBLIC "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../lib/glm-1.0.1-light" )
# endfunction()

# # ## 配置指定目标的 soil2
# function( set_target_link_soil2_lib target_obj )
# target_include_directories( ${target_obj} PUBLIC "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../lib/SOIL2-1.3.0/src/" )
# target_link_libraries( ${target_obj} PUBLIC
# $<$<CONFIG:Release>:"${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../lib/SOIL2-1.3.0//lib/windows/soil2">
# $<$<CONFIG:Debug>:"${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../lib/SOIL2-1.3.0//lib/windows/soil2-debug"> )
# endfunction()

# # ## 配置指定目标的 glew3
# function( set_target_link_glew3_lib target_obj )
# target_link_libraries( ${target_obj} PUBLIC
# "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../lib/glew-2.2.0/lib/Release/x64/glew32.lib"
# "opengl32.lib" )
# target_include_directories( ${target_obj} PUBLIC
# "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../lib/glew-2.2.0/include" )

# if( WIN32 )
# get_target_property( run_path ${target_obj} RUNTIME_OUTPUT_DIRECTORY )
# get_target_property( name ${target_obj} ARCHIVE_OUTPUT_NAME )
# message( "\t\t发现动态库目标路径 : " ${run_path} )
# set( dll_base_name "glew32.dll" )
# set( glew32_dll_file_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../lib/glew-2.2.0/bin/Release/x64/${dll_base_name}" )
# execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${run_path} )
# file( COPY_FILE "${glew32_dll_file_path}" "${run_path}/${dll_base_name}" )
# endif()
# endfunction()

# # ## 配置指定目标的 glfw3
# function( set_target_link_glfw3_lib target_obj )
# target_include_directories( ${target_obj} PUBLIC
# "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../lib/glfw-3.4.bin.WIN64/include" )
# target_link_libraries( ${target_obj} PUBLIC
# "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../lib/glfw-3.4.bin.WIN64/lib-vc2022/glfw3.lib"
# "opengl32.lib" )
# endfunction()

# # ## 配置指定目标的 glut3
# function( set_target_link_freeglut3_lib target_obj )
# set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../lib/freeglut-3.6.0/x64" )

# set( lib_base_name "freeglutd.lib" )
# target_link_libraries( ${target_obj} PUBLIC
# "${root_path}/lib/${lib_base_name}" )

# target_include_directories( ${target_obj} PUBLIC
# "${root_path}/include" )

# if( WIN32 )
# get_target_property( run_path ${target_obj} RUNTIME_OUTPUT_DIRECTORY )
# get_target_property( name ${target_obj} ARCHIVE_OUTPUT_NAME )
# message( "\t\t发现动态库目标路径 : " ${run_path} )
# set( dll_base_name "freeglutd.dll" )
# set( freeglut3_dll_file_path "${root_path}/bin/${dll_base_name}" )
# execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${run_path} )
# file( COPY_FILE "${freeglut3_dll_file_path}" "${run_path}/${dll_base_name}" )
# endif()
# endfunction()

# # ## 配置指定目标的 glad
# function( set_target_link_glad_lib target_obj )
# set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../lib/glad_noes_core" )

# target_sources( ${target_obj} PRIVATE
# "${root_path}/src/glad.c" )
# target_include_directories( ${target_obj} PUBLIC
# "${root_path}/include" )
# endfunction()

# # ## 配置指定目标的 opencv4110
# function( set_target_link_opencv4110_lib target_obj )
# set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../lib/opencv-4.11.0/build" )

# if( NOT OpenCV_FOUND )
# find_package( OpenCV REQUIRED PATHS "${root_path}" REGISTRY_VIEW 64 )
# endif()

# if( OpenCV_FOUND )
# target_link_libraries( ${target_obj} PUBLIC ${OpenCV_LIBS} )
# target_include_directories( ${target_obj} PUBLIC ${OpenCV_INCLUDE_DIRS} )

# get_target_property( run_path ${target_obj} RUNTIME_OUTPUT_DIRECTORY )
# get_target_property( name ${target_obj} ARCHIVE_OUTPUT_NAME )
# message( "\t\t发现动态库目标路径 : " ${run_path} )

# set( root_path "${root_path}/x64/vc16/" )
# set( dll_base_name "opencv_world4110d.dll" )
# set( opencv4110_dll_file_path "${root_path}/bin/${dll_base_name}" )
# execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${run_path} )
# file( COPY_FILE "${opencv4110_dll_file_path}" "${run_path}/${dll_base_name}" )

# set( dll_base_name "opencv_videoio_msmf4110_64d.dll" )
# set( opencv4110_dll_file_path "${root_path}/bin/${dll_base_name}" )
# execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${run_path} )
# file( COPY_FILE "${opencv4110_dll_file_path}" "${run_path}/${dll_base_name}" )

# set( dll_base_name "opencv_videoio_ffmpeg4110_64.dll" )
# set( opencv4110_dll_file_path "${root_path}/bin/${dll_base_name}" )
# execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${run_path} )
# file( COPY_FILE "${opencv4110_dll_file_path}" "${run_path}/${dll_base_name}" )
# endif()
# endfunction()

# # ## 配置指定目标的 用户 tools 库
# function( add_subdirectory_tools_lib )
# set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../userLib/tools" )
# add_subdirectory( ${root_path} )
# endfunction()

# # ## 使用全局的安装文件方式拷贝文件
# # ## @dest_dir_path 目标目录
# # ## @... 多个文件
# function( user_install_copy_file dest_dir_path )
# math( EXPR resultIndex "${ARGC}-1" OUTPUT_FORMAT DECIMAL )

# foreach( item RANGE 1 ${resultIndex} )
# list( GET ARGV ${item} outListIndexValue )
# install( FILES ${outListIndexValue} DESTINATION "${dest_dir_path}/${baseName}" )
# endforeach()
# endfunction()

# function( copy_dir_path_cmake_file_command source_path target_path )
# get_absolute_path( result_abs_path ${source_path} )

# if( EXISTS ${source_path} )
# set( copy_file_target_dir "${Project_Run_Bin_Path}/${PROJECT_NAME}" )
# set( copy_file_src_dir "${result_abs_path}" )
# file( COPY "${result_abs_path}" DESTINATION "${copy_file_target_dir}" )
# message( "执行拷贝任务：${result_abs_path} 拷贝到: ${copy_file_target_dir}" )
# else()
# message( "路径 ${result_abs_path} 不存在，拷贝命令失效" )
# endif()
# endfunction()

# # # 拷贝目录到指定路径
# function( copy_dir_path_cmake_add_custom_command_POST_BUILD_command builder_target copy_dir_target paste_dir_target )
# get_absolute_path( result_abs_path ${source_path} )

# if( EXISTS ${source_path} )
# add_custom_command(
# TARGET ${builder_target} POST_BUILD
# COMMAND ${CMAKE_COMMAND} -E echo "执行拷贝任务：${result_abs_path} 拷贝到: ${paste_dir_target}"
# COMMAND ${CMAKE_COMMAND} -E copy_directory "${result_abs_path}/" "${paste_dir_target}"
# )
# else()
# add_custom_command(
# TARGET ${builder_target} POST_BUILD
# COMMAND ${CMAKE_COMMAND} -E echo "执行拷贝任务：${result_abs_path} 拷贝到: ${paste_dir_target}"
# )
# endif()
# endfunction()

# # # 拷贝目录到指定路径
# function( copy_dir_path_cmake_add_custom_command_PRE_BUILD_command builder_target copy_dir_target paste_dir_target )
# get_absolute_path( result_abs_path ${source_path} )

# if( EXISTS ${source_path} )
# add_custom_command(
# TARGET ${builder_target} PRE_BUILD
# COMMAND ${CMAKE_COMMAND} -E echo "执行拷贝任务：${result_abs_path} 拷贝到: ${paste_dir_target}"
# COMMAND ${CMAKE_COMMAND} -E copy_directory "${result_abs_path}/" "${paste_dir_target}"
# )
# else()
# add_custom_command(
# TARGET ${builder_target} PRE_BUILD
# COMMAND ${CMAKE_COMMAND} -E echo "执行拷贝任务：${result_abs_path} 拷贝到: ${paste_dir_target}"
# )
# endif()
# endfunction()

# # # 拷贝目录到指定路径
# function( copy_dir_path_cmake_add_custom_command_PRE_LINK_command builder_target copy_dir_target paste_dir_target )
# get_absolute_path( result_abs_path ${source_path} )

# if( EXISTS ${source_path} )
# add_custom_command(
# TARGET ${builder_target} PRE_LINK
# COMMAND ${CMAKE_COMMAND} -E echo "执行拷贝任务：${result_abs_path} 拷贝到: ${paste_dir_target}"
# COMMAND ${CMAKE_COMMAND} -E copy_directory "${result_abs_path}/" "${paste_dir_target}"
# )
# else()
# add_custom_command(
# TARGET ${builder_target} PRE_LINK
# COMMAND ${CMAKE_COMMAND} -E echo "执行拷贝任务：${result_abs_path} 拷贝到: ${paste_dir_target}"
# )
# endif()
# endfunction()

# # # 配置模板到指定路径
# function( configure_temp_files trget_name target_path )
# set( rootPath "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../temp/cmake_in" )
# configure_file( "${rootPath}/cmake_to_c_cpp_header_env.h.in" "${target_path}/cmake_to_c_cpp_header_env.h" ) # # 项目信息
# endfunction()
