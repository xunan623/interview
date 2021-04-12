let a = 10
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
