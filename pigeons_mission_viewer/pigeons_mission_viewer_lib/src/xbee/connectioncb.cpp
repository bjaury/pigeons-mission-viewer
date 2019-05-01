#include "connectioncb.h"

namespace pigeons_mission_viewer {
namespace xbee {


void connectionCB::connectionCB::xbee_conCallback(libxbee::Pkt **pkt)
{
    //qDebug() << "Callback!!\n";
    int i;
    for (i = 0; i < (*pkt)->size(); i++) {
        //rqDebug() << (**pkt)[i];
        myData.append((**pkt)[i]);
    }

    //qDebug() << myData;
    //qDebug() << "\n";

    emit receivedNewMessage(myData);

    myData.clear();

}

QString connectionCB::connectionCB::getNewData()
{
    return myData;
}
}};
