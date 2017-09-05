# Redmine inventory plugin

# Install

Clone to redmine/plugins directory, then migrate database.

```
cd redmine

git clone https://github.com/bryt-li/redmine_inventory_plugin.git ./plugins/redmine_inventory_plugin

rake redmine:plugins NAME=redmine_inventory_plugin
```

# Uninstall

Unmigrate plugin database, then delete redmine_inventory_plugin directory.


```
cd redmine

rake redmine:plugins:migrate NAME=redmine_inventory_plugin VERSION=0

rm -rf ./plugins/redmine_inventory_plugin
```

# Redmine db structure migration description

![Database Structure](http://uml.caratech.cn/plantuml/proxy?id=1&src=https://raw.githubusercontent.com/bryt-li/redmine_inventory_plugin/master/doc/db.puml)

