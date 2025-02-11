cmake_minimum_required( VERSION 3.16 )
get_current_path_name_to_project_name( result_name -4 -3 -2 -1)

set( prject_name ${result_name} )
message( "============ ${prject_name}" )
message( "name = " "${prject_name}" )
project( "${prject_name}" VERSION 0.1 )
message( "============ ${CURRENT_FOLDER}" )

set( CMAKE_CXX_STANDARD 23 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )

get_path_sources( project_src_file PATHS "${CMAKE_CURRENT_LIST_DIR}/srcs" LANGUAGES CXX C )

if( ${QT_VERSION_MAJOR} GREATER_EQUAL 6 )
    qt_add_executable( ${prject_name}
        MANUAL_FINALIZATION
        ${project_src_file}
    )

    set_target_bin_out_path_property( "${prject_name}" "${Project_Run_Bin_Path}/${prject_name}" )
    set_target_static_lib_out_path_property( "${prject_name}" "${Project_Run_Static_Lib_Path}/${prject_name}" )
    set_target_pdb_out_path_property( "${prject_name}" "${Project_Run_Pbd_Path}/${prject_name}" )

else()
    if( ANDROID )
        add_library( ${prject_name} SHARED
            ${project_src_file}
        )
    else()
        add_executable( ${prject_name}
            ${project_src_file}
        )
    endif()
endif()

target_link_libraries( ${prject_name} PRIVATE Qt6::Widgets )

if( ${QT_VERSION} VERSION_LESS 6.1.0 )
    set( BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.${prject_name} )
endif()

set_target_properties( "${prject_name}" PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

if( QT_VERSION_MAJOR EQUAL 6 )
    qt_finalize_executable( ${prject_name} )
endif()

# 加入头文件搜索路径
target_include_directories( "${prject_name}" PUBLIC "${CMAKE_CURRENT_LIST_DIR}/srcs" )

qt_generate_deploy_cmake_script_inatll_job( scrpt_path_ "${prject_name}" )

# # 生成文件
set( cmake_definitions_env_out "${CMAKE_CURRENT_LIST_DIR}/auto_generate_files/macro/" )
configure_temp_files( ${cmake_definitions_env_out} "${prject_name}" )

if( WIN32 )
    target_compile_options( "${prject_name}" PRIVATE "/utf-8" )
endif()

printf_qt_cmake_out()

# # 需要生成的 *.ts 文件保存到 translation_file_list 变量当中
SET( translation_file_list
	# # 美语
	"${PROJECT_SOURCE_DIR}/cmake_generate/translations/${prject_name}_en.ts"
	# # 汉语
	"${PROJECT_SOURCE_DIR}/cmake_generate/translations/${prject_name}_zh_CN.ts"
)

# # 设置 *.pm 的输出位置
set_source_files_properties( ${translation_file_list} PROPERTIES OUTPUT_LOCATION "${Project_Run_Bin_Path}/${prject_name}/progress/translations" )

# # 生成 *.ts 和 *.pm 的脚本任务
qt_add_translations(
    "${prject_name}"
    TS_FILES ${translation_file_list}
    SOURCES ${project_src_file}
    LUPDATE_OPTIONS -no-obsolete
)

# # qt_add_translations([target]
# #     [TARGETS target1 [target2...]]
# #     [SOURCE_TARGETS target1 [target2...]]
# #     [TS_FILE_BASE name]
# #     [TS_FILE_DIR directory]
# #     [TS_FILES file1.ts [file2.ts ...]]
# #     [PLURALS_TS_FILE file.ts]
# #     [NO_GENERATE_PLURALS_TS_FILE]
# #     [RESOURCE_PREFIX prefix]
# #     [OUTPUT_TARGETS variable-name]
# #     [TS_FILES_OUTPUT_VARIABLE variable-name]    # since 6.8
# #     [QM_FILES_OUTPUT_VARIABLE variable-name]
# #     [SOURCES source1.cpp [sources2.cpp ...]]
# #     [INCLUDE_DIRECTORIES directory1 [directory2 ...]]
# #     [LUPDATE_TARGET target-name]
# #     [LUPDATE_OPTIONS ...]
# #     [LRELEASE_TARGET target-name]
# #     [LRELEASE_OPTIONS ...]
# #     [IMMEDIATE_CALL])
