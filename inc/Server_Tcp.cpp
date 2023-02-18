#include "inc/Server_Tcp.h"
#include <QTcpServer>
#include <QTcpSocket>
#include <QList>
#include <QNetworkInterface>
#include <QIODevice>

Server_Tcp::Server_Tcp()
    : m_server(nullptr)
{
}
Server_Tcp::~Server_Tcp()
{
    delete m_server;
}

void Server_Tcp::init_server()
{
    m_server = new QTcpServer(this);

    if(m_server == nullptr)
    {
        return;
    }
    if(!m_server->listen(QHostAddress::Any,8888))
    {
        m_server->close();
        return;
    }
}

void Server_Tcp::start()
{
    init_server();
    QObject::connect(m_server,&QTcpServer::newConnection,this,&Server_Tcp::accept_connect);
}

void Server_Tcp::accept_connect()
{
    QTcpSocket* socket = m_server->nextPendingConnection();
    m_socket_vector.push_back(socket);

    QString str = "hello,connect to you!";
    socket->write(str.toUtf8().data());

    emit newConnect(socket->peerPort());

    QObject::connect(socket,&QTcpSocket::readyRead,[=]()
    {
        m_read_text = QString(socket->readAll());
        emit readyRead(socket->peerPort());
    });

    QObject::connect(socket,&QTcpSocket::disconnected,[=](){
        qDebug() << "Client "
                 << socket->peerPort()
                 << "address "
                 << socket->peerAddress()
                 << "name "
                 << socket->peerName()
                 << "off line";

        emit client_offline(socket->peerPort());


//        for(int i = 0;i < m_socket_vector.size();++i)
//        {
//            if(m_socket_vector.at(i)->peerPort() == socket->peerPort())
//            {
//                delete m_socket_vector.at(i);
//                break;
//            }
//        }
    });
}

bool Server_Tcp::isListen()
{
    return m_server->isListening();
}

void Server_Tcp::closeServer()
{
    m_server->close();
}

void Server_Tcp::writeMsg(const QString& msg,int descriptor)
{
    for(qsizetype i = 0;i < m_socket_vector.size();++i)
    {
        if(m_socket_vector.at(i)->socketDescriptor() == descriptor)
        {
            m_socket_vector.at(i)->write(msg.toLocal8Bit());
            break;
        }
    }

}
