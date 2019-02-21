#ifndef QGCMISSIONPLAN_H
#define QGCMISSIONPLAN_H

#include <QObject>
#include <QFile>
#include <QCoreApplication>
#include <QJsonDocument>
#include <QJsonValue>
#include <QJsonArray>
#include <QJsonObject>
#include <pigeons_mission_viewer_lib_global.h>



namespace pigeons_mission_viewer {
namespace models {

class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT QGCMissionPlan : public QObject
{

Q_OBJECT

public:
    explicit QGCMissionPlan(QFile &qgcmissionplan);
    //~QGCMissionPlan();
};
}}
#endif // QGCMISSIONPLAN_H



