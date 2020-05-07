#include "PilotOrderList.h"

PilotOrderList::PilotOrderList(QObject *parent) : QObject(parent)
{
	m_items.append({ QString("Leclerc")   , QColor("red")     , QString("world")});
	m_items.append({ QString("Hamilton")  , QColor("silver")  , QString("world")});
	m_items.append({ QString("Verstappen"), QColor("darkblue"), QString("world")});
	m_items.append({ QString("Vettel")    , QColor("red")     , QString("world")});
	m_items.append({ QString("Bottas")    , QColor("silver")  , QString("world")});
	m_items.append({ QString("Ricciardo") , QColor("yellow")  , QString("world")});
	m_items.append({ QString("Norris")    , QColor("orange")  , QString("world")});
	m_items.append({ QString("Räikkönen") , QColor("white")   , QString("world")});
}

QVector<PilotOrderItem> PilotOrderList::items() const
{
	return m_items;
}

bool PilotOrderList::setItemAt(int index, const PilotOrderItem& item)
{
	if(index < 0 || index >= m_items.size())
		return false;

	const PilotOrderItem& oldItem = m_items.at(index);
	if (item.name == oldItem.name && item.scuderiaColor == oldItem.scuderiaColor && item.pilotCountry == oldItem.pilotCountry)
		return false;

	m_items[index] = item;
	return true;
}

void PilotOrderList::appendItem()
{
	emit preItemAppended();

	PilotOrderItem item;
	/* init values here*/
	m_items.append(item);

	emit postItemAppended();
}

void PilotOrderList::removeItems()
{
	for (int i=0; i < m_items.size(); )
	{
		emit preItemRemoved(i);

		m_items.removeAt(i);

		emit postItemRemoved();
	}
}
