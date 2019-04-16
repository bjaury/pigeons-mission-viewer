import QtQuick 2.10
import QtLocation 5.6
import QtPositioning 5.6
import PIGEONS_MISSON_VIEWER 1.0
import Esri.ArcGISRuntime 100.4

Item {

    property string azContent;
    property string gpsContent;

    // add a sceneView component
    SceneView {
        anchors.fill: parent

        // add a Scene to the SceneView
        Scene {
            // add the BasemapOpenStreetMap basemap to the scene
            BasemapOpenStreetMap {}

            // add a surface...surface is a default property of scene
            Surface {
                // add an arcgis tiled elevation source...elevation source is a default property of surface
                ArcGISTiledElevationSource {
                    url: "https://elevation3d.arcgis.com/arcgis/rest/services/WorldElevation3D/Terrain3D/ImageServer"
                }
            }
        }
    }


}

