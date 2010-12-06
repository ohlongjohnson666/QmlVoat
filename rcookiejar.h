#ifndef RCOOKIEJAR_H
#define RCOOKIEJAR_H

#include <QNetworkCookieJar>
#include <QVariantMap>

class RCookieJar : public QNetworkCookieJar
{
    Q_OBJECT
public:
    explicit RCookieJar(QObject *parent = 0);

    virtual bool setCookiesFromUrl ( const QList<QNetworkCookie> & cookieList, const QUrl & url );

signals:

public slots:
    QVariantMap cookies();


};

#endif // RCOOKIEJAR_H
