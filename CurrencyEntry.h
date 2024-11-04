#pragma once

#include <QObject>


class CurrencyEntry : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged FINAL)
    Q_PROPERTY(QString charCode READ charCode WRITE setCharCode NOTIFY charCodeChanged FINAL)
    Q_PROPERTY(double value READ value WRITE setValue NOTIFY valueChanged FINAL)
public:
    explicit CurrencyEntry(QObject *parent = nullptr);
    explicit CurrencyEntry(const QString& name, const QString& charCode, double value, QObject  *parent = nullptr);

    QString charCode() const;
    void setCharCode(const QString &newCharCode);

    double value() const;
    void setValue(double newValue);

    QString name() const;
    void setName(const QString &newName);

signals:
    void charCodeChanged();
    void valueChanged();

    void nameChanged();

private:
    QString m_charCode;
    double m_value;
    QString m_name;
};
