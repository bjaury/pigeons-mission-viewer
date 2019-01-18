#QT += testlib
#QT -= gui

#TARGET = client-tests
#TEMPLATE = app

#CONFIG += c++14
#CONFIG += qt console warn_on depend_includepath testcase
#CONFIG += console
#CONFIG -= app_bundle

#include(../qmake-target-platform.pri)
#include(../qmake-destination-path.pri)

#INCLUDEPATH += src

#SOURCES +=  src/models/tst_clienttests.cpp

#LIBS += -L$$PWD/../binaries/$$DESTINATION_PATH -lpigeons_mission_viewer_lib

#DESTDIR = $$PWD/../binaries/$$DESTINATION_PATH
#OBJECTS_DIR = $$PWD/build/$$DESTINATION_PATH/.obj
#MOC_DIR = $$PWD/build/$$DESTINATION_PATH/.moc
#RCC_DIR = $$PWD/build/$$DESTINATION_PATH/.qrc
#UI_DIR = $$PWD/build/$$DESTINATION_PATH/.ui

QT += testlib
QT -= gui

TARGET = client-tests
TEMPLATE = app

CONFIG += c++14
CONFIG += console
CONFIG -= app_bundle

include(../qmake-target-platform.pri)
include(../qmake-destination-path.pri)

INCLUDEPATH += src

SOURCES += src/models/tst_clienttests.cpp

LIBS += -L$$PWD/../binaries/$$DESTINATION_PATH -lpigeons_mission_viewer_lib

DESTDIR = $$PWD/../binaries/$$DESTINATION_PATH
OBJECTS_DIR = $$PWD/build/$$DESTINATION_PATH/.obj
MOC_DIR = $$PWD/build/$$DESTINATION_PATH/.moc
RCC_DIR = $$PWD/build/$$DESTINATION_PATH/.qrc
UI_DIR = $$PWD/build/$$DESTINATION_PATH/.ui
