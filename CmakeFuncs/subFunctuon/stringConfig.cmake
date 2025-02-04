cmake_minimum_required( VERSION 3.19 )

# ## 标准化项目名称
function( normal_project_name noormal_name org_name )
    string( REPLACE " " "_" var_replace ${org_name} )
    string( REPLACE "/" "_" var_replace ${var_replace} )
    set( ${noormal_name} ${var_replace} PARENT_SCOPE )
endfunction()

# # 切分字符串
# # result_list 返回切分后的字符串列表
# # src_str 被切分的源字符串
# # target_str 被切分的匹配字符串
function( string_splite result_list src_str target_str )
    set( spliteResult )

    while( true )
        string( FIND ${src_str} ${target_str} resultIndex )

        if( ${resultIndex} EQUAL -1 )
            break()
        endif()

        string( SUBSTRING ${src_str} 0 ${resultIndex} subResult )
        list( APPEND spliteResult ${subResult} )
        math( EXPR resultIndex "${resultIndex}+1" OUTPUT_FORMAT DECIMAL )
        string( SUBSTRING ${src_str} ${resultIndex} -1 subResult )
        set( src_str ${subResult} )
    endwhile()

    list( APPEND spliteResult ${src_str} )
    set( ${${result_list}} ${spliteResult} PARENT_SCOPE )
endfunction()

message( "----\n\t\t调用:(${CMAKE_CURRENT_LIST_FILE}[${CMAKE_CURRENT_FUNCTION}]:${CMAKE_CURRENT_FUNCTION_LIST_LINE})行 ->\n\t\t\t消息:列表加载完毕" )
