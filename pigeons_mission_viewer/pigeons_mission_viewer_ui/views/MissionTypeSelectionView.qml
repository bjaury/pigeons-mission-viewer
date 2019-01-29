import QtQuick 2.10
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.4


Item {

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
                text: "Please select and upload the QGroundControl Mission Plan file:"
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
                rows: 3
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
                    width: 75
                    model: ["ILS", "VOR", "ILS & VOR"]
                }

                Label {
                    id: missionTypeVORFreqLbl
                    text: "VOR Frequency"
                    font.pointSize: 12
                    font.bold: true

                }

                TextField {
                    id: vorFreqTxtInpt
                    width: 75
                    placeholderText: qsTr("VOR Frequency")
                    cursorVisible: false
                }

                Label {
                    id: missionTypeILSFreqLbl
                    text: "ILS Frequency"
                    font.pointSize: 12
                    font.bold: true

                }

                TextField {
                    id: ilsFreqTxtInpt
                    width: 75
                    placeholderText: qsTr("ILS Frequency")
                    cursorVisible: false
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


}








/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:5;anchors_height:170}
}
 ##^##*/
