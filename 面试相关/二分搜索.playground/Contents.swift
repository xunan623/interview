import UIKit

/// 二分搜索

/// 目标:在数组中快速寻找一个元素
let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]
numbers.firstIndex(of: 43)

/// 内置的indexOf() s函数执行的是线性搜索 代码大概:
func linearSearch<T: Equatable>(_ a: [T], _ key: T) -> Int? {
    for i in 0..<a.count {
        if a[i] == key {
            return i
        }
    }
    return nil
}

/// 如果数据量比较大的数组 大概率在中间 会非常耗性能
linearSearch(numbers, 43)

/// 二分搜索递归实现
func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        /// 如果走到这, 搜索关键字没有出现在这个数组中
        return nil
    } else {
        print(range.lowerBound, range.upperBound)
        /// 计算从哪分割数组
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        print(midIndex)

        /// 搜索keys是不是在左边的一半
        if a[midIndex] > key {
            return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)
        } else if a[midIndex] < key {
            return binarySearch(a, key: key, range: midIndex + 1 ..< range.upperBound)
        } else {
            return midIndex
        }
    }
}

let binaryNumbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
binarySearch(binaryNumbers, key: 43, range: 0 ..< binaryNumbers.count)  // gives 13

/// 二分搜索迭代实现
func binaryWSearch<T: Comparable>(_ a: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (lowerBound + upperBound) / 2
        if a[midIndex] == key {
            return midIndex
        } else if a[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return nil
}

let binaryWNumbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
binarySearch(binaryWNumbers, key: 43, range: 0 ..< binaryWNumbers.count)  // gives 13



/// 二叉搜索树(或者叫二分搜索树) 是一种特殊的二叉树(每个节点最多有两个子节点), 它执行插入和删除,以便始终对数进行排序
public class BinarySearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?

    public init(value: T) {
        self.value = value
    }
    
    /// 是否是根节点
    public var isRoot: Bool {
        return parent == nil
    }
    
    /// 是否是叶节点
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    /// 是否是左子节点
    public var isLeftChid: Bool {
        return parent?.left === self
    }
    
    /// 是否是右子节点
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    /// 是否有左子节点
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    /// 是否有右子节点
    public var hasRightChild: Bool {
        return right != nil
    }
    
    /// 是否有子节点
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    /// 是否左右两个子节点都有
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    /// 当前节点包括子数中的所有节点总数
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    /// 插入节点
    public func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            } else {
                left = BinarySearchTree(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }
    
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }
    
    /// 搜索
    
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <-"
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
}

let tree = BinarySearchTree<Int>(value: 7)
tree.insert(value: 2)
tree.insert(value: 5)
tree.insert(value: 10)
tree.insert(value: 9)
tree.insert(value: 1)

let treeNode = BinarySearchTree<Int>(array: [7, 2, 5, 10, 9, 1])
print(treeNode)
