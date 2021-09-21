## Break when user-mode process is created

If you're willing to catch the process on boot, you need to preliminarily break on system startup:
```
kd> <Ctrl+Alt+K>
Will breakin at next boot.

kd> .reboot
```

After it breaks (or if you didn't reboot):
```
kd> !gflag +ksl
New NtGlobalFlag contents: 0x00040000
    ksl - Enable loading of kernel debugger symbols

kd> sxe ld winlogon.exe; g
```

When the next break occurs, you'll be in context of this process.

At this point we need to wait for `ntdll` to load:
```
kd> bp /1 /p @$proc nt!NtMapViewOfSection; g
```

On the next stop `ntdll` should be loaded (check it using `kn` command - should be on the stack, `.reload /user` if necessary).

After that, we need to wait for the first user thread to start:
```
kd> bp /1 /p @$proc ntdll!RtlUserThreadStart; g
```

When the breakpoint is hit, do `.reload /f` and it's done.

## Switch to an existing user-mode process context

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

### Inspect user-mode process (threads, stacks, modules)

> WinDbg keeps track of the current thread in both user mode and kernel mode in the pseudo-register `@$thread`, and current process in the pseudo-register `@$proc`.
