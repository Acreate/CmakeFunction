#ifndef STRINGTOOLS_H_H_HEAD__FILE__
#define STRINGTOOLS_H_H_HEAD__FILE__
#pragma once

#include <codecvt>

#include <cwctype>
#include <cctype>

#include "toolsNamespace.h"
namespace cyl::tools::stringTools {
	//CMAKEFUNCS_USERLIB_TOOLS_EXPORT  size_t converString( const std::string &conver_str, std::wstring &result_str );
	//CMAKEFUNCS_USERLIB_TOOLS_EXPORT size_t converString( const std::string &conver_str, std::wstring &result_str, const std::locale &locale );
	//CMAKEFUNCS_USERLIB_TOOLS_EXPORT size_t converString( const std::wstring &conver_str, std::string &result_str );

	//CMAKEFUNCS_USERLIB_TOOLS_EXPORT size_t converString( const std::wstring &conver_str, std::string &result_str, const std::locale &locale );
	/// @brief 宽字符串转多字节字符串
	/// @param wstr 宽字符串
	/// @param result
	/// @return 多字节字符串
	CMAKEFUNCS_USERLIB_TOOLS_EXPORT size_t converString( const ToolsString &wstr, std::string *result );

	/// @brief 多字节转宽字符
	/// @param mbs 多字节字符串
	/// @param result
	/// @return 宽字符串
	CMAKEFUNCS_USERLIB_TOOLS_EXPORT size_t converString( const std::string &mbs, std::wstring *result );
	/// @brief 字符串转大写
	/// @param conver_tools_string 转换的字符串
	CMAKEFUNCS_USERLIB_TOOLS_EXPORT ToolsString toUpper( const ToolsString &conver_tools_string );
	/// @brief 字符串转小写
	/// @param conver_tools_string 转换的字符串
	CMAKEFUNCS_USERLIB_TOOLS_EXPORT ToolsString toLower( const ToolsString &conver_tools_string );

	/// @brief 使用替换生成一个新的字符串
	/// @param org_str 原始字符串
	/// @param org_str_len 原始字符串长度
	/// @param replace_src_str 原始字符串当中被替换的字符串
	/// @param replace_src_str_len 匹配字符串的长度
	/// @param replace_target_str 匹配到替换字符串后填充的字符串
	/// @param replace_target_str_len 匹配替换的字符串长度
	/// @param replace_count 替换次数
	/// @return 新的字符串
	CMAKEFUNCS_USERLIB_TOOLS_EXPORT std::wstring replaceSubString( const CharValueType *org_str, size_t org_str_len, const CharValueType *replace_src_str, size_t replace_src_str_len, const CharValueType *replace_target_str, size_t replace_target_str_len, size_t replace_count );

	/// @brief 使用替换生成一个新的字符串
	/// @param org_str 原始字符串
	/// @param org_str_len 原始字符串长度
	/// @param replace_src_str 原始字符串当中被替换的字符串
	/// @param replace_src_str_len 匹配字符串的长度
	/// @param replace_target_str 匹配到替换字符串后填充的字符串
	/// @param replace_target_str_len 匹配替换的字符串长度
	/// @return 新的字符串
	CMAKEFUNCS_USERLIB_TOOLS_EXPORT std::wstring replaceSubString( const CharValueType *org_str, size_t org_str_len, const CharValueType *replace_src_str, size_t replace_src_str_len, const CharValueType *replace_target_str, size_t replace_target_str_len );

	/// @brief 从结束开始，使用替换生成一个新的字符串
	/// @param org_str 原始字符串
	/// @param replace_src_str 原始字符串当中被替换的字符串
	/// @param replace_target_str 匹配到替换字符串后填充的字符串
	/// @param replace_count 替换次数
	/// @return 新的字符串
	CMAKEFUNCS_USERLIB_TOOLS_EXPORT ToolsString replaceSubStringOnLast( ToolsString org_str, ToolsString replace_src_str, ToolsString replace_target_str, size_t replace_count );
	/// @brief 切分字符串，并且返回切分后的字符串
	/// @param source 切分源
	/// @param check_string 匹配的字符串 
	/// @return 切分后的字符串
	CMAKEFUNCS_USERLIB_TOOLS_EXPORT std::vector< std::wstring > splitString( const std::wstring &source, const std::wstring &check_string );

	/// @brief 移除字符串全部空格
	/// @param conver_tools_string 移除的字符串
	CMAKEFUNCS_USERLIB_TOOLS_EXPORT std::wstring removeAllSpaceChar( const std::wstring &conver_tools_string );
	/// @brief 移除字符串左侧空格
	/// @param conver_tools_string 移除的字符串
	CMAKEFUNCS_USERLIB_TOOLS_EXPORT std::wstring removeLeftSpaceChar( const std::wstring &conver_tools_string );
	/// @brief 移除字符串右侧空格
	/// @param conver_tools_string 移除的字符串
	CMAKEFUNCS_USERLIB_TOOLS_EXPORT std::wstring removeRightSpaceChar( const std::wstring &conver_tools_string );

	/// @brief 移除字符串两侧空格
	/// @param conver_tools_string 移除的字符串
	CMAKEFUNCS_USERLIB_TOOLS_EXPORT std::wstring removeBothSpaceChar( const std::wstring &conver_tools_string );
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
};

#endif // STRINGTOOLS_H_H_HEAD__FILE__
