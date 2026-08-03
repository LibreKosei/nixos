pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property string currentTime: Qt.formatDateTime(clock.date, "hh:mm:ss")

    SystemClock {
        id: clock 
        precision: SystemClock.Seconds
    }
}
