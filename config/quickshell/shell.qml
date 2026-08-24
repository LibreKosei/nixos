//@ pragma IconTheme Pebble
import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.modules.bar
import qs.modules.launcher
import qs.modules.osd
import qs.modules.lockscreen
import qs.modules.background
import qs.modules.notification
import qs.modules.panel
import qs.modules.notificationCenter
import qs.services
import qs.settings
import qs.ipc
import qs.config

ShellRoot {
    id: root

    settings.watchFiles: false

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
                activeAsync: States.showLauncher    
            }

            VolumeOSD {}

            LockScreen {}

            IpcHandlers {}

            NotificationPopup {
                screen: toplevel.modelData
            }

            LazyLoader {
                activeAsync: States.showQS
                Panel {
                    anchor.window: toplevel
                    anchor.rect.x: toplevel.screen.width - this.implicitWidth
                    anchor.rect.y: toplevel.screen.height - toplevel.implicitHeight
                }
            }

            LazyLoader {
                activeAsync: States.showNC
                NotificationCenter {
                    anchor.window: toplevel
                    anchor.rect.x: toplevel.screen.width / 2 - this.implicitWidth / 2
                    anchor.rect.y: toplevel.screen.height - toplevel.implicitHeight
                }
            }
        }
    }

    Component.onCompleted: {
        Idle.init()
        Notification.dnd = false
    }
}
