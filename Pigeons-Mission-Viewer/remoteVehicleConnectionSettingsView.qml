import QtQuick 2.10
import QtQuick.Controls 2.4


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
        font.bold: true
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

        Column {
            id: column

            anchors.top: rvcsInfoTitleLbl.bottom
            anchors.margins: 15
            anchors.horizontalCenter: parent.horizontalCenter

            Row{

                id: serialPortRow
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.margins: 15

                Label {
                    id: serialPortLbl
                    text: "Serial Port:"
                    anchors.right: serialPortCmb.left
                    anchors.rightMargin: 15
                    anchors.verticalCenter: serialPortCmb.verticalCenter
                    font.pointSize: 10
                }

                ComboBox {
                    id: serialPortCmb
                    width: 200
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    model: [ "Banana", "Apple", "Coconut" ]
                }
            }

            Row{
                id: baudRateRow
                anchors.right: serialPortRow.right
                anchors.rightMargin: 0
                anchors.top: serialPortRow.bottom
                anchors.topMargin: 15
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 15


                Label {
                    id: baudRateLbl
                    text: "Baud Rate:"
                    anchors.right: baudRateCmb.left
                    anchors.rightMargin: 15
                    anchors.verticalCenter: baudRateCmb.verticalCenter
                    font.pointSize: 10

                }
                ComboBox {
                    id: baudRateCmb
                    width: 200
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    model: [ "Banana", "Apple", "Coconut" ]
                }
            }

            Row {
                id: dataBitsRow
                anchors.right: baudRateRow.right
                anchors.rightMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 55
                anchors.top: baudRateRow.bottom
                anchors.bottomMargin: 15

                Label {
                    id: dataBitsLbl
                    text: "Data Bits:"
                    anchors.right: dataBitsCmb.left
                    anchors.rightMargin: 15
                    anchors.verticalCenter: dataBitsCmb.verticalCenter
                    font.pointSize: 10

                }
                ComboBox {
                    id: dataBitsCmb
                    width: 200
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    model: [ "Banana", "Apple", "Coconut" ]
                }
            }

            Row{
                id: parityRow
                anchors.right: dataBitsRow.right
                anchors.rightMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: dataBitsRow.bottom
                anchors.topMargin: 55
                anchors.bottomMargin: 15

                Label {
                    id: parityLbl
                    text: "Parity:"
                    anchors.right: parityCmb.left
                    anchors.rightMargin: 15
                    anchors.verticalCenter: parityCmb.verticalCenter
                    font.pointSize: 10

                }
                ComboBox {
                    id: parityCmb
                    width: 200
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    model: [ "Banana", "Apple", "Coconut" ]
                }
            }

            Row{
                id: stopBitsRow
                anchors.right: parityRow.right
                anchors.rightMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 55
                anchors.top: parityRow.bottom
                anchors.bottomMargin: 15

                Label {
                    id: stopBitsLbl
                    text: "Stop Bits:"
                    anchors.right: stopBitsCmb.left
                    anchors.rightMargin: 15
                    anchors.verticalCenter: stopBitsCmb.verticalCenter
                    font.pointSize: 10

                }
                ComboBox {
                    id: stopBitsCmb
                    width: 200
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    model: [ "Banana", "Apple", "Coconut" ]
                }
            }

            Row{
                id: flowCntrlRow
                anchors.right: stopBitsRow.right
                anchors.rightMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 55
                anchors.top: stopBitsRow.bottom
                anchors.bottomMargin: 15

                Label {
                    id: flowCntrlLbl
                    text: "Flow Control:"
                    anchors.right: flowCntrlCmb.left
                    anchors.rightMargin: 15
                    anchors.verticalCenter: flowCntrlCmb.verticalCenter
                    font.pointSize: 10

                }
                ComboBox {
                    id: flowCntrlCmb
                    width: 200
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    model: [ "Banana", "Apple", "Coconut" ]
                }
            }

        }

        //        Button {
        //            text: "BuggieWoogie"
        //            anchors.margins: 10
        //        }

    }
}

/*##^## Designer {
    D{i:17;invisible:true}D{i:20;invisible:true}
}
 ##^##*/
