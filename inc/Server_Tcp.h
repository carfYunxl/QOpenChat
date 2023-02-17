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
    Q_PROPERTY(size_t descriptor READ descriptor WRITE setDescriptor NOTIFY descriptorChanged)
public:
    explicit Server_Tcp();
    ~Server_Tcp();

public:
    Q_INVOKABLE void start();
    Q_INVOKABLE bool isListen();
    Q_INVOKABLE void closeServer();
    Q_INVOKABLE void writeMsg(const QString& msg,int descriptor);

    QString ipAddr(){return m_ipAddr;}
    void setIpAddr(const QString& ip){m_ipAddr = ip;emit ipAddrChanged();}

    quint32 port(){return m_port;}
    void setPort(quint32 iport){m_port = iport;emit portChanged();}

    QString rText(){return m_read_text;}
    void setRText(const QString& text){m_read_text = text;emit rTextChanged();}

    size_t descriptor() const;
    void setDescriptor(size_t newDescriptor);

signals:
    void readyRead(int descriptor);
    void newConnect();
    void ipAddrChanged();
    void portChanged();
    void rTextChanged();
    void descriptorChanged();

private:
    void find_server_addr();
    void init_server();
private slots:
    void accept_connect();
private:
    QList<QTcpSocket*>  m_socket_vector;

    QTcpServer* m_server;
    QString     m_ipAddr;
    quint32     m_port;
    QString     m_read_text;
    size_t      m_descriptor;
};

#endif // SERVER_TCP_H
