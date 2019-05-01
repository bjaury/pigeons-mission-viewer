import QtQuick 2.10
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Controls 1.4
import PIGEONS_MISSION_VIEWER 1.0
import Esri.ArcGISRuntime 100.4
import "../js/calculations.js" as Calc

Item {
    property string statusColor: "grey"
    property double startLat;
    property double startLong;
    property QtObject pointsModel;

    // Create a scene view
    SceneView {
        id: sceneView
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
            startLat = pointsModel.get(0).lat
            startLong = pointsModel.get(0).lon;
            addSymbols(pointsModel);
            setCameraPoint(startLat, startLong)

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

    // function to dynamically create the graphics and add them to the graphics overlay
    function addSymbols(dataModel) {
        for (var i = 0; i < dataModel.count; i++) {
            var elem = dataModel.get(i);

            var err = Calc.calculateError(elem.theoretical, elem.measured);



            // create a simple marker scene symbol
            var smss = ArcGISRuntimeEnvironment.createObject("SimpleMarkerSceneSymbol", {
                                                                 style: Enums.SimpleMarkerSceneSymbolStyleCylinder,
                                                                 color: Calc.calculateErrorColor(err),
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

    function setCameraPoint(lat, lon)
    {
        var newCameraPoint = newPoint(lon, lat, 3000);
        // set viewpoint to the specified camera
        sceneView.setViewpointCameraAndSeconds(camera.moveTo(newCameraPoint), 3);

    }
}
