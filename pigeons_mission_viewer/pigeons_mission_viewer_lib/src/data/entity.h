#ifndef ENTITY_H
#define ENTITY_H

#include <map>

#include <QObject>
#include <QScopedPointer>

#include <pigeons_mission_viewer_lib_global.h>
#include <data/data-decorator.h>
#include <data/entity-collection.h>

namespace pigeons_mission_viewer {
namespace data {

class PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT Entity : public QObject
{
	Q_OBJECT

public:
	Entity(QObject* parent = nullptr, const QString& key = "SomeEntityKey");
	Entity(QObject* parent, const QString& key, const QJsonObject& jsonObject);
	virtual ~Entity();

public:
	const QString& key() const;
	void update(const QJsonObject& jsonObject);
	QJsonObject toJson() const;

signals:
	void childCollectionsChanged(const QString& collectionKey);
	void childEntitiesChanged();
	void dataDecoratorsChanged();

protected:
	Entity* addChild(Entity* entity, const QString& key);
	EntityCollectionBase* addChildCollection(EntityCollectionBase* entityCollection);
	DataDecorator* addDataItem(DataDecorator* dataDecorator);

protected:
	class Implementation;
	QScopedPointer<Implementation> implementation;
};

}}

#endif
