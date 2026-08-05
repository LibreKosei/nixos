//@ pragma IconTheme Pebble
import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.modules.bar
import qs.modules.launcher
import qs.modules.osd
import qs.modules.lockscreen
import qs.modules.background
import qs.services
import qs.settings
import qs.ipc

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens
        delegate: PanelWindow {
            id: toplevel
            required property var modelData
            screen: modelData
            color: "transparent"
            WlrLayershell.layer: WlrLayer.Background
            exclusionMode: ExclusionMode.Ignore
            anchors {
                left: true
                right: true
                top: true
                bottom: true
            }

            Wallpaper {
                id: background

                anchors.fill: parent
                setWallpaper: true
            }

            LazyLoader {
                loading: true
                Bar {
                    screen: toplevel.modelData  
                }
            }

            LazyLoader {
                Launcher {
                    screen: toplevel.modelData
                }
                activeAsync: Config.persistent.showLauncher    
            }

            VolumeOSD {}

            LockScreen {}

            IpcHandlers {}
        }
    }
}
