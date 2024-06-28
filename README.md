# OceanEyes

基于多模态大模型的海洋生物识别系统。

## 概述

OceanEyes 是一款使用现代 SwiftUI 和多模态大模型技术开发的应用程序，旨在通过图片识别海洋生物。用户可以选择从相册中选择图片或使用相机拍照上传，应用会对图片进行分析并返回生物的详细信息。

## 功能

- 从相册选择图片
- 使用相机拍照上传图片
- 对上传的图片进行海洋生物识别
- 显示识别结果的详细信息
- 应用关闭或进入后台时清理数据

## 安装

1. 确保你已经安装了最新版本的 Xcode。
2. 克隆此仓库到你的本地机器：
    ```sh
    git clone https://github.com/yourusername/OceanEyes.git
    ```
3. 打开 Xcode，加载 `OceanEyes.xcodeproj` 项目文件。
4. 选择目标设备或模拟器，然后点击运行按钮。

## 使用

1. 启动应用程序。
2. 点击 **相册选择** 按钮从相册中选择图片，或者点击 **拍照上传** 按钮使用相机拍摄新照片。
3. 选择或拍摄图片后，点击 **分析生物** 按钮开始图片分析。
4. 等待分析完成后，若有识别结果，会显示 **分析成功 查看结果** 按钮，点击它查看识别结果的详细信息。

## 项目结构

- **OceanEyesApp.swift**：应用程序的入口，配置应用的生命周期和状态管理。
- **ContentView.swift**：主视图，包含图片选择、上传和分析的界面。
- **MainViewModel.swift**：视图模型，处理应用的业务逻辑，包括图片上传、数据清理和识别结果处理。
- **SpeciesInfoView.swift**：显示识别结果详细信息的视图。
- **ImagePicker.swift**：自定义的图片选择器，允许用户从相册选择图片或使用相机拍照。

## 鸣谢

特别感谢以下人员和项目对本项目的支持和贡献：

- **孔老师** - 项目发起人和指导老师。
- **方同学** - 项目负责人和前端开发者。
- **庄同学** - 服务器及后端开发者。
- **OpenAI** - 提供了强大的 GPT-4o 模型支持，使得本项目中的自然语言处理和分析功能成为可能。
- **SwiftUI 社区** - 为 SwiftUI 提供了丰富的资源和支持。
- **GitHub 社区** - 提供了一个强大的协作平台，让我们能够轻松地共享和管理代码。

感谢所有对本项目提供帮助和支持的个人和组织！

## 贡献者

感谢以下人员对本项目的贡献：

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/ftx66"><img src="https://avatars.githubusercontent.com/ftx66?v=4" width="100px;" alt=""/><br /><sub><b>方正豪</b></sub></a><br /><a href="https://github.com/ftx66/your-repo/commits?author=ftx66" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/zhuangzero"><img src="https://avatars.githubusercontent.com/zhuangzero?v=4" width="100px;" alt=""/><br /><sub><b>庄浩林</b></sub></a><br /><a href="https://github.com/yourusername/your-repo/commits?author=zhuangzero" title="Code">💻</a></td>
  </tr>
</table>
<!-- ALL-CONTRIBUTORS-LIST:END -->
