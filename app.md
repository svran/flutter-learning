1. 展示一个简单的相册app. 
2. 功能包括 首页,底部tabbar, 侧滑栏. 主页展示图片网格, 点击图片预览大图.
   - 创建flutter项目
   - 编写MaterialApp-> Scaffold -> AppBar -> body = IndexedStack -> BottomNavigationBar 
   - 添加两个 BottomNavigationBarItem 和 两个IndexedStack 中的两个页面.
   - IndexedStack index 和 BottomNavigationBar currentIndex 实现切换页面.
   - Scaffold  添加 drawer 侧滑栏.
   - 首页GridView.使用List.generate 生成 多个 image.network. fit 属性 BoxFit.cover
   - GridView gridDelegate, SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, space8, childAspectRatio 16/9,)
   - 首页 GridView展示 宫格 图片. URL地址: https://picsum.photos/600/400?random=
   - 编写详情页面. Scaffold -> 背景黑色, 居中. 
   - 路由跳转 puhs 先使用Material 再演示PageRouteBuilder -> FadeTransition -> opacity传入 animation
   - 宫格页面添加点击,跳转过去. 携带参数 url, 详情图片点击返回.
   - 为效果跳转, 实现Hero动画 宫格页和详情页,用Hero包裹, tag 使用url.
3. 讲设计模式相关.
4. 回过头来,把当前项目中对应嵌套地狱相关代码做优化重构.

