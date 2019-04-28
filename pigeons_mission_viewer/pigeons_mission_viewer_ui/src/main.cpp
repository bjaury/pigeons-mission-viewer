#include <QGuiApplication>
#include <QQmlContext>
#include <QDir>


#include <QQmlApplicationEngine>
#include <controllers/master-controller.h>
#include <xbee/xbee-controller.h>
#include <serial/serialport-manager.h>
#include <controllers/communication_controller.h>
#include <controllers/qgcmissionplan_controller.h>
#include <data/datetime-decorator.h>
#include <data/enumerator-decorator.h>
#include <data/int-decorator.h>
#include <data/string-decorator.h>
#include <controllers/fileio_controller.h>

#define STRINGIZE(x) #x
#define QUOTE(x) STRINGIZE(x)

int main(int argc, char *argv[])
{
    qputenv("QT_QUICK_CONTROLS_STYLE", "material");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<pigeons_mission_viewer::controllers::MasterController>("PIGEONS_MISSION_VIEWER", 1, 0, "MasterController");
    qmlRegisterType<pigeons_mission_viewer::controllers::NavigationController>("PIGEONS_MISSION_VIEWER", 1, 0, "NavigationController");
    qmlRegisterType<pigeons_mission_viewer::xbee::XbeeController>("PIGEONS_MISSION_VIEWER", 1, 0, "XbeeController");
    qmlRegisterType<pigeons_mission_viewer::serial::SerialPortManager>("PIGEONS_MISSION_VIEWER", 1, 0, "SerialPortManager");
    qmlRegisterType<pigeons_mission_viewer::controllers::CommunicationController>("PIGEONS_MISSION_VIEWER", 1, 0, "CommunicationController");
    qmlRegisterType<pigeons_mission_viewer::controllers::QGCMissionPlanController>("PIGEONS_MISSION_VIEWER", 1, 0, "QGCMissionPlanController");
    qmlRegisterType<pigeons_mission_viewer::controllers::fileIO_Controller>("PIGEONS_MISSION_VIEWER", 1, 0, "FileIOController");



    pigeons_mission_viewer::controllers::MasterController masterController;
    pigeons_mission_viewer::serial::SerialPortManager serialPortManager;
    pigeons_mission_viewer::controllers::CommunicationController communicationController;
    pigeons_mission_viewer::controllers::fileIO_Controller fileIOController;

    QObject::connect(&serialPortManager, SIGNAL(receivedData(QByteArray)), &communicationController, SLOT(onReceivedData(QByteArray)));
//    bool success =
//        Q_ASSERT(success);

    QQmlApplicationEngine engine;

    engine.addImportPath(QDir(QCoreApplication::applicationDirPath()).filePath("qml"));

    QString arcGISRuntimeImportPath = QUOTE(ARCGIS_RUNTIME_IMPORT_PATH);
    QString arcGISToolkitImportPath = QUOTE(ARCGIS_TOOLKIT_IMPORT_PATH);

    // Add the Runtime and Extras path
    engine.addImportPath(arcGISRuntimeImportPath);
    // Add the Toolkit path
    engine.addImportPath(arcGISToolkitImportPath);

    engine.rootContext()->setContextProperty("masterController", &masterController);
    engine.rootContext()->setContextProperty("SerialPortManager", &serialPortManager);
    engine.rootContext()->setContextProperty("communicationController", &communicationController);
    engine.rootContext()->setContextProperty("fileIOController", &fileIOController);





    engine.load(QUrl(QStringLiteral("qrc:/views/MasterView.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
