
import Foundation

var block = {
    (v1: Int, v2: Int) -> Int in
    return v1 + v2
}
block(10, 20)



// 太秀了
func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
    print(fn(v1, v2))
}

exec(v1: 10, v2: 20) { (v1: Int, v2: Int) -> Int in
    return v1 + v2
}

exec(v1: 10, v2: 20) {
    v1, v2 in return v1 + v2
}

exec(v1: 10, v2: 20) {
    v1, v2 in v1 + v2
}

// $0:第一个参数 $1:第二个参数
exec(v1: 10, v2: 20) { $0 + $1}

// $0:第一个参数 $1:第二个参数
exec(v1: 10, v2: 20, fn: +)
