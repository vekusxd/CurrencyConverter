import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ItemDelegate {
    required property string charCode
    required property string imageSource
    contentItem: RowLayout {

        Image {
            id: svgTest
            source: imageSource
            sourceSize: Qt.size(img.sourceSize.width / 20,
                                img.sourceSize.height / 20)
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
            // verticalAlignment: Text.AlignVCenter
        }
    }
}
