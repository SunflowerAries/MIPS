# <center>Cache实验报告</center>

<center>罗翔</center>

<center>17307130191</center>

[TOC]

## 1 Cache简介

### 1.1 局部性原理

　　在较短时间间隔内，程序产生的地址往往集中在存储器的一个很小范围内，这种现象称为局部性，可细分为时间局部性和空间局部性。

- 时间局部性指被访问的某个存储单元在一个较短时间间隔内很可能又被访问。
- 空间局部性指被访问的某个存储单元的临近单元在一个较短时间间隔内很可能被访问。

　　因为程序是由指令和数据组成的，所以出现局部性的原因也可以从这两方面解释。

- 指令在主存中按序存放，地址连续，而程序中的循环程序段或子程序段通常会被重复执行，因此指令访问具有明显的局部性。
- 数据在主存中一般也是连续存放，尤其是数组元素，经常被按序重复访问，因此数据访问也具有明显的局部性。

### 1.2 Cache基本工作原理

　　Cache是一种小容量高速缓冲存储器，在CPU和主存之间设置Cache可以将主存中被频繁访问的程序块和数据块复制到Cache中。利用局部性原理，大多数情况下，CPU能直接从Cache中取得指令和数据，而不必访问主存。



## 2 部件分析



## 3 模拟测试



## 4 申A理由



## 5 致谢

1. 非常感谢张作柏同学无私贡献出<a style="text-decoration:none;" href="https://github.com/Oxer11/MIPS/tree/master/Assembler/assembler.py">译码器</a>使得生成测试样例的效率极大提高。
2. Mitu Raj等人就latch问题在<a style="text-decoration:none;" href=" https://electronics.stackexchange.com/questions/343146/how-do-i-eliminate-latches-in-fsm-verilog-implementation">StackExchange</a>上的讨论给我提供了很多帮助。

## 6 参考文献

1. 袁春风. 计算机组成与系统结构
2. Randal E. Bryant, David R. O’Hallaron. Computer Systems: A Programmer’s Perspective