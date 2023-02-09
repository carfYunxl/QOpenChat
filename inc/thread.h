#ifndef THREAD_H
#define THREAD_H

#include <QThread>
#include <QObject>

class Thread : public QThread
{
    Q_OBJECT
public:
    explicit Thread(QObject *parent = nullptr);

private:
    void run() override;

signals:
    void resultReady();
};

#endif // THREAD_H
