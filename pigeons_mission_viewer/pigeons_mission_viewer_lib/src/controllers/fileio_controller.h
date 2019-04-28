#ifndef FILEIO_CONTROLLER_H
#define FILEIO_CONTROLLER_H

#include <QObject>
#include <pigeons_mission_viewer_lib_global.h>
#include <QJsonObject>
#include <cmath>
#include <QJsonDocument>
#include <QJsonArray>

namespace pigeons_mission_viewer {
namespace controllers {

class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT fileIO_Controller : public QObject
{
    Q_OBJECT

public:
    Q_PROPERTY(QString source
               READ source
               WRITE setSource
               NOTIFY sourceChanged)

    Q_PROPERTY(QString vorSource
               READ vorSource
               WRITE setVORSource
               NOTIFY vorSourceChanged)

    Q_PROPERTY(QString ilsSource
               READ ilsSource
               WRITE setILSSource
               NOTIFY ilsSourceChanged)

    Q_PROPERTY(QString jsonContents
               READ jsonContents
               WRITE setJSONContents
               NOTIFY jsonContentsChanged)

    Q_PROPERTY(QString logFilePath
               READ logFilePath)

    Q_PROPERTY(QString missionType
               READ missionType)




    explicit fileIO_Controller(QObject *parent = nullptr);

    //Q_INVOKABLE QString read(QString& src, QStringList& des);
    Q_INVOKABLE bool write(const QString& data);
    Q_INVOKABLE void parseLogs();
    Q_INVOKABLE void parseVORJSONLogs();
    Q_INVOKABLE void parseILSJSONLogs();
    Q_INVOKABLE void readJson(QString fileName);


    QString source() { return mSource; }


    QString vorSource() { return mVORSource; }
    QString ilsSource() { return mILSSource; }

    QString jsonContents() {return mJSONContents;}
    QString logFilePath() {return  mLogFilePath;}
    QString missionType() {return  mMissionType;}

private:
    float convertGPStoAzmuth(float lat, float lon);


public slots:
    void setSource(const QString& source) { mSource = source; }

    void setILSSource(const QString& source) { mILSSource = source; }
    void setVORSource(const QString& source) { mVORSource = source; }

    void setJSONContents(const QString& content) {mJSONContents = content; }

signals:
    void sourceChanged(const QString& source);

    void ilsSourceChanged(const QString& source);
    void vorSourceChanged(const QString& source);

    void jsonContentsChanged(const QString& content);

    void error(const QString& msg);

private:
    QString mSource;
    QString mVORSource;
    QString mILSSource;
    QString mJSONContents;
    QString mLogFilePath;
    QString mMissionType;


};
}
}
#endif // FILEIO_CONTROLLER_H





