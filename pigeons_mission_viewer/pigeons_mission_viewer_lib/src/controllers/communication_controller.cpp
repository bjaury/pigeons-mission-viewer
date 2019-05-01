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



    if(message.compare(INDENTIFIER_CONNECTION_START) == 0)
    {
        setConnectionStatus("Connected");
    }else if(message.compare(INDENTIFIER_CONNECTION_TERMINATION) == 0){

        setConnectionStatus("Disconnected");


    }else if(message.indexOf(INDENTIFIER_VOR) == 1 || message.indexOf(INDENTIFIER_ILS) == 1){
        addNewPoint("["+msg+"]");
        emit newPointAdded(msg);
    }


}
}};







