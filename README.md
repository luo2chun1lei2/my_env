# my_shell

my_shell缩写为“mysh”，用于辅助管理开发环境。

## 功能
* 必须向前兼容。
* 设置规定好的开发环境，比如环境变量。
* 自动加入这个环境可以用到的脚本，允许用户自己定制。
* 显示当前环境的状态，允许用户定制显示的状态。

## 想要的功能
* 跟踪某些资料（比如文件、工具）的信息。技术和方法需要再思考。

## 如何使用

需要创建的文件路径

~/bin/setting
├── common
│   └── setting.sh
└── sp3136 <-- 自己定义的名称
    └── setting.sh

## 内部结构

1. 先分析命令参数。
2. 再根据命令去初始化各种内部环境。
3. 然后再根据用户的设定，来初始化环境和调用他自己的脚本。
4. 允许用户定制自己的脚本。

### 用户可以配置的项目
用户可以设定自己需要的初始化环境，以及可以使用的脚本。
然后定义自己的环境变量。

### 内部的版本管理机制
此软件为了支持向后兼容性，比如说之前的脚本，后面也将支持。
但是后面的设计肯定会和之前的不同，或者更多、或者更少。
所以必须提供脚本的版本管理，每个制定版本的脚本就按照此版本的体系运行。
