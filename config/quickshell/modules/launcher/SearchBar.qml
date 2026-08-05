import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.config
import qs.services

TextField {
    id: root
    
    placeholderText: qsTr("Search apps...")
    placeholderTextColor: Colors.md3.on_surface_variant
    focus: true
    text: Apps.text
    onTextEdited: Apps.text = text
    color: Colors.md3.on_surface

    background: Item {
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            radius: General.radius.small
            color: Colors.md3.surface_container
            border.width: 2
            border.color: Colors.md3.outline_variant
        }
    }
}
