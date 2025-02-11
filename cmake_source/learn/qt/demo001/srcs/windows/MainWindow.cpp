#include "MainWindow.h"

#include <qdatetime.h>
void MainWindow::printer( ) {
	printer( tr( "类型" ) );
}
void MainWindow::printer( const QString &msg ) {
	qDebug( ) << msg << " " << QDateTime::currentDateTime( );
}
