#include "xbee-controller.h"

namespace pigeons_mission_viewer {
namespace xbee {


XbeeController::XbeeController(controllers::CommunicationController* messageParser, QObject* parent) : QObject(parent)
{
    memset(&address, 0, sizeof(address));
    address.addr64_enabled = 1;

    connect(con, &xbee::connectionCB::receivedNewMessage, messageParser, &controllers::CommunicationController::receivedNewMessage);
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

}};
