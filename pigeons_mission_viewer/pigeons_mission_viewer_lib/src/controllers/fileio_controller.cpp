#include "fileio_controller.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>


namespace pigeons_mission_viewer {
namespace controllers {


fileIO_Controller::fileIO_Controller(QObject *parent) :
    QObject(parent)
{

}

//Load files into Qstring lists, then create a final Qstring list that contains the data needed:
QString fileIO_Controller::fileIO_Controller::read()
{
    if (mAZSource.isEmpty() && mGPSSource.isEmpty()){
        emit error("Source AZ & GPS are empty");
        return QString();
    }

    //QFile file(mSource);
    QFile azFile(mAZSource);
    QFile gpsFile(mGPSSource);

    QString fileContent;
    QString azFileContent;
    QString gpsFileContent;
    QString line;


    //Open AZ file and load into qAZStringList
    if ( azFile.open(QIODevice::ReadOnly) ) {
        QTextStream azT( &azFile );
        do {
            line = azT.readLine();
            mAZStringList.append(line);
            //fileContent += line;
        } while (!line.isNull());

        azFile.close();
    } else {
        emit error("Unable to open the file");
        return QString();
    }
    qDebug() << "Processed AZ file" << endl;

    //file:///Users/brian/Documents/senior_design/pigeons-mission-viewer/04-15-15-33-16_UDP_log.txt
    //file:///Users/brian/Documents/senior_design/pigeons-mission-viewer/04-15-15-33-22_GPS_log.txt

    //Open GPS file and load into qGPSStringList
    if ( gpsFile.open(QIODevice::ReadOnly) ) {
        QTextStream gpsT( &azFile );
        do {
            line = gpsT.readLine();
            mGPSStringList.append(line);
            //fileContent += line;
        } while (!line.isNull());

        gpsFile.close();
    } else {
        emit error("Unable to open the file");
        return QString();
    }
    qDebug() << "Processed GPS file" << endl;



    qDebug() << "GPS String" << mGPSStringList << endl;
    qDebug() << "AZ String" << mAZStringList << endl;



    return QString("Dummy Return");

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
}};
