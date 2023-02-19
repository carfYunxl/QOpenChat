import QtQuick 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Popup
{
    id:root
    required property int posx;
    required property int posy;

    required property int w_x;
    required property int w_y;
    property alias title: label.text
    property int port:0
    x:posx
    y:posy
    width: w_x
    height: w_y
    topInset:0
    leftInset:0
    topMargin:0
    leftMargin:0
    topPadding:0
    leftPadding:0

    background: Rectangle
    {
        anchors.fill:parent
        color:"black"
    }

    signal sendInfo(var text);
    signal posChange(var x,var y);

    closePolicy: Popup.NoAutoClose
    Rectangle
    {
        id:label_bg
        width: root.width
        height: 30
        color: "black"
        x:0
        y:0

        Text
        {
            id:label
            anchors.fill: parent
            text: qsTr("Input msg to send to all client")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "white"
            font.family: "Consolos"
            font.bold: true
            font.pixelSize: 18
        }

        MouseArea
        {
            property variant holdPos: "0,0"

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onPressed:
            {
                holdPos  = Qt.point(mouseX,mouseY)
            }

            onPositionChanged:
            {
                var delta = Qt.point(mouseX-holdPos.x, mouseY-holdPos.y)
                root.x += delta.x;
                root.y += delta.y;

                posChange(root.x,root.y);
            }
        }
    }

    TextArea
    {
        id:text_area
        y:label_bg.height
        anchors.top: label_bg.bottom
        anchors.left: label_bg.left
        anchors.right: label_bg.right
        width: root.width
        height: root.height * 0.6
        selectByMouse: true
        mouseSelectionMode: TextEdit.SelectWords
        wrapMode:TextEdit.WordWrap

        background: Rectangle
        {
            anchors.fill:parent
            color:"white"
        }

    }

    Button
    {
        id:send
        x:(root.width - send.width)/2
        y:text_area.y + text_area.height + 3
        width: root.width * 0.8
        height: 30
        text: qsTr("Send")

        background: Rectangle
        {
            color: send.hovered ? "lightblue" : "white"
            anchors.fill:parent
        }

        onClicked:
        {
            sendInfo(text_area.text)
        }
    }

    Button
    {
        id:close
        x:(root.width - close.width)/2
        y:root.height - close.height
        width: root.width * 0.8
        height: 30
        text: qsTr("Close")

        background: Rectangle
        {
            id:close_bg
            color:close.hovered ? "lightblue" : "white"
            anchors.fill:parent
        }

        onClicked:
        {
            root.close()
        }
    }
}
