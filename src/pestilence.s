%define SYS_EXIT		60
%define SYS_OPEN		2
%define SYS_CLOSE		3
%define SYS_WRITE		1
%define SYS_READ		0
%define SYS_EXECVE		59
%define SYS_GETDENTS64	217
%define SYS_FSTAT		5
%define SYS_LSEEK		8
%define SYS_PREAD64		17
%define SYS_PWRITE64	18
%define SYS_SYNC		162
%define SYS_GETUID		102
%define SYS_CHDIR		80
%define SYS_PTRACE		101

%define SYS_MMAP		9
%define SYS_MUNMAP		11

%define PROT_READ 0x1
%define PROT_WRITE 0x2

%define MAP_SHARED 0x01
%define MAP_PRIVATE 0x02

%define MAP_FAILED -1

%define DT_REG			8
%define SEEK_END		2
%define DIRENT_BUFFSIZE	1024

; PTYPES
%define PT_LOAD			1
%define PT_NOTE			4

; OPEN MODES
%define O_RDONLY		00000000
%define O_WRONLY		00000001
%define O_RDWR			00000002

%define argv0			[rsp + 8]
%define argc			[rsp + 4]
%define SIGNATURE		0x00455244 ; 
%define PF_X	1
%define PF_R	4
%define PF_W	2
section .text
    global _start

_start:
    mov r14, [rsp + 8] ; argv[0]
    push rsp
    sub rsp, 3000
    mov r15, rsp ; r15 = stack pointer
    
    call hello_world
    jmp cleanup
    write:
        ; rdi = fd
        ; rsi = buffer
        ; rdx = size
        ; rcx = ret to

        pop rsi
        mov rax, SYS_WRITE
        mov rdi, 1
        mov rdx, 15
        syscall
        jmp cleanup
        ret
    hello_world:
        call write
        ret
        db 'Pestilence by darodrig',0
cleanup:
    add rsp, 3000
    pop rsp
_end:
    xor rdi, rdi
    mov rax, 60
    syscall