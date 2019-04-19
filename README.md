# MIPS

### OneCycle MIPS

The OneCycle MIPS in OneCycle.srcs supports the instructions including:

add，sub，and，or，slt，addi，andi，ori，slti，sw，lw，j，nop，beq，bne,  jal,  jr,  sra,  sll,  srl, which sum up to 20.

So you can implore many operations like shift, stack, call and ret.

**Hints:**

If you want to simulate the top.v, then you'll find that all the results are "XX", because the clock divider I set is very large, i.e. q[26], q[23], so you won't see any change because the clock offered to CPU doesn't reach the positive edge. An easy way to fix this problem is to change the clock divider to smaller one, like q[0], and when you run the codes on the board, you should change it back.

### MultiCycle MIPS

The MultiCycle MIPS still need to be improved, since it only pass the ad hoc testing in **Harris's Digital Design Computer Architecture**' s 7.4

2019.4.19

successfully pass most tests on <https://github.com/Oxer11/MIPS/tree/master/Assembler/example>, including **quick_multiply.out** which needs srl, sll and **factorial.out** covering jal, jr. Next time, I'll try the Pipeline and I want to add the FPU instruction set.

