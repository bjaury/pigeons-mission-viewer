//Purpose of this class is to be an intermidatary between serial port manager receiving messages and PIGEONS_MISSION_MODEL receiving messages


#include "controllers/communication_controller.h"


namespace pigeons_mission_viewer {
namespace controllers {

CommunicationController::CommunicationController(QObject *parent) : QObject (parent)
{

    //qDebug() << "communicaitonsController Alive!" <<endl;
}

CommunicationController::~CommunicationController() {

}



void CommunicationController::receivedNewMessage(const QString &msg)
{
    parseMessage(msg);
}

void CommunicationController::parseMessage(const QString &msg)
{
    QString message = msg;

    //qDebug() << "Checking if message VOR Point" <<  message.indexOf() << endl;

    if(message.indexOf(INDENTIFIER_VOR) || INDENTIFIER_ILS){
        addNewPoint("["+msg+"]");
        emit newPointAdded(msg);
    }


}
}};







