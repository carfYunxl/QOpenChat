import QtQuick 2.2
import QtQuick.Controls 2.5

Rectangle
{
    property alias newWidth: root.width
    property alias newHeight: root.height

    id:root
    FloatToolBar
    {
        id:bar
        awidth: root.width
        bheight: 30
        background_color: "blue"
        background_radius: 1

        anchors.top: root.top

        inner_control_radius: 5
        inner_control_width: 50

        onPressIdxSignal: function(idx)
        {
            bar.setIcon(idx,"qrc:/img/star2.png")
            dlg.open()
        }

        onReleaseIdxSignal: function(idx)
        {
            bar.setIcon(idx,"qrc:/img/star1.png")
        }
    }

    Dialog
    {
        id: dlg
        title: "Title"
        x:100
        y:100
        standardButtons: Dialog.Ok | Dialog.Cancel

        onAccepted:
        {
            dlg.close()
        }
        onRejected:
        {
            dlg.close()
        }
    }


    Flickable
    {
         id: flick
         width: root.width
         height: root.height * 0.6
         anchors.top: bar.bottom

         contentWidth: flick.width
         contentHeight: flick.height
         clip: true

         function ensureVisible(r)
         {
             if (contentX >= r.x)
                 contentX = r.x;
             else if (contentX+width <= r.x+r.width)
                 contentX = r.x+r.width-width;
             if (contentY >= r.y)
                 contentY = r.y;
             else if (contentY+height <= r.y+r.height)
                 contentY = r.y+r.height-height;
         }

         Rectangle
         {
             anchors.fill: parent
             border.color: "black"
             border.width: 1
             TextEdit
             {
                 id: edit
                 width: root.width
                 textFormat: TextEdit.RichText
                 text: "<b>Hello</b> <i>World!</i>"
                 focus: true
                 wrapMode: TextEdit.Wrap
                 onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
                 selectByMouse: true
             }
         }
     }

    FloatToolBar
    {
        id:bar2
        awidth: root.width
        bheight: 30
        background_color: "blue"
        background_radius: 1
        anchors.top: flick.bottom

        inner_control_radius: 5
        inner_control_width: 50

        onPressIdxSignal: function(idx)
        {
            bar2.setIcon(idx,"qrc:/img/star2.png")
            dlg.open()
        }

        onReleaseIdxSignal: function(idx)
        {
            bar2.setIcon(idx,"qrc:/img/star1.png")
        }
    }

    TextArea
    {
        width: root.width
        height: root.height * 0.2
        color: "white"
        font.family: "Arial"
        font.pixelSize: 30
        anchors.top: bar2.bottom

        background: Rectangle
        {
            anchors.fill:parent
            color:"darkgrey"
        }
    }

}
