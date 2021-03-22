##RunLoop

1. 概念
2. 数据结构
3. 事件循环机制
4. RunLoop与NSTimer
5. RunLoop与多线程

****

###概念

什么是RunLoop?

RunLoop是通过内部维护的事件循环来对事件/消息进行管理的一个对象.

事件循环:

	1. 没有消息需要处理时,休眠以避免资源占用
	   用户态--->内核态
	2. 有消息需要处理时,立刻被唤醒.
	   内核态--->用户态

	
mian函数为什么不退出,可以一直运行:

	UIApplicationMain函数内部会启动主线程的RunLoop,而RunLoop又是对事件循环的一种维护机制,可以做到在有事做的时候做事,没事做的时候由用户态到内核态的切换,从而避免资源的占用,当前线程的休眠状态.
	
###数据结构

NSRunLoop是CFRunLoop的封装,提供了面向对象的API

	1. CFRunLoop
	2. CFRunLoopMode
	3. Source/Timer/Observer
CFRunLoop包含:
	
	1. pthread  --------> 一一对应(RunLoop和线程的关系)
	2. currentMode  ------> CFRunLoopMode
	3. modes		-----> NSMutableSet<CFRunLoopMode *>
	4. commonModes -----> NSMutableSet<NSString *>
	5. commonModeItems -----> {Observer, Timer, Source}
CFRunLoopMode包含:

	1. name  --------> NSDefaultRunLoopMode
	2. sources0  -------> MutableSet 
	3. sources1  -------> MutableSet
	4. Observers -------> MutableArray
	5. Timers	 -------> MutableArray
CFRunLoopSource
	
1. source0

	需要手动唤醒线程
	
2. source1

	具备唤醒线程的能力

CFRunLoopTimer 

1. 基于事件的定时器
2. NSTimer是toll-free bridged的.

CFRunLoopObserver观测时间点:

1. kCFRunLoopEntry
2. kCFRunLoopBeforeTimers
3. kCFRunLoopBeforeSources
4. kCFRunLoopBeforeWaiting
5. kCFRunLoopAfterWaiting
6. kCFRunLoopExit

![各个数据结构直之间的关系](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunLoop/各个数据结构直之间的关系.png)

RunLoop的Mode:

![RunLoop的Mode](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunLoop/RunLoop的Mode.png)

###事件循环的实现机制

![事件循环的实现机制](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunLoop/事件循环的实现机制.png)

![RunLoop的核心](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/RunLoop/RunLoop的核心.png)

###RunLoop与NSTimer

问:滑动TableView的时候我们的定时器还会生效吗?

	kCFRunLoopDefaultMode ----mode发生切换-------> UITackingRunLoopMode
	
	答案:失效
	解决办法:
	将timer添加到多个mode上去
	void CFRunLoopAddTimer(runLoop, timer, commonMode)
	
###RunLoop与多线程

线程是和RunLoop一一对应的

自己创建的线程默认是没有RunLoop的

RunLoop保存在一个全局的NSDictionary里,线程作为key,RunLoop作为Value

**怎样实现一个常驻线程?**
	
	1. 为当前线程开启一个RunLoop
	2. 向该RunLoop中添加一个Port/Source等维持RunLoop的事件循环.
	3. 启动该RunLoop.


总结:

**怎样保证子线程数据回来更新UI的时候不打断用户的滑动操作?**

滑动是在UITackingRunLoopMode  子线程包装放在主线程kCFRunLoopDefaultMode下


****

##李明杰RunLoop

1. 讲讲RunLoop,项目中有用到吗?
2. RunLoop的内部实现逻辑?
3. RUnLoop和线程有什么样的关系?
4. timer和RunLoop的关系?
5. 程序中每3s响应一次NSTimer,当拖动TableView时Timer可能无法响应怎么解决?
6. RunLoop是怎么想用用户操作的,具体流程是什么样的?
7. 说说RunLoop的几种状态
8. RunLoop的mode作用是什么?


