import QtQuick
import QtQuick.Controls.Universal
import QtQuick.Layouts
import CurrencyModel

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
            Layout.preferredHeight: parent.height * (1 / 8)
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
            Layout.preferredHeight: parent.height * (1 / 10)
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

        Rectangle {
            color: "white"
            Layout.preferredWidth: parent.width - 40
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: parent.height * (4 / 7)
            radius: 20
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
            Layout.preferredHeight: parent.height * (1 / 7)
            text: "1 SGD = 0.7367 USD"
            Layout.leftMargin: 20
            color: "black"
            font {
                pixelSize: 18
                bold: true
            }
        }
    }

    // Rectangle {
    //     width: 310
    //     height: 250
    //     color: "#f6f6f6"
    //     // anchors.centerIn: parent
    //     radius: 3.0
    // ColumnLayout {
    //     // anchors.fill: parent
    //     RowLayout {
    //         ComboBox {
    //             id: comboBox1
    //             model: currencyModel
    //             textRole: "fullInfo"
    //             currentIndex: 31 //ruble index
    //             delegate: ItemDelegate {
    //                 required property string fullInfo
    //                 text: fullInfo
    //             }
    //         }
    //         TextField {
    //             id: textField1
    //             validator: IntValidator {
    //                 bottom: 1
    //                 top: 1000
    //             }
    //         }
    //     }

    //     RowLayout {
    //         ComboBox {
    //             id: comboBox2
    //             model: currencyModel
    //             textRole: "fullInfo"
    //             currentIndex: 39 //usd index
    //             delegate: ItemDelegate {
    //                 required property string fullInfo
    //                 text: fullInfo
    //             }
    //         }
    //     }

    //     Button {
    //         text: "Update"
    //         onClicked: {
    //             console.log("Button clicked")
    //             currencyModel.update()
    //         }
    //     }

    //     Button {
    //         text: "Convert"
    //         onClicked: {
    //             var firstIndex = comboBox1.currentIndex
    //             var secondIndex = comboBox2.currentIndex
    //             var value = textField1.text
    //             var result = currencyModel.calculate(firstIndex,
    //                                                  secondIndex, value)
    //             displayText.text = "Converted value: %1".arg(result)
    //         }
    //     }

    //     Text {
    //         id: displayText
    //         text: "Converted value"
    //     }
    // }
    // }
    CurrencyModel {
        id: currencyModel
    }
}
