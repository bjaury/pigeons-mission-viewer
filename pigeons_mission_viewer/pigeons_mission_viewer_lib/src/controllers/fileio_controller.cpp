#include "fileio_controller.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>

#define PI 3.14159265

namespace pigeons_mission_viewer {
namespace controllers {


fileIO_Controller::fileIO_Controller(QObject *parent) :
    QObject(parent)
{

}

//Load files into Qstring lists, then create a final Qstring list that contains the data needed:
QString fileIO_Controller::fileIO_Controller::read(QString& src, QStringList& des)
{

    //qDebug() << mAZSource << mGPSSource << endl;

    if (mAZSource.isEmpty() && mGPSSource.isEmpty()){
        emit error("Source AZ & GPS are empty");
        return QString();
    }

    //qDebug() << mAZSource << mGPSSource << endl;

    QFile file(src);
    QString line;

    //Open file and load into des
    if ( file.open(QIODevice::ReadOnly) ) {
        QTextStream t( &file );
        do {
            line = t.readLine();
            if(!(line.isEmpty()))
            {
                des.append(line);
            }
        } while (!line.isNull());

        file.close();
    } else {
        emit error("Unable to open the file");
        return QString();
    }

    //qDebug() << "Processed File" << endl;

    return QString("Done Reading File");

}

bool fileIO_Controller::fileIO_Controller::write(const QString& data)
{
    //    if (mSource.isEmpty())
    //        return false;

    //    QFile file(mSource);
    //    if (!file.open(QFile::WriteOnly | QFile::Truncate))
    //        return false;

    //    QTextStream out(&file);
    //    out << data;

    //    file.close();
    qDebug() << "Debug not implemented" << endl;


    return true;
}

void fileIO_Controller::fileIO_Controller::parseLogs()
{
    //For testing only
    mAZSource  = "file///Users/brian/Documents/senior_design/pigeons-mission-viewer/04-15-15-33-16_UDP_log.txt";
    mGPSSource = "file///Users/brian/Documents/senior_design/pigeons-mission-viewer/04-15-15-33-22_GPS_log.txt";

    mAZSource = mAZSource.mid(6);
    mGPSSource = mGPSSource.mid(6);

    QJsonObject gpsJSONLine;
    QString azLine;
    QString gpsLine;
    QString azTime;
    QString measured;
    QString theoretical;
    QString jsonReadingObj;

    // qDebug() << "GPS String" << mGPSStringList << endl;
    // qDebug() << "AZ String" << mAZStringList << endl;

    this->read(mAZSource, mAZStringList);
    this->read(mGPSSource, mGPSStringList);

    //qDebug() << "AZ String " << mAZStringList.at(1) << endl;
    //qDebug() << "GPS String " << mGPSStringList.at(1) << endl;

    qDebug() << "Index of Comma" << mGPSStringList.at(1).indexOf("");

    qDebug() <<  mGPSStringList.count() << endl;

    for(int i = 0; i < mGPSStringList.count(); i++)
    {
        //Save GPS String to hold
        gpsLine = mGPSStringList.at(i);
        qDebug() << "GPS String " << mGPSStringList.at(i) << endl;
        gpsJSONLine = this->convertGPS2JSON(gpsLine, i + 1);

        qDebug() << gpsJSONLine << endl;
        qDebug() << gpsJSONLine.value("lon") << endl;






        //        for(int j = 0; j < mAZStringList.count(); j++)
        //        {
        //            //Save AZ string to hold
        //            azString = mAZStringList.at(j);
        //            qDebug() << "AZ String " << mAZStringList.at(j) << endl;
        //        }

    }
}

QJsonObject fileIO_Controller::fileIO_Controller::convertGPS2JSON(QString& gpsStr, int num)
{
    QString gpsString = gpsStr;
    QString gpsTime;
    QString lat;
    QString lon;
    QString alt = "5";


    QJsonObject gpsDataJS;


    //Get GPS time
    gpsString = gpsString.mid(6);
    gpsTime = gpsString.left(gpsString.indexOf(" "));

    gpsString = gpsString.mid(gpsString.indexOf(":") + 2);
    lat = gpsString.left(gpsString.indexOf(","));

    gpsString = gpsString.mid(gpsString.indexOf(" ") +1);
    lon = gpsString;

    float theoretical = this->convertGPStoAzmuth(lat.toFloat(), lon.toFloat());


     gpsDataJS = {
        { "num", num },
        { "time", gpsTime },
        { "lat", lat.toDouble() },
        { "lon", lon.toDouble() },
        { "alt", alt.toDouble() },
        { "theoretical", theoretical}
    };

    qDebug() << "Reached return of gps2json" << endl;
    return gpsDataJS;


}

float fileIO_Controller::fileIO_Controller::convertGPStoAzmuth(float lat, float lon)
{
    float latVOR, latRover, longVOR, longRover, deltaLong, latVORRad, latRoverRad, longVORRad, longRoverRad, deltaLongRad, azimuth;

    latVOR = 29.3033;
    longVOR  = -81.1127;

    latRover = lat;
    longRover = lon;

    deltaLong = longRover - longVOR;

    latVORRad = (latVOR * PI) / 180;
    latRoverRad = (latRover * PI) / 180;
    longVORRad = (longVOR * PI) / 180;
    longRoverRad = (longRover * PI) / 180;
    deltaLongRad = (deltaLong * PI) / 180;

    float yParam = sin(deltaLongRad)*cos(latRoverRad);

    float xParam = (cos(latVORRad)*sin(latRoverRad)) - (sin(latVORRad)*cos(latRoverRad)*cos(deltaLongRad));

    azimuth = ((atan2(yParam, xParam))*180)/PI;

    if(azimuth < 0){
        azimuth = azimuth + 360;
    }

}

}};
