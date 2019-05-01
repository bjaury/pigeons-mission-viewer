#ifndef PIGEONS_MISSION_MODEL_H
#define PIGEONS_MISSION_MODEL_H

#include <QObject>
#include <QDebug>

#include <pigeons_mission_viewer_lib_global.h>

namespace pigeons_mission_viewer {
namespace models {


class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT PIGEONSMissionModel : public QObject
{
    Q_OBJECT

public:
    explicit PIGEONSMissionModel(QObject *parent = nullptr);

    Q_PROPERTY(QString missionType
               READ missionType
               WRITE setMissionType
               NOTIFY missionTypeChanged)

    Q_PROPERTY(double ilsFrequency
               READ ilsFrequency
               WRITE setILSFrequency
               NOTIFY ilsFrequencyChanged)

    Q_PROPERTY(double vorFrequency
               READ vorFrequency
               WRITE setVORFrequency
               NOTIFY vorFrequencyChanged)

    Q_PROPERTY(double airportLat
               READ airportLat
               WRITE setAirportLat
               NOTIFY airportLatChanged)

    Q_PROPERTY(double airportLong
               READ airportLong
               WRITE setAirportLong
               NOTIFY airportLongChanged)


    QString missionType() { return mMissionType; }
    double ilsFrequency() { return mILSFrequency; }
    double vorFrequency() { return mVORFrequency; }

    double airportLat() { return mAirportLat ;}
    double airportLong() { return mAirportLong ;}

public slots:
    void setMissionType(const QString& mType) {mMissionType = mType; }
    void setILSFrequency(const double ils) {mILSFrequency = ils; }
    void setVORFrequency(const double vor) {mVORFrequency = vor; }

    void setAirportLat(const double lat) {mAirportLat = lat; }
    void setAirportLong(const double lon) {mAirportLong = lon; }

signals:
    void missionTypeChanged(const QString& mType);
    void ilsFrequencyChanged(const double ils);
    void vorFrequencyChanged(const double vor);

    void airportLatChanged(const double lat);
    void airportLongChanged(const double lon);


private:
    QString mMissionType;
    double mILSFrequency;
    double mVORFrequency;
    double mAirportLat;
    double mAirportLong;
};
}
}
#endif // PIGEONS_MISSION_MODEL_H
