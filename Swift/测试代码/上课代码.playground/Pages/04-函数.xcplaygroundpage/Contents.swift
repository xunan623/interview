
func pi() -> Double {
    return 3.14
}

pi()

func sum(v1: Int, v2: Int) -> Int {
    return v1 + v2
}

sum(v1: 3, v2: 6)

func calculate(v1: Int, v2: Int) -> (sum: Int, difference: Int, average: Int) {
    let sum = v1 + v2
    return (sum, v1 - v2, sum >> 1)
}

let result = calculate(v1: 20, v2: 10)
result.sum
result.difference
result.average


/// <#Description#>
/// - Parameters:
///   - v1: <#v1 description#>
///   - v2: <#v2 description#>
/// - Returns: <#description#>
func sums(v1: Int, v2: Int) -> Int { v1 + v2}
sums(v1: 10, v2: 20)

// 可以修改参数标签 at形参 给外部使用 time实际参数 供内部使用
func goToWork(at time: String) {
    print("this time \(time)")
}
goToWork(at: "08:00")

func sumArgument(_ v1: Int, _ v2: Int) -> Int {
    v1 + v2
}
sumArgument(10, 20)

// 参数可以有默认值
func check(name: String = "nobody", age: Int, job: String = "none") {
    print("name=\(name), age=\(age), job=\(job)")
}
check(age: 30)

// C++的默认参数值有个限制:必须从右往左设置. 由于Swift拥有参数标签, 因此没有此类的限制


//
func test(_ first: Int = 10, middle: Int, _ last: Int = 30) {
    print("first = \(first) middle = \(middle) last = \(last)")
}
test(middle: 20)


func sum(_ numbers: Int...) -> Int {
    var total = 0
    for number in numbers {
        total += number
    }
    return total
}
sum(10, 20, 30, 40) // 100

// 紧跟在可变参数后面的参数不能省略参数标签
func changeTest(_ numbers: Int..., string: String, _ other: String) {
    print("\(numbers) " + string + other)
}
changeTest(10, 20, 30 , 40, string: "Jack", "Rose")


// 输入输出参数, 可以在函数内部修改外部的值
var number = 10
func outAdd(_ num: inout Int) {
    num = 20
}
outAdd(&number)


func sumR(v1: Int, v2: Int) -> Int {
    v1 + v2
}

func sumR(v1: Int, v2: Int, v3: Int = 10) -> Int {
    v1 + v2 + v3
}

sumR(v1: 10, v2: 20)



// 函数类型
func sumCovert(a: Int, b: Int) -> Int {
    a + b
}
// 当成变量 标签不用写
var fn: (Int, Int) -> Int = sumCovert
print(fn(2, 3))


//函数类型作为函数参数
func sumx(v1: Int, v2: Int) -> Int {
    v1 + v2
}
func difference(v1: Int, v2: Int) -> Int {
    v1 - v2
}
func printResult(_ mathFn: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFn(a, b))")
}
printResult(sumx, 5, 2)
printResult(difference, 5, 2)

func forward(_ forward: Bool) -> (Int) -> Int {
    func next(_ input: Int) -> Int {
        input + 1
    }
    func previous(_ input: Int) -> Int {
        input - 1
    }
    return forward ? next : previous
}
forward(true)(3)
forward(false)(3)


// 永远不会被内联(即使开启了编译器优化)
@inline(never) func test() {
    print("test")
}

// 开启了编译器优化, 即使代码很长,也会被内联(递归调用函数,动态派发函数除外)
@inline(__always) func test1() {
    print("test1")
}
