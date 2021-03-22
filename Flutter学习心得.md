##Flutter学习心得

###创建自己的package到pub.dev?

1.创建package工程
进入自己的项目目录上一级

flutter create --template=package PopupMenuUtils

2.添加License和修改pubspec.yaml文件

3.发布校验
 flutter pub publish --dry-run

4.发布
 flutter pub publish
  
 此刻可能碰到两个错误 
 
 一种可能是没有翻墙
 
 
 
 上传pub的时候一直报错
 
Looks great! Are you ready to upload your package (y/n)? y
Uploading...
Failed to upload the package.
pub finished with exit code 1

说明有网络 但是没有权限

sudo flutter pub publish



## Tabbar抖动问题

CustomTabBar-master

## 侧滑删除

flutter_sunny_demo-master