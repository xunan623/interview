//
//  main.swift
//  TestSwift
//
//  Created by xunan on 2021/3/29.
//

import Foundation


var a = 10


print("Hello, World! \(a)")

// 输入输出参数, 可以在函数内部修改外部的值
var number = 10
func outAdd(_ num: inout Int) {
    num = 20
}
outAdd(&number)


var mutableArray = [1, 2, 3]
for _ in mutableArray {
    print(mutableArray)
    mutableArray.removeLast()
}
print(mutableArray)


extension Array where Element == String {
    var isStringElement: Bool {
        return true
    }
}

print(["1", "2"].isStringElement)


class AnotherClass {
    static func staticMethod() {}
    class func classMethod() {}
}

class ChildAnotherClass: AnotherClass {
    override class func classMethod() {
        
    }
}

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


func fib(n: Int) -> Int {
    switch n {
    case 0:
        return 0
    case 1:
        return 1
    case 2:
        return 1
    case 3:
        return 2
    default:
        return fib(n: n - 1) + fib(n: n - 2) + fib(n: n - 3)
    }
}

print(fib(n: 25))

func tfib(n: Int) -> Int {
    if n < 3 {
        return n == 0 ? 0 : 1
    }
    var temp: Int, x = 0, y = 1, z = 1
    for _ in 3...n {
        temp = x + y + z
        x = y
        y = z
        z = temp
    }
    return z
}

print(tfib(n: 25))
