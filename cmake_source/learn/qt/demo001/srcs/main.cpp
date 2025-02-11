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
		mainWidget.printer( "===============  δ���ص�Ӧ�ó���" );

		mainWidget.printer( );
		mainWidget.printer( QObject::tr( "����" ) );

		qDebug( ) << "���� : " << translator.language( );
		qApp->installTranslator( &translator );
		mainWidget.printer( "===============  ���ص�����" );
		mainWidget.printer( );
		mainWidget.printer( QObject::tr( "����" ) );
	}

	return app.exec( );
}
