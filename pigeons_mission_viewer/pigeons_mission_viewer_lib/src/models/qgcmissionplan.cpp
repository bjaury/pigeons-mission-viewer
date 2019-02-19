#include "qgcmissionplan.h"

namespace pigeons_mission_viewer {
namespace models {



QGCMissionPlan::QGCMissionPlan(QFile &qgcmissionplan)
{

    // Read the file which has the JSON object.

    if(!qgcmissionplan.open(QFile::ReadOnly)){
        qDebug("Error, Cannot open the file.");
        //return false;
    }

    QJsonDocument jsonDoc = QJsonDocument::fromJson(qgcmissionplan.readAll());
    qDebug("Successfully loaded qgcMissionPlan!");
   // qDebug() << jsonDoc.object().value("items").toArray()[0].toObject().value("contentDetails").toObject().value("duration").toString();

}
}}
