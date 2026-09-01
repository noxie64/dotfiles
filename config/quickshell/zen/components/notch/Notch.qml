import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

RowLayout {
    id: notch
    required property real notchHeight
    required property real notchWidth
    property real radius: 10
    property real sideBox: 20
    default property alias content: middle.data

    anchors.centerIn: parent
    notchHeight: parent.height
    spacing: 0

    Shape {
        Layout.fillHeight: true
        implicitWidth: notch.sideBox

        ShapePath {
            strokeWidth: 0
            fillColor: 'black'
            startX: 0
            startY: 0
            PathArc {
                x: notch.sideBox
                y: notch.sideBox
                radiusX: notch.sideBox
                radiusY: notch.sideBox
            }
            PathLine {
                x: notch.sideBox
                y: 0
            }
            PathLine {
                x: 0
                y: 0
            }
        }
    }
    Rectangle {
        id: middle
        height: notch.notchHeight
        implicitWidth: notch.notchWidth
        color: "black"
        bottomLeftRadius: notch.radius
        bottomRightRadius: notch.radius
    }

    Shape {
        Layout.fillHeight: true
        implicitWidth: notch.sideBox

        ShapePath {
            strokeWidth: 0
            fillColor: 'black'
            startX: 0
            startY: 0
            PathLine {
                x: notch.sideBox
                y: 0
            }
            PathArc {
                x: 0
                y: notch.sideBox
                radiusX: notch.sideBox
                radiusY: notch.sideBox
                direction: PathArc.Counterclockwise
            }
            PathLine {
                x: 0
                y: 0
            }
        }
    }
}
