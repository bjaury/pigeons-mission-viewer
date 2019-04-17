#ifndef FILEIO_CONTROLLER_H
#define FILEIO_CONTROLLER_H

#include <QObject>
#include <pigeons_mission_viewer_lib_global.h>

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
    Q_PROPERTY(QString azSource
               READ azSource
               WRITE setAZSource
               NOTIFY azSourceChanged)
    Q_PROPERTY(QString gpsSource
               READ gpsSource
               WRITE setGPSSource
               NOTIFY gpsSourceChanged)
    explicit fileIO_Controller(QObject *parent = nullptr);

    Q_INVOKABLE QString read();
    Q_INVOKABLE bool write(const QString& data);

    QString source() { return mSource; }
    QString azSource() { return mAZSource; }
    QString gpsSource() { return mGPSSource; }

public slots:
    void setSource(const QString& source) { mSource = source; }
    void setAZSource(const QString& source) { mAZSource = source; }
    void setGPSSource(const QString& source) { mGPSSource = source; }

signals:
    void sourceChanged(const QString& source);
    void azSourceChanged(const QString& source);
    void gpsSourceChanged(const QString& source);

    void error(const QString& msg);

private:
    QString mSource;
    QString mAZSource;
    QString mGPSSource;
    QStringList mAZStringList;
    QStringList mGPSStringList;


};
}
}
#endif // FILEIO_CONTROLLER_H





