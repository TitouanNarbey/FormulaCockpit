import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12
import QtMultimedia 5.12

import cockpit.models 1.0

Window {
	visible: true
	width: 1280
	height: 720
	title: qsTr("Formula Cockpit")

	Flickable {
		id: flick
		anchors.fill: parent
		focus: true
		contentWidth: Math.max(circuitMap.width * slider.value, width)
		contentHeight: Math.max(circuitMap.height  * slider.value, height)
		anchors.centerIn: parent
		boundsBehavior: Flickable.StopAtBounds
		contentX: contentWidth === width ? 0 : circuitMap.width * slider.value / 2 - width / 2
		contentY: contentHeight === height ? 0 : circuitMap.height * slider.value / 2 - height / 2



		Image {
			id: circuitMap
			source: "qrc:/circuits/maps/Circuit_de_Monaco"

			scale: slider.value
			transformOrigin: Item.Center
			anchors.centerIn: parent

			/* formula grid */
			Item {id: position1; x: 350; y: 400}
			Item {id: position2; x: 337; y: 396}
			Item {id: position3; x: 339; y: 412}
			Item {id: position4; x: 327; y: 408}
			Item {id: position5; x: 331; y: 423}
			Item {id: position6; x: 318; y: 419}
			Item {id: position7; x: 322; y: 434}
			Item {id: position8; x: 309; y: 430}


			/* cars */
			Rectangle  {
				id: car1
				x: position1.x; y: position1.y
				width: 10; height: 10; transformOrigin: Item.Center; rotation: 45; color: "red"; radius: width*0.5
			}
			Rectangle  {
				id: car2
				x: position2.x; y: position2.y
				width: 10; height: 10; transformOrigin: Item.Center; rotation: 45; color: "silver"; radius: width*0.5
			}
			Rectangle  {
				id: car3
				x: position3.x; y: position3.y
				width: 10; height: 10; transformOrigin: Item.Center; rotation: 45; color: "darkblue"; radius: width*0.5
			}
			Rectangle  {
				id: car4
				x: position4.x; y: position4.y
				width: 10; height: 10; transformOrigin: Item.Center; rotation: 45; color: "red"; radius: width*0.5
			}
			Rectangle  {
				id: car5
				x: position5.x; y: position5.y
				width: 10; height: 10; transformOrigin: Item.Center; rotation: 45; color: "silver"; radius: width*0.5
				MouseArea {
					anchors.fill: parent
					onClicked: { carInformation.switchVisibility()}
				}
			}
			Rectangle  {
				id: car6
				x: position6.x; y: position6.y
				width: 10; height: 10; transformOrigin: Item.Center; rotation: 45; color: "yellow"; radius: width*0.5
			}
			Rectangle  {
				id: car7
				x: position7.x; y: position7.y
				width: 10; height: 10; transformOrigin: Item.Center; rotation: 45; color: "orange"; radius: width*0.5
			}
			Rectangle  {
				id: car8
				x: position8.x; y: position8.y
				width: 10; height: 10; transformOrigin: Item.Center; rotation: 45; color: "white"; radius: width*0.5
			}
		}
	}

	Slider {
		id: slider
		from: 1
		to: 4
		value: 1
		orientation: Qt.Vertical
		anchors {
			bottom: parent.bottom
			right: parent.right
			margins: 50
		}
	}

	Button {
		id: buttonDown
		height: 75; width: 75
		onClicked: pilotOrder.itemAtIndex(2).moveDown()
		text: "-"
		anchors.right: flick.right
		anchors.top: buttonUp.bottom
	}
	Button {
		id: buttonUp
		height: 75; width: 75
		onClicked: pilotOrder.itemAtIndex(2).moveUp()
		text: "+"
		anchors.right: flick.right
	}

	Item {
		id: pitLaneCamerasContainer

		Shape {
			id: pitLaneCamerasShape
			anchors.fill: parent

			layer.enabled: true
			layer.smooth: true
			layer.samples: 2

			ShapePath {
				id: pitLaneCamerasShapePath
				fillColor: "dimgray"
				strokeWidth: 10
				strokeColor: "red"
				capStyle: ShapePath.RoundCap
				strokeStyle: ShapePath.SolidLine
				dashPattern: [ 1, 4 ]
				startX: 0; startY: 0
				PathLine { x: pitLaneCamerasContainer.width * 0.05; y: pitLaneCamerasContainer.height * 1 }
				PathLine { x: pitLaneCamerasContainer.width * 0.95; y: pitLaneCamerasContainer.height * 1 }
				PathLine { x: pitLaneCamerasContainer.width * 1; y: pitLaneCamerasContainer.height * 0 }
				PathLine { x: pitLaneCamerasContainer.width * 0; y: pitLaneCamerasContainer.height * 0 }
			}
		}

		Rectangle {
			id: pitLaneCamera1
			color: "grey"
			border.color: "red"
			border.width: 4

			Text {
				text: qsTr("Pit Lane Camera 1")
				anchors.verticalCenter: parent.verticalCenter
				anchors.horizontalCenter: parent.horizontalCenter
			}

			width: (16/9)*height
			anchors {
				top: pitLaneCamerasShape.top
				topMargin: pitLaneCamerasShapePath.strokeWidth*2.5
				bottom: pitLaneCamerasShape.bottom
				bottomMargin: pitLaneCamerasShapePath.strokeWidth*1.5
				right: pitLaneCamera2.left
				rightMargin: pitLaneCamera2.border.width*2
			}
		}
		Rectangle {
			id: pitLaneCamera2
			color: "grey"
			border.color: "red"
			border.width: 4

			Text {
				text: qsTr("Pit Lane Camera 2")
				anchors.verticalCenter: parent.verticalCenter
				anchors.horizontalCenter: parent.horizontalCenter
			}

			Rectangle {
				id: pitStopRubanTimeCamera2
				opacity: 0
				color: "black"

				Text {
					id: pitStopTextTimeCamera2
					text: "4.159"
					font.bold: true
					font.pixelSize: parent.height*0.7
					color: "red"
					//font: ;
					anchors.verticalCenter: parent.verticalCenter
					anchors.horizontalCenter: parent.horizontalCenter
				}

				height: parent.height/3
				anchors {
					left: pitLaneCamera2.left
					leftMargin: pitLaneCamera2.border.width
					right: pitLaneCamera2.right
					rightMargin: pitLaneCamera2.border.width
					verticalCenter: pitLaneCamera2.verticalCenter
				}

				SequentialAnimation {
					id: showpitStopRubanTimeCamera2

					NumberAnimation {
						target: pitStopRubanTimeCamera2
						properties: "opacity"
						from: 0
						to: 0.9
						duration: 500
					}
					NumberAnimation {
						target: pitStopRubanTimeCamera2
						properties: "opacity"
						from: 0.9
						to: 0
						duration: 400
					}
					NumberAnimation {
						target: pitStopRubanTimeCamera2
						properties: "opacity"
						from: 0
						to: 0.9
						duration: 500
					}
					NumberAnimation {
						target: pitStopRubanTimeCamera2
						properties: "opacity"
						from: 0.9
						to: 0
						duration: 400
					}
					NumberAnimation {
						target: pitStopRubanTimeCamera2
						properties: "opacity"
						from: 0
						to: 0.8
						duration: 500
					}
					PauseAnimation {
						duration: 2500
					}
					NumberAnimation {
						target: pitStopRubanTimeCamera2
						properties: "opacity"
						from: 0.8
						to: 0
						duration: 1500
					}
				}
			}

			MouseArea {
				anchors.fill: parent
				onClicked: showpitStopRubanTimeCamera2.start()
				//onPressAndHold: pitStopTimerCamera2.start();
				//onReleased: { pitStopTimerCamera2.stop(); }
			}

			width: (16/9)*height
			anchors {
				top: pitLaneCamerasShape.top
				topMargin: pitLaneCamerasShapePath.strokeWidth*2.5
				bottom: pitLaneCamerasShape.bottom
				bottomMargin: pitLaneCamerasShapePath.strokeWidth*1.5
				horizontalCenter: pitLaneCamerasContainer.horizontalCenter
			}
		}
		Rectangle {
			id: pitLaneCamera3
			color: "grey"
			border.color: "red"
			border.width: 4

			Text {
				text: qsTr("Pit Lane Camera 3")
				anchors.verticalCenter: parent.verticalCenter
				anchors.horizontalCenter: parent.horizontalCenter
			}

			width: (16/9)*height
			anchors {
				top: pitLaneCamerasShape.top
				topMargin: pitLaneCamerasShapePath.strokeWidth*2.5
				bottom: pitLaneCamerasShape.bottom
				bottomMargin: pitLaneCamerasShapePath.strokeWidth*1.5
				left: pitLaneCamera2.right
				leftMargin: pitLaneCamera2.border.width*2
			}
		}

		width: flick.width/2; height: flick.height/6
		anchors {
			top: flick.top
			topMargin: -pitLaneCamerasShapePath.strokeWidth*2
			horizontalCenter: flick.horizontalCenter
		}
	}

	CarInformation {
		id: carInformation
		visible: true

		x: initialXonShowAnimation
		initialXonShowAnimation: flick.width
		targetXonShowAnimation: flick.width - width

		width: flick.width*0.35
		anchors {
			//right: flick.right
			top: flick.top
			bottom: flick.bottom
		}
	}

	Item {
		id: raceLiveInformations

		y: 30

		Rectangle {
			id: raceRectangleName
			width: 160; height: 50
			color: Qt.rgba(0.2, 0.2, 0.2, 1)

			Image {
				id: raceFlag
				source: "qrc:/flags/monaco"

				fillMode: Image.PreserveAspectFit

				anchors {
					left: parent.left
					leftMargin: 10
					top: parent.top
					topMargin: 2
					bottom: parent.bottom
					bottomMargin: 2
				}
			}

			Text {
				id: raceName
				text: "Monaco"
				transformOrigin: Item.Left
				color: "#FFFFFF"

				font {
					bold: true
					pixelSize: 14
				}

				anchors {
					verticalCenter: parent.verticalCenter
					left: raceFlag.right
					leftMargin: 15
				}
			}
		}

		ListView {
			id: pilotOrder
			z: raceRectangleName.z-1
			width: 160; height: 25 * 20

			interactive: false
			Component.onCompleted: currentIndex = -1;

			model: PilotOrderListModel {
				list: pilotOrderList
			}

			delegate: PilotRank {
				pilotName: model.name
				scuderiaColor: model.scuderiaColor
			}

			Timer {
				interval: 1000;
				repeat: true;
				running: true;
				onTriggered: { pilotOrder.update() }
			}

			anchors {
				top: raceRectangleName.bottom
			}
		}
	}
}
