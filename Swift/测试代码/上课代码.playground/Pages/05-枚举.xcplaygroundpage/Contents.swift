

var age = 10

MemoryLayout<Int>.size
MemoryLayout<Int>.stride
// 内存对齐
MemoryLayout<Int>.alignment

MemoryLayout.size(ofValue: age)
MemoryLayout.stride(ofValue: age)

enum Password {
    case number(Int, Int, Int, Int)
    case other
}
var pwd = Password.number(5, 6, 7, 8)
pwd = .other
MemoryLayout<Password>.size // 33 实际用到的空间大小
MemoryLayout<Password>.stride // 40 分配占用空间大小
// 内存对齐
MemoryLayout<Password>.alignment // 8 对齐参数



