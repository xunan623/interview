###UI视图

1. UITableView相关
2. 事件传递&视图响应(必考)
3. 图像显示原理
4. 卡顿&掉帧
5. 绘制原理&异步绘制
6. 离屏渲染

*****

###UITableView

**重用机制**

	cell = [tableView dequeueReusableCellWithIdentifier:identifer];
	
![重用池](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/UI视图/重用池.png)

**数据源同步**

1. 并发访问,数据拷贝

![并发访问数据,数据拷贝](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/UI视图/并发访问%2C数据拷贝.png)

2. 串行访问

**UIView和CALayer之间的关系**

关系:

![并发访问数据,数据拷贝](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/UI视图/UIView和CALayer关系.png)

区别:

1. UIView为其提供内容,以及负责触摸等事件,参与响应链
2. CALayer只负责显示内容Contents

**事件传递**

	- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;
	- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;

**视图事件响应**

	- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
	- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
	- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

**图像显示原理**

![图像显示原理](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/UI视图/图像显示原理.png)

**UI卡顿,掉帧的原因**

每一帧需要做的文字和图像的显示没有完成,会导致卡顿掉帧

![UI卡顿掉帧图解](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/UI视图/UI卡顿掉帧图解.png)

**卡顿,滑动优化方案**

1. CPU

	对象的创建,销毁,调整可放在子线程中实现
	
	预排版(布局,文本的计算)
	
	预渲染(文本等异步绘制,文本计算)
	
2. GPU

	纹理渲染
	
	视图混合
	
**UIView绘制原理**

![UIView异步绘制原理](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/UI视图/UIView异步绘制原理.png)

**系统绘制流程**

![系统绘制流程](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/UI视图/系统绘制流程.png)

**异步绘制**

![异步绘制](https://raw.githubusercontent.com/xunan623/xunan623.github.io/master/UI视图/异步绘制.png)

**离屏渲染**

- On-Screen Rendering (在屏渲染)

意为当前屏幕渲染,指的是GPU的渲染操作是在当前用于显得当前屏幕的缓冲区中进行

- Off-Screen Rendering (离屏渲染)

意为 GPU在当前屏幕的缓冲区以外新开辟的一个缓冲区进行渲染操作 (如圆角,遮罩)

**何时触发离屏渲染?**

1. 设置圆角(当和maskToBounds一起使用)
2. 图层蒙版
3. 阴影
4. 光栅化

**为何要避免离屏渲染?**

1. 离屏渲染会创建新的缓冲区会有内存的开销
2. 上下文的切换(GPU额外的开销)
