###OC语言

1. 分类
2. 关联对象
3. 扩展
4. 代理
5. 通知
6. KVO
7. KVC
8. 属性关键字

*****

###分类(Category)

**你用分类都做了哪些事情?**

1. 声明私有方法
2. 分解体积庞大的类文件
3. Framework的私有方法公开化

**分类的特点**

运行时决议

为系统类添加分类

**分类中都可以添加哪些内容**

1. 实例方法
2. 类方法
3. 协议
4. 属性(getter,setter方法,实质上没有添加属性)
5. 成员变量(关联对象)

- 分类添加的的方法可以"覆盖"原类方法
- 同名方法谁能生效取决于编译顺序
- 名字相同的分类会导致编译报错

###关联对象

**能否给分类添加"成员变量"?**

	objc_setAssociatedObject(id object, const void *key, id value, objc_associationPolicy policy);
	objc_getAssociatedObject(id object, const void *key);
	objc_removeAssociatedObjects(id object);

**关联对象的本质**

- 关联对象由AssocationsManager管理并在AssocationHashMap存储

- 所有对象的关联内容都放在同一个全局的容器中

###扩展(Extension)

**一般用扩展来做什么?**

1. 声明私有属性
2. 声明私有方法
3. 声明私有成员变量

**分类和扩展的区别?**

1. 编译时决译 (分类是运行时决议)
2. 只以声明的形式存在,实现多数情况下在宿主类.m中 (分类有声明,有实现)
3. 不能为系统类添加扩展 (可以为系统类添加分类)

###代理(delegate)

代理是一种软件设计模式

iOS中以Protocol的形式体现

一对一的传递方式

一般声明weak防止循环引用

###通知(NSNotifaction)

是使用观察者模式来实现跨层传递消息的机制

传递方式一对多

**如何实现通知机制?**

notifactionName对应OberserList[key, 方法名称, observer1....observerN]

###KVO(观察者模式)

1. key-value-observing
2. Object-C对观察者设计模式的一种实现
3. Apple使用isa(isa-swizzling)混写技术实现的KVO

**isa技术在swzzling混写在kvo是怎样实现的呢?**

addObserverforKeyPath(key)->运行时动态创建NSKVONotify_A类 然后将原来的类A指向NSKVONotify_A 继承A 对A的Setting方法进行重写 达到负责通知所有观察者的目的

![isa混写技术](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/ObjectiveC/isa混写技术.png)

**KVO重写Setter的子类添加的方法**

	- (void)willChangeValueForKey:(NSString *)key;
	- (void)didChangeValueForKey:(NSString *)key;

	// NSNotifying_A 的Setter方法实现
	- (void)setValue:(id)obj {
		
		[self willChangeValueForKey:@"keyPath"];
		[super setValue:obj];
		[self didChangeValueForKey:@"keyPath"];
	}


###KVC(键值观察)

1. key-value-coding

		- (id)valueForKey:(NSString *)key;
		- (void)setValue:(id)value forKey:(NSString *)key;

**kvc是否会破话面向对象的编程思想?**

会.因为kvc会动态改变数据的值 key是没有限制的,知道内部私有变量名称的,可以外部进行设置和修改 

**kvc的实现流程**

![kvc查找属性流程](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/ObjectiveC/查找属性流程.png)

###属性关键字

1. 读写权限
	
	readonly (对象使用之后,只能使用getter方法,不能使用setter方法, 可以使用,不能改)
	
	readwrite(默认)

2. 原子性

	automic(默认) (保证赋值和获取是安全的) 但是不能修改
	
	nonatomic(经常使用) 
	
3. 引用计数
	
	retain(mrc)/strong(arc) 修饰对象
	
	assign(修饰基本数据类型,对象类型)/unsafe_unretained(mrc)
	
	weak
	
	copy


**assign和weak的区别**

1. assgin修饰基本数据类型,对象			weak只修饰对象
2. assgin修饰对象的时候不改变其引用计数  weak不改变被修改对象的引用计数
3. assgin修饰对象被释放后会产生悬垂指针  weak被修饰的对象被释放后会自动置为nil

**copy**

1. 可变对象的copy和mutableCopy都是深拷贝
2. 不可变对象的copy是浅拷贝,mutableCopy是深拷贝
3. copy返回的对象都是不可变对象
4. mutableCopy返回的对象都是可变对象

**面试题 @property(copy) NSMutableArray *array?**

对可变对象copy的结果是:深拷贝,不可变. 所以在对array进行添加删除的时候会报错.

**浅拷贝**

1. 增加引用计数
2. 只是拷贝了指针,没有开辟新的内存空间

**深拷贝**

1. 不改变原数据的引用计数
2. 既拷贝了指针,又开辟了新的内存地址

![copy关键字](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/ObjectiveC/copy.png)

**MRC下如何修改retain修饰变量的setter方法?**

	@property(nonatomic, retain) id obj;
	
	- (void)setObj:(id)obj {
		if (_obj != obj) { // 防止一些异常处理, obj有没有已经被释放等情况
			[_obj release];
			_obj = [obj retain];
		}
	}


****

##李明杰

### NSObject

	1. 我们平时编写的Objective-C代码,底层实现都是C\C++代码
	2. Objective-C的面向对象都是基于C\C++的数据结构实现的
 
	Objective-C->C\C++->汇编语言->机器语言


1. 一个NSObject对象占用多少内存?

		NSObject实质上是一个结构体isa指针 64位处理器下占用8字节,
		分配了16字节存储空间给NSObject对象(通过malloc_size获得)
		但NSObject对象内部只使用了8个字节的空间(可以通过class_getInstance获得 )
	
2. Objective-C的对象,类主要是基于C\C++的什么数据结构实现的?

	结构体
	
	NSObject的底层实现:
	
	@interface NSObject {
   	 	Class isa;
	}
	
	==>
	
	struct NSObject_IMPL {
   	 	Class isa;
	};
	
3. 如何将OC代码转成C++语言? 

		// 将OC代码转成c++文件
		clang -rewrite-objc main.m -o mian.cpp
		// xcrun xcode的工具
		// iphoneos 手机系统
		// -arch arm64 64位手机系统
		// 模拟器(i386) 32bit(armv7) 64bit(arm64)
		xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m -o main-arm64.cpp
	
4. Student占用多少字节?

	Struct NSObject_IMPL {
		Class isa; // 8
	}
	
	Struct Person_IMPL {
		struct NSObject_IMPL NSObject_IVARS; // 8
		int _age; // 4
	} // 16
	
	struct Student_IMPL {
		struct Person_IMPL Person_IVARS; // 16
		int _no; // 4
	}
	
	因为Person里有4个字节空着 然后就4+4+8
	
	Student一共16字节
	
5. Objective-C中的对象,主要可以分为3种:
		
		1.instance对象(实例对象)
			类alloc出来的对象,每次调用都会产生新的instance对象.
			NSObject *obj1 = [[NSObject alloc] init];
			
			a.isa指针
			b.其他成员变量
			
		2. class(类对象)
			Class objectClass = [obj1 class];
			Class objectClass = [NSObject class];
			Class objectClass = object_getClass(obj1);
			
			每个类在内存中有且只有一个类对象
			
			a.存放isa
			b.superclass指针
			c.类的属性信息(@property)
			d.类的对象方法(instanceMethod)
			e.类的协议(Protocol)
			f.类的成员变量信息(iva)
			
		3. meta-class(元类对象)
			Class objectMetaClass = object_getClass([NSObject class]);
			objectMetaClass是NSObject的meta-class对象(元类对象)
			
			每个类在内存中有且只有一个meta-class对象
			
			meta-class对象和class对象的内存结构是一样的,但是用途不一样
			
			在内存中存储的信息主要包括:
			
			a.存放类方法信息(class method)
			b.isa指针
			c.superclass指针
			
6. 对象isa指针指向哪里?
	实例对象isa指向类对象,类对象的isa指向元类对象,元类对象指向基类的元类对象

7. OC的类信息存放在哪里?
		
		1. 成员变量的具体值存放在instance对象
		2. 对象的方法,协议,成员变量存放在类对象
		3. 类方法存在元类对象里
		
8. weak的原理
   https://www.jianshu.com/p/16a95390f235
### isa,superClass总结
		
		1. instance(实例对象)的isa指向class(类对象)
		2. class(类对象)的isa指向meta-class(元类对象)
		3. meta-class(元类对象)的isa指向root-class(根对象)
		4. class(类对象)的superclass指向父类的class,没有父类指向nil
		5. meta-class(元类对象)的superclass指向父类的meta-class
		6. rootClass(根对象)的meta-class指向rootClass(基类)
		7. isa找到class,方法不存在,就通过superclass找父类

###KVO

1. iOS用什么方式实现对一个对象的KVO?

		person.isa == NSKVONotifying_Person 之前isa指向的类对象 现在指向了KVONotifying_Person这个类, 然后这个类调用set方法, 执行 _NSSetIntValueAndNotify() 然后执行willChangValueForKey didChangValueForKey
		
		当一个对象使用了KVO监听,iOS系统会修改这个对象的isa指针,
		改为指向一个全新的动态RunTime创建的子类(NSKVONotifying_Person),子类用自己的set方法实现,内部会调用:
		1. willChangValueForKey:
		2. 原来的setter方法实现
		3. didChangValueForKey:, 这个方法内部又会调用监听器(Observer)的监听方法

2. 如何手动触发KVO?

		willChangValueForKey:
		修改值
		didChangValueForKey:
		
		
###KVC

1. 通过KVC修改属性会触发KVO吗?
	
		会触发KVO

2. KVC的赋值和取值是怎样的? 原理是什么?

		赋值:
		[setValue:@10 forKey:@"age"];
		先寻找setAge:方法 
		没有则找_setAge:方法 
		再没有则找accessInstanceVariablesDirectly如果返回的NO
		则调用setValue:forUndefinedKey:并抛出异常NSUnkonwnKeyExecption
		如果返回的是YES, 这允许访问成员变量
		_Age, _isAge, age, isAge 如果还是找不到也会抛出异常
		
		取值:
		[person valueForKey:@"age"];
		getAge age isAge _age
		找不到则accessInstanceVariablesDirectly如果返回NO
		则调用getValue:forUndefinedKey:并抛出异常NSUnkonwnKeyExecption
		如果返回的YES, 则直接访问有没有以下成员变量
		_age _isAge age isAge
		如果还是找不到则报错
###Category

运行时执行步骤:
		
		1.objc-os.mm (objc_init)

**分类后编译先调用原则**

1. category的实现原理?

		category编译之后的底层结构是struct category_t
		里面存储着分类的对象方法,类方法,属性,协议信息
		在程序运行的时候,runtime会将category的数据合并到类信息中(类对象,元类对象中)
	

2. Category和Class Extension的区别是什么?

		Class Extension在编译的时候,它的数据就已经包含在类信息中
		Category是在运行时,才会将数据合并到类信息中
		
3. Category中有load方法吗?load方法是什么时候调用的?load方法能继承吗?
	
		有 
		+load方法会在runtime加载类, 分类的时候调用
		每个类,分类的+load方法,在程序运行过程中只调用一次
		
		调用顺序
		1.先调用类的+load方法
		按照编译先后顺序调用(先编译,先调用)
		调用子类的+load方法之前会先调用父类的+load
		2.再调用父类的+load方法
		按照编译先后顺序调用(先编译,先调用)
		
		存在继承 但是一般不会主动调用
		
**load方法是先编译先执行**

4. load,initialize方法的区别是什么?它们在Category中调用的顺序?以及出现继承时他们之间的调用过程?

		initialize在类第一次接收消息时调用, 只会调用一次
		先调用父类的initialize, 再调用子类的initialize
		先初始化父类,再初始化子类,每个类只会初始化1次
		
		1.调用方式:
		load是根据函数地址直接调用
		initialize通过objc_msgSend调用
		2.调用时刻:
		load是runtime加载类, 分类的时候调用(只会调用一次)
		initialize在类第一次接收消息时调用, 只会调用一次(父类可能会被调用多次)
		3.调用顺序
		load:先调用类,再调用分类, 先编译的类优先调用, 调用子类的load之前,会先调用父类的load
		initialize:先初始化父类,再初始化子类
		
	**如果分类实现了initialize, 就覆盖类本身的initialize** 

	msgSend()
	class_getInstanceMethod
	lookupIMPForward然后_class_initialize
	superClass有没有初始化, 没有先执行父类的initialize

5. Category能否添加成员变量?如果可以,如何给Category添加成员变量?

		不能给Category直接添加成员变量,通过关联对象技术添加
		

6. 类里的对象方法, 和各分类的对象方法重名,会优先执行哪个方法?

		1.类里和分类都有,则优先会找分类里的重名方法
		2.多个分类里有同名方法, 则取决于编译顺序, while(i--), 倒序遍历, 最后面的分类会放在合并在类方法的方法列表的最前面, 所以最后添加编译的最先执行
	
	
###关联对象

	AssocationManager
	AssiocationHashMap
	维护一个全局的map表 以object为key, AssiocationMap为value
		
###Extension扩展

	类的扩展在编译时完成,当项目在编译时就已经将扩展的属性,方法合并到类里去了
	分类是在运行时机制合并到类信息里的
	
###Block

	执行的代码包装起来,在合适的时机调用
	
1. block的本质

		block本质上也是一个OC对象,它内部也有个isa指针
		block是封装了函数调用以及函数调用环境的OC对象
		
		int age = 10;
		void (^block)(int, int) = ^(int a, int b){
           NSLog(@"这是个block --%d", age);
       	};
       	block(10, 10);
		
		struct __block_impl {
			void *isa;
			int Flags;
			int Reserved;
			void *FuncPtr;
		}
		
		struct __main_block_desc_0 {
			size_t reserved;
			size_t Block_size;
		}
		
		struct __main_block_impl_0 {
			struct __block_impl impl;
			struct __main_block_desc_0* Desc;
			int age;
			__main_block_impl_0(void *fp, struct __main_block_desc_0* desc, int age, int flags=0) : age(_age) {
				impl.isa = *_NSConcreteStackBlock;
				impl.Flags = flags;
				impl.FuncPtr = fp;
				Desc = desc;
			}
		}
		

2. block的类型

		block有3种类型, 可以通过调用class方法或者isa指针查看具体类型, 最终都是继承自NSBlock类型
		
		一切以运行时结果为准
		
		__NSGloabBlock__ 编译后 (_NSConcreteGlobalBlock) 数据区   copy后什么也不做
		Gloal:没有访问auto变量
		void (^block)(void) = ^{
			NSLog("block -----");
		};
		或者:
		static init age = 10;
		void (^block)(void) = ^{
			NSLog("block ----- %d", age);
		};
		NSLog("%@", [block class]);
		
		
		__NSStackBlock__	编译后 (_NSConcreteStackBlock)  栈区:放局部变量,系统自动分配内存,自动销毁 copy后复制到堆
		Stack:访问了auto变量
		int age = 10;
		void (^block)(void) = ^{
			NSLog("block------ %d", age);
		};
		
		
		__NSMallocBlock__ 编译后 (_NSConcreteMallocBlock) 堆区:动态分配内存, 需要开发者申请内存,管理内存
		__NSStackBlock__调用了copy   copy引用计数增加
		
		
		[block class]
		__NSGlobalBlock__
		
		[[block class] superclass]
		__NSGlobalBlock
		
		[[[block class] superclass] superclass]
		NSBlock
		
		[[[[block class] superclass] superclass] superclass]
		NSObject
		
	
3. block的copy操作
	
		在ARC环境下, 编译器会自动将栈上的block复制到堆上
		
		1.block作为函数返回值时

		typedef void (^TestBlock)(void);

		TestBlock test() {
			return ^{
				NSLog("----")
			};
		}
		
		2.将block赋值给__strong指针时
		3.block作为Cocoa API中方法名含有usingBlock的方法参数时
		4.block作为gcd方法参数
		
4. 对象类型的auto变量

	__weak修复的对象在生成c++代码时候会报错, 需要
	
	xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-8.0.0 main.m
	
问:当block内部访问了对象类型的auto变量时
	
	1. 只要block在栈上的,都不会对auto对象进行强引用
	2. 如果block被拷贝到堆上
		会调用block内部的copy函数
		copy函数内部会调用_Block_object_assign函数
		_Block_object_assign函数会根据auto变量的修饰符(__strong, __weak, __unretained)做出相应的操作,类似于retain(形成强引用,弱引用)
	3.如果
