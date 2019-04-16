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

    if ( file.open(QIODevice::ReadOnly) ) {
        QString line;
        QTextStream t( &file );
        do {
            line = t.readLine();
            fileContent += line;
        } while (!line.isNull());

        file.close();
    } else {
        emit error("Unable to open the file");
        return QString();
    }
    return fileContent;
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
