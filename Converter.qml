import QtQuick
import CurrencyModel
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "white"
    radius: 20
    property int iconScale: 12
    property int toolTipDelay: 750
    signal changeButtonText(string newText)

    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.topMargin: 20
            ComboBox {
                id: comboBox1
                model: currencyModel
                textRole: "fullInfo"
                Layout.leftMargin: 20
                currentIndex: 31 //ruble index
                onCurrentIndexChanged: {
                    var firstValuteCharCode = model.getCharCode(currentIndex)
                    var secondValuteCharCode = comboBox2.model.getCharCode(
                                comboBox2.currentIndex)
                    var result = model.getCurrency(comboBox1.currentIndex,
                                                   comboBox2.currentIndex)
                    changeButtonText("1 %1 = %2 %3".arg(
                                         firstValuteCharCode).arg(
                                         secondValuteCharCode).arg(result))
                }

                // ToolTip.text: model.getName(currentIndex)
                // ToolTip.delay: toolTipDelay
                // hoverEnabled: true
                // ToolTip.visible: hovered
                background: Rectangle {
                    color: "transparent"
                    border.width: 0
                }
                delegate: CurrenclyListModelDelegate {
                    toolTipDelay: root.toolTipDelay
                }
                contentItem: RowLayout {
                    Image {
                        id: icon1
                        source: comboBox1.model.getImageSource(
                                    comboBox1.currentIndex)
                        sourceSize: Qt.size(
                                        img1.sourceSize.width / root.iconScale,
                                        img1.sourceSize.height / root.iconScale)
                        // base qml stuff i guess :)
                        // https://forum.qt.io/topic/52161/properly-scaling-svg-images/2
                        Image {
                            id: img1
                            source: parent.source
                            width: 0
                            height: 0
                        }
                    }

                    Text {
                        text: comboBox1.model.getCharCode(
                                  comboBox1.currentIndex)
                        color: "#26278D"
                        font {
                            pixelSize: 20
                            bold: true
                        }
                    }
                }
            }
            CurrencyTextField {
                id: textField1
                Layout.preferredWidth: 130
                Layout.preferredHeight: 40

                onEditingFinished: {
                    let firstIndex = comboBox1.currentIndex
                    let secondIndex = comboBox2.currentIndex
                    let value = textField1.text
                    if (value !== "") {
                        let result = currencyModel.calculate(firstIndex,
                                                             secondIndex,
                                                             parseFloat(value))
                        textField2.text = result
                    }
                }
            }
        }

        // // f6f6f8
        // Rectangle {
        //     // Layout.preferredHeight: 2
        //     Layout.fillWidth: true
        //     height: 2
        //     color: "#f6f6f8"
        // }
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            property int lineWidth: (width - 50) / 2
            // Линия
            Rectangle {
                height: 2
                width: parent.lineWidth
                color: "#f6f6f8"
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }
            }

            Image {
                source: "Assets/swap_icon.svg"
                width: 45
                height: 45
                anchors.centerIn: parent

                opacity: mouseArea.containsMouse ? 0.75 : 1

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        let tmpIndex = comboBox1.currentIndex
                        comboBox1.currentIndex = comboBox2.currentIndex
                        comboBox2.currentIndex = tmpIndex
                        let tmpValue = textField1.text
                        textField1.text = textField2.text
                        textField2.text = tmpValue
                        textField1.editingFinished()
                    }
                }
            }

            Rectangle {
                height: 2
                width: parent.lineWidth
                color: "#f6f6f8"
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                }
            }
        }

        RowLayout {
            Layout.bottomMargin: 20
            ComboBox {
                id: comboBox2
                model: currencyModel
                textRole: "fullInfo"
                currentIndex: 39 //usd index
                Layout.leftMargin: 20
                background: Rectangle {
                    color: "transparent"
                    border.width: 0
                }
                onCurrentIndexChanged: {
                    let firstValuteCharCode = comboBox1.model.getCharCode(
                            comboBox1.currentIndex)
                    let secondValuteCharCode = model.getCharCode(currentIndex)
                    let result = model.getCurrency(comboBox1.currentIndex,
                                                   comboBox2.currentIndex)
                    changeButtonText("1 %1 = %2 %3".arg(
                                         firstValuteCharCode).arg(
                                         secondValuteCharCode).arg(result))
                }

                // ToolTip.text: model.getName(currentIndex)
                // ToolTip.delay: 1000
                // hoverEnabled: true
                // ToolTip.visible: hovered
                Component.onCompleted: currentIndexChanged()

                delegate: CurrenclyListModelDelegate {
                    toolTipDelay: root.toolTipDelay
                }
                contentItem: RowLayout {
                    Image {
                        id: icon2
                        source: comboBox1.model.getImageSource(
                                    comboBox2.currentIndex)
                        sourceSize: Qt.size(
                                        img2.sourceSize.width / root.iconScale,
                                        img2.sourceSize.height / root.iconScale)
                        // base qml stuff i guess :
                        // https://forum.qt.io/topic/52161/properly-scaling-svg-images/2
                        Image {
                            id: img2
                            source: parent.source
                            width: 0
                            height: 0
                        }
                    }

                    Text {
                        text: comboBox2.model.getCharCode(
                                  comboBox2.currentIndex)
                        color: "#26278D"
                        font {
                            pixelSize: 20
                            bold: true
                        }
                    }
                }
            }
            CurrencyTextField {
                id: textField2
                Layout.preferredWidth: 130
                Layout.preferredHeight: 40
                readOnly: true
            }
        }

        // // Button {
        // //     text: "Update"
        // //     onClicked: {
        // //         currencyModel.update()
        // //     }
        // // }
        // Button {
        //     text: "Convert"
        // }
    }
    CurrencyModel {
        id: currencyModel
    }
}
