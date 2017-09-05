class ManualController < ApplicationController  
	unloadable

	def index
		@manual_index = <<-eos

h1. WIKI语法

h2. 基本语法

{{iframe(/help/zh/wiki_syntax_textile.html,100%,500px)}}

h2. 详细语法

{{iframe(/help/zh/wiki_syntax_detailed_textile.html,100%,500px)}}

h2. 绘图

h3. PlantUML绘图

* "Redmine插件":https://github.com/dkd/plantuml
* "PlantUML官网":http://plantuml.com/
* "PlantUML在线编辑器":http://www.planttext.com/planttext
* "PlantUML文档":http://plantuml.com/PlantUML_Language_Reference_Guide.pdf
* Wiki页面语法示例：

<pre>
{{plantuml(svg)

package ClientNoBizCloudSdk {
    [Message]
    [Rtc]
    [Livecast]
    [Account]
}

}}
</pre>

h3. Graphviz绘图

* "Graphviz插件":https://github.com/tckz/redmine-wiki_graphviz_plugin
* "Graphviz官网":http://www.graphviz.org/
* 有可视化的图形编辑器
* Graphviz PDF手册: http://www.graphviz.org/pdf/dotguide.pdf
* Wiki页面语法示例：

<pre>
{{graphviz_link()

digraph UI {
  graph [size="10,10"]
  edge [fontname="WenQuanYi Zen Hei" dir="both"];
  node [fontname="WenQuanYi Zen Hei"];

  subgraph cluster_launcher {
    graph [label="Launcher桌面总入口"]
    Launcher桌面 [URL=""]
    个人设置 [URL=""]
    系统设置 [URL=""]

    Launcher桌面 -> 个人设置
    Launcher桌面 -> 系统设置
  }


  subgraph cluster_vs {
    graph [label="视频通信服务"]
    视频通信服务首页 [URL="/projects/vs-launcher/repository/vs-launcher-design/revisions/master/raw/news-tv.jpg"]
  }

  subgraph cluster_msg {
    graph [label="消息服务首页"]
    消息中心 [URL=""]
  }

  subgraph cluster_dvbvod {
    graph [label="广电基础视频服务"]
    直播时移 [URL=""]
    点播回看 [URL=""]
    高清VR [URL=""]
  }

  subgraph cluster_game {
    graph [label="集成代代星游戏"]
    游戏 [URL=""]
  }

  subgraph cluster_other {
    graph [label="集成第三方服务"]
    其它 [URL=""]
  }

  Launcher桌面 -> 直播时移
  Launcher桌面 -> 点播回看
  Launcher桌面 -> 高清VR
  Launcher桌面 -> 视频通信服务首页
  Launcher桌面 -> 消息中心
  Launcher桌面 -> 游戏
  Launcher桌面 -> 其它

}

}}

</pre>

使用第三方在线可视化绘图工具

如： https://www.processon.com


h2. 扩展语法

{{macro_list}}

h1. 修改Prodject ID

<pre>
rails console

p = Project.where(identifier: 'old_id').first
p.instance_eval { self['identifier'] = 'new_id' }
p.save
</pre>
		eos

	end

end

