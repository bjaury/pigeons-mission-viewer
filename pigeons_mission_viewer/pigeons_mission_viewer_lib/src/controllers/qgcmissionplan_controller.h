#ifndef QGCMISSIONPLAN_CONTROLLER_H
#define QGCMISSIONPLAN_CONTROLLER_H

#include <QObject>
#include <pigeons_mission_viewer_lib_global.h>

namespace pigeons_mission_viewer {
namespace controllers {


class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT QGCMissionPlanController: public QObject
{

    Q_OBJECT

public:
    explicit QGCMissionPlanController(QObject* parent = nullptr);
};

}
}

#endif // QGCMISSIONPLAN_CONTROLLER_H
