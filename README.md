# cmakeFuncsopengl_demo

## 介绍

cmake 功能合集

## cmake 模块函数

### CmakeFuncsConfig.cmake

使用 find_package 功能导入。它自动导入子功能项

```
    1. addSubdirectoryConfig.cmake
    2. pathConfig.cmake
    3. setTargetPropertyConfig.cmake
    4. stringConfig.cmake
    5. targetLinkConfig.cmake
```

```
案例:
	find_package( CmakeFuncs REQUIRED PATHS "${CMAKE_CURRENT_SOURCE_DIR}/srcs/cmakeFuncs/CmakeFuncs" )
```

#### include_path_package()

加载 pathConfig.cmake

#### include_setTargetProperty_package()

加载 setTargetPropertyConfig.cmake

#### include_string_package()

加载 stringConfig.cmake

#### include_targetLink_package()

加载 targetLinkConfig.cmake

#### include_addSubdirectory_package()

加载 addSubdirectoryConfig.cmake

#### include_everything_package( package_name package_path )

在路径 package_path 下加载 ${package_name}.cmake

### addSubdirectoryConfig.cmake

#### supper_cmake_builder_language( result_language_list_ )

激活并且返回当前环境支持编译环境

```cmake
cmake_minimum_required( VERSION 3.19 )

# # 加载模块
find_package( CmakeFuncs REQUIRED PATHS "${CMAKE_CURRENT_SOURCE_DIR}/srcs/cmakeFuncs/CmakeFuncs" )

# # 获取当前文件夹名称
get_current_dir_name( prject_name ${CMAKE_CURRENT_SOURCE_DIR} )
message( "============ ${prject_name}" )
message( "name = " ${prject_name} ) # # 当前文件名配置为项目名称
project( ${prject_name} )
message( "============ ${CURRENT_FOLDER}" )

set( CMAKE_C_STANDARD 17 )
set( CMAKE_C_STANDARD_REQUIRED ON )
set( CMAKE_C_VISIBILITY_PRESET hidden )

set( CMAKE_CXX_STANDARD 23 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )
set( CMAKE_CXX_VISIBILITY_PRESET hidden )

supper_cmake_builder_language( _cmake_supper_language_list ) # # 语言支持列表
```



#### append_CXX_C_source_file_extensions( extension_list )

添加 c 和 cpp 后缀名称

```cmake
cmake_minimum_required( VERSION 3.19 )

## 加载模块
find_package( CmakeFuncs REQUIRED PATHS "${CMAKE_CURRENT_SOURCE_DIR}/srcs/cmakeFuncs/CmakeFuncs" )

## 获取当前文件夹名称
get_current_dir_name( prject_name ${CMAKE_CURRENT_SOURCE_DIR} )
message( "============ ${prject_name}" )
message( "name = " ${prject_name} ) ## 当前文件名配置为项目名称
project( ${prject_name} )
message( "============ ${CURRENT_FOLDER}" )

set( CMAKE_C_STANDARD 17 )
set( CMAKE_C_STANDARD_REQUIRED ON )
set( CMAKE_C_VISIBILITY_PRESET hidden )

set( CMAKE_CXX_STANDARD 23 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )
set( CMAKE_CXX_VISIBILITY_PRESET hidden )

append_CXX_C_source_file_extensions( h hpp hc H HPP HC ) ## 追加后缀名
```



#### check_value_is_define( result_ [\__CHECK_CMAKE_VALUE\_\_ <value_name>] )

检查变量列表，标注其中未定义的变量

```cmake
## 检查 Qt6_DIR 与 qt_DIR 是否已经被定义，如果其中一个变量未定义，则返回该字面变量
check_value_is_define( _result _CHECK_CMAKE_VALUE_ Qt6_DIR qt_DIR )
## 若 Qt6_DIR 未定义，则 _result 列表理应保存 Qt6_DIR 名称，而不是 ${Qt6_DIR}
```

#### add_subdirectory_tools_lib()

把工具库加入 cmake 项目内

#### add_subdirectory_test_code_project()

把测试库加入 cmake 项目内

#### append_sub_directory_cmake_project_path_list( path_dir_s )

把列表当中的所有项目都加入到 cmake 项目内

必须保证该路径存在可用的 CMakeLists.txt 文件

该功能提供更多的工具帮助

path_dir_s 为列表

```cmake
    set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../userLib/tools" )
    append_sub_directory_cmake_project_path_list( root_path )
```

```cmake
	## 非法操作，请使用 append_sub_directory_cmake_project_path_s( path_dir_s )
	append_sub_directory_cmake_project_path_s( "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../userLib/tools"  )
```



#### append_sub_directory_cmake_project_path_s( path_dir_s )

增加路径列表到项目

path_dir_s 为路径列表，并非数组

```cmake
    set( root_path "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../userLib/tools" )
    append_sub_directory_cmake_project_path_s( ${root_path} )
```

```cmake
    append_sub_directory_cmake_project_path_s( "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../userLib/tools"  )
```



#### get_in_cmakeFunction_call_load_sub_directory_project_list( result_list_ )

返回使用 append_sub_directory_cmake_project_path( path_dir_s ) 函数加载的所有目标

### pathConfig.cmake

#### get_current_dir_name( out_name in_path )

获取当前文件夹名称

#### get_parent_dir_name( out_name in_path )

获取父级文件夹名称

#### get_path_cmake_dir_path( out_list check_path_dir file_name )

获取指定路径下的所有匹配文件名

#### get_path_sources( out_file_list  [PATHS <路径 ...>] [LANGUAGES <语言 ...> ] [SUFFIXS <后缀 ...> ])

out_file_list  返回源码列表

PATHS 指定后续参数列表为路径，允许多个

LANGUAGES 从指定开发语言获取源码后缀，允许多个编程语言，可以使用 supper_cmake_builder_language( result_language_list_ ) 获取支持语言

SUFFIXS 指定后续参数列表为追加后缀，允许多个

```cmake
## 检查 "${CMAKE_CURRENT_LIST_DIR}/srcs" 路径当中所有支持 C/C++ 的源码，并且在这之上增加 .e 后缀检查
get_path_sources( project_src_file PATHS "${CMAKE_CURRENT_LIST_DIR}/srcs" LANGUAGES CXX C SUFFIXS ".e" )
```



#### get_path_cxx_and_c_sources( out_file_list check_path )

获取源码，根据 CMAKE_CXX_SOURCE_FILE_EXTENSIONS 与 CMAKE_C_SOURCE_FILE_EXTENSIONS 获取后缀，返回源码

需要支持 C/C++，使用 check_language( C ) 与 check_language( CXX ) 返回 CMAKE_CXX_COMPILER 与 CMAKE_C_COMPILER 定义判定

​	out_file_list 返回源码

​	check_path 检查路径

#### get_path_sources check_path( find_expansion out_file_list )

获取指定后缀的源码

#### user_install_copy_file( dest_dir_path )

使用安装模式拷贝路径

#### copy_dir_path_cmake_file_command( source_path target_path )

生成 cmake 项目名时候拷贝内容

#### copy_dir_path_cmake_add_custom_command_POST_BUILD_command( builder_target copy_dir_target paste_dir_target )

使用 post build 选项拷贝

#### copy_dir_path_cmake_add_custom_command_PRE_BUILD_command( builder_target copy_dir_target paste_dir_target )

使用 pre build 选项拷贝

#### copy_dir_path_cmake_add_custom_command_PRE_LINK_command( builder_target copy_dir_target paste_dir_target )

使用 pre link 选项拷贝

#### filter_path_repetition( result_list path_dir_s )

过滤重复的路径

#### get_temp_file_dir_path( result_dir_path )

返回模板目录

#### get_absolute_path( result_dir_path in_path )

返回绝对目录

#### get_cmake_separator( result_path_sep )

返回路径分隔符

#### get_path_files( result_file_list get_path )

返回该路径下的所有文件

#### get_path_dirs( result_dir_list get_path )

返回该路径下的所有文件夹

### setTargetPropertyConfig.cmake

#### set_target_BIN_out_path_property( target_obj out_path )

配置目标的可执行文件输出，win当中包含动态库

#### set_target_Static_Lib_out_path_property( target_obj out_path )

配置目标的库输出目标

#### set_target_PDB_out_path_property( target_obj out_path )

配置目标的 pdb 文件输出

#### set_target_WIN32_cmd_windows( target_obj )

配置目标是否使用命令行模式

#### set_target_WIN32_show_windows( target_obj )

配置目标是否使用窗口模式

### stringConfig.cmake

#### normal_project_name( noormal_name org_name )

重新配置名称，并且返回正确名称

#### string_splite( result_list src_str target_str )

切分字符串

### targetLinkConfig.cmake

#### set_target_link_glm_lib( target_obj )

目标链接 glm

#### set_target_link_soil2_lib( target_obj )

目标链接 soil2

#### set_target_link_glew3_lib( target_obj )

目标链接glew3

#### set_target_link_win_opengl3_lib( target_obj )

目标链接 opengl3

#### set_target_link_glfw3_lib( target_obj )

目标链接 glfw3

#### set_target_link_freeglut3_lib( target_obj )

目标链接 freelut3

#### set_target_link_glad46compatibility_lib( target_obj )

目标链接 glad46 compatibility

#### set_target_link_glad46core_lib( target_obj )

目标链接 glad46 core

#### set_target_link_glad33core_lib( target_obj )

目标链接 glad33 core

#### set_target_link_opencv4110_lib( target_obj )

目标链接 opencv4110

#### set_target_link_user_tools_lib( target_obj )

目标链接 tools 工具

#### configure_temp_files( target_path target_obj )

目标配置cmake环境头文件

#### configure_all_target()

目标生成 cmake 头文件。

需要使用 configure_temp_files( target_path target_obj ) 配置路径

并且该项目由 append_sub_directory_cmake_project_path( path_dir_s ) 加载

### qtConfig.cmake

包含 cmake 当中激活qt功能的函数

#### printf_qt_cmake_out()

打印 cmake 当中的 qt 环境变量

#### qt_generate_deploy_cmake_script_inatll_job( _out_deploy_script_job_path target_obj )

激活 qt 安装功能，自动配置 qt 环境所需要的库文件

_out_deploy_script_job_path 返回生成脚本的路径

target_obj 目标名称

```
qt_generate_deploy_cmake_script_inatll_job( scrpt_path_ "${prject_name}" )
```

#### init_qt_dir_event( qt_dir )

激活 qt 环境

该功能优先使用 \${qt_dir} 路径激活 qt 环境，备选使用 \${Qt6_DIR} 

功能只能在未初始化时调用，再次调用，或者 qt 实现 cmake 初始化时成功时，该调用会失败

如果需要重新初始化 qt 的 cmake，可以调用 update_qt_dir_event( qt_dir )

```cmake
init_qt_dir_event( "${Qt6_DIR}" )
```

#### update_qt_dir_event( qt_dir )

更新 qt 的 cmake 环境

与 init_qt_dir_evect( qt_dir ) 不同，该调用会覆盖就配置

该功能优先使用 \${qt_dir} 路径激活 qt 环境，备选使用 \${Qt6_DIR} 

```cmake
update_qt_dir_event( "${Qt6_DIR}" )
```



## tools 库

### cyl::tools::io 

包含输出函数

#### Printer_Normal_Info

在通用输出打印 msg 消息

需要使用 DEF_CURRENT_RELATIVELY_PATH_STATIC_VALUE( FILE  ) 配置文件路径

需要在项目 CMakeLists.txt 文件当中配置

```cmake
set( cmake_definitions_env_out "${CMAKE_CURRENT_LIST_DIR}/auto_generate_files/macro/" )
configure_temp_files( ${cmake_definitions_env_out} "${PROJECT_NAME}" )
```

使用 append_sub_directory_cmake_project_path( path_dir_s ) 加载

```
get_path_cmake_dir_path( bin_list "${CMAKE_CURRENT_SOURCE_DIR}/srcs/" "CMakeLists.txt" ) ## 查找 CMakeLists.txt 文件

filter_path_repetition( list_result out_path_list ) ## 过滤重复路径
append_sub_directory_cmake_project_path( list_result ) ## 加入目标

configure_all_target() ## 配置 cmake 环境头文件
```

代码使用

```c++
#include <tools/io.h> // 包含 Printer_Normal_Info( MSG ) 定义
#include <tools/path.h> // 包含 DEF_CURRENT_RELATIVELY_PATH_STATIC_VALUE( FILE   ) 定义
#include <cmake_include_to_c_cpp_header_env.h>
DEF_CURRENT_RELATIVELY_PATH_STATIC_VALUE( __FILE__ );

int main( int argc, char **argv ) {
	Printer_Normal_Info( "这是一行消息" );
	/* 命令行输出:
文件->( srcs\video sources\QiJinOpengl\demo00test\srcs\main.cpp ), 函数调用->{ main }, 行号-* 7
        信息->这是一行消息
	 */
	exit( EXIT_SUCCESS ); // 安全退出
}
```



#### Printer_Error_Info

在错误输出打印 msg 消息

参考 Printer_Normal_Info( msg )

#### error_print_to_std_errorio

在错误通道打印消息

```c++
/**
* @brief 发出错误信息
* @param error_info 错误信息
* @param error_file 错误文件
* @param error_call_function_name 调用函数名称
* @param file_line 错误行
* @return 格式化完成的异常信息
*/
std::string error_print_to_std_errorio( const std::string &error_info, const std::string &error_file, const std::string &error_call_function_name, const size_t file_line );
```

#### out_print_to_std_outio

在标准通道打印消息

```c++
/**
* @brief 输出一个信息
* @param out_info 信息内容
* @param out_file 信息输出文件
* @param out_call_function_name 调用函数名称
* @param file_line 输出行
* @return 格式化完成的信息
*/
std::string out_print_to_std_outio( const std::string &out_info, const std::string &out_file, const std::string &out_call_function_name, const size_t file_line );
```

### cyl::tools::path

路径类

#### DEF_CURRENT_RELATIVELY_PATH_STATIC_VALUE( FILE   )

定义基于 FILE 实现的 cmake 顶级目录相对路径变量 current_relatively_path

#### DEF_CURRENT_PROJECT_NAME(   )

定义当前项目名称，使用 project_name 即可使用

```c++
/**
 * @brief 定义当前项目名称宏
 * @brief 需要导入 cmake 模板文件
 * @brief
 * @code
 * #include <cmake_include_to_c_cpp_header_env.h>
 * @endcode 
 */
# define DEF_CURRENT_PROJECT_NAME(   ) const static std::string project_name = cmake_property_NAME
```

```c++
#include <tools/io.h>
#include <tools/path.h>
#include <cmake_include_to_c_cpp_header_env.h>
DEF_CURRENT_PROJECT_NAME(  );
DEF_CURRENT_RELATIVELY_PATH_STATIC_VALUE( __FILE__ );

int main( int argc, char **argv ) {
	Printer_Normal_Info( project_name );
	/* 命令行输出:
文件->( srcs\video sources\QiJinOpengl\demo00test\srcs\main.cpp ), 函数调用->{ main }, 行号-* 8
        信息->video_sources_QiJinOpengl_demo005
	 */
	exit( EXIT_SUCCESS ); // 安全退出
}
```

#### 类声明

```c++
class cyl::tools::path {
public:
	/// @brief 根路径
	static const std::filesystem::path root_path;
	/**
	* @brief 获取给予项目根路径的路径
	* @param file_path 绝对路径
	* @return 相对路径
	*/
	static path getCmakeSourceRelativelyPath( const std::string &file_path );

	/// @brief 获取工作路径
	/// @return 当前工作路径
	static cyl::tools::path getWorkPath( );
private:
	/// @brief 对象当前路径
	std::filesystem::path currentPath;
public:
	/// @brief 根据路径创建一个对象
	/// @param current_path 路径
	path( const std::filesystem::path &current_path )
		: currentPath( current_path ) { }
	/// @brief 根据路径创建一个对象
	/// @param current_path 路径
	path( const std::string &current_path )
		: currentPath( current_path ) { }
	/// @brief 创建一个对象，对象为当前工作路径
	path( ) {
	}
public:
	/// @brief 获取路径标准库（std::filesystem::path）对象
	/// @return 标准库对象
	std::filesystem::path getCurrentPath( ) const { return currentPath; }
	/// @brief 重设路径
	/// @param current_path 新路径
	void setCurrentPath( const std::filesystem::path &current_path ) { currentPath = current_path; }
	void setCurrentPath( const std::string &current_path ) { currentPath = current_path; }
	void setCurrentPath( const std::wstring &current_path ) { currentPath = current_path; }
	std::string string( ) const {
		return currentPath.string( );
	}
	operator std::string( ) const {
		return currentPath.string( );
	}
	/// @brief 获取父级目录
	/// @return 父级目录
	path getParent( ) const {

		return currentPath.parent_path( );
	}
	/// @brief 返回根级目录
	/// @return 根级目录
	path getRoot( ) const {
		return currentPath.root_path( );
	}

	/// @brief 从路径当中读取文件内容
	/// @param result 返回内容
	/// @return 文件内容长度，0 表示失败，或者不存在
	size_t readPathFile( std::wstring *result ) const;
	/// @brief 向文件写入内容
	/// @param content 文件内容
	/// @return 写入个数
	size_t writePathFile( const std::wstring &content ) const;
	/// @brief 从路径当中读取文件内容
	/// @param result 返回内容
	/// @return 文件内容长度，0 表示失败，或者不存在
	size_t readPathFile( std::string *result ) const;
	/// @brief 向文件写入内容
	/// @param content 文件内容
	/// @return 写入个数
	size_t writePathFile( const std::string &content ) const;

	/// @brief 从路径当中读取文件内容-二进制实现
	/// @param result 返回内容
	/// @return 文件内容长度，0 表示失败，或者不存在
	size_t readPathFile( std::vector< uint8_t > *result ) const;
	/// @brief 向文件写入内容-二进制实现
	/// @param content 文件内容
	/// @return 写入个数
	size_t writePathFile( const std::vector< uint8_t > &content ) const;
	/// @brief 向文件写入内容-二进制实现
	/// @param content 文件内容
	/// @return 写入个数
	size_t writePathFile( const std::vector< int8_t > &content ) const;
	/// @brief 获取绝对路径
	/// @return 绝对路径
	cyl::tools::path getAbsPath( ) const;

	/// @brief 创建目录
	/// @return 成功返回 true
	bool createPathDir( ) const;
	/// @brief 创建文件
	/// @return 成功返回 true
	bool createPathFile( ) const;
	/// @brief 检查路径是否存在
	/// @return 存在返回 true
	bool isExists( ) const;
	/// @brief 检查路径是否为文件
	/// @return 文件返回 true
	bool isFile( ) const;
	/// @brief 检查路径是否为文件夹
	/// @return 文件夹返回 true
	bool isDir( ) const;
	/// @brief 删除路径下所有的文件/文件夹
	/// @return 删除路径个数
	size_t removeAll( ) const;
	/// @brief 删除路径，只删除该路径单一文件或目录
	/// @return 成功返回 true
	bool removeThisOne( ) const;
	/// @brief 获取当前执行程序文件路径
	/// @return 返回当前执行程序文件路径
	cyl::tools::path getRunFilePath( ) const;
	/// @brief 获取路径的信息，返回该目录与文件的路径列表-不进入子目录
	/// @param file_vector 文件路径存储容器
	/// @param dir_vector 目录路径存储容器
	/// @return  文件夹与文件的数量
	size_t getPathDirAndFile( std::vector< std::string > *file_vector, std::vector< std::string > *dir_vector ) const;
	/// @brief 获取路径的信息，返回该目录与文件的路径列表-进入子目录
	/// @param file_vector 文件路径存储容器
	/// @param dir_vector 目录路径存储容器
	/// @return  文件夹与文件的数量
	size_t getPathDirAndFileRecursive( std::vector< std::string > *file_vector, std::vector< std::string > *dir_vector ) const;
	/// @brief 获取路径的信息，返回该目录的路径列表-进入子目录
	/// @return  文件夹
	std::vector< std::string > getPathDirRecursive( ) const;
	/// @brief 获取路径的信息，返回该文件的路径列表-进入子目录
	/// @return  文件
	std::vector< std::string > getPathFileRecursive( ) const;

	/// @brief 获取路径的信息，返回该目录的路径列表
	/// @return  文件夹
	std::vector< std::string > getPathDir( ) const;
	/// @brief 获取路径的信息，返回该文件的路径列表
	/// @return  文件
	std::vector< std::string > getPathFile( ) const;
	/// @brief 获取路径的信息，返回该目录与文件的路径列表
	/// @param file_vector 文件路径存储容器
	/// @param dir_vector 目录路径存储容器
	/// @param is_cd_in_dir 是否进入子目录
	/// @return  文件夹与文件的数量
	size_t getPathDirAndFile( std::vector< std::string > *file_vector, std::vector< std::string > *dir_vector, bool is_cd_in_dir ) {
		if( is_cd_in_dir )
			return getPathDirAndFileRecursive( file_vector, dir_vector );
		return getPathDirAndFile( file_vector, dir_vector );
	}

	/// @brief 获取当前工作路径的信息，返回该目录与文件的路径列表
	/// @param file_vector 文件路径存储容器
	/// @param dir_vector 目录路径存储容器
	/// @param is_cd_in_dir 是否进入子目录
	/// @return  文件夹与文件的数量
	size_t getPathDirAndFile( std::vector< std::string > *file_vector, std::vector< std::string > *dir_vector, bool is_cd_in_dir ) const;
	/// @brief 获取文件名称
	/// @return 文件名称
	std::string getFileName( ) const {
		return currentPath.filename( ).string( );
	}
	/// @brief 获取文件基本名称-去后缀
	/// @return 基本类名称
	std::string getFileBaseName( ) const {
		auto fileName = this->getFileName( );
		size_t findLastOf = fileName.find_last_of( "." );
		if( findLastOf != std::string::npos )
			fileName = fileName.substr( 0, findLastOf );
		return fileName;
	}
	std::string getFileSuffix( ) const {
		auto fileName = this->getFileName( );
		size_t findLastOf = fileName.find_last_of( "." );
		if( findLastOf != std::string::npos )
			fileName = fileName.substr( findLastOf );
		return fileName;
	}
};
```

###  cyl::tools::stringTools 

字符串空间

```c++
/// @brief 宽字符串转多字节字符串
/// @param wstr 宽字符串
/// @param result
/// @return 多字节字符串
 size_t converString( const ToolsString &wstr, std::string *result );

/// @brief 多字节转宽字符
/// @param mbs 多字节字符串
/// @param result
/// @return 宽字符串
 size_t converString( const std::string &mbs, std::wstring *result );
/// @brief 字符串转大写
/// @param conver_tools_string 转换的字符串
 ToolsString toUpper( const ToolsString &conver_tools_string );
/// @brief 字符串转小写
/// @param conver_tools_string 转换的字符串
 ToolsString toLower( const ToolsString &conver_tools_string );

/// @brief 使用替换生成一个新的字符串
/// @param org_str 原始字符串
/// @param org_str_len 原始字符串长度
/// @param replace_src_str 原始字符串当中被替换的字符串
/// @param replace_src_str_len 匹配字符串的长度
/// @param replace_target_str 匹配到替换字符串后填充的字符串
/// @param replace_target_str_len 匹配替换的字符串长度
/// @param replace_count 替换次数
/// @return 新的字符串
 std::wstring replaceSubString( const CharValueType *org_str, size_t org_str_len, const CharValueType *replace_src_str, size_t replace_src_str_len, const CharValueType *replace_target_str, size_t replace_target_str_len, size_t replace_count );

/// @brief 使用替换生成一个新的字符串
/// @param org_str 原始字符串
/// @param org_str_len 原始字符串长度
/// @param replace_src_str 原始字符串当中被替换的字符串
/// @param replace_src_str_len 匹配字符串的长度
/// @param replace_target_str 匹配到替换字符串后填充的字符串
/// @param replace_target_str_len 匹配替换的字符串长度
/// @return 新的字符串
 std::wstring replaceSubString( const CharValueType *org_str, size_t org_str_len, const CharValueType *replace_src_str, size_t replace_src_str_len, const CharValueType *replace_target_str, size_t replace_target_str_len );

/// @brief 从结束开始，使用替换生成一个新的字符串
/// @param org_str 原始字符串
/// @param replace_src_str 原始字符串当中被替换的字符串
/// @param replace_target_str 匹配到替换字符串后填充的字符串
/// @param replace_count 替换次数
/// @return 新的字符串
 ToolsString replaceSubStringOnLast( ToolsString org_str, ToolsString replace_src_str, ToolsString replace_target_str, size_t replace_count );
/// @brief 切分字符串，并且返回切分后的字符串
/// @param source 切分源
/// @param check_string 匹配的字符串 
/// @return 切分后的字符串
 std::vector< std::wstring > splitString( const std::wstring &source, const std::wstring &check_string );

/// @brief 移除字符串全部空格
/// @param conver_tools_string 移除的字符串
 std::wstring removeAllSpaceChar( const std::wstring &conver_tools_string );
/// @brief 移除字符串左侧空格
/// @param conver_tools_string 移除的字符串
 std::wstring removeLeftSpaceChar( const std::wstring &conver_tools_string );
/// @brief 移除字符串右侧空格
/// @param conver_tools_string 移除的字符串
 std::wstring removeRightSpaceChar( const std::wstring &conver_tools_string );

/// @brief 移除字符串两侧空格
/// @param conver_tools_string 移除的字符串
 std::wstring removeBothSpaceChar( const std::wstring &conver_tools_string );
/// @brief 字符串当中是否存在空格
/// @param conver_tools_string 校验字符串 
/// @return 存在空格返回 true
inline bool hasSpace( const std::wstring &conver_tools_string ) {
	auto data = conver_tools_string.data( );
	size_t length = conver_tools_string.length( );
	for( size_t index = 0; index < length; ++index )
		if( isspace( data[ index ] ) )
			return true;
	return false;
}
/// @brief 字符串当中是否存在空格
/// @param conver_tools_string 校验字符串 
/// @return 存在空格返回 true
inline bool hasSpace( const std::string &conver_tools_string ) {
	auto data = conver_tools_string.data( );
	size_t length = conver_tools_string.length( );
	for( size_t index = 0; index < length; ++index )
		if( isspace( data[ index ] ) )
			return true;
	return false;
}
/// @brief 移除字符串全部空格
/// @param conver_tools_string 移除的字符串
inline std::string removeAllSpaceChar( const std::string &conver_tools_string ) {
	std::wstring converWString;
	converString( conver_tools_string, &converWString );
	std::string result;
	converString( removeAllSpaceChar( converWString ), &result );
	return result;
}
/// @brief 移除字符串左侧空格
/// @param conver_tools_string 移除的字符串
inline std::string removeLeftSpaceChar( const std::string &conver_tools_string ) {
	std::wstring converWString;
	converString( conver_tools_string, &converWString );
	std::string result;
	converString( removeLeftSpaceChar( converWString ), &result );
	return result;
}
/// @brief 移除字符串右侧空格
/// @param conver_tools_string 移除的字符串
inline std::string removeRightSpaceChar( const std::string &conver_tools_string ) {
	std::wstring converWString;
	converString( conver_tools_string, &converWString );
	std::string result;
	converString( removeRightSpaceChar( converWString ), &result );
	return result;
}
/// @brief 移除字符串两侧空格
/// @param conver_tools_string 移除的字符串
inline std::string removeBothSpaceChar( const std::string &conver_tools_string ) {
	std::wstring converWString;
	converString( conver_tools_string, &converWString );
	std::string result;
	converString( removeBothSpaceChar( converWString ), &result );
	return result;
}

/// @brief 切分字符串，并且返回切分后的字符串
/// @param source 切分源
/// @param check_string 匹配的字符串 
/// @return 切分后的字符串
inline std::vector< std::string > splitString( const std::string &source, const std::string &check_string ) {
	std::wstring converSourceString, converCheckString;
	converString( source, &converSourceString );
	converString( check_string, &converCheckString );
	auto resultWVector = splitString( converSourceString, converCheckString );
	std::vector< std::string > result;
	std::string converSTDString;
	for( auto &spliteWString : resultWVector ) {
		converString( spliteWString, &converSTDString );
		result.emplace_back( converSTDString );
	}
	return result;
}
/// @brief 使用替换生成一个新的字符串
/// @param org_str 原始字符串
/// @param replace_src_str 原始字符串当中被替换的字符串
/// @param replace_target_str 匹配到替换字符串后填充的字符串
/// @return 新的字符串
inline ToolsString replaceSubString( const CharValueType *org_str, const CharValueType *replace_src_str, const CharValueType *replace_target_str ) {
	return replaceSubString( org_str, std::wcslen( org_str ), replace_src_str, std::wcslen( replace_src_str ), replace_target_str, std::wcslen( replace_target_str ) );
}
/// @brief 使用替换生成一个新的字符串
/// @param org_str 原始字符串
/// @param replace_src_str 原始字符串当中被替换的字符串
/// @param replace_target_str 匹配到替换字符串后填充的字符串
/// @return 新的字符串
inline ToolsString replaceSubString( const ToolsString &org_str, const ToolsString &replace_src_str, const ToolsString &replace_target_str ) {
	return replaceSubString( org_str.c_str( ), org_str.length( ), replace_src_str.c_str( ), replace_src_str.length( ), replace_target_str.c_str( ), replace_target_str.length( ) );
}

/// @brief 使用替换生成一个新的字符串
/// @param org_str 原始字符串
/// @param replace_src_str 原始字符串当中被替换的字符串
/// @param replace_target_str 匹配到替换字符串后填充的字符串
/// @param replace_count 替换次数
/// @return 新的字符串
inline ToolsString replaceSubString( const CharValueType *org_str, const CharValueType *replace_src_str, const CharValueType *replace_target_str, size_t replace_count ) {
	return replaceSubString( org_str, std::wcslen( org_str ), replace_src_str, std::wcslen( replace_src_str ), replace_target_str, std::wcslen( replace_target_str ), replace_count );
}
/// @brief 使用替换生成一个新的字符串
/// @param org_str 原始字符串
/// @param replace_src_str 原始字符串当中被替换的字符串
/// @param replace_target_str 匹配到替换字符串后填充的字符串
/// @param replace_count 替换次数
/// @return 新的字符串
inline ToolsString replaceSubString( const ToolsString &org_str, const ToolsString &replace_src_str, const ToolsString &replace_target_str, size_t replace_count ) {
	return replaceSubString( org_str.c_str( ), org_str.length( ), replace_src_str.c_str( ), replace_src_str.length( ), replace_target_str.c_str( ), replace_target_str.length( ), replace_count );
}

/// @brief 使用替换生成一个新的字符串
/// @param org_str 原始字符串
/// @param replace_src_str 原始字符串当中被替换的字符串
/// @param replace_target_str 匹配到替换字符串后填充的字符串
/// @param replace_count 替换次数
/// @return 新的字符串
inline std::string replaceSubString( const std::string &org_str, const std::string &replace_src_str, const std::string &replace_target_str, size_t replace_count ) {
	ToolsString ortStr, replaceSrcStr, replaceTargetStr;
	std::string result;
	if( converString( org_str, &ortStr ) && converString( replace_src_str, &replaceSrcStr ) && converString( replace_target_str, &replaceTargetStr ) ) {
		ToolsString wstring = replaceSubString( ortStr.c_str( ), ortStr.length( ), replaceSrcStr.c_str( ), replaceSrcStr.length( ), replaceTargetStr.c_str( ), replaceTargetStr.length( ), replace_count );
		converString( wstring, &result );
		return result;
	}
	return result;
}

/// @brief 使用替换生成一个新的字符串
/// @param org_str 原始字符串
/// @param replace_src_str 原始字符串当中被替换的字符串
/// @param replace_target_str 匹配到替换字符串后填充的字符串
/// @return 新的字符串
inline std::string replaceSubString( const std::string &org_str, const std::string &replace_src_str, const std::string &replace_target_str ) {
	ToolsString ortStr, replaceSrcStr, replaceTargetStr;
	std::string result;
	if( converString( org_str, &ortStr ) && converString( replace_src_str, &replaceSrcStr ) && converString( replace_target_str, &replaceTargetStr ) ) {
		ToolsString wstring = replaceSubString( ortStr.c_str( ), ortStr.length( ), replaceSrcStr.c_str( ), replaceSrcStr.length( ), replaceTargetStr.c_str( ), replaceTargetStr.length( ) );
		converString( wstring, &result );
	}
	return result;
}

/// @brief 从结束开始，使用替换生成一个新的字符串
/// @param org_str 原始字符串
/// @param replace_src_str 原始字符串当中被替换的字符串
/// @param replace_target_str 匹配到替换字符串后填充的字符串
/// @param replace_count 替换次数
/// @return 新的字符串
inline std::string replaceSubStringOnLast( const std::string &org_str, const std::string &replace_src_str, const std::string &replace_target_str, size_t replace_count ) {
	ToolsString ortStr, replaceSrcStr, replaceTargetStr;
	std::string result;
	if( converString( org_str, &ortStr ) && converString( replace_src_str, &replaceSrcStr ) && converString( replace_target_str, &replaceTargetStr ) ) {
		ToolsString wstring = replaceSubStringOnLast( ortStr, replaceSrcStr, replaceTargetStr, replace_count );
		converString( wstring, &result );
		return result;
	}
	return result;
}

/// @brief 判断是否为空字符
/// @param check_char 校验字符
/// @return 空字符返回 true
inline bool isSpace( const int &check_char ) {
	if( std::isblank( check_char ) || std::isspace( check_char ) || std::iscntrl( check_char ) || !std::isprint( check_char ) )
		return true;
	return false;
}

/// @brief 判断是否为空字符
/// @param check_char 校验字符
/// @return 空字符返回 true
inline bool isSpace( const std::wint_t &check_char ) {
	if( std::iswblank( check_char ) || std::iswspace( check_char ) || std::iswcntrl( check_char ) || !std::iswprint( check_char ) )
		return true;
	return false;
}
```

### cyl::tools::time

时间类

```c++

class  cyl::tools::time {
public:
	using Ratio = std::ratio< 1, 10000000 >;
	using l_time_t = long long;
	using Duration = std::chrono::duration< l_time_t, Ratio >;
	using Clock = std::chrono::system_clock;
	using TimePoint = std::chrono::time_point< Clock >;
	/// @brief 获取格林时间到本地时间的相差-小时
	/// @return 相差小时
	static int getUtcToLocalAtHourSepTime( );
	/// @brief 时间数据格式化输出字符串 - utc 格式
	/// @brief %Y - xxxx 年
	/// @brief %m - xx 月
	/// @brief %d - xx 日
	/// @brief %H - xx 小时
	/// @brief %M - xx 分钟
	/// @brief %S - xx 秒
	/// @see std::put_time
	/// @param form_time_string 格式化字符串
	/// @param to_string_time 转换时间点
	/// @return 转换后的字符串
	static std::string toStdStringOnUTC( const std::string &form_time_string, const TimePoint &to_string_time );

	/// @brief 时间数据格式化输出字符串 - 本地格式
	/// @brief %Y - xxxx 年
	/// @brief %m - xx 月
	/// @brief %d - xx 日
	/// @brief %H - xx 小时
	/// @brief %M - xx 分钟
	/// @brief %S - xx 秒
	/// @param form_time_string 格式化字符串
	/// @param to_string_time 转换时间点
	/// @return 转换后的字符串
	static std::string toStringOnLocal( const std::string &form_time_string, const TimePoint &to_string_time );

	/// <summary>
	/// 比较一个时间，并且返回时间差
	/// </summary>
	/// <param name="left_date_time">被减数</param>
	/// <param name="right_date_time">减数</param>
	/// <returns>时间差</returns>
	static std::chrono::milliseconds compareDateTime( const TimePoint &left_date_time, const TimePoint &right_date_time ) {
		auto leftTimeSinceEpoch = std::chrono::duration_cast< std::chrono::milliseconds >( left_date_time.time_since_epoch( ) );
		auto rightTimeSinceEpoch = std::chrono::duration_cast< std::chrono::milliseconds >( right_date_time.time_since_epoch( ) );
		std::chrono::milliseconds stdMilliseconds = leftTimeSinceEpoch - rightTimeSinceEpoch;
		return stdMilliseconds;
	}
	/// @brief 从时间点上获取年份
	/// @param time_point 时间点
	/// @return 年份
	static l_time_t getYear( const TimePoint &time_point );
	/// @brief 从时间点上获取月份
	/// @param time_point 时间点
	/// @return 月份
	static l_time_t getMon( const TimePoint &time_point );
	/// @brief 从时间点上获取当前日
	/// @param time_point 时间点
	/// @return 月份中的日
	static l_time_t getDay( const TimePoint &time_point );
	/// @brief 从时间点上获取小时
	/// @param time_point 时间点
	/// @return 小时
	static l_time_t getHour( const TimePoint &time_point );
	/// @brief 从时间点上获取分钟
	/// @param time_point 时间点
	/// @return 分钟
	static l_time_t getMinute( const TimePoint &time_point );
	/// @brief 从时间点上获取秒
	/// @param time_point 时间点
	/// @return 秒
	static l_time_t getSecond( const TimePoint &time_point );
	/// @brief 从时间点上获取毫秒
	/// @param time_point 时间点
	/// @return 毫秒
	static l_time_t getMillisecond( const TimePoint &time_point );
```

