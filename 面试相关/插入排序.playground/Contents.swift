import UIKit

/// 把数组从低到高(或从高到低)排序  插入排序

/// 原地排序:在排序过程中不申请多余的存储空间,只利用原来存储待排数据的存储空间进行比较和交换的数据排序. 包括:希尔排序、冒泡排序、选择排序、堆排序、快速排序

/// [8, 3, 5, 4, 6]
/// 交换的方式
func insertionSort(_ array: [Int]) -> [Int] {
    var a = array           /// 1
    
    for x in 1..<a.count {  /// 2
        print("x:%zd", x)
        var y = x
        while y > 0 && a[y] < a[y-1] { /// 3
            a.swapAt(y-1, y)
            y -= 1
            print("y:%zd", y)
        }
    }
    
    return a
}

let list = [8, 3, 5, 4, 6]
insertionSort(list)

/// 不交换 移除swap()的调度提升速度
func insertionUpdateSort(_ array: [Int]) -> [Int] {
    var a = array
    
    for x in 1..<a.count {
        var y = x
        let temp = a[y]
        while y > 0 && temp > a[y-1] {
            a[y] = a[y-1]
            y -= 1
        }
        a[y] = temp
    }
    
    return a
}
let list1 = [8, 3, 5, 4, 6]
insertionUpdateSort(list1)

