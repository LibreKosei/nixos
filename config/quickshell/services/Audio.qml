pragma Singleton
import Quickshell
import Quickshell.Services.Pipewire
import QtQml
import QtQml.Models

Singleton {
    id: root

    property PwNode sink: Pipewire.defaultAudioSink
    property real maxVol: 150
    readonly property real dsVol: Math.min(Math.floor(sink.audio.volume * 100), maxVol)

    PwObjectTracker {
        objects: [sink, Pipewire.defaultAudioSource]
    }

    function getIconName(node: PwNode): string {
        if (!node.ready || node.audio == null || node.audio.muted) { return "audio-volume-muted-symbolic" }
        const vol = node.audio.volume * 100
        if (100 <= vol) {
            return "audio-volume-overamplified-symbolic"
        } else if (70 <= vol) {
            return "audio-volume-high-symbolic"
        } else if (40 <= vol) {
            return "audio-volume-medium-symbolic"
        } else if (1 <= vol) {
            return "audio-volume-low-symbolic"
        } else { return "audio-volume-muted-symbolic" }
    }

    ListModel {
        id: sinks
    }

    PwNodeLinkTracker {
        id: linkTracker
        node: sink
    }

    Connections {
        target: Pipewire.nodes

        // Insert only non-existent sink node
        function onObjectInsertedPost(object, index) {
            if (!object.isSink) return
            for (let i = 0; i < sinks.count; i++) {
                const sink = sinks.get(i)
                if (sink === object) {
                    return
                } else {
                    sinks.append(object)
                }
            }
        }

        // Remove the correct sink
        function onObjectRemovedPost(object, _) {
            if (!object.isSink) return
            for (let i = 0; i < sinks.count; i++) {
                const sink = sinks.get(i)
                if (sink === object) {
                    sinks.remove(i)
                } else {
                    return       
                }
            }
        }
    }

    property alias sinks: sinks
    property alias linkTracker: linkTracker
    property bool ready: Pipewire.defaultAudioSink?.ready ?? false
    readonly property PwNode source: Pipewire.defaultAudioSource 
}
