//Purpose of this class is to be an intermidatary between serial port manager receiving messages and PIGEONS_MISSION_MODEL receiving messages


#include "controllers/communication_controller.h"


namespace pigeons_mission_viewer {
namespace controllers {

CommunicationController::CommunicationController(QObject *parent) : QObject (parent)
{

    qDebug() << "communicaitonsController Alive!" <<endl;
}

CommunicationController::~CommunicationController() {

}



void CommunicationController::receivedNewMessage(const QString &msg)
{
    qDebug() << "TBD: Implement receiveMessageHandler." << endl;
    qDebug() << "Messaged Received from serialPort: " << msg << endl;
}
}};







