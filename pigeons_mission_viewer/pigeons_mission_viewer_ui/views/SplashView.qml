import QtQuick 2.9

Item {
    Rectangle {
        width: 1200
        height: 1200
        anchors.fill: parent
        color: "#ffffff"
        Text {
            anchors.centerIn: parent
            text: "PIGEONS Mission Viewer 1.0"
            font.pointSize: 20
            font.family: "Courier"
            font.weight: Font.ExtraBold
            anchors.verticalCenterOffset: 303
            anchors.horizontalCenterOffset: 1
        }

        Image {
            id: image
            x: 202
            y: 213
            width: 596
            height: 575
            fillMode: Image.PreserveAspectFit
            source: "../assets/pigeons_Logo_596x575.png"
        }
    }
}
