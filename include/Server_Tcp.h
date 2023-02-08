#ifndef SERVER_TCP_H
#define SERVER_TCP_H
#include <QtCore>

class QTcpServer;
class QTcpSocket;
class Server_Tcp
{
public:
    Server_Tcp();
    ~Server_Tcp();
private:

    void init_server();

private:
    QTcpServer* m_server;
    QString mIpAddr;
    quint32 mPort;
};


#endif // SERVER_TCP_H
