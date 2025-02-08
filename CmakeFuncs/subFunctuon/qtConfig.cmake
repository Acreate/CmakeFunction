cmake_minimum_required( VERSION 3.19 )

function( printf_cmake_out )
    message( "QT_VERSION = ${QT_VERSION}" )
    message( "QT_VERSION_MAJOR = ${QT_VERSION_MAJOR}" )
    message( "DEPLOY_QT_HOME = ${DEPLOY_QT_HOME}" )
    message( "CMAKE_PREFIX_PATH = ${CMAKE_PREFIX_PATH}" )
    message( "Qt6_DIR = ${Qt6_DIR}" )
    message( "Qt${QT_VERSION_MAJOR}CoreTools_DIR = ${Qt${QT_VERSION_MAJOR}CoreTools_DIR}" )
    message( "Qt${QT_VERSION_MAJOR}GuiTools_DIR = ${Qt${QT_VERSION_MAJOR}GuiTools_DIR}" )
    message( "Qt${QT_VERSION_MAJOR}WidgetsTools_DIR = ${Qt${QT_VERSION_MAJOR}WidgetsTools_DIR}" )
    message( "Qt${QT_VERSION_MAJOR}Widgets_DIR = ${Qt${QT_VERSION_MAJOR}Widgets_DIR}" )
    message( "Qt${QT_VERSION_MAJOR}ZlibPrivate_DIR = ${Qt${QT_VERSION_MAJOR}ZlibPrivate_DIR}" )
    message( "Qt${QT_VERSION_MAJOR}Core_DIR = ${Qt${QT_VERSION_MAJOR}Core_DIR}" )
    message( "WINDEPLOYQT_EXECUTABLE = ${WINDEPLOYQT_EXECUTABLE}" )
    message( "QT_QMAKE_EXECUTABLE = ${QT_QMAKE_EXECUTABLE}" )
endfunction()

function( qt_generate_deploy_cmake_script_inatll_job _out_deploy_script_job_path target_obj )
    if( qt_FOUND EQUAL 0 )
        message( "未成功初始化该模块，请定义 Qt6_DIR 后在初始化模块" )
        return()
    endif()

    get_target_property( projectType "${target_obj}" TYPE )

    if( "${projectType}" STREQUAL "EXECUTABLE" )
        get_target_property( Project_Run_Bin_Path "${target_obj}" RUNTIME_OUTPUT_DIRECTORY )
        message( "生成 [可自行文件] 路径 = ${Project_Run_Bin_Path}" )
    else()
        get_target_property( Project_Run_Bin_Path "${target_obj}" LIBRARY_OUTPUT_DIRECTORY )
        message( "生成 [动态库] 路径 = ${Project_Run_Bin_Path}" )
    endif()

    # App bundles on macOS have an .app suffix
    if( APPLE )
        set( executable_path "$<TARGET_FILE_NAME:${target_obj}>.app" )
    else()
        set( executable_path "${Project_Run_Bin_Path}/$<TARGET_FILE_NAME:${target_obj}>" )
    endif()

    qt_generate_deploy_script(
        TARGET ${target_obj}
        OUTPUT_SCRIPT deploy_script
        CONTENT "
qt_deploy_runtime_dependencies(
    EXECUTABLE \"${executable_path}\"
	PLUGINS_DIR \"${Project_Run_Bin_Path}\"
	LIB_DIR \"${Project_Run_Bin_Path}\"
	BIN_DIR \"${Project_Run_Bin_Path}\"
)
message( \"打包程序 : ${executable_path}\" )
" )

    install( SCRIPT ${deploy_script} )
    set( ${_out_deploy_script_job_path} ${deploy_script} PARENT_SCOPE )
endfunction()

if( NOT Qt6_DIR )
    message( "未定义 Qt6_DIR 退出检测" )
    return()
endif()

get_filename_component( _absParamFilePath "${Qt6_DIR}" ABSOLUTE )

get_cmake_separator( _sep )
string_splite( _splite_dir_name "${_absParamFilePath}" "${_sep}" )

list( GET _splite_dir_name -4 _builder_tools )
set( DEPLOY_QT_HOME "${_result}" )

list( GET _splite_dir_name -5 _result ) # # 版本文件夹

string_splite( _versionSplite "${_result}" "." )
list( GET _versionSplite 0 QT_VERSION_MAJOR ) # # 获取主要版本

set( QT_VERSION "${_result}" )
set( DEPLOY_QT_HOME "C:/Qt/${QT_VERSION}/${_builder_tools}/" )
set( CMAKE_PREFIX_PATH "${DEPLOY_QT_HOME}" )
set( Qt6_DIR "${DEPLOY_QT_HOME}/lib/cmake/Qt${QT_VERSION_MAJOR}" )
set( Qt${QT_VERSION_MAJOR}CoreTools_DIR "${DEPLOY_QT_HOME}/lib/cmake/Qt${QT_VERSION_MAJOR}CoreTools" )
set( Qt${QT_VERSION_MAJOR}GuiTools_DIR "${DEPLOY_QT_HOME}/lib/cmake/Qt${QT_VERSION_MAJOR}GuiTools" )
set( Qt${QT_VERSION_MAJOR}WidgetsTools_DIR "${DEPLOY_QT_HOME}/lib/cmake/Qt${QT_VERSION_MAJOR}WidgetsTools" )
set( Qt${QT_VERSION_MAJOR}Widgets_DIR "${DEPLOY_QT_HOME}/lib/cmake/Qt${QT_VERSION_MAJOR}Widgets" )
set( Qt${QT_VERSION_MAJOR}ZlibPrivate_DIR "${DEPLOY_QT_HOME}/lib/cmake/Qt${QT_VERSION_MAJOR}ZlibPrivate" )
set( Qt${QT_VERSION_MAJOR}Core_DIR "${DEPLOY_QT_HOME}/lib/cmake/Qt${QT_VERSION_MAJOR}Core" )
set( WINDEPLOYQT_EXECUTABLE "${DEPLOY_QT_HOME}/bin/windeployqt.exe" )
set( QT_QMAKE_EXECUTABLE "${DEPLOY_QT_HOME}/bin/qmake.exe" )

set( CMAKE_AUTOUIC ON )
set( CMAKE_AUTOMOC ON )
set( CMAKE_AUTORCC ON )

get_filename_component( abs "${CMAKE_CURRENT_LIST_FILE}" ABSOLUTE )
string( FIND "${abs}" "${CMAKE_HOME_DIRECTORY}" index )

if( NOT ${index} EQUAL -1 )
    string( LENGTH "${abs}" _orgStrLen )
    string( LENGTH "${CMAKE_HOME_DIRECTORY}" _findStrLen )
    math( EXPR _subLen "${_orgStrLen} - ${_findStrLen}" )
    string( SUBSTRING "${abs}" ${_findStrLen} ${_subLen} abs )
    set( abs ".${abs}" )
endif()

message( "----\n\t\t调用:(${abs}[${CMAKE_CURRENT_FUNCTION}]:${CMAKE_CURRENT_LIST_LINE})行 ->\n\t\t\t消息:列表加载完毕" )
