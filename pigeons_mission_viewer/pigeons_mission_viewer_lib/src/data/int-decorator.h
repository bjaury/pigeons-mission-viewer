#ifndef INTDECORATOR_H
#define INTDECORATOR_H

#include <QJsonObject>
#include <QJsonValue>
#include <QObject>
#include <QScopedPointer>

#include <pigeons_mission_viewer_lib_global.h>
#include <data/data-decorator.h>

namespace pigeons_mission_viewer {
namespace data {

class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT IntDecorator : public DataDecorator
{
	Q_OBJECT

	Q_PROPERTY( int ui_value READ value WRITE setValue NOTIFY valueChanged )

public:
	IntDecorator(Entity* parentEntity = nullptr, const QString& key = "SomeItemKey", const QString& label = "", int value = 0);
	~IntDecorator();

	IntDecorator& setValue(int value);
	int value() const;

public:
	QJsonValue jsonValue() const override;
	void update(const QJsonObject& jsonObject) override;

signals:
	void valueChanged();

private:
	class Implementation;
	QScopedPointer<Implementation> implementation;
};

}}

#endif
