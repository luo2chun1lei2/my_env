# my_shell

my_shell缩写为“mysh”，用于辅助管理使用环境。

## 需求
【描述对此软件的需要，可以是具体的，也可以是抽象的，最好是抽象的，这样有多种功能实现余地】
【对于需求的描述，需要如实记录，后面要进行整理，不能出现缺漏和矛盾的地方】

* 进入某个环境（可以是文件夹、制定的名字）后，
  * 设置规定好的开发环境，比如环境变量。
  * 自动加入这个环境可以用到的脚本，允许用户自己定制。
  * 可以添加一些目标（比如文件、文件夹）的标签，并且显示允许的操作（有点类似于鼠标右键）。
  * 显示当前环境的状态，允许用户定制显示的状态。

### 额外需求
* 针对Ubuntu系统，最好普适 Linux 系统。
* 必须向前兼容。
* 不影响到系统正常操作。

## 实现需求的功能
【这里描述实现需求的具体功能，一般只涉及到用户的动作和系统的反应，不包括技术如何实现，形成功能架构】
【对于功能的描述，要尽量采用完整的、可靠的、明确的、不矛盾的概念，比如说文件、服务器、画面等等，如果可以还要加入一些额外的要求，
错误处理、可靠性的具体要求等】

## 实现功能的框架、技术和模块
【这里描述实现上面功能的架构，形成系统架构，包括软硬件。】
【对于框架等描述，要按照标准的软硬件模型来描述，比如UML，不要用模糊的语义来说明。
需要知道如何划分模块，定义模块之间的接口，已经模块的技术实现方法】

针对目标（文件夹、文件等）的配置
name -------------+--> myenv
directory/file ---+

从此目录向上，找到的存在 .myenv 的配置。

.myenv  -+-- setting.sh   自己的配置
         +-- bin/         自定义的脚本
         +-- map_name_path  name和path之间的映射【用户配置】
         +-- config.sh    特定配置【用户配置】

1. 每个目标都可以有自己的设置。
2. 目标可以根据文件树形成包含关系。
   目标上面只有一个父。父可以有多个子。
3. 当前环境(myenv)在哪个目标内，就具有什么样的环境。

### 启动流程
1. 先分析命令参数。
2. 再根据命令去初始化各种内部环境。
3. 然后再根据用户的设定，来初始化环境和调用他自己的脚本。
4. 允许用户定制自己的脚本。

### 用户可以配置的项目
用户可以设定自己需要的初始化环境，以及可以使用的脚本。
然后定义自己的环境变量。
客户环境中的文件，工具只负责生成，而不要输入缺省的设置。

### 内部的版本管理机制
此软件为了支持向后兼容性，比如说之前的脚本，后面也将支持。
但是后面的设计肯定会和之前的不同，或者更多、或者更少。
所以必须提供脚本的版本管理，每个制定版本的脚本就按照此版本的体系运行。

## 实现软件的支撑系统
【这里描述实现上面的系统时，需要提供的支撑系统，比如代码管理、开发平台、调试和测试平台、实施和维护方法，以及人员管理流程等，总之是围绕实现系统的周边系统】
