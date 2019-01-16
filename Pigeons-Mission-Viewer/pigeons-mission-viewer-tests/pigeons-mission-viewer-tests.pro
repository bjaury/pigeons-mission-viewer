QT += testlib
QT -= gui

TARGET = client-tests
TEMPLATE = app

CONFIG += c++14
CONFIG += console
CONFIG -= app_bundle
CONFIG += qt warn_on depend_includepath testcase

INCLUDEPATH += src

SOURCES +=  src/models/tst_clienttests.cpp
