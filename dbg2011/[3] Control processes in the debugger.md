### Get process information

We can use the `!process` command to locate a process by its image name:

    kd> !process 0 0 LINQPad.UserQuery.exe
    PROCESS ffffda07cd4da4c0
        SessionId: 6  Cid: 3168    Peb: 4b61e15000  ParentCid: 1e5c
        DirBase: 1e6165002  ObjectTable: ffffb2813a6dcd00  HandleCount: 529.
        Image: LINQPad.UserQuery.exe
    
    PROCESS ffffda07bfa49080
        SessionId: 6  Cid: 427c    Peb: c0d32c9000  ParentCid: 1e5c
        DirBase: 3b2173002  ObjectTable: ffffb2812cd5ad40  HandleCount: 397.
        Image: LINQPad.UserQuery.exe

### Break when user-mode process is created

`kd> bp nt!PspInsertProcess`

The breakpoint is hit whenever a new user-mode process is created.
To know what process is it, we may access the `_EPROCESS` structure in the `ImageFileName` field:

* x64: `dt nt!_EPROCESS @rcx ImageFileName`
* x86: `dt nt!_EPROCESS @eax ImageFileName`

### Break in user-mode process from the kernel-mode

You may set a breakpoint in user space, but you need to be in a valid process context:

```
kd> !process 0 0 notepad.exe
PROCESS ffffe0014f80d680
    SessionId: 2  Cid: 0e44    Peb: 7ff7360ef000  ParentCid: 0aac
    DirBase: 2d497000  ObjectTable: ffffc00054529240  HandleCount: 
    Image: notepad.exe

kd> .process /i ffffe0014f80d680
You need to continue execution (press 'g' ) for the context
to be switched. When the debugger breaks in again, you will be in
the new process context.

kd> g
```

When you are in a given process context, set the breakpoint:

```
kd> .reload /user
kd> !process -1 0
PROCESS ffffe0014f80d680
    SessionId: 2  Cid: 0e44    Peb: 7ff7360ef000  ParentCid: 0aac
    DirBase: 2d497000  ObjectTable: ffffc00054529240  HandleCount: 
    Image: notepad.exe

kd> x kernel32!CreateFileW
00007ffa`d8502508 KERNEL32!CreateFileW ()
kd> bp 00007ffa`d8502508
```

