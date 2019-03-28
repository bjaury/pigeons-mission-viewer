TEMPLATE = subdirs

SUBDIRS += \
    pigeons_mission_viewer_ui \
    pigeons_mission_viewer_lib \
    pigeons_mission_viewer_tests

message(pigeons_mission_viewer project dir: $${PWD})

ARCGIS_RUNTIME_VERSION = 100.4
include($$PWD/arcgisruntime.pri)
