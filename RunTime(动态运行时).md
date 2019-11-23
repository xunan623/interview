###RunTime(动态运行时)

1. 数据结构
2. 类对象与元类对象
3. 消息传递
4. 方法缓存
5. 消息转发
6. Method-Swizzling(方法混淆)
7. 动态添加方法
8. 动态方法解析

*****

###数据结构

- objc_object
- objc_class
- isa指针
- method_t

**objc_object**

![objc_object](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/objc_object.png)

**objc_class**

![objc_class](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/objc_class.png)

**isa指针**

![isa](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/isa.png)

**isa指向**

1. 关于对象,其指向类对象

	实例----isa---->Class
	
2. 关于类对象,其指向元类对象

	Class----isa----->MetaClass
	
**cache_t**

1. 用于快速查找方法执行函数
2. 可增量扩展的哈希表结构
3. 局部性原理的最佳应用

![objc_cache_t](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/cache_t.png)

**class_data_bits_t**

1. class_data_bits_t主要是对class_rw_t的封装
2. class_rw_t代表了类相关的读写信息,对class_ro_t的封装
3. class_ro_t代表了类相关的只读信息

**class_rw_t**

![class_rw_t](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/class_rw_t.png)

**class_ro_t**

![class_ro_t](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/class_ro_t.png)

**method_t**

函数四要素:名称,返回值,参数,函数体

![method_t](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/method_t.png)

**TypeEncodings**

![TypeEncodings](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/TypeEncodings.png)


**整体数据结构**

![数据结构](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/数据结构.png)

###对象,类对象,元类对象

1. 类对象:存储实例方法列表等信息.
2. 元类对象:存储类方法列表等信息.

![类对象元类对象](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/类对象元类对象.png)

**笔试题**
![查找父类面试题](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/查找父类面试题.png)

**消息传递**

void objc_msgSend(void /* id self, SEL op, ... */)

[self class] <====> objc_msgSend(void /* id self, SEL op, ... */)

void objc_msgSendSuper(void /* struct objc_super *super, SEL op, ... */)

struct objc_super {
	__unsafe_unretained id receiver;
}

[super class] <====> objc_msgSendSuper(super, @selector(class))

 ![消息传递](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/消息传递.png)

**缓存查找**

给定值是SEL,目标值是对应bucket_t中的IMP

cache_key_t ---f(key)---> bucket_t 

答案:哈希查找 f(key) = key & mask

**当前类中查找**

对于已排序好的列表,采用二分查找算法查找方法对应的执行函数.

对于没有排序的列表,采用一般遍历查找方法对应执行函数.

**父类逐级查找**

 ![父类逐级查找](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/父类逐级查找.png)

**消息转发流程**

实例方法的转发流程:

 ![消息转发流程](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/消息转发流程.png)

**方法交换**

 ![消息转发流程](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunTime/method_swizzing.png)

**动态添加方法**

问: 使用过performSelector:吗?

**动态方法解析**

@dynamic  setting getting 在运行时

1. 动态运行时语言将函数决议推迟到运行时
2. 编译时语言在编译期进行函数决议.

**RunTime实战**

1. [obj foo]和objc_msgSend()函数之间有什么关系?
2. runtime如何通过Selector找到对应的IMP地址的?
3. 能否向编译后的类中添加实例变量? 不能

