import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import qs.services
import qs.modules.common
import qs.settings
import qs.modules.bar.start
import qs.modules.bar.center
import qs.modules.bar.end
import qs.config

// qmllint disable uncreatable-type
PanelWindow {
    // qmllint enable
    id: bar

    implicitWidth: screen.width
    implicitHeight: 64
    color: Qt.alpha(Colors.md3.surface_container, 1)
    WlrLayershell.layer: WlrLayer.Overlay

    anchors {
        bottom: true 
    }

    Item {
        anchors {
            fill: parent
        }

        Start {
            id: leftGroup

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 100                                      
                right: center.left 
            }
        }

        Center {
            id: center
            anchors.centerIn: parent
        }

        End {
            id: rightGroup

            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.verticalCenter: parent.verticalCenter

            Clicker {
                backgroundColor: Colors.md3.error_container
                Icon {
                    id: powerButton
                    iconName: "system-shutdown-symbolic"
                    iconColor: Colors.md3.on_error_container
                }
                TapHandler {
                    onTapped: States.showQS = !(States.showQS)
                }
            }
        }
    }
}
