
var str: String = "123"

func test() {
    var age: Int?
    age = 10
    print(age)
}
test()

var array = [1, 15, 50, 23]
func get(_ index: Int) -> Int? {
    if index < 0 || index >= array.count {
        return nil
    }
    return array[index]
}
print(get(0))


var height: Int? = 10

var num = height! + 20
print(num)


let number = Int("123")
if number != nil {
    print("字符串转换成功: \(number!)")
} else {
    print("字符串转换成Int")
}


// 可选项绑定
if let number = Int("123") {
    print("字符串转换成功: \(number)")
} else {
    print("字符串转换失败")
}


let a: Int? = 1
let b: Int? = 2
let c = a ?? b
print(c)

let a1: Int? = nil
let b1: Int? = 2
let c1 = a1 ?? b1
print(c1)

let a2: Int? = nil
let b2: Int? = nil
let c2 = a2 ?? b2
print(c2)


// b3不是可选项 如果返回的是a3 则a3自动解包 变成了 c3!
let a3: Int? = 1
let b3: Int = 2
let c3 = a3 ?? b3
print(c3)

// 隐式解包的可选项
let numX: Int! = 10
let numX1: Int = numX
