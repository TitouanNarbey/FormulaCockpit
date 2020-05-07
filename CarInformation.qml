import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12
import QtMultimedia 5.12

import cockpit.models 1.0

Item {
	id: carInformation
	
	Shape {
		id: carInformationShape
		anchors.fill: parent
		
		layer.enabled: true
		layer.smooth: true
		layer.samples: 2
		
		ShapePath {
			id: carInformationShapePath
			strokeWidth: 10
			strokeColor: "#0ca597"
			capStyle: ShapePath.RoundCap
			strokeStyle: ShapePath.SolidLine
			
			dashPattern: [ 1, 4 ]
			startX: 0; startY: 0
			PathLine { x: carInformation.width * 0; y: carInformation.height * 0.60 }
			PathLine { x: carInformation.width * 1; y: carInformation.height * 0.75 }
			PathLine { x: carInformation.width * 1; y: carInformation.height * 0 }
			PathLine { x: carInformation.width * 0; y: carInformation.height * 0 }
			
			fillGradient: LinearGradient {
				x1: carInformation.width; y1: 0
				x2: 0; y2: carInformation.height * 0.75
				GradientStop { position: 0; color: "#0ca597" }
				GradientStop { position: 0.50; color: "gainsboro" }
				GradientStop { position: 0.80; color: "gainsboro" }
				GradientStop { position: 1; color: "#0ca597" }
			}
		}
	}
	
	Rectangle {
		id: pilotInformationRectangle
		
		color: "transparent"
		border.color: carInformationShapePath.strokeColor
		border.width: carInformationShapePath.strokeWidth/2
		
		height: 65
		anchors {
			top: carInformationShape.top
			left: carInformationShape.left
			right: carInformationShape.right
		}
		
		Text {
			id: pinotNameText
			text: "Valtteri BOTTAS"
			color: "white"
			font.bold: true
			font.pixelSize: parent.height*0.6
			anchors.verticalCenter: parent.verticalCenter
			anchors.horizontalCenter: parent.horizontalCenter
		}
		
		Item {
			Image {
				id: pilotNumberImage
				source: "qrc:/pilots/numbers/77"
				
				height: parent.height*0.8
				width: (sourceSize.width/sourceSize.height)*height
				anchors {
					centerIn: parent
				}
			}
			
			anchors {
				top: pilotInformationRectangle.top
				bottom: pilotInformationRectangle.bottom
				left: pilotInformationRectangle.left
				right: pinotNameText.left
			}
		}
		
		Item {
			Image {
				id: pilotCountryImage
				source: "qrc:/pilots/flags/finland"
				
				height: parent.height*0.6
				width: (sourceSize.width/sourceSize.height)*height
				anchors {
					centerIn: parent
				}
			}
			
			anchors {
				top: pilotInformationRectangle.top
				bottom: pilotInformationRectangle.bottom
				left: pinotNameText.right
				right: pilotInformationRectangle.right
			}
		}
	}
	
	Image {
		id: pilotImage
		source: "qrc:/pilots/mini_bottas"
		
		anchors {
			top: pilotInformationRectangle.bottom
			topMargin: pilotInformationRectangle.strokeWidth
			left: carInformationShape.left
			leftMargin: carInformationShapePath.strokeWidth
			
		}
	}
	
	Image {
		id: fullLogoImage
		source: "qrc:/logos/full_mercedes"
		antialiasing: true
		
		height: (sourceSize.height/sourceSize.width)*width
		anchors {
			top: pilotImage.bottom
			topMargin: pilotImage.height/4
			left: pilotImage.left
			right: pilotImage.right
		}
	}
	
	Image {
		id: carImage
		source: "qrc:/cars/mercedes"
		
		height: (sourceSize.height/sourceSize.width)*width
		anchors {
			top: fullLogoImage.bottom
			topMargin: fullLogoImage.height/4
			left: fullLogoImage.left
			right: fullLogoImage.right
		}
	}
	
	Image {
		id: oldTyre1Image
		source: "qrc:/tyres/tyre-yellow"
		
		width: carImage.width/4
		height: (sourceSize.height/sourceSize.width)*width
		anchors {
			top: carImage.bottom
			topMargin: carImage.height/8
			left: carImage.left
		}
	}
	Image {
		id: oldTyre2Image
		source: "qrc:/tyres/tyre-white"
		
		width: carImage.width/4
		height: (sourceSize.height/sourceSize.width)*width
		anchors {
			top: carImage.bottom
			topMargin: carImage.height/8
			left: oldTyre1Image.left
			leftMargin: oldTyre1Image.width/3
		}
	}
	Image {
		id: oldTyre3Image
		source: "qrc:/tyres/tyre-blue"
		
		width: carImage.width/4
		height: (sourceSize.height/sourceSize.width)*width
		anchors {
			top: carImage.bottom
			topMargin: carImage.height/8
			left: oldTyre2Image.left
			leftMargin: oldTyre2Image.width/3
		}
	}
	Image {
		id: oldTyre4Image
		source: "qrc:/tyres/tyre-green"
		
		width: carImage.width/4
		height: (sourceSize.height/sourceSize.width)*width
		anchors {
			top: carImage.bottom
			topMargin: carImage.height/8
			left: oldTyre3Image.left
			leftMargin: oldTyre3Image.width/3
		}
	}
	Image {
		id: oldTyre5Image
		source: "qrc:/tyres/tyre-red"
		
		width: carImage.width/4
		height: (sourceSize.height/sourceSize.width)*width
		anchors {
			top: carImage.bottom
			topMargin: carImage.height/8
			left: oldTyre4Image.left
			leftMargin: oldTyre4Image.width/3
		}
	}
	
	Image {
		id: currentTyreImage
		source: "qrc:/tyres/tyre-red"
		
		transform: Rotation {
			origin.x: currentTyreImage.width/2
			origin.y: currentTyreImage.height/2
			
			RotationAnimation on angle {
				from: 0
				to: 360
				duration: 4000
				loops: Animation.Infinite
			}
		}
		
		width: carImage.width/4
		height: (sourceSize.height/sourceSize.width)*width
		anchors {
			top: carImage.bottom
			topMargin: carImage.height/8
			right: carImage.right
		}
	}
	
	Rectangle {
		id: onBoardCamera
		color: "grey"
		border.color: "#0ca597"
		border.width: 4
		
		Text {
			text: qsTr("On Board Camera")
			anchors.verticalCenter: parent.verticalCenter
			anchors.horizontalCenter: parent.horizontalCenter
		}
		
		height: (9/16)*width
		anchors {
			top: pilotInformationRectangle.bottom
			topMargin: pilotInformationRectangle.border.width
			left: pilotImage.right
			leftMargin: carInformationShapePath.strokeWidth // need to be replace
			right: carInformationShape.right
			rightMargin: carInformationShapePath.strokeWidth // need to be replace
		}
	}

	property bool active: false
	property int initialXonShowAnimation: showAnimation.from
	property int targetXonShowAnimation: unShowAnimation.to
	ParallelAnimation {
		id: showAnimation

		NumberAnimation {
			target: carInformation
			properties: "x"
			from: x
			to: targetXonShowAnimation
			duration: 500
			//easing {type: Easing.OutBack; overshoot: 500}
		}

		NumberAnimation {
			target: carInformation
			properties: "opacity"
			from: opacity
			to: 1
			duration: 500
		}
	}
	ParallelAnimation {
		id: unShowAnimation

		NumberAnimation {
			target: carInformation
			properties: "x"
			from: x
			to: initialXonShowAnimation
			duration: 500
			//easing {type: Easing.OutBack; overshoot: 500}
		}

		NumberAnimation {
			target: carInformation
			properties: "opacity"
			from: opacity
			to: 0
			duration: 500
			//easing {type: Easing.OutBack; overshoot: 500}
		}
	}

	function switchVisibility() {
		if (active === false)
			show()
		else
			close()
	}

	function show() {
		active = true
		unShowAnimation.stop()
		showAnimation.start()
	}

	function close() {
		active = false
		showAnimation.stop()
		unShowAnimation.start()
	}
}
