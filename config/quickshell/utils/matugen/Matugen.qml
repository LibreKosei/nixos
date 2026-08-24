pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    function generate(image: string, mode: string) {
        Quickshell.execDetached(["matugen", 
            "-t", "scheme-neutral", 
            "--prefer", "darkness",
            // "--source-color-index", "0",
            "-m", mode, "image", image
        ])
    }
}
