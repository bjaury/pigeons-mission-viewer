#ifndef COMMUNICATION_CONTROLLER_H
#define COMMUNICATION_CONTROLLER_H

#include <QObject>
#include <QByteArray>
#include <pigeons_mission_viewer_lib_global.h>
#include <serial/serialport-manager.h>



namespace pigeons_mission_viewer {
namespace controllers {


class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT CommunicationController : public QObject
{
    Q_OBJECT

public:
    explicit CommunicationController(pigeons_mission_viewer::serial::SerialPortManager& serialMng, QObject* parent = nullptr);
    explicit CommunicationController(QObject* parent = nullptr);
    //~CommunicationController();

public slots:
    void onReceivedData(const QByteArray& msg);

private:
   pigeons_mission_viewer::serial::SerialPortManager& _serialPortManager;
};
}
}

#endif // COMMUNICATION_CONTROLLER_H
