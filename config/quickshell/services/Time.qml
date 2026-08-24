pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property string currentTime: Qt.formatDateTime(clock.date, "hh:mm:ss")
    readonly property string minute: Qt.formatDateTime(clock.date, "hh:mm")

    SystemClock {
        id: clock 
        precision: SystemClock.Seconds
    }
}
