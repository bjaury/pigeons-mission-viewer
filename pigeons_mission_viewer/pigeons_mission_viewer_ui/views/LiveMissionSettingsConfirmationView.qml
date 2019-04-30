import QtQuick 2.10
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.4

Item {

    Rectangle {
        id: lmscParentRec
        color: "#dedede"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 500
        height: 500
        border.width: 1
        border.color: "black"
        anchors.margins: 15

        Label {
            id: lmscTitleLbl
            text: "PIGEONS Live Mission Settings Confirmation"
            anchors.topMargin: 15
            font.bold: true
            font.pointSize: 11
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10
        }

        Rectangle {
            id: lmscChildRec
            anchors.top: lmscTitleLbl.bottom
            width:500
            height: 480
            anchors.margins: 15
            //color: "#ff0000"
            border.width: 1
            border.color: "black"

            Label {
                id: lmscInfoTitleLbl
                text: "Please confirm your mission settings configuration:"
                anchors.top: lmscChildRec.top
                anchors.left: lmscChildRec.left
                anchors.margins: 15
                font.pointSize: 9
                font.bold: true
            }

            Grid {
                id: grid
                anchors.topMargin: 25
                spacing: 10
                columns:2
                rows: 4
                verticalItemAlignment: Grid.AlignVCenter
                anchors.top: lmscInfoTitleLbl.bottom
                anchors.margins: 15
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    id: missionTypeTltLbl
                    text: "Mission Type:"
                    font.pointSize: 10
                    font.bold: true
                }

                Label {
                    id: missionTypeLbl
                    text: pigeonsMissionModel.missionType
                    font.pointSize: 10
                }

                Label {
                    id: vorFreqTltLbl
                    text: "VOR Frequency:"
                    font.pointSize: 10
                    font.bold: true
                }

                Label {
                    id: vorFreqLbl
                    text: pigeonsMissionModel.vorFrequency
                    font.pointSize: 10
                }

                Label {
                    id: ilsFreqTltLbl
                    text: "ILS Frequency:"
                    font.pointSize: 10
                    font.bold: true
                }

                Label {
                    id: ilsFreqLbl
                    text: pigeonsMissionModel.ilsFrequency
                    font.pointSize: 10
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
                        masterController.ui_navigationController.goMissionTypeSelectionView();
                    }
                }

                Button {
                    id: startBtn
                    text: "Start"
                    width: 100
                    anchors.rightMargin: 30
                    anchors.right: parent.right
                    anchors.margins: 10

                    Material.background: Material.Green


                    onClicked: {
                        masterController.ui_navigationController.goLiveMissionMapView();
                        console.log("Go to show Mission");
                        xBeeController.sendXbeeMessage("Mission VOR")
                        xBeeController.sendXbeeMessage('Send Data Down')
                    }
                }
            }
        }
    }
}

