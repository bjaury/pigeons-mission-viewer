#include "xbee-controller.h"

namespace pigeons_mission_viewer {
namespace xbee {


void XbeeController::XbeeController::openXbeeConnection(QString port, int bRate, QString deviceAddr)
{
    baudRate = bRate;
    portName = "/dev/" + port;

    qDebug() << "Port name is " << portName << endl;

    qDebug() << "Need to implement deviceAddr" << deviceAddr << endl;

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
}

void XbeeController::XbeeController::sendXbeeMessage(QString message)
{
    *con << message.toLocal8Bit().data();
}

void XbeeController::XbeeController::closeXbeeConnection()
{
    qDebug() << "closeXbeeConnection not implemented yet" << endl;
}

}};
