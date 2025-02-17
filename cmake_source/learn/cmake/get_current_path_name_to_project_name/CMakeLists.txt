cmake_minimum_required( VERSION 3.19 )

get_current_path_name_to_project_name( result_name -4 -3 -2 )

set( prject_name ${result_name} )
message( "============ ${prject_name}" )
message( "name = " "${prject_name}" )
project( "${prject_name}" )
message( "============ ${CURRENT_FOLDER}" )

add_executable( ${PROJECT_NAME} )

# 加入头文件搜索路径
target_include_directories( "${prject_name}" SYSTEM PUBLIC "${CMAKE_CURRENT_LIST_DIR}/srcs" )
get_path_files( project_src_file "${CMAKE_CURRENT_LIST_DIR}/srcs" )
target_sources( "${prject_name}" PRIVATE ${project_src_file} )

# # 生成文件
set( cmake_definitions_env_out "${CMAKE_CURRENT_LIST_DIR}/auto_generate_files/macro/" )
configure_temp_files( ${cmake_definitions_env_out} "${prject_name}" )
