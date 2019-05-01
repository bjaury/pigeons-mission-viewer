#include "xbee-controller.h"

namespace pigeons_mission_viewer {
namespace xbee {


XbeeController::XbeeController(pigeons_mission_viewer::controllers::CommunicationController* comController, QObject* parent) : QObject(parent)
{

    messageParser = comController;

    memset(&address, 0, sizeof(address));
    address.addr64_enabled = 1;
}

void XbeeController::XbeeController::openXbeeConnection(QString port, int bRate, QString deviceAddr)
{
    portName = ("/dev/" + port).toLocal8Bit().data();
    baudRate = bRate;
    deviceAddress = deviceAddr;

    try {
        setXBeeDeviceAddress(deviceAddress);
        xbee = new libxbee::XBee(DEVICE_REV, portName, baudRate);
        con = new connectionCB(*xbee, "Data", &address);
        connect(con, SIGNAL(receivedNewMessage(const QString&)), messageParser, SLOT(receivedNewMessage(const QString&)));


    } catch (xbee_err e) {
        qDebug() << "Error opeing XBee " << e << endl;
    }

}

void XbeeController::XbeeController::sendXbeeMessage(QString message)
{
    *con << message.toLocal8Bit().data();
}

void XbeeController::XbeeController::closeXbeeConnection()
{
    qDebug() << "closeXbeeConnection not implemented yet" << endl;
}

void XbeeController::XbeeController::setXBeeDeviceAddress(QString addr)
{
    int arrIndex = 0;
    bool ok;

    for(int i = 0; i < 16; i+=2)
    {
        int addrHex = addr.mid(i, 2).toInt(&ok, 16);
        address.addr64[arrIndex] = addrHex;
        arrIndex = arrIndex +1;
    }

}

xbee::connectionCB* XbeeController::XbeeController::getConnectionCB()
{
    return con;
}

}};
