cmake_minimum_required( VERSION 3.19 )


include( CMakeParseArguments )

find_package( addSubdirectory REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
find_package( path REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
find_package( setTargetProperty REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
find_package( string REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
find_package( targetLink REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )
find_package( userQt REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/subFunctuon" GLOBAL )

get_filename_component( abs "${CMAKE_CURRENT_LIST_FILE}" ABSOLUTE )
string( FIND "${abs}" "${CMAKE_HOME_DIRECTORY}" index )

if( NOT ${index} EQUAL -1 )
	string( LENGTH "${abs}" _orgStrLen )
	string( LENGTH "${CMAKE_HOME_DIRECTORY}" _findStrLen )
	math( EXPR _subLen "${_orgStrLen} - ${_findStrLen}" )
	string( SUBSTRING "${abs}" ${_findStrLen} ${_subLen} abs )
	set( abs ".${abs}" )
endif( )

function( init_cmake_func )
	set( CMAKE_C_STANDARD 17 PARENT_SCOPE )
	set( CMAKE_C_STANDARD_REQUIRED ON PARENT_SCOPE )
	set( CMAKE_C_VISIBILITY_PRESET hidden PARENT_SCOPE )
	set( CMAKE_C_EXTENSIONS ON PARENT_SCOPE )
	set( CMAKE_CXX_STANDARD 23 PARENT_SCOPE )
	set( CMAKE_CXX_STANDARD_REQUIRED ON PARENT_SCOPE )
	set( CMAKE_CXX_VISIBILITY_PRESET hidden PARENT_SCOPE )
	set( CMAKE_CXX_EXTENSIONS ON PARENT_SCOPE )
	
	# qt 资源自动编译
	set( CMAKE_AUTOMOC ON PARENT_SCOPE )
	set( CMAKE_AUTOUIC ON PARENT_SCOPE )
	set( CMAKE_AUTORCC ON PARENT_SCOPE )
	
	set( CMAKE_SUPPRESS_REGENERATION ON PARENT_SCOPE )
	## 对于一些特殊环境，应当除去增量编译，否则会导致生成的 .pdb 过大而无法编译。
	## 其次，对于 qt 来说，会导致调用 main 等主函数后，调试器会尝试发出异常中断—增量编译导致的符号导向异常或释放异常。
	close_global_compile_batching( )
endfunction( )

message( "----\n\t\t调用:(${abs}[${CMAKE_CURRENT_FUNCTION}]:${CMAKE_CURRENT_LIST_LINE})行 ->\n\t\t\t消息:列表加载完毕" )
