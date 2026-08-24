import QtQuick
import Quickshell
import QtQuick.Layouts
import qs.services
import qs.config
import qs.settings
import qs.modules.common

Item {
    id: root

    implicitHeight: 300

    GridLayout {
        id: grid

        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
            margins: General.margin.large
        }

        columns: 2
        columnSpacing: General.spacing.xl
        rowSpacing: General.spacing.large

        ToggleButton {
            Layout.fillWidth: true
            active: Bluetooth.anyDeviceConnected
            iconName: Bluetooth.getAdapterIcon(Bluetooth.adapter)
            iconColor: Bluetooth.anyDeviceConnected ? Config.blue : Config.white
            hasAction: true
        }

        ToggleButton {
            Layout.fillWidth: true
            active: 0 < Network.wifiNetworks.count || 0 < Network.wiredNetworks.count 
            iconName: Network.getWifiStatusIcon(Network.currentWifi)
            hasAction: true
        }

        ToggleButton {
            Layout.fillWidth: true
            active: Notification.dnd
            iconName: Notification.dnd 
                ? "notifications-disabled-symbolic" 
                : "preferences-system-notifications-symbolic"
            TapHandler { onTapped: () => Notification.dnd = !(Notification.dnd) }
        }

        ToggleButton {
            Layout.fillWidth: true
            iconName: "night-light-symbolic"
            active: Misc.wallpaper.dark
            onClicked: () => { Misc.wallpaper.dark = !(Misc.wallpaper.dark) }
            TapHandler {
                onTapped: () => { Misc.wallpaper.dark = !(Misc.wallpaper.dark) }
            }
        }

        ToggleButton {
            Layout.fillWidth: true
            active: States.caffein
            iconName: States.caffein 
                ? Quickshell.shellPath("assets/caffein-on-symbolic") 
                : Quickshell.shellPath("assets/caffein-off-symbolic")
            iconBrightness: 0.1

            TapHandler {
                onTapped: () => { States.caffein = !(States.caffein) }
            }
        }
    }
}
