#include "CurrencyEntry.h"

CurrencyEntry::CurrencyEntry(QObject *parent)
    : QObject{parent}
{}

CurrencyEntry::CurrencyEntry(const QString& name, const QString &charCode, double value, QObject *parent)
    : m_name{name},m_charCode{charCode}, m_value{value}, QObject{parent}
{

}

QString CurrencyEntry::charCode() const
{
    return m_charCode;
}

void CurrencyEntry::setCharCode(const QString &newCharCode)
{
    if (m_charCode == newCharCode)
        return;
    m_charCode = newCharCode;
    emit charCodeChanged();
}

double CurrencyEntry::value() const
{
    return m_value;
}

void CurrencyEntry::setValue(double newValue)
{
    if (qFuzzyCompare(m_value, newValue))
        return;
    m_value = newValue;
    emit valueChanged();
}

QString CurrencyEntry::name() const
{
    return m_name;
}

void CurrencyEntry::setName(const QString &newName)
{
    if (m_name == newName)
        return;
    m_name = newName;
    emit nameChanged();
}
