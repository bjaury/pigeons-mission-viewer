import QtQuick 2.10
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.4
import QtQuick.Dialogs 1.0
import PIGEONS_MISSION_VIEWER 1.0


Item {

    QGCMissionPlanController {
        id: qgcMissionPlanCtrl
    }

    Rectangle {
        id: mluvParentRec
        color: "#dedede"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 575
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
            width:575
            height: 480
            anchors.margins: 15
            //color: "#ff0000"
            border.width: 1
            border.color: "black"

            Label {
                id: mluvInfoTitleLbl
                text: "Please select and upload a previously recorded mission file:"
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
                rows: 2
                verticalItemAlignment: Grid.AlignVCenter
                anchors.top: mluvInfoTitleLbl.bottom
                anchors.margins: 15
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    id: missionLogTlLbl
                    text: "Mission Log:"
                    font.pointSize: 10
                    font.bold: true

                }

                Label {
                    id: missionLogPathLbl
                    text: "No log file Selected"
                    font.pointSize: 10

                }

                Button {
                    id: browseBtn
                    text: "Browse"

                    onClicked: {
                        fileDialog.open();
                    }
                }

                Label {
                    id: missionTypeTlLbl
                    text: "Mission Type:"
                    font.pointSize: 10
                    font.bold: true
                }

                RadioButton {
                    id: vorMissionRadioBtn
                    text: "VOR"
                    checked: false

                    onClicked: {
                        console.log("VOR Checked!");
                    }
                }

                RadioButton {
                    id: ilsMissionRadioBtn
                    text: "ILS"
                    checked: false

                    onClicked: {
                        console.log("ILS Checked!");
                    }
                }
            }


            Row {
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
                    enabled: false

                    onClicked: {

                        if(!ilsMissionRadioBtn.checked && !vorMissionRadioBtn.checked)
                        {
                            console.log("Error: user did not select a mission.");
                        }else
                        {
                            setMissionType();
                            fileIOController.parseLogs();
                            masterController.ui_navigationController.onGoRecordedMissionMapView();
                        }
                    }
                }
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        nameFilters: ["Recorded Mission Log File (*.json)"];

        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            checkMissionFromFilePath(fileDialog.fileUrls)


            missionLogPathLbl.text = fileDialog.fileUrl
            nextBtn.enabled = true;

        }
        onRejected: {
            console.log("Canceled")

        }
        Component.onCompleted: visible = false
    }

    function checkMissionFromFilePath(url)
    {
        var path = url.toString();

        if(path.toLowerCase().indexOf("ils") != -1)
        {
            vorMissionRadioBtn.checked = false;
            ilsMissionRadioBtn.checked = true;
        }
        else if(path.toLowerCase().indexOf("vor") != -1)
        {
            vorMissionRadioBtn.checked = true
            ilsMissionRadioBtn.checked = false;
        }else
        {
            console.error("Cannot determine mission type from file name.");
        }

    }

    function setMissionType()
    {
        if(ilsMissionRadioBtn.checked){
            console.log("ILS Mission to be processed");
            fileIOController.setILSSource(fileDialog.fileUrl);
            fileIOController.setVORSource("");
        }else if (vorMissionRadioBtn.checked){
            console.log("VOR Mission to be processed");
            fileIOController.setILSSource("");
            fileIOController.setVORSource(fileDialog.fileUrl);
        }

    }

}

