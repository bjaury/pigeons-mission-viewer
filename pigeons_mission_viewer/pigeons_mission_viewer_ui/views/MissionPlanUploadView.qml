import QtQuick 2.10
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.4
import QtQuick.Dialogs 1.0


Item {

    Rectangle {
        id: mpuvParentRec
        color: "#dedede"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 500
        height: 500
        border.width: 1
        border.color: "black"
        anchors.margins: 15

        Label {
            id: mpuvTitleLbl
            text: "PIGEONS Mission Plan Upload"
            anchors.topMargin: 15
            font.bold: true
            font.pointSize: 11
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10

        }

        Rectangle {
            id: mpuvChildRec
            anchors.top: mpuvTitleLbl.bottom
            width:500
            height: 480
            anchors.margins: 15
            //color: "#ff0000"
            border.width: 1
            border.color: "black"

            Label {
                id: mpuvInfoTitleLbl
                text: "Please select and upload the QGroundControl Mission Plan file:"
                anchors.top: mpuvChildRec.top
                anchors.left: mpuvChildRec.left
                anchors.margins: 15
                font.pointSize: 9
                font.bold: true

            }

            Grid {
                id: grid
                anchors.topMargin: 25
                spacing: 10
                columns:3
                rows: 1
                verticalItemAlignment: Grid.AlignVCenter
                anchors.top: mpuvInfoTitleLbl.bottom
                anchors.margins: 15
                anchors.horizontalCenter: parent.horizontalCenter



                Label {
                    id: missionPlanTlLbl
                    text: "Mission Plan:"
                    font.pointSize: 10
                    font.bold: true

                }

                Label {
                    id: missionPlanPathLbl
                    text: "No File Path Selected"
                    font.pointSize: 10

                }

                Button {
                    id: browseBtn
                    text: "Browse"

                    onClicked: {

                    fileDialog.open();
                    }

                }

            }




            Row{
                anchors.top: parent.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.topMargin: -60

                Button {
                    id: previousBtn
                    text: "Previous"
                    width: 100
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.margins: 10

                    onClicked: {
                        masterController.ui_navigationController.goStartView();
                    }
                }

                Button {
                    id: nextBtn
                    text: "Next"
                    width: 100
                    anchors.rightMargin: 30
                    anchors.right: parent.right

                    anchors.margins: 10
                }
            }


        }
    }
    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)

            missionPlanPathLbl.text = fileDialog.fileUrl

        }
        onRejected: {
            console.log("Canceled")

        }
        Component.onCompleted: visible = false
    }

}

