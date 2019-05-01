//https://github.com/Eksapsy/Vide

import QtQuick 2.10
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.4
import PIGEONS_MISSION_VIEWER 1.0

Item {

    property string serialPort;
    property int baudRate;
    property string deviceAddress: "0013A200417E33A1";

    property bool disableContinueButton: true
    signal guiSerialSettingsChanged


    SerialPortSettingsManager {
    id: serialPortSettingsManager
    }

    Rectangle {
        id: rvcsParentRec
        color: "#dedede"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 500
        height: 500
        border.width: 1
        border.color: "black"
        anchors.margins: 15

        Label {
            id: rvcsTitleLbl
            text: "Remote Vehicle Connection Settings"
            anchors.topMargin: 15
            font.bold: true
            font.pointSize: 11
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10

        }

        Rectangle {
            id: rvcsChildRec
            anchors.top: rvcsTitleLbl.bottom
            width:500
            height: 480
            anchors.margins: 15
            //color: "#ff0000"
            border.width: 1
            border.color: "black"

            Label {
                id: rvcsInfoTitleLbl
                text: "Please configure the settings to connect to the onboard computer:"
                anchors.top: rvcsChildRec.top
                anchors.left: rvcsChildRec.left
                anchors.margins: 15
                font.pointSize: 9
                font.bold: true

            }

            Grid {
                id: grid
                anchors.topMargin: 25
                spacing: 10
                columns:2
                rows: 6
                verticalItemAlignment: Grid.AlignVCenter
                anchors.top: rvcsInfoTitleLbl.bottom
                anchors.margins: 15
                anchors.horizontalCenter: parent.horizontalCenter


                Label {
                    id: serialPortLbl
                    text: "Serial Port:"
                    font.pointSize: 10

                }

                ComboBox {
                    id: serialPortCmb
                    width: 200
                    model: serialPortSettingsManager.availablePorts()

                    onCurrentIndexChanged: {
                        guiSerialSettingsChanged();
                    }

                }

                Label {
                    id: baudRateLbl
                    text: "Baud Rate:"
                    font.pointSize: 10

                }
                ComboBox {
                    id: baudRateCmb
                    width: 200
                    model: serialPortSettingsManager.availableBaudRates()
                    currentIndex: 6
                    onCurrentIndexChanged: {
                        guiSerialSettingsChanged();
                    }
                }

                Label {
                    id: xbeeAddressLbl
                    text: "XBee Device Address:"
                    font.pointSize: 10
                }

                TextField {
                    id: xbeeTextInput
                    width: 200
                    text: "0013A200417E33A1"

                }

            }

            Row{
                anchors.top: parent.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.topMargin: -60

                Button {
                    id: cancelBtn
                    text: "Cancel"
                    width: 100
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.margins: 10

                    onClicked: {
                        masterController.ui_navigationController.goStartView();
                    }
                }

                Button {
                    id: testConnBtn
                    width: 150
                    text: "Test Connection"
                    checkable: false
                    anchors.rightMargin: 20
                    anchors.right: connBtn.left
                    anchors.margins: 10
                    Material.background: Material.Red

                    onClicked: {
                        console.debug("NOTE NOT ACTUALLY TESTING CONNECTION. NEED TO FIX.");
                        console.debug("Opening Connection");
                        console.debug("REMOVE BURNT BAUD");


                        xBeeController.openXbeeConnection(serialPort, 9600, deviceAddress);
                        Material.background = Material.Green;

                        console.debug("Sending Connection Request to Air");
                        xBeeController.sendXbeeMessage("Connection Request");

                        disableContinueButton = false;

//                        xBeeController.sendXbeeMessage("Accept Connection Request")
//                        xBeeController.sendXbeeMessage("Mission VOR")
                    }

                }

                Button {
                    id: connBtn
                    text: "Continue"
                    width: 100
                    anchors.rightMargin: 30
                    anchors.right: parent.right

                    anchors.margins: 10
                    enabled: !disableContinueButton

                    onClicked: {

                        console.log("Need to implement Continue Button");

                        masterController.ui_navigationController.goMissionTypeSelectionView();
                    }
                }
            }
        }
    }

    onGuiSerialSettingsChanged: {

        serialPort = serialPortCmb.model[serialPortCmb.currentIndex];
        baudRate = baudRateCmb.model[baudRateCmb.currentIndex];
        deviceAddress = deviceAddress.text;
    }
}
