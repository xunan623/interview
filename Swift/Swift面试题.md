###Swift面试题

*****

###问题

1. class和struct的区别
2. 不通过继承, 代码复用的方式有哪些?
3. Set独有的方法有哪些?
4. 实现一个min函数, 返回两个元素较小的元素
5. map, filter, reduce的作用

	
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