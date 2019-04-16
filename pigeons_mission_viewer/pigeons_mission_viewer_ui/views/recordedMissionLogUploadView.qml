import QtQuick 2.10
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.4
import QtQuick.Dialogs 1.0
import PIGEONS_MISSION_VIEWER 1.0


Item {

    property string logType;

    QGCMissionPlanController {
        id: qgcMissionPlanCtrl
    }

    FileIOController{
    id: logFileProcessor
    }

    Rectangle {
        id: mluvParentRec
        color: "#dedede"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 500
        height: 500
        border.width: 1
        border.color: "black"
        anchors.margins: 15

        Label {
            id: mluvTitleLbl
            text: "PIGEONS Recorded Mission Log Upload"
            anchors.topMargin: 15
            font.bold: true
            font.pointSize: 11
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10

        }

        Rectangle {
            id: mluvChildRec
            anchors.top: mluvTitleLbl.bottom
            width:500
            height: 480
            anchors.margins: 15
            //color: "#ff0000"
            border.width: 1
            border.color: "black"

            Label {
                id: mluvInfoTitleLbl
                text: "Please select and upload the QGroundControl Mission Plan file:"
                anchors.top: mluvChildRec.top
                anchors.left: mluvChildRec.left
                anchors.margins: 15
                font.pointSize: 9
                font.bold: true

            }

            Grid {
                id: grid
                anchors.topMargin: 25
                spacing: 10
                columns:3
                rows: 3
                verticalItemAlignment: Grid.AlignVCenter
                anchors.top: mluvInfoTitleLbl.bottom
                anchors.margins: 15
                anchors.horizontalCenter: parent.horizontalCenter



                Label {
                    id: missionAzLogTlLbl
                    text: "Azimuth Log:"
                    font.pointSize: 10
                    font.bold: true

                }

                Label {
                    id: missionAzLogPathLbl
                    text: "No log file Selected"
                    font.pointSize: 10

                }

                Button {
                    id: browseAzBtn
                    text: "Browse"

                    onClicked: {
                        logType = "Azmuth";
                        fileDialog.open();
                    }

                }

                Label {
                    id: missionGPSLogTlLbl
                    text: "GPS Log:"
                    font.pointSize: 10
                    font.bold: true

                }

                Label {
                    id: missionGPSLogPathLbl
                    text: "No log file Selected"
                    font.pointSize: 10

                }

                Button {
                    id: browseGPSBtn
                    text: "Browse"

                    onClicked: {
                        logType = "GPS";
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

                    onClicked: {
                        //qgcMissionPlanCtrl.openQGCMissionPlan(fileDialog.fileUrl);
                        logFileProcessor.read();
                        masterController.ui_navigationController.onGoRecordedMissionMapView();
                    }

                }
            }


        }
    }
    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        nameFilters: ["" + logType + "Log File (*.txt)"];

        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)


            if(logType == "GPS"){
                console.log("GPS Opened");
                missionGPSLogPathLbl.text = fileDialog.fileUrl
                logFileProcessor.gpsSource = fileDialog.fileUrl
            }else if (logType == "Azmuth"){
                console.log("AZ Opened");
                missionAzLogPathLbl.text = fileDialog.fileUrl
                logFileProcessor.azSource = fileDialog.fileUrl

            }


        }
        onRejected: {
            console.log("Canceled")

        }
        Component.onCompleted: visible = false
    }

//    function openLogFiles()
//    {
//    logFileProcessor.azSource =
//    }

}

