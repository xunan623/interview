import UIKit

var str = "Hello, playground"

import UIKit
import PlaygroundSupport

let view = UIView.init()
view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
view.backgroundColor = UIColor.red
PlaygroundPage.current.liveView = view

let imageView = UIImageView(image: UIImage(named: "logo"))
PlaygroundPage.current.liveView = imageView

let vc = UITableViewController()
vc.view.backgroundColor = UIColor.red
PlaygroundPage.current.liveView = vc
