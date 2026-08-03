pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import QtQml

Singleton {
    id: root

    property real max
    property real current

    Process {
        id: maxProc
        running: false
        command: ["brightnessctl", "m"]
        stdout: StdioCollector {
            onStreamFinished: root.max = parseInt(this.text, 10)
        }
    }

    Process {
        id: currentProc
        running: false
        command: ["brightnessctl", "g"]
        stdout: StdioCollector {
            onStreamFinished: () => {
                root.current = parseInt(this.text, 10)
            }
        }
    }

    Component.onCompleted: {
        maxProc.running = true
        currentProc.running = true
    }

    function decrease(percent: real) { 
        Quickshell.execDetached(["brightnessctl", "s", `${percent}%-`])
        currentProc.running = true
    }

    function increase(percent: real) {
        Quickshell.execDetached(["brightnessctl", "s", `+${percent}%`])
        currentProc.running = true
    }

    function restore() {
        Quickshell.execDetached(["brightnessctl", "--restore"])
    }

    function save() {
        Quickshell.execDetached(["brightnessctl", "--save"])
    }
}
