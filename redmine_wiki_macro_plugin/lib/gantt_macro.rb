# coding: utf-8
module WikiMacro

  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
Draw gantt diagraph
Available themes: skyblue broadway meadow terrace contrast_black contrast_white
Usage:
      {{gantt(skyblue,1,100%,1600px)
{"text":"STB机顶盒硬件组", "subtasks": [
    {"text":"跟踪打板、测试、开模、修模、试产", "assignee":"钟佳龙", "priority":1, "start_date":"12-01-2017", "duration":"9"},
    {"text":"跟踪确定蓝牙音箱模块、音频、NFC和摄像头",    "assignee":"钟佳龙", "priority":1, "start_date":"12-1-2017", "duration":"9"},
]},
{"text":"产品组","subtasks": [
    {"text":"产品文档",       "assignee":"黄焙饶",   "start_date":"12-1-2017", "duration":"13"},
]},
{"text":"测试组", "subtasks": [
]},
{"text":"TV端软件开发组", "subtasks": [
    {"text":"Android操作系统定制","subtasks": [
      {"text":"双网卡，明细路由", "assignee":"贺发祥", "start_date":"17-1-2017", "duration":"7"},
    ]},
    {"text":"终端应用基础库开发","subtasks": [
      {"text":"I2S音频",    "assignee":"贺发祥", "start_date":"17-1-2017", "duration":"5"},
    ]},
    {"text":"通信基础库开发","subtasks": [
    ]},
    {"text":"系统级通用应用开发", "subtasks": [
    ]},
    {"text":"Launcher桌面开发", "subtasks": [
      {"text":"1.0 APK体验优化",    "assignee":"吴仁海", "start_date":"10-1-2017", "duration":"12"},
      {"text":"2.0 H5-Launcher前端",    "assignee":"陈燕", "start_date":"17-1-2017", "duration":"8"},
      {"text":"2.0 H5-Launcher APK",    "assignee":"温丹", "start_date":"14-1-2017", "duration":"8"},
    ]},
    {"text":"TV端VS应用开发", "subtasks": [
      {"text":"1.0 APK体验优化和分拆",   "assignee":"吴仁海", "start_date":"12-1-2017", "duration":"7"},
    ]},
    {"text":"TV端VoD应用开发", "subtasks": [
      {"text":"1.0 APK体验优化和分拆",   "assignee":"吴仁海", "start_date":"12-1-2017", "duration":"7"},
    ]},
]},
{"text":"Mobile应用软件开发组", "subtasks": [
    {"text":"Android端VS应用开发", "subtasks": [
      {"text":"增加拨号盘功能，发布", "assignee":"陈昱", "start_date":"12-1-2017", "duration":"5"},
    ]},
    {"text":"iOS端VS应用开发", "subtasks": [
      {"text":"增加拨号盘功能，发布",   "assignee":"刘灿", "start_date":"12-1-2017", "duration":"5"},
    ]},
    {"text":"微信小程序开发", "subtasks": [
      {"text":"实现查找和添加好友功能",  "assignee":"陈昱", "start_date":"12-1-2017", "duration":"9"},
    ]},
]},
{"text":"服务器端应用软件开发组", "subtasks": [
    {"text":"管理后台开发", "subtasks": [
      {"text":"Backend后台应用",  "assignee":"王雷磊", "start_date":"12-1-2017", "duration":"7"},
      {"text":"Backend前端应用",  "assignee":"王雷磊", "start_date":"12-1-2017", "duration":"7"},
    ]},
]},
{"text":"运维组", "subtasks": [
  {"text":"部署应用系统，测试环境搭建",    "assignee":"李昕", "start_date":"12-1-2017", "duration":"9"},
]},
{"text":"运营组","subtasks": [
    {"text":"微信公众号",    "assignee":"李昕",  "start_date":"12-1-2017", "duration":"9"},
    {"text":"高清和VR内容",    "assignee":"刘小军,黄焙饶", "start_date":"12-1-2017", "duration":"4"},
]},
      }}
eos
    macro :gantt, :parse_args => false do |obj, args, text|

      theme = args.split(',')[0]
      step = args.split(',')[1]
      width = args.split(',')[2]
      height = args.split(',')[3]

      content = '<script> var head = document.getElementsByTagName("head")[0], '
      if theme && !theme.empty? 
        content = content + "t = document.createElement(\"link\"); t.href =\"/plugin_assets/bryt_wiki_extension/gantt/skins/dhtmlxgantt_#{theme}.css\"; t.media=\"all\"; t.rel=\"stylesheet\"; head.appendChild(t); "
      else
        content = content + 't = document.createElement("link"); t.href ="/plugin_assets/bryt_wiki_extension/gantt/dhtmlxgantt.css"; t.media="all"; t.rel="stylesheet"; head.appendChild(t); '
      end
      content = content + '</script>'
      content = content + '<script src="/plugin_assets/bryt_wiki_extension/gantt/dhtmlxgantt.js"></script>'
      content = content + '<script src="/plugin_assets/bryt_wiki_extension/gantt/ext/dhtmlxgantt_marker.js"></script>'
      content = content + '<script src="/plugin_assets/bryt_wiki_extension/gantt/dhtmlxgantt_locale_cn.js"></script>'

      style = <<-eos
.high{
  border:2px solid #d96c49;
  color: #d96c49;
  background: #d96c49;
}
.high .gantt_task_progress{
  background: #db2536;
}

.medium{
  border:2px solid #34c461;
  color:#34c461;
  background: #34c461;
}
.medium .gantt_task_progress{
  background: #23964d;
}

.low{
  border:2px solid #6ba8e3;
  color:#6ba8e3;
  background: #6ba8e3;
}
.low .gantt_task_progress{
  background: #547dab;
}
.none{
  display:none;
}
      eos

      content = content + "<style type=\"text/css\">#{style} #gantt{width:#{width};height:#{height};}
</style>"

      html = '<div id="gantt"></div>'
      content = content+html

      script = 'var data = [' + text + '];' + <<-eos
      
gantt.config.columns=[
  {name:"text",       label:"任务",  tree:true, width:"*", resize:true },
  {name:"priority",   label:"优先级",   align: "center", template:function(obj){
      if (obj.priority == 0){ return ""}
      if (obj.priority == 2){ return "中等"}
      if (obj.priority == 3){ return "紧急"}
      return "普通"
  } },
  {name:"assignee",   label:"负责人", width:"110" },
];

gantt.templates.task_class  = function(start, end, task){
  switch (task.priority){
    case 0:
      return "none";
      break;
    case 1:
      return "low";
      break;
    case 2:
      return "medium";
      break;
    case 3:
      return "high";
      break;
  }
};

var date_to_str = gantt.date.date_to_str(gantt.config.task_date);
var markerId = gantt.addMarker({
    start_date: new Date(), //a Date object that sets the marker's date
    css: "today", //a CSS class applied to the marker
    text: "Now", //the marker title
    title:date_to_str( new Date()) // the marker's tooltip
});

gantt.config.grid_width = 450;
gantt.config.scale_unit = "month";
gantt.config.date_scale = "%F, %Y";

gantt.config.scale_height = 50;


gantt.init("gantt");

var tasks = {
  "data":[
  ],
  "links":[
  ]
};

var id = 0;
function fillTaskData(data,parent){
  for(var i=0;i<data.length;i++){
    id++;
    var task = {
      "id":id,
      "parent": parent,
      "text":data[i]["text"], 
      "assignee": data[i]["assignee"]?data[i]["assignee"]:"", 
      "progress": data[i]["subtasks"]?0:data[i]["progress"],
      "priority": data[i]["subtasks"]?0:(data[i]["priority"]?data[i]["priority"]:1),
      "start_date":data[i]["start_date"], 
      "duration":data[i]["duration"],
      "open": true
    };
    tasks["data"].push(task);
    //console.log(task);
    if(data[i]["subtasks"])
      fillTaskData(data[i]["subtasks"],id);
  }
}
      eos

      script = script + "gantt.config.subscales = [{unit:\"day\", step:#{step}, date:\"%j, %D\" }];"

      script = script + "fillTaskData(data, id);gantt.parse(tasks);"

      content = content + "<script>#{script}</script>";
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end
end