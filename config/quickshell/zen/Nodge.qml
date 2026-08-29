import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

RowLayout {
    id: notch
    property real radius: 10
    property real sideBoxWidths: 20

    anchors.centerIn: parent
    height: parent.height
    spacing: 0

    Shape {
        Layout.fillHeight: true
        implicitWidth: notch.sideBoxWidths

        ShapePath {
            strokeWidth: 0
            fillColor: 'black'
            startX: 0
            startY: 0
            PathArc {
                x: notch.sideBoxWidths
                y: notch.sideBoxWidths
                radiusX: notch.sideBoxWidths
                radiusY: notch.sideBoxWidths
            }
            PathLine {
                x: notch.sideBoxWidths; y: 0
            }
            PathLine {
                x: 0; y: 0
            }
        }
    }
    Rectangle {
        Layout.fillHeight: true
        implicitWidth: 200
        color: "black"
        bottomLeftRadius: notch.radius
        bottomRightRadius: notch.radius
    }

    Shape {
        Layout.fillHeight: true
        implicitWidth: notch.sideBoxWidths

        ShapePath {
            strokeWidth: 0
            fillColor: 'black'
            startX: 0
            startY: 0
            PathLine {
                x: notch.sideBoxWidths
                y: 0
            }
            PathArc {
                x: 0
                y: notch.sideBoxWidths
                radiusX: notch.sideBoxWidths
                radiusY: notch.sideBoxWidths
                direction: PathArc.Counterclockwise
            }
            PathLine {
                x: 0; y: 0
            }
        }
    }
}
