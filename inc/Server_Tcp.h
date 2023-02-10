#ifndef SERVER_TCP_H
#define SERVER_TCP_H
#include <QtCore>
#include <QObject>
class QTcpServer;
class QTcpSocket;

class Server_Tcp : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString ipAddr READ ipAddr WRITE setIpAddr NOTIFY ipAddrChanged)
    Q_PROPERTY(quint32 port READ port WRITE setPort NOTIFY portChanged)
    Q_PROPERTY(QString rText READ rText WRITE setRText NOTIFY rTextChanged)
public:
    explicit Server_Tcp();
    ~Server_Tcp();

public:
    Q_INVOKABLE void start();
    Q_INVOKABLE bool isListen();
    Q_INVOKABLE void stop();

    QString ipAddr(){return m_ipAddr;}
    void setIpAddr(const QString& ip){m_ipAddr = ip;emit ipAddrChanged();}

    quint32 port(){return m_port;}
    void setPort(quint32 iport){m_port = iport;emit portChanged();}

    QString rText(){return m_read_text;}
    void setRText(const QString& text){m_read_text = text;emit rTextChanged();}
signals:
    void readyRead();
    void newConnect();
    void ipAddrChanged();
    void portChanged();
    void rTextChanged();
private:
    void find_server_addr();
    void init_server();
private slots:
    void accept_connect();
    void read();
private:
    QTcpServer* m_server;
    QTcpSocket* m_socket;
    QString     m_ipAddr;
    quint32     m_port;
    QString     m_read_text;
};

#endif // SERVER_TCP_H
