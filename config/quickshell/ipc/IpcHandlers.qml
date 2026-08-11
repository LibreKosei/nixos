import Quickshell
import Quickshell.Io
import qs.services
import qs.settings
import qs.utils.matugen
import qs.config

Scope {
    id: root

    readonly property string shell: "shell"
    readonly property string locker: "locker"
    readonly property string brightness: "brightness"
    readonly property string idle: "idle"
    readonly property string util: "util"

    IpcHandler {
        target: root.shell
        function toggleLauncher() { States.showLauncher = !(States.showLauncher) }
    }

    IpcHandler {
        target: root.locker
        function lock() { Idle.lock() }
    }

    IpcHandler {
        target: root.brightness
        function increase(percent: int) { Brightness.increase(percent) }
        function decrease(percent: int) { Brightness.decrease(percent) }
    }

    IpcHandler {
        target: root.idle
        function status() { console.log("[Idle Daemon] active: ", Idle.active) }
    }

    IpcHandler {
        target: root.util
        function generate(image: string, mode: string) { Matugen.generate(image, mode) }
    }
}
