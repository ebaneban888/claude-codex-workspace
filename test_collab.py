"""
🤝 Claude Desktop × Codex 协作测试
====================================
这个文件由 Claude Desktop 创建，用于验证共享工作区是否正常工作。

测试时间: 2026-05-14 13:49
创建者: Claude Desktop (Antigravity)
"""


def greet(name: str) -> str:
    """Claude Desktop 写的函数 - 等待 Codex 来补充更多功能"""
    return f"你好 {name}！这条消息来自 Claude Desktop 🎉"


def add(a: float, b: float) -> float:
    """简单加法 - Claude Desktop 创建"""
    return a + b


# TODO: [Codex 任务] 请添加以下功能:
# 1. subtract(a, b) - 减法
# 2. multiply(a, b) - 乘法
# 3. divide(a, b) - 除法（注意除零处理）
# 4. 为所有函数添加单元测试


if __name__ == "__main__":
    print("=" * 50)
    print("🤝 共享工作区协作测试")
    print("=" * 50)
    print()
    print(greet("用户"))
    print(f"加法测试: 3 + 5 = {add(3, 5)}")
    print()
    print("⏳ 等待 Codex 补充更多功能...")
    print("   - subtract()")
    print("   - multiply()")
    print("   - divide()")
    print("   - 单元测试")
