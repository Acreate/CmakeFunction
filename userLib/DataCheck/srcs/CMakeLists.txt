get_current_dir_name( prject_name ${CMAKE_CURRENT_SOURCE_DIR} )
message( "============ ${prject_name}" )
message( "name =" ${prject_name} )
project( ${prject_name} VERSION 0.1 LANGUAGES CXX )
message( "============ ${CURRENT_FOLDER}" )

m_set_env( "${Project_Run_bin}" "${Project_Install_bin}" )

file( GLOB_RECURSE SRC_LIST
	"*.h"
	"*.c"
	"*.cpp"
	"*.cxx"
	"*.hpp"
)

string( REPLACE "." "_" project_name_include_dir ${PROJECT_NAME} )

set( ${project_name_include_dir}_include_dir ${CMAKE_CURRENT_LIST_DIR} PARENT_SCOPE )

string( REPLACE "." "_" project_name_include_dir ${PROJECT_NAME} )
set( ${project_name_include_dir}_include_dir ${CMAKE_CURRENT_LIST_DIR} ${CMAKE_CURRENT_LIST_DIR}/ PARENT_SCOPE )

STRING( SUBSTRING "${PROJECT_NAME}" 0 1 exportFileStartName )
STRING( SUBSTRING "${PROJECT_NAME}" 1 -1 exportFileName )
STRING( TOUPPER ${exportFileStartName} exportFileStartName )
SET( exportFileName ${CMAKE_CURRENT_SOURCE_DIR}/${cmake_auto_sub_dir_name}/export/${exportFileStartName}${exportFileName}_export.h )

# # 合并源码
list( APPEND ${SRC_LIST} ${SRC_UI} ${QM_FILES} ${SRC_DATA} ${cmake_definitions_out} ${exportFileName} )
add_library( ${PROJECT_NAME} SHARED
	${SRC_LIST}
)

get_target_property( project_type_property ${PROJECT_NAME} TYPE )

GENERATE_EXPORT_HEADER( ${PROJECT_NAME}
	EXPORT_FILE_NAME ${exportFileName}
)
TARGET_INCLUDE_DIRECTORIES( ${PROJECT_NAME} SYSTEM INTERFACE ${CMAKE_CURRENT_SOURCE_DIR} )
