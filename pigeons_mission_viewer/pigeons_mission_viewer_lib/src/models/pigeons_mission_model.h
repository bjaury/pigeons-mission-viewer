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

    Q_PROPERTY(float ilsFrequency
               READ ilsFrequency
               WRITE setILSFrequency
               NOTIFY ilsFrequencyChanged)

    Q_PROPERTY(float vorFrequency
               READ vorFrequency
               WRITE setVORFrequency
               NOTIFY vorFrequencyChanged)


    QString missionType() { return mMissionType; }
    float ilsFrequency() { return mILSFrequency; }
    float vorFrequency() { return mVORFrequency; }

public slots:
    void setMissionType(const QString& mType) {mMissionType = mType; }
    void setILSFrequency(const float ils) {mILSFrequency = ils; }
    void setVORFrequency(const float vor) {mVORFrequency = vor; }

signals:
    void missionTypeChanged(const QString& mType);
    void ilsFrequencyChanged(const float ils);
    void vorFrequencyChanged(const float vor);

private:
    QString mMissionType;
    float mILSFrequency;
    float mVORFrequency;
};
}
}
#endif // PIGEONS_MISSION_MODEL_H
