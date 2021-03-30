var age = 10

// swift3废弃 age++

let range = 1...3
for i in range {
    print(i)
}

for i in 0...3 {
    print("123")
}

// _代表可以忽略这个值
for _ in 0...3 {
    print("123")
}

let names = ["xunan", "zhangyang", "yufei"]
for i in 0...2 {
    print(names[i])
}

for name in names[0...2] {
    print(name)
}

for name in names[0...] {
    print(name)
}

// 默认是字符串
let str = "a"

// 如果想指定字符 则需要指定一下
let c: Character = "a"

// tickMark的取值:从4开始, 累加2, 不超过11
let hours = 11
let hourInterval = 2
for tickMark in stride(from: 4, through: hours, by: hourInterval) {
    print(tickMark)
}

// case, default后面不能写大括号{}
var number = 1
switch number {
case 1:
    print("number is 1")
default:
    print("number is other")
}

// 使用fallthrough可以实现贯穿效果
var numbers = 1
switch numbers {
case 1:
    print("number is 1")
    fallthrough
default:
    print("number is other")
}

let string = "Jack"
switch string {
case "Jack":
    print(string)
    fallthrough
case "Rose":
    print("Rose")
default:
    break
}

//switch age {
//case 1:
//case 2:
//    print("12")
//default:
//    break
//}

//let count = 62
//switch count {
//case 0:
//    print("0")
//case 1..<5:
//    print("1..<5")
//default:
//    break
//}


var numbersData = [1, 3, 6, 12]
var sum = 0
for num in numbersData where num > 3 { // 过滤
    sum += num
}
print(sum)


outer: for i in 1...4 {
    for j in 1...4 {
        if j == 2 {
            continue outer
        }
        if i == 3 {
            break outer
        }
        print("i == \(i), j == \(j)")
    }
}
