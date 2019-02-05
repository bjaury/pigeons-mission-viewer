import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

Window {
    visible: true
    width: 1920
    height: 1080
    title: qsTr("Pigeons Mission Viewer")

    Component.onCompleted: contentFrame.replace("qrc:/views/StartView.qml");

    Connections {
        target: masterController.ui_navigationController
        onGoCreateClientView: contentFrame.replace("qrc:/views/CreateClientView.qml")
        onGoDashboardView: contentFrame.replace("qrc:/views/DashboardView.qml")
        onGoEditClientView: contentFrame.replace("qrc:/views/EditClientView.qml", {selectedClient: client})
        onGoFindClientView: contentFrame.replace("qrc:/views/FindClientView.qml")

        onGoStartView: contentFrame.replace("qrc:/views/StartView.qml")
        //onGoStartView: contentFrame.pop("qrc:/views/StartView.qml");
        onGoRemoteVehicleConnectionSettingsView: contentFrame.replace("qrc:/views/RemoteVehicleConnectionSettingsView.qml")
        onGoMissionPlanUploadView: contentFrame.replace("qrc:/views/MissionPlanUploadView.qml")
        onGoMissionTypeSelectionView: contentFrame.replace("qrc:/views/MissionTypeSelectionView.qml")
        onGoLiveMissionSettingsConfirmationView: contentFrame.replace("qrc:/views/LiveMissionSettingsConfirmationView.qml")
    }

    //    Rectangle {
    //        id: navigationBar
    //        anchors {
    //            top: parent.top
    //            bottom: parent.bottom
    //            left: parent.left
    //        }
    //        width: 100
    //        color: "#000000"

    //        Column {
    //            Button {
    //                text: "Dashboard"
    //                onClicked: masterController.ui_navigationController.goDashboardView()
    //            }
    //            Button {
    //                text: "New Client"
    //                onClicked: masterController.ui_navigationController.goCreateClientView()
    //            }
    //            Button {
    //                text: "Find Client"
    //                onClicked: masterController.ui_navigationController.goFindClientView()
    //            }
    //        }
    //    }

    StackView {
        id: contentFrame
        anchors.fill: parent
        //            anchors {
        //                top: parent.top
        //                bottom: parent.bottom
        //                right: parent.right
        //                //left: navigationBar.right
        //                left: parent.left
        //            }
        initialItem: "qrc:/views/SplashView.qml"
        clip: true

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }

        replaceEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 50
            }
        }
        replaceExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 50
            }
        }

    }
}
