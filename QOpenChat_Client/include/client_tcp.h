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
    Q_INVOKABLE void qml_send(QString str);

    Q_PROPERTY(QString cInfo READ cInfo WRITE setCInfo NOTIFY cInfoChanged)
    Q_PROPERTY(QString rInfo READ rInfo WRITE setRInfo NOTIFY rInfoChanged)

    QString cInfo(){return m_connect_info;}
    void setCInfo(const QString& info){m_connect_info = info;emit cInfoChanged();}

    QString rInfo(){return m_read_info;}
    void setRInfo(const QString& info){m_read_info = info;emit rInfoChanged();}

signals:
    void connect_success();
    void read_success();

    void cInfoChanged();
    void rInfoChanged();
private slots:
    void connected();
    void read();

private:
    QTcpSocket*     m_socket;
    QString         m_connect_info;
    QString         m_read_info;
};

#endif // CLIENT_TCP_H
