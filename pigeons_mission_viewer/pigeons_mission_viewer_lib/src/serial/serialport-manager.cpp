//https://github.com/Eksapsy/Vide
#include "serialport-manager.h"
#include <QCoreApplication>


namespace pigeons_mission_viewer {
namespace serial{

SerialPortManager::SerialPortManager(QObject *parent) : QObject(parent) {
    m_serial = new QSerialPort(this);

    connect(m_serial, &QSerialPort::readyRead, this, &SerialPortManager::readData);
    connect(this, &SerialPortManager::dataRead, this, &SerialPortManager::logData);

    m_timer.setSingleShot(true);

    connect(m_serial, &QSerialPort::readyRead, this, &SerialPortManager::handleReadyRead);
    connect(m_serial, &QSerialPort::errorOccurred, this, &SerialPortManager::handleError);
    connect(&m_timer, &QTimer::timeout, this, &SerialPortManager::handleTimeout);

    connect(m_serial, &QSerialPort::bytesWritten,
            this, &SerialPortManager::handleBytesWritten);
    connect(m_serial, &QSerialPort::errorOccurred,
            this, &SerialPortManager::handleError);
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

QString SerialPortManager::getLastBytesRead() {
    QString lastBytesRead = m_lastBytesRead;
    m_lastBytesRead.clear();
    return lastBytesRead;
}

void SerialPortManager::readData() {
    QByteArray serialData = m_serial->readAll();
    m_lastBytesRead.append(serialData);
    emit dataRead();
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

void SerialPortManager::handleReadyRead()
{
    m_readData.append(m_serial->readAll());

    if (!m_timer.isActive())
        m_timer.start(5000);
}

void SerialPortManager::handleBytesWritten(qint64 bytes)
{
    m_bytesWritten += bytes;
    if (m_bytesWritten == m_writeData.size()) {
        m_bytesWritten = 0;
        m_standardOutput << QObject::tr("Data successfully sent to port %1")
                            .arg(m_serial->portName()) << endl;
        //QCoreApplication::quit();
    }
}

void SerialPortManager::handleTimeout()
{
    if (m_readData.isEmpty()) {
        m_standardOutput << QObject::tr("No data was currently available "
                                        "for reading from port %1")
                            .arg(m_serial->portName())
                         << endl;
    } else {
        m_standardOutput << QObject::tr("Data successfully received from port %1")
                            .arg(m_serial->portName())
                         << endl;
        m_standardOutput << m_readData << endl;
    }

//    m_standardOutput << QObject::tr("Operation timed out for port %1, error: %2")
//                        .arg(m_serial->portName())
//                        .arg(m_serial->errorString())
//                     << endl;

    //QCoreApplication::quit();
    m_standardOutput << QObject::tr("handleTimeout()") << endl;
}

void SerialPortManager::handleError(QSerialPort::SerialPortError serialPortError)
{
    if (serialPortError == QSerialPort::ReadError) {
        m_standardOutput << QObject::tr("An I/O error occurred while reading "
                                        "the data from port %1, error: %2")
                            .arg(m_serial->portName())
                            .arg(m_serial->errorString())
                         << endl;
        QCoreApplication::exit(1);
    }

    if (serialPortError == QSerialPort::WriteError) {
        m_standardOutput << QObject::tr("An I/O error occurred while writing"
                                        " the data to port %1, error: %2")
                            .arg(m_serial->portName())
                            .arg(m_serial->errorString())
                         << endl;
        QCoreApplication::exit(1);
    }
}

void SerialPortManager::write(const QByteArray &writeData)
{
    m_writeData = writeData;

    const qint64 bytesWritten = m_serial->write(writeData);

    if (bytesWritten == -1) {
        m_standardOutput << QObject::tr("Failed to write the data to port %1, error: %2")
                            .arg(m_serial->portName())
                            .arg(m_serial->errorString())
                         << endl;
        QCoreApplication::exit(1);
    } else if (bytesWritten != m_writeData.size()) {
        m_standardOutput << QObject::tr("Failed to write all the data to port %1, error: %2")
                            .arg(m_serial->portName())
                            .arg(m_serial->errorString())
                         << endl;
        QCoreApplication::exit(1);
    }

    m_timer.start(5000);
}

/* ONLY FOR DEBUGGING - DELETE AFTER STABLE */
void SerialPortManager::logData() {
    QDebug deb = qDebug();
    deb.noquote() << getLastBytesRead().replace("\n", "").replace("\r", "");
}

SerialPortManager::SerialSettings SerialPortManager::currentSettings() const {
    return m_currentSettings;
}

QString SerialPortManager::lastBytesRead() const {
    return m_lastBytesRead;
}

}};
