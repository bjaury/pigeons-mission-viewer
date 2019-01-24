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
            console.err("Track Previous Mission not implemented.");
        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
