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


