cmake_minimum_required(VERSION 3.16)

project(TeslaMCU VERSION 1.0 LANGUAGES CXX)

# set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS
    Core
    Gui
    Qml
    Quick
    QuickControls2
    Positioning
    Location
    Multimedia
    Sql
)


qt_standard_project_setup(REQUIRES 6.8)

add_executable(TeslaMCU
    src/main.cpp
    src/Backend.cpp
    src/Backend.cpp
    header_files/Backend.h
    src/DataSql.cpp
    header_files/DataSql.h
    header_files/temprature.h
    src/temprature.cpp
    src/MusicController.cpp
    header_files/MusicController.h
    resources/assets.qrc

)

target_include_directories(TeslaMCU PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/header_files
)

set_target_properties(TeslaMCU PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}"
)

qt_add_qml_module(TeslaMCU
    URI TeslaMCU
    VERSION 1.0

    OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/qml/TeslaMCU"

    QML_FILES
        qml/Main.qml
        qml/Homebutton.qml
        qml/Callpanel.qml
        qml/bottomBar/BottomButtons.qml
        qml/Leftscreen/LeftDashboard.qml
        qml/Rightscreen/MapView.qml
        qml/Rightscreen/UpperControls.qml
        qml/Rightscreen/Searchbar.qml
        qml/Rightscreen/Musicbar.qml

)

target_link_libraries(TeslaMCU PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Location
    Qt6::Positioning
    Qt6::Multimedia
    Qt6::Sql
)