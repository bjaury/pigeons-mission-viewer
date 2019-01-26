//https://github.com/Eksapsy/Vide

import QtQuick 2.10
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.4
import PIGEONS_MISSION_VIEWER 1.0

Item {

    SerialPortManager {
        id: serialPortManager
        //        onConnected: {
        //            startButton.text = "STOP"
        //        }
        //        onDisconnected: {
        //            startButton.text = "START"
        //        }
        //        onDataRead: {
        //            terminal.input= getLastBytesRead()
        //        }
    }

    signal guiSerialSettingsChanged

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
                    model: serialPortManager.availablePorts()
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
                    model: serialPortManager.availableBaudRates()
                    onCurrentIndexChanged: {
                        guiSerialSettingsChanged();
                    }
                }

                Label {
                    id: dataBitsLbl
                    text: "Data Bits:"
                    font.pointSize: 10

                }
                ComboBox {
                    id: dataBitsCmb
                    width: 200
                    model: ["5", "6", "7", "8"]
                    onCurrentIndexChanged: {
                        guiSerialSettingsChanged();
                    }
                }


                Label {
                    id: parityLbl
                    text: "Parity:"
                    font.pointSize: 10

                }
                ComboBox {
                    id: parityCmb
                    width: 200
                    model: ["No Parity", "Even", "Odd", "Space", "Mark"]
                    onCurrentIndexChanged: {
                        guiSerialSettingsChanged();
                    }
                }


                Label {
                    id: stopBitsLbl
                    text: "Stop Bits:"
                    font.pointSize: 10

                }
                ComboBox {
                    id: stopBitsCmb
                    width: 200
                    model: ["1",  "2", "1.5"]
                    onCurrentIndexChanged: {
                        guiSerialSettingsChanged();
                    }
                }


                Label {
                    id: flowCntrlLbl
                    text: "Flow Control:"
                    font.pointSize: 10

                }
                ComboBox {
                    id: flowCntrlCmb
                    width: 200
                    model: ["No Flow Control", "Hardware Control", "Software Control"]
                    onCurrentIndexChanged: {
                        guiSerialSettingsChanged();
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
                        console.log();

                        serialPortManager.openSerialPort();

                        //Ultimately make function in serialPort class to manage testing connection.

                        serialPortManager.closeSerialPort();


                    }

                }

                Button {
                    id: connBtn
                    text: "Continue"
                    width: 100
                    anchors.rightMargin: 30
                    anchors.right: parent.right

                    anchors.margins: 10

                    onClicked: {
                    masterController.ui_navigationController.goMissionPlanUploadView();
                    }
                }
            }
        }
    }

    onGuiSerialSettingsChanged: {

        serialPortManager.updateSettings(serialPortCmb.model[serialPortCmb.currentIndex],
                                         baudRateCmb.model[baudRateCmb.currentIndex],
                                         dataBitsCmb.model[dataBitsCmb.currentIndex],
                                         parityCmb.model[parityCmb.currentIndex],
                                         stopBitsCmb.model[stopBitsCmb.currentIndex],
                                         flowCntrlCmb.model[flowCntrlCmb.currentIndex])



    }
}
