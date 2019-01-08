# ubuntu 脱坑 & 日常

## 系统安装

- win10 下空出分区，以便 ubuntu 安装
- 设置 BIOS 为 U 盘自启动
- 18.04 下，选择英文安装，与 win10 共存（分区意义不大）
  [英文安装下设置中文](https://blog.csdn.net/qq_19339041/article/details/80058575),好处是使用英文路径
- 等到中文设置完成后，安装搜狗输入法.
  [中文乱码解决](https://blog.csdn.net/s_lisheng/article/details/79620131),需要重启，并在输入法配置里`Fcitx Config`将搜狗拼音移动到第一项

## 常用命令&软件

### 系统

- `sudo` 命令，权限高 (**_Super user do_**)
- `ls` 当前目录下所有文件夹
  - `ls -l & ls -a` (**_详细文件信息和全部文件信息包括隐藏_**)
- `cd & rm & mkdir & cp` (**_进入目录 删除文件-f 表示强制 创建目录 复制文件_**)
- `find` (**_查找文件， /表示查找的起始目录_**)
- `tar & dpkg` (**_tar -zxvf 解压文件名 -C 要复制到的文件目录 & dpkg -i .deb 文件 一般用于安装 _**)
- `apt` 命令， 安装包管理工具，apt-get 的缩写(**_Advanced Packaging Tool_**),
  - `apt update`(**_更新软件源中的所有软件列表_**)
  - `apt install`(**_安装指定软件_**) `install -f` 强制安装 ; `install -y` 忽略缺失
  - `apt remove`(卸载指定软件)
- `curl` 命令， 网络工具，[基本用法](https://www.cnblogs.com/linjiqin/p/5484910.html)
- `npm`
- `ip addr`
- `source /etc/bashrc`

### 软件

- **[蓝灯](https://github.com/getlantern/lantern)**
- **[chrome](https://www.google.com/intl/zh-CN_ALL/chrome/)**
- **[vscode](https://code.visualstudio.com/)**
- **[shutter](http://shutter-project.org/downloads/)**
- **vim**
- **git**
- **[node&npm](https://github.com/creationix/nvm#installation)**
- **印象笔记插件（网页版）**

## 环境

- `/opt`目录： **_可选的程序_**
- `/etc`目录： **_各种系统配置文件_**
  - `/etc/profile` ：**为系统的每个用户设置环境信息,当用户第一次登录时,该文件被执行**
  - [配置设置](https://my.oschina.net/qinlinwang/blog/30471)
  - [更多设置](https://blog.csdn.net/White_Idiot/article/details/78253004)
- [各个目录功能介绍](https://www.cnblogs.com/yudar/p/5809219.html)

## 注意提示

- github 密码修改后，更新 ssh 秘钥并在网页更新(不行用邮箱名登录 F\*\*\*)
  [设置](https://blog.csdn.net/hd_feng/article/details/78353146),[修改](https://git-scm.com/book/zh/v1/%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%B8%8A%E7%9A%84-Git-%E7%94%9F%E6%88%90-SSH-%E5%85%AC%E9%92%A5)
- > git pull 拉取线上代码
  > git stash 存栈
  > git add 添加代码
  > git stash pop 出栈
  > git branch 查看分支
  > git commit -m "本次备注"
  > git checkout 切换分支
  > vim .gitignore 查看/设置不提交文件夹
  > 先拉取线上代码,判断是否存在冲突,有则存栈,然后在拉取代码,然后出栈.
  > 通过 git status 查看仓库的状态
  > 确认提交分支正确,然后备注本次修改内容,然后提交(push)

- 启动 java 时注意端口有无被占用,[查看进程](https://blog.csdn.net/hongweideng/article/details/78424866)
- ESlint 语法规则问题，[官网](https://eslint.org/)大多有解释,补充：
  > ESLint Parsing error: Unexpected token 问题
  > 无`babel-eslint` 包 ，[详情](https://stackoverflow.com/questions/36001552/eslint-parsing-error-unexpected-token)
- vsCode Debug Meteor 问题
  - 安装插件
  - [配置 lanuch.json](https://forums.meteor.com/t/meteor-1-6-server-debugging-with-vs-code/39821)
  - 尝试更新 Meteor 包到`18.1`或最新版本
- `markdown-preview-enhanced` 可以修改预览样式和生成样式

  - 预览：`ctrl+shift+p`命令打开`Markdown Preview Enhanced: Customize Css`
  - 生成：
    > ~/.vscode/extensions/shd101wyy.markdown-preview-enhanced-0.3.5/node_modules/@shd101wyy/mume/styles/preview_theme/github-light.css
    > 修改完成后刷新

- `f.lux 安装` [下载](http://blog.topspeedsnail.com/archives/4691),注意 PPA 格式
- `属性访问注意` 当属性名是循环或是获取时,多为字符串类型,用 **`.`** 访问为`undefined`. 使用`[]`[访问](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Property_Accessors),可以取到

  ```js
  if (typeof content[key] == "string" && content[key].includes("其他")) {
    content[key] = content[key].split(",");
    self.setState({ [key]: true });
  }
  ```

- 一个`getFieldDecorator`下注册多个`child`,两种形式,

  - [封装组件形式](https://github.com/ant-design/ant-design/issues/3864),在设置值时,没试过,可以借鉴
  - 控制 state 形式(选中||未选中场景):
    ```js
      <FormItem {...checkbox} label="具体风险描述">
                {getFieldDecorator("descriptionInForceMajeure", {
                  rules: [
                    {
                      required: false,
                      message: "请选择/填写描述"
                    }
                  ]
                })(
                  <CheckboxGroup
                    style={{ paddingLeft: "1rem" }}
                    options={checkboxOptions1}
                    onChange={this.checkboxChang1}
                  />
                )}
                { this.state.descriptionInForceMajeure ? getFieldDecorator("descriptionInForceMajeureInput", {
                  rules: [
                    {
                      required: true,
                      message: "请选择/填写描述"
                    }
                  ]
                })(<Input />):null}
              </FormItem>
              <FormItem {...checkbox} label="风险规避措施">...
    ```
    注意,在 `setFieldsValue()`里要对应每个注册表名 `name` 相同 ,在不同周期,注意`setState`,注意`setFieldsValue` 本质是调用外层`wrapper` 的 `setState`

- antd 里 `Modal`组件下,默认`zIndex`属性为 1000,不设置的话,默认关闭是打开顺序.
  在里面嵌套组件时,需要特别注意(大坑!!!)

  ```js
  //options设置!!
  const ModalOpits2 = {
    title: "Schedule details",
    footer: null,
    centered: true,
    width: "30rem",
    // zIndex: 11111,
    visible: this.state.detvisible,
    onCancel: this.setDetailOff,
    mask: false,
    destroyOnClose: true
  };
  //嵌套
  <Modal {...ModalOpits2}>
    <Form onSubmit={this.handleSubmit}>
      <FormItem {...formItemLayout} label="Where Dates ?">
        <span className="ant-form-text">{this.state.showNums}</span>
      </FormItem>
      <FormItem label="SelectBadgeType" {...formItemLayout}>
        {getFieldDecorator("badgeType", {
          initialValue: "success",
          rules: [{ required: false, message: "请选择日程类型" }]
        })(
          <Select
            // disabled={this.state.showText}
            onChange={this.handleSelectChange}
          >
            {options}
          </Select>
        )}
      </FormItem>
      <FormItem label="Schedule details" {...formItemLayout}>
        {getFieldDecorator("Details", {
          initialValue: this.state.nowtextcont,
          rules: [{ required: true, message: "请填写详情内容" }]
        })(
          <TextArea
            disabled={this.state.showText}
            autosize={{ minRows: 2, maxRows: 6 }}
          />
        )}
      </FormItem>
      <FormItem wrapperCol={{ span: 12, offset: 8 }}>
        <Button type="primary" htmlType="submit">
          Submit
        </Button>
      </FormItem>
    </Form>
  </Modal>;
  ```

## 构造函数&原型对象

> 原型是一个对象，任何一个对象都可以成为原型，并让其他对象继承

### constructor **_属性_**

属性始终指向创建当前对象的构造函数

```js
var arr = [1, 2, 3];
console.log(arr.constructor); //输出 function Array(){}
var a = {};
console.log(arr.constructor); //输出 function Object(){}
var bool = false;
console.log(bool.constructor); //输出 function Boolean(){}
var name = "hello";
console.log(name.constructor); //输出 function String(){}
var sayName = function() {};
console.log(sayName.constrctor); // 输出 function Function(){}

//接下来通过构造函数创建instance
function A() {}
var a = new A();
console.log(a.constructor); //输出 function A(){}
```

### prototype **_属性_**

prototype 属性是每个`函数对象`(**`function`**) 都有的属性，被称为**原型对象**，`_proto_` 属性是每个对象都有的属性，是指向该原型对象的内部指针.

prototype 属性指向被 构造函数 创建的 函数(**`function`**) 的原型对象

一旦原型对象被赋予了属性和方法，那么相应的构造函数创建的实例也会继承`prototype`上的属性和方法

### ES6 class

- 类(`Class`)的内部所有定义的方法，都是不可枚举的（但是在 es5 中 prototype 的方法是可以进行枚举的）
- 类(`Class`)的构造函数，不使用 new 是没法调用的，除了静态方法
- 类(`Class`)不存在变量提升（hoist）
- ES5 的继承，实质是先创造子类的实例对象`this`，然后再将父类的方法添加到`this`上面`Parent.apply(this)`.ES6 的继承机制完全不同，实质是先创造父类的实例对象`this`（所以必须先调用 **`super`** 方法），然后再用子类的构造函数修改`this`

  ```js
  class Point {
    constructor(x, y) {
      this.x = x;
      this.y = y;
    }
    toString() {
      returu`(${this.x},${this.y})`;
    }
  }
  ```

- 类的所有方法都定义在类的 prototype 属性上，在类的实例上调用方法，就是调用原型上的方法

## Meteor

### RocketChat [API](https://rocket.chat/docs/developer-guides/rest-api/)

一个开源、开放、功能强大、基于 Meteor 和 MongoDB 的 Slack 替代软件....(~~聊天的~~)
在初始安装包时(`npm i`),可以尝试`meteor npm i` 命令安装

### 目录结构

- `/client` 文件夹中所有文件都只发送到客户端.用来放置 HTML，CSS 和 UI 相关的 javascript 代码
- `/server` 文件夹中所有文件都只提供给服务端使用，不会发送到客户端.用来放置不应该被客户端看到的敏感逻辑和数据
- `/public` 文件夹中的文件会原样发送到客户端.用来放置资源

### [meteor 路由](http://www.sitexa.net/post/meteor-url-route/)

- `triggers()` 路由触发时,最先调用这个方法,然后是`subscriptions`,最后是`action()`
- `action()`路由匹配时触发,[详情](https://guide.meteor.com/routing.html#rendering-routes)

  ```js
  FlowRouter.route("/lists/:_id", {
    name: "Lists.show",
    action() {
      BlazeLayout.render("App_body", { main: "Lists_show_page" });
    }
  });
  //访问“/lists/:_id(自定义)下，“App_body”组件下main属性
  ```

- `FlowRouter.subsReady()` 订阅管理,可以使用 FlowRouter.subsReady 在 template helpers 内部显示加载状态和相应的行为

  ```js
  Template.myTemplate.events({
    "click #id": function() {
      FlowRouter.subsReady("myPost", function() {
        // do something
      });
    }
  });
  ```

### [meteor 模板](https://segmentfault.com/a/1190000003781596),[解释](https://segmentfault.com/a/1190000003781596)

- `Template.组件名.helpers` 给模板变量赋值,定义模板的 helpers
- `{{title}}` 嵌入数据 ,调用属性或者方法
- `{{#each data}}...{{/each}} {{#if data}}...{{/if}}` 控制结构
- `Template.registerHelper` 定义所有模板都能用的 helper

  ```js
  Template.registerHelper("log", () => {
    console.log.apply(console, arguments);
  });
  Template.registerHelper("not", value => {
    return !value;
  });
  Template.registerHelper("hasPermission", function(permission, scope) {
    return hasPermission(permission, scope, atLeastOne);
  });
  ```

- `unless/else模板标签` [模板逻辑控制,条件](http://www.hangge.com/blog/cache/detail_1340.html)；判断数据是不是 `false`（或者是 `"undefined"` 或 `"null"` 或`""` 或`"0"`. 是 `false` 的话则走 `{{#unless}}`，否则走 `{{else}}` 分支

  ```js
    //数据
    {
      name: 'John Doe',
      hobby: false
     }
    //样例
    <p>Hello, my name is {{name}}.</p>
    {{#unless hobby}}
    <p>I have hobby</p>
    {{else}}
    <p>I don't have hobby'</p>
    {{/unless}}
    //输出
    <p>Hello, my name is John Doe.</p>
    <p>I have hobby</p>
  ```

- `{{> demo}}` 导入指定的模板

  ```js
    //admin
    <body>
      <h1>Hello!</h1>
      {{> xiongdihui}}
    </body>
    //zi
    <template name="xiongdihui">
      <p>Welcome to 兄弟会!</p>
    </template>
  ```

- `Template.myTemplate.events(eventMap)` 模板事件.传给`Template.myTemplate.events`的事件`map`,用事件描述符作为`key`,事件处理函数作为`value`.事件处理函数接收两个参数：`事件对象和模板实例`

  ```js
  //例子
  Template._autocompleteContainer.events({
    "click .-autocomplete-item, click [data-autocomplete]"(e, t) {
      t.data.onItemClick(this, e);
    },
    "mouseenter .-autocomplete-item"(e, t) {
      t.data.onItemHover(this, e);
    }
  });
  //key前半部分是事件名称,后半部分是css选择器
  //无论何时，选定元素上触发了监听的事件时，对应的事件处理函数就会被调用
  //参数为：DOM事件对象(Events)和模板实例(Template)
  ```

- `Template.registerHelper()` (原版调用为: Blaze.registerHelper()) ,用于注册全局 [helpers](http://blazejs.org/guide/reusing-code.html#Global-Helpers)

  ```js
  Blaze.registerHelper("pathFor", function(path, kw) {
    return FlowRouter.path(path, kw.hash);
  });
  ```

- `Template instances` 获取模板实例,还可给模板实例附加属性,属性在模板响应式更新中保持,不会丢失
  - 在 created, rendered 和 destroyed 模板回调中，`this`指向模板实例
  - 事件处理器的第二个参数
  - 在 Helper 中,通过`Template.instance()` 获取
    ```js
    Template.appInstall.helpers({
      isInstalling() {
        return Template.instance().isInstalling.get();
      },
      appUrl() {
        return Template.instance().appUrl.get();
      }
    });
    ```
- `Template.myTemplate.onCreated()` 模板初始时调用方法,设定初始值,参数是要执行的方法

  ```js
  Template.readReceipts.onCreated(function readReceiptsOnCreated() {
    this.loading = new ReactiveVar(false);
    this.readReceipts = new ReactiveVar([]);
  });
  //初始化值
  Template.hello.onCreated(function() {
    console.log("产生模板..");
    this.timer = null;
    this.number = 0;
  });
  ```

- `Template.myTemplate.onRendered` 模板被插入 DOM 时调用的方法,相似于`ReactDOM.render()`

  ```js
  Template.readReceipts.onRendered(function readReceiptsOnRendered() {
    this.loading.set(true);
    Meteor.call(
      "getReadReceipts",
      {
        messageId: this.data.messageId
      },
      (error, result) => {
        if (!error) {
          this.readReceipts.set(result);
        }
        this.loading.set(false);
      }
    );
  });
  ```

  当前阶段可操作 DOM 元素,可以通过`find()`查找,参数是`css选择器`查找,或者`findall()`查询所有符合的元素,或使用`$()` 注意 JQ 选择下对象是 JQdom 对象,只能在此过程调用

- `Template.myTemplate.onDestroyed()` 模板被销毁时调用

  ```js
  Template.hello.onDestroyed(function() {
    console.log("摧毀模板..");
    // 清除 timer
    clearInterval(this.timer);
  });
  //OR 执行一些操作
  Template.rc_modal.onDestroyed(function() {
    document.removeEventListener("keydown", modal.onKeydown);
  });
  Template.popover.onDestroyed(function() {
    if (this.data.onDestroyed) {
      this.data.onDestroyed();
    }
    $(window).off("resize", this.position);
  });
  ```

- [函数反应式编程](http://cw.hubwiz.com/card/c/55b87a7b3ad79a1b05dcc339/1/3/2/) `ReactiveVar` 类创建反应式数据(变量),触发变量既有响应式结果

  - 创建 `new ReactiveVar(初始值 ('字符串';10) )`
  - `set() get()` 获取或设置值

    ```js
    const number = this.number.get();
    this.number.set(number + 1);
    ```

  - 多数用在模板的

    ```js
    Template.appLogs.onCreated(function() {
      const instance = this;
      this.id = new ReactiveVar(FlowRouter.getParam("appId"));
      this.ready = new ReactiveVar(false);
      this.hasError = new ReactiveVar(false);
      this.theError = new ReactiveVar("");
      this.app = new ReactiveVar({});
      this.logs = new ReactiveVar([]);

      const id = this.id.get();
      Promise.all([
        RocketChat.API.get(`apps/${id}`),
        RocketChat.API.get(`apps/${id}/logs`)
      ])
        .then(results => {
          instance.app.set(results[0].app);
          instance.logs.set(results[1].logs);

          this.ready.set(true);
        })
        .catch(e => {
          instance.hasError.set(true);
          instance.theError.set(e.message);
        });
    });
    ```

- [Blaze API](http://blazejs.org/api/blaze.html)
  Blaze 是 Meteor 預設的前端框架,整合了 Meteor 的 Tracker 和 Minimongo，能夠隨著資料變動而自動更新使用者畫面，因此開發者不需要決定什麼時候去更新網頁元素，也不需要做 data-binding,常用:
  - `Blaze.render（templateOrView，parentNode，[nextNode]，[parentView]）`
    将模板渲染到指定节点 ,`templateOrView` 为模板或 view 对象, `parentNode` 为呈现模板的父节点,必须是 Element 节点
  - `Blaze.renderWithData（templateOrView，data，parentNode，[nextNode]，[parentView]）`
    将数据和模板绑定,插入到节点. `data`为数据,若无此参数,和`render`基本相同
  - `Blaze.remove（renderedView）` 从 DOM 中删除节点,然后停止跟踪和更新节点
    ```js
    var myData3 = Blaze.render(myData, myData2);
    // 3s后删除数据
    Meteor.setTimeout(() => {
      Blaze.remove(myData3);
    }, 3000);
    //OR
    Blaze.remove(Blaze.getView(document.getElementsByClassName("Test")[0]));
    ```
  - `Blaze.getData（[elementOrView]）` 返回当前数据,`elementOrView` 为渲染的元素
  - `Blaze.toHTMLWithData（templateOrView，data）` 将模板渲染成 HTML,`templateOrView` 为用于生成 HTML 的模板,`data`为关联数据

### [Collection 数据集合](https://wizardforcel.gitbooks.io/meteor-doc/content/12.html)

Meteor 用集合保存数据.集合里保存的 Javascript 对象叫做文档.使用`new Mongo.Collection`声明一个集合,[Mongo 运算符详情](https://docs.mongodb.com/manual/reference/operator/query/)

```js
  //创建
  var msgs = new Mongo.Collection("messages");
  //CRUD
  msgs.insert(...);
  msgs.update(...);
  msgs.remove(...);
  msgs.find(...);
```

默认情况下,前端后端的同名数据集自动保持同步,在前端插入的数据，会通过 Meteor 的 RPC 机制插入到后端数据集，而后端数据的变化， 将通过 pub/sub 机制自动传播到前端,[例子](http://cw.hubwiz.com/card/c/55b87a7b3ad79a1b05dcc339/1/5/1/#-collection)

```js
//前后端创建同名Collection对象
var msgs = new Mongo.Collection("messages");
if (Meteor.isServer) {
  //后端发布
  Meteor.publish("ezpub", function() {
    return msgs.find();
  });
}
if (Meteor.isClient) {
  //前端订阅
  Meteor.subscribe("ezpub");
}
```

- 每个`Mongo.Collection`里的每个文档都有一个`_id`字段.它必须是唯一的，如果你没有提供，会自动生成,
  `collection.findOne`使用`_id`可以用来检索特定的文档

- `insert(doc,[callback])` 集合对象的`insert()` 方法,向集合插入一天数据(`JSON对象`).`doc`指作为数据的对象,`callback()` 指插入数据完成之后的回调

  ```js
    const Todos = new Mongo.Collection();
    ...
    Template.hello.events({
      'keyup #myInput'(event, templateInstance) {
        if (event.keyCode === 13) {
          Todos.insert({
            text: event.currentTarget.value,
            date: new Date(),
          });
          event.currentTarget.value = '';
        }
      }
    });
  ```

- `find([selector],[options])` 查找集合中满足指定条件的文档 . `selector` 指定文档选择符,如果为`{}`,则查询集合下的所有. `options` 指筛选条件,JOSN 格式: 返回数目,排序顺序... , [详情](https://wizardforcel.gitbooks.io/meteor-doc/content/12.html#options)

  ```js
  var demo = new Mongo.Collection("persons");
  //对返回结果按 age 字段排序
  var cursor = demo.find({}, { sort: { age: 1 } });
  //跳过指定数量文档:年龄大于20,并跳过100个文档返回剩余的
  var cursor = demo.find({ age: { $gt: 20 } }, { skip: 100 });
  //限定返回文档数量,分页:年龄大于20,并返回最多10个文档
  var cursor = demo.find({ age: { $gt: 20 } }, { limit: 10 });
  //对所有返回结果限定:返回每个文档中的namge.tel字段
  var cursor = demo.find({}, { fields: { name: 1, tel: 1 } });
  ```

  `find()`查询出来的结果是一个`游标/Cursor`对象,只是记录数据库地址,查询条件,查询选项,没有物理的访问数据库,真正获取数据,需要使用游标对象方法

  - `Cursor.forEach(callback,[thisArg])`对游标匹配的文档集中的每一个文档执行 callback 参数指定的处理函数

    ```js
    demo.find({ name: "Jason" }).forEach(function(doc) {
      console.log(doc.tel);
    });
    ```

  - `Cursor.map(callback,[thisArg])` 匹配每一个文档对象,通过 callback 参数指定的 映射函数 返回一个新值
    ```js
    var tels = demo.find({ name: "Jason" }).map(function(doc) {
      return doc.tel;
    });
    ```
  - `Cursor.fetch()` 提取游标匹配的所有文档,返回这些文档组成的数组
    ```js
    var demo = new Mongo.Collection("persons");
    var persons = demo.find().fetch();
    ```
  - `Cursor.count()` 返回游标匹配的文档数量

  <br>

- `update(selector, modifier, [options], [callback])` 更新集合中指定文档.
  `selector` 指文档选择符,文档\_id 或者是合法的 MongoDB 选择器.`modifier` 指文档修改指令对象,根据这个指令修改匹配的数据.`options` 可选,JSON 对象,`callback` 完成之后的回调,在后端调用该方法时，如果不指定`callback`参数，将阻塞执行直至更新完成，或者在发生 错误时抛出异常；前端不支持同步阻塞方式的执行，因此如果不设置`callback`参数，将 无法捕捉错误和执行结果

  ```js
    var demp = new Mongo.Collection("persons");
    //options 参数:multi 为true时更新匹配选择条件的所有文档:修改所有name为jason的分值为100
    demo.update({name:"Jason"},{$set:{score:100},{multi:true}})
    //options 参数:upsert 若果为true,在无法找到匹配文档时,执行插入操作:修改name为jason的第一条数据,如果找不到,插入name,tel数据
    demo.update({name:"Jason"},{name:"Jason",tel:"114"},{upsert:true});
  ```

  `update()`方法的行为取决于是在受信代码中被调用，还是在非受信代码中被调用.服务端 代码被认为是受信代码，而浏览器中运行的客户端代码被认为是非受信代码.

  在受信代码中，可以设置`options`参数的`multi`属性来一次更新多个文档，然而在非受信 代码中，只可以是使用文档的`_id`作为选择符，一次更新一个文档，而且还必须通过应用层 设置的`allow`和`deny`规则检查.此外，非受信代码中调用的`update()`方法，也不能执行通过 设置`options`参数的`upsert`属性来执行无匹配时的插入操作 —— 除非在应用中添加了`insecure`包(`meteor add insecure`)

- `remove(selector,[callback])` 删除指定文档.`selector` 指文档选择符,为文档 ID 或合法的 MongoDB 选择符,`callback()` 更新完后的回调

  ```js
  var demo = new Mongo.Collection("persons");
  demo.remove({ name: "Jason" });
  ```

  `remove()`方法的行为取决于是在受信代码中被调用，还是在非受信代码中被调用。`服务端`代码被认为是受信代码，而浏览器中运行的`客户端`代码被认为是非受信代码。

  在受信代码中，可以使用`任意MongoDB的选择符`实现一次删除`多个`文档，然而在非受信代码中，只能使用文档的`_id`作为选择符，一次删除`一个`文档，而且还必须通过应用层 设置的`allow`和`deny`规则检查。

- [Meteor.wrapAsync(func, [context])](https://docs.meteor.com/api/core.html#Meteor-wrapAsync) : 在服务端执行,将异步函数封装成同步函数.封装后的函数在服务端既可以作为异步函数(传入回调函数)也可以作为同步函数使用(不传入回调函数). 在客户端(浏览器端)还是需要传入回调函数作为异步函数使用,注意在异步函数中需要有回调函数,否则会堵塞,[详情](https://www.cnblogs.com/meteorcn/p/MeteorJS_Async_Fiber_Future_Wrap.html)

### [Methods RPC 协议实现方法](http://cw.hubwiz.com/card/c/55b87a7b3ad79a1b05dcc339/1/2/2/)

**Methods**是客户端调用服务端的方法

`Meteor.methods(methods)` 定义方法操作数据库,避免客户端直接呼叫`insert`,`update`, `remove`等方法,用`Meteor.call(name,[arg1,arg2],[asyncCallback])` 方法调用,[参数详情](https://docs.meteor.com/api/methods.html#Meteor-call).

```js
  //server side
  Meteor.methods({
    'calcSalary':function(name){
      //喜欢的三个员工给多点
      if(name==='Mary') return 100000.00；
      if(name==='Linda') return 50000.00;
      if(name==='Tommy') return 78000.00;
      //其他员工都给一样的薪酬
      return 15000.00;
    }
  });
  //client side
  //异步调用，调用结果或错误将被传入回调函数
  Meteor.call("calcSalary","Mary",function(error,result){
    $("body").html("result is " + result);
  });
```

### [Meteor Package](https://docs.meteor.com/api/packagejs.html)

`Package`是一个包含`package.js`文件的目录，该文件大致包含三个主要部分：基本描述，包定义和测试定义。默认情况下，目录名称是包的名称

```js
// Information about this package:
Package.describe({
  // Short two-sentence summary
  summary: "What this does",
  // Version number
  version: "1.0.0",
  // Optional, default is package directory name
  name: "username:package-name",
  // Optional GitHub URL to your source repository
  git: "https://github.com/something/something.git"
});

// This defines your actual package:
Package.onUse(api => {
  // If no version is specified for an `api.use` dependency, use the one defined
  // in Meteor 1.4.3.1.
  api.versionsFrom("1.4.3.1");
  // Use the `underscore` package, but only on the server. Version not
  // specified, so it will be as of Meteor 1.4.3.1.
  api.use("underscore", "server");
  // Use `kadira:flow-router`, version 2.12.1 or newer.
  api.use("kadira:flow-router@2.12.1");
  // Give users of this package access to active-route's JavaScript helpers.
  api.imply("zimme:active-route@2.3.2");
  // Export the object `Email` to packages or apps that use this package.
  api.export("Email", "server");
  // Specify the source code for the package.
  api.addFiles("email.js", "server");
  // When using `ecmascript` or `modules` packages, you can use this instead of
  // `api.export` and `api.addFiles`.
  api.mainModule("email.js", "server");
});

// This defines the tests for the package:
Package.onTest(api => {
  // Sets up a dependency on this package.
  api.use("username:package-name");
  // Use the Mocha test framework.
  api.use("practicalmeteor:mocha@2.4.5_2");
  // Specify the source code for the package tests.
  api.addFiles("email_tests.js", "server");
});

// This lets you use npm packages in your package:
Npm.depends({
  simplesmtp: "0.3.10",
  "stream-buffers": "0.2.5"
});
```

`Package.onUse（FUNC）` 定义包依赖关系,和公开包的方法

- `api.use（packageNames，[architecture]，[options]）`
  **packageName** 指包依赖于,可指定版本号,例:`'accounts@1.0.0'`
  **architecture** 指定包在什么体系结构使用,`server` or `client`
- `api.export（exportedObjects，[architecture]，[exportOptions]，exportOptions.testOnly）`
  导出包中的变量
- `api.addFiles(filenames, [architecture], [options])`
  指定包的源文件. **filenames** 指源文件路径,**architecture** 指定运行在哪个体系结构

## Nginx & certbot & Jitsi Meet

### [HTTP 和反向代理服务器](http://www.runoob.com/linux/nginx-install-setup.html)

- [安装](https://www.cnblogs.com/languoliang/archive/2013/04/01/nginx.html)
  > sudo apt install nginx
  > 启动 sudo service nginx restart
  > worker_processes: 每个 worker 进程的最大连接数
- 注意: 如果报错,检查`/etc/nginx/sites-available` 目录下的配置文件,或运行`nginx -t` 检查配置文件语法,根据内容提示行检查

```config
  # Default server configuration
  #
  #
  upstream backend {
          server 127.0.0.1:3000;
  }

  server {
    listen 80;
    listen [::]:80;

    # SSL configuration
    #
    # listen 443 ssl default_server;
    # listen [::]:443 ssl default_server;
    #
    # Note: You should disable gzip for SSL traffic.
    # See: https://bugs.debian.org/773332
    #
    # Read up on ssl_ciphers to ensure a secure configuration.
    # See: https://bugs.debian.org/765782
    #
    # Self signed certs generated by the ssl-cert package
    # Don't use them in a production server!
    #
    # include snippets/snakeoil.conf;

    root /var/www/html;

    # Add index.php to the list if you are using PHP
    index index.html index.htm index.nginx-debian.html;

    server_name dling.org;

    location / {
      # First attempt to serve request as file, then
      # as directory, then fall back to displaying a 404.
      # try_files $uri $uri/ =404;
      proxy_pass http://192.168.10.206:3000/;
    }

    # pass PHP scripts to FastCGI server
    #
    #location ~ \.php$ {
    #	include snippets/fastcgi-php.conf;
    #
    #	# With php-fpm (or other unix sockets):
    #	fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
    #	# With php-cgi (or other tcp sockets):
    #	fastcgi_pass 127.0.0.1:9000;
    #}

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #	deny all;
    #}
  }


  # Virtual Host configuration for example.com
  #
  # You can move that to a different file under sites-available/ and symlink that
  # to sites-enabled/ to enable it.
  #
  #server {
  #	listen 80;
  #	listen [::]:80;
  #
  #	server_name example.com;
  #
  #	root /var/www/example.com;
  #	index index.html;
  #
  #	location / {
  #		try_files $uri $uri/ =404;
  #	}
  #}
```

### [SSL 简化申请流程](https://caloskao.org/ubuntu-use-certbot-to-automatically-update-lets-encrypt-certificate-authority/)

- [安装](https://certbot.eff.org/lets-encrypt/ubuntubionic-nginx) 按照命令安装.注意选择 OS 和软件,在设置`certbot --nginx`时需要域名和邮箱
- `sudo certbot renew --dry-run` 自动更新命令检测

### [Jitsi Meet 安装](https://github.com/jitsi/jitsi-meet/blob/master/doc/quick-install.md)

注意: 用`sudo su` 获取权限安装,设置域名问题,如果错误设置域名,运行一下[步骤](https://github.com/jitsi/jitsi-meet/issues/2663)

> 1 . apt-get --purge remove jitsi-meet jitsi-meet-prosody jitsi-meet-web jitsi-meet-web-config jicofo jitsi-videobridge
> 2 . apt-get autoclean
> 3 . apt-get --force-yes remove
> 4 . apt-get install --reinstall dpkg
> 5 . cd /var/lib/dpkg/info
> 6 . sudo rm jitsi-meet-web-config.postinst

## [Kubernetes](https://github.com/wh211212/awesome-kubernetes-cn) && [Docker](http://guide.daocloud.io/dcs/docker-9152673.html)

Kubernetes是一个开源系统，用于自动化集装箱化应用程序的部署，扩展和管理.
Docker 是一种容器技术，它可以将应用和环境等进行打包，形成一个独立的，类似于 iOS 的 APP 形式的「应用」，这个应用可以直接被分发到任意一个支持 Docker 的环境中，通过简单的命令即可启动运行。
Docker 是一种最流行的容器化实现方案。和虚拟化技术类似，它极大的方便了应用服务的部署；又与虚拟化技术不同，它以一种更轻量的方式实现了应用服务的打包。
使用 Docker 可以让每个应用彼此相互隔离，在同一台机器上同时运行多个应用，不过他们彼此之间共享同一个操作系统。Docker 的优势在于，它可以在更细的粒度上进行资源的管理，也比虚拟化技术更加节约资源。

### Kubernetes [中文文档](http://docs.kubernetes.org.cn/247.html) [模型文档](https://kubernetes.io/docs/reference/federation/v1/definitions/)

Kubernetes 集群包含一个 master 和多个 node;Master 是控制集群的中心，node 是提供 CPU、内存和存储资源的节点。Master 上运行着很多进程，包括面向用户的 API 服务、负责维护集群状态的 Controller Manager、负责调度任务的 Scheduler 等。每个 node 上运行着维护 node 状态并和 master 通信的 kubelet，以及实现集群网络服务的 kube-proxy

- `Service` [抽象定义](https://kubernetes.io/zh/docs/concepts/services-networking/service/),一个 Pod 的逻辑分组，一种可以访问它们的策略 —— 通常称为微服务。 这一组 Pod 能够被 Service 访问到，通常是通过 Label Selector（查看下面了解，为什么可能需要没有 selector 的 Service）实现的

### 安装示例注意

- `reboot` 重启,不要关机!!!
- 未找到命令,多半是没安装..yum安装一下
- 大坑!!!
  配置镜像时,选择一个配置方式
  1.12以上是,如果配置json文件无用,选择以下方式配置
  [修改docker.service](http://shouce.jb51.net/docker_practice/install/mirror.html),[修改docker.service2](https://www.jianshu.com/p/42772740f09a)
  如果同时配置了json和service文件,会启动错误,按照这个[配置](https://www.imooc.com/article/264027),然后重启一下docker

  ``` shell
    systemctl daemon-reload
    systemctl restart docker
  ```

- `docker代理` docker的代理是独立于centos的，需要单独[配置](https://docs.docker.com/config/daemon/systemd/#httphttps-proxy)
  **大坑!!!!!!!**---解决镜像源配置成功后,无法pull镜像或是登陆问题

  ```shell
    vim /etc/systemd/system/multi-user.target.wants/docker.service
    Environment="HTTP_PROXY=http://你的代理/" "HTTPS_PROXY=http://你的代理(或者是有端口的)/"
  ```

- `下载k8s所需镜像` 通过Docker下载提示的版本,[.sh下载](https://haojianxun.github.io/2018/10/14/%E4%BD%BF%E7%94%A8kubeadm%E4%BB%8E0%E5%BC%80%E5%A7%8B%E6%90%AD%E5%BB%BAkubernetesv1.11.1/),然后`init`初始化集群
  **注意**,初始化集群时,需要把提前拉下来的镜像改为`k8s.gcr.io/`开头,[方便识别](https://www.kubernetes.org.cn/3805.html#highlighter_534436)
  **特别注意,当初始化init提示你的所需下载名称,要与你用shell下载的镜像名称相同,一定要TM相同,比如提示没有-amdin64(后缀),就不要下载带后缀的,不识别!!!**

  ```shell
    #!/usr/bin/env bash

    docker pull coredns/coredns:1.2.6
    docker tag coredns/coredns:1.2.6 k8s.gcr.io/coredns:1.2.6
    docker rmi coredns/coredns:1.2.6

    images=(
        kube-proxy-amd64:v1.13.1
        kube-controller-manager-amd64:v1.13.1
        kube-apiserver-amd64:v1.13.1
        kube-scheduler-amd64:v1.13.1
        etcd-amd64:3.2.24
        pause-amd64:3.1
    )

    for imageName in ${images[@]} ; do
        docker pull mirrorgooglecontainers/$imageName
        docker tag mirrorgooglecontainers/$imageName k8s.gcr.io/$imageName
        docker push mirrorgooglecontainers/$imageName
    done

    #quay.io/coreos/flannel:v0.7.0-amd64
    #docker tag quay.io/coreos/flannel:v0.7.0-amd64 f6j1klbv.mirror.aliyuncs.com/flannel:v0.7.0-amd64
    #docker push f6j1klbv.mirror.aliyuncs.com/flannel:v0.7.0-amd64

  ```

- `docker rmi -f [options]` 强制删除镜像
- `kubeadm token create --print-join-command` 重新生成token
- 命令

  ```shell
    # 查看节点状态
    kubectl get nodes
    # 查看pods状态
    kubectl get pods --all-namespaces
    # 查看K8S集群状态
    kubectl get cs
  ```

## Redis

Redis 是非关系型数据库(NoSQL),使用内存存储,并能存储 5 种不同数据结构类型之间的映射，分别是`STRING(字符串)`、`LIST(列表)`、`SET(集合)`、`HASH(散列)`、`ZSET(有序集合)`

[分布式锁的目的](https://www.cnblogs.com/rjzheng/p/9310976.html),保证同一时间只有一个客户端可以对共享资源进行操作

### 安装(Ubuntu18.0.4)

> sudo spt install redis-server 直接安装
> redis-cli 测试,然后执行 PING 命令验证
> exit 执行退出

[在线运行 Redis 网站](http://try.redis.io/),尝试命令;[Redlock:node 下的分布式锁](http://ifeve.com/redis-lock/)

### 命令(String 类型)

- `SET key value [EX seconds] [PX milliseconds] [NX|XX]` 共有五个参数,`空格分割`.
  `EX second` 代表设置键的过期时间为 `second` 秒(???wtf)
  `PX millisecond` 代表设置键的过期时间为 `millisecond` 毫秒
  `NX` 只在键不存在时，才对键进行设置操作
  `XX` 只在键已经存在时，才对键进行设置操作

  ```js
    //PX 选项
    redis 127.0.0.1:6379> SET key-with-pexpire-time "moto" PX 123321
    OK

    redis 127.0.0.1:6379> GET key-with-pexpire-time
    "moto"

    redis 127.0.0.1:6379> PTTL key-with-pexpire-time
    (integer) 111939
    //NX 选项
    redis 127.0.0.1:6379> SET not-exists-key "value" NX
    OK      # 键不存在，设置成功

    redis 127.0.0.1:6379> GET not-exists-key
    "value"

    redis 127.0.0.1:6379> SET not-exists-key "new-value" NX
    (nil)   # 键已经存在，设置失败

    redis 127.0.0.1:6379> GEt not-exists-key
    "value" # 维持原值不变
    //XX 选项
    redis 127.0.0.1:6379> EXISTS exists-key
    (integer) 0

    redis 127.0.0.1:6379> SET exists-key "value" XX
    (nil)   # 因为键不存在，设置失败

    redis 127.0.0.1:6379> SET exists-key "value"
    OK      # 先给键设置一个值

    redis 127.0.0.1:6379> SET exists-key "new-value" XX
    OK      # 设置新值成功

    redis 127.0.0.1:6379> GET exists-key
    "new-value"
  ```

## MYSQL

MySQL 为关系型数据库(Relational Database Management System)，一个关系型数据库由一个或数个表格组成

> 数据仓库 注重决策,复杂的分析操作; 数据库 基本的、日常的事务处理,使用原始格式保存大量原始数据

- `表头(header)`: 每一列的名称
- `列(col)`: 具有相同数据类型的数据的集合
- `行(row)`: 每一行用来描述某个人/物的具体信息
- `值(value)`: 行的具体信息, 每个值必须与该列的数据类型相同
- `键(key)`: 表中用来识别某个特定的人物的方法, 键的值在当前列中具有唯一性

## Java

### 关键字

`public`、`class`和`static`等单词都是 Java 语言中的关键字,`public`称为`访问修饰符`,用于控制程序的其他部分对这段代码的访问级别.
关键字也称之为保留字

### 识别符

Java 程序的各个组成部分都需要名字.类名、变量名、方法名、方法参数名等都被称为标识符.比如`HelloWorld`这个类名在代码中就是一种标识符.标识符是我们自己来命名的.

- 所有的标识符都应该以`字母（A-Z或者a-z）`,`美元符（$）`、或者`下划线（_）`开始
- 首字符之后可以是字母`（A-Z或者a-z）`,`美元符（$）`、`下划线（_）`和数字的组合
- Java 语言自带的关键字不能用作标识符，比如你不能定义一个类或者方法命名为`class`
- `标识符是大小写敏感的`

### 数据类型&变量

`变量（Variable）`是在内存中动态存储值的地方.简单地理解，程序的作用就是对变量进行各种运算
Java 是一种强类型语言.Java 要求在使用一个变量前要求必须声明它的类型.分为:

- `基本数据类型（或者称为原生数据类型）`
- `引用数据类型`

#### 声明变量

声明一个变量之后, 必须用赋值语句对变量进行显式初始化, 千万不要使用未初始化的
变量

```java
public class VariableTest {
    public static void main(String[] args) {
        int a = 1, b, c = 2;
        double pi = 3.14159;
        char x = 'x';
    }
}
```

**常量** 在 Java 中, 利用关键字 `final` 指示常量

```java
public class Constants
{
  public static void main ( String [] args)
  {
    final double CM _ PER INCH = 2.54 ;
    double paperWidth = 8.5;
    double paperHeight = 11;
    System.outprintln( " Paper size in centimeters : "
    + paperWidth * CM PER INCH + " by " + paperHeight;
  }
  * CM.PER.INCH ) ;
}
```

关键字 final 表示这个变量只能被赋值一次 . 一旦被赋值之后, 就不能够再更改了 . 习惯上 ,
常量名使用全大写

#### 基本数据类型

Java 语言提供了八种基本类型，其中包括六种数字类型（四种整数型，两种浮点型），一种字符类型，还有一种布尔型

[基本类型示例](https://course.tianmaying.com/java-basic+data-types#2)

#### 数组

一系列相同类型的数据. 一个数组一旦创建后，它的长度是固定的.通过一个整型下标可以访问数组中
的每一个值

- 一旦创建了数组, 就不能再改变它的`大小`
- `for each` 循环

  ```java
    for (int element : a )
    System.out.println (element ) :
  ```

- 初始化及匿名数组 :`int [] small Primes = { 2 , 3 , 5 , 7 , 11 , 13 } ;`

#### 字符串

从概念上讲, Java 字符串就是 `Unicode` 字符序列 ,`String`并不是基本的数据类型，是一个类

- `String str = "abc"` 最常见的定义字符串实例

- 可以通过`+` `+=` 操作字符串拼接

  ```java
  String expletive = " Expletive" ;
  String PC13 = " deleted " ;
  String message = expletive + PC13;
  ```

- 当将一个字符串与一个非字符串的值进行拼接时 , 后者被转换成字符串 ,任何一个 Java 对象都可以转换成字符串

  ```java
    int age= 13;
    String rating = " PC " + age
    //rating 为13
  ```

- `substring()` 方法 ,从一个较大的字符串提取出一个子串 ,第二个参数是不想复制的第一个位置
- `不可变字符串`,String 类没有提供用于修改字符串的方法,所以通过修改字符串变量来改变字符串

## Python

### [安装库及常用框架](https://germey.gitbooks.io/python3webspider/1.1-Python3%E7%9A%84%E5%AE%89%E8%A3%85.html)

注意,pip 安装和 pip3 安装路径不同,须统一安装方式
运行测试代码,新建.py 文件,在终端下或是 vscode 右键运行

- `Docker` 安装(Fu\*\*)出错时,更新软件源,检查公钥问题,[详情](http://zyy1217.com/2016/08/25/%E7%8E%A9Docker%E6%8E%89%E8%BF%9B%E7%9A%84%E5%90%84%E7%A7%8D%E5%9D%91/),具体脚本式安装看[这个](https://www.jianshu.com/p/07e405c01880)
- `yield` 关键字
  迭代（iteration）是一种操作,逐个获取元素的过程，就是「迭代」.迭代器（iterator）是一种对象,迭代协议指容器类需要包含的特殊方法,Python 中迭代协议和 for 循环绑在一起.

  生成器函数（generator function）和生成器（generator）: 生成器函数是一种特殊的函数；生成器则是特殊的迭代器

  ```Python
      def func():
      return 1

      def gen():
      yield 1
  ```

  除了返回值不相同,和普通函数没有太大区别.func() 是一个 int 类型的对象；而 gen() 则是一个迭代器对象。
  当函数内遇到 yield 关键字后,将返回生成器对象,变量保存(暂存),直到下一次迭代调用时,从之前暂存位置开始读取

  ```Python
      >>> f = fab(5)
      >>> f.next()
      1
      >>> f.next()
      1
      >>> f.next()
      2
      >>> f.next()
      3
      >>> f.next()
      5
      >>> f.next()
  ```

  参考: [(译)Python 关键字 yield 的解释(stackoverflow)](https://pyzh.readthedocs.io/en/latest/the-python-yield-keyword-explained.html),[理解 yield 关键字](https://liam.page/2017/06/30/understanding-yield-in-python/)

- python 字符串可以被索引

  ```Python
    >>> word = 'Python'
    >>> word[0]
    'P'
    >>> word[5]
    'n'
    #可以是负数,负数代表从右边计算
    >>> word[-6]
    'P'
    #支持切割字符串
    >>> word[2:5]
    'tho'
    #简写(省略冒号前后)即使用默认值,冒号前省略,代表默认为0;省略省略冒号后,代表要切割的字符串的长度,即最后
    >>> word[:2]
    'Py'
    >>> word[4:]
    'on'
    >>> word[-2:]
    'on'
    #注意
    #尝试过大索引会报错,如word[89],但长度只有6
    #不可给索引赋值,可以尝试创建新的字符串拼接
  ```

## 参考资料

太多，[书签](https://app.yinxiang.com/Home.action?login=true#n=2f7b3fe9-e2dd-4056-b36a-fadfa36642cf&s=s45&b=8a69d444-49ec-4ffd-991d-5acadd0b91ff&ses=4&sh=1&sds=5&)保存一下
