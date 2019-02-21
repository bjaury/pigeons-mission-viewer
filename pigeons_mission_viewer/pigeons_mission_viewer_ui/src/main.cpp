#include <QGuiApplication>
#include <QQmlContext>

#include <QQmlApplicationEngine>
#include <controllers/master-controller.h>

#include <xbee/xbee-controller.h>
#include <serial/serialport-manager.h>
#include <controllers/qgcmissionplan_controller.h>
#include <data/datetime-decorator.h>
#include <data/enumerator-decorator.h>
#include <data/int-decorator.h>
#include <data/string-decorator.h>

int main(int argc, char *argv[])
{
    qputenv("QT_QUICK_CONTROLS_STYLE", "material");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<pigeons_mission_viewer::controllers::MasterController>("PIGEONS_MISSION_VIEWER", 1, 0, "MasterController");
    qmlRegisterType<pigeons_mission_viewer::controllers::NavigationController>("PIGEONS_MISSION_VIEWER", 1, 0, "NavigationController");
    qmlRegisterType<pigeons_mission_viewer::xbee::XbeeController>("PIGEONS_MISSION_VIEWER", 1, 0, "XbeeController");
    qmlRegisterType<pigeons_mission_viewer::serial::SerialPortManager>("PIGEONS_MISSION_VIEWER", 1, 0, "SerialPortManager");
    qmlRegisterType<pigeons_mission_viewer::controllers::QGCMissionPlanController>("PIGEONS_MISSION_VIEWER", 1, 0, "QGCMissionPlanController");


    pigeons_mission_viewer::controllers::MasterController masterController;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("masterController", &masterController);

    engine.load(QUrl(QStringLiteral("qrc:/views/MasterView.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
