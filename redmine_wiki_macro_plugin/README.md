h1. What does it do?

This redmine plugin exposes extra macros in your redmine wikis. These macros are used to dynamically load css file, js file or inject raw HTML into your wiki page.

h2. Article wiki


    {{article_begin(XXXX数据服务购买合同|XXXX合同范本)}}

    甲乙双方经过平等、友好协商，根据公平、自愿和诚信的原则，就甲方购买乙方明星数据信息服务的有关事宜达成如下合同，双方共同遵守： 

    {{part(产品及服务)}}
    {{term(甲方同意购买乙方的XX数据信息服务（明细见附件一）。服务期为 壹 年，自  2017 年3 月 15 日至 2018 年 3 月 14日止。 服务期间的数据更新频率为保证每24小时内每个明星的数据至少刷新一次。)}}

    {{part(交付、使用和维护)}}
    {{term(本合同生效后，乙方收到甲方安装数据要求的10个工作日内将数据信息服务内容按照双方确认的格式传输到甲方指定服务器上，并以此作为数据交付的依据。)}}
    {{term(乙方将负责甲方使用数据期间出现问题的维护工作，这种维护不被认为是数据质量事故。 )}}
    {{term(在使用数据过程中，甲方对于数据的咨询，乙方有义务及时解答。 )}}
    {{term(乙方应向甲方提供必要的免费技术培训。)}} 
    {{term(由于甲方故意或过失造成乙方已交付数据故障或丢失的，如果甲方要求，乙方可以代为修复，但甲方应当支付相应的修复费用。)}}
    {{term(双方认识到互联网数据知识产权属于第三方拥有，数据本身的风险性以及对数据信息使用的广泛性、时效性以及多目的用途，因此甲方对其因使用乙方数据开展相关业务可能造成的所有技术风险和法律风险的后果自负。)}}

    {{part(价格和支付方式)}}
    {{term(甲方购买的明星数据信息服务总额为人民币（大写） 贰拾万 元整。)}}
    {{term(甲方应于本合同签署后十五个工作日内将合同总价款50%即人民币（大写）拾万元整支付给乙方。在乙方提供数据服务6个月后支付合同总价款50%即人民币（大写）拾万元整支付给乙方。乙方应提供产品的正式销售发票。 乙方账户名：       开户银行：               银行账号：                )}}

    {{part(知识产权)}}
    {{term(乙方数据提供的数据信息均来自互联网，乙方不拥有本合同书项下数据信息及相关信息的知识产权。乙方授权甲方在其内部业务系统中使用乙方数据信息。未经乙方书面同意，甲方不得改变数据信息的使用用途。 )}}
    {{term(甲方及其员工如需在书面报告中引用数据信息，应注明内容“本资讯数据仅供参考，使用该数据的风险自负”。)}}
    {{term(任何未经双方同意试图链接乙方所提供数据信息的行为，不论这种行为是否有偿，均属于数据侵权行为。双方均有义务打击该盗用行为，相互通报所发生的数据盗用现象，交换所掌握的盗用证据，共同或者协助对方追究盗用方的法律责任。)}}
    {{term(甲方使用该数据后形成的后续产品，知识产权均属于甲方。)}}

    {{part(保密)}}
    {{term(双方同意采用至少与其对于自身专有资料相同的谨慎与防范措施，对本合同书（含附件）或因履行本合同涉及的任何商业秘密或专有信息予以保密。未经对方书面许可，不得复制、向他人透露或者使用该等资料或数据。)}}
    {{term(双方在此前签署的保密合同或者承诺以及本合同书第五章下的保密义务在本合同书终止或届满后三年中继续有效。双方应保证其雇员、代理人或其他依其指示而作某种行为的人履行该义务。 )}}

    {{part(违约责任)}}
    {{term(非因甲方过错或不可抗力，乙方如不能按本合同规定的期限提供服务的，应向甲方支付滞期费：从规定的提供服务之日起，每延期一天，向甲方偿付本合同总金额的0.2％。乙方偿付上述滞期费并不免除乙方提供服务的责任。)}} 
    {{term(甲方未按照本合同规定的时间付款的即为违约，甲方应自款项的最迟应付日的次日起，每拖欠一日，向乙方偿付合同总额0.2％的延期付款补偿金。如果甲方逾期两周内仍不付款的，乙方有权单方面终止本合同书。)}}
    {{term(甲方违反本合同书义务直接或间接侵害乙方权利的，乙方有权立即终止对甲方的服务，并有权要求甲方赔偿乙方经济损失及追究甲方法律责任。)}}
    {{term(任何一方违反保密义务造成对方损失的，应当依法赔偿对方损失。)}}

    {{part(不可抗力)}}
    {{term(任何一方因遭受国家法律规定的不可抗力事件而不能正确和全面履行本合同义务的，可以免除违约责任，但应当在遭受不可抗力后10个工作日内向对方提供政府部门证明。)}}

    {{part(其他)}}
    {{term(本合同的合作没有排他性，双方均可以与其他合作伙伴进行合作，但是不能违反本合同书或者损害对方权益。)}}
    {{term(双方确认本合同书记载的各方办公地址，均为有效联系地址，任何一方按照该地址给对方发送的函件，以有效发送记录视同已经送达。)}}
    {{term(双方在履行本合同书过程中出现争议的，应当协商解决。协商不成的，任何一方可向被告住所地人民法院提起诉讼，本合同适用中华人民共和国法律。)}}
    {{term(双方确认的附件、补充合同、备忘录等均是本合同书的有效组成部分，与本合同书具有同等法律效力，如果相互之间内容不一致的，以时间在后的为准。)}}
    {{term(本合同书用中文书写，一式贰份，内容一致，甲、乙双方各执一份。合同经双方授权代表签字或加盖各自公章或合同专用章后生效。)}}

    {{part(合同附件)}}
    附件1. 所有明星采集数据列表
    附件2. 明星数据交付数据格式规格说明

    {{article_end(部分：)}}


h2. Exposed Macros

* css_url()
* js_url()
* html()
* css()
* js()
* babel()
* import_react()
* import_antd()

h1. Examples

h2. Testing Plain HTML()

Below is a test for only the html(), js(), css(), css_url() and js_url() macros.

h2. HTML with line breaks

{{html
<ul>
   <li>option 1</li>
   <li>option 2</li>
   <li>option 3</li>
</ul>
}}

h2. HTML as oneliner

{{html(<ul><li>option 1</li><li>option 2</li><li>option 3</li></ul>)}}

h2. Raw js() macro

Inserting javascript to alert a message: <pre>alert('js() is working');</pre>

{{js
alert("js() is working");
}}

h2. Raw css() macro

Inserting RAW CSS to turn LI blue when in a UL of class rawcss
{{css
.rawcss li{ color:blue; }
}}
{{html(<ul class="rawcss"><li>option 1</li><li>option 2</li><li>option 3</li></ul>)}}

h2. Insert external JS and CSS files

Trying: 
- https://rawgithub.com/twbs/bootstrap/master/dist/css/bootstrap.min.css
- https://rawgithub.com/twbs/bootstrap/master/dist/js/bootstrap.min.js

Check the live DOM for these files at the bottom of the <code><head></code> section.

{{css_url('https://rawgithub.com/twbs/bootstrap/master/dist/css/bootstrap.min.css')}}
{{js_url('https://rawgithub.com/twbs/bootstrap/master/dist/js/bootstrap.min.js')}}


<pre><code>{{html
<ul>
   <li>option 1</li>
   <li>option 2</li>
   <li>option 3</li>
</ul>
}}</code></pre>

You can also use <code>css()</code> macro to embedd raw CSS into the middle of a wiki page.

<pre><code>{{css
.fooClass{
  color:red;
  padding:15px;
}
#barID{
  margin-left:15px;
}
}}</code></pre>

Include external static assets to your wiki page

<pre><code>{{css_url('https://rawgithub.com/twbs/bootstrap/master/dist/css/bootstrap.min.css')}}
{{js_url('https://rawgithub.com/twbs/bootstrap/master/dist/js/bootstrap.min.js')}}
</code></pre>




Useing React & Antd in wiki

<pre><code>
{{html
<div id="example"></div>
}}

{{import_react}}
{{import_antd}}

{{babel

const columns = [{
  title: 'Name',
  dataIndex: 'name',
  key: 'name',
  render: text => <a href="#">{text}</a>,
}, {
  title: 'Age',
  dataIndex: 'age',
  key: 'age',
}, {
  title: 'Address',
  dataIndex: 'address',
  key: 'address',
}, {
  title: 'Action',
  key: 'action',
  render: (text, record) => (
    <span>
      <a href="#">Action 一 {record.name}</a>
      <span className="ant-divider" />
      <a href="#">Delete</a>
      <span className="ant-divider" />
      <a href="#" className="ant-dropdown-link">
        More actions <antd.Icon type="down" />
      </a>
    </span>
  ),
}];

const data = [{
  key: '1',
  name: 'John Brown',
  age: 32,
  address: 'New York No. 1 Lake Park',
}, {
  key: '2',
  name: 'Jim Green',
  age: 42,
  address: 'London No. 1 Lake Park',
}, {
  key: '3',
  name: 'Joe Black',
  age: 32,
  address: 'Sidney No. 1 Lake Park',
}];

for(var i=4;i<100;i++){
  data.push({
  key: i,
  name: 'Joe Black',
  age: 32,
  address: 'Sidney No. 1 Lake Park',
  });
}


ReactDOM.render(
   <div>

   <div>
    <antd.Button type="primary" shape="circle" icon="search" />
    <antd.Button type="primary" icon="search">Search</antd.Button>
    <antd.Button shape="circle" icon="search" />
    <antd.Button icon="search">Search</antd.Button>
    <br />
    <antd.Button type="ghost" shape="circle" icon="search" />
    <antd.Button type="ghost" icon="search">Search</antd.Button>
    <antd.Button type="dashed" shape="circle" icon="search" />
    <antd.Button type="dashed" icon="search">Search</antd.Button>
   </div>

   <br />
   <antd.DatePicker />
   
   <br />
   <antd.Table dataSource={data} columns={columns} />

   </div>,
   document.getElementById('example')
);
}}</code></pre>


h1. Installation

Navigate to:
@[redmine_install_path]/plugins@

Clone this repo:
@git clone git://github.com/bryt-li/bryt_wiki_extenstion

Restart Redmine (example below is using bitnami stack): 
@sudo /etc/init.d/bitnami restart@

h1. License: "arlo.mit-license.org":http://arlo.mit-license.org
 
