#ifndef NAVIGATIONCONTROLLER_H
#define NAVIGATIONCONTROLLER_H

#include <QObject>

#include <pigeons_mission_viewer_lib_global.h>

namespace pigeons_mission_viewer {
namespace controllers {

class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT NavigationController : public QObject
{
    Q_OBJECT

public:
    explicit NavigationController(QObject* parent = nullptr) : QObject(parent){}

signals:
    void goCreateClientView();
    void goDashboardView();
    void goFindClientView();

    void goStartView();
    void goRemoteVehicleConnectionSettingsView();
    void goMissionPlanUploadView();
    void goMissionTypeSelectionView();
    void goLiveMissionSettingsConfirmationView();
    void goLiveMissionMapView();
    void goRecordedMissionLogUploadView();
    void goRecordedMissionMapView();
};

}
}

#endif
