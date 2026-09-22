import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

RowLayout {
    id: notch
    property real radius: 10
    property real sideBoxHeight: 15
    property real sideBoxWidth: 10
    default property alias content: middle.data
    property alias padding: middle.anchors.margins

    anchors.centerIn: parent
    spacing: 0

    Shape {
        Layout.fillHeight: true
        implicitWidth: notch.sideBoxHeight

        ShapePath {
            strokeWidth: 0
            fillColor: 'black'
            startX: 0
            startY: 0
            PathArc {
                x: notch.sideBoxWidth
                y: notch.sideBoxHeight
                radiusX: notch.sideBoxWidth
                radiusY: notch.sideBoxHeight
            }
            PathLine {
                x: notch.sideBoxWidth
                y: 0
            }
            PathLine {
                x: 0
                y: 0
            }
        }
    }

    Rectangle {
        id: wrapper
        RowLayout {
            id: middle
            anchors.fill: parent
        }
        bottomLeftRadius: notch.radius
        bottomRightRadius: notch.radius
        implicitWidth: middle.implicitWidth + 2 * notch.padding
        implicitHeight: middle.implicitHeight
        color: "black"
    }

    Shape {
        Layout.fillHeight: true
        implicitWidth: notch.sideBoxHeight

        ShapePath {
            strokeWidth: 0
            fillColor: 'black'
            startX: 0
            startY: 0
            PathLine {
                x: notch.sideBoxWidth
                y: 0
            }
            PathArc {
                x: 0
                y: notch.sideBoxHeight
                radiusX: notch.sideBoxWidth
                radiusY: notch.sideBoxHeight
                direction: PathArc.Counterclockwise
            }
            PathLine {
                x: 0
                y: 0
            }
        }
    }
}
