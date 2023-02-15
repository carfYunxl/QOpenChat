#include "inc/Server_Tcp.h"
#include <QTcpServer>
#include <QTcpSocket>
#include <QHostAddress>
#include <QList>
#include <QNetworkInterface>
#include <QIODevice>

Server_Tcp::Server_Tcp()
    : m_server(nullptr)
    , m_port(0)
{
}
Server_Tcp::~Server_Tcp()
{
    delete m_server;
}


void Server_Tcp::find_server_addr()
{
    QList<QHostAddress> ipAddressList = QNetworkInterface::allAddresses();

    for(int i = 0;i < ipAddressList.size();++i)
    {
        if(ipAddressList.at(i) != QHostAddress::LocalHost && ipAddressList.at(i).toIPv4Address())
        {
            //get first ipv4 address
            m_ipAddr = ipAddressList.at(i).toString();
            break;
        }
    }

    if(m_ipAddr.isEmpty())
    {
        m_ipAddr = QHostAddress(QHostAddress::LocalHost).toString();
    }
}

void Server_Tcp::init_server()
{
    m_server = new QTcpServer(this);
    if(m_server == nullptr)
    {
        return;
    }
    if(!m_server->listen())
    {
        m_server->close();
        return;
    }

    setPort(m_server->serverPort());
    find_server_addr();
}

void Server_Tcp::start()
{
    init_server();
    QObject::connect(m_server,&QTcpServer::newConnection,this,&Server_Tcp::accept_connect);
}

void Server_Tcp::accept_connect()
{
    qDebug() << "New Connection Come!";
    QTcpSocket* socket = m_server->nextPendingConnection();

    socket->setSocketDescriptor(m_socket_vector.size());

    m_read_text = "connection come!";

    emit newConnect();

    //当server收到某个client传来的信息时，可以通过descriptor判断是哪个client
    QObject::connect(socket,&QTcpSocket::readyRead,[=]()
    {
        m_read_text = QString(socket->readAll());
        emit readyRead(socket->socketDescriptor());
    });

    m_socket_vector.push_back(socket);
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
