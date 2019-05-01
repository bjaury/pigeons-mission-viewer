#include <QGuiApplication>
#include <QQmlContext>
#include <QDir>
#include <QQmlApplicationEngine>
#include <controllers/master-controller.h>
#include <xbee/xbee-controller.h>
#include <xbeep.h>
#include <serial/serialport-settings-manager.h>
#include <controllers/communication_controller.h>
#include <data/datetime-decorator.h>
#include <data/enumerator-decorator.h>
#include <data/int-decorator.h>
#include <data/string-decorator.h>
#include <controllers/fileio_controller.h>
#include <models/pigeons_mission_model.h>

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
    qmlRegisterType<pigeons_mission_viewer::controllers::fileIO_Controller>("PIGEONS_MISSION_VIEWER", 1, 0, "FileIOController");
    qmlRegisterType<pigeons_mission_viewer::models::PIGEONSMissionModel>("PIGEONS_MISSION_VIEWER", 1, 0, "PIGEONSMissionModel");



    pigeons_mission_viewer::controllers::MasterController masterController;
    pigeons_mission_viewer::serial::SerialPortSettingsManager serialPortSettingsManager;
    pigeons_mission_viewer::controllers::CommunicationController communicationController;
    pigeons_mission_viewer::controllers::fileIO_Controller fileIOController;
    pigeons_mission_viewer::xbee::XbeeController xBeeController(&communicationController);
    pigeons_mission_viewer::models::PIGEONSMissionModel pigeonsMissionModel;

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


    engine.addImportPath(arcGISRuntimeImportPath);
    engine.addImportPath(arcGISToolkitImportPath);
    engine.rootContext()->setContextProperty("masterController", &masterController);
    engine.rootContext()->setContextProperty("SerialPortManager", &serialPortSettingsManager);
    engine.rootContext()->setContextProperty("communicationController", &communicationController);
    engine.rootContext()->setContextProperty("fileIOController", &fileIOController);
    engine.rootContext()->setContextProperty("xBeeController", &xBeeController);
    engine.rootContext()->setContextProperty("pigeonsMissionModel", &pigeonsMissionModel);

    engine.load(QUrl(QStringLiteral("qrc:/views/MasterView.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
