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
                liveMissionMapView.setCameraPoint(29.307844, -81.1198912);
            }
        }

    Connections {
    target: communicationController

    onNewPointAdded: {
        appendToModel(communicationController.newPoint, missionModelVor);
        liveMissionMapView.addSymbols(missionModelVor);
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

