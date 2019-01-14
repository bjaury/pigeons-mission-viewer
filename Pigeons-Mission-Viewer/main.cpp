#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    qputenv("QT_QUICK_CONTROLS_STYLE", "material");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //engine.load(QUrl(QStringLiteral("qrc:views/main.qml")));
    engine.load(QUrl(QStringLiteral("qrc:views/ViewManager.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
