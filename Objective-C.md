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
	
	readonly
	
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

	NSObject实质上是一个结构体isa指针 64位处理器下占用8字节

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

	clang -rewrite-objc main.m -o mian.cpp
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
2. 如何手动触发KVO?