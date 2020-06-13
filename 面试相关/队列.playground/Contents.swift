import UIKit

/// 队列 数组有些低效率 在移除的时候 每个数据需要向前移动 时间复杂度O(n)
public struct Queue<T> {
    
    /// 声明数组
    fileprivate var array = [T]()
    
    /// 数组是否为空
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    /// 数组Item数量
    public var count: Int {
        return array.count
    }
    
    /// 入队
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    /// 出队
    public mutating func dequeue() -> T? {
        print(array)
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    /// 取出队首元素(peek)
    public var front: T? {
        return array.first
    }
}

var queue = Queue<String>()
queue.enqueue("许楠")
queue.enqueue("A")
queue.enqueue("B")
queue.enqueue("C")

queue.dequeue()
queue.dequeue()

/// 更高效的队列
public struct FastQueue<T> {
    /// 声明数组
    fileprivate var array = [T?]()
    
    /// 指定头
    fileprivate var head = 0
        
    /// 是否为空
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var count: Int {
        return array.count - head
    }

    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return nil }
        
        array[head] = nil
        head += 1
        
        /// 当前游标是否1/4
        let precentage = Double(head)/Double(array.count)
        /// 数组数量是否>50
        if array.count > 50 && precentage > 0.25 {
            /// 移除head游标之前的数据
            array.removeFirst(head)
            head = 0
        }
        return element
    }
    
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}

var q = FastQueue<String>()
q.array

q.enqueue("1")
q.enqueue("2")
q.enqueue("3")
q.enqueue("4")

q.dequeue()
q.array
q.count

q.dequeue()
q.array
q.count

q.enqueue("x")
q.array
q.count


/// 链表

/// 描述节点
public class LinkedListMode<T> {
    var value: T
    var next: LinkedListMode?
    weak var previous: LinkedListMode?
    
    public init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    /// 节点
    public typealias Node = LinkedListMode<T>
    
    /// 头节点
    private var head: Node?
    
    /// 是否为空指针
    public var isEmpty: Bool {
        return head == nil
    }
    
    /// 头结点
    public var first: Node? {
        return head
    }
    
    /// 尾部
    public var last: Node? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    /// 添加一个节点
    public func append(value: T) {
        /// 创建一个新的节点
        let newNode = Node(value: value)
        
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else { /// 如果没有这样的节点，链表仍然是空的，我们使head指向这个新的Node
            head = newNode
        }
    }
    
    /// 计算链表中有多少个节点
    public var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    /// 链表中特定索引出找到节点
    public func node(atIndex index: Int) -> Node {
        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }
            return node!
        }
    }
    
    /// 获取下标方法
    public subscript(index: Int) -> T {
        let currentNode = node(atIndex: index)
        return currentNode.value
    }
    
    /// 在链表中的任何索引处插入新节点
    public func insert(_ node: Node, at index: Int) {
        let newNode = node
        if index == 0 {
            newNode.next = head
            head?.previous = newNode
            head = newNode
        } else {
            let prev = self.node(atIndex: index - 1)
            let next = prev.next
            
            newNode.previous = prev
            newNode.next = prev.next
            
            prev.next = newNode
            next?.previous = newNode
        }
    }
    
    /// 删除全部节点
    public func removeAll() {
        head = nil
    }
    
    /// 删除单个节点(传入node)
    public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    /// 删除最后一个节点
    public func removeLast() -> T {
        assert(!isEmpty)
        return remove(node: last!)
    }
    
    /// 删除单个节点(传入index索引)
    public func remove(at index: Int) -> T {
        let node = self.node(atIndex: index)
        return remove(node: node)
    }
    
    /// 链表反转
    public func reverse() {
        var node = head
//        tail = node           // If you had a tail pointer
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
        }
    }
    
    /// 链表的的map
    public func map<U>(transform: (T) -> U) -> LinkedList<U> {
        let result = LinkedList<U>()
        var node = head
        while node != nil {
            result.append(value: transform(node!.value))
            node = node!.next
        }
        return result
    }
    
    /// 链表filter
    public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
        let result = LinkedList<T>()
        var node = head
        while node != nil {
            if predicate(node!.value) {
                result.append(value: node!.value)
            }
            node = node!.next
        }
        return result
    }
    
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil { s += "," }
        }
        return s + "]"
    }
}

let list = LinkedList<String>()
/// true
list.isEmpty
/// nil
list.first

/// 增加一个节点
list.append(value: "Hello")
list.isEmpty  /// false
list.first!.value /// "Hello"
list.last!.value /// "Hello"

/// 增加第二个节点
list.append(value: "World")
list.first?.value /// "Hello"
list.last?.value /// "World"

list.first?.previous  /// nil
list.first?.next?.value /// "World"
list.last?.previous?.value /// "Hello"
list.last?.next /// nil


list.node(atIndex: 0).value
list.node(atIndex: 1).value
//list.node(atIndex: 2).value /// crash


list[0]
list[1]
//list[2] /// crash

/// 插入
list.insert(LinkedListMode(value: "Insert"), at: 1)
list[0]
list[1]
list[2]
print(list)

/// 删除
list.remove(node: list.first!)
list.count
list[0]
list[1]
print(list)
list.removeLast()
list[0]
list.count
list.remove(at: 0)
list.count
print(list)

let mapList = LinkedList<String>()
mapList.append(value: "1")
mapList.append(value: "22")
mapList.append(value: "333")

let m = mapList.map { s in s.count }
print(m)

let f = mapList.filter { s in s.count > 2 }
print(f)
