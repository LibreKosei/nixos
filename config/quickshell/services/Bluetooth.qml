pragma Singleton
import Quickshell
import Quickshell.Bluetooth
import QtQuick
import QtQml.Models

Singleton {
    id: root

    ListModel {
        id: devices
    }

    property alias devices: devices

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property bool anyDeviceConnected: [...Bluetooth.devices.values].some(dev => dev.connected)

    function getAdapterIcon(adapter) {
        const prefix = "bluetooth-"
        const suffix = "-symbolic"
        function put(str) { return prefix + str + suffix }

        switch (adapter.state) {
            case BluetoothAdapterState.Enabled:
                return put("active")
            case BluetoothAdapterState.Disabled:
                return put("disabled")
            case BluetoothAdapterState.Blocked:
                return put("hardware-disabled")
            default:
                return put("acquiring")
        }
    }

    // function getDeviceBatteryIcon(device) {
    //     if (!device.batteryAvailable) return 
    // }

    Connections {
        target: Bluetooth.devices

        function onObjectInsertedPost(device, index) {
            insertObj(device, devices)
        }

        function onObjectRemovedPost(device, index) {
            removeObj(device, devices)
        }
    }
    
    function containObj(obj, listModel) {
        for (let i = 0; i < listModel.count; i++) {
            if (listModel.get(i).object === obj) return true  
        }
        return false
    }

    function insertObj(obj, listModel) {
        if (containObj(obj, listModel)) return
        listModel.append({ object: obj })
    }

    function removeObj(obj, listModel) {
        for (let i = 0; i < listModel.count; i++) {
            if (listModel.get(i).object === obj) {
                listModel.remove(i)
                return
            }   
        }
    }
}
