#include "CurrencyListModel.h"

#include <QFile>
#include <QJsonObject>
#include <algorithm>

CurrencyListModel::CurrencyListModel(QObject *parent)
    : QAbstractListModel(parent)
{
    m_manager = new QNetworkAccessManager(this);
    update();
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
    case ImageSource:
        return QString("Assets/%1.svg").arg(m_entries.at(row)->charCode());
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
    roles[ImageSource] = "imageSource";
    return roles;
}

void CurrencyListModel::update()
{
#ifdef LOCAL
    populateFromLocalFile();
#else
    fetchFromNetwork();
#endif
}

void CurrencyListModel::populateFromLocalFile()
{
    QFile file(":/qt/qml/CurrencyConverter/Assets/default.json");
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
    m_entries.clear();
    for (const QString &key : keys) {
        QJsonObject currencyObject = valuteObject.value(key).toObject();

        // QString id = currencyObject.value("ID").toString();
        // QString numCode = currencyObject.value("NumCode").toString();
        QString charCode = currencyObject.value("CharCode").toString();
        // int nominal = currencyObject.value("Nominal").toInt();
        QString name = currencyObject.value("Name").toString();
        double value = currencyObject.value("Value").toDouble();
        // double previous = currencyObject.value("Previous").toDouble();
        m_entries.append(new CurrencyEntry(name, charCode, value, this));
    }
    m_entries.append(new CurrencyEntry("Российский рубль", "RUB", 1.00, this));
    std::sort(m_entries.begin(), m_entries.end(), [](const CurrencyEntry* const lhs, const CurrencyEntry*  const rhs){return lhs->charCode() < rhs->charCode();});
    endResetModel();
}

void CurrencyListModel::OnNetworkRequestFinished(QNetworkReply *reply)
{
    if (reply->error() != QNetworkReply::NoError)
    {
        qDebug() << reply->errorString();
        qDebug() << "network error, falling back to local file..";
        populateFromLocalFile();
        return;
    }
    parseJson(QJsonDocument::fromJson(reply->readAll()));
}
