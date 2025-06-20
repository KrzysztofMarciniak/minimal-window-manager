
mwm:     file format elf64-x86-64


Disassembly of section .init:

0000000000001000 <.init>:
    1000:	f3 0f 1e fa          	endbr64
    1004:	48 83 ec 08          	sub    $0x8,%rsp
    1008:	48 8b 05 c1 3f 00 00 	mov    0x3fc1(%rip),%rax        # 4fd0 <fork@plt+0x3b00>
    100f:	48 85 c0             	test   %rax,%rax
    1012:	74 02                	je     1016 <__cxa_finalize@plt-0x26a>
    1014:	ff d0                	call   *%rax
    1016:	48 83 c4 08          	add    $0x8,%rsp
    101a:	c3                   	ret

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:	ff 35 62 3e 00 00    	push   0x3e62(%rip)        # 4e88 <fork@plt+0x39b8>
    1026:	ff 25 64 3e 00 00    	jmp    *0x3e64(%rip)        # 4e90 <fork@plt+0x39c0>
    102c:	0f 1f 40 00          	nopl   0x0(%rax)
    1030:	f3 0f 1e fa          	endbr64
    1034:	68 00 00 00 00       	push   $0x0
    1039:	e9 e2 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    103e:	66 90                	xchg   %ax,%ax
    1040:	f3 0f 1e fa          	endbr64
    1044:	68 01 00 00 00       	push   $0x1
    1049:	e9 d2 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    104e:	66 90                	xchg   %ax,%ax
    1050:	f3 0f 1e fa          	endbr64
    1054:	68 02 00 00 00       	push   $0x2
    1059:	e9 c2 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    105e:	66 90                	xchg   %ax,%ax
    1060:	f3 0f 1e fa          	endbr64
    1064:	68 03 00 00 00       	push   $0x3
    1069:	e9 b2 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    106e:	66 90                	xchg   %ax,%ax
    1070:	f3 0f 1e fa          	endbr64
    1074:	68 04 00 00 00       	push   $0x4
    1079:	e9 a2 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    107e:	66 90                	xchg   %ax,%ax
    1080:	f3 0f 1e fa          	endbr64
    1084:	68 05 00 00 00       	push   $0x5
    1089:	e9 92 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    108e:	66 90                	xchg   %ax,%ax
    1090:	f3 0f 1e fa          	endbr64
    1094:	68 06 00 00 00       	push   $0x6
    1099:	e9 82 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    109e:	66 90                	xchg   %ax,%ax
    10a0:	f3 0f 1e fa          	endbr64
    10a4:	68 07 00 00 00       	push   $0x7
    10a9:	e9 72 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    10ae:	66 90                	xchg   %ax,%ax
    10b0:	f3 0f 1e fa          	endbr64
    10b4:	68 08 00 00 00       	push   $0x8
    10b9:	e9 62 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    10be:	66 90                	xchg   %ax,%ax
    10c0:	f3 0f 1e fa          	endbr64
    10c4:	68 09 00 00 00       	push   $0x9
    10c9:	e9 52 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    10ce:	66 90                	xchg   %ax,%ax
    10d0:	f3 0f 1e fa          	endbr64
    10d4:	68 0a 00 00 00       	push   $0xa
    10d9:	e9 42 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    10de:	66 90                	xchg   %ax,%ax
    10e0:	f3 0f 1e fa          	endbr64
    10e4:	68 0b 00 00 00       	push   $0xb
    10e9:	e9 32 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    10ee:	66 90                	xchg   %ax,%ax
    10f0:	f3 0f 1e fa          	endbr64
    10f4:	68 0c 00 00 00       	push   $0xc
    10f9:	e9 22 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    10fe:	66 90                	xchg   %ax,%ax
    1100:	f3 0f 1e fa          	endbr64
    1104:	68 0d 00 00 00       	push   $0xd
    1109:	e9 12 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    110e:	66 90                	xchg   %ax,%ax
    1110:	f3 0f 1e fa          	endbr64
    1114:	68 0e 00 00 00       	push   $0xe
    1119:	e9 02 ff ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    111e:	66 90                	xchg   %ax,%ax
    1120:	f3 0f 1e fa          	endbr64
    1124:	68 0f 00 00 00       	push   $0xf
    1129:	e9 f2 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    112e:	66 90                	xchg   %ax,%ax
    1130:	f3 0f 1e fa          	endbr64
    1134:	68 10 00 00 00       	push   $0x10
    1139:	e9 e2 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    113e:	66 90                	xchg   %ax,%ax
    1140:	f3 0f 1e fa          	endbr64
    1144:	68 11 00 00 00       	push   $0x11
    1149:	e9 d2 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    114e:	66 90                	xchg   %ax,%ax
    1150:	f3 0f 1e fa          	endbr64
    1154:	68 12 00 00 00       	push   $0x12
    1159:	e9 c2 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    115e:	66 90                	xchg   %ax,%ax
    1160:	f3 0f 1e fa          	endbr64
    1164:	68 13 00 00 00       	push   $0x13
    1169:	e9 b2 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    116e:	66 90                	xchg   %ax,%ax
    1170:	f3 0f 1e fa          	endbr64
    1174:	68 14 00 00 00       	push   $0x14
    1179:	e9 a2 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    117e:	66 90                	xchg   %ax,%ax
    1180:	f3 0f 1e fa          	endbr64
    1184:	68 15 00 00 00       	push   $0x15
    1189:	e9 92 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    118e:	66 90                	xchg   %ax,%ax
    1190:	f3 0f 1e fa          	endbr64
    1194:	68 16 00 00 00       	push   $0x16
    1199:	e9 82 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    119e:	66 90                	xchg   %ax,%ax
    11a0:	f3 0f 1e fa          	endbr64
    11a4:	68 17 00 00 00       	push   $0x17
    11a9:	e9 72 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    11ae:	66 90                	xchg   %ax,%ax
    11b0:	f3 0f 1e fa          	endbr64
    11b4:	68 18 00 00 00       	push   $0x18
    11b9:	e9 62 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    11be:	66 90                	xchg   %ax,%ax
    11c0:	f3 0f 1e fa          	endbr64
    11c4:	68 19 00 00 00       	push   $0x19
    11c9:	e9 52 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    11ce:	66 90                	xchg   %ax,%ax
    11d0:	f3 0f 1e fa          	endbr64
    11d4:	68 1a 00 00 00       	push   $0x1a
    11d9:	e9 42 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    11de:	66 90                	xchg   %ax,%ax
    11e0:	f3 0f 1e fa          	endbr64
    11e4:	68 1b 00 00 00       	push   $0x1b
    11e9:	e9 32 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    11ee:	66 90                	xchg   %ax,%ax
    11f0:	f3 0f 1e fa          	endbr64
    11f4:	68 1c 00 00 00       	push   $0x1c
    11f9:	e9 22 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    11fe:	66 90                	xchg   %ax,%ax
    1200:	f3 0f 1e fa          	endbr64
    1204:	68 1d 00 00 00       	push   $0x1d
    1209:	e9 12 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    120e:	66 90                	xchg   %ax,%ax
    1210:	f3 0f 1e fa          	endbr64
    1214:	68 1e 00 00 00       	push   $0x1e
    1219:	e9 02 fe ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    121e:	66 90                	xchg   %ax,%ax
    1220:	f3 0f 1e fa          	endbr64
    1224:	68 1f 00 00 00       	push   $0x1f
    1229:	e9 f2 fd ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    122e:	66 90                	xchg   %ax,%ax
    1230:	f3 0f 1e fa          	endbr64
    1234:	68 20 00 00 00       	push   $0x20
    1239:	e9 e2 fd ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    123e:	66 90                	xchg   %ax,%ax
    1240:	f3 0f 1e fa          	endbr64
    1244:	68 21 00 00 00       	push   $0x21
    1249:	e9 d2 fd ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    124e:	66 90                	xchg   %ax,%ax
    1250:	f3 0f 1e fa          	endbr64
    1254:	68 22 00 00 00       	push   $0x22
    1259:	e9 c2 fd ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    125e:	66 90                	xchg   %ax,%ax
    1260:	f3 0f 1e fa          	endbr64
    1264:	68 23 00 00 00       	push   $0x23
    1269:	e9 b2 fd ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    126e:	66 90                	xchg   %ax,%ax
    1270:	f3 0f 1e fa          	endbr64
    1274:	68 24 00 00 00       	push   $0x24
    1279:	e9 a2 fd ff ff       	jmp    1020 <__cxa_finalize@plt-0x260>
    127e:	66 90                	xchg   %ax,%ax

Disassembly of section .plt.got:

0000000000001280 <__cxa_finalize@plt>:
    1280:	f3 0f 1e fa          	endbr64
    1284:	ff 25 56 3d 00 00    	jmp    *0x3d56(%rip)        # 4fe0 <fork@plt+0x3b10>
    128a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

Disassembly of section .plt.sec:

0000000000001290 <XSendEvent@plt>:
    1290:	f3 0f 1e fa          	endbr64
    1294:	ff 25 fe 3b 00 00    	jmp    *0x3bfe(%rip)        # 4e98 <fork@plt+0x39c8>
    129a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000012a0 <getenv@plt>:
    12a0:	f3 0f 1e fa          	endbr64
    12a4:	ff 25 f6 3b 00 00    	jmp    *0x3bf6(%rip)        # 4ea0 <fork@plt+0x39d0>
    12aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000012b0 <__errno_location@plt>:
    12b0:	f3 0f 1e fa          	endbr64
    12b4:	ff 25 ee 3b 00 00    	jmp    *0x3bee(%rip)        # 4ea8 <fork@plt+0x39d8>
    12ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000012c0 <_exit@plt>:
    12c0:	f3 0f 1e fa          	endbr64
    12c4:	ff 25 e6 3b 00 00    	jmp    *0x3be6(%rip)        # 4eb0 <fork@plt+0x39e0>
    12ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000012d0 <XCreateFontCursor@plt>:
    12d0:	f3 0f 1e fa          	endbr64
    12d4:	ff 25 de 3b 00 00    	jmp    *0x3bde(%rip)        # 4eb8 <fork@plt+0x39e8>
    12da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000012e0 <write@plt>:
    12e0:	f3 0f 1e fa          	endbr64
    12e4:	ff 25 d6 3b 00 00    	jmp    *0x3bd6(%rip)        # 4ec0 <fork@plt+0x39f0>
    12ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000012f0 <XPending@plt>:
    12f0:	f3 0f 1e fa          	endbr64
    12f4:	ff 25 ce 3b 00 00    	jmp    *0x3bce(%rip)        # 4ec8 <fork@plt+0x39f8>
    12fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001300 <XKillClient@plt>:
    1300:	f3 0f 1e fa          	endbr64
    1304:	ff 25 c6 3b 00 00    	jmp    *0x3bc6(%rip)        # 4ed0 <fork@plt+0x3a00>
    130a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001310 <__stack_chk_fail@plt>:
    1310:	f3 0f 1e fa          	endbr64
    1314:	ff 25 be 3b 00 00    	jmp    *0x3bbe(%rip)        # 4ed8 <fork@plt+0x3a08>
    131a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001320 <XFree@plt>:
    1320:	f3 0f 1e fa          	endbr64
    1324:	ff 25 b6 3b 00 00    	jmp    *0x3bb6(%rip)        # 4ee0 <fork@plt+0x3a10>
    132a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001330 <__fdelt_chk@plt>:
    1330:	f3 0f 1e fa          	endbr64
    1334:	ff 25 ae 3b 00 00    	jmp    *0x3bae(%rip)        # 4ee8 <fork@plt+0x3a18>
    133a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001340 <XMoveResizeWindow@plt>:
    1340:	f3 0f 1e fa          	endbr64
    1344:	ff 25 a6 3b 00 00    	jmp    *0x3ba6(%rip)        # 4ef0 <fork@plt+0x3a20>
    134a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001350 <close@plt>:
    1350:	f3 0f 1e fa          	endbr64
    1354:	ff 25 9e 3b 00 00    	jmp    *0x3b9e(%rip)        # 4ef8 <fork@plt+0x3a28>
    135a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001360 <setsid@plt>:
    1360:	f3 0f 1e fa          	endbr64
    1364:	ff 25 96 3b 00 00    	jmp    *0x3b96(%rip)        # 4f00 <fork@plt+0x3a30>
    136a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001370 <signal@plt>:
    1370:	f3 0f 1e fa          	endbr64
    1374:	ff 25 8e 3b 00 00    	jmp    *0x3b8e(%rip)        # 4f08 <fork@plt+0x3a38>
    137a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001380 <XOpenDisplay@plt>:
    1380:	f3 0f 1e fa          	endbr64
    1384:	ff 25 86 3b 00 00    	jmp    *0x3b86(%rip)        # 4f10 <fork@plt+0x3a40>
    138a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001390 <XKeysymToKeycode@plt>:
    1390:	f3 0f 1e fa          	endbr64
    1394:	ff 25 7e 3b 00 00    	jmp    *0x3b7e(%rip)        # 4f18 <fork@plt+0x3a48>
    139a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000013a0 <XGrabKey@plt>:
    13a0:	f3 0f 1e fa          	endbr64
    13a4:	ff 25 76 3b 00 00    	jmp    *0x3b76(%rip)        # 4f20 <fork@plt+0x3a50>
    13aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000013b0 <select@plt>:
    13b0:	f3 0f 1e fa          	endbr64
    13b4:	ff 25 6e 3b 00 00    	jmp    *0x3b6e(%rip)        # 4f28 <fork@plt+0x3a58>
    13ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000013c0 <XSetErrorHandler@plt>:
    13c0:	f3 0f 1e fa          	endbr64
    13c4:	ff 25 66 3b 00 00    	jmp    *0x3b66(%rip)        # 4f30 <fork@plt+0x3a60>
    13ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000013d0 <XNextEvent@plt>:
    13d0:	f3 0f 1e fa          	endbr64
    13d4:	ff 25 5e 3b 00 00    	jmp    *0x3b5e(%rip)        # 4f38 <fork@plt+0x3a68>
    13da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000013e0 <XInternAtom@plt>:
    13e0:	f3 0f 1e fa          	endbr64
    13e4:	ff 25 56 3b 00 00    	jmp    *0x3b56(%rip)        # 4f40 <fork@plt+0x3a70>
    13ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000013f0 <XSync@plt>:
    13f0:	f3 0f 1e fa          	endbr64
    13f4:	ff 25 4e 3b 00 00    	jmp    *0x3b4e(%rip)        # 4f48 <fork@plt+0x3a78>
    13fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001400 <XSelectInput@plt>:
    1400:	f3 0f 1e fa          	endbr64
    1404:	ff 25 46 3b 00 00    	jmp    *0x3b46(%rip)        # 4f50 <fork@plt+0x3a80>
    140a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001410 <XDefineCursor@plt>:
    1410:	f3 0f 1e fa          	endbr64
    1414:	ff 25 3e 3b 00 00    	jmp    *0x3b3e(%rip)        # 4f58 <fork@plt+0x3a88>
    141a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001420 <XGetWMProtocols@plt>:
    1420:	f3 0f 1e fa          	endbr64
    1424:	ff 25 36 3b 00 00    	jmp    *0x3b36(%rip)        # 4f60 <fork@plt+0x3a90>
    142a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001430 <XUnmapWindow@plt>:
    1430:	f3 0f 1e fa          	endbr64
    1434:	ff 25 2e 3b 00 00    	jmp    *0x3b2e(%rip)        # 4f68 <fork@plt+0x3a98>
    143a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001440 <XFlush@plt>:
    1440:	f3 0f 1e fa          	endbr64
    1444:	ff 25 26 3b 00 00    	jmp    *0x3b26(%rip)        # 4f70 <fork@plt+0x3aa0>
    144a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001450 <XGetWindowAttributes@plt>:
    1450:	f3 0f 1e fa          	endbr64
    1454:	ff 25 1e 3b 00 00    	jmp    *0x3b1e(%rip)        # 4f78 <fork@plt+0x3aa8>
    145a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001460 <XMapWindow@plt>:
    1460:	f3 0f 1e fa          	endbr64
    1464:	ff 25 16 3b 00 00    	jmp    *0x3b16(%rip)        # 4f80 <fork@plt+0x3ab0>
    146a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001470 <XRaiseWindow@plt>:
    1470:	f3 0f 1e fa          	endbr64
    1474:	ff 25 0e 3b 00 00    	jmp    *0x3b0e(%rip)        # 4f88 <fork@plt+0x3ab8>
    147a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001480 <execl@plt>:
    1480:	f3 0f 1e fa          	endbr64
    1484:	ff 25 06 3b 00 00    	jmp    *0x3b06(%rip)        # 4f90 <fork@plt+0x3ac0>
    148a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001490 <XCloseDisplay@plt>:
    1490:	f3 0f 1e fa          	endbr64
    1494:	ff 25 fe 3a 00 00    	jmp    *0x3afe(%rip)        # 4f98 <fork@plt+0x3ac8>
    149a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000014a0 <XkbKeycodeToKeysym@plt>:
    14a0:	f3 0f 1e fa          	endbr64
    14a4:	ff 25 f6 3a 00 00    	jmp    *0x3af6(%rip)        # 4fa0 <fork@plt+0x3ad0>
    14aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000014b0 <XSetInputFocus@plt>:
    14b0:	f3 0f 1e fa          	endbr64
    14b4:	ff 25 ee 3a 00 00    	jmp    *0x3aee(%rip)        # 4fa8 <fork@plt+0x3ad8>
    14ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000014c0 <XGetInputFocus@plt>:
    14c0:	f3 0f 1e fa          	endbr64
    14c4:	ff 25 e6 3a 00 00    	jmp    *0x3ae6(%rip)        # 4fb0 <fork@plt+0x3ae0>
    14ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000014d0 <fork@plt>:
    14d0:	f3 0f 1e fa          	endbr64
    14d4:	ff 25 de 3a 00 00    	jmp    *0x3ade(%rip)        # 4fb8 <fork@plt+0x3ae8>
    14da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

Disassembly of section .text:

00000000000014e0 <.text>:
    14e0:	f3 0f 1e fa          	endbr64
    14e4:	41 56                	push   %r14
    14e6:	bf 0f 00 00 00       	mov    $0xf,%edi
    14eb:	41 55                	push   %r13
    14ed:	41 54                	push   %r12
    14ef:	55                   	push   %rbp
    14f0:	53                   	push   %rbx
    14f1:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
    14f8:	64 48 8b 1c 25 28 00 	mov    %fs:0x28,%rbx
    14ff:	00 00 
    1501:	48 89 9c 24 88 00 00 	mov    %rbx,0x88(%rsp)
    1508:	00 
    1509:	48 8d 1d c9 02 00 00 	lea    0x2c9(%rip),%rbx        # 17d9 <fork@plt+0x309>
    1510:	48 89 de             	mov    %rbx,%rsi
    1513:	e8 58 fe ff ff       	call   1370 <signal@plt>
    1518:	bf 02 00 00 00       	mov    $0x2,%edi
    151d:	48 89 de             	mov    %rbx,%rsi
    1520:	e8 4b fe ff ff       	call   1370 <signal@plt>
    1525:	48 8d 3d 08 1b 00 00 	lea    0x1b08(%rip),%rdi        # 3034 <fork@plt+0x1b64>
    152c:	e8 6f fd ff ff       	call   12a0 <getenv@plt>
    1531:	48 85 c0             	test   %rax,%rax
    1534:	75 05                	jne    153b <fork@plt+0x6b>
    1536:	e8 ab 02 00 00       	call   17e6 <fork@plt+0x316>
    153b:	31 ff                	xor    %edi,%edi
    153d:	e8 3e fe ff ff       	call   1380 <XOpenDisplay@plt>
    1542:	48 89 c7             	mov    %rax,%rdi
    1545:	48 89 05 ec 3a 00 00 	mov    %rax,0x3aec(%rip)        # 5038 <fork@plt+0x3b68>
    154c:	48 85 c0             	test   %rax,%rax
    154f:	74 e5                	je     1536 <fork@plt+0x66>
    1551:	48 63 80 e0 00 00 00 	movslq 0xe0(%rax),%rax
    1558:	48 89 e2             	mov    %rsp,%rdx
    155b:	48 c1 e0 07          	shl    $0x7,%rax
    155f:	48 03 87 e8 00 00 00 	add    0xe8(%rdi),%rax
    1566:	48 8b 70 10          	mov    0x10(%rax),%rsi
    156a:	48 89 35 bf 3a 00 00 	mov    %rsi,0x3abf(%rip)        # 5030 <fork@plt+0x3b60>
    1571:	e8 da fe ff ff       	call   1450 <XGetWindowAttributes@plt>
    1576:	85 c0                	test   %eax,%eax
    1578:	74 bc                	je     1536 <fork@plt+0x66>
    157a:	8b 44 24 08          	mov    0x8(%rsp),%eax
    157e:	48 8d 1d 84 02 00 00 	lea    0x284(%rip),%rbx        # 1809 <fork@plt+0x339>
    1585:	48 89 df             	mov    %rbx,%rdi
    1588:	66 89 05 99 3a 00 00 	mov    %ax,0x3a99(%rip)        # 5028 <fork@plt+0x3b58>
    158f:	8b 44 24 0c          	mov    0xc(%rsp),%eax
    1593:	66 89 05 8c 3a 00 00 	mov    %ax,0x3a8c(%rip)        # 5026 <fork@plt+0x3b56>
    159a:	e8 21 fe ff ff       	call   13c0 <XSetErrorHandler@plt>
    159f:	48 8b 35 8a 3a 00 00 	mov    0x3a8a(%rip),%rsi        # 5030 <fork@plt+0x3b60>
    15a6:	ba 00 00 1a 00       	mov    $0x1a0000,%edx
    15ab:	48 8b 3d 86 3a 00 00 	mov    0x3a86(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    15b2:	e8 49 fe ff ff       	call   1400 <XSelectInput@plt>
    15b7:	48 8b 3d 7a 3a 00 00 	mov    0x3a7a(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    15be:	be 44 00 00 00       	mov    $0x44,%esi
    15c3:	e8 08 fd ff ff       	call   12d0 <XCreateFontCursor@plt>
    15c8:	48 89 c2             	mov    %rax,%rdx
    15cb:	48 85 c0             	test   %rax,%rax
    15ce:	0f 84 62 ff ff ff    	je     1536 <fork@plt+0x66>
    15d4:	48 8b 35 55 3a 00 00 	mov    0x3a55(%rip),%rsi        # 5030 <fork@plt+0x3b60>
    15db:	48 8b 3d 56 3a 00 00 	mov    0x3a56(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    15e2:	e8 29 fe ff ff       	call   1410 <XDefineCursor@plt>
    15e7:	48 89 df             	mov    %rbx,%rdi
    15ea:	bb 31 00 00 00       	mov    $0x31,%ebx
    15ef:	e8 cc fd ff ff       	call   13c0 <XSetErrorHandler@plt>
    15f4:	48 89 df             	mov    %rbx,%rdi
    15f7:	be 01 00 00 00       	mov    $0x1,%esi
    15fc:	48 ff c3             	inc    %rbx
    15ff:	e8 af 0a 00 00       	call   20b3 <fork@plt+0xbe3>
    1604:	48 83 fb 3a          	cmp    $0x3a,%rbx
    1608:	75 ea                	jne    15f4 <fork@plt+0x124>
    160a:	48 8d 1d 4f 1b 00 00 	lea    0x1b4f(%rip),%rbx        # 3160 <fork@plt+0x1c90>
    1611:	48 8d 6b 28          	lea    0x28(%rbx),%rbp
    1615:	48 8b 3b             	mov    (%rbx),%rdi
    1618:	be 01 00 00 00       	mov    $0x1,%esi
    161d:	48 83 c3 08          	add    $0x8,%rbx
    1621:	e8 8d 0a 00 00       	call   20b3 <fork@plt+0xbe3>
    1626:	48 39 eb             	cmp    %rbp,%rbx
    1629:	75 ea                	jne    1615 <fork@plt+0x145>
    162b:	48 8d 1d ee 35 00 00 	lea    0x35ee(%rip),%rbx        # 4c20 <fork@plt+0x3750>
    1632:	48 8d 6b 60          	lea    0x60(%rbx),%rbp
    1636:	48 8b 3b             	mov    (%rbx),%rdi
    1639:	31 f6                	xor    %esi,%esi
    163b:	48 83 c3 10          	add    $0x10,%rbx
    163f:	e8 6f 0a 00 00       	call   20b3 <fork@plt+0xbe3>
    1644:	48 39 eb             	cmp    %rbp,%rbx
    1647:	75 ed                	jne    1636 <fork@plt+0x166>
    1649:	48 8b 3d e8 39 00 00 	mov    0x39e8(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1650:	4c 8d 25 e9 39 00 00 	lea    0x39e9(%rip),%r12        # 5040 <fork@plt+0x3b70>
    1657:	31 f6                	xor    %esi,%esi
    1659:	31 db                	xor    %ebx,%ebx
    165b:	4d 89 e6             	mov    %r12,%r14
    165e:	e8 8d fd ff ff       	call   13f0 <XSync@plt>
    1663:	e8 56 03 00 00       	call   19be <fork@plt+0x4ee>
    1668:	31 ed                	xor    %ebp,%ebp
    166a:	4c 63 eb             	movslq %ebx,%r13
    166d:	48 8b 3d c4 39 00 00 	mov    0x39c4(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1674:	41 3a 6c 24 60       	cmp    0x60(%r12),%bpl
    1679:	73 18                	jae    1693 <fork@plt+0x1c3>
    167b:	40 0f b6 d5          	movzbl %bpl,%edx
    167f:	ff c5                	inc    %ebp
    1681:	49 6b c5 0d          	imul   $0xd,%r13,%rax
    1685:	48 01 d0             	add    %rdx,%rax
    1688:	49 8b 34 c6          	mov    (%r14,%rax,8),%rsi
    168c:	e8 9f fd ff ff       	call   1430 <XUnmapWindow@plt>
    1691:	eb da                	jmp    166d <fork@plt+0x19d>
    1693:	48 ff c3             	inc    %rbx
    1696:	49 83 c4 68          	add    $0x68,%r12
    169a:	48 83 fb 09          	cmp    $0x9,%rbx
    169e:	75 c8                	jne    1668 <fork@plt+0x198>
    16a0:	e8 eb fd ff ff       	call   1490 <XCloseDisplay@plt>
    16a5:	48 8b 84 24 88 00 00 	mov    0x88(%rsp),%rax
    16ac:	00 
    16ad:	64 48 2b 04 25 28 00 	sub    %fs:0x28,%rax
    16b4:	00 00 
    16b6:	74 05                	je     16bd <fork@plt+0x1ed>
    16b8:	e8 53 fc ff ff       	call   1310 <__stack_chk_fail@plt>
    16bd:	48 81 c4 90 00 00 00 	add    $0x90,%rsp
    16c4:	31 c0                	xor    %eax,%eax
    16c6:	5b                   	pop    %rbx
    16c7:	5d                   	pop    %rbp
    16c8:	41 5c                	pop    %r12
    16ca:	41 5d                	pop    %r13
    16cc:	41 5e                	pop    %r14
    16ce:	c3                   	ret
    16cf:	90                   	nop
    16d0:	f3 0f 1e fa          	endbr64
    16d4:	0f ae 5c 24 fc       	stmxcsr -0x4(%rsp)
    16d9:	81 4c 24 fc 40 80 00 	orl    $0x8040,-0x4(%rsp)
    16e0:	00 
    16e1:	0f ae 54 24 fc       	ldmxcsr -0x4(%rsp)
    16e6:	c3                   	ret
    16e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    16ee:	00 00 
    16f0:	f3 0f 1e fa          	endbr64
    16f4:	31 ed                	xor    %ebp,%ebp
    16f6:	49 89 d1             	mov    %rdx,%r9
    16f9:	5e                   	pop    %rsi
    16fa:	48 89 e2             	mov    %rsp,%rdx
    16fd:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    1701:	50                   	push   %rax
    1702:	54                   	push   %rsp
    1703:	45 31 c0             	xor    %r8d,%r8d
    1706:	31 c9                	xor    %ecx,%ecx
    1708:	48 8d 3d d1 fd ff ff 	lea    -0x22f(%rip),%rdi        # 14e0 <fork@plt+0x10>
    170f:	ff 15 ab 38 00 00    	call   *0x38ab(%rip)        # 4fc0 <fork@plt+0x3af0>
    1715:	f4                   	hlt
    1716:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    171d:	00 00 00 
    1720:	48 8d 3d e9 38 00 00 	lea    0x38e9(%rip),%rdi        # 5010 <fork@plt+0x3b40>
    1727:	48 8d 05 e2 38 00 00 	lea    0x38e2(%rip),%rax        # 5010 <fork@plt+0x3b40>
    172e:	48 39 f8             	cmp    %rdi,%rax
    1731:	74 15                	je     1748 <fork@plt+0x278>
    1733:	48 8b 05 8e 38 00 00 	mov    0x388e(%rip),%rax        # 4fc8 <fork@plt+0x3af8>
    173a:	48 85 c0             	test   %rax,%rax
    173d:	74 09                	je     1748 <fork@plt+0x278>
    173f:	ff e0                	jmp    *%rax
    1741:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1748:	c3                   	ret
    1749:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1750:	48 8d 3d b9 38 00 00 	lea    0x38b9(%rip),%rdi        # 5010 <fork@plt+0x3b40>
    1757:	48 8d 35 b2 38 00 00 	lea    0x38b2(%rip),%rsi        # 5010 <fork@plt+0x3b40>
    175e:	48 29 fe             	sub    %rdi,%rsi
    1761:	48 89 f0             	mov    %rsi,%rax
    1764:	48 c1 ee 3f          	shr    $0x3f,%rsi
    1768:	48 c1 f8 03          	sar    $0x3,%rax
    176c:	48 01 c6             	add    %rax,%rsi
    176f:	48 d1 fe             	sar    $1,%rsi
    1772:	74 14                	je     1788 <fork@plt+0x2b8>
    1774:	48 8b 05 5d 38 00 00 	mov    0x385d(%rip),%rax        # 4fd8 <fork@plt+0x3b08>
    177b:	48 85 c0             	test   %rax,%rax
    177e:	74 08                	je     1788 <fork@plt+0x2b8>
    1780:	ff e0                	jmp    *%rax
    1782:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1788:	c3                   	ret
    1789:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1790:	f3 0f 1e fa          	endbr64
    1794:	80 3d 85 38 00 00 00 	cmpb   $0x0,0x3885(%rip)        # 5020 <fork@plt+0x3b50>
    179b:	75 2b                	jne    17c8 <fork@plt+0x2f8>
    179d:	55                   	push   %rbp
    179e:	48 83 3d 3a 38 00 00 	cmpq   $0x0,0x383a(%rip)        # 4fe0 <fork@plt+0x3b10>
    17a5:	00 
    17a6:	48 89 e5             	mov    %rsp,%rbp
    17a9:	74 0c                	je     17b7 <fork@plt+0x2e7>
    17ab:	48 8b 3d 4e 38 00 00 	mov    0x384e(%rip),%rdi        # 5000 <fork@plt+0x3b30>
    17b2:	e8 c9 fa ff ff       	call   1280 <__cxa_finalize@plt>
    17b7:	e8 64 ff ff ff       	call   1720 <fork@plt+0x250>
    17bc:	c6 05 5d 38 00 00 01 	movb   $0x1,0x385d(%rip)        # 5020 <fork@plt+0x3b50>
    17c3:	5d                   	pop    %rbp
    17c4:	c3                   	ret
    17c5:	0f 1f 00             	nopl   (%rax)
    17c8:	c3                   	ret
    17c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    17d0:	f3 0f 1e fa          	endbr64
    17d4:	e9 77 ff ff ff       	jmp    1750 <fork@plt+0x280>
    17d9:	f3 0f 1e fa          	endbr64
    17dd:	31 c0                	xor    %eax,%eax
    17df:	89 05 27 38 00 00    	mov    %eax,0x3827(%rip)        # 500c <fork@plt+0x3b3c>
    17e5:	c3                   	ret
    17e6:	50                   	push   %rax
    17e7:	58                   	pop    %rax
    17e8:	bf 02 00 00 00       	mov    $0x2,%edi
    17ed:	ba 0a 00 00 00       	mov    $0xa,%edx
    17f2:	48 8d 35 07 18 00 00 	lea    0x1807(%rip),%rsi        # 3000 <fork@plt+0x1b30>
    17f9:	50                   	push   %rax
    17fa:	e8 e1 fa ff ff       	call   12e0 <write@plt>
    17ff:	bf 01 00 00 00       	mov    $0x1,%edi
    1804:	e8 b7 fa ff ff       	call   12c0 <_exit@plt>
    1809:	f3 0f 1e fa          	endbr64
    180d:	80 3d f4 37 00 00 00 	cmpb   $0x0,0x37f4(%rip)        # 5008 <fork@plt+0x3b38>
    1814:	74 0d                	je     1823 <fork@plt+0x353>
    1816:	50                   	push   %rax
    1817:	c6 05 ea 37 00 00 00 	movb   $0x0,0x37ea(%rip)        # 5008 <fork@plt+0x3b38>
    181e:	e8 c3 ff ff ff       	call   17e6 <fork@plt+0x316>
    1823:	31 c0                	xor    %eax,%eax
    1825:	c3                   	ret
    1826:	48 89 fe             	mov    %rdi,%rsi
    1829:	48 8b 3d 08 38 00 00 	mov    0x3808(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1830:	31 c9                	xor    %ecx,%ecx
    1832:	ba 02 00 00 00       	mov    $0x2,%edx
    1837:	e9 74 fc ff ff       	jmp    14b0 <XSetInputFocus@plt>
    183c:	8a 4e 60             	mov    0x60(%rsi),%cl
    183f:	31 c0                	xor    %eax,%eax
    1841:	0f b6 d0             	movzbl %al,%edx
    1844:	38 c8                	cmp    %cl,%al
    1846:	73 4e                	jae    1896 <fork@plt+0x3c6>
    1848:	4c 8d 40 01          	lea    0x1(%rax),%r8
    184c:	48 39 3c c6          	cmp    %rdi,(%rsi,%rax,8)
    1850:	75 3f                	jne    1891 <fork@plt+0x3c1>
    1852:	48 8d 04 c6          	lea    (%rsi,%rax,8),%rax
    1856:	0f b6 f9             	movzbl %cl,%edi
    1859:	ff cf                	dec    %edi
    185b:	48 83 c0 08          	add    $0x8,%rax
    185f:	39 d7                	cmp    %edx,%edi
    1861:	7e 0b                	jle    186e <fork@plt+0x39e>
    1863:	4c 8b 00             	mov    (%rax),%r8
    1866:	ff c2                	inc    %edx
    1868:	4c 89 40 f8          	mov    %r8,-0x8(%rax)
    186c:	eb ed                	jmp    185b <fork@plt+0x38b>
    186e:	8d 51 ff             	lea    -0x1(%rcx),%edx
    1871:	88 56 60             	mov    %dl,0x60(%rsi)
    1874:	84 d2                	test   %dl,%dl
    1876:	74 1e                	je     1896 <fork@plt+0x3c6>
    1878:	8a 46 61             	mov    0x61(%rsi),%al
    187b:	38 d0                	cmp    %dl,%al
    187d:	72 06                	jb     1885 <fork@plt+0x3b5>
    187f:	8d 41 fe             	lea    -0x2(%rcx),%eax
    1882:	88 46 61             	mov    %al,0x61(%rsi)
    1885:	0f b6 c0             	movzbl %al,%eax
    1888:	48 8b 3c c6          	mov    (%rsi,%rax,8),%rdi
    188c:	e9 95 ff ff ff       	jmp    1826 <fork@plt+0x356>
    1891:	4c 89 c0             	mov    %r8,%rax
    1894:	eb ab                	jmp    1841 <fork@plt+0x371>
    1896:	c3                   	ret
    1897:	0f b6 15 86 37 00 00 	movzbl 0x3786(%rip),%edx        # 5024 <fork@plt+0x3b54>
    189e:	41 56                	push   %r14
    18a0:	41 55                	push   %r13
    18a2:	4c 8d 2d 97 37 00 00 	lea    0x3797(%rip),%r13        # 5040 <fork@plt+0x3b70>
    18a9:	41 54                	push   %r12
    18ab:	55                   	push   %rbp
    18ac:	48 6b d2 68          	imul   $0x68,%rdx,%rdx
    18b0:	53                   	push   %rbx
    18b1:	4c 01 ea             	add    %r13,%rdx
    18b4:	0f b6 42 60          	movzbl 0x60(%rdx),%eax
    18b8:	84 c0                	test   %al,%al
    18ba:	0f 84 f5 00 00 00    	je     19b5 <fork@plt+0x4e5>
    18c0:	44 0f b7 05 60 37 00 	movzwl 0x3760(%rip),%r8d        # 5028 <fork@plt+0x3b58>
    18c7:	00 
    18c8:	44 0f b7 0d 56 37 00 	movzwl 0x3756(%rip),%r9d        # 5026 <fork@plt+0x3b56>
    18cf:	00 
    18d0:	48 8b 32             	mov    (%rdx),%rsi
    18d3:	48 8b 3d 5e 37 00 00 	mov    0x375e(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    18da:	44 89 c5             	mov    %r8d,%ebp
    18dd:	3c 01                	cmp    $0x1,%al
    18df:	75 25                	jne    1906 <fork@plt+0x436>
    18e1:	31 c9                	xor    %ecx,%ecx
    18e3:	31 d2                	xor    %edx,%edx
    18e5:	e8 56 fa ff ff       	call   1340 <XMoveResizeWindow@plt>
    18ea:	0f b6 05 33 37 00 00 	movzbl 0x3733(%rip),%eax        # 5024 <fork@plt+0x3b54>
    18f1:	48 8b 3d 40 37 00 00 	mov    0x3740(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    18f8:	48 6b c0 68          	imul   $0x68,%rax,%rax
    18fc:	49 8b 74 05 00       	mov    0x0(%r13,%rax,1),%rsi
    1901:	e9 a2 00 00 00       	jmp    19a8 <fork@plt+0x4d8>
    1906:	0f bf 15 15 37 00 00 	movswl 0x3715(%rip),%edx        # 5022 <fork@plt+0x3b52>
    190d:	41 8d 14 50          	lea    (%r8,%rdx,2),%edx
    1911:	d1 fa                	sar    $1,%edx
    1913:	89 d3                	mov    %edx,%ebx
    1915:	66 83 fa 63          	cmp    $0x63,%dx
    1919:	76 11                	jbe    192c <fork@plt+0x45c>
    191b:	41 83 e8 63          	sub    $0x63,%r8d
    191f:	0f b7 d2             	movzwl %dx,%edx
    1922:	41 39 d0             	cmp    %edx,%r8d
    1925:	7f 0a                	jg     1931 <fork@plt+0x461>
    1927:	8d 5d 9c             	lea    -0x64(%rbp),%ebx
    192a:	eb 05                	jmp    1931 <fork@plt+0x461>
    192c:	bb 64 00 00 00       	mov    $0x64,%ebx
    1931:	8d 48 ff             	lea    -0x1(%rax),%ecx
    1934:	44 89 c8             	mov    %r9d,%eax
    1937:	29 dd                	sub    %ebx,%ebp
    1939:	99                   	cltd
    193a:	0f b7 db             	movzwl %bx,%ebx
    193d:	41 b6 01             	mov    $0x1,%r14b
    1940:	f7 f9                	idiv   %ecx
    1942:	41 89 d8             	mov    %ebx,%r8d
    1945:	31 c9                	xor    %ecx,%ecx
    1947:	31 d2                	xor    %edx,%edx
    1949:	0f b7 ed             	movzwl %bp,%ebp
    194c:	41 89 c4             	mov    %eax,%r12d
    194f:	e8 ec f9 ff ff       	call   1340 <XMoveResizeWindow@plt>
    1954:	0f b6 05 c9 36 00 00 	movzbl 0x36c9(%rip),%eax        # 5024 <fork@plt+0x3b54>
    195b:	48 8b 3d d6 36 00 00 	mov    0x36d6(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1962:	48 6b d0 68          	imul   $0x68,%rax,%rdx
    1966:	4c 01 ea             	add    %r13,%rdx
    1969:	44 3a 72 60          	cmp    0x60(%rdx),%r14b
    196d:	73 29                	jae    1998 <fork@plt+0x4c8>
    196f:	41 0f b6 d6          	movzbl %r14b,%edx
    1973:	45 89 e1             	mov    %r12d,%r9d
    1976:	48 6b c0 0d          	imul   $0xd,%rax,%rax
    197a:	41 89 e8             	mov    %ebp,%r8d
    197d:	41 ff c6             	inc    %r14d
    1980:	8d 4a ff             	lea    -0x1(%rdx),%ecx
    1983:	41 0f af cc          	imul   %r12d,%ecx
    1987:	48 01 d0             	add    %rdx,%rax
    198a:	89 da                	mov    %ebx,%edx
    198c:	49 8b 74 c5 00       	mov    0x0(%r13,%rax,8),%rsi
    1991:	e8 aa f9 ff ff       	call   1340 <XMoveResizeWindow@plt>
    1996:	eb bc                	jmp    1954 <fork@plt+0x484>
    1998:	48 6b c0 0d          	imul   $0xd,%rax,%rax
    199c:	0f b6 52 61          	movzbl 0x61(%rdx),%edx
    19a0:	48 01 d0             	add    %rdx,%rax
    19a3:	49 8b 74 c5 00       	mov    0x0(%r13,%rax,8),%rsi
    19a8:	5b                   	pop    %rbx
    19a9:	5d                   	pop    %rbp
    19aa:	41 5c                	pop    %r12
    19ac:	41 5d                	pop    %r13
    19ae:	41 5e                	pop    %r14
    19b0:	e9 bb fa ff ff       	jmp    1470 <XRaiseWindow@plt>
    19b5:	5b                   	pop    %rbx
    19b6:	5d                   	pop    %rbp
    19b7:	41 5c                	pop    %r12
    19b9:	41 5d                	pop    %r13
    19bb:	41 5e                	pop    %r14
    19bd:	c3                   	ret
    19be:	41 57                	push   %r15
    19c0:	41 56                	push   %r14
    19c2:	41 55                	push   %r13
    19c4:	41 54                	push   %r12
    19c6:	55                   	push   %rbp
    19c7:	53                   	push   %rbx
    19c8:	48 81 ec 38 02 00 00 	sub    $0x238,%rsp
    19cf:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    19d6:	00 00 
    19d8:	48 89 84 24 28 02 00 	mov    %rax,0x228(%rsp)
    19df:	00 
    19e0:	48 8b 05 51 36 00 00 	mov    0x3651(%rip),%rax        # 5038 <fork@plt+0x3b68>
    19e7:	4c 63 68 10          	movslq 0x10(%rax),%r13
    19eb:	4c 89 ed             	mov    %r13,%rbp
    19ee:	8b 05 18 36 00 00    	mov    0x3618(%rip),%eax        # 500c <fork@plt+0x3b3c>
    19f4:	85 c0                	test   %eax,%eax
    19f6:	0f 84 8d 06 00 00    	je     2089 <fork@plt+0xbb9>
    19fc:	4c 8d 25 39 17 00 00 	lea    0x1739(%rip),%r12        # 313c <fork@plt+0x1c6c>
    1a03:	48 8b 3d 2e 36 00 00 	mov    0x362e(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1a0a:	e8 e1 f8 ff ff       	call   12f0 <XPending@plt>
    1a0f:	85 c0                	test   %eax,%eax
    1a11:	0f 84 21 06 00 00    	je     2038 <fork@plt+0xb68>
    1a17:	48 8b 3d 1a 36 00 00 	mov    0x361a(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1a1e:	48 8d b4 24 a8 00 00 	lea    0xa8(%rsp),%rsi
    1a25:	00 
    1a26:	e8 a5 f9 ff ff       	call   13d0 <XNextEvent@plt>
    1a2b:	8b 84 24 a8 00 00 00 	mov    0xa8(%rsp),%eax
    1a32:	83 f8 02             	cmp    $0x2,%eax
    1a35:	74 12                	je     1a49 <fork@plt+0x579>
    1a37:	83 e8 11             	sub    $0x11,%eax
    1a3a:	83 f8 05             	cmp    $0x5,%eax
    1a3d:	77 c4                	ja     1a03 <fork@plt+0x533>
    1a3f:	49 63 04 84          	movslq (%r12,%rax,4),%rax
    1a43:	4c 01 e0             	add    %r12,%rax
    1a46:	3e ff e0             	notrack jmp *%rax
    1a49:	0f b6 b4 24 fc 00 00 	movzbl 0xfc(%rsp),%esi
    1a50:	00 
    1a51:	31 c9                	xor    %ecx,%ecx
    1a53:	31 d2                	xor    %edx,%edx
    1a55:	48 8b 3d dc 35 00 00 	mov    0x35dc(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1a5c:	e8 3f fa ff ff       	call   14a0 <XkbKeycodeToKeysym@plt>
    1a61:	44 8b b4 24 f8 00 00 	mov    0xf8(%rsp),%r14d
    1a68:	00 
    1a69:	48 83 f8 71          	cmp    $0x71,%rax
    1a6d:	0f 94 c2             	sete   %dl
    1a70:	41 83 fe 41          	cmp    $0x41,%r14d
    1a74:	0f 94 c1             	sete   %cl
    1a77:	84 d2                	test   %dl,%dl
    1a79:	74 11                	je     1a8c <fork@plt+0x5bc>
    1a7b:	84 c9                	test   %cl,%cl
    1a7d:	74 0d                	je     1a8c <fork@plt+0x5bc>
    1a7f:	31 c9                	xor    %ecx,%ecx
    1a81:	89 0d 85 35 00 00    	mov    %ecx,0x3585(%rip)        # 500c <fork@plt+0x3b3c>
    1a87:	e9 77 ff ff ff       	jmp    1a03 <fork@plt+0x533>
    1a8c:	48 89 c6             	mov    %rax,%rsi
    1a8f:	48 83 e6 fb          	and    $0xfffffffffffffffb,%rsi
    1a93:	48 83 fe 68          	cmp    $0x68,%rsi
    1a97:	75 20                	jne    1ab9 <fork@plt+0x5e9>
    1a99:	84 c9                	test   %cl,%cl
    1a9b:	74 1c                	je     1ab9 <fork@plt+0x5e9>
    1a9d:	ba ce ff ff ff       	mov    $0xffffffce,%edx
    1aa2:	48 83 f8 6c          	cmp    $0x6c,%rax
    1aa6:	75 05                	jne    1aad <fork@plt+0x5dd>
    1aa8:	ba 32 00 00 00       	mov    $0x32,%edx
    1aad:	66 01 15 6e 35 00 00 	add    %dx,0x356e(%rip)        # 5022 <fork@plt+0x3b52>
    1ab4:	e9 75 05 00 00       	jmp    202e <fork@plt+0xb5e>
    1ab9:	41 83 fe 40          	cmp    $0x40,%r14d
    1abd:	0f 94 c1             	sete   %cl
    1ac0:	84 d2                	test   %dl,%dl
    1ac2:	0f 84 54 01 00 00    	je     1c1c <fork@plt+0x74c>
    1ac8:	84 c9                	test   %cl,%cl
    1aca:	0f 84 4c 01 00 00    	je     1c1c <fork@plt+0x74c>
    1ad0:	0f b6 05 4d 35 00 00 	movzbl 0x354d(%rip),%eax        # 5024 <fork@plt+0x3b54>
    1ad7:	48 8d 15 62 35 00 00 	lea    0x3562(%rip),%rdx        # 5040 <fork@plt+0x3b70>
    1ade:	48 6b c8 68          	imul   $0x68,%rax,%rcx
    1ae2:	48 6b c0 0d          	imul   $0xd,%rax,%rax
    1ae6:	0f b6 4c 0a 61       	movzbl 0x61(%rdx,%rcx,1),%ecx
    1aeb:	48 01 c8             	add    %rcx,%rax
    1aee:	48 8b 1c c2          	mov    (%rdx,%rax,8),%rbx
    1af2:	48 85 db             	test   %rbx,%rbx
    1af5:	0f 84 08 ff ff ff    	je     1a03 <fork@plt+0x533>
    1afb:	48 3b 1d 2e 35 00 00 	cmp    0x352e(%rip),%rbx        # 5030 <fork@plt+0x3b60>
    1b02:	0f 84 fb fe ff ff    	je     1a03 <fork@plt+0x533>
    1b08:	48 8b 3d 29 35 00 00 	mov    0x3529(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1b0f:	48 8d 35 f5 14 00 00 	lea    0x14f5(%rip),%rsi        # 300b <fork@plt+0x1b3b>
    1b16:	31 d2                	xor    %edx,%edx
    1b18:	e8 c3 f8 ff ff       	call   13e0 <XInternAtom@plt>
    1b1d:	48 8d 4c 24 1c       	lea    0x1c(%rsp),%rcx
    1b22:	31 d2                	xor    %edx,%edx
    1b24:	48 89 de             	mov    %rbx,%rsi
    1b27:	48 8b 3d 0a 35 00 00 	mov    0x350a(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1b2e:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    1b33:	49 89 c6             	mov    %rax,%r14
    1b36:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    1b3b:	e8 e0 f8 ff ff       	call   1420 <XGetWMProtocols@plt>
    1b40:	85 c0                	test   %eax,%eax
    1b42:	0f 84 b4 00 00 00    	je     1bfc <fork@plt+0x72c>
    1b48:	8b 54 24 1c          	mov    0x1c(%rsp),%edx
    1b4c:	31 c0                	xor    %eax,%eax
    1b4e:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    1b53:	39 c2                	cmp    %eax,%edx
    1b55:	0f 8e 9c 00 00 00    	jle    1bf7 <fork@plt+0x727>
    1b5b:	48 ff c0             	inc    %rax
    1b5e:	4c 3b 74 c7 f8       	cmp    -0x8(%rdi,%rax,8),%r14
    1b63:	75 ee                	jne    1b53 <fork@plt+0x683>
    1b65:	48 8d 94 24 6c 01 00 	lea    0x16c(%rsp),%rdx
    1b6c:	00 
    1b6d:	31 c0                	xor    %eax,%eax
    1b6f:	b9 2f 00 00 00       	mov    $0x2f,%ecx
    1b74:	c7 84 24 68 01 00 00 	movl   $0x21,0x168(%rsp)
    1b7b:	21 00 00 00 
    1b7f:	4c 8d 84 24 68 01 00 	lea    0x168(%rsp),%r8
    1b86:	00 
    1b87:	48 89 d7             	mov    %rdx,%rdi
    1b8a:	31 d2                	xor    %edx,%edx
    1b8c:	f3 ab                	rep stos %eax,%es:(%rdi)
    1b8e:	48 8b 3d a3 34 00 00 	mov    0x34a3(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1b95:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)
    1b9a:	48 8d 35 7b 14 00 00 	lea    0x147b(%rip),%rsi        # 301c <fork@plt+0x1b4c>
    1ba1:	48 89 9c 24 88 01 00 	mov    %rbx,0x188(%rsp)
    1ba8:	00 
    1ba9:	e8 32 f8 ff ff       	call   13e0 <XInternAtom@plt>
    1bae:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    1bb3:	31 c9                	xor    %ecx,%ecx
    1bb5:	31 d2                	xor    %edx,%edx
    1bb7:	48 8b 3d 7a 34 00 00 	mov    0x347a(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1bbe:	48 89 de             	mov    %rbx,%rsi
    1bc1:	48 89 84 24 90 01 00 	mov    %rax,0x190(%rsp)
    1bc8:	00 
    1bc9:	31 c0                	xor    %eax,%eax
    1bcb:	c7 84 24 98 01 00 00 	movl   $0x20,0x198(%rsp)
    1bd2:	20 00 00 00 
    1bd6:	4c 89 b4 24 a0 01 00 	mov    %r14,0x1a0(%rsp)
    1bdd:	00 
    1bde:	48 89 84 24 a8 01 00 	mov    %rax,0x1a8(%rsp)
    1be5:	00 
    1be6:	e8 a5 f6 ff ff       	call   1290 <XSendEvent@plt>
    1beb:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    1bf0:	e8 2b f7 ff ff       	call   1320 <XFree@plt>
    1bf5:	eb 14                	jmp    1c0b <fork@plt+0x73b>
    1bf7:	e8 24 f7 ff ff       	call   1320 <XFree@plt>
    1bfc:	48 8b 3d 35 34 00 00 	mov    0x3435(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1c03:	48 89 de             	mov    %rbx,%rsi
    1c06:	e8 f5 f6 ff ff       	call   1300 <XKillClient@plt>
    1c0b:	48 8b 3d 26 34 00 00 	mov    0x3426(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1c12:	e8 29 f8 ff ff       	call   1440 <XFlush@plt>
    1c17:	e9 e7 fd ff ff       	jmp    1a03 <fork@plt+0x533>
    1c1c:	48 8d 50 96          	lea    -0x6a(%rax),%rdx
    1c20:	48 83 fa 01          	cmp    $0x1,%rdx
    1c24:	0f 87 84 00 00 00    	ja     1cae <fork@plt+0x7de>
    1c2a:	41 83 fe 40          	cmp    $0x40,%r14d
    1c2e:	0f 85 28 02 00 00    	jne    1e5c <fork@plt+0x98c>
    1c34:	0f b6 15 e9 33 00 00 	movzbl 0x33e9(%rip),%edx        # 5024 <fork@plt+0x3b54>
    1c3b:	48 8d 3d fe 33 00 00 	lea    0x33fe(%rip),%rdi        # 5040 <fork@plt+0x3b70>
    1c42:	48 6b f2 68          	imul   $0x68,%rdx,%rsi
    1c46:	48 01 fe             	add    %rdi,%rsi
    1c49:	0f b6 4e 60          	movzbl 0x60(%rsi),%ecx
    1c4d:	80 f9 01             	cmp    $0x1,%cl
    1c50:	0f 86 ad fd ff ff    	jbe    1a03 <fork@plt+0x533>
    1c56:	44 0f b6 46 61       	movzbl 0x61(%rsi),%r8d
    1c5b:	83 ce ff             	or     $0xffffffff,%esi
    1c5e:	48 83 f8 6a          	cmp    $0x6a,%rax
    1c62:	75 05                	jne    1c69 <fork@plt+0x799>
    1c64:	be 01 00 00 00       	mov    $0x1,%esi
    1c69:	41 01 f0             	add    %esi,%r8d
    1c6c:	45 31 c9             	xor    %r9d,%r9d
    1c6f:	0f b6 f1             	movzbl %cl,%esi
    1c72:	66 41 83 f8 ff       	cmp    $0xffff,%r8w
    1c77:	44 89 c8             	mov    %r9d,%eax
    1c7a:	0f 44 c6             	cmove  %esi,%eax
    1c7d:	44 01 c0             	add    %r8d,%eax
    1c80:	44 0f bf c0          	movswl %ax,%r8d
    1c84:	41 39 c8             	cmp    %ecx,%r8d
    1c87:	41 0f 4c f1          	cmovl  %r9d,%esi
    1c8b:	48 6b ca 68          	imul   $0x68,%rdx,%rcx
    1c8f:	29 f0                	sub    %esi,%eax
    1c91:	48 6b d2 0d          	imul   $0xd,%rdx,%rdx
    1c95:	88 44 0f 61          	mov    %al,0x61(%rdi,%rcx,1)
    1c99:	48 0f bf c0          	movswq %ax,%rax
    1c9d:	48 01 d0             	add    %rdx,%rax
    1ca0:	48 8b 3c c7          	mov    (%rdi,%rax,8),%rdi
    1ca4:	e8 7d fb ff ff       	call   1826 <fork@plt+0x356>
    1ca9:	e9 55 fd ff ff       	jmp    1a03 <fork@plt+0x533>
    1cae:	48 8d 50 cf          	lea    -0x31(%rax),%rdx
    1cb2:	48 83 fa 08          	cmp    $0x8,%rdx
    1cb6:	0f 87 a0 01 00 00    	ja     1e5c <fork@plt+0x98c>
    1cbc:	48 8b 3d 75 33 00 00 	mov    0x3375(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1cc3:	48 8d 54 24 1c       	lea    0x1c(%rsp),%rdx
    1cc8:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    1ccd:	8d 58 cf             	lea    -0x31(%rax),%ebx
    1cd0:	e8 eb f7 ff ff       	call   14c0 <XGetInputFocus@plt>
    1cd5:	41 83 fe 40          	cmp    $0x40,%r14d
    1cd9:	0f 85 cd 00 00 00    	jne    1dac <fork@plt+0x8dc>
    1cdf:	3a 1d 3f 33 00 00    	cmp    0x333f(%rip),%bl        # 5024 <fork@plt+0x3b54>
    1ce5:	0f 84 18 fd ff ff    	je     1a03 <fork@plt+0x533>
    1ceb:	80 3d 33 33 00 00 00 	cmpb   $0x0,0x3333(%rip)        # 5025 <fork@plt+0x3b55>
    1cf2:	0f 85 0b fd ff ff    	jne    1a03 <fork@plt+0x533>
    1cf8:	c6 05 26 33 00 00 01 	movb   $0x1,0x3326(%rip)        # 5025 <fork@plt+0x3b55>
    1cff:	45 31 ff             	xor    %r15d,%r15d
    1d02:	4c 8d 35 37 33 00 00 	lea    0x3337(%rip),%r14        # 5040 <fork@plt+0x3b70>
    1d09:	0f b6 05 14 33 00 00 	movzbl 0x3314(%rip),%eax        # 5024 <fork@plt+0x3b54>
    1d10:	48 6b d0 68          	imul   $0x68,%rax,%rdx
    1d14:	45 3a 7c 16 60       	cmp    0x60(%r14,%rdx,1),%r15b
    1d19:	73 20                	jae    1d3b <fork@plt+0x86b>
    1d1b:	41 0f b6 d7          	movzbl %r15b,%edx
    1d1f:	48 8b 3d 12 33 00 00 	mov    0x3312(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1d26:	41 ff c7             	inc    %r15d
    1d29:	48 6b c0 0d          	imul   $0xd,%rax,%rax
    1d2d:	48 01 d0             	add    %rdx,%rax
    1d30:	49 8b 34 c6          	mov    (%r14,%rax,8),%rsi
    1d34:	e8 f7 f6 ff ff       	call   1430 <XUnmapWindow@plt>
    1d39:	eb ce                	jmp    1d09 <fork@plt+0x839>
    1d3b:	88 1d e3 32 00 00    	mov    %bl,0x32e3(%rip)        # 5024 <fork@plt+0x3b54>
    1d41:	31 db                	xor    %ebx,%ebx
    1d43:	0f b6 05 da 32 00 00 	movzbl 0x32da(%rip),%eax        # 5024 <fork@plt+0x3b54>
    1d4a:	48 6b d0 68          	imul   $0x68,%rax,%rdx
    1d4e:	41 3a 5c 16 60       	cmp    0x60(%r14,%rdx,1),%bl
    1d53:	73 1e                	jae    1d73 <fork@plt+0x8a3>
    1d55:	0f b6 d3             	movzbl %bl,%edx
    1d58:	48 8b 3d d9 32 00 00 	mov    0x32d9(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1d5f:	ff c3                	inc    %ebx
    1d61:	48 6b c0 0d          	imul   $0xd,%rax,%rax
    1d65:	48 01 d0             	add    %rdx,%rax
    1d68:	49 8b 34 c6          	mov    (%r14,%rax,8),%rsi
    1d6c:	e8 ef f6 ff ff       	call   1460 <XMapWindow@plt>
    1d71:	eb d0                	jmp    1d43 <fork@plt+0x873>
    1d73:	e8 1f fb ff ff       	call   1897 <fork@plt+0x3c7>
    1d78:	0f b6 05 a5 32 00 00 	movzbl 0x32a5(%rip),%eax        # 5024 <fork@plt+0x3b54>
    1d7f:	48 6b d0 68          	imul   $0x68,%rax,%rdx
    1d83:	4c 01 f2             	add    %r14,%rdx
    1d86:	80 7a 60 00          	cmpb   $0x0,0x60(%rdx)
    1d8a:	74 14                	je     1da0 <fork@plt+0x8d0>
    1d8c:	48 6b c0 0d          	imul   $0xd,%rax,%rax
    1d90:	0f b6 52 61          	movzbl 0x61(%rdx),%edx
    1d94:	48 01 d0             	add    %rdx,%rax
    1d97:	49 8b 3c c6          	mov    (%r14,%rax,8),%rdi
    1d9b:	e8 86 fa ff ff       	call   1826 <fork@plt+0x356>
    1da0:	c6 05 7e 32 00 00 00 	movb   $0x0,0x327e(%rip)        # 5025 <fork@plt+0x3b55>
    1da7:	e9 57 fc ff ff       	jmp    1a03 <fork@plt+0x533>
    1dac:	41 83 fe 41          	cmp    $0x41,%r14d
    1db0:	0f 85 4d fc ff ff    	jne    1a03 <fork@plt+0x533>
    1db6:	4c 8b 74 24 20       	mov    0x20(%rsp),%r14
    1dbb:	4d 85 f6             	test   %r14,%r14
    1dbe:	0f 84 3f fc ff ff    	je     1a03 <fork@plt+0x533>
    1dc4:	4c 3b 35 65 32 00 00 	cmp    0x3265(%rip),%r14        # 5030 <fork@plt+0x3b60>
    1dcb:	0f 84 32 fc ff ff    	je     1a03 <fork@plt+0x533>
    1dd1:	0f b6 35 4c 32 00 00 	movzbl 0x324c(%rip),%esi        # 5024 <fork@plt+0x3b54>
    1dd8:	40 38 f3             	cmp    %sil,%bl
    1ddb:	0f 84 22 fc ff ff    	je     1a03 <fork@plt+0x533>
    1de1:	4c 8d 3d 58 32 00 00 	lea    0x3258(%rip),%r15        # 5040 <fork@plt+0x3b70>
    1de8:	0f b6 db             	movzbl %bl,%ebx
    1deb:	48 6b c3 68          	imul   $0x68,%rbx,%rax
    1def:	41 80 7c 07 60 0b    	cmpb   $0xb,0x60(%r15,%rax,1)
    1df5:	0f 87 08 fc ff ff    	ja     1a03 <fork@plt+0x533>
    1dfb:	40 0f b6 c6          	movzbl %sil,%eax
    1dff:	48 6b c0 68          	imul   $0x68,%rax,%rax
    1e03:	48 89 c6             	mov    %rax,%rsi
    1e06:	41 8a 54 07 60       	mov    0x60(%r15,%rax,1),%dl
    1e0b:	31 c0                	xor    %eax,%eax
    1e0d:	4c 01 fe             	add    %r15,%rsi
    1e10:	38 d0                	cmp    %dl,%al
    1e12:	0f 83 eb fb ff ff    	jae    1a03 <fork@plt+0x533>
    1e18:	48 ff c0             	inc    %rax
    1e1b:	4c 3b 74 c6 f8       	cmp    -0x8(%rsi,%rax,8),%r14
    1e20:	75 ee                	jne    1e10 <fork@plt+0x940>
    1e22:	4c 89 f7             	mov    %r14,%rdi
    1e25:	e8 12 fa ff ff       	call   183c <fork@plt+0x36c>
    1e2a:	48 6b d3 68          	imul   $0x68,%rbx,%rdx
    1e2e:	48 8b 3d 03 32 00 00 	mov    0x3203(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1e35:	4c 89 f6             	mov    %r14,%rsi
    1e38:	48 6b db 0d          	imul   $0xd,%rbx,%rbx
    1e3c:	4c 01 fa             	add    %r15,%rdx
    1e3f:	0f b6 42 60          	movzbl 0x60(%rdx),%eax
    1e43:	48 89 c1             	mov    %rax,%rcx
    1e46:	48 01 c3             	add    %rax,%rbx
    1e49:	ff c1                	inc    %ecx
    1e4b:	4d 89 34 df          	mov    %r14,(%r15,%rbx,8)
    1e4f:	88 4a 60             	mov    %cl,0x60(%rdx)
    1e52:	e8 d9 f5 ff ff       	call   1430 <XUnmapWindow@plt>
    1e57:	e9 d2 01 00 00       	jmp    202e <fork@plt+0xb5e>
    1e5c:	48 8d 15 bd 2d 00 00 	lea    0x2dbd(%rip),%rdx        # 4c20 <fork@plt+0x3750>
    1e63:	31 db                	xor    %ebx,%ebx
    1e65:	49 89 d6             	mov    %rdx,%r14
    1e68:	48 39 02             	cmp    %rax,(%rdx)
    1e6b:	75 63                	jne    1ed0 <fork@plt+0xa00>
    1e6d:	84 c9                	test   %cl,%cl
    1e6f:	74 5f                	je     1ed0 <fork@plt+0xa00>
    1e71:	e8 5a f6 ff ff       	call   14d0 <fork@plt>
    1e76:	85 c0                	test   %eax,%eax
    1e78:	0f 85 85 fb ff ff    	jne    1a03 <fork@plt+0x533>
    1e7e:	e8 dd f4 ff ff       	call   1360 <setsid@plt>
    1e83:	31 ff                	xor    %edi,%edi
    1e85:	48 c1 e3 04          	shl    $0x4,%rbx
    1e89:	e8 c2 f4 ff ff       	call   1350 <close@plt>
    1e8e:	bf 01 00 00 00       	mov    $0x1,%edi
    1e93:	e8 b8 f4 ff ff       	call   1350 <close@plt>
    1e98:	bf 02 00 00 00       	mov    $0x2,%edi
    1e9d:	e8 ae f4 ff ff       	call   1350 <close@plt>
    1ea2:	49 8b 4c 1e 08       	mov    0x8(%r14,%rbx,1),%rcx
    1ea7:	45 31 c0             	xor    %r8d,%r8d
    1eaa:	31 c0                	xor    %eax,%eax
    1eac:	48 8d 3d 79 11 00 00 	lea    0x1179(%rip),%rdi        # 302c <fork@plt+0x1b5c>
    1eb3:	48 8d 15 6f 11 00 00 	lea    0x116f(%rip),%rdx        # 3029 <fork@plt+0x1b59>
    1eba:	48 8d 35 70 11 00 00 	lea    0x1170(%rip),%rsi        # 3031 <fork@plt+0x1b61>
    1ec1:	e8 ba f5 ff ff       	call   1480 <execl@plt>
    1ec6:	bf 01 00 00 00       	mov    $0x1,%edi
    1ecb:	e8 f0 f3 ff ff       	call   12c0 <_exit@plt>
    1ed0:	ff c3                	inc    %ebx
    1ed2:	48 83 c2 10          	add    $0x10,%rdx
    1ed6:	83 fb 06             	cmp    $0x6,%ebx
    1ed9:	75 8d                	jne    1e68 <fork@plt+0x998>
    1edb:	e9 23 fb ff ff       	jmp    1a03 <fork@plt+0x533>
    1ee0:	0f b6 15 3d 31 00 00 	movzbl 0x313d(%rip),%edx        # 5024 <fork@plt+0x3b54>
    1ee7:	48 8d 05 52 31 00 00 	lea    0x3152(%rip),%rax        # 5040 <fork@plt+0x3b70>
    1eee:	31 ff                	xor    %edi,%edi
    1ef0:	48 8b 9c 24 d0 00 00 	mov    0xd0(%rsp),%rbx
    1ef7:	00 
    1ef8:	48 6b f2 68          	imul   $0x68,%rdx,%rsi
    1efc:	48 6b ca 68          	imul   $0x68,%rdx,%rcx
    1f00:	40 8a 74 30 60       	mov    0x60(%rax,%rsi,1),%sil
    1f05:	48 01 c1             	add    %rax,%rcx
    1f08:	41 89 f8             	mov    %edi,%r8d
    1f0b:	40 38 f7             	cmp    %sil,%dil
    1f0e:	73 1f                	jae    1f2f <fork@plt+0xa5f>
    1f10:	48 ff c7             	inc    %rdi
    1f13:	48 3b 5c f9 f8       	cmp    -0x8(%rcx,%rdi,8),%rbx
    1f18:	75 ee                	jne    1f08 <fork@plt+0xa38>
    1f1a:	48 6b d2 68          	imul   $0x68,%rdx,%rdx
    1f1e:	48 8b 3d 13 31 00 00 	mov    0x3113(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1f25:	48 89 de             	mov    %rbx,%rsi
    1f28:	44 88 44 10 61       	mov    %r8b,0x61(%rax,%rdx,1)
    1f2d:	eb 30                	jmp    1f5f <fork@plt+0xa8f>
    1f2f:	48 8b 3d 02 31 00 00 	mov    0x3102(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    1f36:	40 80 fe 0c          	cmp    $0xc,%sil
    1f3a:	74 35                	je     1f71 <fork@plt+0xaa1>
    1f3c:	48 6b ca 0d          	imul   $0xd,%rdx,%rcx
    1f40:	44 0f b6 c6          	movzbl %sil,%r8d
    1f44:	48 6b d2 68          	imul   $0x68,%rdx,%rdx
    1f48:	4c 01 c1             	add    %r8,%rcx
    1f4b:	48 89 1c c8          	mov    %rbx,(%rax,%rcx,8)
    1f4f:	48 01 d0             	add    %rdx,%rax
    1f52:	8d 56 01             	lea    0x1(%rsi),%edx
    1f55:	40 88 70 61          	mov    %sil,0x61(%rax)
    1f59:	48 89 de             	mov    %rbx,%rsi
    1f5c:	88 50 60             	mov    %dl,0x60(%rax)
    1f5f:	e8 fc f4 ff ff       	call   1460 <XMapWindow@plt>
    1f64:	48 89 df             	mov    %rbx,%rdi
    1f67:	e8 ba f8 ff ff       	call   1826 <fork@plt+0x356>
    1f6c:	e9 bd 00 00 00       	jmp    202e <fork@plt+0xb5e>
    1f71:	48 89 de             	mov    %rbx,%rsi
    1f74:	e9 8d fc ff ff       	jmp    1c06 <fork@plt+0x736>
    1f79:	80 3d a5 30 00 00 00 	cmpb   $0x0,0x30a5(%rip)        # 5025 <fork@plt+0x3b55>
    1f80:	0f 85 03 01 00 00    	jne    2089 <fork@plt+0xbb9>
    1f86:	0f b6 35 97 30 00 00 	movzbl 0x3097(%rip),%esi        # 5024 <fork@plt+0x3b54>
    1f8d:	48 8d 05 ac 30 00 00 	lea    0x30ac(%rip),%rax        # 5040 <fork@plt+0x3b70>
    1f94:	48 8b bc 24 d0 00 00 	mov    0xd0(%rsp),%rdi
    1f9b:	00 
    1f9c:	48 6b f6 68          	imul   $0x68,%rsi,%rsi
    1fa0:	48 01 c6             	add    %rax,%rsi
    1fa3:	e8 94 f8 ff ff       	call   183c <fork@plt+0x36c>
    1fa8:	e9 81 00 00 00       	jmp    202e <fork@plt+0xb5e>
    1fad:	4c 8b bc 24 d0 00 00 	mov    0xd0(%rsp),%r15
    1fb4:	00 
    1fb5:	48 8d 1d 84 30 00 00 	lea    0x3084(%rip),%rbx        # 5040 <fork@plt+0x3b70>
    1fbc:	45 31 f6             	xor    %r14d,%r14d
    1fbf:	8a 53 60             	mov    0x60(%rbx),%dl
    1fc2:	31 c0                	xor    %eax,%eax
    1fc4:	38 d0                	cmp    %dl,%al
    1fc6:	73 23                	jae    1feb <fork@plt+0xb1b>
    1fc8:	48 ff c0             	inc    %rax
    1fcb:	4c 3b 7c c3 f8       	cmp    -0x8(%rbx,%rax,8),%r15
    1fd0:	75 f2                	jne    1fc4 <fork@plt+0xaf4>
    1fd2:	48 89 de             	mov    %rbx,%rsi
    1fd5:	4c 89 ff             	mov    %r15,%rdi
    1fd8:	e8 5f f8 ff ff       	call   183c <fork@plt+0x36c>
    1fdd:	44 3a 35 40 30 00 00 	cmp    0x3040(%rip),%r14b        # 5024 <fork@plt+0x3b54>
    1fe4:	75 05                	jne    1feb <fork@plt+0xb1b>
    1fe6:	e8 ac f8 ff ff       	call   1897 <fork@plt+0x3c7>
    1feb:	41 ff c6             	inc    %r14d
    1fee:	48 83 c3 68          	add    $0x68,%rbx
    1ff2:	41 80 fe 09          	cmp    $0x9,%r14b
    1ff6:	75 c7                	jne    1fbf <fork@plt+0xaef>
    1ff8:	e9 06 fa ff ff       	jmp    1a03 <fork@plt+0x533>
    1ffd:	48 8b 05 2c 30 00 00 	mov    0x302c(%rip),%rax        # 5030 <fork@plt+0x3b60>
    2004:	48 39 84 24 d0 00 00 	cmp    %rax,0xd0(%rsp)
    200b:	00 
    200c:	0f 85 f1 f9 ff ff    	jne    1a03 <fork@plt+0x533>
    2012:	8b 84 24 e0 00 00 00 	mov    0xe0(%rsp),%eax
    2019:	66 89 05 08 30 00 00 	mov    %ax,0x3008(%rip)        # 5028 <fork@plt+0x3b58>
    2020:	8b 84 24 e4 00 00 00 	mov    0xe4(%rsp),%eax
    2027:	66 89 05 f8 2f 00 00 	mov    %ax,0x2ff8(%rip)        # 5026 <fork@plt+0x3b56>
    202e:	e8 64 f8 ff ff       	call   1897 <fork@plt+0x3c7>
    2033:	e9 cb f9 ff ff       	jmp    1a03 <fork@plt+0x533>
    2038:	48 8d 5c 24 28       	lea    0x28(%rsp),%rbx
    203d:	b9 20 00 00 00       	mov    $0x20,%ecx
    2042:	48 89 df             	mov    %rbx,%rdi
    2045:	f3 ab                	rep stos %eax,%es:(%rdi)
    2047:	4c 89 ef             	mov    %r13,%rdi
    204a:	e8 e1 f2 ff ff       	call   1330 <__fdelt_chk@plt>
    204f:	89 e9                	mov    %ebp,%ecx
    2051:	45 31 c0             	xor    %r8d,%r8d
    2054:	48 89 de             	mov    %rbx,%rsi
    2057:	8d 7d 01             	lea    0x1(%rbp),%edi
    205a:	48 89 c2             	mov    %rax,%rdx
    205d:	b8 01 00 00 00       	mov    $0x1,%eax
    2062:	48 d3 e0             	shl    %cl,%rax
    2065:	31 c9                	xor    %ecx,%ecx
    2067:	48 09 44 d4 28       	or     %rax,0x28(%rsp,%rdx,8)
    206c:	31 d2                	xor    %edx,%edx
    206e:	e8 3d f3 ff ff       	call   13b0 <select@plt>
    2073:	ff c0                	inc    %eax
    2075:	0f 85 73 f9 ff ff    	jne    19ee <fork@plt+0x51e>
    207b:	e8 30 f2 ff ff       	call   12b0 <__errno_location@plt>
    2080:	83 38 04             	cmpl   $0x4,(%rax)
    2083:	0f 84 65 f9 ff ff    	je     19ee <fork@plt+0x51e>
    2089:	48 8b 84 24 28 02 00 	mov    0x228(%rsp),%rax
    2090:	00 
    2091:	64 48 2b 04 25 28 00 	sub    %fs:0x28,%rax
    2098:	00 00 
    209a:	74 05                	je     20a1 <fork@plt+0xbd1>
    209c:	e8 6f f2 ff ff       	call   1310 <__stack_chk_fail@plt>
    20a1:	48 81 c4 38 02 00 00 	add    $0x238,%rsp
    20a8:	5b                   	pop    %rbx
    20a9:	5d                   	pop    %rbp
    20aa:	41 5c                	pop    %r12
    20ac:	41 5d                	pop    %r13
    20ae:	41 5e                	pop    %r14
    20b0:	41 5f                	pop    %r15
    20b2:	c3                   	ret
    20b3:	55                   	push   %rbp
    20b4:	89 f5                	mov    %esi,%ebp
    20b6:	48 89 fe             	mov    %rdi,%rsi
    20b9:	53                   	push   %rbx
    20ba:	41 52                	push   %r10
    20bc:	48 8b 3d 75 2f 00 00 	mov    0x2f75(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    20c3:	e8 c8 f2 ff ff       	call   1390 <XKeysymToKeycode@plt>
    20c8:	84 c0                	test   %al,%al
    20ca:	74 5f                	je     212b <fork@plt+0xc5b>
    20cc:	48 8b 0d 5d 2f 00 00 	mov    0x2f5d(%rip),%rcx        # 5030 <fork@plt+0x3b60>
    20d3:	57                   	push   %rdi
    20d4:	0f b6 d8             	movzbl %al,%ebx
    20d7:	ba 40 00 00 00       	mov    $0x40,%edx
    20dc:	6a 01                	push   $0x1
    20de:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    20e4:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    20ea:	89 de                	mov    %ebx,%esi
    20ec:	48 8b 3d 45 2f 00 00 	mov    0x2f45(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    20f3:	e8 a8 f2 ff ff       	call   13a0 <XGrabKey@plt>
    20f8:	41 58                	pop    %r8
    20fa:	41 59                	pop    %r9
    20fc:	85 ed                	test   %ebp,%ebp
    20fe:	74 2b                	je     212b <fork@plt+0xc5b>
    2100:	48 8b 0d 29 2f 00 00 	mov    0x2f29(%rip),%rcx        # 5030 <fork@plt+0x3b60>
    2107:	89 de                	mov    %ebx,%esi
    2109:	52                   	push   %rdx
    210a:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    2110:	48 8b 3d 21 2f 00 00 	mov    0x2f21(%rip),%rdi        # 5038 <fork@plt+0x3b68>
    2117:	6a 01                	push   $0x1
    2119:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    211f:	ba 41 00 00 00       	mov    $0x41,%edx
    2124:	e8 77 f2 ff ff       	call   13a0 <XGrabKey@plt>
    2129:	59                   	pop    %rcx
    212a:	5e                   	pop    %rsi
    212b:	58                   	pop    %rax
    212c:	5b                   	pop    %rbx
    212d:	5d                   	pop    %rbp
    212e:	c3                   	ret

Disassembly of section .fini:

0000000000002130 <.fini>:
    2130:	f3 0f 1e fa          	endbr64
    2134:	48 83 ec 08          	sub    $0x8,%rsp
    2138:	48 83 c4 08          	add    $0x8,%rsp
    213c:	c3                   	ret
