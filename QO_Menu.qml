import QtQuick 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Menu
{
    width: 150
    signal sendNormal();

    id: option_menu
    background: Image
    {
        anchors.fill:parent
        source:"qrc:/img/Menu_bg.jpg"
    }

    Menu
    {
        width: 150
        title: qsTr("&Send")
        background: Image
        {
            anchors.fill:parent
            source:"qrc:/img/Menu_bg.jpg"
        }

        Action
        {
            text: "&SendBox"
            icon.source: "qrc:/icon/skin.png"
            icon.color: "green"
            onTriggered:
            {
                sendNormal()
            }
        }
        Action
        {
            text: "&File"
            icon.source: "qrc:/icon/file.png"
            icon.color: "green"
        }
        Action
        {
            text: "&Picture"
            icon.source: "qrc:/icon/picture.png"
        }
        Action
        {
            text: "&Video"
            icon.source: "qrc:/icon/video.png"
            icon.color: "green"
        }
    }
    MenuSeparator { }
    Menu
    {
        width: 150
        title: qsTr("&Font")
        background: Image
        {
            anchors.fill:parent
            source:"qrc:/img/Menu_bg.jpg"
        }

        Action
        {
            text: "&Style"
            icon.source: "qrc:/img/font_style.png"
            icon.color: "green"
        }
        Action
        {
            text: "&Color"
            icon.source: "qrc:/img/font_color.png"
            icon.color: "green"
        }
        Action
        {
            text: "&Bold"
            icon.source: "qrc:/img/font_bold.png"
            icon.color: "green"
        }
        Action
        {
            text: "&Italic"
            icon.source: "qrc:/img/font_italic.png"
        }
        Action
        {
            text: "&UnderLine"
            icon.source: "qrc:/img/font_underline.png"
            icon.color: "green"
        }
    }
    MenuSeparator { }
    Action
    {
        text: "&Record"
        shortcut: "Ctrl+V"
        onTriggered: {}
    }

    MenuSeparator { }
    Menu
    {
        width: 150
        background: Image
        {
            anchors.fill:parent
            source:"qrc:/img/Menu_bg.jpg"
        }

        title: "More Stuff"

        Action
        {
            text: "Do Nothing"
            icon.color: "green"
        }
    }
}
