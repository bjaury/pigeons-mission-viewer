QT += qml quick location sensors positioning

TEMPLATE = app

CONFIG += c++14

include(../qmake-target-platform.pri)
include(../qmake-destination-path.pri)
ARCGIS_RUNTIME_VERSION = 100.4
include(../arcgisruntime.pri)

#ARCGIS_RUNTIME_VERSION = 100.4
#include($$PWD/arcgisruntime.pri)

INCLUDEPATH += src \
    ../pigeons_mission_viewer_lib/src



SOURCES += src/main.cpp

RESOURCES += views.qrc js.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD

LIBS += -L$$PWD/../binaries/$$DESTINATION_PATH -lpigeons_mission_viewer_lib


#LIBS += -L$$PWD/../binaries/$$DESTINATION_PATH -LC:/OpenSSL-Win64/lib \
#-lpigeons_mission_viewer_lib \
#-lopenssl




DESTDIR = $$PWD/../binaries/$$DESTINATION_PATH
OBJECTS_DIR = $$PWD/build/$$DESTINATION_PATH/.obj
MOC_DIR = $$PWD/build/$$DESTINATION_PATH/.moc
RCC_DIR = $$PWD/build/$$DESTINATION_PATH/.qrc
UI_DIR = $$PWD/build/$$DESTINATION_PATH/.ui

DISTFILES += js/calculations.js
