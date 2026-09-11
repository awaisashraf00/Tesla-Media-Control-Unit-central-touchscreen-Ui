import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: appWindow
    width: 1280
    height: 720
    visible: true
    title: "Tesla"
    property bool homePopupVisible: false
    property bool callPopupVisible: false

    Rectangle {
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#262626" }
            GradientStop { position: 1.0; color: "#666666" }
        }
    }

    BottomButtons {
        id: bottomBar
        temp_Unit:Temprature_Controls
        
        onHomePopupToggled:{
            appWindow.homePopupVisible = !appWindow.homePopupVisible
            appWindow.callPopupVisible = false
        } 
            
        onCallPopupToggled:{
            appWindow.callPopupVisible = !appWindow.callPopupVisible
            appWindow.homePopupVisible = false
        } 
        
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 7
    }

    MapView {
        id: mapView
        backend: upper_control
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.35
        anchors.right: parent.right
        anchors.rightMargin: 9
        anchors.bottom: bottomBar.top
    }
    LeftDashboard{
        id: leftbar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: mapView.left
        anchors.bottom: bottomBar.top
    }

    Homebutton{
        id:app_panel
        homePopupVisible: appWindow.homePopupVisible
        anchors{
            left:parent.left
            right: parent.right
            top:parent.top
            bottom: bottomBar.top
        }
    }
        

    Callpanel{
        id:call_panel
        callbuttonvisible: !appWindow.homePopupVisible && appWindow.callPopupVisible
        anchors{
            left:parent.left
            right: parent.right
            bottom: bottomBar.top
            top:parent.top
        }
    }

}
