#ifndef XBEECONTROLLER_H
#define XBEECONTROLLER_H

#include <QObject>
#include <QScopedPointer>
#include <QString>

#include <pigeons_mission_viewer_lib_global.h>

namespace pigeons_mission_viewer {
namespace xbee {


class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT XbeeController : public QObject
{
    Q_OBJECT

    //Q_PROPERTY( QString ui_welcomeMessage READ welcomeMessage CONSTANT )
    //Q_PROPERTY( pigeons_mission_viewer::controllers::NavigationController* ui_navigationController READ navigationController CONSTANT )


public:
    explicit XbeeController(QObject* parent = nullptr);
    ~XbeeController();

private:
    class Implementation;
    QScopedPointer<Implementation> implementation;

};

}}

#endif // XBEECONTROLLER_H
