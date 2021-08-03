
import UIKit
import Foundation

var a = 10
let b = 20
var c = a + b
print(c)


var array = [10,2, 32, 56, 1, 90]
array.sort()

array.sort { (a1, a2) -> Bool in
    return a1 > a2
}


func fn() -> () -> () {

    func fn1() {
        print("hello world")
    }
    
    return fn1
}


typealias Fn = (Int) -> Int

func getFn() -> Fn {
    var num = 0
    func plus(_ i: Int) -> Int {
        num += i
        return num
    }
    return plus
}

var fc = getFn()
print(fc(1))
print(fc(2))
print(fc(3))
print(fc(4))


[1, 2, 3].reduce(""){$0 + "\($1)"}


print((0 ..< 10).filter { $0 % 2 == 0 }.map { "\($0)" }.reduce(""){$0 + $1})

print(["1", "@", "2", "3", "a"].compactMap{Int($0)})


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

func swap(a: inout Int, b: inout Int) {
    let temp = a
    a = b
    b = temp
}
var ax = 1
var bx = 2
swap(a: &ax, b: &bx)


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
