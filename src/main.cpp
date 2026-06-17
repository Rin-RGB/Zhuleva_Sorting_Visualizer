#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "ArrayModel.h"
#include "SortingController.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    ArrayModel arrayModel;

    SortingController controller(&arrayModel);

    controller.selectAlgorithm("Пузырёк");

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty(
        "arrayModel", &arrayModel);

    engine.rootContext()->setContextProperty(
        "controller", &controller);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(QUrl(QStringLiteral("qrc:/qml/Main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
