CBCoreDataTutorial
==================

A simple tutorial to demonstrate basic CoreData implementations. I wrote it for my wife, so the descriptions and commit comments are in Chinese.

<img src="https://raw.github.com/CocoaBob/CBCoreDataTutorial/master/screenshot.png" width="320" height="480"/>

Components 结构：
==================

1.  一个DataModel：数据库中的每一条数据，都是数据模型的实例。数据模型里只要有date和content即可。
2.  一个TableView。
3.  一个View的Controller——VC：从DC中获取数据，并让TableView显示。
4.  一个DataBase的Controller——DC：创建并打开数据库，在里头添加或删除数据，退出程序时要保存数据库。

Steps 步骤：
==================

1\. 项目：

1.  创建一个Single View Application，使用ARC，同时支持iPhone、iPad

2\. View部分：

1.  在Storyboard里添加NavigationController：把程序入口改到NC上，删掉NC自带的VC，把创建项目时创建的VC设置成NC的rootViewController。
2.  在viewDidLoad里给这个VC添加一个UITable并设置delegate和datasource到这个VC
3.  在这个table的顶部添加一个textfield，并设置其delegate到这个VC
4.  让keyboard在table滚动或某一行被选中的时候dismiss

3\. CoreData部分：

1. 给项目添加CoreData.framework

2. 添加一个继承自NSObject的subclass，命名为HistoryManager

3. 添加一个Data Model，命名为HistoryModel

	1.  右击左侧项目文件目录，菜单里选New File…
	2.  选Core Data里的Data Model
	3.  命名为HistoryModel，保存

4. 添加Core Data所需的private properties

	1.  NSManagedObjectModel
    \*managedObjectModel;（数据库的模型表示，是若干数据表的集合。）
	2.  NSManagedObjectContext\*
    managedObjectContext;（若干NSManagedObject在内存中的存在空间，或称上下文。除非该上下文执行save动作，否则数据变动一直限于内存中，并不会保存到文件。）
	3.  NSPersistentStoreCoordinator
    \*persistentStoreCoordinator;（作为中间层，根据NSManagedObjectModel帮我们协调不同格式的存储文件。）

5. 实现这些properties的getter（使得第一次调用getter的时候初始化其对应的实例）

	1. NSManagedObjectModel
	2. NSManagedObjectContext
	3. NSPersistentStoreCoordinator，CoreData支持XML、SQLite等存储方式，我们在这里选SQLite

6. 为DataModel添加Entity，并设置attributes

	1. Add Entity：添加HistoryItem
	
	2. 给这个Entity添加attributes

		1.  String类型的content
		2.  Data类型的date

7. 为DataModel的Entity创建NSManagedObject的subclass

	1.  右击HistoryModel.xcdatamodeld，选择New File…
	2.  选择Core Data中的NSManagedObject subclass
	3.  选择Data Model的名字
	4.  选择Entity的名字
	5.  选择保存位置，并确认

8. 添加数据库查询、增加数据、删除数据的函数

	1.  \- (NSArray \*)allHistories;
	2.  \- (void)addNewHistoryWithDate:(NSDate \*)date content:(NSString
	    \*)content;
	3.  \- (void)deleteHistory:(HistoryItem \*)history;

4\. 整合

1.  把MCHistoryManager改造成singleton
2.  给VC添加一个array用来保存数据库里获得的数据
3.  查询数据库并更新这个array
4.  使用array显示TableView
5.  通过TextField的回车事件添加history
6.  通过TableView删除history
