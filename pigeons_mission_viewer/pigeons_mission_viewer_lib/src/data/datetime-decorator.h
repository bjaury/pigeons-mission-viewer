#ifndef DATETIMEDECORATOR_H
#define DATETIMEDECORATOR_H

#include <QDateTime>
#include <QJsonObject>
#include <QJsonValue>
#include <QObject>
#include <QScopedPointer>

#include <pigeons_mission_viewer_lib_global.h>
#include <data/data-decorator.h>

namespace pigeons_mission_viewer {
namespace data {

class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT DateTimeDecorator : public DataDecorator
{
	Q_OBJECT
	Q_PROPERTY( QString ui_iso8601String READ toIso8601String NOTIFY valueChanged )
	Q_PROPERTY( QString ui_prettyDateString READ toPrettyDateString NOTIFY valueChanged )
	Q_PROPERTY( QString ui_prettyTimeString READ toPrettyTimeString NOTIFY valueChanged )
	Q_PROPERTY( QString ui_prettyString READ toPrettyString NOTIFY valueChanged )
	Q_PROPERTY( QDateTime ui_value READ value WRITE setValue NOTIFY valueChanged )

public:
	DateTimeDecorator(Entity* parentEntity = nullptr, const QString& key = "SomeItemKey", const QString& label = "", const QDateTime& value = QDateTime());
	~DateTimeDecorator();

	const QDateTime& value() const;
	DateTimeDecorator& setValue(const QDateTime& value);
	QString toIso8601String() const;
	QString toPrettyDateString() const;
	QString toPrettyTimeString() const;
	QString toPrettyString() const;

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
