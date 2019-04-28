import QtQuick 2.10
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Controls 1.4
import PIGEONS_MISSION_VIEWER 1.0
import Esri.ArcGISRuntime 100.4
//import "JSONListModel.qml" as jsonListModel

Item {
    property string statusColor: "grey"
    property double startLat;
    property double startLong;

    // Create a scene view
    SceneView {
        anchors.fill: parent

        // create a scene...scene is a default property of sceneview
        // and thus will get added to the sceneview
        Scene {
            // add a basemap
            BasemapOpenStreetMap {}
        }

        // add a graphics overlay
        GraphicsOverlay {
            id: graphicsOverlay
            LayerSceneProperties {
                surfacePlacement: Enums.SurfacePlacementAbsolute
            }
        }

        Component.onCompleted: {
            convertQStringtoModel(fileIOController.jsonContents, missionModelVor);
            startLat = missionModelVor.get(0).lat
            startLong = missionModelVor.get(0).lon;
            addSymbols(missionModelVor);
            var startingPoint = newPoint(startLong, startLat, 3000);
            // set viewpoint to the specified camera
            setViewpointCameraAndSeconds(camera.moveTo(startingPoint), 3);
        }
    }

    // create the camera to be used as the scene view's viewpoint
    Camera {
        id: camera
        location: Point {
            x: startLong
            y: startLat
            z: 3000
            spatialReference: SpatialReference { wkid: 4326 }
        }
        heading: 0
        pitch: 0
        roll: 0
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

    Rectangle {
        id: dataDisplayListViewRec

        width: 400
        height: 400

        anchors.right:parent.right
        anchors.bottom: parent.bottom
        color: "#cfcfcf"
        layer.enabled: true
        opacity: .8

        Component {
            id: pointsListDelegate
            Item {
                width: 90; height: 40;
                Rectangle{
                    width: parent.width
                    height: parent.height
                    border.width: 1
                    border.color: "black"
                    color: "grey"

                    MouseArea {
                        anchors.fill: parent

                        Text
                        {
                            id: txtLbl
                            text: 'Point: ' + num
                            font.bold: true
                            color: "white"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        onClicked:
                        {
                            console.log("Point: "+num+" clicked!");
                            pointsDisplay.visible = true;
                            displayMeasurementData(num - 1, missionModelVor);

                        }
                    }
                }
            }
        }

        Rectangle{
            id: pointsDisplay
            width: 310; height: parent.height;
            border.width: 1
            border.color: "black"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            visible: false

            Label
            {
                id: titleLbl
                text: "sample"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 18
                font.bold: true
                anchors.topMargin: 5
            }

            Row
            {
                id: dateRow
                anchors.top: titleLbl.bottom
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.topMargin: 10
                spacing: 5


                Label
                {
                    id: dateTitLbl
                    text: "Date:"
                    font.pointSize: 16
                    font.bold: true
                }

                Label
                {
                    id: dateLbl
                    text: "time"
                    font.pointSize: 16

                }
            }

            Row
            {
                id: locationRow
                anchors.top: dateRow.bottom
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.topMargin: 10
                spacing: 5


                Label
                {
                    id: locTitLbl
                    text: "Location:"
                    font.pointSize: 16
                    font.bold: true
                }

                Label
                {
                    id: latLbl
                    text: "lat"
                    font.pointSize: 16

                }

                Label
                {
                    id: longLbl
                    text: "long"
                    font.pointSize: 16

                }

            }

            Row
            {
                id: altRow
                anchors.top: locationRow.bottom
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.topMargin: 10
                spacing: 5


                Label
                {
                    id: altTitLbl
                    text: "Altitude:"
                    font.pointSize: 16
                    font.bold: true
                }

                Label
                {
                    id: altLbl
                    text: "alt"
                    font.pointSize: 16
                }
            }

            Row
            {
                id: measurementTypeRow
                anchors.top: altRow.bottom
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.topMargin: 10
                spacing: 5

                Label
                {
                    id: measTypeTitLbl
                    text: "Measurement Type:"
                    font.pointSize: 16
                    font.bold: true
                }

                Label
                {
                    id: measTypeLbl
                    text: "ilvor"
                    font.pointSize: 16

                }
            }

            Row
            {
                id: azmuthMeasuredRow
                anchors.top: measurementTypeRow.bottom
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.topMargin: 10
                spacing: 5

                Label
                {
                    id: azmuthMeasuredTitLbl
                    text: "Azmuth Measured:"
                    font.pointSize: 16
                    font.bold: true
                }

                Label
                {
                    id: azmuthMeasuredLbl
                    text: ".2"
                    font.pointSize: 16

                }
            }

            Row
            {
                id: azmuthTheoreticalRow
                anchors.top: azmuthMeasuredRow.bottom
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.topMargin: 10
                spacing: 5

                Label
                {
                    id: azmuthTheoreticalTitLbl
                    text: "Azmuth Theoretical:"
                    font.pointSize: 16
                    font.bold: true
                }

                Label
                {
                    id: azmuthTheoreticalLbl
                    text: ".3"
                    font.pointSize: 16

                }
            }

            Row
            {
                id: azmuthErrorRow
                anchors.top: azmuthTheoreticalRow.bottom
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.topMargin: 10
                spacing: 5


                Label
                {
                    id: azmuthErrorTitLbl
                    text: "Azmuth Error:"
                    font.pointSize: 16
                    font.bold: true
                }

                Label
                {
                    id: azmuthErrorLbl
                    text: "%"
                    font.pointSize: 16

                }
            }

            Row
            {
                id: readingStatusRow
                anchors.top: azmuthErrorRow.bottom
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.topMargin: 10
                spacing: 5


                Label
                {
                    id: readingStatusTitLbl
                    text: "Azmuth Status:"
                    font.pointSize: 16
                    font.bold: true
                }

                Label
                {
                    id: readingStatusLbl
                    text: "Acceptable"
                    color: statusColor
                    font.pointSize: 16

                }
            }
        }

        ListView {
            anchors.fill: parent
            model: missionModelVor
            delegate: pointsListDelegate
            focus: true
        }
    }

    ListModel
    {
        id: missionModelVor
    }

    // function to dynamically create the graphics and add them to the graphics overlay
    function addSymbols(dataModel) {
        for (var i = 0; i < dataModel.count; i++) {
            var elem = dataModel.get(i);

            var err = calculateError(elem.theoretical, elem.measured);
            calculateErrorColor(err);



            // create a simple marker scene symbol
            var smss = ArcGISRuntimeEnvironment.createObject("SimpleMarkerSceneSymbol", {
                                                                 style: Enums.SimpleMarkerSceneSymbolStyleCylinder,
                                                                 color: statusColor,
                                                                 width: 13,
                                                                 height: elem.alt, //height or altitude of point taken
                                                                 depth: 13,
                                                                 anchorPosition: Enums.SceneSymbolAnchorPositionCenter

                                                             });

            var ts = ArcGISRuntimeEnvironment.createObject("TextSymbol", {
                                                               text: elem.num,
                                                               color: "black"
                                                           });


            // create a new point geometry
            var point = ArcGISRuntimeEnvironment.createObject("Point", {
                                                                  y: elem.lat, //+ 0.001,
                                                                  x: elem.lon, //+ 0.0045,
                                                                  z: 0,
                                                                  spatialReference: SpatialReference.createWgs84()
                                                              });

            // create a graphic using the point and the symbol
            var cylGraphic = ArcGISRuntimeEnvironment.createObject("Graphic", {
                                                                       geometry: point,
                                                                       symbol: smss
                                                                   });

            var txtGraphic = ArcGISRuntimeEnvironment.createObject("Graphic", {
                                                                       geometry: point,
                                                                       symbol: ts
                                                                   });

            // add the graphic to the graphics overlay
            graphicsOverlay.graphics.append(cylGraphic);
            graphicsOverlay.graphics.append(txtGraphic);
            //console.log("i:" + i + " count: "+dataModel.count);

        }
    }

    function displayMeasurementData(index, dataModel)
    {
        var elem = dataModel.get(index);
        var err = calculateError(elem.theoretical, elem.measured)
        calculateErrorColor(err);


        titleLbl.text = "Point " + elem.num;
        dateLbl.text = elem.time
        latLbl.text = elem.lat;
        longLbl.text = ", " + elem.lon;
        altLbl.text = elem.alt;
        measTypeLbl.text = "VOR";
        azmuthMeasuredLbl.text = elem.theoretical;
        azmuthTheoreticalLbl.text = elem.measured;
        readingStatusLbl.text = calculateErrorLabel(err)
        azmuthErrorLbl.text = err + "°";
    }

    function calculateError(theo, measured)
    {
        var error = Math.abs(theo - measured).toFixed(2);
        return error;
    }

    function calculateErrorColor(err)
    {
        if(err >=0 && err <=3)
        {
            statusColor = "green";
        }else if(err > 3 && err <=6)
        {
            statusColor = "yellow";
        }else if(err > 6)
        {
            statusColor = "red";
        }
    }

    function calculateErrorLabel(err)
    {
        var txt = "Null"

        if(err >=0 && err <=3)
        {
            txt = "Acceptable";
        }else if(err > 3 && err <=6)
        {
            txt = "Needs Improvement";
        }else if(err > 6)
        {
            txt = "Unacceptable";
        }

        return txt;
    }

    function convertQStringtoModel(contents, model)
    {
        var jsonObject= JSON.parse(contents);
        for(var i in jsonObject){
            model.append(jsonObject[i])
        }
    }

    function newPoint(nX, nY, nZ)
    {

        var point = ArcGISRuntimeEnvironment.createObject("Point", {
                                                              y:  nY, //+ 0.001,
                                                              x: nX, //+ 0.0045,
                                                              z: nZ,
                                                              spatialReference: SpatialReference.createWgs84()
                                                          });
        return point;
    }

}
