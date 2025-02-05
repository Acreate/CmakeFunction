cmake_minimum_required( VERSION 3.19 )

# # 添加支持语言
function( supper_cmake_builder_language result_language_list_ )
    include( CheckLanguage ) # # 加载 check_language 函数
    
    check_language( Fortran )
    set( supper_language_list )

    if( CMAKE_Fortran_COMPILER )
        enable_language( Fortran )
        list( APPEND supper_language_list "Fortran" )
    endif()

    check_language( CXX )

    if( CMAKE_CXX_COMPILER )
        enable_language( CXX )
        list( APPEND supper_language_list "CXX" )
    endif()

    check_language( C )

    if( CMAKE_C_COMPILER )
        enable_language( C )
        list( APPEND supper_language_list "C" )
    endif()

    check_language( ASM )

    if( CMAKE_ASM_COMPILER )
        enable_language( ASM )
        list( APPEND supper_language_list "ASM" )
    endif()

    check_language( ASM_NASM )

    if( CMAKE_ASM_NASM_COMPILER )
        enable_language( ASM_NASM )
        list( APPEND supper_language_list "ASM_NASM" )
    endif()

    check_language( ASM_MARMASM )

    if( CMAKE_ASM_MARMASM_COMPILER )
        enable_language( ASM_MARMASM )
        list( APPEND supper_language_list "ASM_MARMASM" )
    endif()

    check_language( ASM_MASM )

    if( CMAKE_ASM_MASM_COMPILER )
        enable_language( ASM_MASM )
        list( APPEND supper_language_list "ASM_MASM" )
    endif()

    check_language( ASM-ATT )

    if( CMAKE_ASM-ATT_COMPILER )
        enable_language( ASM-ATT )
        list( APPEND supper_language_list "ASM-ATT" )
    endif()

    check_language( Swift )

    if( CMAKE_Swift_COMPILER )
        enable_language( Swift )
        list( APPEND supper_language_list "Swift" )
    endif()

    check_language( CSharp )

    if( CMAKE_CSharp_COMPILER )
        enable_language( CSharp )
        list( APPEND supper_language_list "CSharp" )
    endif()

    check_language( CUDA )

    if( CMAKE_CUDA_COMPILER )
        enable_language( CUDA )
        list( APPEND supper_language_list "CUDA" )
    endif()

    check_language( HIP )

    if( CMAKE_HIP_COMPILER )
        enable_language( HIP )
        list( APPEND supper_language_list "HIP" )
    endif()

    check_language( ISPC )

    if( CMAKE_ISPC_COMPILER )
        enable_language( ISPC )
        list( APPEND supper_language_list "ISPC" )
    endif()

    message( "================== 支持语言\n\t\t ${supper_language_list}\n==================" )
    set( ${result_language_list_} ${supper_language_list} PARENT_SCOPE )
endfunction()

# # 添加 C CPP 后缀
macro( append_CXX_C_source_file_extensions extension_list )
    if( NOT PROJECT_NAME )
        message( FATAL_ERROR "需要先配置项目，否则该能容无法使用" )
        return()
    endif()

    foreach( extension ${ARGV} )
        list( APPEND CMAKE_CXX_SOURCE_FILE_EXTENSIONS "${extension}" )
        list( APPEND CMAKE_C_SOURCE_FILE_EXTENSIONS "${extension}" )
    endforeach()

    message( "================== 当前后缀" )
    message( "\t\tCMAKE_CXX_SOURCE_FILE_EXTENSIONS=${CMAKE_CXX_SOURCE_FILE_EXTENSIONS}" )
    message( "\t\tCMAKE_C_SOURCE_FILE_EXTENSIONS=${CMAKE_C_SOURCE_FILE_EXTENSIONS}" )
    message( "==================" )
endmacro()

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
