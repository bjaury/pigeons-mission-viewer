import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.4

ApplicationWindow {
    id: mainWindow
    width: 1920
    height: 1080
    visible: true

    Loader{
        id: viewLoader
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source:"StartView.qml"
    }

}
