import QtQuick
import QtQuick.Controls.Universal
import QtQuick.Layouts
import CurrencyModel

Window {
    id: root
    width: 400
    height: 550
    visible: true
    title: qsTr("Currency Converter")

    Rectangle {
        anchors.fill: parent
        color: "#eef2f8"

        Rectangle {
            width: 310
            height: 250
            color: "#ffffff"
            anchors.centerIn: parent
            radius: 3.0
            ColumnLayout {
                anchors.fill: parent
                RowLayout {
                    ComboBox {
                        id: comboBox1
                        model: currencyModel
                        textRole: "fullInfo"
                        currentIndex: 0
                        delegate: ItemDelegate {
                            required property string fullInfo
                            text: fullInfo
                        }
                    }
                    TextField {
                        id: textField1
                        validator: IntValidator {
                            bottom: 1
                            top: 1000
                        }
                    }
                }

                RowLayout {
                    ComboBox {
                        id: comboBox2
                        model: currencyModel
                        textRole: "fullInfo"
                        currentIndex: 0
                        delegate: ItemDelegate {
                            required property string fullInfo
                            text: fullInfo
                        }
                    }
                    // TextField {
                    //     id: textField2
                    //     validator: IntValidator {
                    //         bottom: 1
                    //         top: 1000
                    //     }
                    // }
                }

                Button {
                    text: "Update"
                    onClicked: {
                        console.log("Button clicked")
                        currencyModel.fetchFromNetwork()
                    }
                }

                Button {
                    text: "Convert"
                    onClicked: {
                        var firstIndex = comboBox1.currentIndex
                        var secondIndex = comboBox2.currentIndex
                        var value = textField1.text
                        console.log(currencyModel.calculate(firstIndex,
                                                            secondIndex, value))
                    }
                }

                Text {
                    id: displayText
                    text: "Converted value"
                }
            }
        }
    }

    CurrencyModel {
        id: currencyModel
    }
}
