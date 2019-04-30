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
                console.debug("Need to fix this to append everytime new ILS data comes in");
                appendToModel(fileIOController.jsonContents, missionModelVor);
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

