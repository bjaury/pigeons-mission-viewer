#ifndef XBEECONTROLLER_H
#define XBEECONTROLLER_H

#include <QObject>
#include <QScopedPointer>
#include <QString>
#include <xbeep.h>
#include <QDebug>
#include <QThread>
#include <string.h>

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
    explicit XbeeController(QObject* parent = nullptr);
    //~XbeeController();
    Q_INVOKABLE int openXbeeConnection(QString port, int bRate, QString deviceAddr);
    Q_INVOKABLE int sendXbeeMessage(QString message);
    Q_INVOKABLE int closeXbeeConnection();
    void receivedDataCallback(struct xbee *xbee, struct xbee_con *con, struct xbee_pkt **pkt, void **data);

private:
    void *d;
    struct xbee *xbee;
    struct xbee_con *con;
    struct xbee_conAddress address;
    unsigned char txRet;
    xbee_err ret;
    QString portName;
    int baudRate;

};

}}

#endif // XBEECONTROLLER_H
