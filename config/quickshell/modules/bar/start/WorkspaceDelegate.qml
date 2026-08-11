import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell.WindowManager
import qs.settings
import qs.config
import qs.modules.common

Clickable {
    id: root
    
    required property Windowset ws
    property color txtColor: modelData?.active 
                              ? Colors.md3.primary
                              : Colors.md3.outline

    bgColor: Colors.md3.surface_container 
    radius: General.radius.medium
    
    contentItem: Item {
        implicitWidth: txt.width
        implicitHeight: implicitWidth
        MonoText {
            anchors.centerIn: parent
            id: txt
            text: root.modelData?.name        
            color: root.txtColor
            font.underline: root.ws?.active
        }
    }

    onClicked: () => {
        if (root.ws?.canActivate) modelData?.activate()
        return
    }
    Component.onCompleted: console.log("Workspace Icon: height", implicitHeight)
}
