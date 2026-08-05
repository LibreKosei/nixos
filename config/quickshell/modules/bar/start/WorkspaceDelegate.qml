import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell.WindowManager
import qs.settings
import qs.modules.common

Clickable {
    id: root
    
    required property Windowset ws
    property color txtColor: modelData?.active 
                              ? Config.blue 
                              : Config.white

    bgColor: Config.lighterBackground 
    
    contentItem: Item {
        implicitWidth: txt.width
        implicitHeight: implicitWidth
        MonoText {
            anchors.centerIn: parent
            id: txt
            text: root.modelData?.name        
            color: root.txtColor
        }
    }

    onClicked: () => {
        if (root.ws?.canActivate) modelData?.activate()
        return
    }
}
