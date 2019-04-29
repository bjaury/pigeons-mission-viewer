#ifndef XBEECONTROLLER_H
#define XBEECONTROLLER_H

#include <QObject>
#include <QScopedPointer>
#include <QString>
#include <xbeep.h>
#include "connectioncb.h"
#include <QDebug>
#include <QThread>
#include <string.h>
#include <QTimer>

#include <pigeons_mission_viewer_lib_global.h>

#define DEVICE_REV "xbee3"

namespace pigeons_mission_viewer {
namespace xbee {

//void wrapReceivedDataCallback(struct xbee *xbee, struct xbee_con *con, struct xbee_pkt **pkt, void **data);

class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT XbeeController : public QObject
{
    Q_OBJECT

    //Q_PROPERTY( QString ui_welcomeMessage READ welcomeMessage CONSTANT )
    //Q_PROPERTY( pigeons_mission_viewer::controllers::NavigationController* ui_navigationController READ navigationController CONSTANT )


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
    //~XbeeController();
    Q_INVOKABLE void openXbeeConnection(QString port, int bRate, QString deviceAddr);
    Q_INVOKABLE void sendXbeeMessage(QString message);
    Q_INVOKABLE void closeXbeeConnection();
    //    void receivedDataCallback(struct xbee *xbee, struct xbee_con *con, struct xbee_pkt **pkt, void **data);

private slots:
    //    void handleCBTimeout();

private:
    //    void *d;
    //    struct xbee *xbee;
    //    struct xbee_con *con;
    struct xbee_conAddress address;

    //    unsigned char txRet;
    //    xbee_err ret;
    QString portName;
    int baudRate;

    libxbee::XBee* xbee;
    connectionCB* con;
    //libxbee::XBee xbee();
    //connectionCB con();
    //    QTimer m_cbTimer;

};

}}

#endif // XBEECONTROLLER_H
