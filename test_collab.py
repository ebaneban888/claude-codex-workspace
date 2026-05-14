"""
🤝 Claude Desktop × Codex 协作测试
====================================
这个文件由 Claude Desktop 创建，用于验证共享工作区是否正常工作。

测试时间: 2026-05-14 13:49
创建者: Claude Desktop (Antigravity)
"""


import sys
import unittest


if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")


def greet(name: str) -> str:
    """Claude Desktop 写的函数 - 等待 Codex 来补充更多功能"""
    return f"你好 {name}！这条消息来自 Claude Desktop 🎉"


def add(a: float, b: float) -> float:
    """简单加法 - Claude Desktop 创建"""
    return a + b


def subtract(a: float, b: float) -> float:
    """简单减法 - Codex 补充"""
    return a - b


def multiply(a: float, b: float) -> float:
    """简单乘法 - Codex 补充"""
    return a * b


def divide(a: float, b: float) -> float:
    """简单除法 - Codex 补充，除数不能为 0"""
    if b == 0:
        raise ValueError("除数不能为 0")
    return a / b


class TestCollabFunctions(unittest.TestCase):
    def test_greet(self) -> None:
        self.assertEqual(greet("用户"), "你好 用户！这条消息来自 Claude Desktop 🎉")

    def test_add(self) -> None:
        self.assertEqual(add(3, 5), 8)
        self.assertEqual(add(-2, 7), 5)

    def test_subtract(self) -> None:
        self.assertEqual(subtract(10, 4), 6)
        self.assertEqual(subtract(-2, -5), 3)

    def test_multiply(self) -> None:
        self.assertEqual(multiply(3, 5), 15)
        self.assertEqual(multiply(-2, 4), -8)

    def test_divide(self) -> None:
        self.assertEqual(divide(10, 2), 5)
        self.assertEqual(divide(7, 2), 3.5)

    def test_divide_by_zero(self) -> None:
        with self.assertRaises(ValueError):
            divide(10, 0)


if __name__ == "__main__":
    print("=" * 50)
    print("🤝 共享工作区协作测试")
    print("=" * 50)
    print()
    print(greet("用户"))
    print(f"加法测试: 3 + 5 = {add(3, 5)}")
    print(f"减法测试: 8 - 3 = {subtract(8, 3)}")
    print(f"乘法测试: 4 * 6 = {multiply(4, 6)}")
    print(f"除法测试: 12 / 3 = {divide(12, 3)}")
    print()
    print("✅ Codex 已补充更多功能:")
    print("   - subtract()")
    print("   - multiply()")
    print("   - divide()")
    print("   - 单元测试")
