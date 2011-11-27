import QtQuick 1.0

Rectangle {
    id: geocacheRectangle
    width: drawSimple ? 10: 36
    height: drawSimple ? 10: 36
    property variant cache
    property variant targetPoint
    property bool drawSimple
    x: targetPoint[0] - width/2
    y: targetPoint[1] - height/2
    color: (cache == currentGeocache) ? "#88ff0000" : "#88ffffff"
    border.width: 4
    border.color: (cache.type == 'regular' ? "green" :
                   cache.type == 'multi' ? "orange" :
                   cache.type == 'virtual' ? "blue" :
                   cache.type == 'event' ? "red" :
                   cache.type == 'earth' ? "darkgreen" :
                   "blue")

    smooth: true
    radius: 7
    Image {
        source: "../data/cross.svg"
        anchors.centerIn: parent
        visible: ! drawSimple
    }
    /*
    Text {
        font.pixelSize: 15
        font.weight: Font.Bold
        text: cache.title
        width: 150
        wrapMode: Text.WordWrap
        anchors.left: parent.right
        anchors.leftMargin: 8
        color: "green"
        visible: ! drawSimple
    }*/
}
