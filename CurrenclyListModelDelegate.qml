import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ItemDelegate {
    required property string charCode
    required property string imageSource
    required property string fullInfo
    property int toolTipDelay: 750

    // ToolTip.text: fullInfo
    // ToolTip.delay: toolTipDelay
    // hoverEnabled: true
    // ToolTip.visible: hovered
    contentItem: RowLayout {
        Image {
            id: svgTest
            source: imageSource
            sourceSize: Qt.size(img.sourceSize.width / 12,
                                img.sourceSize.height / 12)
            // base qml stuff i guess :
            // https://forum.qt.io/topic/52161/properly-scaling-svg-images/2
            Image {
                id: img
                source: parent.source
                width: 0
                height: 0
            }
        }

        Text {
            text: charCode
            color: "#26278D"
            font {
                pixelSize: 20
                bold: true
            }
            // verticalAlignment: Text.AlignVCenter
        }
    }
}
