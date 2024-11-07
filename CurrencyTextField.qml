import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

TextField {

    background: Rectangle {
        color: "#eeeeee"
        radius: 5
    }

    font {
        pixelSize: 20
        weight: 600
    }

    color: "#3C3C3C"
    horizontalAlignment: TextInput.AlignRight

    validator: DoubleValidator {
        notation: DoubleValidator.StandardNotation
        bottom: 1.0
        decimals: 4
        top: 100000.0
    }
}
