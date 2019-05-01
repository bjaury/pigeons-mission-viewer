import QtQuick 2.10
import QtQuick.Controls 1.4
import PIGEONS_MISSION_VIEWER 1.0

Item {
    PIGEONSMapView {
        id: liveMissionMapView
        anchors.fill: parent
        pointsModel: missionModelVor

        Component.onCompleted: {
            xBeeController.sendXbeeMessage('Send Data Down')
            liveMissionMapView.setCameraPoint(pigeonsMissionModel.airportLat, pigeonsMissionModel.airportLong);
        }
    }

    Connections {
        target: communicationController

        onNewPointAdded: {
            appendToModel(communicationController.newPoint, missionModelVor);
            liveMissionMapView.addSymbols(missionModelVor);
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
            id: missionTypeLbl
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: pigeonsMissionModel.missionType
            color: "white"
        }

        Label
        {
            id: connectionStatusTitleLbl
            anchors.right: connectionStatus.left
            anchors.verticalCenter: parent.verticalCenter
            text: "Status: "
            color: "white"
            font.bold: true
        }

        Label
        {
            id:  connectionStatus
            text: communicationController.connectionStatus
            color: "green"
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

    function appendToModel(contents, model)
    {
        var jsonObject= JSON.parse(contents);
        for(var i in jsonObject){
            model.append(jsonObject[i])
        }
    }
}

