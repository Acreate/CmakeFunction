cmake_minimum_required( VERSION 3.19 )

set( CMAKE_C_STANDARD 99 )
set( CMAKE_C_STANDARD_REQUIRED ON )
set( CMAKE_C_VISIBILITY_PRESET hidden )

set( CMAKE_CXX_STANDARD 23 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )
set( CMAKE_CXX_VISIBILITY_PRESET hidden )

get_absolute_path( absFilePath ${CMAKE_CURRENT_LIST_FILE} )
string_splite( result_list ${absFilePath} ${cmake_sep_char} )
list( GET result_list -4 -3 -2  resultList )
string( JOIN " " jionResult ${resultList} )
normal_project_name( result_name "${jionResult}" )
set( prject_name ${result_name} )
message( "============ ${prject_name}" )
message( "name =" ${prject_name} )
project( ${prject_name}
        VERSION 0.1
        LANGUAGES CXX )
message( "============ ${CURRENT_FOLDER}" )

set( cmake_definitions_env_out "${CMAKE_CURRENT_LIST_DIR}/auto_generate_files/macro/" )
configure_temp_files( ${prject_name} ${cmake_definitions_env_out} )

add_library( ${PROJECT_NAME} SHARED )
set( include_path "${CMAKE_CURRENT_LIST_DIR}/srcs" )

string( REPLACE "." "_" project_name_include_dir ${PROJECT_NAME} )
set( ${project_name_include_dir}_include_dir "${include_path}" "${include_path}" PARENT_SCOPE )

set_target_bin_out_path_property( ${PROJECT_NAME} "${Project_Run_Bin_Path}" )
set_target_static_lib_out_path_property( ${PROJECT_NAME} "${Project_Run_Static_Lib_Path}" )
set_target_pdb_out_path_property( ${PROJECT_NAME} "${Project_Run_Pbd_Path}" )

string( SUBSTRING "${PROJECT_NAME}" 0 1 exportFileStartName )
string( SUBSTRING "${PROJECT_NAME}" 1 -1 exportFileName )
string( TOUPPER ${exportFileStartName} exportFileStartName )
set( exportFileName "${CMAKE_CURRENT_SOURCE_DIR}/auto_generate_files/export/${exportFileStartName}${exportFileName}_export.h" )
generate_export_header( ${PROJECT_NAME} EXPORT_FILE_NAME ${exportFileName} )

set_target_link_glew3_lib( ${PROJECT_NAME} )
set_target_link_glfw3_lib( ${PROJECT_NAME} )
set_target_link_glm_lib( ${PROJECT_NAME} )

file( GLOB_RECURSE project_src_file "srcs/*.cpp" "srcs/*.c" "srcs/*.h" )

# 添加源文件
target_sources( ${PROJECT_NAME} PRIVATE ${project_src_file} ${cmake_definitions_env_out} ${exportFileName} ) # 添加源文件

target_include_directories( ${PROJECT_NAME} PUBLIC ${include_path} )
