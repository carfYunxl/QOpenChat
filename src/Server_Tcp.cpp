#include "Server_Tcp.h"
#include <QTcpServer>
#include <QTcpSocket>
#include <QHostAddress>
#include <QList>
#include <QNetworkInterface>

Server_Tcp::Server_Tcp(quint32 port):m_server(nullptr),m_port(port)
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
            mIpAddr = ipAddressList.at(i).toString();
            break;
        }
    }

    if(ipAddress.isEmpty())
    {
        mIpAddr = QHostAddress(QHostAddress::LocalHost).toString();
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

    //ui->label->setText
    //("Server is running,please open your client now...\nIp = " + ipAddress + "\nPort = "
    //+ QString::number(server->serverPort()));
}
