#ifndef CONNECTIONCB_H
#define CONNECTIONCB_H
#include <xbeep.h>
#include <QString>
#include <QDebug>
#include <QObject>
#include <controllers/communication_controller.h>

#include <pigeons_mission_viewer_lib_global.h>

namespace pigeons_mission_viewer {
namespace xbee {


class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT connectionCB: public libxbee::ConCallback
{
Q_OBJECT

public:    
    explicit connectionCB (libxbee::XBee &parent, std::string type, struct xbee_conAddress *address = NULL): libxbee::ConCallback(parent, type, address){};
    //explicit connectionCB();




    void xbee_conCallback(libxbee::Pkt **pkt);
    QString myData;

    connectionCB* getConnectionCB(){return this;}

signals:
    void receivedNewMessage(QString newMessage);
};

}}
#endif // CONNECTIONCB_H
