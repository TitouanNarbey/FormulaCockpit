#ifndef CIRCUIT_H
#define CIRCUIT_H

#include <QObject>
#include <QVector>
#include <QPoint>

class Circuit : public QObject
{
	Q_OBJECT
public:
	explicit Circuit(QObject *parent = nullptr);

protected:
	unsigned int m_distance; // in meters
	bool m_direction; // false = clockwise | true = anti-clockwise


	QVector<QPoint> m_startingPosition;

signals:

};

#endif // CIRCUIT_H
