import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import ".."

Notch {
    notchWidth: 100
    notchHeight: 40
    ThemedText {
        id: clock

        font {
            pointSize: 12
        }

        anchors.centerIn: parent

        color: 'white'

        Process {
            id: dateProc
            command: ["date", "+%H:%M:%S"]
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
