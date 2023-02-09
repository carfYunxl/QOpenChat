#include "inc/Server_Tcp.h"
#include <QTcpServer>
#include <QTcpSocket>
#include <QHostAddress>
#include <QList>
#include <QNetworkInterface>

Server_Tcp::Server_Tcp()
    : m_server(nullptr)
    , m_socket(nullptr)
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

    find_server_addr();
}

void Server_Tcp::start()
{
    init_server();
    QObject::connect(m_server,&QTcpServer::newConnection,this,&Server_Tcp::accept_connect);
}

void Server_Tcp::accept_connect()
{
    m_socket = m_server->nextPendingConnection();

    QObject::connect(m_socket,&QTcpSocket::readyRead,this,&Server_Tcp::read);
}

void Server_Tcp::read()
{
    m_read_text = QString(m_socket->readAll());
    emit readyRead();
}

bool Server_Tcp::isListen()
{
    return m_server->isListening();
}
