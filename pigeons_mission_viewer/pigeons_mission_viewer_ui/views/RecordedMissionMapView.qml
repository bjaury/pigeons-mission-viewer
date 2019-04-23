import QtQuick 2.10
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Controls 1.4
import PIGEONS_MISSION_VIEWER 1.0
import Esri.ArcGISRuntime 100.4

Item {
    property string azContent;
    property string gpsContent;
    property string statusColor: "grey"

    // Create a scene view
    SceneView {
        anchors.fill: parent

        // create a scene...scene is a default property of sceneview
        // and thus will get added to the sceneview
        Scene {
            // add a basemap
            //BasemapImagery {}
            BasemapOpenStreetMap {}


            // add a surface...surface is a default property of scene
            //            Surface {
            //                // add an arcgis tiled elevation source...elevation source is a default property of surface
            //                ArcGISTiledElevationSource {
            //                    url: "https://elevation3d.arcgis.com/arcgis/rest/services/WorldElevation3D/Terrain3D/ImageServer"
            //                }
            //            }
        }

        // add a graphics overlay
        GraphicsOverlay {
            id: graphicsOverlay
            LayerSceneProperties {
                surfacePlacement: Enums.SurfacePlacementAbsolute
            }
        }

        Component.onCompleted: {
            // set viewpoint to the specified camera
            setViewpointCameraAndWait(camera);
            addSymbols(missionModel);

        }
    }

    // create the camera to be used as the scene view's viewpoint
    Camera {
        id: camera
        location: Point {
            //            x: 45
            //            y: 34

            x: missionModel.get(0).lon
            y: missionModel.get(0).lat
            z: 3000
            spatialReference: SpatialReference { wkid: 4326 }
        }
        heading: 0
        pitch: 0
        roll: 0
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
                            displayMeasurementData(num - 1, missionModel);

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
            model: missionModel
            delegate: pointsListDelegate
            //highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            focus: true
        }


    }



    ListModel
    {
        id: missionModel

        ListElement {
            num: 1
            time: "15:0401"
            lat: 29.304938
            lon:-81.117262
            alt: 5
            measured: 288.716583
            theoretical: 292.8659262
        }

        ListElement {
            num: 2
            time: "15:0406"
            lat: 29.304975
            lon:-81.11722
            alt: 5
            measured: 288.432037
            theoretical: 293.5083755
        }

        ListElement {
            num: 3
            time: "15:0411"
            lat: 29.305038
            lon:-81.117142
            alt: 5
            measured: 289.081512
            theoretical: 294.6467839
        }

        ListElement {
            num: 4
            time: "15:0416"
            lat: 29.305338
            lon:-81.116775
            alt: 5
            measured: 295.380157
            theoretical: 300.2934286
        }

        ListElement {
            num: 5
            time: "15:0421"
            lat: 29.305365
            lon:-81.116743
            alt: 5
            measured: 295.801392
            theoretical: 300.8137387
        }

        ListElement {
            num: 6
            time: "15:0426"
            lat: 29.305993
            lon:-81.116495
            alt: 5
            measured: 306.948547
            theoretical: 309.5045668
        }

        ListElement {
            num: 7
            time: "15:0431"
            lat: 29.30696
            lon:-81.116477
            alt: 5
            measured: 315.26236
            theoretical: 318.2667841
        }

        ListElement {
            num: 8
            time: "15:0436"
            lat: 29.307857
            lon:-81.11642
            alt: 5
            measured: 324.747314
            theoretical: 324.7283297
        }

        ListElement {
            num: 9
            time: "15:0441"
            lat: 29.307942
            lon:-81.116415
            alt: 5
            measured: 325.889069
            theoretical: 325.2572681
        }

        ListElement {
            num: 10
            time: "15:0446"
            lat: 29.30811
            lon:-81.1164
            alt: 5
            measured: 325.905121
            theoretical: 326.3031523
        }

        ListElement {
            num: 11
            time: "15:0451"
            lat: 29.307557
            lon:-81.116463
            alt: 5
            measured: 319.010559
            theoretical: 322.5713058
        }

        ListElement {
            num: 12
            time: "15:0456"
            lat: 29.307095
            lon:-81.116498
            alt: 5
            measured: 315.322662
            theoretical: 319.1267837
        }

        ListElement {
            num: 13
            time: "15:0461"
            lat: 29.307095
            lon:-81.116498
            alt: 5
            measured: 315.322662
            theoretical: 319.1267837
        }

        ListElement {
            num: 14
            time: "15:0466"
            lat: 29.305757
            lon:-81.11652
            alt: 5
            measured: 307.351257
            theoretical: 306.8135497
        }

        ListElement {
            num: 15
            time: "15:0471"
            lat: 29.305673
            lon:-81.116543
            alt: 5
            measured: 305.526428
            theoretical: 305.7165398
        }

        ListElement {
            num: 16
            time: "15:0476"
            lat: 29.305673
            lon:-81.116543
            alt: 5
            measured: 305.526428
            theoretical: 305.7165398
        }

        ListElement {
            num: 17
            time: "15:0481"
            lat: 29.305317
            lon:-81.116872
            alt: 5
            measured: 293.257996
            theoretical: 299.4621114
        }

        ListElement {
            num: 18
            time: "15:0486"
            lat: 29.304872
            lon:-81.117322
            alt: 5
            measured: 285.252197
            theoretical: 291.7976144
        }


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

}



