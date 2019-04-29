#ifndef XBEECONTROLLER_H
#define XBEECONTROLLER_H

#include <QObject>
#include <QString>
#include <QDebug>
#include <string.h>
#include <xbeep.h>
#include "connectioncb.h"

#include <pigeons_mission_viewer_lib_global.h>

#define DEVICE_REV "xbee3"

namespace pigeons_mission_viewer {
namespace xbee {

class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT XbeeController : public QObject
{
    Q_OBJECT

public:
    explicit XbeeController(QObject* parent = nullptr) : QObject(parent)
    {

        memset(&address, 0, sizeof(address));
        address.addr64_enabled = 1;

        address.addr64[0] = 0x00;
        address.addr64[1] = 0x13;
        address.addr64[2] = 0xA2;
        address.addr64[3] = 0x00;
        address.addr64[4] = 0x41;
        address.addr64[5] = 0x7E;
        address.addr64[6] = 0x33;
        address.addr64[7] = 0x74;
    }

    Q_INVOKABLE void openXbeeConnection(QString port, int bRate, QString deviceAddr);
    Q_INVOKABLE void sendXbeeMessage(QString message);
    Q_INVOKABLE void closeXbeeConnection();


private:
    QString portName;
    int baudRate;
    struct xbee_conAddress address;
    libxbee::XBee* xbee;
    connectionCB* con;
};

}}

#endif // XBEECONTROLLER_H
