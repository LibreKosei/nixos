import QtQuick
import QtQuick.Layouts
import qs.settings
import qs.services
import qs.config
import qs.modules.bar
import qs.modules.common

Item {
    id: root

    implicitHeight: 75

    Rectangle {
        id: background

        color: Colors.md3.surface_container_high
        bottomRightRadius: General.radius.medium
        bottomLeftRadius: General.radius.medium
        anchors.fill: parent
    }

    RowLayout {
        id: row

        anchors.fill: parent
        anchors.rightMargin: General.margin.large
        anchors.leftMargin: General.margin.large
        spacing: 0

        Clicker {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            backgroundColor: "transparent"
            Icon {
                id: batteryIcon
                iconName: Battery.mbIcon 
                iconColor: {
                    const p = Math.floor(Battery.mainBattery?.percentage * 100)
                    if (p < 33) {
                        return Config.red
                    } else if (p < 45) {
                        return Config.yellow
                    } else {
                        return Config.green
                    }
                }
            }

            MonoText {
                id: batteryText
                text: 99 <= Battery.mbHealth ? "max" : `${Battery.mbHealth}%`
                charCount: 3
                color: Colors.md3.on_surface
            }
        }

        Clicker {
            backgroundColor: "transparent"
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

            Icon {
                iconColor: Colors.md3.on_surface
                iconName: "preferences-system-symbolic"
            }
        }
    }
}
