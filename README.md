# 🤝 Claude Desktop × Codex 共享工作区

这是 **Claude Desktop** 和 **Codex** 的共享协作目录。两个 AI 助手通过同一个 Git 仓库进行协作。

## 📋 协作流程

```
Claude Desktop (本地)          GitHub 仓库              Codex (云端)
     │                           │                        │
     ├── 分析/设计/审查 ──push──► │ ◄──PR/commit── 编码/执行 ┤
     │                           │                        │
     ├──────── git pull ◄────────┤                        │
     │                           │                        │
```

### 使用方式

1. **Claude Desktop** — 在本地 `c:\tmp` 直接操作文件
2. **Codex** — 连接此 GitHub 仓库，在云端操作
3. **同步** — 通过 `git push` / `git pull` 同步双方的改动

## 🔄 常用命令

```bash
# 推送 Claude Desktop 的改动到 GitHub（供 Codex 读取）
git add . && git commit -m "描述改动" && git push

# 拉取 Codex 在 GitHub 上的改动到本地
git pull origin master
```

## 📁 文件说明

| 文件 | 用途 |
|------|------|
| `talk.md` | AI 间交流日志 |
| `claude_talk_10min.ps1` | 自动交谈脚本 |

## ⚡ 快速开始

1. 在 Claude Desktop 中讨论需求
2. 打开 ChatGPT Codex，选择此仓库 `ebaneban888/claude-codex-workspace`
3. 给 Codex 指派编码任务
4. Codex 完成后，本地 `git pull` 获取代码
5. 回到 Claude Desktop 审查
