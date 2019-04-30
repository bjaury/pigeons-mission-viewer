#ifndef XBEECONTROLLER_H
#define XBEECONTROLLER_H

#include <QObject>
#include <QString>
#include <QDebug>
#include <string.h>
#include <xbeep.h>
#include "connectioncb.h"
#include "controllers/communication_controller.h"

#include <pigeons_mission_viewer_lib_global.h>

#define DEVICE_REV "xbee3"

namespace pigeons_mission_viewer {
namespace xbee {

class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT XbeeController : public QObject
{
    Q_OBJECT

public:
    explicit XbeeController(controllers::CommunicationController* messageParser = nullptr,QObject* parent = nullptr);


    Q_INVOKABLE void openXbeeConnection(QString port, int bRate, QString deviceAddr);
    Q_INVOKABLE void sendXbeeMessage(QString message);
    Q_INVOKABLE void closeXbeeConnection();


private:
    void setXBeeDeviceAddress(QString addr);

    std::string portName;
    int baudRate;
    QString deviceAddress;
    struct xbee_conAddress address;
    libxbee::XBee* xbee;
    connectionCB* con;
};

}}

#endif // XBEECONTROLLER_H
