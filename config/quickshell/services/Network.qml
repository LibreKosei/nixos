pragma Singleton 
import Quickshell
import Quickshell.Networking
import QtQml
import QtQml.Models

Singleton {
    id: root

    ListModel {
        id: wifiDevices
    }

    ListModel {
        id: wiredDevices
    }

    ListModel {
        id: wifiNetworks
    }

    ListModel {
        id: wiredNetworks
    }

    readonly property list<NetworkDevice> deviceList: [...Networking.devices.values]
    readonly property list<WifiNetwork> wifiList: {
        let networks = []
        for (let i = 0; i < wifiDevices.count; i++) {
            const device = wifiDevices.get(i).object
            if (device && device.networks) {
                networks = networks.concat([...device.networks.values])
            }
        }
        return networks
    }

    // Aliases
    property alias wifiDevices: wifiDevices
    property alias wiredDevices: wiredDevices
    property alias wifiNetworks: wifiNetworks
    property alias wiredNetworks: wiredNetworks

    ////////////////////////////////
    ///// Most important ones  /////
    ////////////////////////////////
    readonly property WifiDevice wifiDevice: {
        let i = 0
        if (wifiDevices.count === 0) return null;
        for (i; i < wifiDevices.count; i++) {
            const device = wifiDevices.get(i).object
            if (device.connected) {
                // console.log("[Network] A Wifi device found: ", device.name)
                return device
            }
        }
        return null
    }

    readonly property WifiNetwork currentWifi: {
        let i = 0
        if (wifiNetworks.count === 0) return null;
        for (i; i < wifiNetworks.count; i++) {
            const network = wifiNetworks.get(i).object
            if (network.connected) {
                // console.log("[Network] A connected wifi network found: ", network.name)
                return network
            }
        }
        return null
    }

    readonly property WiredDevice wiredDevice: {
        let i = 0
        if (wiredDevices.count === 0) return null;
        for (i; i < wiredDevices.count; i++) {
            const device = wiredDevices.get(i).object
            if (device.connected) {
                // console.log("[Network] A Wired device found: ", device.name)
                return device
            }
        }
        return null
    }

    function getWifiStatusIcon(wifi) {
        const prefix = "network-wireless-"
        const suffix = "-symbolic"
        function put(str) {
            return prefix + str + suffix
        }

        if (!wifi) return put("offline")
        if (!wifi.known) return put("no-route")
        if (wifi.stateChanging) return put("acquiring")
        if (wifi.state === ConnectionState.Disconnected) return put("offline")

        const s = wifi?.signalStrength * 100

        if (75 <= s) return put("signal-good")
        if (40 <= s) return put("signal-ok")
        if (15 <= s) return put("signal-weak")
        if (s <= 3) return put("signal-none")
    }

    ////////////////////
    // Internal impl ///
    ////////////////////
    onDeviceListChanged: (devices) => {
        let i = 0, j = 0
        for (i; i < deviceList.length; i++) {
            if (deviceList[i].type === DeviceType.Wifi) {
                // console.log("[Network] A device of wireless type captured") 
                insertObj(deviceList[i], wifiDevices)

            } else if (deviceList[i].type === DeviceType.Wired) {
                console.log("[Network] A device of wired type captured")
                insertObj(deviceList[i], wiredDevices) 

            } else {
                // console.log("[Network] A device of unknown type captured")
            }
        }
    }

    onWifiListChanged: () => {
        for (let i = 0; i < wifiList.length; i++) {
            insertObj(wifiList[i], wifiNetworks)
        }
        pruneStale(wifiList, wifiNetworks)
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

    function pruneStale(items, listModel) {
        for (let i = listModel.count - 1; i >= 0; i--) {
            if (!items.includes(listModel.get(i).object)) {
                listModel.remove(i)
            }
        }
    }
}
