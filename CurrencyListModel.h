#pragma once

#include <QAbstractListModel>
#include <QJsonDocument>
#include <QNetworkAccessManager>
#include <QNetworkReply>

#include "CurrencyEntry.h"

#define LOCAL

class CurrencyListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit CurrencyListModel(QObject *parent = nullptr);
    enum CurrencyRoles
    {
        CharCodeRole = Qt::UserRole + 1,
        ValueRole,
        FullInfo,
        Index,
        ImageSource
    };    
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
public:
    Q_INVOKABLE void update();
    Q_INVOKABLE QString calculate(int firstValuteIndex, int secondValuteIndex, double value) const;
    Q_INVOKABLE QString getCharCode(int index) const;
    Q_INVOKABLE QString getImageSource(int index) const;
    Q_INVOKABLE QString getCurrency(int firstValuteIndex, int secondValuteIndex) const;
    Q_INVOKABLE QString getName(int index) const;
private:
    void init();
    QString roundDouble(double value) const;
    void fetchFromNetwork();
    void populateFromLocalFile();
    void parseJson(const QJsonDocument& doc);
    void OnNetworkRequestFinished(QNetworkReply *reply);
private:
    QList<CurrencyEntry*> m_entries;
    QNetworkAccessManager* m_manager;
};
