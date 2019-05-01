#ifndef COMMUNICATION_CONTROLLER_H
#define COMMUNICATION_CONTROLLER_H

#include <QObject>
#include <QByteArray>
#include <pigeons_mission_viewer_lib_global.h>
#include <QDebug>

#define INDENTIFIER_VOR "\"Mission\": \"vor\""
#define INDENTIFIER_ILS "\"Mission\": \"ils\""
#define INDENTIFIER_CONNECTION_START "Air Accept Connection Request"
#define INDENTIFIER_CONNECTION_TERMINATION "Terminating connection."

namespace pigeons_mission_viewer {
namespace controllers {

class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT CommunicationController : public QObject
{
    Q_OBJECT

public:
    explicit CommunicationController(QObject* parent = nullptr);
    ~CommunicationController();

    Q_PROPERTY(QString newPoint
               READ newPoint
               WRITE addNewPoint
               NOTIFY newPointAdded)

    Q_PROPERTY(QString connectionStatus
               READ connectionStatus
               WRITE setConnectionStatus
               NOTIFY connectionStatusChanged)

    QString newPoint() { return mNewPoint; }
     QString connectionStatus() { return mConnectionStatus; }

public slots:
    void receivedNewMessage(const QString& msg);

private slots:
    void addNewPoint(const QString& newPoint) { mNewPoint = newPoint; }
    void setConnectionStatus(const QString& connectionStatus) { mConnectionStatus = connectionStatus; }


signals:
    void newPointAdded(const QString newPoint);
    void connectionStatusChanged(const QString connectionStatus);


private:
    void parseMessage(const QString &msg);

    QString mNewPoint;
    QString mConnectionStatus;

};
}
}

#endif // COMMUNICATION_CONTROLLER_H
