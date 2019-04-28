import QtQuick 2.10
import QtQuick.Controls 1.4
import PIGEONS_MISSION_VIEWER 1.0

Item {

    PIGEONSMapView {
        id: recordedMissionMapView
        anchors.fill: parent
        pointsModel: missionModelVor

        Component.onCompleted:
        {
            convertQStringtoModel(fileIOController.jsonContents, missionModelVor);
        }
    }

    Rectangle {
        id: missionParameterRectangle
        width: parent.width
        height: 35
        color: "black"
        opacity: .7
        anchors.top: parent.top

        Label
        {
            id: previousMissionFileName
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: fileIOController.logFilePath
            color: "white"
        }

        Label
        {
            id: missionTypeTitleLbl
            anchors.right: missionTypeLbl.left
            anchors.verticalCenter: parent.verticalCenter
            text: "Mission: "
            color: "white"
            font.bold: true
        }

        Label
        {
            id: missionTypeLbl
            text: fileIOController.missionType
            color: "white"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10
        }
    }

    VORPointsDisplay {
        id: vorPointsDisplay
        width: 400
        height: 400
        anchors.right:parent.right
        anchors.bottom: parent.bottom
        numbersModel: missionModelVor
    }

    ListModel
    {
        id: missionModelVor
    }

    function convertQStringtoModel(contents, model)
    {
        var jsonObject= JSON.parse(contents);
        for(var i in jsonObject){
            model.append(jsonObject[i])
        }
    }
}
