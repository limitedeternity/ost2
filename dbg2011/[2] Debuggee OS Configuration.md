Open an **Administrator** cmd.exe prompt and run the following commands:

```
bcdedit /debug on
bcdedit /dbgsettings net hostip:Debugger_VM_IP port:50505 key:a.b.c.d
```

Where *Debugger_VM_IP* should be replaced with the IP address of your *Debugger VM* (and a.b.c.d can be left as-is as it is actually a "secret" key for the debugger and the debuggee to talk)

**Reboot the VM after running the above bcdedit commands.**

