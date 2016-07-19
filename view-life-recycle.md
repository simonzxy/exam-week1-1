###iOS视图生命周期
* init：初始化程序
* viewDidLoad：加载视图
* viewWillAppear：控制器的对象视图即将加入窗口时调用
* viewDidApper：控制器对象的视图已经加入到窗口时调用
* viewWillDisappear：控制器对象的视图即将消失，或者被覆盖，隐藏时调用
* viewDidDisappear：控制器对象的视图已经消失，或者被覆盖，隐藏时调用
* viewVillUnload：当内存过低时，需要释放一些不需要使用的视图时，在即将释放的时候调用
* iewDidUnload：当内存过低，释放一些不需要的视图时调用
* dealloc：视图被销毁，需要对在init方法中，或者viewDidLoad方法中创建的对象进行释放