#include <iostream>
#include <tools/io.h>
#include <tools/path.h>
#include <cmake_include_to_c_cpp_header_env.h>
#include <source_location>
#include <stacktrace>
DEF_CURRENT_RELATIVELY_PATH_STATIC_VALUE( __FILE__ );
DEF_CURRENT_PROJECT_NAME( );

void out( ) {
	auto currentsacktrace = std::stacktrace::current( );

	std::cout << "=============\n";
	std::cout << std::to_string( currentsacktrace );
	std::cout << "\n=============\n";
	size_t inde = 0;
	std::stringstream ss;
	ss << "\n";
	for( auto &entry : currentsacktrace ) {
		auto description = entry.description( );
		auto sourceFile = entry.source_file( );

		auto sourceLine = entry.source_line( );
		auto nativeHandle = entry.native_handle( );

		ss << "=============\n";
		ss << "index = " << inde << "\n";
		ss << "description = " << description << "\n";
		ss << "sourceFile = " << sourceFile << "\n";
		ss << "sourceLine = " << sourceLine << "\n";
		ss << "----------->\n";
		ss << "\tentry = " << entry << "\n";
		ss << "=============\n";
		inde += 1;
	}
	Printer_Normal_Info( ss.str( ) );
	ss = std::stringstream( );
	ss << "\n";
	ss << "=============\n";
	auto sourceLocation = std::source_location::current( );
	ss << "file: "
		<< sourceLocation.file_name( ) << "("
		<< sourceLocation.line( ) << ":"
		<< sourceLocation.column( ) << ") `"
		<< sourceLocation.function_name( ) << "\n";
	ss << "=============\n";
	Printer_Normal_Info( ss.str( ) );
}

int main( int argc, char **argv ) {

	out( );
	exit( EXIT_SUCCESS ); // 安全退出
}
