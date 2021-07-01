# my_env

my_env 缩写为“myenv”，用于辅助管理使用环境。
其中用于调用各种命令的执行，叫做 mysh (=my shell)。

.bashrc 中加入
export PATH=$PATH:/..../my_env
source /..../my_env/myenv.complete

## 需求
【描述对此软件的需要，可以是具体的，也可以是抽象的，最好是抽象的，这样有多种功能实现余地】
【对于需求的描述，需要如实记录，后面要进行整理，不能出现缺漏和矛盾的地方】

* 进入某个环境（可以是文件夹、指定的名字）后，
  * 设置规定好的开发环境，比如环境变量。
  * 自动加入这个环境可以用到的脚本，允许用户自己定制。
  * 可以添加一些目标（比如文件、文件夹）的标签，并且显示允许的操作（有点类似于鼠标右键）。
  * 显示当前环境的状态，允许用户定制显示的状态。
  * 可以导入和使用不同机器的“环境”。

### 额外需求
* 针对Ubuntu系统，最好普适 Linux 系统。
* 必须向前兼容。
* 尽量不影响到原有系统的操作。

## 实现需求的功能
【这里描述实现需求的具体功能，一般只涉及到用户的动作和系统的反应，不包括技术如何实现，形成功能架构】
【对于功能的描述，要尽量采用完整的、可靠的、明确的、不矛盾的概念，比如说文件、服务器、画面等等，如果可以还要加入一些额外的要求，
错误处理、可靠性的具体要求等】

1. 有一个工具，可以进入到“环境”中。
2. 环境中按照目录或者名字来区分，用名字来区分是针对那种没有特定目录，但是有特定功能的情况，
	比如计算处理等等。
3. 用户可以定制自己的某个环境，
	1. 能够显示“状态”，状态是某个目标的 state，最好是实时的，如果不行，那么可以在必要操作时显示最新的情况。
		用户可以自己添加需要观察的状态，最好是不花费大量时间的，否则每次都花费大量时间，是无法正常操作的。
		比如 git status、internet status之类的。这个只能异步操作才可以。
	2. 能够允许用户加入自己在此环境中需要的脚本和命令。
	3. 允许用户自行导入其他环境的脚本和命令。（这个是一个复杂的功能，目前最好只给一个简单的方法。）
		1. 环境一可以直接导入环境二的脚本和命令。 <-- 会有多份代码，最后很难统一脚本。
		2. 环境一可以直接使用环境二的脚本和命令。 <-- 不用多份代码维护，和方便$HOME/.myenv 影响其他所有的环境。
4. 可以设置环境中的某个特定目标的动作，仿效图形界面中的右键，这样方便工作。
	这个功能并不是用于替代脚本，脚本的高效是目前最好的解决方案。
	本功能主要是“方便调用脚本”，并且提醒用户这个目标的状态和有哪些可以执行的动作。

## 实现功能的框架、技术和模块
【这里描述实现上面功能的架构，形成系统架构，包括软硬件。】
【对于框架等描述，要按照标准的软硬件模型来描述，比如UML，不要用模糊的语义来说明。
需要知道如何划分模块，定义模块之间的接口，已经模块的技术实现方法】

### 环境的模型

环境是一个运行的环境，可以设定编程、工具需要的环境变量、函数和程序。
并且环境可以显示某些对象的状态。
### 环境和名字

针对目标（文件夹、文件等）的配置
1. name/path/nearest --> .myenv --> config

nearest: 从当前目录向上，找到存在 .myenv 的目录

### 脚本和配置

bin/ 	独立可运行的程序
source/ 需要source 包含的程序，比如function等。

tool
	+-- private/     内部使用的代码。
	    +-- bin/
        +-- source/
	+-- public/      可以外部使用的代码。
	    +-- bin/
        +-- source/
    +-- subcmd/      子命令的实现
	    +-- bin/
        +-- source/

.myenv  
	+-- kind   		类型
	+-- config.sh   配置
	+-- bin/ 		用户自定义的
    +-- source/		用户自定义的
    +-- data/        自定义的数据在里面
		+-- map-name-env/  名字和环境的映射

### 工具
1. myenv 主要是创建、管理、进入环境，为了不影响当前的环境，用一个进程实现。
2. mysh 执行命令，为了能够影响到内部的变量（比如 cd 等操作），是一个 function 来实现的。
	但是它可以执行一个内部的function，或者外部的一个进程。
	为了不影响内部的环境，尽量使用外部的进程实现功能。

### 启动流程
1. 先分析命令参数。
2. 根据命令指定的版本，去初始化各种内部环境。【版本】
3. 根据用户的设定，按照版本来初始化环境。【自动的构造过程】
4. 最后读取用户定制自己的脚本。【定制】

### 用户可以配置的项目
用户可以设定自己需要的初始化环境，以及可以使用的脚本。
然后定义自己的环境变量。
客户环境中的文件，工具只负责生成，而不要输入缺省的设置。

### 内部的类别（kind）管理机制
这里不再说 version，因为版本有升级的暗示，而此程序要求必须兼容。
所以只按照实现的方式来区分“类别”（kind），代表了一种实现的方案。

此软件为了支持向后兼容性，比如说之前的脚本，后面也将支持。
但是后面的设计肯定会和之前的不同，或者更多、或者更少。
所以必须提供脚本的版本管理，每个制定版本的脚本就按照此版本的体系运行。

1. 版本管理的前提是必须有统一的接口，只有定义一套统一的接口，且这套接口未来不会改变，
	那么才能用版本管理有统一接口的多套不同的实现。
	接口为了以后兼容，就必须尽量的灵活和普遍适合需要。
2. 在统一的接口上建立统一的架构，然后此架构和接口必须兼容之前的版本。
3. 同一个版本内，所有对外的接口都只能增加，不能减少或者修改。
	并且提供版本中旧的设定升级为新的设定。

architecture ---> upgrade interface --> kind 1 modules
                                    +-> kind 2 modules

## 实现软件的支撑系统
【这里描述实现上面的系统时，需要提供的支撑系统，比如代码管理、开发平台、调试和测试平台、实施和维护方法，以及人员管理流程等，总之是围绕实现系统的周边系统】

1. 因为这个项目并不需要复杂的工程实现，而且面对的环境也比较单一（都是Linux/Bash)，那么编程的主要语言就是
	1. bash
	2. python 开发复杂的程序。
	3. 三方工具。

## 目前的任务

已经实现：
* 解决 按下 TAB 时，会出现错误。(OK)
	PATH 路径也有问题。
	-修改方法 : /usr/share/bash-completion/bash_completion 的 2058 行，加入 declare -A _xspecs.-
	-不知道为什么，这个 _xspecs 数组变成了 index array，所以索引不能输入带有"."的文字作为索引。-
	-declare -A 是声明为 association array，可以是任意字符串。-
	-问题应该没有真的解决。-
	shell中不再 source ~/.bashrc，避免了问题，上面也不用修改。但是alias之类的设定还需要自己加入。
* 实现 myenv mysh <命令> 的功能。 (OK)
* 独立运行程序，放在文件夹下面，可以立刻使用，而不是需要再进入系统中。(新的加载exe的方法就可以实现) OK
	function的同样。（没有妥善的方法，所以这个放弃。）
* 可以复制某个环境的脚本设定等等。  OK
   1. 比如nebula环境，在不同的机器上是相同的。 或者Alps环境，也是类似的。
   2. env 之间可以相互引用，和导入。
* 实现 TAB 按下后，word complete 操作。 OK
* 可以通过配置文件等，使用其他环境的脚本。 OK
* 允许设置 env 中某个文件、文件夹相关的操作，和 context menu 类似。（可用）
	添加了 context 的命令，但是发现bash在处理复杂的数据结构时，力不从心。

等待实现：
version 2:
* 将系统划分为三个功能：环境、状态显示和执行命令。
	* 环境：可以进入到指定的环境中(myenv)，环境可以是某个目录、虚拟名字、远程环境等。进入环境后，就加载计划好的环境变量和脚本。
		目前碰到在同一个目录下，具有不同的环境的情况，没有办法解决，只能通过使用者自己来区分。
		需要登录远程的环境，需要执行的命令是固定的，所以应该可以自动化。
		虚拟环境，是要进行某些操作，但是并不局限于某个目录。
	* 提示：用户可以显示出当前的情况，方便用户执行某些命令，以及根据特殊的状态进行操作。
		需要具有很强的可配置性，允许工具本身和使用者定制。
		因为如果显示比较多，会减少命令和命令结果的显示，所以这里需要能够比较强的伸缩。
	* 执行命令：针对目标执行一些操作。
		* 目标：可以是名字、path等。
		* 操作：可以是 function或者是 script。
		* 状态: 跟踪命令的完成情况，或者命令涉及到的数据情况。-> 状态。
		* Help/Complete: 提供帮助和补全功能。
* 加入的技术：
	* sqlite: 基于文件的数据库，方便创建多种结构的配置和处理。
	* 路径的模式匹配。用什么来实现？
	* PS1 用 powerline 来实现吗？更加的容易和绚丽。


还在规划：
* 实现 search-do 模式，就是将 “search” 得到的结果，交给 “do” 去处理。
	最好能够在 bash 下都可以运行，不然只能定制一个 shell 程序了。
	1. 我们很多的动作都是先search，然后根据 search 的结果操作。
	2. 如果search慢，或者还需要再加工一下，比如手工加工，那么就会不容易操作。
	3. search-do ： 要有多次 search/filter/do 的过程。主要是保存中间的结果，
	这样就方便操作了。
	4. search-do 需要把内部执行的命令的导出都放入临时文件，然后下面一个命令就可以获取。
      	1. content -> do -> content
* 是否加入一个 IDE 环境，显示 某个目标的 context ?
   1.  目标的列表
   2.  目标的动作列表
   3.  目标的状态（现检查和之前保存下来的信息）
   4.  查询其他环境的目标情况。
   5.  多个环境的动作连动。
* 脚本可以在不同的机器上运行，只要设定 <env name>@<machine>，然后执行就行。
    场景是用来使用远程服务器，分布使用，并且将一系列的工作放在一个脚本中运行。
	1. 可以公开某个机器的env，其他机器可以登录并使用。
	2. 脚本可以运行在任意环境中。参考 dsh，注意避免没有必要的繁琐实现。
* 版本或种类管理需要再考虑一下。主要是目前没有明确的需求。
* 用 SQLite 替代现在的设定文件(比如context/note)，方便编程和统一管理
* PS0 的时间，可以放到下一条命令看到“时间差”。

* 路径设置，支持 global pattern 或者 其他的，正则表达式过于复杂了。

* 是否加入一个Frame，可以在上下左右显示不同的信息，
	比如底部显示正在进行的工作Job，上面显示系统的状态等。
	参考pymux等。
* 可以显示状态栏。
* 可以定制PS1。可以考虑用 powerline 来代替自己的实现。
	sudo apt install powerline vim-airline
	vim-airline 是vim 的powerline插件。
	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	. /usr/share/powerline/bindings/bash/powerline.sh 使用powerline，
	但是和PS1冲突！
	powerline-config 是配置的。