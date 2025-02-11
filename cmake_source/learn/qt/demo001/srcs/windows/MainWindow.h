#ifndef MAINWINDOW_H_H_HEAD__FILE__
#define MAINWINDOW_H_H_HEAD__FILE__
#pragma once

#include <QMainWindow>
class MainWindow : public QMainWindow {
public:
	void printer();
	void printer(const QString &msg);
};

#endif // MAINWINDOW_H_H_HEAD__FILE__
