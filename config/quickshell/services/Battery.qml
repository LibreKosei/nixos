pragma Singleton
import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root

    readonly property var mainBattery: {
        var list = UPower.devices.values
        var bat = list.find((b) => b.isLaptopBattery)
        return bat
    }

    readonly property real mbHealth: Math.floor(mainBattery?.percentage * 100)
    readonly property string mbIcon: {

      const prefix = "battery-level-"
      const suffix = "-symbolic"

      function put(status: string): string {
          return prefix + status + suffix
      }

      switch (mainBattery?.state) {
          case UPowerDevice.Discharging: 
              return put(`${Math.floor(mbHealth / 10)}`)
          case UPowerDevice.Charging:
              return put(`${Math.floor(mbHealth / 10)}-charging`)
          case UPowerDevice.PendingCharge:
              return put(`${Math.floor(mbHealth / 10)}-plugged`)
          default:
              return "battery-missing-symbolic"
      }
    }
}
