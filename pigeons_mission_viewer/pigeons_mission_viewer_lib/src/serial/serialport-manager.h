//https://github.com/Eksapsy/Vide
#ifndef SERIALPORTMANAGER_H
#define SERIALPORTMANAGER_H

#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QByteArray>
#include <QtGlobal>
#include <QDebug>
#include <QQmlListProperty>
#include <QVariant>
#include <QTextStream>
#include <QTimer>
#include <pigeons_mission_viewer_lib_global.h>


namespace pigeons_mission_viewer {
namespace serial {

class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT SerialPortManager : public QObject
{    
    Q_OBJECT
    Q_PROPERTY(QString lastBytesRead READ lastBytesRead NOTIFY dataRead)

public:
    struct SerialSettings {
        QString name;
        qint32 baudRate;
        QString stringBaudRate;
        QSerialPort::DataBits dataBits;
        QString stringDataBits;
        QSerialPort::Parity parity;
        QString stringParity;
        QSerialPort::StopBits stopBits;
        QString stringStopBits;
        QSerialPort::FlowControl flowControl;
        QString stringFlowControl;
    };

    explicit SerialPortManager(QObject *parent = nullptr);
    ~SerialPortManager();

    struct SerialSettings currentSettings() const;
    QString lastBytesRead() const;
    void write(const QByteArray &writeData);
    Q_INVOKABLE QVariant availablePorts();
    Q_INVOKABLE QVariant availableBaudRates();
    Q_INVOKABLE QString getLastBytesRead();


signals:

public slots:
    Q_INVOKABLE void openSerialPort();
    Q_INVOKABLE void closeSerialPort();
    Q_INVOKABLE void updateSettings(QString portName, QString baudRate, QString dataBits, qint32  parity, qint32 stopBits, qint32 flowControl);

private slots:
    Q_INVOKABLE void readData();

    /* ONLY FOR DEBUGGING - DELETE AFTER STABLE */
    void logData();
    void handleReadyRead();
    void handleBytesWritten(qint64 bytes);
    void handleTimeout();
    void handleError(QSerialPort::SerialPortError error);

signals:
    void connected();
    void disconnected();
    void dataRead();
    void settingsChanged();
private:
    QSerialPort *m_serial = nullptr;
    struct SerialSettings m_currentSettings;
    QString m_lastBytesRead;
    QByteArray m_readData;
    QByteArray m_writeData;
    qint64 m_bytesWritten = 0;
    QTextStream m_standardOutput;
    QTimer m_timer;
};

}}

#endif // SERIALPORTMANAGER_H
