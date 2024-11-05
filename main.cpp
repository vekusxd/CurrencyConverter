#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QSGRendererInterface>
#include <QFontDatabase>

#include "CurrencyListModel.h"

void SetDefaultFont();

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

#ifdef LOCAL
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGL);
#endif

    QQmlApplicationEngine engine;

    SetDefaultFont();

    qmlRegisterType<CurrencyListModel>("CurrencyModel", 1, 0,"CurrencyModel");
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("CurrencyConverter", "Main");

    return app.exec();
}


void SetDefaultFont()
{
    qint32 fontId = QFontDatabase::addApplicationFont(":/qt/qml/CurrencyConverter/Assets/Roboto.ttf");
    QStringList fontList = QFontDatabase::applicationFontFamilies(fontId);
    QString family = fontList.first();
    QGuiApplication::setFont(QFont(family));
}
