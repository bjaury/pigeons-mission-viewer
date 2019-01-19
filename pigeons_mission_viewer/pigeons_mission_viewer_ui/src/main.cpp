#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <controllers/master-controller.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<pigeons_mission_viewer::controllers::MasterController>("PIGEONS_MISSION_VIEWER", 1, 0, "MasterController");
    qmlRegisterType<pigeons_mission_viewer::controllers::NavigationController>("PIGEONS_MISSION_VIEWER", 1, 0, "NavigationController");


    pigeons_mission_viewer::controllers::MasterController masterController;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("masterController", &masterController);

    engine.load(QUrl(QStringLiteral("qrc:/views/MasterView.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
