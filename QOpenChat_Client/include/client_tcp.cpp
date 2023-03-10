#include "client_tcp.h"
#include <QTcpSocket>
#include <QHostAddress>
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
    m_socket->connectToHost(QHostAddress::LocalHost,8888);

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

void Client_Tcp::qml_disConnect()
{
    m_socket->disconnectFromHost();
}

void Client_Tcp::qml_send(QString str)
{
    m_socket->write(str.toUtf8().data());
}
