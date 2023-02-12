import QtQuick 2.2
import QtQuick.Controls 2.5
Rectangle
{
    required property int w
    required property int h
    required property int inner_w
    property alias bg_color:root.color

    id:root
    width: w
    height: h

    signal server_open;
    signal server_close
    Row
    {
        id:row
        spacing: 5
        Button
        {
            width: inner_w
            height: root.height
            text: "OpenServer"
            icon.source: "qrc:/icon/open.png"

            onClicked:
            {
                server_open()
            }
        }

        Button
        {
            width: inner_w
            height: root.height
            text: "CloseServer"
            icon.source: "qrc:/icon/close.png"

            onClicked:
            {
                server_close()
            }
        }
    }
}
