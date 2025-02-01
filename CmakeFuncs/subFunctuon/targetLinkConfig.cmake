cmake_minimum_required( VERSION 3.19 )

# ## 配置指定目标的 soil2
function( set_target_link_glm_lib target_obj )
    target_include_directories( ${target_obj} PUBLIC "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../lib/glm-1.0.1-light" )
endfunction()

# ## 配置指定目标的 soil2
function( set_target_link_soil2_lib target_obj )
    target_include_directories( ${target_obj} PUBLIC "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../lib/SOIL2-1.3.0/src/" )
    target_link_libraries( ${target_obj} PUBLIC
        $<$<CONFIG:Release>:"${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../lib/SOIL2-1.3.0//lib/windows/soil2">
        $<$<CONFIG:Debug>:"${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../lib/SOIL2-1.3.0//lib/windows/soil2-debug"> )
endfunction()

# ## 配置指定目标的 glew3
function( set_target_link_glew3_lib target_obj )
    target_link_libraries( ${target_obj} PUBLIC
        "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../lib/glew-2.2.0/lib/Release/x64/glew32.lib"
        "opengl32.lib" )
    target_include_directories( ${target_obj} PUBLIC
        "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../lib/glew-2.2.0/include" )

    if( WIN32 )
        get_target_property( run_path ${target_obj} RUNTIME_OUTPUT_DIRECTORY )
        get_target_property( name ${target_obj} ARCHIVE_OUTPUT_NAME )
        message( "\t\t发现动态库目标路径 : " ${run_path} )
        set( dll_base_name "glew32.dll" )
        set( glew32_dll_file_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../lib/glew-2.2.0/bin/Release/x64/${dll_base_name}" )
        execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${run_path} )
        file( COPY_FILE "${glew32_dll_file_path}" "${run_path}/${dll_base_name}" )
    endif()
endfunction()

# ## 配置指定目标的 glfw3
function( set_target_link_glfw3_lib target_obj )
    target_include_directories( ${target_obj} PUBLIC
        "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../lib/glfw-3.4.bin.WIN64/include" )
    target_link_libraries( ${target_obj} PUBLIC
        "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../lib/glfw-3.4.bin.WIN64/lib-vc2022/glfw3.lib"
        "opengl32.lib" )
endfunction()

# ## 配置指定目标的 glut3
function( set_target_link_freeglut3_lib target_obj )
    set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../lib/freeglut-3.6.0/x64" )

    set( lib_base_name "freeglutd.lib" )
    target_link_libraries( ${target_obj} PUBLIC
            "${root_path}/lib/${lib_base_name}" )

    target_include_directories( ${target_obj} PUBLIC
        "${root_path}/include" )

    if( WIN32 )
        get_target_property( run_path ${target_obj} RUNTIME_OUTPUT_DIRECTORY )
        get_target_property( name ${target_obj} ARCHIVE_OUTPUT_NAME )
        message( "\t\t发现动态库目标路径 : " ${run_path} )
        set( dll_base_name "freeglutd.dll" )
        set( freeglut3_dll_file_path "${root_path}/bin/${dll_base_name}" )
        execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${run_path} )
        file( COPY_FILE "${freeglut3_dll_file_path}" "${run_path}/${dll_base_name}" )
    endif()
endfunction()

# ## 配置指定目标的 glad
function( set_target_link_glad_lib target_obj )
    set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../lib/glad_noes_core" )

    target_sources( ${target_obj} PRIVATE
            "${root_path}/src/glad.c" )
    target_include_directories( ${target_obj} PUBLIC
        "${root_path}/include" )
endfunction()

# ## 配置指定目标的 opencv4110
function( set_target_link_opencv4110_lib target_obj )
    set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../lib/opencv-4.11.0/build" )

    if( NOT OpenCV_FOUND )
        find_package( OpenCV REQUIRED PATHS "${root_path}" REGISTRY_VIEW 64 )
    endif()

    if( OpenCV_FOUND )
        target_link_libraries( ${target_obj} PUBLIC ${OpenCV_LIBS} )
        target_include_directories( ${target_obj} PUBLIC ${OpenCV_INCLUDE_DIRS} )

        get_target_property( run_path ${target_obj} RUNTIME_OUTPUT_DIRECTORY )
        get_target_property( name ${target_obj} ARCHIVE_OUTPUT_NAME )
        message( "\t\t发现动态库目标路径 : " ${run_path} )

        set( root_path "${root_path}/x64/vc16/" )
        set( dll_base_name "opencv_world4110d.dll" )
        set( opencv4110_dll_file_path "${root_path}/bin/${dll_base_name}" )
        execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${run_path} )
        file( COPY_FILE "${opencv4110_dll_file_path}" "${run_path}/${dll_base_name}" )

        set( dll_base_name "opencv_videoio_msmf4110_64d.dll" )
        set( opencv4110_dll_file_path "${root_path}/bin/${dll_base_name}" )
        execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${run_path} )
        file( COPY_FILE "${opencv4110_dll_file_path}" "${run_path}/${dll_base_name}" )

        set( dll_base_name "opencv_videoio_ffmpeg4110_64.dll" )
        set( opencv4110_dll_file_path "${root_path}/bin/${dll_base_name}" )
        execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${run_path} )
        file( COPY_FILE "${opencv4110_dll_file_path}" "${run_path}/${dll_base_name}" )
    endif()
endfunction()

# ## 配置指定目标的 glad
function( set_target_link_user_tools_lib target_obj )
    set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../userLib/tools" )
    get_absolute_path( absFilePath ${root_path} )
    string_splite( result_list ${absFilePath} ${cmake_sep_char} )
    list( GET result_list -3 -2 -1 resultList )
    string( JOIN " " jionResult ${resultList} )
    normal_project_name( result_name "${jionResult}" )
    target_link_libraries( ${target_obj} PUBLIC ${result_name} )
endfunction()
