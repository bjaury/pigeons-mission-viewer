#ifndef ENUMERATORDECORATOR_H
#define ENUMERATORDECORATOR_H

#include <map>

#include <QJsonObject>
#include <QJsonValue>
#include <QObject>
#include <QScopedPointer>

#include <pigeons_mission_viewer_lib_global.h>
#include <data/data-decorator.h>

namespace pigeons_mission_viewer {
namespace data {

class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT EnumeratorDecorator : public DataDecorator
{
	Q_OBJECT
	Q_PROPERTY( int ui_value READ value WRITE setValue NOTIFY valueChanged )
	Q_PROPERTY( QString ui_valueDescription READ valueDescription NOTIFY valueChanged )

public:
	EnumeratorDecorator(Entity* parentEntity = nullptr, const QString& key = "SomeItemKey", const QString& label = "", int value = 0, const std::map<int, QString>& descriptionMapper = std::map<int, QString>());
	~EnumeratorDecorator();

	EnumeratorDecorator& setValue(int value);
	int value() const;
	QString valueDescription() const;

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
