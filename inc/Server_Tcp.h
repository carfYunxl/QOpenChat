#ifndef SERVER_TCP_H
#define SERVER_TCP_H
#include <QtCore>
#include <QObject>
class QTcpServer;
class QTcpSocket;
class Server_Tcp : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString rText READ rText WRITE setRText NOTIFY rTextChanged)
public:
    explicit Server_Tcp();
    ~Server_Tcp();

public:
    Q_INVOKABLE void start();
    Q_INVOKABLE bool isListen();
    Q_INVOKABLE void closeServer();
    Q_INVOKABLE void writeMsg(const QString& msg,int descriptor);

    QString rText(){return m_read_text;}
    void setRText(const QString& text){m_read_text = text;emit rTextChanged();}

signals:
    void readyRead(int port);
    void newConnect(int port);
    void rTextChanged();
    void client_offline(int port);
private:
    void init_server();
private slots:
    void accept_connect();
private:
    QList<QTcpSocket*>  m_socket_vector;
    QTcpServer* m_server;
    QString     m_read_text;
};

#endif // SERVER_TCP_H
