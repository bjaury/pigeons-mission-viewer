import QtQuick 2.10
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Controls 1.4
import "../js/calculations.js" as Calc

Item {

    property QtObject numbersModel;

    Rectangle {
        id: dataDisplayListViewRec
        anchors.fill: parent
        color: "#cfcfcf"
        layer.enabled: true
        opacity: .8

        ListView {
            anchors.fill: parent
            model: numbersModel
            delegate: pointsListDelegate
            focus: true
        }

        Component {
            id: pointsListDelegate
            Item {
                width: 90; height: 40; anchors.left: parent.left
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
                            displayMeasurementData(num - 1, numbersModel);
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
                    color: recordedMissionMapView.statusColor
                    font.pointSize: 16
                }
            }
        }
    }

    function displayMeasurementData(index, dataModel)
    {
        var elem = dataModel.get(index);
        var err = Calc.calculateError(elem.theoretical, elem.measured)
        readingStatusLbl.color = Calc.calculateErrorColor(err);
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
