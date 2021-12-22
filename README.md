# Pestilence: obfuscated malware

This is part of the malware series from the 42 cursus.

Work in progress.

How I made this:

- Famine uses the technique PT_NOTE to PT_LOAD.
- For pestilence en cryption, a simple XOR loop is used.
- For anti-debugging, ptrace is called so that a debugger cannot run over it.

Useful things:

``gdb ./pestilence --tui``

Inside gdb:
``si``              Next instruction
``b <line>``        Set breakpoint
``r``               Run until breakpoint
``c``               Continue
``tui enable``      Enable TUI
``tui reg general`` Show registers