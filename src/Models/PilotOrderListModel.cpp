#include "PilotOrderListModel.h"

PilotOrderListModel::PilotOrderListModel(QObject *parent)
	: QAbstractListModel(parent)
	, m_list(nullptr)
{
}

int PilotOrderListModel::rowCount(const QModelIndex &parent) const
{
	// For list models only the root node (an invalid parent) should return the list's size. For all
	// other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
	if (parent.isValid() || !m_list)
		return 0;

	// FIXME: Implement me!
	return m_list->items().size();
}

QVariant PilotOrderListModel::data(const QModelIndex &index, int role) const
{
	if (!index.isValid() || !m_list)
		return QVariant();

	// FIXME: Implement me!
	const PilotOrderItem item = m_list->items().at(index.row());
	switch (role) {
	case PilotNameRole:
		return QVariant(item.name);

	case ScuderiaColorRole:
		return QVariant(item.scuderiaColor);

	case PilotCountryRole:
		return QVariant(item.pilotCountry);
	}

	return QVariant();
}

bool PilotOrderListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
	if (!m_list)
		return false;

	PilotOrderItem item = m_list->items().at(index.row());
	switch (role) {
	case PilotNameRole:
		item.name = value.toString();
		break;

	case ScuderiaColorRole:
		item.scuderiaColor = value.toString();
		break;

	case PilotCountryRole:
		item.pilotCountry = value.toString();
		break;
	}

	if (m_list->setItemAt(index.row(), item)) {
		emit dataChanged(index, index, QVector<int>() << role);
		return true;
	}
	return false;
}

Qt::ItemFlags PilotOrderListModel::flags(const QModelIndex &index) const
{
	if (!index.isValid())
		return Qt::NoItemFlags;

	return Qt::ItemIsEditable;
}

QHash<int, QByteArray> PilotOrderListModel::roleNames() const
{
	QHash<int, QByteArray> names;
	names[PilotNameRole] = "name";
	names[ScuderiaColorRole] = "scuderiaColor";
	names[PilotCountryRole] = "pilotCountry";
	return names;
}

PilotOrderList* PilotOrderListModel::list() const
{
	return m_list;
}

void PilotOrderListModel::setList(PilotOrderList* list)
{
	beginResetModel();

	if (m_list)
	{
		m_list->disconnect(this);
	}

	m_list = list;

	if (m_list)
	{
		connect(m_list, &PilotOrderList::preItemAppended, this, [=]() {
			const int index = m_list->items().size();
			beginInsertRows(QModelIndex(), index, index);
		});
		connect(m_list, &PilotOrderList::postItemAppended, this, [=]() {
			endInsertRows();
		});
		connect(m_list, &PilotOrderList::preItemRemoved, this, [=](int index) {
			beginRemoveRows(QModelIndex(), index, index);
		});
		connect(m_list, &PilotOrderList::postItemRemoved, this, [=]() {
			endRemoveRows();
		});
	}

	endResetModel();
}
