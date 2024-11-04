#include "CurrencyListModel.h"

#include <QFile>
#include <QJsonObject>

CurrencyListModel::CurrencyListModel(QObject *parent)
    : QAbstractListModel(parent)
{
    m_manager = new QNetworkAccessManager(this);
    fetchFromNetwork();
}

int CurrencyListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_entries.size();
}

QVariant CurrencyListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    int row = index.row();

    switch (role)
    {
    case CharCodeRole:
        return m_entries.at(row)->charCode();
    case ValueRole:
        return m_entries.at(row)->value();
    case Qt::DisplayRole:
        return m_entries.at(row)->name();
    case FullInfo:
        return QString("%1 - %2").arg(m_entries.at(row)->charCode()).arg(m_entries.at(row)->value());
    case Index:
        return row;
    }

    return QVariant();
}

QHash<int, QByteArray> CurrencyListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[CharCodeRole] = "charCode";
    roles[ValueRole] = "value";
    roles[FullInfo] = "fullInfo";
    roles[Index] = "index";
    return roles;
}

void CurrencyListModel::populateFromLocalFile()
{
    QFile file("../Assets/default.json");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug() << "Failed to open local json file";
        return;
    }
    parseJson(QJsonDocument::fromJson(file.readAll()));
}

void CurrencyListModel::fetchFromNetwork()
{
    QNetworkRequest request;
    request.setUrl(QUrl("https://www.cbr-xml-daily.ru/daily_json.js"));
    m_manager->get(request);
    connect(m_manager, &QNetworkAccessManager::finished, this, &CurrencyListModel::OnNetworkRequestFinished);
}

double CurrencyListModel::calculate(int firstValuteIndex, int secondValuteIndex, double value)
{
    double firstInRubles = value * m_entries.at(firstValuteIndex)->value();
    return firstInRubles / m_entries.at(secondValuteIndex)->value();
}

void CurrencyListModel::parseJson(const QJsonDocument &doc)
{
    QJsonObject rootObject = doc.object();

    QJsonObject valuteObject = rootObject.value("Valute").toObject();

    QStringList keys = valuteObject.keys();
    beginResetModel();
    for (const QString &key : keys) {
        QJsonObject currencyObject = valuteObject.value(key).toObject();

        QString id = currencyObject.value("ID").toString();
        // QString numCode = currencyObject.value("NumCode").toString();
        QString charCode = currencyObject.value("CharCode").toString();
        int nominal = currencyObject.value("Nominal").toInt();
        QString name = currencyObject.value("Name").toString();
        double value = currencyObject.value("Value").toDouble();
        double previous = currencyObject.value("Previous").toDouble();

        m_entries.append(new CurrencyEntry(name, charCode, value, this));

        // qDebug() << "Валюта:" << name;
        // qDebug() << "ID:" << id;
        // qDebug() << "Код валюты:" << charCode;
        // qDebug() << "Номинал:" << nominal;
        // qDebug() << "Текущая стоимость:" << value;
        // qDebug() << "Предыдущая стоимость:" << previous;
        // qDebug() << "--------------------------";
    }
    endResetModel();
}

void CurrencyListModel::OnNetworkRequestFinished(QNetworkReply *reply)
{
    if (reply->error() != QNetworkReply::NoError)
    {
        qDebug() << reply->errorString();
        qDebug() << "falling back to local file..";
        populateFromLocalFile();
        return;
    }
    qDebug() << "all fine!";
    parseJson(QJsonDocument::fromJson(reply->readAll()));
}
