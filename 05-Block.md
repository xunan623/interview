##Block

1. Block介绍
2. 截获变量
3. __block修饰符
4. Block的内存管理
5. Block的循环引用

****

###什么是Block

Block是将函数及其执行上下文封装起来的对象.

		{
			int multiplier = 6;
			int(^Block)(int) = ^int(int num) {
				return num * multiplier;
			}
			Block(2); // 12
		}

###截获变量

1. 局部变量
	1. 基本数据类型(截获其值)
	2. 对象类型(连同所有权修饰符一起截获)
2. 静态局部变量(指针形式截获)
3. 全局变量(不截获)
4. 静态全局变量(不截获)

###__block修饰符

1. 一般情况下,对被截获变量进行赋值操作需添加__block修饰符
2. 赋值不等于使用

		{
			// 只是使用 没问题 不需要__block
			NSMutableArray *array = [NSMutableArray array];
			void(^Block)(void) = ^{
				[array addObject:@123];
			}
			Block();
		}
		
		{
			// 赋值 会报错 需要赋值添加 __block
			NSMutableArray *array = nil;
			void(^Block)(void) = ^{
				array = [NSMutableArray array];
			}
			Block();
		}
		
1. 局部变量
	1. 基本数据类型(需要__block修饰符)
	2. 对象类型(需要__block修饰符)

2. 静态局部变量(不需要__block)
3. 全局变量(不需要__block)
4. 静态全局变量(不需要__block)

__block相关面试题:

	{
		__block int multiplier = 6;
		int(^Block)(int) = ^int(int num) {
			return num * multiplier;
		}
		Block(2); // 8
	}
	
__block修饰的变量变成了对象

###Block的内存管理

![Block的Copy操作](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/Block/Block的Copy操作.png)

栈上Block的销毁

![栈上Block的销毁](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/Block/栈上Block的销毁.png)

问题:在MRC下使用block拷贝栈上的对象会引起内存泄露吗?

会

![__block之后](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/Block/__block之后.png)

__forwarding总结:

	{
		__block int multiplier = 10;
		_blk = ^int(int num) {
			return num * multiplier;
		}
		multiplier = 6;
		[self executeBlock];
	}
	
	- (void)executeBlock {
		int result = _blk(4);
		NSLog(@"result is %d", reuslt); // 24
	}
	
__forwarding存在的意义

1. 不论在任何内存位置,都可以顺利的访问同一个__block变量


###Block的循环引用

	// 问题
	{
		_array = [NSMutableArray arrayWithObject:@"block"];
		_strBlk = ^NSString *(NSString *num) {
			return [NSString stringWithFormat:@"helloc_%@", array[0]];
		}
		_strBlk(@"hello"); // 会循环引用
	}
	
	// 答案
	{
		_array = [NSMutableArray arrayWithObject:@"block"];
		__weak NSArray *weakArray = _array;
		_strBlk = ^NSString *(NSString *num) {
			return [NSString stringWithFormat:@"helloc_%@", weakArray[0]];
		}
		_strBlk(@"hello");
	}
	
	问题
	{
		__block MCBlock *blockSelf = self;
		_blk = ^int(int num) {
			// var = 2
			return num * blockSelf.var;
		}
		_blk(3);
	}
	
	答案:
	MRC下不会产生循环引用
	ARC下会产生循环引用,内存泄露

	{
		__block MCBlock *blockSelf = self;
		_blk = ^int(int num) {
			// var = 2
			int result = num * blockSelf.var;
			blockSelf = nil;
			return result;
		}
		// 调用会解环, 不调用就会一直有环存在
		_blk(3);
	}

