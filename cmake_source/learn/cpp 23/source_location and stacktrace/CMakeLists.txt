﻿cmake_minimum_required( VERSION 3.19 )

get_absolute_path( absFilePath ${CMAKE_CURRENT_LIST_FILE} )
string_splite( result_list ${absFilePath} ${cmake_sep_char} )
list( GET result_list -4 -3 -2 resultList )
string( JOIN " " jionResult ${resultList} )
normal_project_name( result_name "${jionResult}" )
set( prject_name ${result_name} )
message( "============ ${prject_name}" )
message( "name = " "${prject_name}" )
project( "${prject_name}" )
message( "============ ${prject_name}" )

add_executable( "${prject_name}" )

set_target_win32_cmd_windows( "${prject_name}" )
set_target_bin_out_path_property( "${prject_name}" "${Project_Run_Bin_Path}/${prject_name}" )
set_target_static_lib_out_path_property( "${prject_name}" "${Project_Run_Static_Lib_Path}/${prject_name}" )
set_target_pdb_out_path_property( "${prject_name}" "${Project_Run_Pbd_Path}/${prject_name}" )

set_target_link_user_tools_lib( "${prject_name}" )

# 加入头文件搜索路径
target_include_directories( "${prject_name}" SYSTEM PUBLIC "${CMAKE_CURRENT_LIST_DIR}/srcs" )
get_path_files( project_src_file "${CMAKE_CURRENT_LIST_DIR}/srcs" )
target_sources( "${prject_name}" PRIVATE ${project_src_file} )

# # 生成文件
set( cmake_definitions_env_out "${CMAKE_CURRENT_LIST_DIR}/auto_generate_files/macro/" )
configure_temp_files( ${cmake_definitions_env_out} "${prject_name}" )
