#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <iostream>

// Circuits
#include "./src/Circuit.h"
#include "./src/Circuits/Circuit_de_Monaco.h"

// Models
#include "./src/Models/PilotOrderListModel.h"
#include "./src/PilotOrderList.h"

int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

	QGuiApplication app(argc, argv);


	qmlRegisterType<Circuit_de_Monaco>("cockpit.circuits", 1, 0, "Monaco");
	qmlRegisterType<PilotOrderListModel>("cockpit.models", 1, 0, "PilotOrderListModel");
	qmlRegisterUncreatableType<PilotOrderList>("cockpit.models", 1, 0, "PilotOrderList", QStringLiteral("PilotOrderList should not be created in QML"));


	PilotOrderList pilotOrderList;


	QQmlApplicationEngine engine;


	engine.rootContext()->setContextProperty(QStringLiteral("pilotOrderList"), &pilotOrderList);

	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.load(url);

	//pilotOrderList.setItemAt(3, { QString("Räikkönen") , QColor("white")   , QString("world")});
	//std::cout << pilotOrderList.items().at(3).name.toStdString() << std::endl;

	return app.exec();
}
