###Swift面试题

*****

###问题

1. class和struct的区别
2. 不通过继承, 代码复用的方式有哪些?
3. Set独有的方法有哪些?
4. 实现一个min函数, 返回两个元素较小的元素
5. map, filter, reduce的作用
6. map和flatMap的区别
7. 什么是copy on write时候
8. 如何获取当前代码的函数名和行号
9. 如何声明一个只能被类conform的protocol
10. defer使用场景
11. String与NSString的关系与区别
12. 怎么获取一个String的长度
13. 如何截取String的某段字符串
14. throws和rethrows的用法与作用
15. try? 和 try! 是什么意思
16. associatedtype的作用
17. 什么时候使用final
18. public和open的区别
19. 声明一个只有一个参数没有返回值闭包的别名
20. Self的使用场景
21. dynamic的作用
22. 什么时候使用@objc
23. Optional(可选型)是用什么实现的
24. 如何自定义下标获取
25. ??的作用
26. lazy的作用
27. 一个类型表示选项, 可以同时表示几个选项选中(类似UIViewAnimationOptions), 用什么类型表示
28. inout的作用
29. Error如果要兼容NSError需要做什么操作
30. 下面的代码都用了哪些语法糖
31. 什么是高阶函数
32. 如何解决引用循环
33. 下面代码会不会崩溃, 说出原因
34. 给集合中元素是字符串的类型增加一个扩展方法,应该怎么声明
35. 定义静态方法时关键字static和class有什么区别
36. 一个Sequence的索引是不是一定从0开始?
37. 数组都实现了哪些协议
38. 如何自定义模式匹配
39. autoclosure的作用
40. 编译选项 whole module optmization 优化了什么
41. 下面代码中nutating的作用是什么
42. 如何让自定义对象支持字面量初始化
43. dynamic framework 和 static framework的区别是什么
	
###答案

1. class和struct的区别

	class为类, struct为结构体
	类为引用类型 结构体为值类型
	结构体不能继承
	
2. 不通过继承, 代码复用的方式有哪些

	扩展
	全局函数
	
3. Set独有的方法有哪些?

		// 定义一个set
		let setA: Set<Int> = [1, 2, 3, 4, 5] // {1, 2, 3, 4}, 顺序可能不一致, 同一个元素只有一个值
		let setB: Set<Int> = [1, 3, 5, 7, 9] // {1, 3, 5, 7, 9}
		// 取交集 A & B
		let setIntersect = setA.intersection(setB) // {1, 3}
		// 取并集 A | B
		let setUnion = setA.union(setB) // {1, 2, 3, 5, 7, 9}
		// 取差集 A - B
		let setRevers = setA.subtracting(setB) // {2, 4}
		// 取对称差集, A XOR B = A-B | B - A
		let setXor = setA.symmetricDifference(setB)
		
4. 实现一个min函数, 返回两个元素较小的元素

		func myMin<T: Comparable>(_ a: T, _ b:  T) -> T {
			return a < b ? a : b
		}
		myMin(1, 2)
		
5. map, filter, reduce的作用
	
	map用于映射, 可以将一个列表转换成另一个列表
		
		[1, 2, 3].map{"\($0)"} // 数字数组转换为字符串数组
		["1", "2", "3"]
		
	filter用于过滤, 可以筛选出想要的元素
	
		[1, 2, 3].filter{ $0 % 2 == 0} // 筛选偶数
		// [2]
		
	reduce合并
	
		[1, 2, 3].reduce(""){$0 + "\($1)"} // 转换为字符串并拼接
		// "123"
		
6. map和flatMap的区别

	flatMap会丢掉那些返回为nil的值
	
	flatMap被compactMap替换
	
		["1", "@", "2", "3", "a"].flatMap{Int($0)}
		
7. 什么是copy on write时候
	
	写时复制, 指的是swift中的值类型, 并不会在一开始赋值的时候就去复制, 只有在需要改的时候才去复制
	
8. 如何获取当前代码的函数名和行号
	
		#file 用于获取当前文件文件名
		#line 用于获取当前行号
		#column 用于获取当前列编号
		#function 用于获取当前函数名
		以上这些都是特殊的字面量, 多用于调试输出日志
		
9. 如何声明一个只能被类conform的protocol
	
	声明协议的时候, 加一个class即可
	
		protocol SomeClassProtocol: class {
			func someFunction()
		}
	
10. defer使用场景
	
	defer语句块中的代码, 会在当前作用域结束前调用
	
	如果有多个defer, 那么先加入的先执行
	
11. String与NSString的关系与区别

	NSString和String之间可以随意转换
	
	String是结构体 值类型 NSString是类 引用类型
	
	通常没必要使用NSString类, 除非你使用一些特有方法, 例如 pathExtension属性
	
12. 怎么获取一个String的长度
	
	不考虑编码, 只是想知道字符的数量, 用characters.count
	
	如果考虑编码则使用"hello".lengthOfBytes(using: .ascii)
	
13. 如何截取String的某段字符串

	substring:to   substring: from  substring: with
	
		let simpleString = "Hello, world"
		simpleString.substring(to: simpleString.index(simpleString.startIndex, offsetBy: 5))
		// hello
		simpleString.substring(from: simpleString.index(simpleString.endIndex, offsetBy: -5))
		// world
		simpleString.substring(with: simpleString.index(simpleString.startIndex, offsetBy: 5) ..< simpleString.index(simpleString.endIndex, offsetBy: -5))

14. throws和rethrows的用法与作用

	throw用在函数上, 表示这个函数会抛出错误
	
	有两种情况会抛出错误, 一种是直接使用throw抛出, 另外一种是调用其他抛出异常的函数时, 直接使用 try xx没有处理异常
	
		enum DivideError: Error {
    			case EqualZeroError
		}

		func divide(_ a: Double, _ b: Double) throws -> Double {
    			guard b != Double(0) else {
				throw DivideError.EqualZeroError
			}
    			return a / b
		}
		
		func split(pieces: Int) throws -> Double {
    			try divide(1, Double(pieces))
		}
	
	rethrows 和 throws类似, 不过只适用于参数中有函数, 且函数会抛出异常的情况, rethrows可以适用throws替换, 反过来不行
	
		func processNumber(a: Double, b: Double, function: (Double, Double) throws -> Double) rethrows -> Double {
			return try function(a, b)
		}
		
15. try? 和 try! 是什么意思

	这两个都用于处理可抛出异常的函数, 使用者两个关键字可以不用写do catch
	
	区别: try? 在用于处理可抛出异常函数时, 如果函数抛出异常, 则返回nil, 复制返回函数的可选值 如:
	
		print(try? divide(2, 1)) // Optional(2.0)
		print(tyr? divide(2, 0)) // nil
		
	而try! 则在函数抛出异常的时候崩溃, 否则则会返回函数返回值, 相当于 (try? xxx)! 如:
	
		print(try! divide(2, 1)) // 2
		print(try! divide(2, 0)) // 崩溃
		
16. associatedtype的作用

	简单来书就是protocol使用的泛型
	
	例如定义一个列表协议
	
		protocol ListProtocol {
			associatedtype Element
			func push(_ element: Element)
			func pop(_ element: Element) -> Element?
		}
		
	实现协议的时候, 可以适用typealias 制定为特定的类型, 也可以自动推断, 如
	
		class IntList: ListProtocol {
			typealias Element = Int // 使用 typealias 指定为 Int
			var list = [Element]()
			func push(_ element: Element) {
				self.list.append(element)
			}
			func pop(_ element: Element) -> Element? {
			 	self.list.popLast()
			}
		}

		class Double: ListProtocol {
			var list = [Double]()
			func push(_ element: Double) { // 自动推断
				self.list.append(element)
			}
			func pop(_ element: Double) -> Double? {
				return self.list.popLast()
			}
		}
		
	使用泛型也可以
	
		class AnyList<T>: ListProtocol {
			var list = [T]()
			func push(_ element: T) {
				self.list.append(element)
			}
			func pop(_ element: T) -> T? {
				return self.list.popLast()
			}
		}
		
	可以使用where字句限定Element类型, 如:
	
		extension ListProtocol where Element == Int {
			func isInt() -> Bool {
				return true	
			}
		}
		
17. 什么时候使用final

	final用于限制继承和重写, 如果只是需要在某一个属性前加final
	
	如果需要限制整个类无法被继承, 那么直接可以在类名前加final
	
18. public和open的区别

	这两个都用于在模块中声明需要对外暴露的函数
	
	public修饰的是类, 在模块外无法继承
	
	open可以任意继承 public < open
	
19. 声明一个只有一个参数没有返回值闭包的别名

		typealias SomeClosure: (String) -> (Void)	
		
20. Self的使用场景

	Self通常在协议中使用, 用来表示实现者或实现者的子类类型
	
	例如: 定义一个复制的协议
	
		protocol CopyProtocol {
			// 协议定一个方法, 实现该协议的自身类型并返回一个同样的类型
			func copy() -> Self
			
			// 不能在协议中定义 泛型 进行限制
			// Self 不仅指代的是 实现该协议的类型本身, 也包括了这个类型的子类
		}
		
	如果是结构体去实现, 要将Self换为具体类型
		
		struct SomeStruct: CopyProtocol {
			let value: Int
			func copySelf() -> SomeStruct {
				return SomeStruct(value: self.value)
			}
		}
		
	如果是类去实现, 需要实现一个required初始化方法
	
		class SomeCopyableClass: CopyProtocol {
			func copySelf() -> Self {
				return type(of: self).init()
			}
			required init() {}
		}
		
21. dynamic的作用

	由于swift是一个静态语音, 所以没有Objective-C中的消息发送这些动态机制, 
	
	dynamic的作用就是让swift代码也能有Objective-C种的动态机制, 
	
	常用的地方就是KVO了, 如果要监控一个属性, 则必须要标记为dynamic
	
22. 什么时候使用@objc

	@objc用途是为了在Objective-C和Swift混编的时候, 能够正常调用Swift代码, 可以用于修饰类, 协议, 方法, 属性
	
	常用的地方是在定义delegate协议中, 会将协议中的部分方法声明为可选方法, 需要用到@objc
	
		@objc protocol OptionalProtocol {
			@objc optional func optionalFunc()
			func normalFunc()
		}
		class OptionProtocolClass: OptionProtocol {
			func normalFunc() {
			
			}
		}
		let someOptionDelegate: OptionalProtocol = OptionProtocolClass()
		someOptionDelegate.optionalFunc?()
		
23. Optional(可选型)是用什么实现的
	
	Optional是一个泛型枚举
	
	大致定义如下:
	
		enum Optional<Wrapped> {
			case none
			case some(Wrapped)
		}
		
24. 如何自定义下标获取

	实现subscript即可, 如
	
		extension AnyList {
			subscript(index: Int) -> T {
				return self.list[index]
			}
			subscript(indexString: String) -> T? {
				guard let index = Int(indexString) else {
					return nil
				}
				return self.list[index]
			}
		}
	索引除了数字之外, 其他类型也是可以的
	
25. ??的作用

	可选值得默认值, 当可选值为nil的时候 会返回后面的值
	
26. lazy的作用

	懒加载, 当属性要使用的时候才去完成初始化
	
27. 一个类型表示选项, 可以同时表示几个选项选中(类似UIViewAnimationOptions), 用什么类型表示

	需要实现自OptionSet, 一般使用struct实现.由于OptionSet要求有一个不可失败的init(rawValue:)构造器, 
	而枚举无法做到这一点(枚举的原始值构造器是可失败的,而且有些组合值, 是没办法用一个枚举值表示的)

		struct SomeOption: OptionSet {
			let rawValue: Int
			static let option1 = SomeOption(rawValue: 1 << 0)
			static let option2 = SomeOption(rawValue: 1 << 1)
			static let option3 = SomeOption(rawValue: 1 << 2)
		}
		let options: SomeOption = [.option1, .option2]
	
28. inout的作用

	输入输出参数 例如:
	
		func swap(a: inout Int, b: inout Int) {
    			let temp = a
    			a = b
    			b = temp
		}
		var ax = 1
		var bx = 2
		swap(a: &ax, b: &bx)
 
 29. Error如果要兼容NSError需要做什么操作

	其实直接转换就可以, 例如 SomeError.someError as NSError 但是这样没有错误码, 描述等等,
	
	如果想和NSError一样有这些东西, 只需要实现localizedError和CustomNSError协议, 有些方法有默认实现, 可以忽略 如:
	
		enum SomeError: Error, LocalizedError, CustomNSError {
    			case error1, error2
    			public var errorDescription: String? {
				switch self {
        				case .error1:
            				return "error description error1"
					case .error2:
        				return "error description error2"
        			}
    			}
    			var errorCode: Int {
        			switch self {
        			case .error1:
            				return 1
        			case .error2:
            				return 2
        			}
    			}
    			public static var errorDomain: String {
        			return "error domain SomeError"
    			}
    			public var errorUserInfo: [String: Any] {
        			switch self {
        			case .error1:
            				return ["info": "error1"]
        			case .error2:
            				return ["info": "error2"]
        			}
    			}
		}
		print(SomeError.error1 as NSError)
		// Error Domain=error domain SomeError Code=1 "error description error1" UserInfo={info=error1}

30. 下面的代码都用了哪些语法糖

		[1, 2, 3].map{ $0 * 2}
	
	[1, 2, 3]使用了,Array实现的ExpressibleByArrayLiteral协议, 用于接受数组的字面值
	
	map{xxx}使用了闭包作为最后一个参数时,可以直接写在调用后面, 而且如果是唯一参数, 圆括号可以省略
	
	闭包没有声明函数参数, 返回值类型,数量,依靠的是闭包类型的自动推断
	
	比保重语句只有一句是,自动将这一句结果作为返回值
	
	0在没有声明参数列表的时候, 第一个参数名称为0, 后续参数以此类推
	
31. 什么是高阶函数

	一个函数如果可以以某一个函数作为参数, 或者返回值, 那么这个函数就称为高阶函数, 如map, reduce, filter
	
32. 如何解决引用循环

	1. 转换为值类型, 只有类会存在引用循环, 所以如果能不用类, 是可以解引用循环的
	2. delegate使用weak属性
	3. 闭包中,对有可能发生循环引用的对象,使用weak或者unowned,修饰

33. 下面代码会不会崩溃, 说出原因

		var mutableArray = [1, 2, 3]
		for _ in mutableArray {
			mutableArray.removeLast()
		}
		
	不会崩溃 for in 在对mutableArray进行了一次捕获, 而Array是一个值类型, removeLast() 并不能修改捕获的值
	
34. 给集合中元素是字符串的类型增加一个扩展方法,应该怎么声明

	使用where子句, 限制Element为String
	
		extension Array where Element == String {
			var isStringElement: Bool {
				return true
			}
		}
		["1", "2"].isStringElement
		[1, 2]. isStringElement // 报错
		
35. 定义静态方法时关键字static和class有什么区别

	static定义的方法不可以被子类继承, class则可以
	
		class AnotherClass {
    			static func staticMethod() {}
    			class func classMethod() {}
		}
		class ChildAnotherClass: AnotherClass {
    			override class func classMethod() {}
		}
	
36. 一个Sequence的索引是不是一定从0开始?
	
	不一定, 两个 for in 并不能保证都是从0开始, 且输出结果一致 官方文档
	
		for element in sequence {
			if ... some condition { break }
		}
		
		for element in sequence {
			
		}
		
	自己写个例子
	
		class CountDown: Sequence, IteratorProtocol {
		    var count: Int
		    init(count: Int) {
		        self.count = count
		    }
		    func next() -> Int? {
		        if count == 0 {
		            return nil
		        } else {
		            defer {
		                count -= 1
		            }
		            return count
		        }
		    }
		}
		
		var countDown = CountDown(count: 5)
		print("begin for in 1")
		for c in countDown {
		    print(c)
		}
		print("end for in 1")
		print("begin for in 2")
		for c in countDown {
		    print(c)
		}
		print("end for in 2")
		// begin for in 1
		// 5
		// 4
		// 3
		// 2
		// 1
		// end for in 1
		// begin for in 2
		// end for in 2
		
37. 数组都实现了哪些协议
	
	MutableCollection, 实现了可修改的数组, 如 a[1] = 2
	
	ExpressibleByArrayLiteral, 实现了数组可以从[1, 2, 3]这种字面值初始化的能力
	
38. 如何自定义模式匹配
	
	http://swifter.tips/pattern-match/
	
39. autoclosure的作用

	自动闭包, 会自动将某一个表达式封装为闭包, 如
	
		func autoClosureFunction(_ closure: @autoclosure () -> Int) {
			closure()
		}
		autoClusureFunction(1)
		
	详细可参考http://swifter.tips/autoclosure/
	
40. 编译选项 whole module optmization 优化了什么

	编译器可以跨文件优化编译代码, 不局限于一个文件
	
	http://www.jianshu.com/p/8dbf2bb05a1c
	
41. 下面代码中nutating的作用是什么

		struct Person {
			var name: String {
				mutating get {
					return store
				}
			}
		}
	让不可变对象无法访问name属性

42. 如何让自定义对象支持字面量初始化

	有几个协议, 分别是
	
	ExpressibleByArrayLiteral 可以由数组形式初始化
	
	ExpressibleByDictionaryLiteral 可以由字典形式初始化
	
	ExpressibleByNilLiteral 可以由nil值初始化
	
	ExpressibleByIntergerLiteral 可以由整数值初始化
	
	ExpressibleByFloatLiteral 可以由浮点数初始化
	
	ExpressibleByBooleanLiteral 可以由bool值初始化
	
	// 下面三种都是由字符串初始化, 上面两种包含由Unicode字符和特殊字符
	
	ExpressibleByUnicodeScalarLiteral
	
	ExpressibleByExtendedGraphemeClusterLiteral
	
	ExpressibleByStringLiteral

43. dynamic framework 和 static framework的区别是什么

	静态库和动态库, 静态库是每一个程序单独打包一份, 而动态库则是多个程序之间共享
	
