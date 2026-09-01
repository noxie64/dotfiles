import Quickshell
import Quickshell.Io
import QtQuick
import "components/notch"

Variants {
    model: Quickshell.screens

    delegate: Component {
        PanelWindow {
            // the screen from the screens list will be injected into this
            // property
            required property var modelData

            // we can then set the window's screen to the injected property
            screen: modelData
            anchors {
                top: true;
                left: true;
                right: true;
            }

            color: "transparent"

            implicitHeight: 40

            TimeNotch {}
        }
    }
}
