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


void fileIO_Controller::fileIO_Controller::readJson(QString fileName)
{
    QString val;
    QFile file;
    file.setFileName(fileName);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    mJSONContents = file.readAll();
    file.close();
    qDebug() << val << endl;


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
    //qDebug() << "Burnt source values, remove before production." << endl;
    //mILSSource = "file///Users/brian/Documents/senior_design/pigeons-mission-viewer/04-15-15-33-16_UDP_log.txt";
    //mVORSource = "file///Users/brian/Documents/senior_design/logs/04-24-23-28-09_VOR_log.json";

    mVORSource = mVORSource.mid(6);
    mILSSource = mILSSource.mid(6);

    if(mILSSource.isEmpty() && !mVORSource.isEmpty())
    {
        qDebug() << "VOR Mission will be parsed" << endl;
        //this->parseVORJSONLogs();
        this->readJson(mVORSource);
        mLogFilePath = mVORSource;
        mMissionType = "VOR";
    }
    else if(!mILSSource.isEmpty() && mVORSource.isEmpty())
    {
        qDebug() << "ILS Mission will be parsed" << endl;
        //this->parseILSJSONLogs();
        this->readJson(mILSSource);
        mLogFilePath = mILSSource;
        mMissionType = "ILS";



    }else if(!mILSSource.isEmpty() && !mVORSource.isEmpty())
    {
        qDebug() << "ERROR. Both ILS & VOR mission sources were selected. Cannot parse." << endl;
        return;
    }else if(mILSSource.isEmpty() && mVORSource.isEmpty())
    {
        qDebug() << "ERROR. no mission log profiles were selected. Cannot parse." << endl;
        return;
    }


}

void fileIO_Controller::fileIO_Controller::parseVORJSONLogs()
{
    this->readJson(mVORSource);
}

void fileIO_Controller::fileIO_Controller::parseILSJSONLogs()
{
    this->readJson(mILSSource);

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

    return azimuth;

}

}};
