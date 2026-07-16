//@ pragma IconTheme Adwaita
import Quickshell
import qs.modules.bar

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens
        Bar {
            required property var modelData
            screen: modelData
        }
    }
}
