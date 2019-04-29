#include <QGuiApplication>
#include <QQmlContext>
#include <QDir>


#include <QQmlApplicationEngine>
#include <controllers/master-controller.h>
#include <xbee/xbee-controller.h>
//#include <xbee/connectioncb.h>
#include <xbeep.h>
#include <serial/serialport-settings-manager.h>
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
    qmlRegisterType<pigeons_mission_viewer::serial::SerialPortSettingsManager>("PIGEONS_MISSION_VIEWER", 1, 0, "SerialPortSettingsManager");
    qmlRegisterType<pigeons_mission_viewer::controllers::CommunicationController>("PIGEONS_MISSION_VIEWER", 1, 0, "CommunicationController");
    qmlRegisterType<pigeons_mission_viewer::controllers::QGCMissionPlanController>("PIGEONS_MISSION_VIEWER", 1, 0, "QGCMissionPlanController");
    qmlRegisterType<pigeons_mission_viewer::controllers::fileIO_Controller>("PIGEONS_MISSION_VIEWER", 1, 0, "FileIOController");



    pigeons_mission_viewer::controllers::MasterController masterController;
    pigeons_mission_viewer::serial::SerialPortSettingsManager serialPortSettingsManager;
    pigeons_mission_viewer::controllers::CommunicationController communicationController;
    pigeons_mission_viewer::controllers::fileIO_Controller fileIOController;
    pigeons_mission_viewer::xbee::XbeeController xBeeController;

    //QObject::connect(&serialPortManager, SIGNAL(receivedData(QByteArray)), &communicationController, SLOT(onReceivedData(QByteArray)));
//    bool success =
//        Q_ASSERT(success);

    QQmlApplicationEngine engine;

    engine.addImportPath(QDir(QCoreApplication::applicationDirPath()).filePath("qml"));

    QString arcGISRuntimeImportPath = QUOTE(ARCGIS_RUNTIME_IMPORT_PATH);
    QString arcGISToolkitImportPath = QUOTE(ARCGIS_TOOLKIT_IMPORT_PATH);

    #if defined(LINUX_PLATFORM_REPLACEMENT)
        // on some linux platforms the string 'linux' is replaced with 1
        // fix the replacement paths which were created
        QString replaceString = QUOTE(LINUX_PLATFORM_REPLACEMENT);
        arcGISRuntimeImportPath = arcGISRuntimeImportPath.replace(replaceString, "linux", Qt::CaseSensitive);
        arcGISToolkitImportPath = arcGISToolkitImportPath.replace(replaceString, "linux", Qt::CaseSensitive);
    #endif


    // Add the Runtime and Extras path
    engine.addImportPath(arcGISRuntimeImportPath);
    // Add the Toolkit path
    engine.addImportPath(arcGISToolkitImportPath);

    engine.rootContext()->setContextProperty("masterController", &masterController);
    engine.rootContext()->setContextProperty("SerialPortManager", &serialPortSettingsManager);
    engine.rootContext()->setContextProperty("communicationController", &communicationController);
    engine.rootContext()->setContextProperty("fileIOController", &fileIOController);
    engine.rootContext()->setContextProperty("xBeeController", &xBeeController);





//    appEngine.addImportPath(QDir(QCoreApplication::applicationDirPath()).filePath("qml"));

//    QString arcGISRuntimeImportPath = QUOTE(ARCGIS_RUNTIME_IMPORT_PATH);
//    QString arcGISToolkitImportPath = QUOTE(ARCGIS_TOOLKIT_IMPORT_PATH);

//#if defined(LINUX_PLATFORM_REPLACEMENT)
//    // on some linux platforms the string 'linux' is replaced with 1
//    // fix the replacement paths which were created
//    QString replaceString = QUOTE(LINUX_PLATFORM_REPLACEMENT);
//    arcGISRuntimeImportPath = arcGISRuntimeImportPath.replace(replaceString, "linux", Qt::CaseSensitive);
//    arcGISToolkitImportPath = arcGISToolkitImportPath.replace(replaceString, "linux", Qt::CaseSensitive);
//#endif

//    // Add the Runtime and Extras path
//    appEngine.addImportPath(arcGISRuntimeImportPath);
//    // Add the Toolkit path
//    appEngine.addImportPath(arcGISToolkitImportPath);




    engine.load(QUrl(QStringLiteral("qrc:/views/MasterView.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
