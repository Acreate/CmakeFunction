#ifndef TOOLSNAMESPACES_H_H_HEAD__FILE__
#define TOOLSNAMESPACES_H_H_HEAD__FILE__
#pragma once
#include <string>
#include "../auto_generate_files/export/CmakeFuncs_userLib_tools_export.h"
#include "enum.h"
namespace cyl {
	namespace tools {
		/// @brief 路径操作类
		class CMAKEFUNCS_USERLIB_TOOLS_EXPORT path;
		/// @brief 图片类
		class CMAKEFUNCS_USERLIB_TOOLS_EXPORT Image;
		/// @brief 输出输入操作类
		namespace io { }
		/// @brief 时间操作类
		class CMAKEFUNCS_USERLIB_TOOLS_EXPORT time;
		/// @brief 字符串工具类
		namespace stringTools { }
	}

}

#include "path.h"
#include "io.h"

#endif // TOOLSNAMESPACES_H_H_HEAD__FILE__
