#include <QApplication>
#include <cmake_include_to_c_cpp_header_env.h>
#include "windows/MainWindow.h"
#include <QDir>
#include <QTranslator>
int main( int argc, char *argv[ ] ) {
	QApplication app( argc, argv );
	MainWindow mainWidget;
	mainWidget.show( );
	QStringList tranFile;
	tranFile << QDir::currentPath( ) << "progress" << "translations" << "cmake_source_learn_qt_demo001_zh_CN.qm";
	auto transPath = tranFile.join( QDir::separator( ) );
	QTranslator translator;
	if( translator.load( transPath ) ) {
		mainWidget.printer( "===============  未加载到应用程序" );

		mainWidget.printer( );
		mainWidget.printer( QObject::tr( "类型" ) );

		qDebug( ) << "语言 : " << translator.language( );
		qApp->installTranslator( &translator );
		mainWidget.printer( "===============  加载到程序" );
		mainWidget.printer( );
		mainWidget.printer( QObject::tr( "类型" ) );
	}

	return app.exec( );
}
