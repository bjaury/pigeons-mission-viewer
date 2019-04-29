#include "connectioncb.h"

namespace pigeons_mission_viewer {
namespace xbee {


void connectionCB::connectionCB::xbee_conCallback(libxbee::Pkt **pkt)
{
    qDebug() << "Callback!!\n";
    int i;
    for (i = 0; i < (*pkt)->size(); i++) {
        //rqDebug() << (**pkt)[i];
        myData.append((**pkt)[i]);
    }

    qDebug() << myData;
    qDebug() << "\n";

    myData.clear();


    /* if you want to keep the packet, then you MUST do the following:
                  libxbee::Pkt *myhandle = *pkt;
                  *pkt = NULL;
               and then later, you MUST delete the packet to free up the memory:
                  delete myhandle;
               if you do not want to keep the packet, then just leave everything as-is, and it will be free'd for you */
}



}};
