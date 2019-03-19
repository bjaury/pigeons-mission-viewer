//Purpose of this class is to be an intermidatary between serial port manager receiving messages and PIGEONS_MISSION_MODEL receiving messages


#include "controllers/communication_controller.h"


namespace pigeons_mission_viewer {
namespace controllers {

CommunicationController::CommunicationController(QObject *parent) : QObject (parent)
{
//    bool success = connect(&_serialPortManager, &pigeons_mission_viewer::serial::SerialPortManager::receivedData, this, &CommunicationController::onReceivedData);
    //    bool success = connect(&_serialPortManager, SIGNAL(receivedData(QByteArray)), this, SLOT(onReceivedData(QByteArray)));
//    Q_ASSERT(success);
//    qDebug() << "Communications Controller Constructed Serial Manager: " << serialMng.metaObject() << endl;
}

CommunicationController::~CommunicationController() {

}

//CommunicationController::CommunicationController(QObject *parent) : QObject (parent)
//{
//}

void CommunicationController::onReceivedData(const QByteArray &msg)
{
    qDebug() << "TBD: Implement receiveMessageHandler." << endl;
    qDebug() << "Messaged Received from serialPort: " << msg << endl;
}
}};

//connect(m_serial, &QSerialPort::bytesWritten, this, &SerialPortManager::handleBytesWritten);






