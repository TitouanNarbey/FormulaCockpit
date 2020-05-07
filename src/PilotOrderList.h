#ifndef PILOTORDERLIST_H
#define PILOTORDERLIST_H

#include <QObject>
#include <QVector>
#include <QColor>

struct PilotOrderItem
{
	QString name;
	QColor scuderiaColor;
	QString pilotCountry;


};

class PilotOrderList : public QObject
{
	Q_OBJECT
public:
	explicit PilotOrderList(QObject *parent = nullptr);

	QVector<PilotOrderItem> items() const;

	bool setItemAt(int index, const PilotOrderItem& item);

signals:
	void preItemAppended();
	void postItemAppended();

	void preItemRemoved(int index);
	void postItemRemoved();

public slots:
	void appendItem();
	void removeItems();

private:
	QVector<PilotOrderItem> m_items;
};

#endif // PILOTORDERLIST_H
