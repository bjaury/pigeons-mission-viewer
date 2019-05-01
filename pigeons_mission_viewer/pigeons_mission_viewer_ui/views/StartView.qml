import QtQuick 2.10
import QtQuick.Controls 2.4

Item {
    id: element

    signal handlerViewLoader(string name)

    Button {
        id: trackLiveMissionBtn;
        width: 250;
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true;
        text: "Track Live Mission";
        anchors.verticalCenter: parent.verticalCenter

        onClicked: {
            masterController.ui_navigationController.goRemoteVehicleConnectionSettingsView();
            console.log("Track Live Mission Button Pressed.");
        }
    }

    Button {
        id: trackPreviousMissionBtn;
        width: 250;
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: trackLiveMissionBtn.bottom;
        anchors.topMargin: 15;
        font.bold: true
        text: "Replay Previous Mission";

        onClicked: {
            masterController.ui_navigationController.goRecordedMissionLogUploadView();
            console.log("Track Previous Mission Button Pressed.");
        }
    }

    Image {
        id: image
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 636
        height: 605
        z: -2
        fillMode: Image.Stretch
        source: "../assets/pigeons_Logo_596x575.png"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: image.bottom
        text: "PIGEONS Mission Viewer 1.0"
        font.pointSize: 20
        font.family: "Courier"
        font.weight: Font.ExtraBold

    }
}
