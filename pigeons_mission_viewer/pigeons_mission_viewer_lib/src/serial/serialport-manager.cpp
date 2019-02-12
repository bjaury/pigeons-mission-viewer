//https://github.com/Eksapsy/Vide
#include "serialport-manager.h"
#include <QCoreApplication>

namespace pigeons_mission_viewer {
namespace serial{

SerialPortManager::SerialPortManager(QObject *parent) : QObject(parent) {
    m_serial = new QSerialPort(this);

    connect(m_serial, &QSerialPort::readyRead, this, &SerialPortManager::handleReadyRead);
    connect(m_serial, &QSerialPort::errorOccurred, this, &SerialPortManager::handleError);
    connect(&m_timer, &QTimer::timeout, this, &SerialPortManager::handleTimeout);

    m_timer.start(5000);
}

SerialPortManager::~SerialPortManager() {

}

void SerialPortManager::openSerialPort() {

    try {
        m_serial->setPortName(m_currentSettings.name);
        m_serial->setBaudRate(m_currentSettings.baudRate);
        m_serial->setDataBits(m_currentSettings.dataBits);
        m_serial->setParity(m_currentSettings.parity);
        m_serial->setStopBits(m_currentSettings.stopBits);
        m_serial->setFlowControl(m_currentSettings.flowControl);


    } catch(...) {
        qFatal("Error while trying to open a serial port.");
    }

    if (!m_serial->open(QIODevice::ReadOnly)) {
        //        qFatal("Couldn't open serial port.");
        qDebug("Couldn't open serial port.");
        qDebug() << m_serial->errorString();
        return;
    }
    qDebug() << "\n\nOpened Serial Port!\n\n";
    emit connected();
}

void SerialPortManager::closeSerialPort() {
    if (m_serial->isOpen()) {
        m_serial->close();
        qDebug() << "\n\nClosed Serial Port!\n\n";
        emit disconnected();
    }
}

QVariant SerialPortManager::availablePorts() {
    QList<QSerialPortInfo> portsAvailable = QSerialPortInfo::availablePorts();
    QStringList names_PortsAvailable;
    for(const QSerialPortInfo& portInfo : portsAvailable) {
        names_PortsAvailable<<portInfo.portName();
    }
    return QVariant::fromValue(names_PortsAvailable);
}

QVariant SerialPortManager::availableBaudRates() {
    QStringList string_baudRates;
    for(const qint32 baudrate : QSerialPortInfo::standardBaudRates()) {
        string_baudRates.append(QString::number(baudrate));
    }

    return QVariant::fromValue(string_baudRates);
}

void SerialPortManager::handleReadyRead()
{
    m_readData.append(m_serial->readAll());

    if (!m_timer.isActive())
        m_timer.start(5000);
}

void SerialPortManager::handleTimeout()
{
    //if(!m_serial->portName().compare("")){

        if (m_readData.isEmpty()) {
            qDebug() << QObject::tr("%1: Heartbeat from port %2")
                        .arg(QDateTime::currentDateTime().toString("hh:mm:ss")).arg(m_serial->portName())
                     << endl;
        } else {
            qDebug() << QObject::tr("Data successfully received from port %1")
                                .arg(m_serial->portName())
                             << endl;
            qDebug() << m_readData << endl;
        }



}


void SerialPortManager::updateSettings(QString portName, QString baudRate, QString dataBits, qint32 parity, qint32 stopBits, qint32 flowControl) {
    qDebug() << "\n\t\tSettings Changed !\n";
    qDebug() << "Current Settings: "
             << "\n\tportName "    << portName
             << "\n\tbaudRate "    << static_cast<QSerialPort::BaudRate>(baudRate.toInt())
             << "\n\tdataBits "    << static_cast<QSerialPort::DataBits>(dataBits.toInt())
             << "\n\tparity "      << static_cast<QSerialPort::Parity>(parity)
             << "\n\tstopBits "    << static_cast<QSerialPort::StopBits>(stopBits)
             << "\n\tflowControl " << static_cast<QSerialPort::FlowControl>(flowControl);

    m_currentSettings.name        = portName;
    m_currentSettings.baudRate    = static_cast<QSerialPort::BaudRate>(baudRate.toInt());
    m_currentSettings.dataBits    = static_cast<QSerialPort::DataBits>(dataBits.toInt());
    m_currentSettings.parity      = static_cast<QSerialPort::Parity>(parity);
    m_currentSettings.stopBits    = static_cast<QSerialPort::StopBits>(stopBits);
    m_currentSettings.flowControl = static_cast<QSerialPort::FlowControl>(flowControl);
}

SerialPortManager::SerialSettings SerialPortManager::currentSettings() const {
    return m_currentSettings;
}

void SerialPortManager::handleError(QSerialPort::SerialPortError serialPortError)
{
    if (serialPortError == QSerialPort::ReadError) {
        qDebug() << QObject::tr("An I/O error occurred while reading "
                                        "the data from port %1, error: %2")
                            .arg(m_serial->portName())
                            .arg(m_serial->errorString())
                         << endl;
        QCoreApplication::exit(1);
    }
}

}};
