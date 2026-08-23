import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

Item {
    id: root
    clip: true

    // ── Design tokens ──────────────────────────────────────────────────────────
    readonly property color accent:      "#2563EB"
    readonly property color accentGlow:  "#3b82f6"
    readonly property color textPrimary: "#F9FAFB"
    readonly property color textSecond:  "#9CA3AF"
    readonly property color cardBg:      Qt.rgba(1, 1, 1, 0.04)
    readonly property color cardBorder:  Qt.rgba(1, 1, 1, 0.09)
    readonly property color teslaRed:    "#E31937"

    // ── Simulated live data ────────────────────────────────────────────────────
    property real  speed:          0          // 0-130 mph
    property real  targetSpeed:    72
    property real  batteryPct:     0.78       // 0-1
    property int   batteryRange:   287        // miles
    property real  outsideTemp:    24.0
    property bool  autopilotReady: true
    property bool  lanekeepActive: true
    property bool  collisionAlert: false

    property string currentTime: Qt.formatTime(new Date(), "hh:mm")
    property string currentDate: Qt.formatDate(new Date(), "ddd, MMM d")
    property bool   colonVisible: true        // blinking colon

    // ── Clock update ───────────────────────────────────────────────────────────
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            currentTime = Qt.formatTime(new Date(), "hh:mm")
            currentDate = Qt.formatDate(new Date(), "ddd, MMM d")
            colonVisible = !colonVisible
        }
    }

    // ── Speed animation: ramp to target then oscillate ─────────────────────────
    Timer {
        interval: 150
        running: true
        repeat: true
        property real phase: 0
        onTriggered: {
            phase += 0.08
            let osc = Math.sin(phase) * 1.5
            speed += (targetSpeed + osc - speed) * 0.06
        }
    }

    // ── Change target speed occasionally ──────────────────────────────────────
    Timer {
        interval: 6000
        running: true
        repeat: true
        property var speeds: [72, 55, 88, 65, 79]
        property int idx: 0
        onTriggered: {
            idx = (idx + 1) % speeds.length
            targetSpeed = speeds[idx]
        }
    }

    // ──────────────────────────────────────────────────────────────────────────
    //  BACKGROUND  — subtle radial vignette
    // ──────────────────────────────────────────────────────────────────────────
    Rectangle {
        anchors.fill: parent
        color: "#0a0a0f"
    }

    Canvas {
        anchors.fill: parent
        Component.onCompleted: requestPaint()
        onPaint: {
            let ctx = getContext("2d")
            let cx = width / 2
            let cy = height * 0.4
            let r  = Math.max(width, height) * 0.65
            let grd = ctx.createRadialGradient(cx, cy, 0, cx, cy, r)
            grd.addColorStop(0,   Qt.rgba(0.15, 0.15, 0.30, 0.30))
            grd.addColorStop(1,   Qt.rgba(0,    0,    0,    0))
            ctx.fillStyle = grd
            ctx.fillRect(0, 0, width, height)
        }
    }

    // ──────────────────────────────────────────────────────────────────────────
    //  CLOCK & DATE  — top centre
    // ──────────────────────────────────────────────────────────────────────────
    Column {
        id: clockArea
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 22
        spacing: 2

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Text {
                text: currentTime.substring(0, 2)
                font { family: "Inter"; pixelSize: 38; weight: 300 }
                color: textPrimary
            }
            Text {
                text: ":"
                font { family: "Inter"; pixelSize: 38; weight: 300 }
                color: colonVisible ? textPrimary : "transparent"
            }
            Text {
                text: currentTime.substring(3, 5)
                font { family: "Inter"; pixelSize: 38; weight: 300 }
                color: textPrimary
            }
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: currentDate
            font { family: "Inter"; pixelSize: 13 }
            color: textSecond
        }
    }

    // ──────────────────────────────────────────────────────────────────────────
    //  SPEEDOMETER  — circular arc gauge
    // ──────────────────────────────────────────────────────────────────────────
    Item {
        id: speedoContainer
        width: 220
        height: 220
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: clockArea.bottom
        anchors.topMargin: 18

        // ── Glow halo behind gauge ─────────────────────────────────────────
        Rectangle {
            anchors.centerIn: parent
            width: 200; height: 200
            radius: 100
            color: Qt.rgba(0.15, 0.39, 0.92, 0.07)
            border.color: Qt.rgba(0.23, 0.51, 0.96, 0.3)
            border.width: 1
        }
        // Soft outer ring
        Rectangle {
            anchors.centerIn: parent
            width: 210; height: 210
            radius: 105
            color: "transparent"
            border.color: Qt.rgba(0.23, 0.51, 0.96, 0.12)
            border.width: 3
        }

        // ── Track arc (full 240 °) ─────────────────────────────────────────
        Canvas {
            id: trackArc
            anchors.fill: parent
            onPaint: {
                let ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                let cx = width/2, cy = height/2, r = 95
                let startAngle = (150) * Math.PI / 180
                let endAngle   = (390) * Math.PI / 180
                ctx.beginPath()
                ctx.arc(cx, cy, r, startAngle, endAngle)
                ctx.strokeStyle = Qt.rgba(1, 1, 1, 0.08)
                ctx.lineWidth   = 10
                ctx.lineCap     = "round"
                ctx.stroke()
            }
        }

        // ── Value arc (filled proportional to speed) ───────────────────────
        Canvas {
            id: valueArc
            anchors.fill: parent
            // Only repaint when rounded speed changes — avoids repainting on every tiny float update
            property int speedInt: Math.round(speed)
            property real fraction: Math.min(speed / 130.0, 1.0)

            onSpeedIntChanged: requestPaint()

            onPaint: {
                let ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                if (fraction <= 0) return
                let cx = width/2, cy = height/2, r = 95
                let startAngle = 150 * Math.PI / 180
                let spanAngle  = 240 * Math.PI / 180
                let endAngle   = startAngle + fraction * spanAngle

                // gradient on the arc
                let grd = ctx.createLinearGradient(0, cy, width, cy)
                if (fraction < 0.5) {
                    grd.addColorStop(0,   "#2563EB")
                    grd.addColorStop(1,   "#38bdf8")
                } else if (fraction < 0.8) {
                    grd.addColorStop(0,   "#2563EB")
                    grd.addColorStop(0.5, "#f59e0b")
                    grd.addColorStop(1,   "#ef4444")
                } else {
                    grd.addColorStop(0,   "#ef4444")
                    grd.addColorStop(1,   "#991b1b")
                }
                ctx.beginPath()
                ctx.arc(cx, cy, r, startAngle, endAngle)
                ctx.strokeStyle = grd
                ctx.lineWidth   = 10
                ctx.lineCap     = "round"
                ctx.stroke()

                // dot at arc tip (no shadowBlur — that forces expensive software rasterization)
                let tipX = cx + r * Math.cos(endAngle)
                let tipY = cy + r * Math.sin(endAngle)
                ctx.beginPath()
                ctx.arc(tipX, tipY, 5, 0, 2 * Math.PI)
                ctx.fillStyle = "#FFFFFF"
                ctx.fill()
            }
        }

        // ── Tick marks ────────────────────────────────────────────────────
        Canvas {
            anchors.fill: parent
            Component.onCompleted: requestPaint()
            onPaint: {
                let ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                let cx = width/2, cy = height/2, rOuter = 83, rInner = 74, rMajor = 70
                let totalTicks = 26
                for (let i = 0; i <= totalTicks; i++) {
                    let angle = (150 + i * (240 / totalTicks)) * Math.PI / 180
                    let isMajor = (i % 5 === 0)
                    let r1 = rOuter
                    let r2 = isMajor ? rMajor : rInner
                    ctx.beginPath()
                    ctx.moveTo(cx + r1 * Math.cos(angle), cy + r1 * Math.sin(angle))
                    ctx.lineTo(cx + r2 * Math.cos(angle), cy + r2 * Math.sin(angle))
                    ctx.strokeStyle = isMajor ? Qt.rgba(1,1,1,0.35) : Qt.rgba(1,1,1,0.12)
                    ctx.lineWidth   = isMajor ? 2 : 1
                    ctx.stroke()
                }
            }
        }

        // ── Centre readout ────────────────────────────────────────────────
        Column {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 8
            spacing: 0

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: Math.round(speed)
                font { family: "Inter"; pixelSize: 52; weight: 700 }
                color: textPrimary

                Behavior on text { }
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "mph"
                font { family: "Inter"; pixelSize: 13; weight: 500 }
                color: textSecond
                topPadding: -6
            }
        }

        // ── Speed limit badge (lower right of gauge) ──────────────────────
        Rectangle {
            width: 36; height: 36
            radius: 18
            color: "white"
            border.color: teslaRed
            border.width: 3
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 10

            Text {
                anchors.centerIn: parent
                text: "65"
                font { family: "Inter"; pixelSize: 11; weight: 700 }
                color: "#111"
            }
        }
    }

    // ──────────────────────────────────────────────────────────────────────────
    //  BATTERY CARD
    // ──────────────────────────────────────────────────────────────────────────
    Rectangle {
        id: batteryCard
        width: parent.width * 0.82
        height: 80
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: speedoContainer.bottom
        anchors.topMargin: 16
        radius: 14
        color: cardBg
        border.color: cardBorder
        border.width: 1

        Row {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 14

            // Icon
            Text {
                text: "⚡"
                font.pixelSize: 22
                anchors.verticalCenter: parent.verticalCenter
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 6
                width: parent.width - 36 - 14

                Item {
                    width: parent.width
                    height: 16
                    Text {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Battery"
                        font { family: "Inter"; pixelSize: 12 }
                        color: textSecond
                    }
                    Text {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        text: batteryRange + " mi  •  " + Math.round(batteryPct * 100) + "%"
                        font { family: "Inter"; pixelSize: 12; weight: 500 }
                        color: textPrimary
                    }
                }

                // Bar track
                Rectangle {
                    width: parent.width
                    height: 8
                    radius: 4
                    color: Qt.rgba(1,1,1,0.08)

                    Rectangle {
                        width: parent.width * batteryPct
                        height: 8
                        radius: 4
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: batteryPct > 0.3 ? "#22c55e" : "#ef4444" }
                            GradientStop { position: 1.0; color: batteryPct > 0.3 ? "#4ade80" : "#f97316" }
                        }

                        Behavior on width { NumberAnimation { duration: 800; easing.type: Easing.OutCubic } }
                    }
                }
            }
        }
    }

    // ──────────────────────────────────────────────────────────────────────────
    //  DRIVER ASSIST HUD STRIP
    // ──────────────────────────────────────────────────────────────────────────
    Rectangle {
        id: hudCard
        width: parent.width * 0.82
        height: 64
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: batteryCard.bottom
        anchors.topMargin: 10
        radius: 14
        color: cardBg
        border.color: cardBorder
        border.width: 1

        Row {
            anchors.centerIn: parent
            spacing: 28

            // Autopilot
            Column {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter
                Rectangle {
                    width: 32; height: 32; radius: 16
                    color: autopilotReady ? Qt.rgba(0.13, 0.39, 0.92, 0.2) : Qt.rgba(1,1,1,0.05)
                    border.color: autopilotReady ? accentGlow : Qt.rgba(1,1,1,0.1)
                    border.width: 1
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        anchors.centerIn: parent
                        text: "AP"
                        font { family: "Inter"; pixelSize: 10; weight: 700 }
                        color: autopilotReady ? "#60a5fa" : textSecond
                    }
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Auto"
                    font { family: "Inter"; pixelSize: 9 }
                    color: autopilotReady ? "#60a5fa" : textSecond
                }
            }

            // Lane keep
            Column {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter
                Rectangle {
                    width: 32; height: 32; radius: 16
                    color: lanekeepActive ? Qt.rgba(0.13, 0.76, 0.37, 0.2) : Qt.rgba(1,1,1,0.05)
                    border.color: lanekeepActive ? "#22c55e" : Qt.rgba(1,1,1,0.1)
                    border.width: 1
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        anchors.centerIn: parent
                        text: "LK"
                        font { family: "Inter"; pixelSize: 10; weight: 700 }
                        color: lanekeepActive ? "#4ade80" : textSecond
                    }
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Lane"
                    font { family: "Inter"; pixelSize: 9 }
                    color: lanekeepActive ? "#4ade80" : textSecond
                }
            }

            // Collision alert
            Column {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter
                Rectangle {
                    width: 32; height: 32; radius: 16
                    color: collisionAlert ? Qt.rgba(0.92, 0.15, 0.22, 0.25) : Qt.rgba(1,1,1,0.05)
                    border.color: collisionAlert ? teslaRed : Qt.rgba(1,1,1,0.1)
                    border.width: 1
                    anchors.horizontalCenter: parent.horizontalCenter

                    SequentialAnimation on border.color {
                        running: collisionAlert
                        loops: Animation.Infinite
                        ColorAnimation { to: teslaRed;  duration: 400 }
                        ColorAnimation { to: "#7f1d1d"; duration: 400 }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "⚠"
                        font { pixelSize: 14 }
                        color: collisionAlert ? "#fca5a5" : textSecond
                    }
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "FCW"
                    font { family: "Inter"; pixelSize: 9 }
                    color: collisionAlert ? "#fca5a5" : textSecond
                }
            }

            // Outside temp
            Column {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter
                Rectangle {
                    width: 32; height: 32; radius: 16
                    color: Qt.rgba(1,1,1,0.05)
                    border.color: Qt.rgba(1,1,1,0.1)
                    border.width: 1
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        anchors.centerIn: parent
                        text: "🌡"
                        font.pixelSize: 14
                    }
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: outsideTemp + "°C"
                    font { family: "Inter"; pixelSize: 9 }
                    color: textSecond
                }
            }
        }
    }

    // ──────────────────────────────────────────────────────────────────────────
    //  GEAR / DRIVE MODE INDICATOR
    // ──────────────────────────────────────────────────────────────────────────
    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 18
        spacing: 20

        property string activeGear: "D"

        Repeater {
            model: ["P", "R", "N", "D"]
            delegate: Item {
                width: 32; height: 32

                Rectangle {
                    anchors.fill: parent
                    radius: 8
                    color: parent.parent.activeGear === modelData
                           ? Qt.rgba(0.15, 0.39, 0.92, 0.3)
                           : Qt.rgba(1,1,1,0.03)
                    border.color: parent.parent.activeGear === modelData
                                  ? accentGlow
                                  : Qt.rgba(1,1,1,0.08)
                    border.width: 1
                }
                Text {
                    anchors.centerIn: parent
                    text: modelData
                    font { family: "Inter"; pixelSize: 14; weight: 600 }
                    color: parent.parent.activeGear === modelData ? "#60a5fa" : textSecond
                }
            }
        }
    }
}
