import QtQuick
import QtQuick.Controls.Universal
import QtQuick.Layouts

Window {
    id: root
    width: 360
    height: 519
    visible: true
    title: qsTr("Currency Converter")

    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width

    color: "#eef2f8"

    ColumnLayout {
        id: rootLayout
        width: parent.width
        height: parent.height - 140
        anchors {
            verticalCenter: parent.verticalCenter
            // margins: 20
        }

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * (1 / 10)
            text: "Currency converter"
            horizontalAlignment: Text.AlignHCenter
            color: "#1F2261"
            font {
                pixelSize: 25
                bold: true
            }
        }

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * (1 / 13)
            text: "Check live rates, set rate alerts, receive notifications and more."
            Layout.bottomMargin: 10
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            color: "#808080"
            font.pixelSize: 16
        }

        Item {
            Layout.preferredHeight: 10
        }

        Converter {
            Layout.preferredWidth: parent.width - 40
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: parent.height * (5 / 8)
        }

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * (1 / 10)
            text: "Indicative Exchange Rate"
            Layout.topMargin: 10
            Layout.leftMargin: 20
            color: "#A1A1A1"
            font.pixelSize: 16
        }

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * (1 / 9)
            text: "1 SGD = 0.7367 USD"
            Layout.leftMargin: 20
            color: "black"
            font {
                pixelSize: 18
                bold: true
            }
        }


    }
}
