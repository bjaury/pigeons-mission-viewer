#-------------------------------------------------
#
# Project created by QtCreator 2019-01-16T03:30:13
#
#-------------------------------------------------

QT -= gui
QT += qml
QT += serialport

TARGET = pigeons_mission_viewer_lib
TEMPLATE = lib

CONFIG += c++14

DEFINES += PIGEONS_MISSION_VIEWER_LIB_LIBRARY

include(../qmake-target-platform.pri)
include(../qmake-destination-path.pri)

INCLUDEPATH += src

SOURCES += src/models/client.cpp \
    src/models/qgcmissionplan.cpp \
    src/controllers/master-controller.cpp \
    src/controllers/qgcmissionplan_controller.cpp \
    src/controllers/communication_controller.cpp \
    src/data/data-decorator.cpp \
    src/data/string-decorator.cpp \
    src/data/int-decorator.cpp \
    src/data/datetime-decorator.cpp \
    src/data/enumerator-decorator.cpp \
    src/data/entity.cpp \
    src/xbee/xbee-controller.cpp \
    src/xbee/qtxb.cpp \
    src/serial/serialport-manager.cpp \
    src/qtxb/atcommand.cpp \
    src/qtxb/atcommandqueueparam.cpp \
    src/qtxb/atcommandremote.cpp \
    src/qtxb/atcommandresponse.cpp \
    src/qtxb/digimeshpacket.cpp \
    src/qtxb/modemstatus.cpp \
    src/qtxb/nodeidentificationindicator.cpp \
    src/qtxb/remotecommandrequest.cpp \
    src/qtxb/remotecommandresponse.cpp \
    src/qtxb/rxindicator.cpp \
    src/qtxb/rxindicatorexplicit.cpp \
    src/qtxb/transmitstatus.cpp \
    src/qtxb/txrequest.cpp \
    src/qtxb/txrequestexplicit.cpp \

HEADERS += src/pigeons_mission_viewer_lib_global.h \
    src/models/client.h \
    src/models/qgcmissionplan.h \
    src/controllers/master-controller.h \
    src/controllers/navigation-controller.h \
    src/controllers/qgcmissionplan_controller.h \
    src/controllers/communication_controller.h \
    src/data/data-decorator.h \
    src/data/datetime-decorator.h \
    src/data/entity.h \
    src/data/entity-collection.h \
    src/data/enumerator-decorator.h \
    src/data/int-decorator.h \
    src/data/string-decorator.h \
    src/xbee/xbee-controller.h \
    src/xbee/qtxb.h \
    src/serial/serialport-manager.h \
    src/qtxb/atcommand.h \
    src/qtxb/atcommandqueueparam.h \
    src/qtxb/atcommandremote.h \
    src/qtxb/atcommandresponse.h \
    src/qtxb/digimeshpacket.h \
    src/qtxb/modemstatus.h \
    src/qtxb/nodeidentificationindicator.h \
    src/qtxb/remotecommandrequest.h \
    src/qtxb/remotecommandresponse.h \
    src/qtxb/rxindicator.h \
    src/qtxb/rxindicatorexplicit.h \
    src/qtxb/transmitstatus.h \
    src/qtxb/txrequest.h \
    src/qtxb/txrequestexplicit.h


message(pigeons_mission_viewer_lib project dir: $${PWD})

DESTDIR = $$PWD/../binaries/$$DESTINATION_PATH
OBJECTS_DIR = $$PWD/build/$$DESTINATION_PATH/.obj
MOC_DIR = $$PWD/build/$$DESTINATION_PATH/.moc
RCC_DIR = $$PWD/build/$$DESTINATION_PATH/.qrc
UI_DIR = $$PWD/build/$$DESTINATION_PATH/.ui
message(pigeons_mission_viewer_lib output dir: $${DESTDIR})

DISTFILES += \
    src/data/missionviewermodel.qmodel
