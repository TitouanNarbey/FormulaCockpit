import QtQuick 2.0

Item {
	id: container
	property alias pilotName: name.text
	property alias scuderiaColor: scuderiaRectangleColor.color

	width: 160; height: 25

	Rectangle {
		id: rectangle
		anchors.fill: parent
		color: Qt.rgba(0.4, 0.4, 0.4, 0.90)
		//border.color: "white" //debug

		Rectangle {
			id: scuderiaRectangleColor
			color: "white"
			visible: true

			width: 4
			anchors {
				left: parent.left
				leftMargin: 3
				top: parent.top
				topMargin: 2
				bottom: parent.bottom
				bottomMargin: 2
			}
		}

		Text {
			id: name
			text: "_NAME_"
			transformOrigin: Item.Left
			font.bold: true
			color: Qt.rgba(0.95, 0.95, 0.95)

			anchors {
				verticalCenter: parent.verticalCenter
				left: scuderiaRectangleColor.right
				leftMargin: 4
			}
		}
		/*NumberAnimation on y {
			from: y
			to: y+parent.height
			duration: 2000
		}*/
	}

	function moveUp() {
		y -= 25
	}

	function moveDown() {
		y += 25
	}
}
