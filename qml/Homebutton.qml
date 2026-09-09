import QtQuick 2.15
import QtQuick.Window 2.15

Item{
    property bool  homePopupVisible : false
    id : homespace
    visible: homePopupVisible
    
    Rectangle{
        opacity: 0.35
        radius:20
        border.color: "#888888"
        border.width: 5 
        gradient: Gradient {
            GradientStop { position: 0.0; color: '#242526' }
            GradientStop { position: 1.0; color: "#000000" }
        }
    }
}


// // Image {
// //     id: homebutton
// //     // existing properties...
    
// //     MouseArea {
// //         anchors.fill: parent
// //         onClicked: homePopupVisible = !homePopupVisible
// //     }
// // }

// HomePopup {
//     id: homePopup
//     visible: homePopupVisible
//     anchors.bottom: homebutton.top
//     anchors.bottomMargin: 10
//     anchors.horizontalCenter: homebutton.horizontalCenter
//     onCloseRequested: homePopupVisible = false
// }
// ```