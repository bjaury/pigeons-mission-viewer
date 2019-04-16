import QtQuick 2.10
import QtQuick.Controls 2.4

Item {
    id: element

    signal handlerViewLoader(string name)
    //anchors.fill: parent

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
}

