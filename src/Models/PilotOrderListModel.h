#ifndef PILOTORDERLISTMODEL_H
#define PILOTORDERLISTMODEL_H

#include <QAbstractListModel>

#include "./src/PilotOrderList.h"

class PilotOrderListModel : public QAbstractListModel
{
	Q_OBJECT
	Q_PROPERTY(PilotOrderList* list READ list WRITE setList)

public:
	explicit PilotOrderListModel(QObject *parent = nullptr);

	enum {
		PilotNameRole,
		ScuderiaColorRole,
		PilotCountryRole
	};

	// Basic functionality:
	int rowCount(const QModelIndex &parent = QModelIndex()) const override;

	QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

	// Editable:
	bool setData(const QModelIndex &index, const QVariant &value,
				 int role = Qt::EditRole) override;

	Qt::ItemFlags flags(const QModelIndex& index) const override;

	virtual QHash<int, QByteArray> roleNames() const override;

	PilotOrderList* list() const;

public slots:
	void setList(PilotOrderList* list);

signals:

private:
	PilotOrderList* m_list;
};

#endif // PILOTORDERLISTMODEL_H
