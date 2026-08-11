import QtQuick
import qs.modules.common

Item {
    id: root

    implicitHeight: 64
    implicitWidth: 64
    property var wrapper
    property color iconColor

    Image {
        id: image

        source: Qt.resolvedUrl(root.wrapper.image)
        anchors.fill: parent
        visible: root.wrapper.image !== "" && image.status !== Image.Null
    }

    Icon {
        id: appIcon

        iconName: root.wrapper.appIcon
        anchors.fill: parent
        visible: root.wrapper.appIcon !== "" && root.wrapper.image === ""
    }

    Icon {
        id: fallback

        iconName: "dialog-information-symbolic"
        iconColor: root.iconColor
        anchors.fill: parent
        visible: root.wrapper.appIcon === "" && root.wrapper.image === "" || image.status === Image.NULL
    }
}
