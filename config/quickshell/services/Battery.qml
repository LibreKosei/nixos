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

      function roundDownStringWay(num) {
          const str = num.toString();
          // Keep the first character, pad the rest of the length with '0'
          const roundedStr = str[0].padEnd(str.length, '0');
          return roundedStr;
      }

      switch (root.mainBattery?.state) {
          case UPowerDeviceState.Discharging: 
              // console.log("[Battery] discharging")
              return put(roundDownStringWay(mbHealth))
          case UPowerDeviceState.Charging:
              // console.log("[Battery] charging")
              if (mbHealth >= 99) return put("100-charged")
              return put(`${roundDownStringWay(mbHealth)}-charging`)
          case UPowerDeviceState.PendingCharge:
              // console.log("[Battery] pending")
              return put(`${roundDownStringWay(mbHealth)}-plugged-in`)
          default:
              return "battery-missing-symbolic"
      }
    }
}
