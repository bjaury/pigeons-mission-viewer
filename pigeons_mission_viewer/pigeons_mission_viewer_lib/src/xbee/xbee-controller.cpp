#include "xbee-controller.h"

namespace pigeons_mission_viewer {
namespace xbee {

//XbeeController* g_xbeeController_ptr = nullptr;


//void wrapReceivedDataCallback(struct xbee *xbee, struct xbee_con *con, struct xbee_pkt **pkt, void **data)
//{
//    qDebug() << "In Wrap Received Data Callback!" << endl;

//    if (g_xbeeController_ptr)
//        g_xbeeController_ptr->receivedDataCallback(xbee, con, pkt, data);
//}


//XbeeController::XbeeController(QObject *parent) : QObject(parent)
//{
//    //g_xbeeController_ptr = nullptr;
//    //xbee(NULL);

////    xbee;
////    connectionCB = NULL;



//    //connect(&m_cbTimer, &QTimer::timeout, this, &XbeeController::handleCBTimeout);
//}


void XbeeController::XbeeController::openXbeeConnection(QString port, int bRate, QString deviceAddr)
{
    baudRate = bRate;
    portName = "/dev/" + port;

    qDebug() << "Port name is " << portName << endl;

    qDebug() << "Need to implement deviceAddr" << deviceAddr << endl;

//    //if ((ret = xbee_setup(&xbee, DEVICE_REV, portName.data(), baudRate)) != XBEE_ENONE) {
//    if ((ret = xbee_setup(&xbee, "xbee3", "/dev/ttyUSB0", 9600)) != XBEE_ENONE) {
//        qDebug() << "ret: " << ret << " " << xbee_errorToStr(ret)<<endl;
//        return ret;
//    }

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

    xbee = new libxbee::XBee(DEVICE_REV, "/dev/ttyUSB0", 9600);
    con = new connectionCB(*xbee, "Data", &address);


//    if ((ret = xbee_conNew(xbee, &con, "Data", &address)) != XBEE_ENONE) {
//        xbee_log(xbee, -1, "xbee_conNew() returned: %d (%s)", ret, xbee_errorToStr(ret));
//        return ret;
//    }

//    if ((ret = xbee_conDataSet(con, xbee, NULL)) != XBEE_ENONE) {
//        xbee_log(xbee, -1, "xbee_conDataSet() returned: %d", ret);
//        return ret;
//    }

//    if ((ret = xbee_conCallbackSet(con, wrapReceivedDataCallback, NULL)) != XBEE_ENONE) {
//        xbee_log(xbee, -1, "xbee_conCallbackSet() returned: %d", ret);
//        return ret;
//    }

//    qDebug() << "Handle CBTimout Started" << endl;
//    m_cbTimer.start(1000);


//    if ((ret = xbee_conEnd(con)) != XBEE_ENONE) {
//        xbee_log(xbee, -1, "xbee_conEnd() returned: %d", ret);
//        return ret;
//    }

//    xbee_shutdown(xbee);

}

//void XbeeController::XbeeController::handleCBTimeout()
//{
//    void *p;

//    if ((ret = xbee_conCallbackGet(con, (xbee_t_conCallback*)&p)) != XBEE_ENONE) {
//        xbee_log(xbee, -1, "xbee_conCallbackGet() returned: %d", ret);
//        qDebug() << "cb ret: " << ret << endl;
//        //return ret;
//    }

//    if (p == NULL) m_cbTimer.stop();

//}

void XbeeController::XbeeController::sendXbeeMessage(QString message)
{
    con << message.toLocal8Bit().data();
}

void XbeeController::XbeeController::closeXbeeConnection()
{

}

//void XbeeController::XbeeController::receivedDataCallback(struct xbee *xbee, struct xbee_con *con, struct xbee_pkt **pkt, void **data)
//{
//    qDebug() << "In Received Data Callback!" << endl;


//    if ((*pkt)->dataLen > 0) {
//        if ((*pkt)->data[0] == '@') {
//            xbee_conCallbackSet(con, NULL, NULL);
//            qDebug() << "*** DISABLED CALLBACK... ***\n" << endl;;
//        }
//        // printf << "rx: [%s]\n" << (*pkt)->data << endl;
//        QString dataReceived( reinterpret_cast< char* >( (*pkt)->data ) );
//        qDebug() << dataReceived << endl;
//        //printf("reeex: [%s]\n", (*pkt)->data);

//        // qDebug() << "come'on rx: [%s]\n" << (*pkt)->dataItems << endl;

//    }
//    qDebug() << "tx: %d\n" << xbee_conTx(con, NULL, "Hello\r\n") << endl;
//}



}};
