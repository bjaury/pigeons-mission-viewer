import QtQuick 2.10
import QtQuick.Controls 2.4

Item {

    signal handlerViewLoader(string name)

    Button {
        id: trackLiveMissionBtn;
        width: 200;
        font.bold: true;
        text: "Track Live Mission";

        onClicked: {

            handlerViewLoader("qrc:views/remoteVehicleConnectionSettingsView.qml");
            console.log("Track Live Mission Button Pressed.");
        }

    }

    Button {
        id: trackPreviousMissionBtn;
        width: 200;
        anchors.top: trackLiveMissionBtn.bottom;
        anchors.topMargin: 15;
        font.bold: true;
        text: "Replay Previous Mission";

        onClicked: {
            console.err("Track Previous Mission not implemented.");
        }
    }
}
