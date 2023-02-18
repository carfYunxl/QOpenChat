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
    property alias msg: text_area.text
    property int port:0
    x:posx
    y:posy
    width: w_x
    height: w_y

    signal sendInfo(var text);

    closePolicy: Popup.NoAutoClose
    Text
    {
        id:label
        width: root.width - 10
        height: 30
        text: qsTr("Input msg to send to all client")

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
            }
        }
    }

    TextArea
    {
        id:text_area
        y:label.height
        anchors.top: label.bottom
        anchors.left: label.left
        anchors.right: label.right
        width: root.width - label.height - send.height - close.height - 10
        height: root.height * 0.6
    }

    Button
    {
        id:send
        anchors.top: text_area.bottom
        x:(label.width - send.width)/2
        y:label.height + text_area.height
        width: 200
        height: 30
        text: qsTr("Send")

        onClicked:
        {
            sendInfo(text_area.text)
        }
    }

    Button
    {
        id:close
        anchors.top: send.bottom
        x:(label.width - send.width)/2
        y:label.height + text_area.height + send.height
        width: 200
        height: 30
        text: qsTr("Close")

        onClicked:
        {
            root.close()
        }
    }
}
