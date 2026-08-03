pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property color background: "#141b1e"
    readonly property color lighterBackground: "#232a2d"
    readonly property color red: "#E57474"
    readonly property color green: "#8CCF7E"
    readonly property color yellow: "#E5C76B"
    readonly property color blue: "#67B0E8"
    readonly property color magenta: "#C47FD5"
    readonly property color cyan: "#6CBFBF"
    readonly property color lightGray: "#B3B9B8"
    readonly property color white: "#DADADA"

    readonly property string fontFamily: "JetBrainsMono Nerd Font"

    property alias persistent: persistentProps
    property alias wallpaper: wallpaperConfig
    property alias padding: paddingSize
    property alias radius: radiusSize
    property alias spacing: spacingSize
    property alias icon: iconSize
    property alias typography: tg

    QtObject {
        id: wallpaperConfig

        readonly property string homeDir: Quickshell.env("HOME")
        property string directory: "/Pictures/Wallpapers/"
        property string filename: "minimalism-mountains.jpg"
        readonly property string image: homeDir + directory + filename
    }

    QtObject {
        id: paddingSize

        property real small: 8
        property real medium: 12
        property real large: 16
        property real xl: 20
    }

    QtObject {
        id: radiusSize

        property real small: 8
        property real medium: 12
        property real large: 16
        property real xl: 20
    }

    QtObject {
        id: spacingSize

        property real small: 8
        property real medium: 12
        property real large: 16
        property real xl: 20
    }

    QtObject {
        id: iconSize

        property real small: 12
        property real medium: 16
        property real large: 24
        property real xl: 32
    }

    QtObject {
        id: tg

        property string fontFamily: "JetBrainsMono Nerd Font"

        property real small: 14
        property real medium: 18
        property real large: 22

        property real heading01: 48
        property real heading02: 44
        property real heading03: 40
    }

    PersistentProperties {
        id: persistentProps
        reloadableId: "persistentStates"
        property bool showBar: true
        property bool showLauncher: false
        property bool locked: false
    }
}
