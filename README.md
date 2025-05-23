# 游戏优化脚本 2.3.3

![GitHub last commit](https://img.shields.io/github/last-commit/vdavidyang/GameOptimizer) ![GitHub license](https://img.shields.io/github/license/vdavidyang/GameOptimizer)![GitHub Actions](https://img.shields.io/github/actions/workflow/status/vdavidyang/GameOptimizer/test.yml)

[English Version](./README_EN.md) | [中文文档](./README.md)

一个用于优化游戏性能的Windows批处理脚本，通过调整进程优先级和CPU相关性来减少游戏卡顿问题。

## 目录  
- [功能特性](#-功能特性)  
- [支持游戏](#-支持游戏)
- [快速开始](#-快速开始)  
- [使用说明](#-使用说明)
- [优化原理](#-优化原理)

## ✨ 功能特性

- 🚀 **通用兼容**：支持多款热门游戏一键优化
- ⚡ **性能优化**：有效减少游戏突然卡顿现象
- 🔒 **安全可靠**：不修改游戏文件，仅调整系统调度规则
- 📌 **便捷使用**：自动生成桌面快捷方式，操作简单

## 🎮 支持游戏

• 英雄联盟 • 穿越火线 • 无畏契约 • CSGO2  
• 三角洲 • 枪神纪 • 界外狂潮 • 守望先锋  
• 暗区突围 • 永劫无间

*其他游戏需求？欢迎提交Issue或联系作者*

## ⚙️ 系统要求  
- ✅ Windows 10/11 32/64位  
- ✅ 管理员权限运行  
- ❌ 其中的PowerShell可能不支持Windows 7

## 📥 快速开始

### 下载安装

1. 下载最新版本：[Release页面](https://github.com/yourusername/game-optimization-script/releases)
2. 解压压缩包到任意目录
3. 右键`一键设置游戏优先级（注册表）_通用版.bat`选择`以管理员身份运行`
4. 按照提示完成设置并重启电脑

### 日常使用

每次首次启动游戏后，双击桌面`一键设置TX反作弊优先级.bat`快捷方式

## 🛠️ 使用说明

详细使用教程请参阅：[使用指南](./docs/使用指南.pdf)

## ❓ 常见问题

**Q：会封号吗？**  
A：绝对安全！仅调整系统调度规则，不修改游戏文件，主播长期实测。

**Q：帧率提升明显吗？**  
A：多数用户反馈有效，实测可提升10-20帧，显著改善团战卡顿。

**Q：脚本报错怎么办？**  
A：请检查是否以管理员身份运行，或提交Issue反馈问题。

**Q：杀毒软件报毒？**  
A：因涉及注册表修改，部分杀软可能误报，请添加信任或[查看源码](src/)验证安全性。  

## 🔧 优化原理  
| 操作目标       | 实现方式                 | 效果             |
| -------------- | ------------------------ | ---------------- |
| 游戏进程优先级 | 通过注册表设置High优先级 | 减少系统资源争夺 |
| 反作弊进程限制 | 绑定到CPU末核+低优先级   | 降低后台占用     |

## 🔄 更新历史  

### v2.1.1 (2025-04-11)  

* 增加永劫无间和暗区突围两款游戏

### v2.1 (2025-04-11)  
-  修复`SetProcessPriority.ps1`对CPU逻辑核心数大于等于32的CPU核心掩码左移计算溢出的问题
- 增加部分游戏

### v2.0 (2025-04-10)  

- 修复无畏契约Bug，瓦学弟放心用
- 优化脚本输出
- 增加自动快捷方式创建脚本
- 优化脚本代码逻辑

### v1.0 (2025-04-9)  

- 初始版本 

## ⚠️ 注意事项  

* `一键设置反作弊优先级.bat` 和 `SetProcessPriority.ps1` **必须保持同目录**  

* 游戏优先级脚本使用完可删除，反作弊脚本**必须保留**  

- 本脚本不会注入或修改任何游戏内存/文件  
- 优化效果因硬件配置可能有所差异  
- 使用前建议关闭其他优化工具避免冲突  

## ⚠️ 免责声明

本脚本仅供学习和技术研究使用，作者不对使用此脚本导致的任何后果负责。使用本脚本即表示您已了解并接受相关风险。

## 📧 联系作者

- 邮箱：vdavidyang@gmail.com
- GitHub Issues: [提交问题](https://github.com/yourusername/game-optimization-script/issues)

## 📜 开源许可

本项目采用 [MIT License](./LICENSE) 开源协议。

---

**⭐ 如果这个项目对你有帮助，请给我一个Star！**

---
