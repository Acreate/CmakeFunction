#include <iostream>
#include <tools/io.h>
#include <tools/path.h>
#include <cmake_include_to_c_cpp_header_env.h>
#include <source_location>
#include <cuchar>

#include "tools/stringTools.h"
DEF_CURRENT_RELATIVELY_PATH_STATIC_VALUE( __FILE__ );
DEF_CURRENT_PROJECT_NAME( );
#include <climits>
#include <clocale>
#include <cuchar>
#include <iomanip>
#include <iostream>
#include <string_view>

int main( ) {
	std::locale sys_loc( "" );
	std::wcout.imbue( sys_loc );
	std::cout.imbue( sys_loc );
	std::string s = "中文";
	std::wstring outWstring;
	if( cyl::tools::stringTools::stdCppConverString( s, outWstring, sys_loc ) )
		std::wcout << outWstring << std::endl;
	outWstring = L"汉化";
	if( cyl::tools::stringTools::stdCppConverString( outWstring, s, sys_loc ) )
		std::cout << s << std::endl;
}
