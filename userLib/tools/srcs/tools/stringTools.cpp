#include "stringTools.h"
#include <codecvt>
#include <iostream>
#include <sstream>
#include <vector>
#include <locale>

typedef std::codecvt< wchar_t, char, mbstate_t > CodecvtFacet;
size_t cyl::tools::stringTools::stdCppConverString( const std::string &conver_str, std::wstring &result_str, const std::locale &locale ) {

	const char *src_str = conver_str.c_str( );
	size_t converCount = conver_str.size( );
	const size_t bufferSize = ( converCount + 1 ) * sizeof std::string::value_type;

	wchar_t *internBuffer = new wchar_t[ bufferSize ];
	wmemset( internBuffer, 0, bufferSize );

	mbstate_t in_cvt_state;
	const char *externFromNext = 0;
	wchar_t *internToNext = 0;

	CodecvtFacet::result cvtRst =
		std::use_facet< CodecvtFacet >( locale ).in(
			in_cvt_state,
			src_str, src_str + converCount, externFromNext,
			internBuffer, internBuffer + bufferSize, internToNext );
	if( cvtRst != CodecvtFacet::ok ) {
		delete []internBuffer;
		return 0;
	}
	result_str = internBuffer;
	delete []internBuffer;
	return bufferSize;
}
size_t cyl::tools::stringTools::stdCppConverString( const std::wstring &conver_str, std::string &result_str, const std::locale &locale ) {
	mbstate_t out_cvt_state;
	const wchar_t *src_wstr = conver_str.c_str( );
	const size_t MAX_UNICODE_BYTES = sizeof std::wstring::value_type;
	const size_t BUFFER_SIZE =
		( conver_str.size( ) + 1 ) * MAX_UNICODE_BYTES;

	char *extern_buffer = new char [ BUFFER_SIZE ];
	memset( extern_buffer, 0, BUFFER_SIZE );

	const wchar_t *intern_from = src_wstr;
	const wchar_t *intern_from_end = intern_from + conver_str.size( );
	const wchar_t *intern_from_next = 0;
	char *extern_to = extern_buffer;
	char *extern_to_end = extern_to + BUFFER_SIZE;
	char *extern_to_next = 0;

	CodecvtFacet::result cvt_rst =
		std::use_facet< CodecvtFacet >( locale ).out(
			out_cvt_state,
			intern_from, intern_from_end, intern_from_next,
			extern_to, extern_to_end, extern_to_next );
	if( cvt_rst != CodecvtFacet::ok ) {
		delete []extern_buffer;
		return 0;
	}
	result_str = extern_buffer;

	delete []extern_buffer;
	return BUFFER_SIZE;
}
//
//size_t cyl::tools::stringTools::converString( const std::string &conver_str, std::wstring &result_str ) {
//	std::wstring_convert< std::codecvt_utf8< wchar_t > > myconv;
//	result_str = myconv.from_bytes( conver_str );
//	return conver_str.size( );
//}
//size_t cyl::tools::stringTools::converString( const std::string &conver_str, std::wstring &result_str, const std::locale &locale ) {
//	std::vector< std::wstring::value_type > buff( conver_str.size( ) );
//	std::use_facet< std::ctype< std::wstring::value_type > >( locale ).widen( conver_str.data( ), conver_str.data( ) + conver_str.size( ), buff.data( ) );
//	result_str = std::wstring( buff.data( ), buff.size( ) );
//	return conver_str.size( );
//}
//size_t cyl::tools::stringTools::converString( const std::wstring &conver_str, std::string &result_str ) {
//	std::wstring_convert< std::codecvt_utf8< wchar_t > > myconv;
//	result_str = myconv.to_bytes( conver_str );
//	return conver_str.size( );
//}
//size_t cyl::tools::stringTools::converString( const std::wstring &conver_str, std::string &result_str, const std::locale &locale ) {
//	std::vector< std::string::value_type > buff( conver_str.size( ) );
//	std::use_facet< std::ctype< std::wstring::value_type > >( locale ).narrow( conver_str.data( ), conver_str.data( ) + conver_str.size( ), '?', buff.data( ) );
//	result_str = std::string( buff.data( ), buff.size( ) );
//	return conver_str.size( );
//}
size_t cyl::tools::stringTools::converString( const std::wstring &wstr, std::string *result ) {
	std::string strLocale = setlocale( LC_ALL, "" );
	const wchar_t *wchSrc = wstr.c_str( );
	size_t nDestSize = wcstombs( NULL, wchSrc, 0 ) + 1;
	char *chDest = new char[ nDestSize ];
	memset( chDest, 0, nDestSize );
	wcstombs( chDest, wchSrc, nDestSize );
	*result = chDest;
	delete[] chDest;
	setlocale( LC_ALL, strLocale.c_str( ) );
	return nDestSize;
}
size_t cyl::tools::stringTools::converString( const std::string &mbs, std::wstring *result ) {
	std::string strLocale = setlocale( LC_ALL, "" );
	const char *chSrc = mbs.c_str( );
	size_t nDestSize = mbstowcs( NULL, chSrc, 0 ) + 1;
	wchar_t *wchDest = new wchar_t[ nDestSize ];
	wmemset( wchDest, 0, nDestSize );
	mbstowcs( wchDest, chSrc, nDestSize );
	*result = wchDest;
	delete[ ] wchDest;
	setlocale( LC_ALL, strLocale.c_str( ) );
	return nDestSize;
}
std::wstring cyl::tools::stringTools::toUpper( const std::wstring &conver_tools_string ) {
	auto strPtr = conver_tools_string.c_str( );
	auto len = conver_tools_string.length( );
	std::vector< std::wstring::value_type > data( len );
	auto index = 0;
	auto dataPtr = data.data( );
	for( ; index < len; ++index )
		dataPtr[ index ] = std::towupper( strPtr[ index ] );
	return std::wstring( dataPtr, index );
}
std::wstring cyl::tools::stringTools::toLower( const std::wstring &conver_tools_string ) {
	auto strPtr = conver_tools_string.c_str( );
	auto len = conver_tools_string.length( );
	std::vector< std::wstring::value_type > data( len );
	auto index = 0;
	auto dataPtr = data.data( );
	for( ; index < len; ++index )
		dataPtr[ index ] = std::towlower( strPtr[ index ] );
	return std::wstring( dataPtr, index );
}

std::wstring cyl::tools::stringTools::replaceSubString( const std::wstring::value_type *org_str, const size_t org_str_len, const std::wstring::value_type *replace_src_str, const size_t replace_src_str_len, const std::wstring::value_type *replace_target_str, const size_t replace_target_str_len, size_t replace_count ) {
	if( replace_count == 0 )
		return org_str;
	std::wstringstream ss; // 流字符串对象
	if( org_str_len > 0 && replace_src_str_len > 0 ) { // 需要原始字符串与匹配长度都大于 0
		size_t buffLen = 1024; // 缓冲大小
		std::wstring::value_type *buff = new std::wstring::value_type[ buffLen ]; // 缓冲
		size_t buffIndex = 0; // 缓冲下标
		size_t orgStrIndex = 0; // 原始字符串访问下标
		while( orgStrIndex < org_str_len ) { // 遍历
			std::wstring::value_type refChar = org_str[ orgStrIndex ];
			if( refChar == replace_src_str[ 0 ] ) {
				size_t replaceStrIndex = 1; // 匹配字符串长度下标
				if( replaceStrIndex < replace_src_str_len )
					for( size_t cloneOrgStrIndex = orgStrIndex + 1; replaceStrIndex < replace_src_str_len && cloneOrgStrIndex < org_str_len; ++replaceStrIndex, ++cloneOrgStrIndex )
						if( org_str[ cloneOrgStrIndex ] != replace_src_str[ replaceStrIndex ] )
							break;
				if( replaceStrIndex == replace_src_str_len ) {
					if( buffIndex > 0 ) {
						ss << std::wstring( buff, buffIndex ); // 追加到字符串
						buffIndex = 0;
					}
					if( replace_target_str_len )
						ss << replace_target_str; // 追加到字符串
					orgStrIndex += replace_src_str_len; // 追加下标
					replace_count -= 1;
					if( replace_count == 0 ) { // 次数足够则跳出循环
						if( orgStrIndex < org_str_len ) // 处理未处理字符串
							ss << org_str + orgStrIndex;
						break;
					}
					continue;
				}
			}
			buff[ buffIndex ] = refChar;
			buffIndex += 1;
			if( buffIndex == buffLen ) {
				ss << std::wstring( buff, buffIndex ); // 追加到字符串
				buffIndex = 0;
			}
			++orgStrIndex;
		}
		if( buffIndex != 0 )
			ss << std::wstring( buff, buffIndex ); // 追加到字符串
		delete[] buff;
	}

	return ss.str( );
}
std::wstring cyl::tools::stringTools::replaceSubString( const std::wstring::value_type *org_str, const size_t org_str_len, const std::wstring::value_type *replace_src_str, const size_t replace_src_str_len, const std::wstring::value_type *replace_target_str, const size_t replace_target_str_len ) {
	std::wstringstream ss; // 流字符串对象
	if( org_str_len > 0 && replace_src_str_len > 0 ) { // 需要原始字符串与匹配长度都大于 0
		size_t buffLen = 1024; // 缓冲大小
		std::wstring::value_type *buff = new std::wstring::value_type[ buffLen ]; // 缓冲
		size_t buffIndex = 0; // 缓冲下标
		size_t orgStrIndex = 0; // 原始字符串访问下标
		while( orgStrIndex < org_str_len ) { // 遍历
			std::wstring::value_type refChar = org_str[ orgStrIndex ];
			if( refChar == replace_src_str[ 0 ] ) {
				size_t replaceStrIndex = 1; // 匹配字符串长度下标
				if( replaceStrIndex < replace_src_str_len )
					for( size_t cloneOrgStrIndex = orgStrIndex + 1; replaceStrIndex < replace_src_str_len && cloneOrgStrIndex < org_str_len; ++replaceStrIndex, ++cloneOrgStrIndex )
						if( org_str[ cloneOrgStrIndex ] != replace_src_str[ replaceStrIndex ] )
							break;
				if( replaceStrIndex == replace_src_str_len ) {
					if( buffIndex > 0 ) {
						ss << std::wstring( buff, buffIndex ); // 追加到字符串
						buffIndex = 0;
					}
					if( replace_target_str_len )
						ss << replace_target_str; // 追加到字符串
					orgStrIndex += replace_src_str_len; // 追加下标
					continue;
				}

			}
			buff[ buffIndex ] = refChar;
			buffIndex += 1;
			if( buffIndex == buffLen ) {
				ss << std::wstring( buff, buffIndex ); // 追加到字符串
				buffIndex = 0;
			}
			++orgStrIndex;
		}
		if( buffIndex != 0 )
			ss << std::wstring( buff, buffIndex ); // 追加到字符串
		delete[] buff;
	}

	return ss.str( );
}
std::wstring cyl::tools::stringTools::replaceSubStringOnLast( std::wstring org_str, std::wstring replace_src_str, std::wstring replace_target_str, size_t replace_count ) {
	std::reverse( org_str.begin( ), org_str.end( ) ); // 重新逆转
	std::reverse( replace_src_str.begin( ), replace_src_str.end( ) ); // 重新逆转
	std::reverse( replace_target_str.begin( ), replace_target_str.end( ) ); // 重新逆转
	// 替换完毕的字符串
	auto replaceWString = replaceSubString( org_str.c_str( ), org_str.length( ), replace_src_str.c_str( ), replace_src_str.length( ), replace_target_str.c_str( ), replace_target_str.length( ), replace_count );
	std::reverse( replaceWString.begin( ), replaceWString.end( ) ); // 重新逆转
	return replaceWString; // 返回逆转后的字符串
}
std::vector< std::wstring > cyl::tools::stringTools::splitString( const std::wstring &source, const std::wstring &check_string ) {
	std::vector< std::wstring > result;
	auto matchDataLen = check_string.length( ); // 匹配长度
	if( matchDataLen == 0 )
		return result;
	auto sourceLen = source.length( ); // 源长度
	if( sourceLen == 0 )
		return result;
	auto sourceDataPtr = source.data( ); // 源
	auto matchDataPtr = check_string.data( ); // 匹配源
	size_t cloneSourceIndex = 0, // 检查时候使用的克隆下标
			spliteStartIndex = 0, // 切分的起始下标
			matchIndex = 0, // 匹配目标
			sourceIndex = 0; // 遍历源
	auto *buff = new std::wstring::value_type[ sourceLen ];
	while( sourceIndex < sourceLen ) {
		auto checkChar = sourceDataPtr[ sourceIndex ];
		if( matchDataPtr[ matchIndex ] == checkChar ) {
			++sourceIndex; // 源加下标
			++matchIndex; // 匹配加下标
			cloneSourceIndex = sourceIndex; // 拷贝源下标
			for( ; matchIndex < matchDataLen && cloneSourceIndex < sourceLen; ++matchIndex, ++cloneSourceIndex ) { // 匹配整个匹配字符串
				if( matchDataPtr[ matchIndex ] != sourceDataPtr[ cloneSourceIndex ] ) {
					matchIndex = 0; // 重置
					break;
				}
			}
			// 完全匹配，同时缓存存在数据，可以存在到列表当中
			if( matchIndex != 0 && spliteStartIndex != 0 ) {
				result.emplace_back( std::wstring( buff, spliteStartIndex ) );
				sourceIndex = cloneSourceIndex;
			}
			matchIndex = spliteStartIndex = 0;
			continue; // 不在拷贝
		}
		buff[ spliteStartIndex++ ] = checkChar; // 拷贝当前不匹配元素
		++sourceIndex;
	}
	if( spliteStartIndex )
		result.emplace_back( std::wstring( buff, spliteStartIndex ) );
	delete[] buff;
	return result;
}
std::wstring cyl::tools::stringTools::removeAllSpaceChar( const std::wstring &conver_tools_string ) {
	auto strPtr = conver_tools_string.c_str( );
	auto len = conver_tools_string.length( );
	std::vector< std::wstring::value_type > data( len );
	auto index = 0, dataIndex = 0;
	auto dataPtr = data.data( );
	for( ; index < len; ++index )
		if( !isSpace( strPtr[ index ] ) )
			dataPtr[ dataIndex++ ] = strPtr[ index ];
	return std::wstring( dataPtr, dataIndex );
}
std::wstring cyl::tools::stringTools::removeLeftSpaceChar( const std::wstring &conver_tools_string ) {
	auto strPtr = conver_tools_string.c_str( );
	auto len = conver_tools_string.length( );
	std::vector< std::wstring::value_type > data( len );
	auto index = 0, dataIndex = 0;
	auto dataPtr = data.data( );
	for( ; index < len; ++index )
		if( !isSpace( strPtr[ index ] ) ) {
			dataPtr[ dataIndex++ ] = strPtr[ index++ ];
			for( ; index < len; ++index )
				dataPtr[ dataIndex++ ] = strPtr[ index ];
			break;
		}
	return std::wstring( dataPtr, dataIndex );
}
std::wstring cyl::tools::stringTools::removeRightSpaceChar( const std::wstring &conver_tools_string ) {
	auto strPtr = conver_tools_string.c_str( );
	auto len = conver_tools_string.length( );
	std::vector< std::wstring::value_type > data( len );
	auto index = 0, dataIndex = 0;
	auto dataPtr = data.data( );
	if( len != 0 )
		do {
			--len;
			if( !isSpace( strPtr[ len ] ) ) {
				dataPtr[ dataIndex++ ] = strPtr[ index++ ];
				for( ; index <= len; ++index )
					dataPtr[ dataIndex++ ] = strPtr[ index ];
				break;
			}
		} while( len != 0 );
	return std::wstring( dataPtr, dataIndex );
}
std::wstring cyl::tools::stringTools::removeBothSpaceChar( const std::wstring &conver_tools_string ) {
	auto strPtr = conver_tools_string.c_str( );
	auto len = conver_tools_string.length( );
	std::vector< std::wstring::value_type > data( len );
	auto index = 0, dataIndex = 0;
	auto dataPtr = data.data( );
	if( len != 0 )
		do {
			--len;
			if( !isSpace( strPtr[ len ] ) ) {
				for( ; index < len; ++index )
					if( !isSpace( strPtr[ index ] ) ) {
						dataPtr[ dataIndex++ ] = strPtr[ index++ ];
						for( ; index < len; ++index )
							dataPtr[ dataIndex++ ] = strPtr[ index ];
						dataPtr[ dataIndex++ ] = strPtr[ index ];
						break;
					}
				break;
			}
		} while( len != 0 );
	return std::wstring( dataPtr, dataIndex );
}
