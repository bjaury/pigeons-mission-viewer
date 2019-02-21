#include "controllers/qgcmissionplan_controller.h"

namespace pigeons_mission_viewer {
namespace controllers {



QGCMissionPlanController::QGCMissionPlanController(QObject *parent) : QObject (parent)
{

}

void QGCMissionPlanController::openQGCMissionPlan(const QString qgcmpPath)
{
    QFile testFile(qgcmpPath);

    //models::QGCMissionPlan qgcmissionplan = new models::QGCMissionPlan(testFile);
    models::QGCMissionPlan qgcmissionplan(testFile);

}
}};
