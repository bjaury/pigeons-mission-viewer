import QtQuick 2.10
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.4

Item {

    property bool vorSettingsVisibility: false;
    property bool ilsSettingsVisibility: false;

    Component.onCompleted: {
        //ORM @29.307844,-81.1198912

        //Burning Values to save time
        ilsFreqTxtInpt.text = 118.00
        vorFreqTxtInpt.text =  122.22

        missionAirportLatTxtInpt.text = "29.307844"
        missionAirportLongTxtInpt.text = "-81.1198912"
    }

    Rectangle {
        id: mtsvParentRec
        color: "#dedede"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 500
        height: 500
        border.width: 1
        border.color: "black"
        anchors.margins: 15

        Label {
            id: mtsvTitleLbl
            text: "PIGEONS Mission Settings"
            anchors.topMargin: 15
            font.bold: true
            font.pointSize: 11
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10
        }

        Rectangle {
            id: mtsvChildRec
            anchors.top: mtsvTitleLbl.bottom
            width:500
            height: 480
            anchors.margins: 15
            //color: "#ff0000"
            border.width: 1
            border.color: "black"

            Label {
                id: mtsvInfoTitleLbl
                text: "Please select and configure mission frequencies:"
                anchors.top: mtsvChildRec.top
                anchors.left: mtsvChildRec.left
                anchors.margins: 15
                font.pointSize: 9
                font.bold: true
            }

            Grid {
                id: grid
                width: 300
                height: 170
                anchors.topMargin: 25
                spacing: 25
                columns: 2
                rows: 5
                verticalItemAlignment: Grid.AlignVCenter
                horizontalItemAlignment: Grid.AlignLeft
                anchors.top: mtsvInfoTitleLbl.bottom
                anchors.margins: 15
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    id: missionTypeTlLbl
                    text: "Mission:"
                    font.pointSize: 12
                    font.bold: true
                }

                ComboBox {
                    id: missionTypeCmb
                    width: 150
                    model: ["ILS", "VOR"]
                    currentIndex: 2



                    onCurrentIndexChanged: {
                        var selectedMissionIndex = missionTypeCmb.currentIndex;

                        if(selectedMissionIndex == 0)
                        {
                            ilsSettingsVisibility = true;
                            vorSettingsVisibility = false;
                        }else if(selectedMissionIndex == 1){
                            ilsSettingsVisibility = false;
                            vorSettingsVisibility = true;
                        }

                        missionSettingsChanged();

                    }
                }

                Label {
                    id: missionTypeVORFreqLbl
                    text: "VOR Frequency"
                    font.pointSize: 12
                    font.bold: true
                    visible: vorSettingsVisibility
                }

                TextField {
                    id: vorFreqTxtInpt
                    width: 150
                    placeholderText: qsTr("VOR Frequency")
                    cursorVisible: false
                    visible: vorSettingsVisibility

                    onTextChanged: missionSettingsChanged();

                }

                Label {
                    id: missionTypeILSFreqLbl
                    text: "ILS Frequency"
                    font.pointSize: 12
                    font.bold: true
                    visible: ilsSettingsVisibility

                }

                TextField {
                    id: ilsFreqTxtInpt
                    width: 150
                    placeholderText: qsTr("ILS Frequency")
                    cursorVisible: false
                    visible: ilsSettingsVisibility

                    onTextChanged: missionSettingsChanged();
                }

                Label {
                    id: missionAirportLatLbl
                    text: "Airport Latitude"
                    font.pointSize: 12
                    font.bold: true
                }

                TextField {
                    id: missionAirportLatTxtInpt
                    width: 150

                    placeholderText: qsTr("Airport Latitude")
                    cursorVisible: false

                    onTextChanged: missionSettingsChanged();
                }

                Label {
                    id: missionAirportLongLbl
                    text: "Airport Longitude"
                    font.pointSize: 12
                    font.bold: true
                }

                TextField {
                    id: missionAirportLongTxtInpt
                    width: 150

                    placeholderText: qsTr("Airport Longitude")
                    cursorVisible: false

                    onTextChanged: missionSettingsChanged();
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
                        masterController.ui_navigationController.goMissionPlanUploadView();
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
                        missionSettingsChanged();
                        masterController.ui_navigationController.goLiveMissionSettingsConfirmationView();
                    }
                }
            }
        }
    }
    function missionSettingsChanged()
    {
        var inputMissionType = missionTypeCmb.model[missionTypeCmb.currentIndex]
        var inputILSFreq = ilsFreqTxtInpt.text
        var inputVORFreq = vorFreqTxtInpt.text
        var inputAirportLat = missionAirportLatTxtInpt.text
        var inputAirportLong = missionAirportLongTxtInpt.text


        pigeonsMissionModel.setMissionType(inputMissionType);
        pigeonsMissionModel.setILSFrequency(inputILSFreq);
        pigeonsMissionModel.setVORFrequency(inputVORFreq);
        pigeonsMissionModel.setAirportLat(inputAirportLat);
        pigeonsMissionModel.setAirportLong(inputAirportLong);


    }

}
