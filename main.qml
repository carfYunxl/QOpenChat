import QtQuick 2.2
import QtQuick.Window
import QtQuick.Controls 2.5
import Server 1.0
import Client 1.0

Window
{
    id:root
    width: 1280
    height: 860
    visible: true
    title: qsTr("QOpenChat")
//    flags: Qt.FramelessWindowHint
//    Component.onCompleted:
//    {
//        console.log("flags: ",flags)
//    }

    Server_Tcp
    {
        id:server
        onNewConnect:
        {
            edit_server.text = server.rText;
        }
        onReadyRead:
        {
            edit_server.text = server.rText;
        }
    }

    Client_Tcp
    {
        id:client
        onConnect_success:
        {
            edit_client.append(client.cInfo);
        }
    }

    Button
    {
        id:open_server
        x:10
        y:10
        width: 100
        height: 50
        text: qsTr("Open Server")
        background: Rectangle
        {
            id:bg_s
            anchors.fill:parent
            color: "yellow"
            radius:10
        }
        onClicked:
        {
            server.start()
            server.isListen() ? edit_server.append(qsTr("server is listening...")) : edit_server.append(qsTr("server open failed"))

            console.log(server.ipAddr)
            console.log(server.port)

            client.ip = server.ipAddr;
            client.port = server.port;
        }
    }

    Button
    {
        id:open_client
        x:120
        y:10
        width: 100
        height: 50
        text: qsTr("Open Client")
        background: Rectangle
        {
            id:bg_c
            anchors.fill:parent
            color: "lightblue"
            radius:10
        }
        onClicked:
        {
            client.start();
            edit_client.append(qsTr(client.cInfo));
        }
    }

    ServerUI
    {
        id:server_ui
        newWidth: root.width
        newHeight: 600
        y:100
    }
}
