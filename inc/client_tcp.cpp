#include "client_tcp.h"
#include <QTcpSocket>
Client_Tcp::Client_Tcp(QObject *parent)
    : QObject(parent)
    , m_socket(new QTcpSocket(this))
{

}

void Client_Tcp::connected()
{
    m_connect_info = "Connect!";
    emit connect_success();
}

void Client_Tcp::read()
{
    m_read_info = QString(m_socket->readAll());
    emit read_success();
}

void Client_Tcp::start()
{
    m_socket->connectToHost(QHostAddress::LocalHost,m_port);
    qDebug()<< "ip: " << m_ip << " port :" << m_port;

    QAbstractSocket::SocketState  state = m_socket->state();

    qDebug() << state;

    connect(m_socket,&QTcpSocket::errorOccurred,[=](){
        qDebug() << "Error!";

        QAbstractSocket::SocketError err = m_socket->error();

        qDebug() << err;
    });

    QObject::connect(m_socket,&QTcpSocket::connected,this,&Client_Tcp::connected);

    QObject::connect(m_socket,&QTcpSocket::readyRead,this,&Client_Tcp::read);
}
