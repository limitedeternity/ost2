## Break when user-mode process is created

`kd> bp nt!PspInsertProcess`

The breakpoint is hit whenever a new user-mode process is created.
To know what process is it, we may access the `_EPROCESS` structure in the `ImageFileName` field:

* x64: `dt nt!_EPROCESS @rcx ImageFileName`
* x86: `dt nt!_EPROCESS @eax ImageFileName`

## Switch to a user-mode process context

```
kd> !process 0 0 notepad.exe
PROCESS ffffe0014f80d680
    SessionId: 2  Cid: 0e44    Peb: 7ff7360ef000  ParentCid: 0aac
    DirBase: 2d497000  ObjectTable: ffffc00054529240  HandleCount: 
    Image: notepad.exe

kd> .process /i ffffe0014f80d680
You need to continue execution (press 'g') for the context
to be switched. When the debugger breaks in again, you will be in
the new process context.

kd> g; .reload -f
<...>

kd> !process -1 0
PROCESS ffffe0014f80d680
    SessionId: 2  Cid: 0e44    Peb: 7ff7360ef000  ParentCid: 0aac
    DirBase: 2d497000  ObjectTable: ffffc00054529240  HandleCount: 
    Image: notepad.exe
```

### Break in user-mode process from the kernel-mode

After you’ve switched the context:

```
kd> !process -1 0
PROCESS ffffe0014f80d680
    SessionId: 2  Cid: 0e44    Peb: 7ff7360ef000  ParentCid: 0aac
    DirBase: 2d497000  ObjectTable: ffffc00054529240  HandleCount: 
    Image: notepad.exe

kd> x kernel32!CreateFileW
00007ffa`d8502508 KERNEL32!CreateFileW ()
kd> bp 00007ffa`d8502508
```

### Inspect user-mode process (threads, stacks, modules) from the kernel-mode

After you’ve switched the context:

```
kd> !process -1 0
PROCESS ffffe0014f80d680
    SessionId: 2  Cid: 0e44    Peb: 7ff7360ef000  ParentCid: 0aac
    DirBase: 2d497000  ObjectTable: ffffc00054529240  HandleCount: 
    Image: notepad.exe
    
kd> !process @$proc
<...>
```

> WinDbg keeps track of the current thread in both user mode and kernel mode in the pseudo-register `@$thread`, and current process in the pseudo-register `@$proc`.

