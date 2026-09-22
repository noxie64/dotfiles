import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import ".."

Notch {
    padding: 10
    ThemedText {
        id: clock

        font {
            pointSize: 10
        }

        Layout.alignment: Qt.AlignVCenter

        color: 'white'

        Process {
            id: dateProc
            command: ["date", "+%H:%M"]
            running: true

            stdout: StdioCollector {
                onStreamFinished: clock.text = this.text
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: dateProc.running = true
        }
    }
}
