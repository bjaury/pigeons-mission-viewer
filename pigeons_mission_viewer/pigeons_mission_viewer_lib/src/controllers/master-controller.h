#ifndef MASTERCONTROLLER_H
#define MASTERCONTROLLER_H

#include <QObject>
#include <QScopedPointer>
#include <QString>

#include <pigeons_mission_viewer_lib_global.h>
#include <controllers/navigation-controller.h>

namespace pigeons_mission_viewer {
namespace controllers {


class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT MasterController : public QObject
{
    Q_OBJECT

    Q_PROPERTY( QString ui_welcomeMessage READ welcomeMessage CONSTANT )
    Q_PROPERTY( pigeons_mission_viewer::controllers::NavigationController* ui_navigationController READ navigationController CONSTANT )


public:
    explicit MasterController(QObject* parent = nullptr);
    ~MasterController();

    NavigationController* navigationController();
    const QString& welcomeMessage() const;

private:
    class Implementation;
    QScopedPointer<Implementation> implementation;

};

}}

#endif // MASTERCONTROLLER_H
