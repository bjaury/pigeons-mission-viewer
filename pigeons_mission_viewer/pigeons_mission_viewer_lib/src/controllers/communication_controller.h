#ifndef COMMUNICATION_CONTROLLER_H
#define COMMUNICATION_CONTROLLER_H

#include <QObject>
#include <QByteArray>
#include <pigeons_mission_viewer_lib_global.h>
#include <QDebug>

#define INDENTIFIER_VOR "\"Mission\": \"vor\""
#define INDENTIFIER_ILS "\"Mission\": \"ils\""

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

    QString newPoint() { return mNewPoint; }

public slots:
    void receivedNewMessage(const QString& msg);
private slots:
    void addNewPoint(const QString& newPoint) { mNewPoint.clear(); mNewPoint.append(newPoint); }

signals:
    void newPointAdded(const QString newPoint);

private:
    void parseMessage(const QString &msg);

    QString mNewPoint;

};
}
}

#endif // COMMUNICATION_CONTROLLER_H
