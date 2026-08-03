import QtQuick
import qs.settings

Text {
    id: root

    /*
     * Defines the reserved width, measured in component's own font (JetBrainsMono Nerd Font).
     * Pass either:
     * - fixedChars: a literal template string, e.g. "WWWW"
     * - charCount: a count of "widest" reference glyphs 
     * If neither is set, the item sizes normally to its actual text.
     */

    property string fixedChars: ""
    property int charCount: 0
    property string referenceGlyph: "W"

    font.family: Config.typography.fontFamily
    font.pixelSize: Config.typography.small
    font.letterSpacing: 0

    renderType: Text.NativeRendering
    clip: true
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter

    TextMetrics {
        id: textMetrics

        font: root.font
        text: 0 < root.fixedChars.length
              ? root.fixedChars
              : root.referenceGlyph.repeat(Math.min(root.charCount, 1))
    }

    width: (0 < root.fixedChars.length || 0 < root.charCount)
            ? Math.ceil(textMetrics.width)
            : implicitWidth

    height: Math.ceil(0 < textMetrics.height ? textMetrics.height : implicitHeight)
}
