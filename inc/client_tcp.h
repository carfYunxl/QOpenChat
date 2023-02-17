#ifndef CLIENT_TCP_H
#define CLIENT_TCP_H

#include <QtCore>
#include <QObject>

class QTcpSocket;
class Client_Tcp : public QObject
{
    Q_OBJECT
public:
    explicit Client_Tcp(QObject *parent = nullptr);
public:
    Q_INVOKABLE void start();
    Q_INVOKABLE void qml_disConnect();

    Q_PROPERTY(QString ip READ ip WRITE setIp NOTIFY ipChanged)
    Q_PROPERTY(quint16 port READ port WRITE setPort NOTIFY portChanged)
    Q_PROPERTY(QString cInfo READ cInfo WRITE setCInfo NOTIFY cInfoChanged)
    Q_PROPERTY(QString rInfo READ rInfo WRITE setRInfo NOTIFY rInfoChanged)

    QString ip(){return m_ip;}
    void setIp(const QString& ip){m_ip = ip;emit ipChanged();}

    quint16 port(){return m_port;}
    void setPort(quint16 port){m_port = port;emit portChanged();}

    QString cInfo(){return m_connect_info;}
    void setCInfo(const QString& info){m_connect_info = info;emit cInfoChanged();}

    QString rInfo(){return m_read_info;}
    void setRInfo(const QString& info){m_read_info = info;emit rInfoChanged();}

signals:
    void connect_success();
    void read_success();

    void ipChanged();
    void portChanged();
    void cInfoChanged();
    void rInfoChanged();
private slots:
    void connected();
    void read();


private:
    QTcpSocket*     m_socket;
    QString         m_ip;
    quint16         m_port;
    QString         m_connect_info;
    QString         m_read_info;
};

#endif // CLIENT_TCP_H
