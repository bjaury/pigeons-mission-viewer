#-------------------------------------------------
#
# Project created by QtCreator 2019-01-16T03:30:13
#
#-------------------------------------------------

QT       -= gui

TARGET = pigeons_mission_viewer_lib
TEMPLATE = lib

CONFIG += c++14

DEFINES += PIGEONS_MISSION_VIEWER_LIB_LIBRARY

INCLUDEPATH += src

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += src/models/client.cpp \
    src/controllers/master-controller.cpp

HEADERS += src/models/client.h \
        src/pigeons_mission_viewer_lib_global.h \
    src/controllers/master-controller.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}
