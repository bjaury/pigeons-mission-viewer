#ifndef MASTERCONTROLLER_H
#define MASTERCONTROLLER_H
#include <QObject>
#include <QString>
#include <pigeons_mission_viewer_lib_global.h>

namespace pigeons_mission_viewer {
namespace controllers {


class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT MasterController : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QString ui_welcomeMessage MEMBER welcomeMessage CONSTANT )

public:
    explicit MasterController(QObject* parent = nullptr);

    QString welcomeMessage = "This is a MasterController to Major Brian";

};

}}

#endif // MASTERCONTROLLER_H
