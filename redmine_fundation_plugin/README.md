
# Redmine fundation plugin

# Install

Clone to redmine/plugins directory, then migrate database.

```
cd redmine

git clone https://github.com/bryt-li/redmine_fundation_plugin.git ./plugins/redmine_fundation_plugin

rake redmine:plugins NAME=redmine_fundation_plugin
```

# Uninstall

Unmigrate plugin database, then delete redmine_fundation_plugin directory.


```
cd redmine

rake redmine:plugins:migrate NAME=redmine_fundation_plugin VERSION=0

rm -rf ./plugins/redmine_fundation_plugin
```

# Redmine db structure migration description

![Database Structure](http://uml.caratech.cn/plantuml/proxy?id=1&src=https://raw.githubusercontent.com/bryt-li/redmine_fundation_plugin/master/doc/db.puml)

