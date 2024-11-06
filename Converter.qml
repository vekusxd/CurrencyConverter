import QtQuick
import CurrencyModel
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "white"
    radius: 20

    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            ComboBox {
                id: comboBox1
                model: currencyModel
                textRole: "fullInfo"
                currentIndex: 31 //ruble index
                delegate: CurrenclyListModelDelegate {}
                // popup.closePolicy: Popup.NoAutoClose
                popup.visible: true
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
                currentIndex: 39 //usd index
                popup.closePolicy: Popup.NoAutoClose
                delegate: CurrenclyListModelDelegate {}
            }
        }

        Button {
            text: "Update"
            onClicked: {
                console.log("Button clicked")
                currencyModel.update()
            }
        }

        Button {
            text: "Convert"
            onClicked: {
                var firstIndex = comboBox1.currentIndex
                var secondIndex = comboBox2.currentIndex
                var value = textField1.text
                var result = currencyModel.calculate(firstIndex,
                                                     secondIndex, value)
                console.log("Converte result: " + result)
            }
        }
    }
    CurrencyModel {
        id: currencyModel
    }
}
