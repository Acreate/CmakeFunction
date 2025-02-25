cmake_minimum_required( VERSION 3.19 )

set( CMAKE_C_STANDARD 17 )
set( CMAKE_C_STANDARD_REQUIRED ON )
set( CMAKE_C_VISIBILITY_PRESET hidden )
set( CMAKE_C_EXTENSIONS ON )

set( CMAKE_CXX_STANDARD 23 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )
set( CMAKE_CXX_VISIBILITY_PRESET hidden )
set( CMAKE_CXX_EXTENSIONS ON )

include( GenerateExportHeader )
include( GNUInstallDirs )

append_CXX_C_source_file_extensions( h hpp hc H HPP HC ) # # 追加后缀名

get_cmake_separator( cmake_sep_char )

get_absolute_path( absFilePath ${CMAKE_CURRENT_LIST_FILE} )
string_splite( result_list ${absFilePath} ${cmake_sep_char} )
list( GET result_list -4 -3 -2 resultList )
string( JOIN " " jionResult ${resultList} )
normal_project_name( result_name "${jionResult}" )
set( prject_name ${result_name} )
message( "============ ${prject_name}" )
message( "name = " "${prject_name}" )
project( "${prject_name}" )
message( "============ ${CURRENT_FOLDER}" )

add_library( ${PROJECT_NAME} SHARED )

set( include_path "${CMAKE_CURRENT_LIST_DIR}/srcs" )

string( REPLACE "." "_" project_name_include_dir "${prject_name}" )
set( ${project_name_include_dir}_include_dir "${include_path}" "${include_path}" PARENT_SCOPE )

set_target_bin_out_path_property( "${prject_name}" "${Project_Run_Bin_Path}/${prject_name}" )
set_target_static_lib_out_path_property( "${prject_name}" "${Project_Run_Static_Lib_Path}/${prject_name}" )
set_target_pdb_out_path_property( "${prject_name}" "${Project_Run_Pbd_Path}/${prject_name}" )

string( SUBSTRING "${PROJECT_NAME}" 0 1 exportFileStartName )
string( SUBSTRING "${PROJECT_NAME}" 1 -1 exportFileName )
string( TOUPPER ${exportFileStartName} exportFileStartName )
set( exportFileName "${CMAKE_CURRENT_SOURCE_DIR}/auto_generate_files/export/${exportFileStartName}${exportFileName}_export.h" )
generate_export_header( "${prject_name}" EXPORT_FILE_NAME ${exportFileName} )

# 添加源文件
target_include_directories( ${PROJECT_NAME} SYSTEM PUBLIC "${include_path}/srcs" ) # 加入头文件搜索路径
get_path_files( project_src_file "srcs" )
target_sources( ${PROJECT_NAME} PRIVATE ${project_src_file} )

target_include_directories( ${PROJECT_NAME} SYSTEM PUBLIC ${include_path} )
set( cmake_definitions_env_out "${CMAKE_CURRENT_LIST_DIR}/auto_generate_files/macro/" )
configure_temp_files( ${cmake_definitions_env_out} "${prject_name}" )
