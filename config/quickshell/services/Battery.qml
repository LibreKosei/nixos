pragma Singleton
import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root

    readonly property UPowerDevice mainBattery: {
        var list = UPower.devices.values
        var bat = list.find((b) => b.isPowerSupply && b.ready && b.type === UPowerDeviceType.Battery )
        return bat
    }
}
