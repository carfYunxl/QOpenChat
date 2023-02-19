import QtQuick 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

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
        height: root.height * 0.7
        selectByMouse: true
        mouseSelectionMode: TextEdit.SelectWords
        wrapMode:TextEdit.WordWrap

        background: Rectangle
        {
            anchors.fill:parent
            color:"white"
        }

        Keys.onReturnPressed:
        {
            if( event.modifiers & Qt.ControlModifier )
            {
                text += '\n'
                text_area.cursorPosition = text_area.length
            }
            else
            {
                sendInfo(text_area.text)
            }
        }
    }

    FontDialog
    {
         id:fontdlg
         title: "Please choose a font"
         font: Qt.font({ family: "Arial", pointSize: 24, weight: Font.Normal })
         onAccepted:
         {
             text_area.font.family = fontdlg.font.family
             text_area.font.pointSize = fontdlg.font.pointSize
             text_area.font.bold = fontdlg.font.bold
             text_area.font.italic = fontdlg.font.italic
             fontdlg.close()
         }
         onRejected:
         {
             console.log("Canceled")
             fontdlg.close()
         }
         modality: Qt.WindowModal
    }

    ColorDialog
    {
         id: colorDialog
         title: "Please choose a color"
         onAccepted:
         {
             text_area.color = colorDialog.color
             colorDialog.close()
         }
         onRejected:
         {
             colorDialog.close()
         }
         modality: Qt.WindowModal
     }

    Row
    {
        id:row
        x:20
        spacing: 5
        Button
        {
            id:font_button
            y:(root.height - text_area.y - text_area.height - font_button.height)/2 + text_area.y + text_area.height
            width: height
            height: root.height * 0.3 - 35
            icon.source: "qrc:/font_icon/font_2.png"
            icon.width: font_button.width * 0.8
            icon.height: font_button.height * 0.8
            icon.color:"white"
            ToolTip.text: qsTr("Font")
            ToolTip.visible: hovered
            background: Rectangle
            {
                id:font_bg
                color:font_button.hovered ? "lightblue" : "transparent"
                anchors.fill:parent
            }

            onClicked:
            {
                fontdlg.open()
            }
        }
        Button
        {
            id:font_bold
            y:(root.height - text_area.y - text_area.height - font_button.height)/2 + text_area.y + text_area.height
            width: height
            height: root.height * 0.3 - 35
            icon.source: "qrc:/font_icon/bold_2.png"
            icon.width: font_bold.width * 0.8
            icon.height: font_bold.height * 0.8
            icon.color:"white"
            ToolTip.text: qsTr("Bold")
            ToolTip.visible: hovered
            background: Rectangle
            {
                id:font_bold_bg
                color:font_bold.hovered ? "lightblue" : "transparent"
                anchors.fill:parent
            }

            onClicked:
            {
                text_area.font.bold = true
            }
        }
        Button
        {
            id:font_color
            y:(root.height - text_area.y - text_area.height - font_button.height)/2 + text_area.y + text_area.height
            width: height
            height: root.height * 0.3 - 35
            icon.source: "qrc:/font_icon/color_2.png"
            icon.width: font_color.width * 0.8
            icon.height: font_color.height * 0.8
            icon.color:"white"
            ToolTip.text: qsTr("Color")
            ToolTip.visible: hovered
            background: Rectangle
            {
                id:font_color_bg
                color:font_color.hovered ? "lightblue" : "transparent"
                anchors.fill:parent
            }

            onClicked:
            {
                colorDialog.open()
            }
        }
        Button
        {
            id:font_italic
            y:(root.height - text_area.y - text_area.height - font_button.height)/2 + text_area.y + text_area.height
            width: height
            height: root.height * 0.3 - 35
            icon.source: "qrc:/font_icon/italic_2.png"
            icon.width: font_italic.width
            icon.height: font_italic.height
            icon.color:"white"
            ToolTip.text: qsTr("Italic")
            ToolTip.visible: hovered
            background: Rectangle
            {
                id:font_italic_bg
                color:font_italic.hovered ? "lightblue" : "transparent"
                anchors.fill:parent
            }

            onClicked:
            {
                text_area.font.italic = true
            }
        }
        Button
        {
            id:font_underline
            y:(root.height - text_area.y - text_area.height - font_button.height)/2 + text_area.y + text_area.height
            width: height
            height: root.height * 0.3 - 35
            icon.source: "qrc:/font_icon/under_line_2.png"
            icon.width: font_underline.width
            icon.height: font_underline.height
            icon.color:"white"
            ToolTip.text: qsTr("underline")
            ToolTip.visible: hovered
            background: Rectangle
            {
                id:font_under_bg
                color:font_underline.hovered ? "lightblue" : "transparent"
                anchors.fill:parent
            }

            onClicked:
            {
                text_area.font.underline = true
            }
        }
        Label
        {
            text: "tool bar"
            height:root.height * 0.3 - 35
            elide: Label.ElideRight
            y:(root.height - text_area.y - text_area.height - close.height)/2 + text_area.y + text_area.height
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            Layout.fillWidth: true
            font.pointSize: 12
            font.family: "Arial"
            color: "white"
        }
        Button
        {
            id:close
            y:(root.height - text_area.y - text_area.height - close.height)/2 + text_area.y + text_area.height
            width: height
            height: root.height * 0.3 - 35
            //text: qsTr("Close")
            ToolTip.text: qsTr("Close")
            ToolTip.visible: hovered
            background: Rectangle
            {
                id:close_bg
                color:close.hovered ? "lightblue" : "transparent"
                anchors.fill:parent
            }

            icon.source: "qrc:/font_icon/close-square.png"
            icon.width: close.width
            icon.height: close.height
            icon.color:"white"

            onClicked:
            {
                root.close()
            }
        }
    }

    Rectangle
    {
        id:resize
        x:root.width - 10
        y:text_area.y + text_area.height
        width: 10
        height: root.height - text_area.y - text_area.height
        color: "transparent"
        MouseArea
        {
            property variant holdPos: "0,0"
            anchors.fill: parent
            cursorShape: Qt.SizeFDiagCursor

            onPressed:
            {
                holdPos  = Qt.point(mouseX,mouseY)
            }

            onPositionChanged:
            {
                var delta = Qt.point(mouseX-holdPos.x, mouseY-holdPos.y)
                root.width += delta.x;
                root.height += delta.y
                if(root.width + delta.x > 200)
                {
                    root.width += delta.x;
                }
                else
                {
                    root.width = 200;
                }

                if(root.height + delta.y > 100)
                {
                    root.height = root.height + delta.y;
                }
                else
                {
                    root.height = 100;
                }
            }
        }
    }
}
