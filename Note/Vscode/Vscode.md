# VSCODE 学习笔记

## 前言

尽管VSCODE已经用了很多年了，然而一些特殊的功能一直没尝试过，这里系统梳理下各种功能和使用方法，尤其是如何调试各种语言上。

### 编辑器

#### 多光标

​	如果希望在编辑器的多个位置同时进行某种操作，则需要首先添加辅助光标，这可以通过按住Alt键并在编辑器的其他位置（可在同一行中）点击鼠标左键来完成。使用键盘快捷方式Ctrl+Alt+Up或Ctrl+Alt+Down，或选择菜单项选择 | 在上面添加光标或选择 | 在下面添加光标，或在命令面板中执行命令`Add Cursor Above`或`Add Cursor Below`，可以为当前光标所在行的上一行或下一行添加辅助光标。在命令面板中执行命令`Add Cursors To Top`或`Add Cursors To Bottom`，可以为当前光标所在行的上面或下面的所有行添加辅助光标。当编辑器中存在辅助光标时，用户移动光标，选择或编辑文本将针对所有的辅助光标，在一些情况下，这将节省大量的工作时间。

#### 文件编码

​	设置项`files.encoding`是一个用于设置默认文件编码的字符串（默认值为`utf8`），如果没有启用自动推断文件编码或无法推断文件的编码，那么编辑器将尝试采用默认编码新建，打开（读取）或保存（写入）文件，在大部分情况下，修改设置项`files.encoding`是没有必要的，保持其默认值即可。设置项`files.autoGuessEncoding`可用于设置是否在编辑器打开文件时自动推断文件的编码（默认值为`false`，不进行自动推断）。点击状态栏的右边区域的文件编码信息，或在命令面板中执行命令`Change File Encoding`，可更改当前编辑器对应的文件的编码，Visual Studio Code 会为用户提供`Reopen with Encoding`和`Save with Encoding`两个选项。其中`Reopen with Encoding`会采用指定的编码重新开打编辑器对应的文件，但不会真正的修改文件的编码，除非对文件进行保存，`Save with Encoding`会采用指定的编码保存编辑器对应的文件。

```json
{
	// 指定默认的编码为 utf16be
	"files.encoding": "utf16be",
	// 在打开文件时推断编码
	"files.autoGuessEncoding": true,
}
```

#### 自动保存

​	在默认情况下，编辑器并不会自动保存已更改的文件，你需要修改设置项`files.autoSave`来实现文件的自动保存，该设置项拥有以下有效取值。此外，在命令面板中执行命令`File: Toggle Auto Save`，可以让设置项`files.autoSave`保持默认值，或被设置为`afterDelay`。

```json
{
	// 更改的文件在 3 秒后被自动保存
	"files.autoSave": "afterDelay",
	"files.autoSaveDelay": 3000,
	// 存在错误的文件不会被自动保存
	"files.autoSaveWhenNoErrors": true,
	// 非工作区的文件不会被自动保存
	"files.autoSaveWorkspaceFilesOnly": true,
}
```

## 终端

​	在实际的项目开发中，IDE 通常会使用命令行（也被称为外壳程序，shell）来编译和运行代码，或完成其他的相关任务。终端使开发人员可以在 Visual Studio Code 中直接使用命令行，比如 Windows 中的 PowerShell 和命令提示符，UNIX/Linux 中的`bash`。

**终端操作**：要在 Visual Studio Code 中打开终端，你可以选择菜单项查看 | 终端，或者使用键盘快捷方式`Ctrl+\`。终端中的复制和粘贴操作与其所在的操作系统相同，在 Windows 中可以使用键盘快捷方式`Ctrl+C`和`Ctrl+V`进行复制和粘贴，在 Linux 中可以使用键盘快捷方式`Ctrl+Shift+C`和`Ctrl+Shift+V`进行复制和粘贴。当终端所打开的命令行应用（外壳程序）处于活动状态时，使用键盘快捷方式`Ctrl+F`将打开查找小部件。终端所打开的命令行应用（外壳程序）可能包含一些链接，这些链接可以在按住`Ctrl`的情况下被鼠标点击，并在鼠标悬停时显示下划线。如果终端启动了过多的命令行应用（外壳程序），则可以点击其对应的终止（垃圾桶）按钮，或其对应的上下文菜单项终止终端，来终止命令行应用。终止按钮一般位于终端面板的右上角，如果终端面板包含多个命令行，那么终止按钮将位于终端面板的右边区域，当鼠标悬停时会出现，此时，对于选中并处于活动状态的命令行应用，按下Delete键也可以将其终止。

**终端缓存区**：命令行应用（外壳程序）中显示的命令和输出结果，存放在终端的缓冲区中，该缓冲区的大小可以通过设置项`terminal.integrated.scrollback`修改，默认值为`1000`，即最多可保留`1000`行的信息。这里需要指出，终端的缓冲区能够保留的最多行数可能与设置项`terminal.integrated.scrollback`不同。如果终端所打开的命令行应用（外壳程序）支持在命令之间导航，那么你可以使用键盘快捷方式Ctrl+UpArrow，Ctrl+DownArrow来导航至上一个或下一个执行过的命令（需要命令行应用处于活动状态）。

```json
{
	// 命令行可以保留 200 行的信息
	"terminal.integrated.scrollback": 200,
}
```

### 任务（Tasks）

​	Visual Studio Code（VSCode）任务允许你配置和运行特定的命令、脚本或应用程序，以完成特定的开发任务。例如，你可以设置一个任务来运行 Windows 命令提示符中的命令，用于复制文件或执行批处理文件。

#### 创建

​	要创建自定义任务，可以通过以下两种方式。通过菜单项终端 | 配置任务…，或运行 VSCode 命令`Tasks: Configure Task`。在配置任务时，VSCode 会显示一个面板，并提供一些选项。如果点击使用模板创建 tasks.json 文件，然后选择`Others`选项，那么将创建一个简单的执行命令的任务`echo`，用于显示信息。完成任务的配置后，VSCode 会在工作区文件夹的`.vscode`目录中创建`tasks.json`文件，该文件包含所有自定义任务的信息。

#### 运行

​	任务创建后，可通过以下方式运行。使用菜单项终端 | 运行任务…，或运行 VSCode 命令`Tasks: Run Task`。选择之前创建的任务`echo`，点击继续而不扫描任务输出，即可在终端面板中看到输出结果`Hello`。

#### 配置

当需要修改现有任务或添加新任务时，可以直接编辑`.vscode`目录中`tasks.json`文件。该文件的`tasks`属性是包含任务的数组，每个任务对应一个对象。要创建新任务，只需在该数组中添加新的任务对象即可。

对于任务对象，一般拥有以下属性。

* label 属性：`label`属性为任务的名称，显示在选择面板中。

* detail 属性`detail`属性为任务的详细说明，用于提供更多上下文信息。

* icon 属性：`icon`属性是一个表示任务图标的对象，该对象的属性`id`为图标形状，属性`color`为图标颜色。

* group 属性：`group`属性表示任务所在的执行组，有效值如下：`build`为生成任务，`test`为测试任务，`none`表示任务不属于任何组。
* type 属性：`type`属性为任务的类型，有效值如下：`process`表示任务为进程，`shell`表示任务是一个命令。

* command 属性：`command`属性与任务的类型（`type`属性）有关，可以包含 VSCode 变量。如果任务为进程，那么`command`属性是指向可执行目标的路径（绝对或相对路径，如果使用相对路径，则默认相对于 VSCode 工作区目录）。如果任务为命令，那么`command`属性是需要在 VSCode 终端中执行的命令。当任务类型为`shell`时，可直接将完整命令和参数作为一个字符串，写入属性`command`中，或者将命令和参数组成一个数组作为`command`属性的值。当然，为了提高可读性和维护性，也可使用`args`属性（数组）单独包含参数。当任务类型为`process`时，必须使用`args`属性（数组）来传递参数。

* hide 属性：如果`hide`属性为`true`，那么任务不会出现在任务选择面板中（默认显示）。
* option属性：一些额外的配置，比如设置工作目录，环境变量等
* dependsOn属性：如果你希望一次执行多个任务，那么可以为文件`tasks.json`的任务对象，添加`dependsOn`属性，该属性是一个数组，包含当前任务（当前任务本身不需要设置`command`和`type`属性）所依赖的所有任务名称。此外，使用任务对象的`dependsOrder`属性，可以控制依赖任务的执行顺序。该属性可以取以下有效值：`parallel`（默认值）表示并行执行所有依赖任务，`sequence`表示按依赖任务的出现顺序执行。

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      // 任务名称
      "label": "My task",
      // 任务说明
      "detail": "This is a test task",
      // 任务图标
      "icon": {
        "id": "alert",
        "color": "terminal.ansiCyan"
      },
      // 任务不在任何执行组中
      "group": "none",
      // 执行工作区根目录下的 test.bat
      "type": "process",
      "command": "${workspaceFolder}\\test.bat",
      // 不在任务选择面板中隐藏任务
      "hide": false,
      "options": {
        // 工作目录
        "cwd": "Z:\\code\\"
      }
    },
    {
      "label": "withargs1",
      "type": "shell",
      "command": "Write-Output 'Hello World'"
    },
    {
      "label": "withargs2",
      "type": "shell",
      "command": "Write-Output",
      "args": ["Hello World"]
    },
    {
      "label": "withargs3",
      "type": "shell",
      "command": ["Get-ChildItem", "-Path Z:\\"]
    },
    {
      "label": "withargs4",
      "type": "process",
      "command": "show.bat",
      "args": ["Jack", "12"]
    },
    {
      "label": "multi",
      "dependsOn": ["withargs1", "withargs2"],
      "dependsOrder": "sequence"
    }
  ]
}

```

### 调试（Launch）

​	Visual Studio Code（VSCode）的调试功能为测试代码提供了极大的便利。本文将介绍如何在 VSCode 中运行调试代码，并解释部分高级设置。对于某些语言（如 JavaScript、TypeScript），VSCode 已内置了它们的运行调试功能，无需安装其它扩展。

​	其它语言（如 Python、C++），通常需要安装启用对应的扩展（例如，调试 Python 需要安装扩展 Python Debugger）。要简单的启动代码的调试，你可以打开一个代码文件。然后，在运行和调试面板中点击运行和调试按钮。如果 VSCode 能够确定采用何种配置，那么运行调试会直接开始。否则，会弹出面板让你选择所采用的配置项，这些配置项通常由 VSCode 自身和所安装的扩展提供。例如，打开并运行调试一个`py`脚本文件，可能会看到配置项 Python 文件，选择它即可使用 Python 解释器运行当前的`py`文件。当然，以上的这种方式适用于快速测试单个文件。如果遇到稍微复杂一些的场景（如传递参数、设置环境变量、执行前后任务），那么就需要进行自定义配置。

#### 创建

​	`launch.json`是 VSCode 用于存储运行调试配置项的文件，它位于项目工作区的`.vscode`文件夹中。通过它，你可以创建并管理自定义的运行调试配置。

#### 配置

对于一个运行调试配置项，通常拥有以下重要的设置（属性）。

* **name 属性**：`name`属性是配置项的名称，可显示在运行和调试面板的下拉列表框中。

* **type 属性**：`type`属性表示配置项的类型。相关语言扩展或 VSCode 内置功能将根据该属性来识别配置项。比如，扩展 Python Debugger 可识别`type`属性为`debugpy`的配置项。

* **request 属性**：`request`属性为请求类型。其有效值`launch`表示启动新程序进行调试，`attach`表示附加到已运行的程序进行调试。

* **program 属性**：`program`属性为要调试的可执行文件或脚本的路径。可以是绝对路径或相对路径（一般情况下，相对路径相对于 VSCode 工作区目录）。
* **args属性**：配置项的`args`属性是一个字符串数组，可为运行调试添加命令行参数，参数的名称和值可以合并为一个字符串，或分别作为两个字符串。
* **env属性**：当程序的行为依赖于环境变量时，你可以在`launch.json`中为相应的运行调试配置设置环境变量。这相对于直接修改操作系统中的环境变量更加灵活。要设置环境变量，可以在配置项中添加`env`属性。该属性是一个对象，需要设置的环境变量作为对象的属性出现，环境变量的名称作为属性的名称，环境变量的值作为属性的值。

* **cwd属性**：配置项的`cwd`属性，表示了运行调试时终端的当前工作目录。
* **pre/postTasks**：如果你需要在运行调试之前或之后执行一些额外的操作（比如，创建或删除某个文件夹），那么可以为配置添加属性`preLaunchTask`或`postDebugTask`即可，属性的值是已存在的任务的名称。

```json
{
	"version": "0.2.0",
	"configurations": [
		{
			"name": "Python 运行当前文件",
			"type": "debugpy",
			"request": "launch",
			"program": "${file}",
            "cwd": "z:\\",
            "args": ["--name Jack","--age","10"],
            "env": {
				"MYNAME": "Tom",
			},
            "preLaunchTask": "begin",
			"postDebugTask": "end",
		}
	]
}
```

