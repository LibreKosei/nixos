import QtQuick
import QtQuick.Layouts
import qs.settings
import qs.services
import qs.modules.common

FlexboxLayout {
    id: root
    
    alignItems: FlexboxLayout.AlignStart
    alignContent: FlexboxLayout.AlignCenter
    gap: Config.spacing.medium

    Clickable {
        Icon {
            id: bluetoothIcon
            iconColor: Bluetooth.anyDeviceConnected ? Config.blue : Config.white
            iconName: Bluetooth.getAdapterIcon(Bluetooth.adapter)
        }

        Icon {
            id: networkIcon
            iconName: Network.getWifiStatusIcon(Network.currentWifi)
        }


        Icon {
            id: volumeIcon
            iconName: Audio.getIconName(Audio.sink)
        }

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
            color: Config.white
        }
    }

    Clickable {
        Icon {
            id: powerButton
            iconName: "system-shutdown-symbolic"
            iconColor: Config.red
        }
    }
}
