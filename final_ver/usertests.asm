
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
      11:	68 b6 4d 00 00       	push   $0x4db6
      16:	6a 01                	push   $0x1
      18:	e8 43 3a 00 00       	call   3a60 <printf>
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
      21:	68 ca 4d 00 00       	push   $0x4dca
      26:	e8 e8 38 00 00       	call   3913 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
      32:	52                   	push   %edx
      33:	52                   	push   %edx
      34:	68 34 55 00 00       	push   $0x5534
      39:	6a 01                	push   $0x1
      3b:	e8 20 3a 00 00       	call   3a60 <printf>
      40:	e8 8e 38 00 00       	call   38d3 <exit>
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
      4c:	68 ca 4d 00 00       	push   $0x4dca
      51:	e8 bd 38 00 00       	call   3913 <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 9d 38 00 00       	call   38fb <close>
      5e:	e8 8d 35 00 00       	call   35f0 <argptest>
      63:	e8 b8 11 00 00       	call   1220 <createdelete>
      68:	e8 83 1a 00 00       	call   1af0 <linkunlink>
      6d:	e8 7e 17 00 00       	call   17f0 <concreate>
      72:	e8 a9 0f 00 00       	call   1020 <fourfiles>
      77:	e8 e4 0d 00 00       	call   e60 <sharedfd>
      7c:	e8 1f 32 00 00       	call   32a0 <bigargtest>
      81:	e8 8a 23 00 00       	call   2410 <bigwrite>
      86:	e8 15 32 00 00       	call   32a0 <bigargtest>
      8b:	e8 a0 31 00 00       	call   3230 <bsstest>
      90:	e8 bb 2c 00 00       	call   2d50 <sbrktest>
      95:	e8 e6 30 00 00       	call   3180 <validatetest>
      9a:	e8 61 03 00 00       	call   400 <opentest>
      9f:	e8 ec 03 00 00       	call   490 <writetest>
      a4:	e8 c7 05 00 00       	call   670 <writetest1>
      a9:	e8 92 07 00 00       	call   840 <createtest>
      ae:	e8 4d 02 00 00       	call   300 <openiputtest>
      b3:	e8 48 01 00 00       	call   200 <exitiputtest>
      b8:	e8 63 00 00 00       	call   120 <iputtest>
      bd:	e8 ce 0c 00 00       	call   d90 <mem>
      c2:	e8 59 09 00 00       	call   a20 <pipe1>
      c7:	e8 e4 0a 00 00       	call   bb0 <preempt>
      cc:	e8 3f 0c 00 00       	call   d10 <exitwait>
      d1:	e8 2a 27 00 00       	call   2800 <rmdot>
      d6:	e8 e5 25 00 00       	call   26c0 <fourteen>
      db:	e8 10 24 00 00       	call   24f0 <bigfile>
      e0:	e8 4b 1c 00 00       	call   1d30 <subdir>
      e5:	e8 f6 14 00 00       	call   15e0 <linktest>
      ea:	e8 61 13 00 00       	call   1450 <unlinkread>
      ef:	e8 8c 28 00 00       	call   2980 <dirfile>
      f4:	e8 87 2a 00 00       	call   2b80 <iref>
      f9:	e8 a2 2b 00 00       	call   2ca0 <forktest>
      fe:	e8 fd 1a 00 00       	call   1c00 <bigdir>
     103:	e8 78 34 00 00       	call   3580 <uio>
     108:	e8 c3 08 00 00       	call   9d0 <exectest>
     10d:	e8 c1 37 00 00       	call   38d3 <exit>
     112:	66 90                	xchg   %ax,%ax
     114:	66 90                	xchg   %ax,%ax
     116:	66 90                	xchg   %ax,%ax
     118:	66 90                	xchg   %ax,%ax
     11a:	66 90                	xchg   %ax,%ax
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <iputtest>:
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	83 ec 10             	sub    $0x10,%esp
     126:	68 5c 3e 00 00       	push   $0x3e5c
     12b:	ff 35 60 5e 00 00    	pushl  0x5e60
     131:	e8 2a 39 00 00       	call   3a60 <printf>
     136:	c7 04 24 ef 3d 00 00 	movl   $0x3def,(%esp)
     13d:	e8 f9 37 00 00       	call   393b <mkdir>
     142:	83 c4 10             	add    $0x10,%esp
     145:	85 c0                	test   %eax,%eax
     147:	78 58                	js     1a1 <iputtest+0x81>
     149:	83 ec 0c             	sub    $0xc,%esp
     14c:	68 ef 3d 00 00       	push   $0x3def
     151:	e8 ed 37 00 00       	call   3943 <chdir>
     156:	83 c4 10             	add    $0x10,%esp
     159:	85 c0                	test   %eax,%eax
     15b:	0f 88 85 00 00 00    	js     1e6 <iputtest+0xc6>
     161:	83 ec 0c             	sub    $0xc,%esp
     164:	68 ec 3d 00 00       	push   $0x3dec
     169:	e8 b5 37 00 00       	call   3923 <unlink>
     16e:	83 c4 10             	add    $0x10,%esp
     171:	85 c0                	test   %eax,%eax
     173:	78 5a                	js     1cf <iputtest+0xaf>
     175:	83 ec 0c             	sub    $0xc,%esp
     178:	68 11 3e 00 00       	push   $0x3e11
     17d:	e8 c1 37 00 00       	call   3943 <chdir>
     182:	83 c4 10             	add    $0x10,%esp
     185:	85 c0                	test   %eax,%eax
     187:	78 2f                	js     1b8 <iputtest+0x98>
     189:	83 ec 08             	sub    $0x8,%esp
     18c:	68 94 3e 00 00       	push   $0x3e94
     191:	ff 35 60 5e 00 00    	pushl  0x5e60
     197:	e8 c4 38 00 00       	call   3a60 <printf>
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	c9                   	leave  
     1a0:	c3                   	ret    
     1a1:	50                   	push   %eax
     1a2:	50                   	push   %eax
     1a3:	68 c8 3d 00 00       	push   $0x3dc8
     1a8:	ff 35 60 5e 00 00    	pushl  0x5e60
     1ae:	e8 ad 38 00 00       	call   3a60 <printf>
     1b3:	e8 1b 37 00 00       	call   38d3 <exit>
     1b8:	50                   	push   %eax
     1b9:	50                   	push   %eax
     1ba:	68 13 3e 00 00       	push   $0x3e13
     1bf:	ff 35 60 5e 00 00    	pushl  0x5e60
     1c5:	e8 96 38 00 00       	call   3a60 <printf>
     1ca:	e8 04 37 00 00       	call   38d3 <exit>
     1cf:	52                   	push   %edx
     1d0:	52                   	push   %edx
     1d1:	68 f7 3d 00 00       	push   $0x3df7
     1d6:	ff 35 60 5e 00 00    	pushl  0x5e60
     1dc:	e8 7f 38 00 00       	call   3a60 <printf>
     1e1:	e8 ed 36 00 00       	call   38d3 <exit>
     1e6:	51                   	push   %ecx
     1e7:	51                   	push   %ecx
     1e8:	68 d6 3d 00 00       	push   $0x3dd6
     1ed:	ff 35 60 5e 00 00    	pushl  0x5e60
     1f3:	e8 68 38 00 00       	call   3a60 <printf>
     1f8:	e8 d6 36 00 00       	call   38d3 <exit>
     1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <exitiputtest>:
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 10             	sub    $0x10,%esp
     206:	68 23 3e 00 00       	push   $0x3e23
     20b:	ff 35 60 5e 00 00    	pushl  0x5e60
     211:	e8 4a 38 00 00       	call   3a60 <printf>
     216:	e8 b0 36 00 00       	call   38cb <fork>
     21b:	83 c4 10             	add    $0x10,%esp
     21e:	85 c0                	test   %eax,%eax
     220:	0f 88 8a 00 00 00    	js     2b0 <exitiputtest+0xb0>
     226:	75 50                	jne    278 <exitiputtest+0x78>
     228:	83 ec 0c             	sub    $0xc,%esp
     22b:	68 ef 3d 00 00       	push   $0x3def
     230:	e8 06 37 00 00       	call   393b <mkdir>
     235:	83 c4 10             	add    $0x10,%esp
     238:	85 c0                	test   %eax,%eax
     23a:	0f 88 87 00 00 00    	js     2c7 <exitiputtest+0xc7>
     240:	83 ec 0c             	sub    $0xc,%esp
     243:	68 ef 3d 00 00       	push   $0x3def
     248:	e8 f6 36 00 00       	call   3943 <chdir>
     24d:	83 c4 10             	add    $0x10,%esp
     250:	85 c0                	test   %eax,%eax
     252:	0f 88 86 00 00 00    	js     2de <exitiputtest+0xde>
     258:	83 ec 0c             	sub    $0xc,%esp
     25b:	68 ec 3d 00 00       	push   $0x3dec
     260:	e8 be 36 00 00       	call   3923 <unlink>
     265:	83 c4 10             	add    $0x10,%esp
     268:	85 c0                	test   %eax,%eax
     26a:	78 2c                	js     298 <exitiputtest+0x98>
     26c:	e8 62 36 00 00       	call   38d3 <exit>
     271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     278:	e8 5e 36 00 00       	call   38db <wait>
     27d:	83 ec 08             	sub    $0x8,%esp
     280:	68 46 3e 00 00       	push   $0x3e46
     285:	ff 35 60 5e 00 00    	pushl  0x5e60
     28b:	e8 d0 37 00 00       	call   3a60 <printf>
     290:	83 c4 10             	add    $0x10,%esp
     293:	c9                   	leave  
     294:	c3                   	ret    
     295:	8d 76 00             	lea    0x0(%esi),%esi
     298:	83 ec 08             	sub    $0x8,%esp
     29b:	68 f7 3d 00 00       	push   $0x3df7
     2a0:	ff 35 60 5e 00 00    	pushl  0x5e60
     2a6:	e8 b5 37 00 00       	call   3a60 <printf>
     2ab:	e8 23 36 00 00       	call   38d3 <exit>
     2b0:	51                   	push   %ecx
     2b1:	51                   	push   %ecx
     2b2:	68 09 4d 00 00       	push   $0x4d09
     2b7:	ff 35 60 5e 00 00    	pushl  0x5e60
     2bd:	e8 9e 37 00 00       	call   3a60 <printf>
     2c2:	e8 0c 36 00 00       	call   38d3 <exit>
     2c7:	52                   	push   %edx
     2c8:	52                   	push   %edx
     2c9:	68 c8 3d 00 00       	push   $0x3dc8
     2ce:	ff 35 60 5e 00 00    	pushl  0x5e60
     2d4:	e8 87 37 00 00       	call   3a60 <printf>
     2d9:	e8 f5 35 00 00       	call   38d3 <exit>
     2de:	50                   	push   %eax
     2df:	50                   	push   %eax
     2e0:	68 32 3e 00 00       	push   $0x3e32
     2e5:	ff 35 60 5e 00 00    	pushl  0x5e60
     2eb:	e8 70 37 00 00       	call   3a60 <printf>
     2f0:	e8 de 35 00 00       	call   38d3 <exit>
     2f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000300 <openiputtest>:
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	83 ec 10             	sub    $0x10,%esp
     306:	68 58 3e 00 00       	push   $0x3e58
     30b:	ff 35 60 5e 00 00    	pushl  0x5e60
     311:	e8 4a 37 00 00       	call   3a60 <printf>
     316:	c7 04 24 67 3e 00 00 	movl   $0x3e67,(%esp)
     31d:	e8 19 36 00 00       	call   393b <mkdir>
     322:	83 c4 10             	add    $0x10,%esp
     325:	85 c0                	test   %eax,%eax
     327:	0f 88 9f 00 00 00    	js     3cc <openiputtest+0xcc>
     32d:	e8 99 35 00 00       	call   38cb <fork>
     332:	85 c0                	test   %eax,%eax
     334:	78 7f                	js     3b5 <openiputtest+0xb5>
     336:	75 38                	jne    370 <openiputtest+0x70>
     338:	83 ec 08             	sub    $0x8,%esp
     33b:	6a 02                	push   $0x2
     33d:	68 67 3e 00 00       	push   $0x3e67
     342:	e8 cc 35 00 00       	call   3913 <open>
     347:	83 c4 10             	add    $0x10,%esp
     34a:	85 c0                	test   %eax,%eax
     34c:	78 62                	js     3b0 <openiputtest+0xb0>
     34e:	83 ec 08             	sub    $0x8,%esp
     351:	68 ec 4d 00 00       	push   $0x4dec
     356:	ff 35 60 5e 00 00    	pushl  0x5e60
     35c:	e8 ff 36 00 00       	call   3a60 <printf>
     361:	e8 6d 35 00 00       	call   38d3 <exit>
     366:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     36d:	8d 76 00             	lea    0x0(%esi),%esi
     370:	83 ec 0c             	sub    $0xc,%esp
     373:	6a 01                	push   $0x1
     375:	e8 e9 35 00 00       	call   3963 <sleep>
     37a:	c7 04 24 67 3e 00 00 	movl   $0x3e67,(%esp)
     381:	e8 9d 35 00 00       	call   3923 <unlink>
     386:	83 c4 10             	add    $0x10,%esp
     389:	85 c0                	test   %eax,%eax
     38b:	75 56                	jne    3e3 <openiputtest+0xe3>
     38d:	e8 49 35 00 00       	call   38db <wait>
     392:	83 ec 08             	sub    $0x8,%esp
     395:	68 90 3e 00 00       	push   $0x3e90
     39a:	ff 35 60 5e 00 00    	pushl  0x5e60
     3a0:	e8 bb 36 00 00       	call   3a60 <printf>
     3a5:	83 c4 10             	add    $0x10,%esp
     3a8:	c9                   	leave  
     3a9:	c3                   	ret    
     3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     3b0:	e8 1e 35 00 00       	call   38d3 <exit>
     3b5:	52                   	push   %edx
     3b6:	52                   	push   %edx
     3b7:	68 09 4d 00 00       	push   $0x4d09
     3bc:	ff 35 60 5e 00 00    	pushl  0x5e60
     3c2:	e8 99 36 00 00       	call   3a60 <printf>
     3c7:	e8 07 35 00 00       	call   38d3 <exit>
     3cc:	51                   	push   %ecx
     3cd:	51                   	push   %ecx
     3ce:	68 6d 3e 00 00       	push   $0x3e6d
     3d3:	ff 35 60 5e 00 00    	pushl  0x5e60
     3d9:	e8 82 36 00 00       	call   3a60 <printf>
     3de:	e8 f0 34 00 00       	call   38d3 <exit>
     3e3:	50                   	push   %eax
     3e4:	50                   	push   %eax
     3e5:	68 81 3e 00 00       	push   $0x3e81
     3ea:	ff 35 60 5e 00 00    	pushl  0x5e60
     3f0:	e8 6b 36 00 00       	call   3a60 <printf>
     3f5:	e8 d9 34 00 00       	call   38d3 <exit>
     3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000400 <opentest>:
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	83 ec 10             	sub    $0x10,%esp
     406:	68 a2 3e 00 00       	push   $0x3ea2
     40b:	ff 35 60 5e 00 00    	pushl  0x5e60
     411:	e8 4a 36 00 00       	call   3a60 <printf>
     416:	58                   	pop    %eax
     417:	5a                   	pop    %edx
     418:	6a 00                	push   $0x0
     41a:	68 ad 3e 00 00       	push   $0x3ead
     41f:	e8 ef 34 00 00       	call   3913 <open>
     424:	83 c4 10             	add    $0x10,%esp
     427:	85 c0                	test   %eax,%eax
     429:	78 36                	js     461 <opentest+0x61>
     42b:	83 ec 0c             	sub    $0xc,%esp
     42e:	50                   	push   %eax
     42f:	e8 c7 34 00 00       	call   38fb <close>
     434:	5a                   	pop    %edx
     435:	59                   	pop    %ecx
     436:	6a 00                	push   $0x0
     438:	68 c5 3e 00 00       	push   $0x3ec5
     43d:	e8 d1 34 00 00       	call   3913 <open>
     442:	83 c4 10             	add    $0x10,%esp
     445:	85 c0                	test   %eax,%eax
     447:	79 2f                	jns    478 <opentest+0x78>
     449:	83 ec 08             	sub    $0x8,%esp
     44c:	68 f0 3e 00 00       	push   $0x3ef0
     451:	ff 35 60 5e 00 00    	pushl  0x5e60
     457:	e8 04 36 00 00       	call   3a60 <printf>
     45c:	83 c4 10             	add    $0x10,%esp
     45f:	c9                   	leave  
     460:	c3                   	ret    
     461:	50                   	push   %eax
     462:	50                   	push   %eax
     463:	68 b2 3e 00 00       	push   $0x3eb2
     468:	ff 35 60 5e 00 00    	pushl  0x5e60
     46e:	e8 ed 35 00 00       	call   3a60 <printf>
     473:	e8 5b 34 00 00       	call   38d3 <exit>
     478:	50                   	push   %eax
     479:	50                   	push   %eax
     47a:	68 d2 3e 00 00       	push   $0x3ed2
     47f:	ff 35 60 5e 00 00    	pushl  0x5e60
     485:	e8 d6 35 00 00       	call   3a60 <printf>
     48a:	e8 44 34 00 00       	call   38d3 <exit>
     48f:	90                   	nop

00000490 <writetest>:
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	56                   	push   %esi
     494:	53                   	push   %ebx
     495:	83 ec 08             	sub    $0x8,%esp
     498:	68 fe 3e 00 00       	push   $0x3efe
     49d:	ff 35 60 5e 00 00    	pushl  0x5e60
     4a3:	e8 b8 35 00 00       	call   3a60 <printf>
     4a8:	58                   	pop    %eax
     4a9:	5a                   	pop    %edx
     4aa:	68 02 02 00 00       	push   $0x202
     4af:	68 0f 3f 00 00       	push   $0x3f0f
     4b4:	e8 5a 34 00 00       	call   3913 <open>
     4b9:	83 c4 10             	add    $0x10,%esp
     4bc:	85 c0                	test   %eax,%eax
     4be:	0f 88 88 01 00 00    	js     64c <writetest+0x1bc>
     4c4:	83 ec 08             	sub    $0x8,%esp
     4c7:	89 c6                	mov    %eax,%esi
     4c9:	31 db                	xor    %ebx,%ebx
     4cb:	68 15 3f 00 00       	push   $0x3f15
     4d0:	ff 35 60 5e 00 00    	pushl  0x5e60
     4d6:	e8 85 35 00 00       	call   3a60 <printf>
     4db:	83 c4 10             	add    $0x10,%esp
     4de:	66 90                	xchg   %ax,%ax
     4e0:	83 ec 04             	sub    $0x4,%esp
     4e3:	6a 0a                	push   $0xa
     4e5:	68 4c 3f 00 00       	push   $0x3f4c
     4ea:	56                   	push   %esi
     4eb:	e8 03 34 00 00       	call   38f3 <write>
     4f0:	83 c4 10             	add    $0x10,%esp
     4f3:	83 f8 0a             	cmp    $0xa,%eax
     4f6:	0f 85 d9 00 00 00    	jne    5d5 <writetest+0x145>
     4fc:	83 ec 04             	sub    $0x4,%esp
     4ff:	6a 0a                	push   $0xa
     501:	68 57 3f 00 00       	push   $0x3f57
     506:	56                   	push   %esi
     507:	e8 e7 33 00 00       	call   38f3 <write>
     50c:	83 c4 10             	add    $0x10,%esp
     50f:	83 f8 0a             	cmp    $0xa,%eax
     512:	0f 85 d6 00 00 00    	jne    5ee <writetest+0x15e>
     518:	83 c3 01             	add    $0x1,%ebx
     51b:	83 fb 64             	cmp    $0x64,%ebx
     51e:	75 c0                	jne    4e0 <writetest+0x50>
     520:	83 ec 08             	sub    $0x8,%esp
     523:	68 62 3f 00 00       	push   $0x3f62
     528:	ff 35 60 5e 00 00    	pushl  0x5e60
     52e:	e8 2d 35 00 00       	call   3a60 <printf>
     533:	89 34 24             	mov    %esi,(%esp)
     536:	e8 c0 33 00 00       	call   38fb <close>
     53b:	5b                   	pop    %ebx
     53c:	5e                   	pop    %esi
     53d:	6a 00                	push   $0x0
     53f:	68 0f 3f 00 00       	push   $0x3f0f
     544:	e8 ca 33 00 00       	call   3913 <open>
     549:	83 c4 10             	add    $0x10,%esp
     54c:	89 c3                	mov    %eax,%ebx
     54e:	85 c0                	test   %eax,%eax
     550:	0f 88 b1 00 00 00    	js     607 <writetest+0x177>
     556:	83 ec 08             	sub    $0x8,%esp
     559:	68 6d 3f 00 00       	push   $0x3f6d
     55e:	ff 35 60 5e 00 00    	pushl  0x5e60
     564:	e8 f7 34 00 00       	call   3a60 <printf>
     569:	83 c4 0c             	add    $0xc,%esp
     56c:	68 d0 07 00 00       	push   $0x7d0
     571:	68 40 86 00 00       	push   $0x8640
     576:	53                   	push   %ebx
     577:	e8 6f 33 00 00       	call   38eb <read>
     57c:	83 c4 10             	add    $0x10,%esp
     57f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     584:	0f 85 94 00 00 00    	jne    61e <writetest+0x18e>
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	68 a1 3f 00 00       	push   $0x3fa1
     592:	ff 35 60 5e 00 00    	pushl  0x5e60
     598:	e8 c3 34 00 00       	call   3a60 <printf>
     59d:	89 1c 24             	mov    %ebx,(%esp)
     5a0:	e8 56 33 00 00       	call   38fb <close>
     5a5:	c7 04 24 0f 3f 00 00 	movl   $0x3f0f,(%esp)
     5ac:	e8 72 33 00 00       	call   3923 <unlink>
     5b1:	83 c4 10             	add    $0x10,%esp
     5b4:	85 c0                	test   %eax,%eax
     5b6:	78 7d                	js     635 <writetest+0x1a5>
     5b8:	83 ec 08             	sub    $0x8,%esp
     5bb:	68 c9 3f 00 00       	push   $0x3fc9
     5c0:	ff 35 60 5e 00 00    	pushl  0x5e60
     5c6:	e8 95 34 00 00       	call   3a60 <printf>
     5cb:	83 c4 10             	add    $0x10,%esp
     5ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5d1:	5b                   	pop    %ebx
     5d2:	5e                   	pop    %esi
     5d3:	5d                   	pop    %ebp
     5d4:	c3                   	ret    
     5d5:	83 ec 04             	sub    $0x4,%esp
     5d8:	53                   	push   %ebx
     5d9:	68 10 4e 00 00       	push   $0x4e10
     5de:	ff 35 60 5e 00 00    	pushl  0x5e60
     5e4:	e8 77 34 00 00       	call   3a60 <printf>
     5e9:	e8 e5 32 00 00       	call   38d3 <exit>
     5ee:	83 ec 04             	sub    $0x4,%esp
     5f1:	53                   	push   %ebx
     5f2:	68 34 4e 00 00       	push   $0x4e34
     5f7:	ff 35 60 5e 00 00    	pushl  0x5e60
     5fd:	e8 5e 34 00 00       	call   3a60 <printf>
     602:	e8 cc 32 00 00       	call   38d3 <exit>
     607:	51                   	push   %ecx
     608:	51                   	push   %ecx
     609:	68 86 3f 00 00       	push   $0x3f86
     60e:	ff 35 60 5e 00 00    	pushl  0x5e60
     614:	e8 47 34 00 00       	call   3a60 <printf>
     619:	e8 b5 32 00 00       	call   38d3 <exit>
     61e:	52                   	push   %edx
     61f:	52                   	push   %edx
     620:	68 cd 42 00 00       	push   $0x42cd
     625:	ff 35 60 5e 00 00    	pushl  0x5e60
     62b:	e8 30 34 00 00       	call   3a60 <printf>
     630:	e8 9e 32 00 00       	call   38d3 <exit>
     635:	50                   	push   %eax
     636:	50                   	push   %eax
     637:	68 b4 3f 00 00       	push   $0x3fb4
     63c:	ff 35 60 5e 00 00    	pushl  0x5e60
     642:	e8 19 34 00 00       	call   3a60 <printf>
     647:	e8 87 32 00 00       	call   38d3 <exit>
     64c:	50                   	push   %eax
     64d:	50                   	push   %eax
     64e:	68 30 3f 00 00       	push   $0x3f30
     653:	ff 35 60 5e 00 00    	pushl  0x5e60
     659:	e8 02 34 00 00       	call   3a60 <printf>
     65e:	e8 70 32 00 00       	call   38d3 <exit>
     663:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     66a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000670 <writetest1>:
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	56                   	push   %esi
     674:	53                   	push   %ebx
     675:	83 ec 08             	sub    $0x8,%esp
     678:	68 dd 3f 00 00       	push   $0x3fdd
     67d:	ff 35 60 5e 00 00    	pushl  0x5e60
     683:	e8 d8 33 00 00       	call   3a60 <printf>
     688:	58                   	pop    %eax
     689:	5a                   	pop    %edx
     68a:	68 02 02 00 00       	push   $0x202
     68f:	68 57 40 00 00       	push   $0x4057
     694:	e8 7a 32 00 00       	call   3913 <open>
     699:	83 c4 10             	add    $0x10,%esp
     69c:	85 c0                	test   %eax,%eax
     69e:	0f 88 61 01 00 00    	js     805 <writetest1+0x195>
     6a4:	89 c6                	mov    %eax,%esi
     6a6:	31 db                	xor    %ebx,%ebx
     6a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6af:	90                   	nop
     6b0:	83 ec 04             	sub    $0x4,%esp
     6b3:	89 1d 40 86 00 00    	mov    %ebx,0x8640
     6b9:	68 00 02 00 00       	push   $0x200
     6be:	68 40 86 00 00       	push   $0x8640
     6c3:	56                   	push   %esi
     6c4:	e8 2a 32 00 00       	call   38f3 <write>
     6c9:	83 c4 10             	add    $0x10,%esp
     6cc:	3d 00 02 00 00       	cmp    $0x200,%eax
     6d1:	0f 85 b3 00 00 00    	jne    78a <writetest1+0x11a>
     6d7:	83 c3 01             	add    $0x1,%ebx
     6da:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6e0:	75 ce                	jne    6b0 <writetest1+0x40>
     6e2:	83 ec 0c             	sub    $0xc,%esp
     6e5:	56                   	push   %esi
     6e6:	e8 10 32 00 00       	call   38fb <close>
     6eb:	5b                   	pop    %ebx
     6ec:	5e                   	pop    %esi
     6ed:	6a 00                	push   $0x0
     6ef:	68 57 40 00 00       	push   $0x4057
     6f4:	e8 1a 32 00 00       	call   3913 <open>
     6f9:	83 c4 10             	add    $0x10,%esp
     6fc:	89 c3                	mov    %eax,%ebx
     6fe:	85 c0                	test   %eax,%eax
     700:	0f 88 e8 00 00 00    	js     7ee <writetest1+0x17e>
     706:	31 f6                	xor    %esi,%esi
     708:	eb 1d                	jmp    727 <writetest1+0xb7>
     70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     710:	3d 00 02 00 00       	cmp    $0x200,%eax
     715:	0f 85 9f 00 00 00    	jne    7ba <writetest1+0x14a>
     71b:	a1 40 86 00 00       	mov    0x8640,%eax
     720:	39 f0                	cmp    %esi,%eax
     722:	75 7f                	jne    7a3 <writetest1+0x133>
     724:	83 c6 01             	add    $0x1,%esi
     727:	83 ec 04             	sub    $0x4,%esp
     72a:	68 00 02 00 00       	push   $0x200
     72f:	68 40 86 00 00       	push   $0x8640
     734:	53                   	push   %ebx
     735:	e8 b1 31 00 00       	call   38eb <read>
     73a:	83 c4 10             	add    $0x10,%esp
     73d:	85 c0                	test   %eax,%eax
     73f:	75 cf                	jne    710 <writetest1+0xa0>
     741:	81 fe 8b 00 00 00    	cmp    $0x8b,%esi
     747:	0f 84 86 00 00 00    	je     7d3 <writetest1+0x163>
     74d:	83 ec 0c             	sub    $0xc,%esp
     750:	53                   	push   %ebx
     751:	e8 a5 31 00 00       	call   38fb <close>
     756:	c7 04 24 57 40 00 00 	movl   $0x4057,(%esp)
     75d:	e8 c1 31 00 00       	call   3923 <unlink>
     762:	83 c4 10             	add    $0x10,%esp
     765:	85 c0                	test   %eax,%eax
     767:	0f 88 af 00 00 00    	js     81c <writetest1+0x1ac>
     76d:	83 ec 08             	sub    $0x8,%esp
     770:	68 7e 40 00 00       	push   $0x407e
     775:	ff 35 60 5e 00 00    	pushl  0x5e60
     77b:	e8 e0 32 00 00       	call   3a60 <printf>
     780:	83 c4 10             	add    $0x10,%esp
     783:	8d 65 f8             	lea    -0x8(%ebp),%esp
     786:	5b                   	pop    %ebx
     787:	5e                   	pop    %esi
     788:	5d                   	pop    %ebp
     789:	c3                   	ret    
     78a:	83 ec 04             	sub    $0x4,%esp
     78d:	53                   	push   %ebx
     78e:	68 07 40 00 00       	push   $0x4007
     793:	ff 35 60 5e 00 00    	pushl  0x5e60
     799:	e8 c2 32 00 00       	call   3a60 <printf>
     79e:	e8 30 31 00 00       	call   38d3 <exit>
     7a3:	50                   	push   %eax
     7a4:	56                   	push   %esi
     7a5:	68 58 4e 00 00       	push   $0x4e58
     7aa:	ff 35 60 5e 00 00    	pushl  0x5e60
     7b0:	e8 ab 32 00 00       	call   3a60 <printf>
     7b5:	e8 19 31 00 00       	call   38d3 <exit>
     7ba:	83 ec 04             	sub    $0x4,%esp
     7bd:	50                   	push   %eax
     7be:	68 5b 40 00 00       	push   $0x405b
     7c3:	ff 35 60 5e 00 00    	pushl  0x5e60
     7c9:	e8 92 32 00 00       	call   3a60 <printf>
     7ce:	e8 00 31 00 00       	call   38d3 <exit>
     7d3:	52                   	push   %edx
     7d4:	68 8b 00 00 00       	push   $0x8b
     7d9:	68 3e 40 00 00       	push   $0x403e
     7de:	ff 35 60 5e 00 00    	pushl  0x5e60
     7e4:	e8 77 32 00 00       	call   3a60 <printf>
     7e9:	e8 e5 30 00 00       	call   38d3 <exit>
     7ee:	51                   	push   %ecx
     7ef:	51                   	push   %ecx
     7f0:	68 25 40 00 00       	push   $0x4025
     7f5:	ff 35 60 5e 00 00    	pushl  0x5e60
     7fb:	e8 60 32 00 00       	call   3a60 <printf>
     800:	e8 ce 30 00 00       	call   38d3 <exit>
     805:	50                   	push   %eax
     806:	50                   	push   %eax
     807:	68 ed 3f 00 00       	push   $0x3fed
     80c:	ff 35 60 5e 00 00    	pushl  0x5e60
     812:	e8 49 32 00 00       	call   3a60 <printf>
     817:	e8 b7 30 00 00       	call   38d3 <exit>
     81c:	50                   	push   %eax
     81d:	50                   	push   %eax
     81e:	68 6b 40 00 00       	push   $0x406b
     823:	ff 35 60 5e 00 00    	pushl  0x5e60
     829:	e8 32 32 00 00       	call   3a60 <printf>
     82e:	e8 a0 30 00 00       	call   38d3 <exit>
     833:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     83a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000840 <createtest>:
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	53                   	push   %ebx
     844:	bb 30 00 00 00       	mov    $0x30,%ebx
     849:	83 ec 0c             	sub    $0xc,%esp
     84c:	68 78 4e 00 00       	push   $0x4e78
     851:	ff 35 60 5e 00 00    	pushl  0x5e60
     857:	e8 04 32 00 00       	call   3a60 <printf>
     85c:	c6 05 40 a6 00 00 61 	movb   $0x61,0xa640
     863:	83 c4 10             	add    $0x10,%esp
     866:	c6 05 42 a6 00 00 00 	movb   $0x0,0xa642
     86d:	8d 76 00             	lea    0x0(%esi),%esi
     870:	83 ec 08             	sub    $0x8,%esp
     873:	88 1d 41 a6 00 00    	mov    %bl,0xa641
     879:	83 c3 01             	add    $0x1,%ebx
     87c:	68 02 02 00 00       	push   $0x202
     881:	68 40 a6 00 00       	push   $0xa640
     886:	e8 88 30 00 00       	call   3913 <open>
     88b:	89 04 24             	mov    %eax,(%esp)
     88e:	e8 68 30 00 00       	call   38fb <close>
     893:	83 c4 10             	add    $0x10,%esp
     896:	80 fb 64             	cmp    $0x64,%bl
     899:	75 d5                	jne    870 <createtest+0x30>
     89b:	c6 05 40 a6 00 00 61 	movb   $0x61,0xa640
     8a2:	bb 30 00 00 00       	mov    $0x30,%ebx
     8a7:	c6 05 42 a6 00 00 00 	movb   $0x0,0xa642
     8ae:	66 90                	xchg   %ax,%ax
     8b0:	83 ec 0c             	sub    $0xc,%esp
     8b3:	88 1d 41 a6 00 00    	mov    %bl,0xa641
     8b9:	83 c3 01             	add    $0x1,%ebx
     8bc:	68 40 a6 00 00       	push   $0xa640
     8c1:	e8 5d 30 00 00       	call   3923 <unlink>
     8c6:	83 c4 10             	add    $0x10,%esp
     8c9:	80 fb 64             	cmp    $0x64,%bl
     8cc:	75 e2                	jne    8b0 <createtest+0x70>
     8ce:	83 ec 08             	sub    $0x8,%esp
     8d1:	68 a0 4e 00 00       	push   $0x4ea0
     8d6:	ff 35 60 5e 00 00    	pushl  0x5e60
     8dc:	e8 7f 31 00 00       	call   3a60 <printf>
     8e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8e4:	83 c4 10             	add    $0x10,%esp
     8e7:	c9                   	leave  
     8e8:	c3                   	ret    
     8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008f0 <dirtest>:
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	83 ec 10             	sub    $0x10,%esp
     8f6:	68 8c 40 00 00       	push   $0x408c
     8fb:	ff 35 60 5e 00 00    	pushl  0x5e60
     901:	e8 5a 31 00 00       	call   3a60 <printf>
     906:	c7 04 24 98 40 00 00 	movl   $0x4098,(%esp)
     90d:	e8 29 30 00 00       	call   393b <mkdir>
     912:	83 c4 10             	add    $0x10,%esp
     915:	85 c0                	test   %eax,%eax
     917:	78 58                	js     971 <dirtest+0x81>
     919:	83 ec 0c             	sub    $0xc,%esp
     91c:	68 98 40 00 00       	push   $0x4098
     921:	e8 1d 30 00 00       	call   3943 <chdir>
     926:	83 c4 10             	add    $0x10,%esp
     929:	85 c0                	test   %eax,%eax
     92b:	0f 88 85 00 00 00    	js     9b6 <dirtest+0xc6>
     931:	83 ec 0c             	sub    $0xc,%esp
     934:	68 3d 46 00 00       	push   $0x463d
     939:	e8 05 30 00 00       	call   3943 <chdir>
     93e:	83 c4 10             	add    $0x10,%esp
     941:	85 c0                	test   %eax,%eax
     943:	78 5a                	js     99f <dirtest+0xaf>
     945:	83 ec 0c             	sub    $0xc,%esp
     948:	68 98 40 00 00       	push   $0x4098
     94d:	e8 d1 2f 00 00       	call   3923 <unlink>
     952:	83 c4 10             	add    $0x10,%esp
     955:	85 c0                	test   %eax,%eax
     957:	78 2f                	js     988 <dirtest+0x98>
     959:	83 ec 08             	sub    $0x8,%esp
     95c:	68 d5 40 00 00       	push   $0x40d5
     961:	ff 35 60 5e 00 00    	pushl  0x5e60
     967:	e8 f4 30 00 00       	call   3a60 <printf>
     96c:	83 c4 10             	add    $0x10,%esp
     96f:	c9                   	leave  
     970:	c3                   	ret    
     971:	50                   	push   %eax
     972:	50                   	push   %eax
     973:	68 c8 3d 00 00       	push   $0x3dc8
     978:	ff 35 60 5e 00 00    	pushl  0x5e60
     97e:	e8 dd 30 00 00       	call   3a60 <printf>
     983:	e8 4b 2f 00 00       	call   38d3 <exit>
     988:	50                   	push   %eax
     989:	50                   	push   %eax
     98a:	68 c1 40 00 00       	push   $0x40c1
     98f:	ff 35 60 5e 00 00    	pushl  0x5e60
     995:	e8 c6 30 00 00       	call   3a60 <printf>
     99a:	e8 34 2f 00 00       	call   38d3 <exit>
     99f:	52                   	push   %edx
     9a0:	52                   	push   %edx
     9a1:	68 b0 40 00 00       	push   $0x40b0
     9a6:	ff 35 60 5e 00 00    	pushl  0x5e60
     9ac:	e8 af 30 00 00       	call   3a60 <printf>
     9b1:	e8 1d 2f 00 00       	call   38d3 <exit>
     9b6:	51                   	push   %ecx
     9b7:	51                   	push   %ecx
     9b8:	68 9d 40 00 00       	push   $0x409d
     9bd:	ff 35 60 5e 00 00    	pushl  0x5e60
     9c3:	e8 98 30 00 00       	call   3a60 <printf>
     9c8:	e8 06 2f 00 00       	call   38d3 <exit>
     9cd:	8d 76 00             	lea    0x0(%esi),%esi

000009d0 <exectest>:
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	83 ec 10             	sub    $0x10,%esp
     9d6:	68 e4 40 00 00       	push   $0x40e4
     9db:	ff 35 60 5e 00 00    	pushl  0x5e60
     9e1:	e8 7a 30 00 00       	call   3a60 <printf>
     9e6:	5a                   	pop    %edx
     9e7:	59                   	pop    %ecx
     9e8:	68 64 5e 00 00       	push   $0x5e64
     9ed:	68 ad 3e 00 00       	push   $0x3ead
     9f2:	e8 14 2f 00 00       	call   390b <exec>
     9f7:	83 c4 10             	add    $0x10,%esp
     9fa:	85 c0                	test   %eax,%eax
     9fc:	78 02                	js     a00 <exectest+0x30>
     9fe:	c9                   	leave  
     9ff:	c3                   	ret    
     a00:	50                   	push   %eax
     a01:	50                   	push   %eax
     a02:	68 ef 40 00 00       	push   $0x40ef
     a07:	ff 35 60 5e 00 00    	pushl  0x5e60
     a0d:	e8 4e 30 00 00       	call   3a60 <printf>
     a12:	e8 bc 2e 00 00       	call   38d3 <exit>
     a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a1e:	66 90                	xchg   %ax,%ax

00000a20 <pipe1>:
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	57                   	push   %edi
     a24:	56                   	push   %esi
     a25:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a28:	53                   	push   %ebx
     a29:	83 ec 38             	sub    $0x38,%esp
     a2c:	50                   	push   %eax
     a2d:	e8 b1 2e 00 00       	call   38e3 <pipe>
     a32:	83 c4 10             	add    $0x10,%esp
     a35:	85 c0                	test   %eax,%eax
     a37:	0f 85 34 01 00 00    	jne    b71 <pipe1+0x151>
     a3d:	e8 89 2e 00 00       	call   38cb <fork>
     a42:	85 c0                	test   %eax,%eax
     a44:	0f 84 89 00 00 00    	je     ad3 <pipe1+0xb3>
     a4a:	0f 8e 34 01 00 00    	jle    b84 <pipe1+0x164>
     a50:	83 ec 0c             	sub    $0xc,%esp
     a53:	ff 75 e4             	pushl  -0x1c(%ebp)
     a56:	31 db                	xor    %ebx,%ebx
     a58:	be 01 00 00 00       	mov    $0x1,%esi
     a5d:	e8 99 2e 00 00       	call   38fb <close>
     a62:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     a69:	83 c4 10             	add    $0x10,%esp
     a6c:	83 ec 04             	sub    $0x4,%esp
     a6f:	56                   	push   %esi
     a70:	68 40 86 00 00       	push   $0x8640
     a75:	ff 75 e0             	pushl  -0x20(%ebp)
     a78:	e8 6e 2e 00 00       	call   38eb <read>
     a7d:	83 c4 10             	add    $0x10,%esp
     a80:	89 c7                	mov    %eax,%edi
     a82:	85 c0                	test   %eax,%eax
     a84:	0f 8e a3 00 00 00    	jle    b2d <pipe1+0x10d>
     a8a:	8d 0c 3b             	lea    (%ebx,%edi,1),%ecx
     a8d:	31 c0                	xor    %eax,%eax
     a8f:	90                   	nop
     a90:	89 da                	mov    %ebx,%edx
     a92:	83 c3 01             	add    $0x1,%ebx
     a95:	38 90 40 86 00 00    	cmp    %dl,0x8640(%eax)
     a9b:	75 1c                	jne    ab9 <pipe1+0x99>
     a9d:	83 c0 01             	add    $0x1,%eax
     aa0:	39 d9                	cmp    %ebx,%ecx
     aa2:	75 ec                	jne    a90 <pipe1+0x70>
     aa4:	01 f6                	add    %esi,%esi
     aa6:	01 7d d4             	add    %edi,-0x2c(%ebp)
     aa9:	b8 00 20 00 00       	mov    $0x2000,%eax
     aae:	81 fe 00 20 00 00    	cmp    $0x2000,%esi
     ab4:	0f 4f f0             	cmovg  %eax,%esi
     ab7:	eb b3                	jmp    a6c <pipe1+0x4c>
     ab9:	83 ec 08             	sub    $0x8,%esp
     abc:	68 1e 41 00 00       	push   $0x411e
     ac1:	6a 01                	push   $0x1
     ac3:	e8 98 2f 00 00       	call   3a60 <printf>
     ac8:	83 c4 10             	add    $0x10,%esp
     acb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ace:	5b                   	pop    %ebx
     acf:	5e                   	pop    %esi
     ad0:	5f                   	pop    %edi
     ad1:	5d                   	pop    %ebp
     ad2:	c3                   	ret    
     ad3:	83 ec 0c             	sub    $0xc,%esp
     ad6:	ff 75 e0             	pushl  -0x20(%ebp)
     ad9:	31 db                	xor    %ebx,%ebx
     adb:	e8 1b 2e 00 00       	call   38fb <close>
     ae0:	83 c4 10             	add    $0x10,%esp
     ae3:	31 c0                	xor    %eax,%eax
     ae5:	8d 76 00             	lea    0x0(%esi),%esi
     ae8:	8d 14 18             	lea    (%eax,%ebx,1),%edx
     aeb:	83 c0 01             	add    $0x1,%eax
     aee:	88 90 3f 86 00 00    	mov    %dl,0x863f(%eax)
     af4:	3d 09 04 00 00       	cmp    $0x409,%eax
     af9:	75 ed                	jne    ae8 <pipe1+0xc8>
     afb:	83 ec 04             	sub    $0x4,%esp
     afe:	81 c3 09 04 00 00    	add    $0x409,%ebx
     b04:	68 09 04 00 00       	push   $0x409
     b09:	68 40 86 00 00       	push   $0x8640
     b0e:	ff 75 e4             	pushl  -0x1c(%ebp)
     b11:	e8 dd 2d 00 00       	call   38f3 <write>
     b16:	83 c4 10             	add    $0x10,%esp
     b19:	3d 09 04 00 00       	cmp    $0x409,%eax
     b1e:	75 77                	jne    b97 <pipe1+0x177>
     b20:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b26:	75 bb                	jne    ae3 <pipe1+0xc3>
     b28:	e8 a6 2d 00 00       	call   38d3 <exit>
     b2d:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b34:	75 26                	jne    b5c <pipe1+0x13c>
     b36:	83 ec 0c             	sub    $0xc,%esp
     b39:	ff 75 e0             	pushl  -0x20(%ebp)
     b3c:	e8 ba 2d 00 00       	call   38fb <close>
     b41:	e8 95 2d 00 00       	call   38db <wait>
     b46:	5a                   	pop    %edx
     b47:	59                   	pop    %ecx
     b48:	68 43 41 00 00       	push   $0x4143
     b4d:	6a 01                	push   $0x1
     b4f:	e8 0c 2f 00 00       	call   3a60 <printf>
     b54:	83 c4 10             	add    $0x10,%esp
     b57:	e9 6f ff ff ff       	jmp    acb <pipe1+0xab>
     b5c:	53                   	push   %ebx
     b5d:	ff 75 d4             	pushl  -0x2c(%ebp)
     b60:	68 2c 41 00 00       	push   $0x412c
     b65:	6a 01                	push   $0x1
     b67:	e8 f4 2e 00 00       	call   3a60 <printf>
     b6c:	e8 62 2d 00 00       	call   38d3 <exit>
     b71:	57                   	push   %edi
     b72:	57                   	push   %edi
     b73:	68 01 41 00 00       	push   $0x4101
     b78:	6a 01                	push   $0x1
     b7a:	e8 e1 2e 00 00       	call   3a60 <printf>
     b7f:	e8 4f 2d 00 00       	call   38d3 <exit>
     b84:	50                   	push   %eax
     b85:	50                   	push   %eax
     b86:	68 4d 41 00 00       	push   $0x414d
     b8b:	6a 01                	push   $0x1
     b8d:	e8 ce 2e 00 00       	call   3a60 <printf>
     b92:	e8 3c 2d 00 00       	call   38d3 <exit>
     b97:	56                   	push   %esi
     b98:	56                   	push   %esi
     b99:	68 10 41 00 00       	push   $0x4110
     b9e:	6a 01                	push   $0x1
     ba0:	e8 bb 2e 00 00       	call   3a60 <printf>
     ba5:	e8 29 2d 00 00       	call   38d3 <exit>
     baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000bb0 <preempt>:
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	57                   	push   %edi
     bb4:	56                   	push   %esi
     bb5:	53                   	push   %ebx
     bb6:	83 ec 24             	sub    $0x24,%esp
     bb9:	68 5c 41 00 00       	push   $0x415c
     bbe:	6a 01                	push   $0x1
     bc0:	e8 9b 2e 00 00       	call   3a60 <printf>
     bc5:	e8 01 2d 00 00       	call   38cb <fork>
     bca:	83 c4 10             	add    $0x10,%esp
     bcd:	85 c0                	test   %eax,%eax
     bcf:	75 07                	jne    bd8 <preempt+0x28>
     bd1:	eb fe                	jmp    bd1 <preempt+0x21>
     bd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bd7:	90                   	nop
     bd8:	89 c7                	mov    %eax,%edi
     bda:	e8 ec 2c 00 00       	call   38cb <fork>
     bdf:	89 c6                	mov    %eax,%esi
     be1:	85 c0                	test   %eax,%eax
     be3:	75 0b                	jne    bf0 <preempt+0x40>
     be5:	eb fe                	jmp    be5 <preempt+0x35>
     be7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bee:	66 90                	xchg   %ax,%ax
     bf0:	83 ec 0c             	sub    $0xc,%esp
     bf3:	8d 45 e0             	lea    -0x20(%ebp),%eax
     bf6:	50                   	push   %eax
     bf7:	e8 e7 2c 00 00       	call   38e3 <pipe>
     bfc:	e8 ca 2c 00 00       	call   38cb <fork>
     c01:	83 c4 10             	add    $0x10,%esp
     c04:	89 c3                	mov    %eax,%ebx
     c06:	85 c0                	test   %eax,%eax
     c08:	75 3e                	jne    c48 <preempt+0x98>
     c0a:	83 ec 0c             	sub    $0xc,%esp
     c0d:	ff 75 e0             	pushl  -0x20(%ebp)
     c10:	e8 e6 2c 00 00       	call   38fb <close>
     c15:	83 c4 0c             	add    $0xc,%esp
     c18:	6a 01                	push   $0x1
     c1a:	68 21 47 00 00       	push   $0x4721
     c1f:	ff 75 e4             	pushl  -0x1c(%ebp)
     c22:	e8 cc 2c 00 00       	call   38f3 <write>
     c27:	83 c4 10             	add    $0x10,%esp
     c2a:	83 f8 01             	cmp    $0x1,%eax
     c2d:	0f 85 a4 00 00 00    	jne    cd7 <preempt+0x127>
     c33:	83 ec 0c             	sub    $0xc,%esp
     c36:	ff 75 e4             	pushl  -0x1c(%ebp)
     c39:	e8 bd 2c 00 00       	call   38fb <close>
     c3e:	83 c4 10             	add    $0x10,%esp
     c41:	eb fe                	jmp    c41 <preempt+0x91>
     c43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c47:	90                   	nop
     c48:	83 ec 0c             	sub    $0xc,%esp
     c4b:	ff 75 e4             	pushl  -0x1c(%ebp)
     c4e:	e8 a8 2c 00 00       	call   38fb <close>
     c53:	83 c4 0c             	add    $0xc,%esp
     c56:	68 00 20 00 00       	push   $0x2000
     c5b:	68 40 86 00 00       	push   $0x8640
     c60:	ff 75 e0             	pushl  -0x20(%ebp)
     c63:	e8 83 2c 00 00       	call   38eb <read>
     c68:	83 c4 10             	add    $0x10,%esp
     c6b:	83 f8 01             	cmp    $0x1,%eax
     c6e:	75 7e                	jne    cee <preempt+0x13e>
     c70:	83 ec 0c             	sub    $0xc,%esp
     c73:	ff 75 e0             	pushl  -0x20(%ebp)
     c76:	e8 80 2c 00 00       	call   38fb <close>
     c7b:	58                   	pop    %eax
     c7c:	5a                   	pop    %edx
     c7d:	68 8d 41 00 00       	push   $0x418d
     c82:	6a 01                	push   $0x1
     c84:	e8 d7 2d 00 00       	call   3a60 <printf>
     c89:	89 3c 24             	mov    %edi,(%esp)
     c8c:	e8 72 2c 00 00       	call   3903 <kill>
     c91:	89 34 24             	mov    %esi,(%esp)
     c94:	e8 6a 2c 00 00       	call   3903 <kill>
     c99:	89 1c 24             	mov    %ebx,(%esp)
     c9c:	e8 62 2c 00 00       	call   3903 <kill>
     ca1:	59                   	pop    %ecx
     ca2:	5b                   	pop    %ebx
     ca3:	68 96 41 00 00       	push   $0x4196
     ca8:	6a 01                	push   $0x1
     caa:	e8 b1 2d 00 00       	call   3a60 <printf>
     caf:	e8 27 2c 00 00       	call   38db <wait>
     cb4:	e8 22 2c 00 00       	call   38db <wait>
     cb9:	e8 1d 2c 00 00       	call   38db <wait>
     cbe:	5e                   	pop    %esi
     cbf:	5f                   	pop    %edi
     cc0:	68 9f 41 00 00       	push   $0x419f
     cc5:	6a 01                	push   $0x1
     cc7:	e8 94 2d 00 00       	call   3a60 <printf>
     ccc:	83 c4 10             	add    $0x10,%esp
     ccf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cd2:	5b                   	pop    %ebx
     cd3:	5e                   	pop    %esi
     cd4:	5f                   	pop    %edi
     cd5:	5d                   	pop    %ebp
     cd6:	c3                   	ret    
     cd7:	83 ec 08             	sub    $0x8,%esp
     cda:	68 66 41 00 00       	push   $0x4166
     cdf:	6a 01                	push   $0x1
     ce1:	e8 7a 2d 00 00       	call   3a60 <printf>
     ce6:	83 c4 10             	add    $0x10,%esp
     ce9:	e9 45 ff ff ff       	jmp    c33 <preempt+0x83>
     cee:	83 ec 08             	sub    $0x8,%esp
     cf1:	68 7a 41 00 00       	push   $0x417a
     cf6:	6a 01                	push   $0x1
     cf8:	e8 63 2d 00 00       	call   3a60 <printf>
     cfd:	83 c4 10             	add    $0x10,%esp
     d00:	eb cd                	jmp    ccf <preempt+0x11f>
     d02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d10 <exitwait>:
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	56                   	push   %esi
     d14:	be 64 00 00 00       	mov    $0x64,%esi
     d19:	53                   	push   %ebx
     d1a:	eb 14                	jmp    d30 <exitwait+0x20>
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d20:	74 68                	je     d8a <exitwait+0x7a>
     d22:	e8 b4 2b 00 00       	call   38db <wait>
     d27:	39 d8                	cmp    %ebx,%eax
     d29:	75 2d                	jne    d58 <exitwait+0x48>
     d2b:	83 ee 01             	sub    $0x1,%esi
     d2e:	74 41                	je     d71 <exitwait+0x61>
     d30:	e8 96 2b 00 00       	call   38cb <fork>
     d35:	89 c3                	mov    %eax,%ebx
     d37:	85 c0                	test   %eax,%eax
     d39:	79 e5                	jns    d20 <exitwait+0x10>
     d3b:	83 ec 08             	sub    $0x8,%esp
     d3e:	68 09 4d 00 00       	push   $0x4d09
     d43:	6a 01                	push   $0x1
     d45:	e8 16 2d 00 00       	call   3a60 <printf>
     d4a:	83 c4 10             	add    $0x10,%esp
     d4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d50:	5b                   	pop    %ebx
     d51:	5e                   	pop    %esi
     d52:	5d                   	pop    %ebp
     d53:	c3                   	ret    
     d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d58:	83 ec 08             	sub    $0x8,%esp
     d5b:	68 ab 41 00 00       	push   $0x41ab
     d60:	6a 01                	push   $0x1
     d62:	e8 f9 2c 00 00       	call   3a60 <printf>
     d67:	83 c4 10             	add    $0x10,%esp
     d6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d6d:	5b                   	pop    %ebx
     d6e:	5e                   	pop    %esi
     d6f:	5d                   	pop    %ebp
     d70:	c3                   	ret    
     d71:	83 ec 08             	sub    $0x8,%esp
     d74:	68 bb 41 00 00       	push   $0x41bb
     d79:	6a 01                	push   $0x1
     d7b:	e8 e0 2c 00 00       	call   3a60 <printf>
     d80:	83 c4 10             	add    $0x10,%esp
     d83:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d86:	5b                   	pop    %ebx
     d87:	5e                   	pop    %esi
     d88:	5d                   	pop    %ebp
     d89:	c3                   	ret    
     d8a:	e8 44 2b 00 00       	call   38d3 <exit>
     d8f:	90                   	nop

00000d90 <mem>:
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	56                   	push   %esi
     d94:	31 f6                	xor    %esi,%esi
     d96:	53                   	push   %ebx
     d97:	83 ec 08             	sub    $0x8,%esp
     d9a:	68 c8 41 00 00       	push   $0x41c8
     d9f:	6a 01                	push   $0x1
     da1:	e8 ba 2c 00 00       	call   3a60 <printf>
     da6:	e8 a8 2b 00 00       	call   3953 <getpid>
     dab:	89 c3                	mov    %eax,%ebx
     dad:	e8 19 2b 00 00       	call   38cb <fork>
     db2:	83 c4 10             	add    $0x10,%esp
     db5:	85 c0                	test   %eax,%eax
     db7:	74 0b                	je     dc4 <mem+0x34>
     db9:	e9 8a 00 00 00       	jmp    e48 <mem+0xb8>
     dbe:	66 90                	xchg   %ax,%ax
     dc0:	89 30                	mov    %esi,(%eax)
     dc2:	89 c6                	mov    %eax,%esi
     dc4:	83 ec 0c             	sub    $0xc,%esp
     dc7:	68 11 27 00 00       	push   $0x2711
     dcc:	e8 ef 2e 00 00       	call   3cc0 <malloc>
     dd1:	83 c4 10             	add    $0x10,%esp
     dd4:	85 c0                	test   %eax,%eax
     dd6:	75 e8                	jne    dc0 <mem+0x30>
     dd8:	85 f6                	test   %esi,%esi
     dda:	74 18                	je     df4 <mem+0x64>
     ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     de0:	89 f0                	mov    %esi,%eax
     de2:	83 ec 0c             	sub    $0xc,%esp
     de5:	8b 36                	mov    (%esi),%esi
     de7:	50                   	push   %eax
     de8:	e8 43 2e 00 00       	call   3c30 <free>
     ded:	83 c4 10             	add    $0x10,%esp
     df0:	85 f6                	test   %esi,%esi
     df2:	75 ec                	jne    de0 <mem+0x50>
     df4:	83 ec 0c             	sub    $0xc,%esp
     df7:	68 00 50 00 00       	push   $0x5000
     dfc:	e8 bf 2e 00 00       	call   3cc0 <malloc>
     e01:	83 c4 10             	add    $0x10,%esp
     e04:	85 c0                	test   %eax,%eax
     e06:	74 20                	je     e28 <mem+0x98>
     e08:	83 ec 0c             	sub    $0xc,%esp
     e0b:	50                   	push   %eax
     e0c:	e8 1f 2e 00 00       	call   3c30 <free>
     e11:	58                   	pop    %eax
     e12:	5a                   	pop    %edx
     e13:	68 ec 41 00 00       	push   $0x41ec
     e18:	6a 01                	push   $0x1
     e1a:	e8 41 2c 00 00       	call   3a60 <printf>
     e1f:	e8 af 2a 00 00       	call   38d3 <exit>
     e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e28:	83 ec 08             	sub    $0x8,%esp
     e2b:	68 d2 41 00 00       	push   $0x41d2
     e30:	6a 01                	push   $0x1
     e32:	e8 29 2c 00 00       	call   3a60 <printf>
     e37:	89 1c 24             	mov    %ebx,(%esp)
     e3a:	e8 c4 2a 00 00       	call   3903 <kill>
     e3f:	e8 8f 2a 00 00       	call   38d3 <exit>
     e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e48:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e4b:	5b                   	pop    %ebx
     e4c:	5e                   	pop    %esi
     e4d:	5d                   	pop    %ebp
     e4e:	e9 88 2a 00 00       	jmp    38db <wait>
     e53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e60 <sharedfd>:
     e60:	55                   	push   %ebp
     e61:	89 e5                	mov    %esp,%ebp
     e63:	57                   	push   %edi
     e64:	56                   	push   %esi
     e65:	53                   	push   %ebx
     e66:	83 ec 34             	sub    $0x34,%esp
     e69:	68 f4 41 00 00       	push   $0x41f4
     e6e:	6a 01                	push   $0x1
     e70:	e8 eb 2b 00 00       	call   3a60 <printf>
     e75:	c7 04 24 03 42 00 00 	movl   $0x4203,(%esp)
     e7c:	e8 a2 2a 00 00       	call   3923 <unlink>
     e81:	5b                   	pop    %ebx
     e82:	5e                   	pop    %esi
     e83:	68 02 02 00 00       	push   $0x202
     e88:	68 03 42 00 00       	push   $0x4203
     e8d:	e8 81 2a 00 00       	call   3913 <open>
     e92:	83 c4 10             	add    $0x10,%esp
     e95:	85 c0                	test   %eax,%eax
     e97:	0f 88 2a 01 00 00    	js     fc7 <sharedfd+0x167>
     e9d:	89 c7                	mov    %eax,%edi
     e9f:	8d 75 de             	lea    -0x22(%ebp),%esi
     ea2:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     ea7:	e8 1f 2a 00 00       	call   38cb <fork>
     eac:	83 f8 01             	cmp    $0x1,%eax
     eaf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     eb2:	19 c0                	sbb    %eax,%eax
     eb4:	83 ec 04             	sub    $0x4,%esp
     eb7:	83 e0 f3             	and    $0xfffffff3,%eax
     eba:	6a 0a                	push   $0xa
     ebc:	83 c0 70             	add    $0x70,%eax
     ebf:	50                   	push   %eax
     ec0:	56                   	push   %esi
     ec1:	e8 6a 28 00 00       	call   3730 <memset>
     ec6:	83 c4 10             	add    $0x10,%esp
     ec9:	eb 0a                	jmp    ed5 <sharedfd+0x75>
     ecb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ecf:	90                   	nop
     ed0:	83 eb 01             	sub    $0x1,%ebx
     ed3:	74 26                	je     efb <sharedfd+0x9b>
     ed5:	83 ec 04             	sub    $0x4,%esp
     ed8:	6a 0a                	push   $0xa
     eda:	56                   	push   %esi
     edb:	57                   	push   %edi
     edc:	e8 12 2a 00 00       	call   38f3 <write>
     ee1:	83 c4 10             	add    $0x10,%esp
     ee4:	83 f8 0a             	cmp    $0xa,%eax
     ee7:	74 e7                	je     ed0 <sharedfd+0x70>
     ee9:	83 ec 08             	sub    $0x8,%esp
     eec:	68 f4 4e 00 00       	push   $0x4ef4
     ef1:	6a 01                	push   $0x1
     ef3:	e8 68 2b 00 00       	call   3a60 <printf>
     ef8:	83 c4 10             	add    $0x10,%esp
     efb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     efe:	85 c9                	test   %ecx,%ecx
     f00:	0f 84 f5 00 00 00    	je     ffb <sharedfd+0x19b>
     f06:	e8 d0 29 00 00       	call   38db <wait>
     f0b:	83 ec 0c             	sub    $0xc,%esp
     f0e:	31 db                	xor    %ebx,%ebx
     f10:	57                   	push   %edi
     f11:	8d 7d e8             	lea    -0x18(%ebp),%edi
     f14:	e8 e2 29 00 00       	call   38fb <close>
     f19:	58                   	pop    %eax
     f1a:	5a                   	pop    %edx
     f1b:	6a 00                	push   $0x0
     f1d:	68 03 42 00 00       	push   $0x4203
     f22:	e8 ec 29 00 00       	call   3913 <open>
     f27:	83 c4 10             	add    $0x10,%esp
     f2a:	31 d2                	xor    %edx,%edx
     f2c:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f2f:	85 c0                	test   %eax,%eax
     f31:	0f 88 aa 00 00 00    	js     fe1 <sharedfd+0x181>
     f37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f3e:	66 90                	xchg   %ax,%ax
     f40:	83 ec 04             	sub    $0x4,%esp
     f43:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f46:	6a 0a                	push   $0xa
     f48:	56                   	push   %esi
     f49:	ff 75 d0             	pushl  -0x30(%ebp)
     f4c:	e8 9a 29 00 00       	call   38eb <read>
     f51:	83 c4 10             	add    $0x10,%esp
     f54:	85 c0                	test   %eax,%eax
     f56:	7e 28                	jle    f80 <sharedfd+0x120>
     f58:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f5b:	89 f0                	mov    %esi,%eax
     f5d:	eb 13                	jmp    f72 <sharedfd+0x112>
     f5f:	90                   	nop
     f60:	80 f9 70             	cmp    $0x70,%cl
     f63:	0f 94 c1             	sete   %cl
     f66:	0f b6 c9             	movzbl %cl,%ecx
     f69:	01 cb                	add    %ecx,%ebx
     f6b:	83 c0 01             	add    $0x1,%eax
     f6e:	39 c7                	cmp    %eax,%edi
     f70:	74 ce                	je     f40 <sharedfd+0xe0>
     f72:	0f b6 08             	movzbl (%eax),%ecx
     f75:	80 f9 63             	cmp    $0x63,%cl
     f78:	75 e6                	jne    f60 <sharedfd+0x100>
     f7a:	83 c2 01             	add    $0x1,%edx
     f7d:	eb ec                	jmp    f6b <sharedfd+0x10b>
     f7f:	90                   	nop
     f80:	83 ec 0c             	sub    $0xc,%esp
     f83:	ff 75 d0             	pushl  -0x30(%ebp)
     f86:	e8 70 29 00 00       	call   38fb <close>
     f8b:	c7 04 24 03 42 00 00 	movl   $0x4203,(%esp)
     f92:	e8 8c 29 00 00       	call   3923 <unlink>
     f97:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f9a:	83 c4 10             	add    $0x10,%esp
     f9d:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     fa3:	75 5b                	jne    1000 <sharedfd+0x1a0>
     fa5:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     fab:	75 53                	jne    1000 <sharedfd+0x1a0>
     fad:	83 ec 08             	sub    $0x8,%esp
     fb0:	68 0c 42 00 00       	push   $0x420c
     fb5:	6a 01                	push   $0x1
     fb7:	e8 a4 2a 00 00       	call   3a60 <printf>
     fbc:	83 c4 10             	add    $0x10,%esp
     fbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fc2:	5b                   	pop    %ebx
     fc3:	5e                   	pop    %esi
     fc4:	5f                   	pop    %edi
     fc5:	5d                   	pop    %ebp
     fc6:	c3                   	ret    
     fc7:	83 ec 08             	sub    $0x8,%esp
     fca:	68 c8 4e 00 00       	push   $0x4ec8
     fcf:	6a 01                	push   $0x1
     fd1:	e8 8a 2a 00 00       	call   3a60 <printf>
     fd6:	83 c4 10             	add    $0x10,%esp
     fd9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fdc:	5b                   	pop    %ebx
     fdd:	5e                   	pop    %esi
     fde:	5f                   	pop    %edi
     fdf:	5d                   	pop    %ebp
     fe0:	c3                   	ret    
     fe1:	83 ec 08             	sub    $0x8,%esp
     fe4:	68 14 4f 00 00       	push   $0x4f14
     fe9:	6a 01                	push   $0x1
     feb:	e8 70 2a 00 00       	call   3a60 <printf>
     ff0:	83 c4 10             	add    $0x10,%esp
     ff3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ff6:	5b                   	pop    %ebx
     ff7:	5e                   	pop    %esi
     ff8:	5f                   	pop    %edi
     ff9:	5d                   	pop    %ebp
     ffa:	c3                   	ret    
     ffb:	e8 d3 28 00 00       	call   38d3 <exit>
    1000:	53                   	push   %ebx
    1001:	52                   	push   %edx
    1002:	68 19 42 00 00       	push   $0x4219
    1007:	6a 01                	push   $0x1
    1009:	e8 52 2a 00 00       	call   3a60 <printf>
    100e:	e8 c0 28 00 00       	call   38d3 <exit>
    1013:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001020 <fourfiles>:
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	57                   	push   %edi
    1024:	56                   	push   %esi
    1025:	be 2e 42 00 00       	mov    $0x422e,%esi
    102a:	53                   	push   %ebx
    102b:	31 db                	xor    %ebx,%ebx
    102d:	83 ec 34             	sub    $0x34,%esp
    1030:	c7 45 d8 2e 42 00 00 	movl   $0x422e,-0x28(%ebp)
    1037:	68 34 42 00 00       	push   $0x4234
    103c:	6a 01                	push   $0x1
    103e:	c7 45 dc 77 43 00 00 	movl   $0x4377,-0x24(%ebp)
    1045:	c7 45 e0 7b 43 00 00 	movl   $0x437b,-0x20(%ebp)
    104c:	c7 45 e4 31 42 00 00 	movl   $0x4231,-0x1c(%ebp)
    1053:	e8 08 2a 00 00       	call   3a60 <printf>
    1058:	83 c4 10             	add    $0x10,%esp
    105b:	83 ec 0c             	sub    $0xc,%esp
    105e:	56                   	push   %esi
    105f:	e8 bf 28 00 00       	call   3923 <unlink>
    1064:	e8 62 28 00 00       	call   38cb <fork>
    1069:	83 c4 10             	add    $0x10,%esp
    106c:	85 c0                	test   %eax,%eax
    106e:	0f 88 64 01 00 00    	js     11d8 <fourfiles+0x1b8>
    1074:	0f 84 e9 00 00 00    	je     1163 <fourfiles+0x143>
    107a:	83 c3 01             	add    $0x1,%ebx
    107d:	83 fb 04             	cmp    $0x4,%ebx
    1080:	74 06                	je     1088 <fourfiles+0x68>
    1082:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1086:	eb d3                	jmp    105b <fourfiles+0x3b>
    1088:	e8 4e 28 00 00       	call   38db <wait>
    108d:	31 f6                	xor    %esi,%esi
    108f:	e8 47 28 00 00       	call   38db <wait>
    1094:	e8 42 28 00 00       	call   38db <wait>
    1099:	e8 3d 28 00 00       	call   38db <wait>
    109e:	8b 44 b5 d8          	mov    -0x28(%ebp,%esi,4),%eax
    10a2:	83 ec 08             	sub    $0x8,%esp
    10a5:	31 db                	xor    %ebx,%ebx
    10a7:	6a 00                	push   $0x0
    10a9:	50                   	push   %eax
    10aa:	89 45 d0             	mov    %eax,-0x30(%ebp)
    10ad:	e8 61 28 00 00       	call   3913 <open>
    10b2:	83 c4 10             	add    $0x10,%esp
    10b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    10b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10bf:	90                   	nop
    10c0:	83 ec 04             	sub    $0x4,%esp
    10c3:	68 00 20 00 00       	push   $0x2000
    10c8:	68 40 86 00 00       	push   $0x8640
    10cd:	ff 75 d4             	pushl  -0x2c(%ebp)
    10d0:	e8 16 28 00 00       	call   38eb <read>
    10d5:	83 c4 10             	add    $0x10,%esp
    10d8:	85 c0                	test   %eax,%eax
    10da:	7e 22                	jle    10fe <fourfiles+0xde>
    10dc:	31 d2                	xor    %edx,%edx
    10de:	66 90                	xchg   %ax,%ax
    10e0:	83 fe 01             	cmp    $0x1,%esi
    10e3:	0f be ba 40 86 00 00 	movsbl 0x8640(%edx),%edi
    10ea:	19 c9                	sbb    %ecx,%ecx
    10ec:	83 c1 31             	add    $0x31,%ecx
    10ef:	39 cf                	cmp    %ecx,%edi
    10f1:	75 5c                	jne    114f <fourfiles+0x12f>
    10f3:	83 c2 01             	add    $0x1,%edx
    10f6:	39 d0                	cmp    %edx,%eax
    10f8:	75 e6                	jne    10e0 <fourfiles+0xc0>
    10fa:	01 c3                	add    %eax,%ebx
    10fc:	eb c2                	jmp    10c0 <fourfiles+0xa0>
    10fe:	83 ec 0c             	sub    $0xc,%esp
    1101:	ff 75 d4             	pushl  -0x2c(%ebp)
    1104:	e8 f2 27 00 00       	call   38fb <close>
    1109:	83 c4 10             	add    $0x10,%esp
    110c:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1112:	0f 85 d4 00 00 00    	jne    11ec <fourfiles+0x1cc>
    1118:	83 ec 0c             	sub    $0xc,%esp
    111b:	ff 75 d0             	pushl  -0x30(%ebp)
    111e:	e8 00 28 00 00       	call   3923 <unlink>
    1123:	83 c4 10             	add    $0x10,%esp
    1126:	83 fe 01             	cmp    $0x1,%esi
    1129:	75 1a                	jne    1145 <fourfiles+0x125>
    112b:	83 ec 08             	sub    $0x8,%esp
    112e:	68 72 42 00 00       	push   $0x4272
    1133:	6a 01                	push   $0x1
    1135:	e8 26 29 00 00       	call   3a60 <printf>
    113a:	83 c4 10             	add    $0x10,%esp
    113d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1140:	5b                   	pop    %ebx
    1141:	5e                   	pop    %esi
    1142:	5f                   	pop    %edi
    1143:	5d                   	pop    %ebp
    1144:	c3                   	ret    
    1145:	be 01 00 00 00       	mov    $0x1,%esi
    114a:	e9 4f ff ff ff       	jmp    109e <fourfiles+0x7e>
    114f:	83 ec 08             	sub    $0x8,%esp
    1152:	68 55 42 00 00       	push   $0x4255
    1157:	6a 01                	push   $0x1
    1159:	e8 02 29 00 00       	call   3a60 <printf>
    115e:	e8 70 27 00 00       	call   38d3 <exit>
    1163:	83 ec 08             	sub    $0x8,%esp
    1166:	68 02 02 00 00       	push   $0x202
    116b:	56                   	push   %esi
    116c:	e8 a2 27 00 00       	call   3913 <open>
    1171:	83 c4 10             	add    $0x10,%esp
    1174:	89 c6                	mov    %eax,%esi
    1176:	85 c0                	test   %eax,%eax
    1178:	78 45                	js     11bf <fourfiles+0x19f>
    117a:	83 ec 04             	sub    $0x4,%esp
    117d:	83 c3 30             	add    $0x30,%ebx
    1180:	68 00 02 00 00       	push   $0x200
    1185:	53                   	push   %ebx
    1186:	bb 0c 00 00 00       	mov    $0xc,%ebx
    118b:	68 40 86 00 00       	push   $0x8640
    1190:	e8 9b 25 00 00       	call   3730 <memset>
    1195:	83 c4 10             	add    $0x10,%esp
    1198:	83 ec 04             	sub    $0x4,%esp
    119b:	68 f4 01 00 00       	push   $0x1f4
    11a0:	68 40 86 00 00       	push   $0x8640
    11a5:	56                   	push   %esi
    11a6:	e8 48 27 00 00       	call   38f3 <write>
    11ab:	83 c4 10             	add    $0x10,%esp
    11ae:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    11b3:	75 4a                	jne    11ff <fourfiles+0x1df>
    11b5:	83 eb 01             	sub    $0x1,%ebx
    11b8:	75 de                	jne    1198 <fourfiles+0x178>
    11ba:	e8 14 27 00 00       	call   38d3 <exit>
    11bf:	51                   	push   %ecx
    11c0:	51                   	push   %ecx
    11c1:	68 cf 44 00 00       	push   $0x44cf
    11c6:	6a 01                	push   $0x1
    11c8:	e8 93 28 00 00       	call   3a60 <printf>
    11cd:	e8 01 27 00 00       	call   38d3 <exit>
    11d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11d8:	83 ec 08             	sub    $0x8,%esp
    11db:	68 09 4d 00 00       	push   $0x4d09
    11e0:	6a 01                	push   $0x1
    11e2:	e8 79 28 00 00       	call   3a60 <printf>
    11e7:	e8 e7 26 00 00       	call   38d3 <exit>
    11ec:	50                   	push   %eax
    11ed:	53                   	push   %ebx
    11ee:	68 61 42 00 00       	push   $0x4261
    11f3:	6a 01                	push   $0x1
    11f5:	e8 66 28 00 00       	call   3a60 <printf>
    11fa:	e8 d4 26 00 00       	call   38d3 <exit>
    11ff:	52                   	push   %edx
    1200:	50                   	push   %eax
    1201:	68 44 42 00 00       	push   $0x4244
    1206:	6a 01                	push   $0x1
    1208:	e8 53 28 00 00       	call   3a60 <printf>
    120d:	e8 c1 26 00 00       	call   38d3 <exit>
    1212:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001220 <createdelete>:
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	56                   	push   %esi
    1225:	53                   	push   %ebx
    1226:	31 db                	xor    %ebx,%ebx
    1228:	83 ec 44             	sub    $0x44,%esp
    122b:	68 80 42 00 00       	push   $0x4280
    1230:	6a 01                	push   $0x1
    1232:	e8 29 28 00 00       	call   3a60 <printf>
    1237:	83 c4 10             	add    $0x10,%esp
    123a:	e8 8c 26 00 00       	call   38cb <fork>
    123f:	85 c0                	test   %eax,%eax
    1241:	0f 88 d2 01 00 00    	js     1419 <createdelete+0x1f9>
    1247:	0f 84 1b 01 00 00    	je     1368 <createdelete+0x148>
    124d:	83 c3 01             	add    $0x1,%ebx
    1250:	83 fb 04             	cmp    $0x4,%ebx
    1253:	75 e5                	jne    123a <createdelete+0x1a>
    1255:	e8 81 26 00 00       	call   38db <wait>
    125a:	8d 7d c8             	lea    -0x38(%ebp),%edi
    125d:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1262:	e8 74 26 00 00       	call   38db <wait>
    1267:	e8 6f 26 00 00       	call   38db <wait>
    126c:	e8 6a 26 00 00       	call   38db <wait>
    1271:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1275:	89 7d c0             	mov    %edi,-0x40(%ebp)
    1278:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    127f:	90                   	nop
    1280:	8d 46 31             	lea    0x31(%esi),%eax
    1283:	89 f7                	mov    %esi,%edi
    1285:	83 c6 01             	add    $0x1,%esi
    1288:	83 fe 09             	cmp    $0x9,%esi
    128b:	88 45 c7             	mov    %al,-0x39(%ebp)
    128e:	0f 9f c3             	setg   %bl
    1291:	85 f6                	test   %esi,%esi
    1293:	0f 94 c0             	sete   %al
    1296:	09 c3                	or     %eax,%ebx
    1298:	88 5d c6             	mov    %bl,-0x3a(%ebp)
    129b:	bb 70 00 00 00       	mov    $0x70,%ebx
    12a0:	83 ec 08             	sub    $0x8,%esp
    12a3:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    12a7:	88 5d c8             	mov    %bl,-0x38(%ebp)
    12aa:	6a 00                	push   $0x0
    12ac:	ff 75 c0             	pushl  -0x40(%ebp)
    12af:	88 45 c9             	mov    %al,-0x37(%ebp)
    12b2:	e8 5c 26 00 00       	call   3913 <open>
    12b7:	83 c4 10             	add    $0x10,%esp
    12ba:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    12be:	0f 84 8c 00 00 00    	je     1350 <createdelete+0x130>
    12c4:	85 c0                	test   %eax,%eax
    12c6:	0f 88 21 01 00 00    	js     13ed <createdelete+0x1cd>
    12cc:	83 ff 08             	cmp    $0x8,%edi
    12cf:	0f 86 60 01 00 00    	jbe    1435 <createdelete+0x215>
    12d5:	83 ec 0c             	sub    $0xc,%esp
    12d8:	50                   	push   %eax
    12d9:	e8 1d 26 00 00       	call   38fb <close>
    12de:	83 c4 10             	add    $0x10,%esp
    12e1:	83 c3 01             	add    $0x1,%ebx
    12e4:	80 fb 74             	cmp    $0x74,%bl
    12e7:	75 b7                	jne    12a0 <createdelete+0x80>
    12e9:	83 fe 13             	cmp    $0x13,%esi
    12ec:	75 92                	jne    1280 <createdelete+0x60>
    12ee:	8b 7d c0             	mov    -0x40(%ebp),%edi
    12f1:	be 70 00 00 00       	mov    $0x70,%esi
    12f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12fd:	8d 76 00             	lea    0x0(%esi),%esi
    1300:	8d 46 c0             	lea    -0x40(%esi),%eax
    1303:	bb 04 00 00 00       	mov    $0x4,%ebx
    1308:	88 45 c7             	mov    %al,-0x39(%ebp)
    130b:	83 ec 0c             	sub    $0xc,%esp
    130e:	89 f0                	mov    %esi,%eax
    1310:	57                   	push   %edi
    1311:	88 45 c8             	mov    %al,-0x38(%ebp)
    1314:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    1318:	88 45 c9             	mov    %al,-0x37(%ebp)
    131b:	e8 03 26 00 00       	call   3923 <unlink>
    1320:	83 c4 10             	add    $0x10,%esp
    1323:	83 eb 01             	sub    $0x1,%ebx
    1326:	75 e3                	jne    130b <createdelete+0xeb>
    1328:	83 c6 01             	add    $0x1,%esi
    132b:	89 f0                	mov    %esi,%eax
    132d:	3c 84                	cmp    $0x84,%al
    132f:	75 cf                	jne    1300 <createdelete+0xe0>
    1331:	83 ec 08             	sub    $0x8,%esp
    1334:	68 93 42 00 00       	push   $0x4293
    1339:	6a 01                	push   $0x1
    133b:	e8 20 27 00 00       	call   3a60 <printf>
    1340:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1343:	5b                   	pop    %ebx
    1344:	5e                   	pop    %esi
    1345:	5f                   	pop    %edi
    1346:	5d                   	pop    %ebp
    1347:	c3                   	ret    
    1348:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    134f:	90                   	nop
    1350:	83 ff 08             	cmp    $0x8,%edi
    1353:	0f 86 d4 00 00 00    	jbe    142d <createdelete+0x20d>
    1359:	85 c0                	test   %eax,%eax
    135b:	78 84                	js     12e1 <createdelete+0xc1>
    135d:	e9 73 ff ff ff       	jmp    12d5 <createdelete+0xb5>
    1362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1368:	83 c3 70             	add    $0x70,%ebx
    136b:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    136f:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1372:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1375:	31 db                	xor    %ebx,%ebx
    1377:	eb 0f                	jmp    1388 <createdelete+0x168>
    1379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1380:	83 fb 13             	cmp    $0x13,%ebx
    1383:	74 63                	je     13e8 <createdelete+0x1c8>
    1385:	83 c3 01             	add    $0x1,%ebx
    1388:	83 ec 08             	sub    $0x8,%esp
    138b:	8d 43 30             	lea    0x30(%ebx),%eax
    138e:	68 02 02 00 00       	push   $0x202
    1393:	57                   	push   %edi
    1394:	88 45 c9             	mov    %al,-0x37(%ebp)
    1397:	e8 77 25 00 00       	call   3913 <open>
    139c:	83 c4 10             	add    $0x10,%esp
    139f:	85 c0                	test   %eax,%eax
    13a1:	78 62                	js     1405 <createdelete+0x1e5>
    13a3:	83 ec 0c             	sub    $0xc,%esp
    13a6:	50                   	push   %eax
    13a7:	e8 4f 25 00 00       	call   38fb <close>
    13ac:	83 c4 10             	add    $0x10,%esp
    13af:	85 db                	test   %ebx,%ebx
    13b1:	74 d2                	je     1385 <createdelete+0x165>
    13b3:	f6 c3 01             	test   $0x1,%bl
    13b6:	75 c8                	jne    1380 <createdelete+0x160>
    13b8:	83 ec 0c             	sub    $0xc,%esp
    13bb:	89 d8                	mov    %ebx,%eax
    13bd:	57                   	push   %edi
    13be:	d1 f8                	sar    %eax
    13c0:	83 c0 30             	add    $0x30,%eax
    13c3:	88 45 c9             	mov    %al,-0x37(%ebp)
    13c6:	e8 58 25 00 00       	call   3923 <unlink>
    13cb:	83 c4 10             	add    $0x10,%esp
    13ce:	85 c0                	test   %eax,%eax
    13d0:	79 ae                	jns    1380 <createdelete+0x160>
    13d2:	52                   	push   %edx
    13d3:	52                   	push   %edx
    13d4:	68 81 3e 00 00       	push   $0x3e81
    13d9:	6a 01                	push   $0x1
    13db:	e8 80 26 00 00       	call   3a60 <printf>
    13e0:	e8 ee 24 00 00       	call   38d3 <exit>
    13e5:	8d 76 00             	lea    0x0(%esi),%esi
    13e8:	e8 e6 24 00 00       	call   38d3 <exit>
    13ed:	8b 7d c0             	mov    -0x40(%ebp),%edi
    13f0:	83 ec 04             	sub    $0x4,%esp
    13f3:	57                   	push   %edi
    13f4:	68 40 4f 00 00       	push   $0x4f40
    13f9:	6a 01                	push   $0x1
    13fb:	e8 60 26 00 00       	call   3a60 <printf>
    1400:	e8 ce 24 00 00       	call   38d3 <exit>
    1405:	83 ec 08             	sub    $0x8,%esp
    1408:	68 cf 44 00 00       	push   $0x44cf
    140d:	6a 01                	push   $0x1
    140f:	e8 4c 26 00 00       	call   3a60 <printf>
    1414:	e8 ba 24 00 00       	call   38d3 <exit>
    1419:	83 ec 08             	sub    $0x8,%esp
    141c:	68 09 4d 00 00       	push   $0x4d09
    1421:	6a 01                	push   $0x1
    1423:	e8 38 26 00 00       	call   3a60 <printf>
    1428:	e8 a6 24 00 00       	call   38d3 <exit>
    142d:	85 c0                	test   %eax,%eax
    142f:	0f 88 ac fe ff ff    	js     12e1 <createdelete+0xc1>
    1435:	8b 7d c0             	mov    -0x40(%ebp),%edi
    1438:	50                   	push   %eax
    1439:	57                   	push   %edi
    143a:	68 64 4f 00 00       	push   $0x4f64
    143f:	6a 01                	push   $0x1
    1441:	e8 1a 26 00 00       	call   3a60 <printf>
    1446:	e8 88 24 00 00       	call   38d3 <exit>
    144b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    144f:	90                   	nop

00001450 <unlinkread>:
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	56                   	push   %esi
    1454:	53                   	push   %ebx
    1455:	83 ec 08             	sub    $0x8,%esp
    1458:	68 a4 42 00 00       	push   $0x42a4
    145d:	6a 01                	push   $0x1
    145f:	e8 fc 25 00 00       	call   3a60 <printf>
    1464:	5b                   	pop    %ebx
    1465:	5e                   	pop    %esi
    1466:	68 02 02 00 00       	push   $0x202
    146b:	68 b5 42 00 00       	push   $0x42b5
    1470:	e8 9e 24 00 00       	call   3913 <open>
    1475:	83 c4 10             	add    $0x10,%esp
    1478:	85 c0                	test   %eax,%eax
    147a:	0f 88 e6 00 00 00    	js     1566 <unlinkread+0x116>
    1480:	83 ec 04             	sub    $0x4,%esp
    1483:	89 c3                	mov    %eax,%ebx
    1485:	6a 05                	push   $0x5
    1487:	68 da 42 00 00       	push   $0x42da
    148c:	50                   	push   %eax
    148d:	e8 61 24 00 00       	call   38f3 <write>
    1492:	89 1c 24             	mov    %ebx,(%esp)
    1495:	e8 61 24 00 00       	call   38fb <close>
    149a:	58                   	pop    %eax
    149b:	5a                   	pop    %edx
    149c:	6a 02                	push   $0x2
    149e:	68 b5 42 00 00       	push   $0x42b5
    14a3:	e8 6b 24 00 00       	call   3913 <open>
    14a8:	83 c4 10             	add    $0x10,%esp
    14ab:	89 c3                	mov    %eax,%ebx
    14ad:	85 c0                	test   %eax,%eax
    14af:	0f 88 10 01 00 00    	js     15c5 <unlinkread+0x175>
    14b5:	83 ec 0c             	sub    $0xc,%esp
    14b8:	68 b5 42 00 00       	push   $0x42b5
    14bd:	e8 61 24 00 00       	call   3923 <unlink>
    14c2:	83 c4 10             	add    $0x10,%esp
    14c5:	85 c0                	test   %eax,%eax
    14c7:	0f 85 e5 00 00 00    	jne    15b2 <unlinkread+0x162>
    14cd:	83 ec 08             	sub    $0x8,%esp
    14d0:	68 02 02 00 00       	push   $0x202
    14d5:	68 b5 42 00 00       	push   $0x42b5
    14da:	e8 34 24 00 00       	call   3913 <open>
    14df:	83 c4 0c             	add    $0xc,%esp
    14e2:	6a 03                	push   $0x3
    14e4:	89 c6                	mov    %eax,%esi
    14e6:	68 12 43 00 00       	push   $0x4312
    14eb:	50                   	push   %eax
    14ec:	e8 02 24 00 00       	call   38f3 <write>
    14f1:	89 34 24             	mov    %esi,(%esp)
    14f4:	e8 02 24 00 00       	call   38fb <close>
    14f9:	83 c4 0c             	add    $0xc,%esp
    14fc:	68 00 20 00 00       	push   $0x2000
    1501:	68 40 86 00 00       	push   $0x8640
    1506:	53                   	push   %ebx
    1507:	e8 df 23 00 00       	call   38eb <read>
    150c:	83 c4 10             	add    $0x10,%esp
    150f:	83 f8 05             	cmp    $0x5,%eax
    1512:	0f 85 87 00 00 00    	jne    159f <unlinkread+0x14f>
    1518:	80 3d 40 86 00 00 68 	cmpb   $0x68,0x8640
    151f:	75 6b                	jne    158c <unlinkread+0x13c>
    1521:	83 ec 04             	sub    $0x4,%esp
    1524:	6a 0a                	push   $0xa
    1526:	68 40 86 00 00       	push   $0x8640
    152b:	53                   	push   %ebx
    152c:	e8 c2 23 00 00       	call   38f3 <write>
    1531:	83 c4 10             	add    $0x10,%esp
    1534:	83 f8 0a             	cmp    $0xa,%eax
    1537:	75 40                	jne    1579 <unlinkread+0x129>
    1539:	83 ec 0c             	sub    $0xc,%esp
    153c:	53                   	push   %ebx
    153d:	e8 b9 23 00 00       	call   38fb <close>
    1542:	c7 04 24 b5 42 00 00 	movl   $0x42b5,(%esp)
    1549:	e8 d5 23 00 00       	call   3923 <unlink>
    154e:	58                   	pop    %eax
    154f:	5a                   	pop    %edx
    1550:	68 5d 43 00 00       	push   $0x435d
    1555:	6a 01                	push   $0x1
    1557:	e8 04 25 00 00       	call   3a60 <printf>
    155c:	83 c4 10             	add    $0x10,%esp
    155f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1562:	5b                   	pop    %ebx
    1563:	5e                   	pop    %esi
    1564:	5d                   	pop    %ebp
    1565:	c3                   	ret    
    1566:	51                   	push   %ecx
    1567:	51                   	push   %ecx
    1568:	68 c0 42 00 00       	push   $0x42c0
    156d:	6a 01                	push   $0x1
    156f:	e8 ec 24 00 00       	call   3a60 <printf>
    1574:	e8 5a 23 00 00       	call   38d3 <exit>
    1579:	51                   	push   %ecx
    157a:	51                   	push   %ecx
    157b:	68 44 43 00 00       	push   $0x4344
    1580:	6a 01                	push   $0x1
    1582:	e8 d9 24 00 00       	call   3a60 <printf>
    1587:	e8 47 23 00 00       	call   38d3 <exit>
    158c:	53                   	push   %ebx
    158d:	53                   	push   %ebx
    158e:	68 2d 43 00 00       	push   $0x432d
    1593:	6a 01                	push   $0x1
    1595:	e8 c6 24 00 00       	call   3a60 <printf>
    159a:	e8 34 23 00 00       	call   38d3 <exit>
    159f:	56                   	push   %esi
    15a0:	56                   	push   %esi
    15a1:	68 16 43 00 00       	push   $0x4316
    15a6:	6a 01                	push   $0x1
    15a8:	e8 b3 24 00 00       	call   3a60 <printf>
    15ad:	e8 21 23 00 00       	call   38d3 <exit>
    15b2:	50                   	push   %eax
    15b3:	50                   	push   %eax
    15b4:	68 f8 42 00 00       	push   $0x42f8
    15b9:	6a 01                	push   $0x1
    15bb:	e8 a0 24 00 00       	call   3a60 <printf>
    15c0:	e8 0e 23 00 00       	call   38d3 <exit>
    15c5:	50                   	push   %eax
    15c6:	50                   	push   %eax
    15c7:	68 e0 42 00 00       	push   $0x42e0
    15cc:	6a 01                	push   $0x1
    15ce:	e8 8d 24 00 00       	call   3a60 <printf>
    15d3:	e8 fb 22 00 00       	call   38d3 <exit>
    15d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15df:	90                   	nop

000015e0 <linktest>:
    15e0:	55                   	push   %ebp
    15e1:	89 e5                	mov    %esp,%ebp
    15e3:	53                   	push   %ebx
    15e4:	83 ec 0c             	sub    $0xc,%esp
    15e7:	68 6c 43 00 00       	push   $0x436c
    15ec:	6a 01                	push   $0x1
    15ee:	e8 6d 24 00 00       	call   3a60 <printf>
    15f3:	c7 04 24 76 43 00 00 	movl   $0x4376,(%esp)
    15fa:	e8 24 23 00 00       	call   3923 <unlink>
    15ff:	c7 04 24 7a 43 00 00 	movl   $0x437a,(%esp)
    1606:	e8 18 23 00 00       	call   3923 <unlink>
    160b:	58                   	pop    %eax
    160c:	5a                   	pop    %edx
    160d:	68 02 02 00 00       	push   $0x202
    1612:	68 76 43 00 00       	push   $0x4376
    1617:	e8 f7 22 00 00       	call   3913 <open>
    161c:	83 c4 10             	add    $0x10,%esp
    161f:	85 c0                	test   %eax,%eax
    1621:	0f 88 1e 01 00 00    	js     1745 <linktest+0x165>
    1627:	83 ec 04             	sub    $0x4,%esp
    162a:	89 c3                	mov    %eax,%ebx
    162c:	6a 05                	push   $0x5
    162e:	68 da 42 00 00       	push   $0x42da
    1633:	50                   	push   %eax
    1634:	e8 ba 22 00 00       	call   38f3 <write>
    1639:	83 c4 10             	add    $0x10,%esp
    163c:	83 f8 05             	cmp    $0x5,%eax
    163f:	0f 85 98 01 00 00    	jne    17dd <linktest+0x1fd>
    1645:	83 ec 0c             	sub    $0xc,%esp
    1648:	53                   	push   %ebx
    1649:	e8 ad 22 00 00       	call   38fb <close>
    164e:	5b                   	pop    %ebx
    164f:	58                   	pop    %eax
    1650:	68 7a 43 00 00       	push   $0x437a
    1655:	68 76 43 00 00       	push   $0x4376
    165a:	e8 d4 22 00 00       	call   3933 <link>
    165f:	83 c4 10             	add    $0x10,%esp
    1662:	85 c0                	test   %eax,%eax
    1664:	0f 88 60 01 00 00    	js     17ca <linktest+0x1ea>
    166a:	83 ec 0c             	sub    $0xc,%esp
    166d:	68 76 43 00 00       	push   $0x4376
    1672:	e8 ac 22 00 00       	call   3923 <unlink>
    1677:	58                   	pop    %eax
    1678:	5a                   	pop    %edx
    1679:	6a 00                	push   $0x0
    167b:	68 76 43 00 00       	push   $0x4376
    1680:	e8 8e 22 00 00       	call   3913 <open>
    1685:	83 c4 10             	add    $0x10,%esp
    1688:	85 c0                	test   %eax,%eax
    168a:	0f 89 27 01 00 00    	jns    17b7 <linktest+0x1d7>
    1690:	83 ec 08             	sub    $0x8,%esp
    1693:	6a 00                	push   $0x0
    1695:	68 7a 43 00 00       	push   $0x437a
    169a:	e8 74 22 00 00       	call   3913 <open>
    169f:	83 c4 10             	add    $0x10,%esp
    16a2:	89 c3                	mov    %eax,%ebx
    16a4:	85 c0                	test   %eax,%eax
    16a6:	0f 88 f8 00 00 00    	js     17a4 <linktest+0x1c4>
    16ac:	83 ec 04             	sub    $0x4,%esp
    16af:	68 00 20 00 00       	push   $0x2000
    16b4:	68 40 86 00 00       	push   $0x8640
    16b9:	50                   	push   %eax
    16ba:	e8 2c 22 00 00       	call   38eb <read>
    16bf:	83 c4 10             	add    $0x10,%esp
    16c2:	83 f8 05             	cmp    $0x5,%eax
    16c5:	0f 85 c6 00 00 00    	jne    1791 <linktest+0x1b1>
    16cb:	83 ec 0c             	sub    $0xc,%esp
    16ce:	53                   	push   %ebx
    16cf:	e8 27 22 00 00       	call   38fb <close>
    16d4:	58                   	pop    %eax
    16d5:	5a                   	pop    %edx
    16d6:	68 7a 43 00 00       	push   $0x437a
    16db:	68 7a 43 00 00       	push   $0x437a
    16e0:	e8 4e 22 00 00       	call   3933 <link>
    16e5:	83 c4 10             	add    $0x10,%esp
    16e8:	85 c0                	test   %eax,%eax
    16ea:	0f 89 8e 00 00 00    	jns    177e <linktest+0x19e>
    16f0:	83 ec 0c             	sub    $0xc,%esp
    16f3:	68 7a 43 00 00       	push   $0x437a
    16f8:	e8 26 22 00 00       	call   3923 <unlink>
    16fd:	59                   	pop    %ecx
    16fe:	5b                   	pop    %ebx
    16ff:	68 76 43 00 00       	push   $0x4376
    1704:	68 7a 43 00 00       	push   $0x437a
    1709:	e8 25 22 00 00       	call   3933 <link>
    170e:	83 c4 10             	add    $0x10,%esp
    1711:	85 c0                	test   %eax,%eax
    1713:	79 56                	jns    176b <linktest+0x18b>
    1715:	83 ec 08             	sub    $0x8,%esp
    1718:	68 76 43 00 00       	push   $0x4376
    171d:	68 3e 46 00 00       	push   $0x463e
    1722:	e8 0c 22 00 00       	call   3933 <link>
    1727:	83 c4 10             	add    $0x10,%esp
    172a:	85 c0                	test   %eax,%eax
    172c:	79 2a                	jns    1758 <linktest+0x178>
    172e:	83 ec 08             	sub    $0x8,%esp
    1731:	68 14 44 00 00       	push   $0x4414
    1736:	6a 01                	push   $0x1
    1738:	e8 23 23 00 00       	call   3a60 <printf>
    173d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1740:	83 c4 10             	add    $0x10,%esp
    1743:	c9                   	leave  
    1744:	c3                   	ret    
    1745:	50                   	push   %eax
    1746:	50                   	push   %eax
    1747:	68 7e 43 00 00       	push   $0x437e
    174c:	6a 01                	push   $0x1
    174e:	e8 0d 23 00 00       	call   3a60 <printf>
    1753:	e8 7b 21 00 00       	call   38d3 <exit>
    1758:	50                   	push   %eax
    1759:	50                   	push   %eax
    175a:	68 f8 43 00 00       	push   $0x43f8
    175f:	6a 01                	push   $0x1
    1761:	e8 fa 22 00 00       	call   3a60 <printf>
    1766:	e8 68 21 00 00       	call   38d3 <exit>
    176b:	52                   	push   %edx
    176c:	52                   	push   %edx
    176d:	68 ac 4f 00 00       	push   $0x4fac
    1772:	6a 01                	push   $0x1
    1774:	e8 e7 22 00 00       	call   3a60 <printf>
    1779:	e8 55 21 00 00       	call   38d3 <exit>
    177e:	50                   	push   %eax
    177f:	50                   	push   %eax
    1780:	68 da 43 00 00       	push   $0x43da
    1785:	6a 01                	push   $0x1
    1787:	e8 d4 22 00 00       	call   3a60 <printf>
    178c:	e8 42 21 00 00       	call   38d3 <exit>
    1791:	51                   	push   %ecx
    1792:	51                   	push   %ecx
    1793:	68 c9 43 00 00       	push   $0x43c9
    1798:	6a 01                	push   $0x1
    179a:	e8 c1 22 00 00       	call   3a60 <printf>
    179f:	e8 2f 21 00 00       	call   38d3 <exit>
    17a4:	53                   	push   %ebx
    17a5:	53                   	push   %ebx
    17a6:	68 b8 43 00 00       	push   $0x43b8
    17ab:	6a 01                	push   $0x1
    17ad:	e8 ae 22 00 00       	call   3a60 <printf>
    17b2:	e8 1c 21 00 00       	call   38d3 <exit>
    17b7:	50                   	push   %eax
    17b8:	50                   	push   %eax
    17b9:	68 84 4f 00 00       	push   $0x4f84
    17be:	6a 01                	push   $0x1
    17c0:	e8 9b 22 00 00       	call   3a60 <printf>
    17c5:	e8 09 21 00 00       	call   38d3 <exit>
    17ca:	51                   	push   %ecx
    17cb:	51                   	push   %ecx
    17cc:	68 a3 43 00 00       	push   $0x43a3
    17d1:	6a 01                	push   $0x1
    17d3:	e8 88 22 00 00       	call   3a60 <printf>
    17d8:	e8 f6 20 00 00       	call   38d3 <exit>
    17dd:	50                   	push   %eax
    17de:	50                   	push   %eax
    17df:	68 91 43 00 00       	push   $0x4391
    17e4:	6a 01                	push   $0x1
    17e6:	e8 75 22 00 00       	call   3a60 <printf>
    17eb:	e8 e3 20 00 00       	call   38d3 <exit>

000017f0 <concreate>:
    17f0:	55                   	push   %ebp
    17f1:	89 e5                	mov    %esp,%ebp
    17f3:	57                   	push   %edi
    17f4:	56                   	push   %esi
    17f5:	31 f6                	xor    %esi,%esi
    17f7:	53                   	push   %ebx
    17f8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    17fb:	83 ec 64             	sub    $0x64,%esp
    17fe:	68 21 44 00 00       	push   $0x4421
    1803:	6a 01                	push   $0x1
    1805:	e8 56 22 00 00       	call   3a60 <printf>
    180a:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
    180e:	83 c4 10             	add    $0x10,%esp
    1811:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    1815:	eb 4c                	jmp    1863 <concreate+0x73>
    1817:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    181e:	66 90                	xchg   %ax,%ax
    1820:	69 c6 ab aa aa aa    	imul   $0xaaaaaaab,%esi,%eax
    1826:	3d ab aa aa aa       	cmp    $0xaaaaaaab,%eax
    182b:	0f 83 af 00 00 00    	jae    18e0 <concreate+0xf0>
    1831:	83 ec 08             	sub    $0x8,%esp
    1834:	68 02 02 00 00       	push   $0x202
    1839:	53                   	push   %ebx
    183a:	e8 d4 20 00 00       	call   3913 <open>
    183f:	83 c4 10             	add    $0x10,%esp
    1842:	85 c0                	test   %eax,%eax
    1844:	78 5f                	js     18a5 <concreate+0xb5>
    1846:	83 ec 0c             	sub    $0xc,%esp
    1849:	83 c6 01             	add    $0x1,%esi
    184c:	50                   	push   %eax
    184d:	e8 a9 20 00 00       	call   38fb <close>
    1852:	83 c4 10             	add    $0x10,%esp
    1855:	e8 81 20 00 00       	call   38db <wait>
    185a:	83 fe 28             	cmp    $0x28,%esi
    185d:	0f 84 9f 00 00 00    	je     1902 <concreate+0x112>
    1863:	83 ec 0c             	sub    $0xc,%esp
    1866:	8d 46 30             	lea    0x30(%esi),%eax
    1869:	53                   	push   %ebx
    186a:	88 45 ae             	mov    %al,-0x52(%ebp)
    186d:	e8 b1 20 00 00       	call   3923 <unlink>
    1872:	e8 54 20 00 00       	call   38cb <fork>
    1877:	83 c4 10             	add    $0x10,%esp
    187a:	85 c0                	test   %eax,%eax
    187c:	75 a2                	jne    1820 <concreate+0x30>
    187e:	69 f6 cd cc cc cc    	imul   $0xcccccccd,%esi,%esi
    1884:	81 fe cd cc cc cc    	cmp    $0xcccccccd,%esi
    188a:	73 34                	jae    18c0 <concreate+0xd0>
    188c:	83 ec 08             	sub    $0x8,%esp
    188f:	68 02 02 00 00       	push   $0x202
    1894:	53                   	push   %ebx
    1895:	e8 79 20 00 00       	call   3913 <open>
    189a:	83 c4 10             	add    $0x10,%esp
    189d:	85 c0                	test   %eax,%eax
    189f:	0f 89 39 02 00 00    	jns    1ade <concreate+0x2ee>
    18a5:	83 ec 04             	sub    $0x4,%esp
    18a8:	53                   	push   %ebx
    18a9:	68 34 44 00 00       	push   $0x4434
    18ae:	6a 01                	push   $0x1
    18b0:	e8 ab 21 00 00       	call   3a60 <printf>
    18b5:	e8 19 20 00 00       	call   38d3 <exit>
    18ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    18c0:	83 ec 08             	sub    $0x8,%esp
    18c3:	53                   	push   %ebx
    18c4:	68 31 44 00 00       	push   $0x4431
    18c9:	e8 65 20 00 00       	call   3933 <link>
    18ce:	83 c4 10             	add    $0x10,%esp
    18d1:	e8 fd 1f 00 00       	call   38d3 <exit>
    18d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    18dd:	8d 76 00             	lea    0x0(%esi),%esi
    18e0:	83 ec 08             	sub    $0x8,%esp
    18e3:	83 c6 01             	add    $0x1,%esi
    18e6:	53                   	push   %ebx
    18e7:	68 31 44 00 00       	push   $0x4431
    18ec:	e8 42 20 00 00       	call   3933 <link>
    18f1:	83 c4 10             	add    $0x10,%esp
    18f4:	e8 e2 1f 00 00       	call   38db <wait>
    18f9:	83 fe 28             	cmp    $0x28,%esi
    18fc:	0f 85 61 ff ff ff    	jne    1863 <concreate+0x73>
    1902:	83 ec 04             	sub    $0x4,%esp
    1905:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1908:	6a 28                	push   $0x28
    190a:	6a 00                	push   $0x0
    190c:	50                   	push   %eax
    190d:	e8 1e 1e 00 00       	call   3730 <memset>
    1912:	5e                   	pop    %esi
    1913:	5f                   	pop    %edi
    1914:	6a 00                	push   $0x0
    1916:	68 3e 46 00 00       	push   $0x463e
    191b:	8d 7d b0             	lea    -0x50(%ebp),%edi
    191e:	e8 f0 1f 00 00       	call   3913 <open>
    1923:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    192a:	83 c4 10             	add    $0x10,%esp
    192d:	89 c6                	mov    %eax,%esi
    192f:	90                   	nop
    1930:	83 ec 04             	sub    $0x4,%esp
    1933:	6a 10                	push   $0x10
    1935:	57                   	push   %edi
    1936:	56                   	push   %esi
    1937:	e8 af 1f 00 00       	call   38eb <read>
    193c:	83 c4 10             	add    $0x10,%esp
    193f:	85 c0                	test   %eax,%eax
    1941:	7e 3d                	jle    1980 <concreate+0x190>
    1943:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1948:	74 e6                	je     1930 <concreate+0x140>
    194a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    194e:	75 e0                	jne    1930 <concreate+0x140>
    1950:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1954:	75 da                	jne    1930 <concreate+0x140>
    1956:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    195a:	83 e8 30             	sub    $0x30,%eax
    195d:	83 f8 27             	cmp    $0x27,%eax
    1960:	0f 87 60 01 00 00    	ja     1ac6 <concreate+0x2d6>
    1966:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    196b:	0f 85 3d 01 00 00    	jne    1aae <concreate+0x2be>
    1971:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    1975:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
    197a:	eb b4                	jmp    1930 <concreate+0x140>
    197c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1980:	83 ec 0c             	sub    $0xc,%esp
    1983:	56                   	push   %esi
    1984:	e8 72 1f 00 00       	call   38fb <close>
    1989:	83 c4 10             	add    $0x10,%esp
    198c:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1990:	0f 85 05 01 00 00    	jne    1a9b <concreate+0x2ab>
    1996:	31 f6                	xor    %esi,%esi
    1998:	eb 4c                	jmp    19e6 <concreate+0x1f6>
    199a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    19a0:	85 ff                	test   %edi,%edi
    19a2:	74 05                	je     19a9 <concreate+0x1b9>
    19a4:	83 f8 01             	cmp    $0x1,%eax
    19a7:	74 6c                	je     1a15 <concreate+0x225>
    19a9:	83 ec 0c             	sub    $0xc,%esp
    19ac:	53                   	push   %ebx
    19ad:	e8 71 1f 00 00       	call   3923 <unlink>
    19b2:	89 1c 24             	mov    %ebx,(%esp)
    19b5:	e8 69 1f 00 00       	call   3923 <unlink>
    19ba:	89 1c 24             	mov    %ebx,(%esp)
    19bd:	e8 61 1f 00 00       	call   3923 <unlink>
    19c2:	89 1c 24             	mov    %ebx,(%esp)
    19c5:	e8 59 1f 00 00       	call   3923 <unlink>
    19ca:	83 c4 10             	add    $0x10,%esp
    19cd:	85 ff                	test   %edi,%edi
    19cf:	0f 84 fc fe ff ff    	je     18d1 <concreate+0xe1>
    19d5:	e8 01 1f 00 00       	call   38db <wait>
    19da:	83 c6 01             	add    $0x1,%esi
    19dd:	83 fe 28             	cmp    $0x28,%esi
    19e0:	0f 84 8a 00 00 00    	je     1a70 <concreate+0x280>
    19e6:	8d 46 30             	lea    0x30(%esi),%eax
    19e9:	88 45 ae             	mov    %al,-0x52(%ebp)
    19ec:	e8 da 1e 00 00       	call   38cb <fork>
    19f1:	89 c7                	mov    %eax,%edi
    19f3:	85 c0                	test   %eax,%eax
    19f5:	0f 88 8c 00 00 00    	js     1a87 <concreate+0x297>
    19fb:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1a00:	f7 e6                	mul    %esi
    1a02:	89 d0                	mov    %edx,%eax
    1a04:	83 e2 fe             	and    $0xfffffffe,%edx
    1a07:	d1 e8                	shr    %eax
    1a09:	01 c2                	add    %eax,%edx
    1a0b:	89 f0                	mov    %esi,%eax
    1a0d:	29 d0                	sub    %edx,%eax
    1a0f:	89 c1                	mov    %eax,%ecx
    1a11:	09 f9                	or     %edi,%ecx
    1a13:	75 8b                	jne    19a0 <concreate+0x1b0>
    1a15:	83 ec 08             	sub    $0x8,%esp
    1a18:	6a 00                	push   $0x0
    1a1a:	53                   	push   %ebx
    1a1b:	e8 f3 1e 00 00       	call   3913 <open>
    1a20:	89 04 24             	mov    %eax,(%esp)
    1a23:	e8 d3 1e 00 00       	call   38fb <close>
    1a28:	58                   	pop    %eax
    1a29:	5a                   	pop    %edx
    1a2a:	6a 00                	push   $0x0
    1a2c:	53                   	push   %ebx
    1a2d:	e8 e1 1e 00 00       	call   3913 <open>
    1a32:	89 04 24             	mov    %eax,(%esp)
    1a35:	e8 c1 1e 00 00       	call   38fb <close>
    1a3a:	59                   	pop    %ecx
    1a3b:	58                   	pop    %eax
    1a3c:	6a 00                	push   $0x0
    1a3e:	53                   	push   %ebx
    1a3f:	e8 cf 1e 00 00       	call   3913 <open>
    1a44:	89 04 24             	mov    %eax,(%esp)
    1a47:	e8 af 1e 00 00       	call   38fb <close>
    1a4c:	58                   	pop    %eax
    1a4d:	5a                   	pop    %edx
    1a4e:	6a 00                	push   $0x0
    1a50:	53                   	push   %ebx
    1a51:	e8 bd 1e 00 00       	call   3913 <open>
    1a56:	89 04 24             	mov    %eax,(%esp)
    1a59:	e8 9d 1e 00 00       	call   38fb <close>
    1a5e:	83 c4 10             	add    $0x10,%esp
    1a61:	e9 67 ff ff ff       	jmp    19cd <concreate+0x1dd>
    1a66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1a6d:	8d 76 00             	lea    0x0(%esi),%esi
    1a70:	83 ec 08             	sub    $0x8,%esp
    1a73:	68 86 44 00 00       	push   $0x4486
    1a78:	6a 01                	push   $0x1
    1a7a:	e8 e1 1f 00 00       	call   3a60 <printf>
    1a7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a82:	5b                   	pop    %ebx
    1a83:	5e                   	pop    %esi
    1a84:	5f                   	pop    %edi
    1a85:	5d                   	pop    %ebp
    1a86:	c3                   	ret    
    1a87:	83 ec 08             	sub    $0x8,%esp
    1a8a:	68 09 4d 00 00       	push   $0x4d09
    1a8f:	6a 01                	push   $0x1
    1a91:	e8 ca 1f 00 00       	call   3a60 <printf>
    1a96:	e8 38 1e 00 00       	call   38d3 <exit>
    1a9b:	51                   	push   %ecx
    1a9c:	51                   	push   %ecx
    1a9d:	68 d0 4f 00 00       	push   $0x4fd0
    1aa2:	6a 01                	push   $0x1
    1aa4:	e8 b7 1f 00 00       	call   3a60 <printf>
    1aa9:	e8 25 1e 00 00       	call   38d3 <exit>
    1aae:	83 ec 04             	sub    $0x4,%esp
    1ab1:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1ab4:	50                   	push   %eax
    1ab5:	68 69 44 00 00       	push   $0x4469
    1aba:	6a 01                	push   $0x1
    1abc:	e8 9f 1f 00 00       	call   3a60 <printf>
    1ac1:	e8 0d 1e 00 00       	call   38d3 <exit>
    1ac6:	83 ec 04             	sub    $0x4,%esp
    1ac9:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1acc:	50                   	push   %eax
    1acd:	68 50 44 00 00       	push   $0x4450
    1ad2:	6a 01                	push   $0x1
    1ad4:	e8 87 1f 00 00       	call   3a60 <printf>
    1ad9:	e8 f5 1d 00 00       	call   38d3 <exit>
    1ade:	83 ec 0c             	sub    $0xc,%esp
    1ae1:	50                   	push   %eax
    1ae2:	e8 14 1e 00 00       	call   38fb <close>
    1ae7:	83 c4 10             	add    $0x10,%esp
    1aea:	e9 e2 fd ff ff       	jmp    18d1 <concreate+0xe1>
    1aef:	90                   	nop

00001af0 <linkunlink>:
    1af0:	55                   	push   %ebp
    1af1:	89 e5                	mov    %esp,%ebp
    1af3:	57                   	push   %edi
    1af4:	56                   	push   %esi
    1af5:	53                   	push   %ebx
    1af6:	83 ec 24             	sub    $0x24,%esp
    1af9:	68 94 44 00 00       	push   $0x4494
    1afe:	6a 01                	push   $0x1
    1b00:	e8 5b 1f 00 00       	call   3a60 <printf>
    1b05:	c7 04 24 21 47 00 00 	movl   $0x4721,(%esp)
    1b0c:	e8 12 1e 00 00       	call   3923 <unlink>
    1b11:	e8 b5 1d 00 00       	call   38cb <fork>
    1b16:	83 c4 10             	add    $0x10,%esp
    1b19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1b1c:	85 c0                	test   %eax,%eax
    1b1e:	0f 88 b6 00 00 00    	js     1bda <linkunlink+0xea>
    1b24:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b28:	bb 64 00 00 00       	mov    $0x64,%ebx
    1b2d:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
    1b32:	19 ff                	sbb    %edi,%edi
    1b34:	83 e7 60             	and    $0x60,%edi
    1b37:	83 c7 01             	add    $0x1,%edi
    1b3a:	eb 1e                	jmp    1b5a <linkunlink+0x6a>
    1b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1b40:	83 f8 01             	cmp    $0x1,%eax
    1b43:	74 7b                	je     1bc0 <linkunlink+0xd0>
    1b45:	83 ec 0c             	sub    $0xc,%esp
    1b48:	68 21 47 00 00       	push   $0x4721
    1b4d:	e8 d1 1d 00 00       	call   3923 <unlink>
    1b52:	83 c4 10             	add    $0x10,%esp
    1b55:	83 eb 01             	sub    $0x1,%ebx
    1b58:	74 41                	je     1b9b <linkunlink+0xab>
    1b5a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b60:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    1b66:	89 f8                	mov    %edi,%eax
    1b68:	f7 e6                	mul    %esi
    1b6a:	89 d0                	mov    %edx,%eax
    1b6c:	83 e2 fe             	and    $0xfffffffe,%edx
    1b6f:	d1 e8                	shr    %eax
    1b71:	01 c2                	add    %eax,%edx
    1b73:	89 f8                	mov    %edi,%eax
    1b75:	29 d0                	sub    %edx,%eax
    1b77:	75 c7                	jne    1b40 <linkunlink+0x50>
    1b79:	83 ec 08             	sub    $0x8,%esp
    1b7c:	68 02 02 00 00       	push   $0x202
    1b81:	68 21 47 00 00       	push   $0x4721
    1b86:	e8 88 1d 00 00       	call   3913 <open>
    1b8b:	89 04 24             	mov    %eax,(%esp)
    1b8e:	e8 68 1d 00 00       	call   38fb <close>
    1b93:	83 c4 10             	add    $0x10,%esp
    1b96:	83 eb 01             	sub    $0x1,%ebx
    1b99:	75 bf                	jne    1b5a <linkunlink+0x6a>
    1b9b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b9e:	85 c0                	test   %eax,%eax
    1ba0:	74 4b                	je     1bed <linkunlink+0xfd>
    1ba2:	e8 34 1d 00 00       	call   38db <wait>
    1ba7:	83 ec 08             	sub    $0x8,%esp
    1baa:	68 a9 44 00 00       	push   $0x44a9
    1baf:	6a 01                	push   $0x1
    1bb1:	e8 aa 1e 00 00       	call   3a60 <printf>
    1bb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1bb9:	5b                   	pop    %ebx
    1bba:	5e                   	pop    %esi
    1bbb:	5f                   	pop    %edi
    1bbc:	5d                   	pop    %ebp
    1bbd:	c3                   	ret    
    1bbe:	66 90                	xchg   %ax,%ax
    1bc0:	83 ec 08             	sub    $0x8,%esp
    1bc3:	68 21 47 00 00       	push   $0x4721
    1bc8:	68 a5 44 00 00       	push   $0x44a5
    1bcd:	e8 61 1d 00 00       	call   3933 <link>
    1bd2:	83 c4 10             	add    $0x10,%esp
    1bd5:	e9 7b ff ff ff       	jmp    1b55 <linkunlink+0x65>
    1bda:	52                   	push   %edx
    1bdb:	52                   	push   %edx
    1bdc:	68 09 4d 00 00       	push   $0x4d09
    1be1:	6a 01                	push   $0x1
    1be3:	e8 78 1e 00 00       	call   3a60 <printf>
    1be8:	e8 e6 1c 00 00       	call   38d3 <exit>
    1bed:	e8 e1 1c 00 00       	call   38d3 <exit>
    1bf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001c00 <bigdir>:
    1c00:	55                   	push   %ebp
    1c01:	89 e5                	mov    %esp,%ebp
    1c03:	57                   	push   %edi
    1c04:	56                   	push   %esi
    1c05:	53                   	push   %ebx
    1c06:	83 ec 24             	sub    $0x24,%esp
    1c09:	68 b8 44 00 00       	push   $0x44b8
    1c0e:	6a 01                	push   $0x1
    1c10:	e8 4b 1e 00 00       	call   3a60 <printf>
    1c15:	c7 04 24 c5 44 00 00 	movl   $0x44c5,(%esp)
    1c1c:	e8 02 1d 00 00       	call   3923 <unlink>
    1c21:	5a                   	pop    %edx
    1c22:	59                   	pop    %ecx
    1c23:	68 00 02 00 00       	push   $0x200
    1c28:	68 c5 44 00 00       	push   $0x44c5
    1c2d:	e8 e1 1c 00 00       	call   3913 <open>
    1c32:	83 c4 10             	add    $0x10,%esp
    1c35:	85 c0                	test   %eax,%eax
    1c37:	0f 88 de 00 00 00    	js     1d1b <bigdir+0x11b>
    1c3d:	83 ec 0c             	sub    $0xc,%esp
    1c40:	31 f6                	xor    %esi,%esi
    1c42:	8d 7d de             	lea    -0x22(%ebp),%edi
    1c45:	50                   	push   %eax
    1c46:	e8 b0 1c 00 00       	call   38fb <close>
    1c4b:	83 c4 10             	add    $0x10,%esp
    1c4e:	66 90                	xchg   %ax,%ax
    1c50:	89 f0                	mov    %esi,%eax
    1c52:	83 ec 08             	sub    $0x8,%esp
    1c55:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1c59:	c1 f8 06             	sar    $0x6,%eax
    1c5c:	57                   	push   %edi
    1c5d:	83 c0 30             	add    $0x30,%eax
    1c60:	68 c5 44 00 00       	push   $0x44c5
    1c65:	88 45 df             	mov    %al,-0x21(%ebp)
    1c68:	89 f0                	mov    %esi,%eax
    1c6a:	83 e0 3f             	and    $0x3f,%eax
    1c6d:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1c71:	83 c0 30             	add    $0x30,%eax
    1c74:	88 45 e0             	mov    %al,-0x20(%ebp)
    1c77:	e8 b7 1c 00 00       	call   3933 <link>
    1c7c:	83 c4 10             	add    $0x10,%esp
    1c7f:	89 c3                	mov    %eax,%ebx
    1c81:	85 c0                	test   %eax,%eax
    1c83:	75 6e                	jne    1cf3 <bigdir+0xf3>
    1c85:	83 c6 01             	add    $0x1,%esi
    1c88:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c8e:	75 c0                	jne    1c50 <bigdir+0x50>
    1c90:	83 ec 0c             	sub    $0xc,%esp
    1c93:	68 c5 44 00 00       	push   $0x44c5
    1c98:	e8 86 1c 00 00       	call   3923 <unlink>
    1c9d:	83 c4 10             	add    $0x10,%esp
    1ca0:	89 d8                	mov    %ebx,%eax
    1ca2:	83 ec 0c             	sub    $0xc,%esp
    1ca5:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1ca9:	c1 f8 06             	sar    $0x6,%eax
    1cac:	57                   	push   %edi
    1cad:	83 c0 30             	add    $0x30,%eax
    1cb0:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1cb4:	88 45 df             	mov    %al,-0x21(%ebp)
    1cb7:	89 d8                	mov    %ebx,%eax
    1cb9:	83 e0 3f             	and    $0x3f,%eax
    1cbc:	83 c0 30             	add    $0x30,%eax
    1cbf:	88 45 e0             	mov    %al,-0x20(%ebp)
    1cc2:	e8 5c 1c 00 00       	call   3923 <unlink>
    1cc7:	83 c4 10             	add    $0x10,%esp
    1cca:	85 c0                	test   %eax,%eax
    1ccc:	75 39                	jne    1d07 <bigdir+0x107>
    1cce:	83 c3 01             	add    $0x1,%ebx
    1cd1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1cd7:	75 c7                	jne    1ca0 <bigdir+0xa0>
    1cd9:	83 ec 08             	sub    $0x8,%esp
    1cdc:	68 07 45 00 00       	push   $0x4507
    1ce1:	6a 01                	push   $0x1
    1ce3:	e8 78 1d 00 00       	call   3a60 <printf>
    1ce8:	83 c4 10             	add    $0x10,%esp
    1ceb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cee:	5b                   	pop    %ebx
    1cef:	5e                   	pop    %esi
    1cf0:	5f                   	pop    %edi
    1cf1:	5d                   	pop    %ebp
    1cf2:	c3                   	ret    
    1cf3:	83 ec 08             	sub    $0x8,%esp
    1cf6:	68 de 44 00 00       	push   $0x44de
    1cfb:	6a 01                	push   $0x1
    1cfd:	e8 5e 1d 00 00       	call   3a60 <printf>
    1d02:	e8 cc 1b 00 00       	call   38d3 <exit>
    1d07:	83 ec 08             	sub    $0x8,%esp
    1d0a:	68 f2 44 00 00       	push   $0x44f2
    1d0f:	6a 01                	push   $0x1
    1d11:	e8 4a 1d 00 00       	call   3a60 <printf>
    1d16:	e8 b8 1b 00 00       	call   38d3 <exit>
    1d1b:	50                   	push   %eax
    1d1c:	50                   	push   %eax
    1d1d:	68 c8 44 00 00       	push   $0x44c8
    1d22:	6a 01                	push   $0x1
    1d24:	e8 37 1d 00 00       	call   3a60 <printf>
    1d29:	e8 a5 1b 00 00       	call   38d3 <exit>
    1d2e:	66 90                	xchg   %ax,%ax

00001d30 <subdir>:
    1d30:	55                   	push   %ebp
    1d31:	89 e5                	mov    %esp,%ebp
    1d33:	53                   	push   %ebx
    1d34:	83 ec 0c             	sub    $0xc,%esp
    1d37:	68 12 45 00 00       	push   $0x4512
    1d3c:	6a 01                	push   $0x1
    1d3e:	e8 1d 1d 00 00       	call   3a60 <printf>
    1d43:	c7 04 24 9b 45 00 00 	movl   $0x459b,(%esp)
    1d4a:	e8 d4 1b 00 00       	call   3923 <unlink>
    1d4f:	c7 04 24 38 46 00 00 	movl   $0x4638,(%esp)
    1d56:	e8 e0 1b 00 00       	call   393b <mkdir>
    1d5b:	83 c4 10             	add    $0x10,%esp
    1d5e:	85 c0                	test   %eax,%eax
    1d60:	0f 85 b3 05 00 00    	jne    2319 <subdir+0x5e9>
    1d66:	83 ec 08             	sub    $0x8,%esp
    1d69:	68 02 02 00 00       	push   $0x202
    1d6e:	68 71 45 00 00       	push   $0x4571
    1d73:	e8 9b 1b 00 00       	call   3913 <open>
    1d78:	83 c4 10             	add    $0x10,%esp
    1d7b:	89 c3                	mov    %eax,%ebx
    1d7d:	85 c0                	test   %eax,%eax
    1d7f:	0f 88 81 05 00 00    	js     2306 <subdir+0x5d6>
    1d85:	83 ec 04             	sub    $0x4,%esp
    1d88:	6a 02                	push   $0x2
    1d8a:	68 9b 45 00 00       	push   $0x459b
    1d8f:	50                   	push   %eax
    1d90:	e8 5e 1b 00 00       	call   38f3 <write>
    1d95:	89 1c 24             	mov    %ebx,(%esp)
    1d98:	e8 5e 1b 00 00       	call   38fb <close>
    1d9d:	c7 04 24 38 46 00 00 	movl   $0x4638,(%esp)
    1da4:	e8 7a 1b 00 00       	call   3923 <unlink>
    1da9:	83 c4 10             	add    $0x10,%esp
    1dac:	85 c0                	test   %eax,%eax
    1dae:	0f 89 3f 05 00 00    	jns    22f3 <subdir+0x5c3>
    1db4:	83 ec 0c             	sub    $0xc,%esp
    1db7:	68 4c 45 00 00       	push   $0x454c
    1dbc:	e8 7a 1b 00 00       	call   393b <mkdir>
    1dc1:	83 c4 10             	add    $0x10,%esp
    1dc4:	85 c0                	test   %eax,%eax
    1dc6:	0f 85 14 05 00 00    	jne    22e0 <subdir+0x5b0>
    1dcc:	83 ec 08             	sub    $0x8,%esp
    1dcf:	68 02 02 00 00       	push   $0x202
    1dd4:	68 6e 45 00 00       	push   $0x456e
    1dd9:	e8 35 1b 00 00       	call   3913 <open>
    1dde:	83 c4 10             	add    $0x10,%esp
    1de1:	89 c3                	mov    %eax,%ebx
    1de3:	85 c0                	test   %eax,%eax
    1de5:	0f 88 24 04 00 00    	js     220f <subdir+0x4df>
    1deb:	83 ec 04             	sub    $0x4,%esp
    1dee:	6a 02                	push   $0x2
    1df0:	68 8f 45 00 00       	push   $0x458f
    1df5:	50                   	push   %eax
    1df6:	e8 f8 1a 00 00       	call   38f3 <write>
    1dfb:	89 1c 24             	mov    %ebx,(%esp)
    1dfe:	e8 f8 1a 00 00       	call   38fb <close>
    1e03:	58                   	pop    %eax
    1e04:	5a                   	pop    %edx
    1e05:	6a 00                	push   $0x0
    1e07:	68 92 45 00 00       	push   $0x4592
    1e0c:	e8 02 1b 00 00       	call   3913 <open>
    1e11:	83 c4 10             	add    $0x10,%esp
    1e14:	89 c3                	mov    %eax,%ebx
    1e16:	85 c0                	test   %eax,%eax
    1e18:	0f 88 de 03 00 00    	js     21fc <subdir+0x4cc>
    1e1e:	83 ec 04             	sub    $0x4,%esp
    1e21:	68 00 20 00 00       	push   $0x2000
    1e26:	68 40 86 00 00       	push   $0x8640
    1e2b:	50                   	push   %eax
    1e2c:	e8 ba 1a 00 00       	call   38eb <read>
    1e31:	83 c4 10             	add    $0x10,%esp
    1e34:	83 f8 02             	cmp    $0x2,%eax
    1e37:	0f 85 3a 03 00 00    	jne    2177 <subdir+0x447>
    1e3d:	80 3d 40 86 00 00 66 	cmpb   $0x66,0x8640
    1e44:	0f 85 2d 03 00 00    	jne    2177 <subdir+0x447>
    1e4a:	83 ec 0c             	sub    $0xc,%esp
    1e4d:	53                   	push   %ebx
    1e4e:	e8 a8 1a 00 00       	call   38fb <close>
    1e53:	59                   	pop    %ecx
    1e54:	5b                   	pop    %ebx
    1e55:	68 d2 45 00 00       	push   $0x45d2
    1e5a:	68 6e 45 00 00       	push   $0x456e
    1e5f:	e8 cf 1a 00 00       	call   3933 <link>
    1e64:	83 c4 10             	add    $0x10,%esp
    1e67:	85 c0                	test   %eax,%eax
    1e69:	0f 85 c6 03 00 00    	jne    2235 <subdir+0x505>
    1e6f:	83 ec 0c             	sub    $0xc,%esp
    1e72:	68 6e 45 00 00       	push   $0x456e
    1e77:	e8 a7 1a 00 00       	call   3923 <unlink>
    1e7c:	83 c4 10             	add    $0x10,%esp
    1e7f:	85 c0                	test   %eax,%eax
    1e81:	0f 85 16 03 00 00    	jne    219d <subdir+0x46d>
    1e87:	83 ec 08             	sub    $0x8,%esp
    1e8a:	6a 00                	push   $0x0
    1e8c:	68 6e 45 00 00       	push   $0x456e
    1e91:	e8 7d 1a 00 00       	call   3913 <open>
    1e96:	83 c4 10             	add    $0x10,%esp
    1e99:	85 c0                	test   %eax,%eax
    1e9b:	0f 89 2c 04 00 00    	jns    22cd <subdir+0x59d>
    1ea1:	83 ec 0c             	sub    $0xc,%esp
    1ea4:	68 38 46 00 00       	push   $0x4638
    1ea9:	e8 95 1a 00 00       	call   3943 <chdir>
    1eae:	83 c4 10             	add    $0x10,%esp
    1eb1:	85 c0                	test   %eax,%eax
    1eb3:	0f 85 01 04 00 00    	jne    22ba <subdir+0x58a>
    1eb9:	83 ec 0c             	sub    $0xc,%esp
    1ebc:	68 06 46 00 00       	push   $0x4606
    1ec1:	e8 7d 1a 00 00       	call   3943 <chdir>
    1ec6:	83 c4 10             	add    $0x10,%esp
    1ec9:	85 c0                	test   %eax,%eax
    1ecb:	0f 85 b9 02 00 00    	jne    218a <subdir+0x45a>
    1ed1:	83 ec 0c             	sub    $0xc,%esp
    1ed4:	68 2c 46 00 00       	push   $0x462c
    1ed9:	e8 65 1a 00 00       	call   3943 <chdir>
    1ede:	83 c4 10             	add    $0x10,%esp
    1ee1:	85 c0                	test   %eax,%eax
    1ee3:	0f 85 a1 02 00 00    	jne    218a <subdir+0x45a>
    1ee9:	83 ec 0c             	sub    $0xc,%esp
    1eec:	68 3b 46 00 00       	push   $0x463b
    1ef1:	e8 4d 1a 00 00       	call   3943 <chdir>
    1ef6:	83 c4 10             	add    $0x10,%esp
    1ef9:	85 c0                	test   %eax,%eax
    1efb:	0f 85 21 03 00 00    	jne    2222 <subdir+0x4f2>
    1f01:	83 ec 08             	sub    $0x8,%esp
    1f04:	6a 00                	push   $0x0
    1f06:	68 d2 45 00 00       	push   $0x45d2
    1f0b:	e8 03 1a 00 00       	call   3913 <open>
    1f10:	83 c4 10             	add    $0x10,%esp
    1f13:	89 c3                	mov    %eax,%ebx
    1f15:	85 c0                	test   %eax,%eax
    1f17:	0f 88 e0 04 00 00    	js     23fd <subdir+0x6cd>
    1f1d:	83 ec 04             	sub    $0x4,%esp
    1f20:	68 00 20 00 00       	push   $0x2000
    1f25:	68 40 86 00 00       	push   $0x8640
    1f2a:	50                   	push   %eax
    1f2b:	e8 bb 19 00 00       	call   38eb <read>
    1f30:	83 c4 10             	add    $0x10,%esp
    1f33:	83 f8 02             	cmp    $0x2,%eax
    1f36:	0f 85 ae 04 00 00    	jne    23ea <subdir+0x6ba>
    1f3c:	83 ec 0c             	sub    $0xc,%esp
    1f3f:	53                   	push   %ebx
    1f40:	e8 b6 19 00 00       	call   38fb <close>
    1f45:	58                   	pop    %eax
    1f46:	5a                   	pop    %edx
    1f47:	6a 00                	push   $0x0
    1f49:	68 6e 45 00 00       	push   $0x456e
    1f4e:	e8 c0 19 00 00       	call   3913 <open>
    1f53:	83 c4 10             	add    $0x10,%esp
    1f56:	85 c0                	test   %eax,%eax
    1f58:	0f 89 65 02 00 00    	jns    21c3 <subdir+0x493>
    1f5e:	83 ec 08             	sub    $0x8,%esp
    1f61:	68 02 02 00 00       	push   $0x202
    1f66:	68 86 46 00 00       	push   $0x4686
    1f6b:	e8 a3 19 00 00       	call   3913 <open>
    1f70:	83 c4 10             	add    $0x10,%esp
    1f73:	85 c0                	test   %eax,%eax
    1f75:	0f 89 35 02 00 00    	jns    21b0 <subdir+0x480>
    1f7b:	83 ec 08             	sub    $0x8,%esp
    1f7e:	68 02 02 00 00       	push   $0x202
    1f83:	68 ab 46 00 00       	push   $0x46ab
    1f88:	e8 86 19 00 00       	call   3913 <open>
    1f8d:	83 c4 10             	add    $0x10,%esp
    1f90:	85 c0                	test   %eax,%eax
    1f92:	0f 89 0f 03 00 00    	jns    22a7 <subdir+0x577>
    1f98:	83 ec 08             	sub    $0x8,%esp
    1f9b:	68 00 02 00 00       	push   $0x200
    1fa0:	68 38 46 00 00       	push   $0x4638
    1fa5:	e8 69 19 00 00       	call   3913 <open>
    1faa:	83 c4 10             	add    $0x10,%esp
    1fad:	85 c0                	test   %eax,%eax
    1faf:	0f 89 df 02 00 00    	jns    2294 <subdir+0x564>
    1fb5:	83 ec 08             	sub    $0x8,%esp
    1fb8:	6a 02                	push   $0x2
    1fba:	68 38 46 00 00       	push   $0x4638
    1fbf:	e8 4f 19 00 00       	call   3913 <open>
    1fc4:	83 c4 10             	add    $0x10,%esp
    1fc7:	85 c0                	test   %eax,%eax
    1fc9:	0f 89 b2 02 00 00    	jns    2281 <subdir+0x551>
    1fcf:	83 ec 08             	sub    $0x8,%esp
    1fd2:	6a 01                	push   $0x1
    1fd4:	68 38 46 00 00       	push   $0x4638
    1fd9:	e8 35 19 00 00       	call   3913 <open>
    1fde:	83 c4 10             	add    $0x10,%esp
    1fe1:	85 c0                	test   %eax,%eax
    1fe3:	0f 89 85 02 00 00    	jns    226e <subdir+0x53e>
    1fe9:	83 ec 08             	sub    $0x8,%esp
    1fec:	68 1a 47 00 00       	push   $0x471a
    1ff1:	68 86 46 00 00       	push   $0x4686
    1ff6:	e8 38 19 00 00       	call   3933 <link>
    1ffb:	83 c4 10             	add    $0x10,%esp
    1ffe:	85 c0                	test   %eax,%eax
    2000:	0f 84 55 02 00 00    	je     225b <subdir+0x52b>
    2006:	83 ec 08             	sub    $0x8,%esp
    2009:	68 1a 47 00 00       	push   $0x471a
    200e:	68 ab 46 00 00       	push   $0x46ab
    2013:	e8 1b 19 00 00       	call   3933 <link>
    2018:	83 c4 10             	add    $0x10,%esp
    201b:	85 c0                	test   %eax,%eax
    201d:	0f 84 25 02 00 00    	je     2248 <subdir+0x518>
    2023:	83 ec 08             	sub    $0x8,%esp
    2026:	68 d2 45 00 00       	push   $0x45d2
    202b:	68 71 45 00 00       	push   $0x4571
    2030:	e8 fe 18 00 00       	call   3933 <link>
    2035:	83 c4 10             	add    $0x10,%esp
    2038:	85 c0                	test   %eax,%eax
    203a:	0f 84 a9 01 00 00    	je     21e9 <subdir+0x4b9>
    2040:	83 ec 0c             	sub    $0xc,%esp
    2043:	68 86 46 00 00       	push   $0x4686
    2048:	e8 ee 18 00 00       	call   393b <mkdir>
    204d:	83 c4 10             	add    $0x10,%esp
    2050:	85 c0                	test   %eax,%eax
    2052:	0f 84 7e 01 00 00    	je     21d6 <subdir+0x4a6>
    2058:	83 ec 0c             	sub    $0xc,%esp
    205b:	68 ab 46 00 00       	push   $0x46ab
    2060:	e8 d6 18 00 00       	call   393b <mkdir>
    2065:	83 c4 10             	add    $0x10,%esp
    2068:	85 c0                	test   %eax,%eax
    206a:	0f 84 67 03 00 00    	je     23d7 <subdir+0x6a7>
    2070:	83 ec 0c             	sub    $0xc,%esp
    2073:	68 d2 45 00 00       	push   $0x45d2
    2078:	e8 be 18 00 00       	call   393b <mkdir>
    207d:	83 c4 10             	add    $0x10,%esp
    2080:	85 c0                	test   %eax,%eax
    2082:	0f 84 3c 03 00 00    	je     23c4 <subdir+0x694>
    2088:	83 ec 0c             	sub    $0xc,%esp
    208b:	68 ab 46 00 00       	push   $0x46ab
    2090:	e8 8e 18 00 00       	call   3923 <unlink>
    2095:	83 c4 10             	add    $0x10,%esp
    2098:	85 c0                	test   %eax,%eax
    209a:	0f 84 11 03 00 00    	je     23b1 <subdir+0x681>
    20a0:	83 ec 0c             	sub    $0xc,%esp
    20a3:	68 86 46 00 00       	push   $0x4686
    20a8:	e8 76 18 00 00       	call   3923 <unlink>
    20ad:	83 c4 10             	add    $0x10,%esp
    20b0:	85 c0                	test   %eax,%eax
    20b2:	0f 84 e6 02 00 00    	je     239e <subdir+0x66e>
    20b8:	83 ec 0c             	sub    $0xc,%esp
    20bb:	68 71 45 00 00       	push   $0x4571
    20c0:	e8 7e 18 00 00       	call   3943 <chdir>
    20c5:	83 c4 10             	add    $0x10,%esp
    20c8:	85 c0                	test   %eax,%eax
    20ca:	0f 84 bb 02 00 00    	je     238b <subdir+0x65b>
    20d0:	83 ec 0c             	sub    $0xc,%esp
    20d3:	68 1d 47 00 00       	push   $0x471d
    20d8:	e8 66 18 00 00       	call   3943 <chdir>
    20dd:	83 c4 10             	add    $0x10,%esp
    20e0:	85 c0                	test   %eax,%eax
    20e2:	0f 84 90 02 00 00    	je     2378 <subdir+0x648>
    20e8:	83 ec 0c             	sub    $0xc,%esp
    20eb:	68 d2 45 00 00       	push   $0x45d2
    20f0:	e8 2e 18 00 00       	call   3923 <unlink>
    20f5:	83 c4 10             	add    $0x10,%esp
    20f8:	85 c0                	test   %eax,%eax
    20fa:	0f 85 9d 00 00 00    	jne    219d <subdir+0x46d>
    2100:	83 ec 0c             	sub    $0xc,%esp
    2103:	68 71 45 00 00       	push   $0x4571
    2108:	e8 16 18 00 00       	call   3923 <unlink>
    210d:	83 c4 10             	add    $0x10,%esp
    2110:	85 c0                	test   %eax,%eax
    2112:	0f 85 4d 02 00 00    	jne    2365 <subdir+0x635>
    2118:	83 ec 0c             	sub    $0xc,%esp
    211b:	68 38 46 00 00       	push   $0x4638
    2120:	e8 fe 17 00 00       	call   3923 <unlink>
    2125:	83 c4 10             	add    $0x10,%esp
    2128:	85 c0                	test   %eax,%eax
    212a:	0f 84 22 02 00 00    	je     2352 <subdir+0x622>
    2130:	83 ec 0c             	sub    $0xc,%esp
    2133:	68 4d 45 00 00       	push   $0x454d
    2138:	e8 e6 17 00 00       	call   3923 <unlink>
    213d:	83 c4 10             	add    $0x10,%esp
    2140:	85 c0                	test   %eax,%eax
    2142:	0f 88 f7 01 00 00    	js     233f <subdir+0x60f>
    2148:	83 ec 0c             	sub    $0xc,%esp
    214b:	68 38 46 00 00       	push   $0x4638
    2150:	e8 ce 17 00 00       	call   3923 <unlink>
    2155:	83 c4 10             	add    $0x10,%esp
    2158:	85 c0                	test   %eax,%eax
    215a:	0f 88 cc 01 00 00    	js     232c <subdir+0x5fc>
    2160:	83 ec 08             	sub    $0x8,%esp
    2163:	68 1a 48 00 00       	push   $0x481a
    2168:	6a 01                	push   $0x1
    216a:	e8 f1 18 00 00       	call   3a60 <printf>
    216f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2172:	83 c4 10             	add    $0x10,%esp
    2175:	c9                   	leave  
    2176:	c3                   	ret    
    2177:	50                   	push   %eax
    2178:	50                   	push   %eax
    2179:	68 b7 45 00 00       	push   $0x45b7
    217e:	6a 01                	push   $0x1
    2180:	e8 db 18 00 00       	call   3a60 <printf>
    2185:	e8 49 17 00 00       	call   38d3 <exit>
    218a:	50                   	push   %eax
    218b:	50                   	push   %eax
    218c:	68 12 46 00 00       	push   $0x4612
    2191:	6a 01                	push   $0x1
    2193:	e8 c8 18 00 00       	call   3a60 <printf>
    2198:	e8 36 17 00 00       	call   38d3 <exit>
    219d:	50                   	push   %eax
    219e:	50                   	push   %eax
    219f:	68 dd 45 00 00       	push   $0x45dd
    21a4:	6a 01                	push   $0x1
    21a6:	e8 b5 18 00 00       	call   3a60 <printf>
    21ab:	e8 23 17 00 00       	call   38d3 <exit>
    21b0:	51                   	push   %ecx
    21b1:	51                   	push   %ecx
    21b2:	68 8f 46 00 00       	push   $0x468f
    21b7:	6a 01                	push   $0x1
    21b9:	e8 a2 18 00 00       	call   3a60 <printf>
    21be:	e8 10 17 00 00       	call   38d3 <exit>
    21c3:	53                   	push   %ebx
    21c4:	53                   	push   %ebx
    21c5:	68 74 50 00 00       	push   $0x5074
    21ca:	6a 01                	push   $0x1
    21cc:	e8 8f 18 00 00       	call   3a60 <printf>
    21d1:	e8 fd 16 00 00       	call   38d3 <exit>
    21d6:	51                   	push   %ecx
    21d7:	51                   	push   %ecx
    21d8:	68 23 47 00 00       	push   $0x4723
    21dd:	6a 01                	push   $0x1
    21df:	e8 7c 18 00 00       	call   3a60 <printf>
    21e4:	e8 ea 16 00 00       	call   38d3 <exit>
    21e9:	53                   	push   %ebx
    21ea:	53                   	push   %ebx
    21eb:	68 e4 50 00 00       	push   $0x50e4
    21f0:	6a 01                	push   $0x1
    21f2:	e8 69 18 00 00       	call   3a60 <printf>
    21f7:	e8 d7 16 00 00       	call   38d3 <exit>
    21fc:	50                   	push   %eax
    21fd:	50                   	push   %eax
    21fe:	68 9e 45 00 00       	push   $0x459e
    2203:	6a 01                	push   $0x1
    2205:	e8 56 18 00 00       	call   3a60 <printf>
    220a:	e8 c4 16 00 00       	call   38d3 <exit>
    220f:	51                   	push   %ecx
    2210:	51                   	push   %ecx
    2211:	68 77 45 00 00       	push   $0x4577
    2216:	6a 01                	push   $0x1
    2218:	e8 43 18 00 00       	call   3a60 <printf>
    221d:	e8 b1 16 00 00       	call   38d3 <exit>
    2222:	50                   	push   %eax
    2223:	50                   	push   %eax
    2224:	68 40 46 00 00       	push   $0x4640
    2229:	6a 01                	push   $0x1
    222b:	e8 30 18 00 00       	call   3a60 <printf>
    2230:	e8 9e 16 00 00       	call   38d3 <exit>
    2235:	52                   	push   %edx
    2236:	52                   	push   %edx
    2237:	68 2c 50 00 00       	push   $0x502c
    223c:	6a 01                	push   $0x1
    223e:	e8 1d 18 00 00       	call   3a60 <printf>
    2243:	e8 8b 16 00 00       	call   38d3 <exit>
    2248:	50                   	push   %eax
    2249:	50                   	push   %eax
    224a:	68 c0 50 00 00       	push   $0x50c0
    224f:	6a 01                	push   $0x1
    2251:	e8 0a 18 00 00       	call   3a60 <printf>
    2256:	e8 78 16 00 00       	call   38d3 <exit>
    225b:	50                   	push   %eax
    225c:	50                   	push   %eax
    225d:	68 9c 50 00 00       	push   $0x509c
    2262:	6a 01                	push   $0x1
    2264:	e8 f7 17 00 00       	call   3a60 <printf>
    2269:	e8 65 16 00 00       	call   38d3 <exit>
    226e:	50                   	push   %eax
    226f:	50                   	push   %eax
    2270:	68 ff 46 00 00       	push   $0x46ff
    2275:	6a 01                	push   $0x1
    2277:	e8 e4 17 00 00       	call   3a60 <printf>
    227c:	e8 52 16 00 00       	call   38d3 <exit>
    2281:	50                   	push   %eax
    2282:	50                   	push   %eax
    2283:	68 e6 46 00 00       	push   $0x46e6
    2288:	6a 01                	push   $0x1
    228a:	e8 d1 17 00 00       	call   3a60 <printf>
    228f:	e8 3f 16 00 00       	call   38d3 <exit>
    2294:	50                   	push   %eax
    2295:	50                   	push   %eax
    2296:	68 d0 46 00 00       	push   $0x46d0
    229b:	6a 01                	push   $0x1
    229d:	e8 be 17 00 00       	call   3a60 <printf>
    22a2:	e8 2c 16 00 00       	call   38d3 <exit>
    22a7:	52                   	push   %edx
    22a8:	52                   	push   %edx
    22a9:	68 b4 46 00 00       	push   $0x46b4
    22ae:	6a 01                	push   $0x1
    22b0:	e8 ab 17 00 00       	call   3a60 <printf>
    22b5:	e8 19 16 00 00       	call   38d3 <exit>
    22ba:	50                   	push   %eax
    22bb:	50                   	push   %eax
    22bc:	68 f5 45 00 00       	push   $0x45f5
    22c1:	6a 01                	push   $0x1
    22c3:	e8 98 17 00 00       	call   3a60 <printf>
    22c8:	e8 06 16 00 00       	call   38d3 <exit>
    22cd:	50                   	push   %eax
    22ce:	50                   	push   %eax
    22cf:	68 50 50 00 00       	push   $0x5050
    22d4:	6a 01                	push   $0x1
    22d6:	e8 85 17 00 00       	call   3a60 <printf>
    22db:	e8 f3 15 00 00       	call   38d3 <exit>
    22e0:	53                   	push   %ebx
    22e1:	53                   	push   %ebx
    22e2:	68 53 45 00 00       	push   $0x4553
    22e7:	6a 01                	push   $0x1
    22e9:	e8 72 17 00 00       	call   3a60 <printf>
    22ee:	e8 e0 15 00 00       	call   38d3 <exit>
    22f3:	50                   	push   %eax
    22f4:	50                   	push   %eax
    22f5:	68 04 50 00 00       	push   $0x5004
    22fa:	6a 01                	push   $0x1
    22fc:	e8 5f 17 00 00       	call   3a60 <printf>
    2301:	e8 cd 15 00 00       	call   38d3 <exit>
    2306:	50                   	push   %eax
    2307:	50                   	push   %eax
    2308:	68 37 45 00 00       	push   $0x4537
    230d:	6a 01                	push   $0x1
    230f:	e8 4c 17 00 00       	call   3a60 <printf>
    2314:	e8 ba 15 00 00       	call   38d3 <exit>
    2319:	50                   	push   %eax
    231a:	50                   	push   %eax
    231b:	68 1f 45 00 00       	push   $0x451f
    2320:	6a 01                	push   $0x1
    2322:	e8 39 17 00 00       	call   3a60 <printf>
    2327:	e8 a7 15 00 00       	call   38d3 <exit>
    232c:	50                   	push   %eax
    232d:	50                   	push   %eax
    232e:	68 08 48 00 00       	push   $0x4808
    2333:	6a 01                	push   $0x1
    2335:	e8 26 17 00 00       	call   3a60 <printf>
    233a:	e8 94 15 00 00       	call   38d3 <exit>
    233f:	52                   	push   %edx
    2340:	52                   	push   %edx
    2341:	68 f3 47 00 00       	push   $0x47f3
    2346:	6a 01                	push   $0x1
    2348:	e8 13 17 00 00       	call   3a60 <printf>
    234d:	e8 81 15 00 00       	call   38d3 <exit>
    2352:	51                   	push   %ecx
    2353:	51                   	push   %ecx
    2354:	68 08 51 00 00       	push   $0x5108
    2359:	6a 01                	push   $0x1
    235b:	e8 00 17 00 00       	call   3a60 <printf>
    2360:	e8 6e 15 00 00       	call   38d3 <exit>
    2365:	53                   	push   %ebx
    2366:	53                   	push   %ebx
    2367:	68 de 47 00 00       	push   $0x47de
    236c:	6a 01                	push   $0x1
    236e:	e8 ed 16 00 00       	call   3a60 <printf>
    2373:	e8 5b 15 00 00       	call   38d3 <exit>
    2378:	50                   	push   %eax
    2379:	50                   	push   %eax
    237a:	68 c6 47 00 00       	push   $0x47c6
    237f:	6a 01                	push   $0x1
    2381:	e8 da 16 00 00       	call   3a60 <printf>
    2386:	e8 48 15 00 00       	call   38d3 <exit>
    238b:	50                   	push   %eax
    238c:	50                   	push   %eax
    238d:	68 ae 47 00 00       	push   $0x47ae
    2392:	6a 01                	push   $0x1
    2394:	e8 c7 16 00 00       	call   3a60 <printf>
    2399:	e8 35 15 00 00       	call   38d3 <exit>
    239e:	50                   	push   %eax
    239f:	50                   	push   %eax
    23a0:	68 92 47 00 00       	push   $0x4792
    23a5:	6a 01                	push   $0x1
    23a7:	e8 b4 16 00 00       	call   3a60 <printf>
    23ac:	e8 22 15 00 00       	call   38d3 <exit>
    23b1:	50                   	push   %eax
    23b2:	50                   	push   %eax
    23b3:	68 76 47 00 00       	push   $0x4776
    23b8:	6a 01                	push   $0x1
    23ba:	e8 a1 16 00 00       	call   3a60 <printf>
    23bf:	e8 0f 15 00 00       	call   38d3 <exit>
    23c4:	50                   	push   %eax
    23c5:	50                   	push   %eax
    23c6:	68 59 47 00 00       	push   $0x4759
    23cb:	6a 01                	push   $0x1
    23cd:	e8 8e 16 00 00       	call   3a60 <printf>
    23d2:	e8 fc 14 00 00       	call   38d3 <exit>
    23d7:	52                   	push   %edx
    23d8:	52                   	push   %edx
    23d9:	68 3e 47 00 00       	push   $0x473e
    23de:	6a 01                	push   $0x1
    23e0:	e8 7b 16 00 00       	call   3a60 <printf>
    23e5:	e8 e9 14 00 00       	call   38d3 <exit>
    23ea:	51                   	push   %ecx
    23eb:	51                   	push   %ecx
    23ec:	68 6b 46 00 00       	push   $0x466b
    23f1:	6a 01                	push   $0x1
    23f3:	e8 68 16 00 00       	call   3a60 <printf>
    23f8:	e8 d6 14 00 00       	call   38d3 <exit>
    23fd:	53                   	push   %ebx
    23fe:	53                   	push   %ebx
    23ff:	68 53 46 00 00       	push   $0x4653
    2404:	6a 01                	push   $0x1
    2406:	e8 55 16 00 00       	call   3a60 <printf>
    240b:	e8 c3 14 00 00       	call   38d3 <exit>

00002410 <bigwrite>:
    2410:	55                   	push   %ebp
    2411:	89 e5                	mov    %esp,%ebp
    2413:	56                   	push   %esi
    2414:	53                   	push   %ebx
    2415:	bb f3 01 00 00       	mov    $0x1f3,%ebx
    241a:	83 ec 08             	sub    $0x8,%esp
    241d:	68 25 48 00 00       	push   $0x4825
    2422:	6a 01                	push   $0x1
    2424:	e8 37 16 00 00       	call   3a60 <printf>
    2429:	c7 04 24 34 48 00 00 	movl   $0x4834,(%esp)
    2430:	e8 ee 14 00 00       	call   3923 <unlink>
    2435:	83 c4 10             	add    $0x10,%esp
    2438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    243f:	90                   	nop
    2440:	83 ec 08             	sub    $0x8,%esp
    2443:	68 02 02 00 00       	push   $0x202
    2448:	68 34 48 00 00       	push   $0x4834
    244d:	e8 c1 14 00 00       	call   3913 <open>
    2452:	83 c4 10             	add    $0x10,%esp
    2455:	89 c6                	mov    %eax,%esi
    2457:	85 c0                	test   %eax,%eax
    2459:	78 7e                	js     24d9 <bigwrite+0xc9>
    245b:	83 ec 04             	sub    $0x4,%esp
    245e:	53                   	push   %ebx
    245f:	68 40 86 00 00       	push   $0x8640
    2464:	50                   	push   %eax
    2465:	e8 89 14 00 00       	call   38f3 <write>
    246a:	83 c4 10             	add    $0x10,%esp
    246d:	39 d8                	cmp    %ebx,%eax
    246f:	75 55                	jne    24c6 <bigwrite+0xb6>
    2471:	83 ec 04             	sub    $0x4,%esp
    2474:	53                   	push   %ebx
    2475:	68 40 86 00 00       	push   $0x8640
    247a:	56                   	push   %esi
    247b:	e8 73 14 00 00       	call   38f3 <write>
    2480:	83 c4 10             	add    $0x10,%esp
    2483:	39 d8                	cmp    %ebx,%eax
    2485:	75 3f                	jne    24c6 <bigwrite+0xb6>
    2487:	83 ec 0c             	sub    $0xc,%esp
    248a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    2490:	56                   	push   %esi
    2491:	e8 65 14 00 00       	call   38fb <close>
    2496:	c7 04 24 34 48 00 00 	movl   $0x4834,(%esp)
    249d:	e8 81 14 00 00       	call   3923 <unlink>
    24a2:	83 c4 10             	add    $0x10,%esp
    24a5:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    24ab:	75 93                	jne    2440 <bigwrite+0x30>
    24ad:	83 ec 08             	sub    $0x8,%esp
    24b0:	68 67 48 00 00       	push   $0x4867
    24b5:	6a 01                	push   $0x1
    24b7:	e8 a4 15 00 00       	call   3a60 <printf>
    24bc:	83 c4 10             	add    $0x10,%esp
    24bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
    24c2:	5b                   	pop    %ebx
    24c3:	5e                   	pop    %esi
    24c4:	5d                   	pop    %ebp
    24c5:	c3                   	ret    
    24c6:	50                   	push   %eax
    24c7:	53                   	push   %ebx
    24c8:	68 55 48 00 00       	push   $0x4855
    24cd:	6a 01                	push   $0x1
    24cf:	e8 8c 15 00 00       	call   3a60 <printf>
    24d4:	e8 fa 13 00 00       	call   38d3 <exit>
    24d9:	83 ec 08             	sub    $0x8,%esp
    24dc:	68 3d 48 00 00       	push   $0x483d
    24e1:	6a 01                	push   $0x1
    24e3:	e8 78 15 00 00       	call   3a60 <printf>
    24e8:	e8 e6 13 00 00       	call   38d3 <exit>
    24ed:	8d 76 00             	lea    0x0(%esi),%esi

000024f0 <bigfile>:
    24f0:	55                   	push   %ebp
    24f1:	89 e5                	mov    %esp,%ebp
    24f3:	57                   	push   %edi
    24f4:	56                   	push   %esi
    24f5:	53                   	push   %ebx
    24f6:	83 ec 14             	sub    $0x14,%esp
    24f9:	68 74 48 00 00       	push   $0x4874
    24fe:	6a 01                	push   $0x1
    2500:	e8 5b 15 00 00       	call   3a60 <printf>
    2505:	c7 04 24 90 48 00 00 	movl   $0x4890,(%esp)
    250c:	e8 12 14 00 00       	call   3923 <unlink>
    2511:	58                   	pop    %eax
    2512:	5a                   	pop    %edx
    2513:	68 02 02 00 00       	push   $0x202
    2518:	68 90 48 00 00       	push   $0x4890
    251d:	e8 f1 13 00 00       	call   3913 <open>
    2522:	83 c4 10             	add    $0x10,%esp
    2525:	85 c0                	test   %eax,%eax
    2527:	0f 88 5e 01 00 00    	js     268b <bigfile+0x19b>
    252d:	89 c6                	mov    %eax,%esi
    252f:	31 db                	xor    %ebx,%ebx
    2531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2538:	83 ec 04             	sub    $0x4,%esp
    253b:	68 58 02 00 00       	push   $0x258
    2540:	53                   	push   %ebx
    2541:	68 40 86 00 00       	push   $0x8640
    2546:	e8 e5 11 00 00       	call   3730 <memset>
    254b:	83 c4 0c             	add    $0xc,%esp
    254e:	68 58 02 00 00       	push   $0x258
    2553:	68 40 86 00 00       	push   $0x8640
    2558:	56                   	push   %esi
    2559:	e8 95 13 00 00       	call   38f3 <write>
    255e:	83 c4 10             	add    $0x10,%esp
    2561:	3d 58 02 00 00       	cmp    $0x258,%eax
    2566:	0f 85 f8 00 00 00    	jne    2664 <bigfile+0x174>
    256c:	83 c3 01             	add    $0x1,%ebx
    256f:	83 fb 14             	cmp    $0x14,%ebx
    2572:	75 c4                	jne    2538 <bigfile+0x48>
    2574:	83 ec 0c             	sub    $0xc,%esp
    2577:	56                   	push   %esi
    2578:	e8 7e 13 00 00       	call   38fb <close>
    257d:	5e                   	pop    %esi
    257e:	5f                   	pop    %edi
    257f:	6a 00                	push   $0x0
    2581:	68 90 48 00 00       	push   $0x4890
    2586:	e8 88 13 00 00       	call   3913 <open>
    258b:	83 c4 10             	add    $0x10,%esp
    258e:	89 c6                	mov    %eax,%esi
    2590:	85 c0                	test   %eax,%eax
    2592:	0f 88 e0 00 00 00    	js     2678 <bigfile+0x188>
    2598:	31 db                	xor    %ebx,%ebx
    259a:	31 ff                	xor    %edi,%edi
    259c:	eb 30                	jmp    25ce <bigfile+0xde>
    259e:	66 90                	xchg   %ax,%ax
    25a0:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    25a5:	0f 85 91 00 00 00    	jne    263c <bigfile+0x14c>
    25ab:	89 fa                	mov    %edi,%edx
    25ad:	0f be 05 40 86 00 00 	movsbl 0x8640,%eax
    25b4:	d1 fa                	sar    %edx
    25b6:	39 d0                	cmp    %edx,%eax
    25b8:	75 6e                	jne    2628 <bigfile+0x138>
    25ba:	0f be 15 6b 87 00 00 	movsbl 0x876b,%edx
    25c1:	39 d0                	cmp    %edx,%eax
    25c3:	75 63                	jne    2628 <bigfile+0x138>
    25c5:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
    25cb:	83 c7 01             	add    $0x1,%edi
    25ce:	83 ec 04             	sub    $0x4,%esp
    25d1:	68 2c 01 00 00       	push   $0x12c
    25d6:	68 40 86 00 00       	push   $0x8640
    25db:	56                   	push   %esi
    25dc:	e8 0a 13 00 00       	call   38eb <read>
    25e1:	83 c4 10             	add    $0x10,%esp
    25e4:	85 c0                	test   %eax,%eax
    25e6:	78 68                	js     2650 <bigfile+0x160>
    25e8:	75 b6                	jne    25a0 <bigfile+0xb0>
    25ea:	83 ec 0c             	sub    $0xc,%esp
    25ed:	56                   	push   %esi
    25ee:	e8 08 13 00 00       	call   38fb <close>
    25f3:	83 c4 10             	add    $0x10,%esp
    25f6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25fc:	0f 85 9c 00 00 00    	jne    269e <bigfile+0x1ae>
    2602:	83 ec 0c             	sub    $0xc,%esp
    2605:	68 90 48 00 00       	push   $0x4890
    260a:	e8 14 13 00 00       	call   3923 <unlink>
    260f:	58                   	pop    %eax
    2610:	5a                   	pop    %edx
    2611:	68 1f 49 00 00       	push   $0x491f
    2616:	6a 01                	push   $0x1
    2618:	e8 43 14 00 00       	call   3a60 <printf>
    261d:	83 c4 10             	add    $0x10,%esp
    2620:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2623:	5b                   	pop    %ebx
    2624:	5e                   	pop    %esi
    2625:	5f                   	pop    %edi
    2626:	5d                   	pop    %ebp
    2627:	c3                   	ret    
    2628:	83 ec 08             	sub    $0x8,%esp
    262b:	68 ec 48 00 00       	push   $0x48ec
    2630:	6a 01                	push   $0x1
    2632:	e8 29 14 00 00       	call   3a60 <printf>
    2637:	e8 97 12 00 00       	call   38d3 <exit>
    263c:	83 ec 08             	sub    $0x8,%esp
    263f:	68 d8 48 00 00       	push   $0x48d8
    2644:	6a 01                	push   $0x1
    2646:	e8 15 14 00 00       	call   3a60 <printf>
    264b:	e8 83 12 00 00       	call   38d3 <exit>
    2650:	83 ec 08             	sub    $0x8,%esp
    2653:	68 c3 48 00 00       	push   $0x48c3
    2658:	6a 01                	push   $0x1
    265a:	e8 01 14 00 00       	call   3a60 <printf>
    265f:	e8 6f 12 00 00       	call   38d3 <exit>
    2664:	83 ec 08             	sub    $0x8,%esp
    2667:	68 98 48 00 00       	push   $0x4898
    266c:	6a 01                	push   $0x1
    266e:	e8 ed 13 00 00       	call   3a60 <printf>
    2673:	e8 5b 12 00 00       	call   38d3 <exit>
    2678:	53                   	push   %ebx
    2679:	53                   	push   %ebx
    267a:	68 ae 48 00 00       	push   $0x48ae
    267f:	6a 01                	push   $0x1
    2681:	e8 da 13 00 00       	call   3a60 <printf>
    2686:	e8 48 12 00 00       	call   38d3 <exit>
    268b:	50                   	push   %eax
    268c:	50                   	push   %eax
    268d:	68 82 48 00 00       	push   $0x4882
    2692:	6a 01                	push   $0x1
    2694:	e8 c7 13 00 00       	call   3a60 <printf>
    2699:	e8 35 12 00 00       	call   38d3 <exit>
    269e:	51                   	push   %ecx
    269f:	51                   	push   %ecx
    26a0:	68 05 49 00 00       	push   $0x4905
    26a5:	6a 01                	push   $0x1
    26a7:	e8 b4 13 00 00       	call   3a60 <printf>
    26ac:	e8 22 12 00 00       	call   38d3 <exit>
    26b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    26b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    26bf:	90                   	nop

000026c0 <fourteen>:
    26c0:	55                   	push   %ebp
    26c1:	89 e5                	mov    %esp,%ebp
    26c3:	83 ec 10             	sub    $0x10,%esp
    26c6:	68 30 49 00 00       	push   $0x4930
    26cb:	6a 01                	push   $0x1
    26cd:	e8 8e 13 00 00       	call   3a60 <printf>
    26d2:	c7 04 24 6b 49 00 00 	movl   $0x496b,(%esp)
    26d9:	e8 5d 12 00 00       	call   393b <mkdir>
    26de:	83 c4 10             	add    $0x10,%esp
    26e1:	85 c0                	test   %eax,%eax
    26e3:	0f 85 97 00 00 00    	jne    2780 <fourteen+0xc0>
    26e9:	83 ec 0c             	sub    $0xc,%esp
    26ec:	68 28 51 00 00       	push   $0x5128
    26f1:	e8 45 12 00 00       	call   393b <mkdir>
    26f6:	83 c4 10             	add    $0x10,%esp
    26f9:	85 c0                	test   %eax,%eax
    26fb:	0f 85 de 00 00 00    	jne    27df <fourteen+0x11f>
    2701:	83 ec 08             	sub    $0x8,%esp
    2704:	68 00 02 00 00       	push   $0x200
    2709:	68 78 51 00 00       	push   $0x5178
    270e:	e8 00 12 00 00       	call   3913 <open>
    2713:	83 c4 10             	add    $0x10,%esp
    2716:	85 c0                	test   %eax,%eax
    2718:	0f 88 ae 00 00 00    	js     27cc <fourteen+0x10c>
    271e:	83 ec 0c             	sub    $0xc,%esp
    2721:	50                   	push   %eax
    2722:	e8 d4 11 00 00       	call   38fb <close>
    2727:	58                   	pop    %eax
    2728:	5a                   	pop    %edx
    2729:	6a 00                	push   $0x0
    272b:	68 e8 51 00 00       	push   $0x51e8
    2730:	e8 de 11 00 00       	call   3913 <open>
    2735:	83 c4 10             	add    $0x10,%esp
    2738:	85 c0                	test   %eax,%eax
    273a:	78 7d                	js     27b9 <fourteen+0xf9>
    273c:	83 ec 0c             	sub    $0xc,%esp
    273f:	50                   	push   %eax
    2740:	e8 b6 11 00 00       	call   38fb <close>
    2745:	c7 04 24 5c 49 00 00 	movl   $0x495c,(%esp)
    274c:	e8 ea 11 00 00       	call   393b <mkdir>
    2751:	83 c4 10             	add    $0x10,%esp
    2754:	85 c0                	test   %eax,%eax
    2756:	74 4e                	je     27a6 <fourteen+0xe6>
    2758:	83 ec 0c             	sub    $0xc,%esp
    275b:	68 84 52 00 00       	push   $0x5284
    2760:	e8 d6 11 00 00       	call   393b <mkdir>
    2765:	83 c4 10             	add    $0x10,%esp
    2768:	85 c0                	test   %eax,%eax
    276a:	74 27                	je     2793 <fourteen+0xd3>
    276c:	83 ec 08             	sub    $0x8,%esp
    276f:	68 7a 49 00 00       	push   $0x497a
    2774:	6a 01                	push   $0x1
    2776:	e8 e5 12 00 00       	call   3a60 <printf>
    277b:	83 c4 10             	add    $0x10,%esp
    277e:	c9                   	leave  
    277f:	c3                   	ret    
    2780:	50                   	push   %eax
    2781:	50                   	push   %eax
    2782:	68 3f 49 00 00       	push   $0x493f
    2787:	6a 01                	push   $0x1
    2789:	e8 d2 12 00 00       	call   3a60 <printf>
    278e:	e8 40 11 00 00       	call   38d3 <exit>
    2793:	50                   	push   %eax
    2794:	50                   	push   %eax
    2795:	68 a4 52 00 00       	push   $0x52a4
    279a:	6a 01                	push   $0x1
    279c:	e8 bf 12 00 00       	call   3a60 <printf>
    27a1:	e8 2d 11 00 00       	call   38d3 <exit>
    27a6:	52                   	push   %edx
    27a7:	52                   	push   %edx
    27a8:	68 54 52 00 00       	push   $0x5254
    27ad:	6a 01                	push   $0x1
    27af:	e8 ac 12 00 00       	call   3a60 <printf>
    27b4:	e8 1a 11 00 00       	call   38d3 <exit>
    27b9:	51                   	push   %ecx
    27ba:	51                   	push   %ecx
    27bb:	68 18 52 00 00       	push   $0x5218
    27c0:	6a 01                	push   $0x1
    27c2:	e8 99 12 00 00       	call   3a60 <printf>
    27c7:	e8 07 11 00 00       	call   38d3 <exit>
    27cc:	51                   	push   %ecx
    27cd:	51                   	push   %ecx
    27ce:	68 a8 51 00 00       	push   $0x51a8
    27d3:	6a 01                	push   $0x1
    27d5:	e8 86 12 00 00       	call   3a60 <printf>
    27da:	e8 f4 10 00 00       	call   38d3 <exit>
    27df:	50                   	push   %eax
    27e0:	50                   	push   %eax
    27e1:	68 48 51 00 00       	push   $0x5148
    27e6:	6a 01                	push   $0x1
    27e8:	e8 73 12 00 00       	call   3a60 <printf>
    27ed:	e8 e1 10 00 00       	call   38d3 <exit>
    27f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002800 <rmdot>:
    2800:	55                   	push   %ebp
    2801:	89 e5                	mov    %esp,%ebp
    2803:	83 ec 10             	sub    $0x10,%esp
    2806:	68 87 49 00 00       	push   $0x4987
    280b:	6a 01                	push   $0x1
    280d:	e8 4e 12 00 00       	call   3a60 <printf>
    2812:	c7 04 24 93 49 00 00 	movl   $0x4993,(%esp)
    2819:	e8 1d 11 00 00       	call   393b <mkdir>
    281e:	83 c4 10             	add    $0x10,%esp
    2821:	85 c0                	test   %eax,%eax
    2823:	0f 85 b0 00 00 00    	jne    28d9 <rmdot+0xd9>
    2829:	83 ec 0c             	sub    $0xc,%esp
    282c:	68 93 49 00 00       	push   $0x4993
    2831:	e8 0d 11 00 00       	call   3943 <chdir>
    2836:	83 c4 10             	add    $0x10,%esp
    2839:	85 c0                	test   %eax,%eax
    283b:	0f 85 1d 01 00 00    	jne    295e <rmdot+0x15e>
    2841:	83 ec 0c             	sub    $0xc,%esp
    2844:	68 3e 46 00 00       	push   $0x463e
    2849:	e8 d5 10 00 00       	call   3923 <unlink>
    284e:	83 c4 10             	add    $0x10,%esp
    2851:	85 c0                	test   %eax,%eax
    2853:	0f 84 f2 00 00 00    	je     294b <rmdot+0x14b>
    2859:	83 ec 0c             	sub    $0xc,%esp
    285c:	68 3d 46 00 00       	push   $0x463d
    2861:	e8 bd 10 00 00       	call   3923 <unlink>
    2866:	83 c4 10             	add    $0x10,%esp
    2869:	85 c0                	test   %eax,%eax
    286b:	0f 84 c7 00 00 00    	je     2938 <rmdot+0x138>
    2871:	83 ec 0c             	sub    $0xc,%esp
    2874:	68 11 3e 00 00       	push   $0x3e11
    2879:	e8 c5 10 00 00       	call   3943 <chdir>
    287e:	83 c4 10             	add    $0x10,%esp
    2881:	85 c0                	test   %eax,%eax
    2883:	0f 85 9c 00 00 00    	jne    2925 <rmdot+0x125>
    2889:	83 ec 0c             	sub    $0xc,%esp
    288c:	68 db 49 00 00       	push   $0x49db
    2891:	e8 8d 10 00 00       	call   3923 <unlink>
    2896:	83 c4 10             	add    $0x10,%esp
    2899:	85 c0                	test   %eax,%eax
    289b:	74 75                	je     2912 <rmdot+0x112>
    289d:	83 ec 0c             	sub    $0xc,%esp
    28a0:	68 f9 49 00 00       	push   $0x49f9
    28a5:	e8 79 10 00 00       	call   3923 <unlink>
    28aa:	83 c4 10             	add    $0x10,%esp
    28ad:	85 c0                	test   %eax,%eax
    28af:	74 4e                	je     28ff <rmdot+0xff>
    28b1:	83 ec 0c             	sub    $0xc,%esp
    28b4:	68 93 49 00 00       	push   $0x4993
    28b9:	e8 65 10 00 00       	call   3923 <unlink>
    28be:	83 c4 10             	add    $0x10,%esp
    28c1:	85 c0                	test   %eax,%eax
    28c3:	75 27                	jne    28ec <rmdot+0xec>
    28c5:	83 ec 08             	sub    $0x8,%esp
    28c8:	68 2e 4a 00 00       	push   $0x4a2e
    28cd:	6a 01                	push   $0x1
    28cf:	e8 8c 11 00 00       	call   3a60 <printf>
    28d4:	83 c4 10             	add    $0x10,%esp
    28d7:	c9                   	leave  
    28d8:	c3                   	ret    
    28d9:	50                   	push   %eax
    28da:	50                   	push   %eax
    28db:	68 98 49 00 00       	push   $0x4998
    28e0:	6a 01                	push   $0x1
    28e2:	e8 79 11 00 00       	call   3a60 <printf>
    28e7:	e8 e7 0f 00 00       	call   38d3 <exit>
    28ec:	50                   	push   %eax
    28ed:	50                   	push   %eax
    28ee:	68 19 4a 00 00       	push   $0x4a19
    28f3:	6a 01                	push   $0x1
    28f5:	e8 66 11 00 00       	call   3a60 <printf>
    28fa:	e8 d4 0f 00 00       	call   38d3 <exit>
    28ff:	52                   	push   %edx
    2900:	52                   	push   %edx
    2901:	68 01 4a 00 00       	push   $0x4a01
    2906:	6a 01                	push   $0x1
    2908:	e8 53 11 00 00       	call   3a60 <printf>
    290d:	e8 c1 0f 00 00       	call   38d3 <exit>
    2912:	51                   	push   %ecx
    2913:	51                   	push   %ecx
    2914:	68 e2 49 00 00       	push   $0x49e2
    2919:	6a 01                	push   $0x1
    291b:	e8 40 11 00 00       	call   3a60 <printf>
    2920:	e8 ae 0f 00 00       	call   38d3 <exit>
    2925:	50                   	push   %eax
    2926:	50                   	push   %eax
    2927:	68 13 3e 00 00       	push   $0x3e13
    292c:	6a 01                	push   $0x1
    292e:	e8 2d 11 00 00       	call   3a60 <printf>
    2933:	e8 9b 0f 00 00       	call   38d3 <exit>
    2938:	50                   	push   %eax
    2939:	50                   	push   %eax
    293a:	68 cc 49 00 00       	push   $0x49cc
    293f:	6a 01                	push   $0x1
    2941:	e8 1a 11 00 00       	call   3a60 <printf>
    2946:	e8 88 0f 00 00       	call   38d3 <exit>
    294b:	50                   	push   %eax
    294c:	50                   	push   %eax
    294d:	68 be 49 00 00       	push   $0x49be
    2952:	6a 01                	push   $0x1
    2954:	e8 07 11 00 00       	call   3a60 <printf>
    2959:	e8 75 0f 00 00       	call   38d3 <exit>
    295e:	50                   	push   %eax
    295f:	50                   	push   %eax
    2960:	68 ab 49 00 00       	push   $0x49ab
    2965:	6a 01                	push   $0x1
    2967:	e8 f4 10 00 00       	call   3a60 <printf>
    296c:	e8 62 0f 00 00       	call   38d3 <exit>
    2971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    297f:	90                   	nop

00002980 <dirfile>:
    2980:	55                   	push   %ebp
    2981:	89 e5                	mov    %esp,%ebp
    2983:	53                   	push   %ebx
    2984:	83 ec 0c             	sub    $0xc,%esp
    2987:	68 38 4a 00 00       	push   $0x4a38
    298c:	6a 01                	push   $0x1
    298e:	e8 cd 10 00 00       	call   3a60 <printf>
    2993:	5b                   	pop    %ebx
    2994:	58                   	pop    %eax
    2995:	68 00 02 00 00       	push   $0x200
    299a:	68 45 4a 00 00       	push   $0x4a45
    299f:	e8 6f 0f 00 00       	call   3913 <open>
    29a4:	83 c4 10             	add    $0x10,%esp
    29a7:	85 c0                	test   %eax,%eax
    29a9:	0f 88 43 01 00 00    	js     2af2 <dirfile+0x172>
    29af:	83 ec 0c             	sub    $0xc,%esp
    29b2:	50                   	push   %eax
    29b3:	e8 43 0f 00 00       	call   38fb <close>
    29b8:	c7 04 24 45 4a 00 00 	movl   $0x4a45,(%esp)
    29bf:	e8 7f 0f 00 00       	call   3943 <chdir>
    29c4:	83 c4 10             	add    $0x10,%esp
    29c7:	85 c0                	test   %eax,%eax
    29c9:	0f 84 10 01 00 00    	je     2adf <dirfile+0x15f>
    29cf:	83 ec 08             	sub    $0x8,%esp
    29d2:	6a 00                	push   $0x0
    29d4:	68 7e 4a 00 00       	push   $0x4a7e
    29d9:	e8 35 0f 00 00       	call   3913 <open>
    29de:	83 c4 10             	add    $0x10,%esp
    29e1:	85 c0                	test   %eax,%eax
    29e3:	0f 89 e3 00 00 00    	jns    2acc <dirfile+0x14c>
    29e9:	83 ec 08             	sub    $0x8,%esp
    29ec:	68 00 02 00 00       	push   $0x200
    29f1:	68 7e 4a 00 00       	push   $0x4a7e
    29f6:	e8 18 0f 00 00       	call   3913 <open>
    29fb:	83 c4 10             	add    $0x10,%esp
    29fe:	85 c0                	test   %eax,%eax
    2a00:	0f 89 c6 00 00 00    	jns    2acc <dirfile+0x14c>
    2a06:	83 ec 0c             	sub    $0xc,%esp
    2a09:	68 7e 4a 00 00       	push   $0x4a7e
    2a0e:	e8 28 0f 00 00       	call   393b <mkdir>
    2a13:	83 c4 10             	add    $0x10,%esp
    2a16:	85 c0                	test   %eax,%eax
    2a18:	0f 84 46 01 00 00    	je     2b64 <dirfile+0x1e4>
    2a1e:	83 ec 0c             	sub    $0xc,%esp
    2a21:	68 7e 4a 00 00       	push   $0x4a7e
    2a26:	e8 f8 0e 00 00       	call   3923 <unlink>
    2a2b:	83 c4 10             	add    $0x10,%esp
    2a2e:	85 c0                	test   %eax,%eax
    2a30:	0f 84 1b 01 00 00    	je     2b51 <dirfile+0x1d1>
    2a36:	83 ec 08             	sub    $0x8,%esp
    2a39:	68 7e 4a 00 00       	push   $0x4a7e
    2a3e:	68 e2 4a 00 00       	push   $0x4ae2
    2a43:	e8 eb 0e 00 00       	call   3933 <link>
    2a48:	83 c4 10             	add    $0x10,%esp
    2a4b:	85 c0                	test   %eax,%eax
    2a4d:	0f 84 eb 00 00 00    	je     2b3e <dirfile+0x1be>
    2a53:	83 ec 0c             	sub    $0xc,%esp
    2a56:	68 45 4a 00 00       	push   $0x4a45
    2a5b:	e8 c3 0e 00 00       	call   3923 <unlink>
    2a60:	83 c4 10             	add    $0x10,%esp
    2a63:	85 c0                	test   %eax,%eax
    2a65:	0f 85 c0 00 00 00    	jne    2b2b <dirfile+0x1ab>
    2a6b:	83 ec 08             	sub    $0x8,%esp
    2a6e:	6a 02                	push   $0x2
    2a70:	68 3e 46 00 00       	push   $0x463e
    2a75:	e8 99 0e 00 00       	call   3913 <open>
    2a7a:	83 c4 10             	add    $0x10,%esp
    2a7d:	85 c0                	test   %eax,%eax
    2a7f:	0f 89 93 00 00 00    	jns    2b18 <dirfile+0x198>
    2a85:	83 ec 08             	sub    $0x8,%esp
    2a88:	6a 00                	push   $0x0
    2a8a:	68 3e 46 00 00       	push   $0x463e
    2a8f:	e8 7f 0e 00 00       	call   3913 <open>
    2a94:	83 c4 0c             	add    $0xc,%esp
    2a97:	6a 01                	push   $0x1
    2a99:	89 c3                	mov    %eax,%ebx
    2a9b:	68 21 47 00 00       	push   $0x4721
    2aa0:	50                   	push   %eax
    2aa1:	e8 4d 0e 00 00       	call   38f3 <write>
    2aa6:	83 c4 10             	add    $0x10,%esp
    2aa9:	85 c0                	test   %eax,%eax
    2aab:	7f 58                	jg     2b05 <dirfile+0x185>
    2aad:	83 ec 0c             	sub    $0xc,%esp
    2ab0:	53                   	push   %ebx
    2ab1:	e8 45 0e 00 00       	call   38fb <close>
    2ab6:	58                   	pop    %eax
    2ab7:	5a                   	pop    %edx
    2ab8:	68 15 4b 00 00       	push   $0x4b15
    2abd:	6a 01                	push   $0x1
    2abf:	e8 9c 0f 00 00       	call   3a60 <printf>
    2ac4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2ac7:	83 c4 10             	add    $0x10,%esp
    2aca:	c9                   	leave  
    2acb:	c3                   	ret    
    2acc:	50                   	push   %eax
    2acd:	50                   	push   %eax
    2ace:	68 89 4a 00 00       	push   $0x4a89
    2ad3:	6a 01                	push   $0x1
    2ad5:	e8 86 0f 00 00       	call   3a60 <printf>
    2ada:	e8 f4 0d 00 00       	call   38d3 <exit>
    2adf:	52                   	push   %edx
    2ae0:	52                   	push   %edx
    2ae1:	68 64 4a 00 00       	push   $0x4a64
    2ae6:	6a 01                	push   $0x1
    2ae8:	e8 73 0f 00 00       	call   3a60 <printf>
    2aed:	e8 e1 0d 00 00       	call   38d3 <exit>
    2af2:	51                   	push   %ecx
    2af3:	51                   	push   %ecx
    2af4:	68 4d 4a 00 00       	push   $0x4a4d
    2af9:	6a 01                	push   $0x1
    2afb:	e8 60 0f 00 00       	call   3a60 <printf>
    2b00:	e8 ce 0d 00 00       	call   38d3 <exit>
    2b05:	51                   	push   %ecx
    2b06:	51                   	push   %ecx
    2b07:	68 01 4b 00 00       	push   $0x4b01
    2b0c:	6a 01                	push   $0x1
    2b0e:	e8 4d 0f 00 00       	call   3a60 <printf>
    2b13:	e8 bb 0d 00 00       	call   38d3 <exit>
    2b18:	53                   	push   %ebx
    2b19:	53                   	push   %ebx
    2b1a:	68 f8 52 00 00       	push   $0x52f8
    2b1f:	6a 01                	push   $0x1
    2b21:	e8 3a 0f 00 00       	call   3a60 <printf>
    2b26:	e8 a8 0d 00 00       	call   38d3 <exit>
    2b2b:	50                   	push   %eax
    2b2c:	50                   	push   %eax
    2b2d:	68 e9 4a 00 00       	push   $0x4ae9
    2b32:	6a 01                	push   $0x1
    2b34:	e8 27 0f 00 00       	call   3a60 <printf>
    2b39:	e8 95 0d 00 00       	call   38d3 <exit>
    2b3e:	50                   	push   %eax
    2b3f:	50                   	push   %eax
    2b40:	68 d8 52 00 00       	push   $0x52d8
    2b45:	6a 01                	push   $0x1
    2b47:	e8 14 0f 00 00       	call   3a60 <printf>
    2b4c:	e8 82 0d 00 00       	call   38d3 <exit>
    2b51:	50                   	push   %eax
    2b52:	50                   	push   %eax
    2b53:	68 c4 4a 00 00       	push   $0x4ac4
    2b58:	6a 01                	push   $0x1
    2b5a:	e8 01 0f 00 00       	call   3a60 <printf>
    2b5f:	e8 6f 0d 00 00       	call   38d3 <exit>
    2b64:	50                   	push   %eax
    2b65:	50                   	push   %eax
    2b66:	68 a7 4a 00 00       	push   $0x4aa7
    2b6b:	6a 01                	push   $0x1
    2b6d:	e8 ee 0e 00 00       	call   3a60 <printf>
    2b72:	e8 5c 0d 00 00       	call   38d3 <exit>
    2b77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2b7e:	66 90                	xchg   %ax,%ax

00002b80 <iref>:
    2b80:	55                   	push   %ebp
    2b81:	89 e5                	mov    %esp,%ebp
    2b83:	53                   	push   %ebx
    2b84:	bb 33 00 00 00       	mov    $0x33,%ebx
    2b89:	83 ec 0c             	sub    $0xc,%esp
    2b8c:	68 25 4b 00 00       	push   $0x4b25
    2b91:	6a 01                	push   $0x1
    2b93:	e8 c8 0e 00 00       	call   3a60 <printf>
    2b98:	83 c4 10             	add    $0x10,%esp
    2b9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2b9f:	90                   	nop
    2ba0:	83 ec 0c             	sub    $0xc,%esp
    2ba3:	68 36 4b 00 00       	push   $0x4b36
    2ba8:	e8 8e 0d 00 00       	call   393b <mkdir>
    2bad:	83 c4 10             	add    $0x10,%esp
    2bb0:	85 c0                	test   %eax,%eax
    2bb2:	0f 85 bb 00 00 00    	jne    2c73 <iref+0xf3>
    2bb8:	83 ec 0c             	sub    $0xc,%esp
    2bbb:	68 36 4b 00 00       	push   $0x4b36
    2bc0:	e8 7e 0d 00 00       	call   3943 <chdir>
    2bc5:	83 c4 10             	add    $0x10,%esp
    2bc8:	85 c0                	test   %eax,%eax
    2bca:	0f 85 b7 00 00 00    	jne    2c87 <iref+0x107>
    2bd0:	83 ec 0c             	sub    $0xc,%esp
    2bd3:	68 eb 41 00 00       	push   $0x41eb
    2bd8:	e8 5e 0d 00 00       	call   393b <mkdir>
    2bdd:	59                   	pop    %ecx
    2bde:	58                   	pop    %eax
    2bdf:	68 eb 41 00 00       	push   $0x41eb
    2be4:	68 e2 4a 00 00       	push   $0x4ae2
    2be9:	e8 45 0d 00 00       	call   3933 <link>
    2bee:	58                   	pop    %eax
    2bef:	5a                   	pop    %edx
    2bf0:	68 00 02 00 00       	push   $0x200
    2bf5:	68 eb 41 00 00       	push   $0x41eb
    2bfa:	e8 14 0d 00 00       	call   3913 <open>
    2bff:	83 c4 10             	add    $0x10,%esp
    2c02:	85 c0                	test   %eax,%eax
    2c04:	78 0c                	js     2c12 <iref+0x92>
    2c06:	83 ec 0c             	sub    $0xc,%esp
    2c09:	50                   	push   %eax
    2c0a:	e8 ec 0c 00 00       	call   38fb <close>
    2c0f:	83 c4 10             	add    $0x10,%esp
    2c12:	83 ec 08             	sub    $0x8,%esp
    2c15:	68 00 02 00 00       	push   $0x200
    2c1a:	68 20 47 00 00       	push   $0x4720
    2c1f:	e8 ef 0c 00 00       	call   3913 <open>
    2c24:	83 c4 10             	add    $0x10,%esp
    2c27:	85 c0                	test   %eax,%eax
    2c29:	78 0c                	js     2c37 <iref+0xb7>
    2c2b:	83 ec 0c             	sub    $0xc,%esp
    2c2e:	50                   	push   %eax
    2c2f:	e8 c7 0c 00 00       	call   38fb <close>
    2c34:	83 c4 10             	add    $0x10,%esp
    2c37:	83 ec 0c             	sub    $0xc,%esp
    2c3a:	68 20 47 00 00       	push   $0x4720
    2c3f:	e8 df 0c 00 00       	call   3923 <unlink>
    2c44:	83 c4 10             	add    $0x10,%esp
    2c47:	83 eb 01             	sub    $0x1,%ebx
    2c4a:	0f 85 50 ff ff ff    	jne    2ba0 <iref+0x20>
    2c50:	83 ec 0c             	sub    $0xc,%esp
    2c53:	68 11 3e 00 00       	push   $0x3e11
    2c58:	e8 e6 0c 00 00       	call   3943 <chdir>
    2c5d:	58                   	pop    %eax
    2c5e:	5a                   	pop    %edx
    2c5f:	68 64 4b 00 00       	push   $0x4b64
    2c64:	6a 01                	push   $0x1
    2c66:	e8 f5 0d 00 00       	call   3a60 <printf>
    2c6b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c6e:	83 c4 10             	add    $0x10,%esp
    2c71:	c9                   	leave  
    2c72:	c3                   	ret    
    2c73:	83 ec 08             	sub    $0x8,%esp
    2c76:	68 3c 4b 00 00       	push   $0x4b3c
    2c7b:	6a 01                	push   $0x1
    2c7d:	e8 de 0d 00 00       	call   3a60 <printf>
    2c82:	e8 4c 0c 00 00       	call   38d3 <exit>
    2c87:	83 ec 08             	sub    $0x8,%esp
    2c8a:	68 50 4b 00 00       	push   $0x4b50
    2c8f:	6a 01                	push   $0x1
    2c91:	e8 ca 0d 00 00       	call   3a60 <printf>
    2c96:	e8 38 0c 00 00       	call   38d3 <exit>
    2c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2c9f:	90                   	nop

00002ca0 <forktest>:
    2ca0:	55                   	push   %ebp
    2ca1:	89 e5                	mov    %esp,%ebp
    2ca3:	53                   	push   %ebx
    2ca4:	31 db                	xor    %ebx,%ebx
    2ca6:	83 ec 0c             	sub    $0xc,%esp
    2ca9:	68 78 4b 00 00       	push   $0x4b78
    2cae:	6a 01                	push   $0x1
    2cb0:	e8 ab 0d 00 00       	call   3a60 <printf>
    2cb5:	83 c4 10             	add    $0x10,%esp
    2cb8:	eb 13                	jmp    2ccd <forktest+0x2d>
    2cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2cc0:	74 4a                	je     2d0c <forktest+0x6c>
    2cc2:	83 c3 01             	add    $0x1,%ebx
    2cc5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2ccb:	74 6b                	je     2d38 <forktest+0x98>
    2ccd:	e8 f9 0b 00 00       	call   38cb <fork>
    2cd2:	85 c0                	test   %eax,%eax
    2cd4:	79 ea                	jns    2cc0 <forktest+0x20>
    2cd6:	85 db                	test   %ebx,%ebx
    2cd8:	74 14                	je     2cee <forktest+0x4e>
    2cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2ce0:	e8 f6 0b 00 00       	call   38db <wait>
    2ce5:	85 c0                	test   %eax,%eax
    2ce7:	78 28                	js     2d11 <forktest+0x71>
    2ce9:	83 eb 01             	sub    $0x1,%ebx
    2cec:	75 f2                	jne    2ce0 <forktest+0x40>
    2cee:	e8 e8 0b 00 00       	call   38db <wait>
    2cf3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2cf6:	75 2d                	jne    2d25 <forktest+0x85>
    2cf8:	83 ec 08             	sub    $0x8,%esp
    2cfb:	68 aa 4b 00 00       	push   $0x4baa
    2d00:	6a 01                	push   $0x1
    2d02:	e8 59 0d 00 00       	call   3a60 <printf>
    2d07:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2d0a:	c9                   	leave  
    2d0b:	c3                   	ret    
    2d0c:	e8 c2 0b 00 00       	call   38d3 <exit>
    2d11:	83 ec 08             	sub    $0x8,%esp
    2d14:	68 83 4b 00 00       	push   $0x4b83
    2d19:	6a 01                	push   $0x1
    2d1b:	e8 40 0d 00 00       	call   3a60 <printf>
    2d20:	e8 ae 0b 00 00       	call   38d3 <exit>
    2d25:	52                   	push   %edx
    2d26:	52                   	push   %edx
    2d27:	68 97 4b 00 00       	push   $0x4b97
    2d2c:	6a 01                	push   $0x1
    2d2e:	e8 2d 0d 00 00       	call   3a60 <printf>
    2d33:	e8 9b 0b 00 00       	call   38d3 <exit>
    2d38:	50                   	push   %eax
    2d39:	50                   	push   %eax
    2d3a:	68 18 53 00 00       	push   $0x5318
    2d3f:	6a 01                	push   $0x1
    2d41:	e8 1a 0d 00 00       	call   3a60 <printf>
    2d46:	e8 88 0b 00 00       	call   38d3 <exit>
    2d4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2d4f:	90                   	nop

00002d50 <sbrktest>:
    2d50:	55                   	push   %ebp
    2d51:	89 e5                	mov    %esp,%ebp
    2d53:	57                   	push   %edi
    2d54:	31 ff                	xor    %edi,%edi
    2d56:	56                   	push   %esi
    2d57:	53                   	push   %ebx
    2d58:	83 ec 54             	sub    $0x54,%esp
    2d5b:	68 b8 4b 00 00       	push   $0x4bb8
    2d60:	ff 35 60 5e 00 00    	pushl  0x5e60
    2d66:	e8 f5 0c 00 00       	call   3a60 <printf>
    2d6b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d72:	e8 e4 0b 00 00       	call   395b <sbrk>
    2d77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d7e:	89 c3                	mov    %eax,%ebx
    2d80:	e8 d6 0b 00 00       	call   395b <sbrk>
    2d85:	83 c4 10             	add    $0x10,%esp
    2d88:	89 c6                	mov    %eax,%esi
    2d8a:	eb 06                	jmp    2d92 <sbrktest+0x42>
    2d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2d90:	89 c6                	mov    %eax,%esi
    2d92:	83 ec 0c             	sub    $0xc,%esp
    2d95:	6a 01                	push   $0x1
    2d97:	e8 bf 0b 00 00       	call   395b <sbrk>
    2d9c:	83 c4 10             	add    $0x10,%esp
    2d9f:	39 f0                	cmp    %esi,%eax
    2da1:	0f 85 84 02 00 00    	jne    302b <sbrktest+0x2db>
    2da7:	83 c7 01             	add    $0x1,%edi
    2daa:	c6 06 01             	movb   $0x1,(%esi)
    2dad:	8d 46 01             	lea    0x1(%esi),%eax
    2db0:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    2db6:	75 d8                	jne    2d90 <sbrktest+0x40>
    2db8:	e8 0e 0b 00 00       	call   38cb <fork>
    2dbd:	89 c7                	mov    %eax,%edi
    2dbf:	85 c0                	test   %eax,%eax
    2dc1:	0f 88 91 03 00 00    	js     3158 <sbrktest+0x408>
    2dc7:	83 ec 0c             	sub    $0xc,%esp
    2dca:	83 c6 02             	add    $0x2,%esi
    2dcd:	6a 01                	push   $0x1
    2dcf:	e8 87 0b 00 00       	call   395b <sbrk>
    2dd4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ddb:	e8 7b 0b 00 00       	call   395b <sbrk>
    2de0:	83 c4 10             	add    $0x10,%esp
    2de3:	39 c6                	cmp    %eax,%esi
    2de5:	0f 85 56 03 00 00    	jne    3141 <sbrktest+0x3f1>
    2deb:	85 ff                	test   %edi,%edi
    2ded:	0f 84 49 03 00 00    	je     313c <sbrktest+0x3ec>
    2df3:	e8 e3 0a 00 00       	call   38db <wait>
    2df8:	83 ec 0c             	sub    $0xc,%esp
    2dfb:	6a 00                	push   $0x0
    2dfd:	e8 59 0b 00 00       	call   395b <sbrk>
    2e02:	89 c6                	mov    %eax,%esi
    2e04:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2e09:	29 f0                	sub    %esi,%eax
    2e0b:	89 04 24             	mov    %eax,(%esp)
    2e0e:	e8 48 0b 00 00       	call   395b <sbrk>
    2e13:	83 c4 10             	add    $0x10,%esp
    2e16:	39 c6                	cmp    %eax,%esi
    2e18:	0f 85 07 03 00 00    	jne    3125 <sbrktest+0x3d5>
    2e1e:	83 ec 0c             	sub    $0xc,%esp
    2e21:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
    2e28:	6a 00                	push   $0x0
    2e2a:	e8 2c 0b 00 00       	call   395b <sbrk>
    2e2f:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2e36:	89 c6                	mov    %eax,%esi
    2e38:	e8 1e 0b 00 00       	call   395b <sbrk>
    2e3d:	83 c4 10             	add    $0x10,%esp
    2e40:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e43:	0f 84 c5 02 00 00    	je     310e <sbrktest+0x3be>
    2e49:	83 ec 0c             	sub    $0xc,%esp
    2e4c:	6a 00                	push   $0x0
    2e4e:	e8 08 0b 00 00       	call   395b <sbrk>
    2e53:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    2e59:	83 c4 10             	add    $0x10,%esp
    2e5c:	39 d0                	cmp    %edx,%eax
    2e5e:	0f 85 93 02 00 00    	jne    30f7 <sbrktest+0x3a7>
    2e64:	83 ec 0c             	sub    $0xc,%esp
    2e67:	6a 00                	push   $0x0
    2e69:	e8 ed 0a 00 00       	call   395b <sbrk>
    2e6e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2e75:	89 c6                	mov    %eax,%esi
    2e77:	e8 df 0a 00 00       	call   395b <sbrk>
    2e7c:	83 c4 10             	add    $0x10,%esp
    2e7f:	89 c7                	mov    %eax,%edi
    2e81:	39 c6                	cmp    %eax,%esi
    2e83:	0f 85 57 02 00 00    	jne    30e0 <sbrktest+0x390>
    2e89:	83 ec 0c             	sub    $0xc,%esp
    2e8c:	6a 00                	push   $0x0
    2e8e:	e8 c8 0a 00 00       	call   395b <sbrk>
    2e93:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    2e99:	83 c4 10             	add    $0x10,%esp
    2e9c:	39 c2                	cmp    %eax,%edx
    2e9e:	0f 85 3c 02 00 00    	jne    30e0 <sbrktest+0x390>
    2ea4:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2eab:	0f 84 18 02 00 00    	je     30c9 <sbrktest+0x379>
    2eb1:	83 ec 0c             	sub    $0xc,%esp
    2eb4:	6a 00                	push   $0x0
    2eb6:	e8 a0 0a 00 00       	call   395b <sbrk>
    2ebb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ec2:	89 c6                	mov    %eax,%esi
    2ec4:	e8 92 0a 00 00       	call   395b <sbrk>
    2ec9:	89 d9                	mov    %ebx,%ecx
    2ecb:	29 c1                	sub    %eax,%ecx
    2ecd:	89 0c 24             	mov    %ecx,(%esp)
    2ed0:	e8 86 0a 00 00       	call   395b <sbrk>
    2ed5:	83 c4 10             	add    $0x10,%esp
    2ed8:	39 c6                	cmp    %eax,%esi
    2eda:	0f 85 d2 01 00 00    	jne    30b2 <sbrktest+0x362>
    2ee0:	be 00 00 00 80       	mov    $0x80000000,%esi
    2ee5:	8d 76 00             	lea    0x0(%esi),%esi
    2ee8:	e8 66 0a 00 00       	call   3953 <getpid>
    2eed:	89 c7                	mov    %eax,%edi
    2eef:	e8 d7 09 00 00       	call   38cb <fork>
    2ef4:	85 c0                	test   %eax,%eax
    2ef6:	0f 88 9e 01 00 00    	js     309a <sbrktest+0x34a>
    2efc:	0f 84 76 01 00 00    	je     3078 <sbrktest+0x328>
    2f02:	e8 d4 09 00 00       	call   38db <wait>
    2f07:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    2f0d:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    2f13:	75 d3                	jne    2ee8 <sbrktest+0x198>
    2f15:	83 ec 0c             	sub    $0xc,%esp
    2f18:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2f1b:	50                   	push   %eax
    2f1c:	e8 c2 09 00 00       	call   38e3 <pipe>
    2f21:	83 c4 10             	add    $0x10,%esp
    2f24:	85 c0                	test   %eax,%eax
    2f26:	0f 85 34 01 00 00    	jne    3060 <sbrktest+0x310>
    2f2c:	8d 75 c0             	lea    -0x40(%ebp),%esi
    2f2f:	89 f7                	mov    %esi,%edi
    2f31:	e8 95 09 00 00       	call   38cb <fork>
    2f36:	89 07                	mov    %eax,(%edi)
    2f38:	85 c0                	test   %eax,%eax
    2f3a:	0f 84 8f 00 00 00    	je     2fcf <sbrktest+0x27f>
    2f40:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f43:	74 14                	je     2f59 <sbrktest+0x209>
    2f45:	83 ec 04             	sub    $0x4,%esp
    2f48:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2f4b:	6a 01                	push   $0x1
    2f4d:	50                   	push   %eax
    2f4e:	ff 75 b8             	pushl  -0x48(%ebp)
    2f51:	e8 95 09 00 00       	call   38eb <read>
    2f56:	83 c4 10             	add    $0x10,%esp
    2f59:	83 c7 04             	add    $0x4,%edi
    2f5c:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2f5f:	39 c7                	cmp    %eax,%edi
    2f61:	75 ce                	jne    2f31 <sbrktest+0x1e1>
    2f63:	83 ec 0c             	sub    $0xc,%esp
    2f66:	68 00 10 00 00       	push   $0x1000
    2f6b:	e8 eb 09 00 00       	call   395b <sbrk>
    2f70:	83 c4 10             	add    $0x10,%esp
    2f73:	89 c7                	mov    %eax,%edi
    2f75:	8b 06                	mov    (%esi),%eax
    2f77:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f7a:	74 11                	je     2f8d <sbrktest+0x23d>
    2f7c:	83 ec 0c             	sub    $0xc,%esp
    2f7f:	50                   	push   %eax
    2f80:	e8 7e 09 00 00       	call   3903 <kill>
    2f85:	e8 51 09 00 00       	call   38db <wait>
    2f8a:	83 c4 10             	add    $0x10,%esp
    2f8d:	83 c6 04             	add    $0x4,%esi
    2f90:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2f93:	39 f0                	cmp    %esi,%eax
    2f95:	75 de                	jne    2f75 <sbrktest+0x225>
    2f97:	83 ff ff             	cmp    $0xffffffff,%edi
    2f9a:	0f 84 a9 00 00 00    	je     3049 <sbrktest+0x2f9>
    2fa0:	83 ec 0c             	sub    $0xc,%esp
    2fa3:	6a 00                	push   $0x0
    2fa5:	e8 b1 09 00 00       	call   395b <sbrk>
    2faa:	83 c4 10             	add    $0x10,%esp
    2fad:	39 c3                	cmp    %eax,%ebx
    2faf:	72 61                	jb     3012 <sbrktest+0x2c2>
    2fb1:	83 ec 08             	sub    $0x8,%esp
    2fb4:	68 60 4c 00 00       	push   $0x4c60
    2fb9:	ff 35 60 5e 00 00    	pushl  0x5e60
    2fbf:	e8 9c 0a 00 00       	call   3a60 <printf>
    2fc4:	83 c4 10             	add    $0x10,%esp
    2fc7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2fca:	5b                   	pop    %ebx
    2fcb:	5e                   	pop    %esi
    2fcc:	5f                   	pop    %edi
    2fcd:	5d                   	pop    %ebp
    2fce:	c3                   	ret    
    2fcf:	83 ec 0c             	sub    $0xc,%esp
    2fd2:	6a 00                	push   $0x0
    2fd4:	e8 82 09 00 00       	call   395b <sbrk>
    2fd9:	89 c2                	mov    %eax,%edx
    2fdb:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2fe0:	29 d0                	sub    %edx,%eax
    2fe2:	89 04 24             	mov    %eax,(%esp)
    2fe5:	e8 71 09 00 00       	call   395b <sbrk>
    2fea:	83 c4 0c             	add    $0xc,%esp
    2fed:	6a 01                	push   $0x1
    2fef:	68 21 47 00 00       	push   $0x4721
    2ff4:	ff 75 bc             	pushl  -0x44(%ebp)
    2ff7:	e8 f7 08 00 00       	call   38f3 <write>
    2ffc:	83 c4 10             	add    $0x10,%esp
    2fff:	90                   	nop
    3000:	83 ec 0c             	sub    $0xc,%esp
    3003:	68 e8 03 00 00       	push   $0x3e8
    3008:	e8 56 09 00 00       	call   3963 <sleep>
    300d:	83 c4 10             	add    $0x10,%esp
    3010:	eb ee                	jmp    3000 <sbrktest+0x2b0>
    3012:	83 ec 0c             	sub    $0xc,%esp
    3015:	6a 00                	push   $0x0
    3017:	e8 3f 09 00 00       	call   395b <sbrk>
    301c:	29 c3                	sub    %eax,%ebx
    301e:	89 1c 24             	mov    %ebx,(%esp)
    3021:	e8 35 09 00 00       	call   395b <sbrk>
    3026:	83 c4 10             	add    $0x10,%esp
    3029:	eb 86                	jmp    2fb1 <sbrktest+0x261>
    302b:	83 ec 0c             	sub    $0xc,%esp
    302e:	50                   	push   %eax
    302f:	56                   	push   %esi
    3030:	57                   	push   %edi
    3031:	68 c3 4b 00 00       	push   $0x4bc3
    3036:	ff 35 60 5e 00 00    	pushl  0x5e60
    303c:	e8 1f 0a 00 00       	call   3a60 <printf>
    3041:	83 c4 20             	add    $0x20,%esp
    3044:	e8 8a 08 00 00       	call   38d3 <exit>
    3049:	50                   	push   %eax
    304a:	50                   	push   %eax
    304b:	68 45 4c 00 00       	push   $0x4c45
    3050:	ff 35 60 5e 00 00    	pushl  0x5e60
    3056:	e8 05 0a 00 00       	call   3a60 <printf>
    305b:	e8 73 08 00 00       	call   38d3 <exit>
    3060:	52                   	push   %edx
    3061:	52                   	push   %edx
    3062:	68 01 41 00 00       	push   $0x4101
    3067:	6a 01                	push   $0x1
    3069:	e8 f2 09 00 00       	call   3a60 <printf>
    306e:	e8 60 08 00 00       	call   38d3 <exit>
    3073:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3077:	90                   	nop
    3078:	0f be 06             	movsbl (%esi),%eax
    307b:	50                   	push   %eax
    307c:	56                   	push   %esi
    307d:	68 2c 4c 00 00       	push   $0x4c2c
    3082:	ff 35 60 5e 00 00    	pushl  0x5e60
    3088:	e8 d3 09 00 00       	call   3a60 <printf>
    308d:	89 3c 24             	mov    %edi,(%esp)
    3090:	e8 6e 08 00 00       	call   3903 <kill>
    3095:	e8 39 08 00 00       	call   38d3 <exit>
    309a:	83 ec 08             	sub    $0x8,%esp
    309d:	68 09 4d 00 00       	push   $0x4d09
    30a2:	ff 35 60 5e 00 00    	pushl  0x5e60
    30a8:	e8 b3 09 00 00       	call   3a60 <printf>
    30ad:	e8 21 08 00 00       	call   38d3 <exit>
    30b2:	50                   	push   %eax
    30b3:	56                   	push   %esi
    30b4:	68 0c 54 00 00       	push   $0x540c
    30b9:	ff 35 60 5e 00 00    	pushl  0x5e60
    30bf:	e8 9c 09 00 00       	call   3a60 <printf>
    30c4:	e8 0a 08 00 00       	call   38d3 <exit>
    30c9:	51                   	push   %ecx
    30ca:	51                   	push   %ecx
    30cb:	68 dc 53 00 00       	push   $0x53dc
    30d0:	ff 35 60 5e 00 00    	pushl  0x5e60
    30d6:	e8 85 09 00 00       	call   3a60 <printf>
    30db:	e8 f3 07 00 00       	call   38d3 <exit>
    30e0:	57                   	push   %edi
    30e1:	56                   	push   %esi
    30e2:	68 b4 53 00 00       	push   $0x53b4
    30e7:	ff 35 60 5e 00 00    	pushl  0x5e60
    30ed:	e8 6e 09 00 00       	call   3a60 <printf>
    30f2:	e8 dc 07 00 00       	call   38d3 <exit>
    30f7:	50                   	push   %eax
    30f8:	56                   	push   %esi
    30f9:	68 7c 53 00 00       	push   $0x537c
    30fe:	ff 35 60 5e 00 00    	pushl  0x5e60
    3104:	e8 57 09 00 00       	call   3a60 <printf>
    3109:	e8 c5 07 00 00       	call   38d3 <exit>
    310e:	53                   	push   %ebx
    310f:	53                   	push   %ebx
    3110:	68 11 4c 00 00       	push   $0x4c11
    3115:	ff 35 60 5e 00 00    	pushl  0x5e60
    311b:	e8 40 09 00 00       	call   3a60 <printf>
    3120:	e8 ae 07 00 00       	call   38d3 <exit>
    3125:	56                   	push   %esi
    3126:	56                   	push   %esi
    3127:	68 3c 53 00 00       	push   $0x533c
    312c:	ff 35 60 5e 00 00    	pushl  0x5e60
    3132:	e8 29 09 00 00       	call   3a60 <printf>
    3137:	e8 97 07 00 00       	call   38d3 <exit>
    313c:	e8 92 07 00 00       	call   38d3 <exit>
    3141:	57                   	push   %edi
    3142:	57                   	push   %edi
    3143:	68 f5 4b 00 00       	push   $0x4bf5
    3148:	ff 35 60 5e 00 00    	pushl  0x5e60
    314e:	e8 0d 09 00 00       	call   3a60 <printf>
    3153:	e8 7b 07 00 00       	call   38d3 <exit>
    3158:	50                   	push   %eax
    3159:	50                   	push   %eax
    315a:	68 de 4b 00 00       	push   $0x4bde
    315f:	ff 35 60 5e 00 00    	pushl  0x5e60
    3165:	e8 f6 08 00 00       	call   3a60 <printf>
    316a:	e8 64 07 00 00       	call   38d3 <exit>
    316f:	90                   	nop

00003170 <validateint>:
    3170:	c3                   	ret    
    3171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3178:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    317f:	90                   	nop

00003180 <validatetest>:
    3180:	55                   	push   %ebp
    3181:	89 e5                	mov    %esp,%ebp
    3183:	56                   	push   %esi
    3184:	31 f6                	xor    %esi,%esi
    3186:	53                   	push   %ebx
    3187:	83 ec 08             	sub    $0x8,%esp
    318a:	68 6e 4c 00 00       	push   $0x4c6e
    318f:	ff 35 60 5e 00 00    	pushl  0x5e60
    3195:	e8 c6 08 00 00       	call   3a60 <printf>
    319a:	83 c4 10             	add    $0x10,%esp
    319d:	8d 76 00             	lea    0x0(%esi),%esi
    31a0:	e8 26 07 00 00       	call   38cb <fork>
    31a5:	89 c3                	mov    %eax,%ebx
    31a7:	85 c0                	test   %eax,%eax
    31a9:	74 63                	je     320e <validatetest+0x8e>
    31ab:	83 ec 0c             	sub    $0xc,%esp
    31ae:	6a 00                	push   $0x0
    31b0:	e8 ae 07 00 00       	call   3963 <sleep>
    31b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31bc:	e8 a2 07 00 00       	call   3963 <sleep>
    31c1:	89 1c 24             	mov    %ebx,(%esp)
    31c4:	e8 3a 07 00 00       	call   3903 <kill>
    31c9:	e8 0d 07 00 00       	call   38db <wait>
    31ce:	58                   	pop    %eax
    31cf:	5a                   	pop    %edx
    31d0:	56                   	push   %esi
    31d1:	68 7d 4c 00 00       	push   $0x4c7d
    31d6:	e8 58 07 00 00       	call   3933 <link>
    31db:	83 c4 10             	add    $0x10,%esp
    31de:	83 f8 ff             	cmp    $0xffffffff,%eax
    31e1:	75 30                	jne    3213 <validatetest+0x93>
    31e3:	81 c6 00 10 00 00    	add    $0x1000,%esi
    31e9:	81 fe 00 40 11 00    	cmp    $0x114000,%esi
    31ef:	75 af                	jne    31a0 <validatetest+0x20>
    31f1:	83 ec 08             	sub    $0x8,%esp
    31f4:	68 a1 4c 00 00       	push   $0x4ca1
    31f9:	ff 35 60 5e 00 00    	pushl  0x5e60
    31ff:	e8 5c 08 00 00       	call   3a60 <printf>
    3204:	83 c4 10             	add    $0x10,%esp
    3207:	8d 65 f8             	lea    -0x8(%ebp),%esp
    320a:	5b                   	pop    %ebx
    320b:	5e                   	pop    %esi
    320c:	5d                   	pop    %ebp
    320d:	c3                   	ret    
    320e:	e8 c0 06 00 00       	call   38d3 <exit>
    3213:	83 ec 08             	sub    $0x8,%esp
    3216:	68 88 4c 00 00       	push   $0x4c88
    321b:	ff 35 60 5e 00 00    	pushl  0x5e60
    3221:	e8 3a 08 00 00       	call   3a60 <printf>
    3226:	e8 a8 06 00 00       	call   38d3 <exit>
    322b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    322f:	90                   	nop

00003230 <bsstest>:
    3230:	55                   	push   %ebp
    3231:	89 e5                	mov    %esp,%ebp
    3233:	83 ec 10             	sub    $0x10,%esp
    3236:	68 ae 4c 00 00       	push   $0x4cae
    323b:	ff 35 60 5e 00 00    	pushl  0x5e60
    3241:	e8 1a 08 00 00       	call   3a60 <printf>
    3246:	83 c4 10             	add    $0x10,%esp
    3249:	31 c0                	xor    %eax,%eax
    324b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    324f:	90                   	nop
    3250:	80 b8 20 5f 00 00 00 	cmpb   $0x0,0x5f20(%eax)
    3257:	75 22                	jne    327b <bsstest+0x4b>
    3259:	83 c0 01             	add    $0x1,%eax
    325c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3261:	75 ed                	jne    3250 <bsstest+0x20>
    3263:	83 ec 08             	sub    $0x8,%esp
    3266:	68 c9 4c 00 00       	push   $0x4cc9
    326b:	ff 35 60 5e 00 00    	pushl  0x5e60
    3271:	e8 ea 07 00 00       	call   3a60 <printf>
    3276:	83 c4 10             	add    $0x10,%esp
    3279:	c9                   	leave  
    327a:	c3                   	ret    
    327b:	83 ec 08             	sub    $0x8,%esp
    327e:	68 b8 4c 00 00       	push   $0x4cb8
    3283:	ff 35 60 5e 00 00    	pushl  0x5e60
    3289:	e8 d2 07 00 00       	call   3a60 <printf>
    328e:	e8 40 06 00 00       	call   38d3 <exit>
    3293:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    329a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000032a0 <bigargtest>:
    32a0:	55                   	push   %ebp
    32a1:	89 e5                	mov    %esp,%ebp
    32a3:	83 ec 14             	sub    $0x14,%esp
    32a6:	68 d6 4c 00 00       	push   $0x4cd6
    32ab:	e8 73 06 00 00       	call   3923 <unlink>
    32b0:	e8 16 06 00 00       	call   38cb <fork>
    32b5:	83 c4 10             	add    $0x10,%esp
    32b8:	85 c0                	test   %eax,%eax
    32ba:	74 44                	je     3300 <bigargtest+0x60>
    32bc:	0f 88 c5 00 00 00    	js     3387 <bigargtest+0xe7>
    32c2:	e8 14 06 00 00       	call   38db <wait>
    32c7:	83 ec 08             	sub    $0x8,%esp
    32ca:	6a 00                	push   $0x0
    32cc:	68 d6 4c 00 00       	push   $0x4cd6
    32d1:	e8 3d 06 00 00       	call   3913 <open>
    32d6:	83 c4 10             	add    $0x10,%esp
    32d9:	85 c0                	test   %eax,%eax
    32db:	0f 88 8f 00 00 00    	js     3370 <bigargtest+0xd0>
    32e1:	83 ec 0c             	sub    $0xc,%esp
    32e4:	50                   	push   %eax
    32e5:	e8 11 06 00 00       	call   38fb <close>
    32ea:	c7 04 24 d6 4c 00 00 	movl   $0x4cd6,(%esp)
    32f1:	e8 2d 06 00 00       	call   3923 <unlink>
    32f6:	83 c4 10             	add    $0x10,%esp
    32f9:	c9                   	leave  
    32fa:	c3                   	ret    
    32fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    32ff:	90                   	nop
    3300:	c7 04 85 80 5e 00 00 	movl   $0x5430,0x5e80(,%eax,4)
    3307:	30 54 00 00 
    330b:	83 c0 01             	add    $0x1,%eax
    330e:	83 f8 1f             	cmp    $0x1f,%eax
    3311:	75 ed                	jne    3300 <bigargtest+0x60>
    3313:	51                   	push   %ecx
    3314:	51                   	push   %ecx
    3315:	68 e0 4c 00 00       	push   $0x4ce0
    331a:	ff 35 60 5e 00 00    	pushl  0x5e60
    3320:	c7 05 fc 5e 00 00 00 	movl   $0x0,0x5efc
    3327:	00 00 00 
    332a:	e8 31 07 00 00       	call   3a60 <printf>
    332f:	58                   	pop    %eax
    3330:	5a                   	pop    %edx
    3331:	68 80 5e 00 00       	push   $0x5e80
    3336:	68 ad 3e 00 00       	push   $0x3ead
    333b:	e8 cb 05 00 00       	call   390b <exec>
    3340:	59                   	pop    %ecx
    3341:	58                   	pop    %eax
    3342:	68 ed 4c 00 00       	push   $0x4ced
    3347:	ff 35 60 5e 00 00    	pushl  0x5e60
    334d:	e8 0e 07 00 00       	call   3a60 <printf>
    3352:	58                   	pop    %eax
    3353:	5a                   	pop    %edx
    3354:	68 00 02 00 00       	push   $0x200
    3359:	68 d6 4c 00 00       	push   $0x4cd6
    335e:	e8 b0 05 00 00       	call   3913 <open>
    3363:	89 04 24             	mov    %eax,(%esp)
    3366:	e8 90 05 00 00       	call   38fb <close>
    336b:	e8 63 05 00 00       	call   38d3 <exit>
    3370:	50                   	push   %eax
    3371:	50                   	push   %eax
    3372:	68 16 4d 00 00       	push   $0x4d16
    3377:	ff 35 60 5e 00 00    	pushl  0x5e60
    337d:	e8 de 06 00 00       	call   3a60 <printf>
    3382:	e8 4c 05 00 00       	call   38d3 <exit>
    3387:	52                   	push   %edx
    3388:	52                   	push   %edx
    3389:	68 fd 4c 00 00       	push   $0x4cfd
    338e:	ff 35 60 5e 00 00    	pushl  0x5e60
    3394:	e8 c7 06 00 00       	call   3a60 <printf>
    3399:	e8 35 05 00 00       	call   38d3 <exit>
    339e:	66 90                	xchg   %ax,%ax

000033a0 <fsfull>:
    33a0:	55                   	push   %ebp
    33a1:	89 e5                	mov    %esp,%ebp
    33a3:	57                   	push   %edi
    33a4:	56                   	push   %esi
    33a5:	31 f6                	xor    %esi,%esi
    33a7:	53                   	push   %ebx
    33a8:	83 ec 54             	sub    $0x54,%esp
    33ab:	68 2b 4d 00 00       	push   $0x4d2b
    33b0:	6a 01                	push   $0x1
    33b2:	e8 a9 06 00 00       	call   3a60 <printf>
    33b7:	83 c4 10             	add    $0x10,%esp
    33ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    33c0:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    33c5:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    33ca:	83 ec 04             	sub    $0x4,%esp
    33cd:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    33d1:	f7 e6                	mul    %esi
    33d3:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    33d7:	c1 ea 06             	shr    $0x6,%edx
    33da:	8d 42 30             	lea    0x30(%edx),%eax
    33dd:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    33e3:	88 45 a9             	mov    %al,-0x57(%ebp)
    33e6:	89 f0                	mov    %esi,%eax
    33e8:	29 d0                	sub    %edx,%eax
    33ea:	89 c2                	mov    %eax,%edx
    33ec:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33f1:	f7 e2                	mul    %edx
    33f3:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33f8:	c1 ea 05             	shr    $0x5,%edx
    33fb:	83 c2 30             	add    $0x30,%edx
    33fe:	88 55 aa             	mov    %dl,-0x56(%ebp)
    3401:	f7 e6                	mul    %esi
    3403:	89 f0                	mov    %esi,%eax
    3405:	c1 ea 05             	shr    $0x5,%edx
    3408:	6b d2 64             	imul   $0x64,%edx,%edx
    340b:	29 d0                	sub    %edx,%eax
    340d:	f7 e1                	mul    %ecx
    340f:	89 f0                	mov    %esi,%eax
    3411:	c1 ea 03             	shr    $0x3,%edx
    3414:	83 c2 30             	add    $0x30,%edx
    3417:	88 55 ab             	mov    %dl,-0x55(%ebp)
    341a:	f7 e1                	mul    %ecx
    341c:	89 f1                	mov    %esi,%ecx
    341e:	c1 ea 03             	shr    $0x3,%edx
    3421:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3424:	01 c0                	add    %eax,%eax
    3426:	29 c1                	sub    %eax,%ecx
    3428:	89 c8                	mov    %ecx,%eax
    342a:	83 c0 30             	add    $0x30,%eax
    342d:	88 45 ac             	mov    %al,-0x54(%ebp)
    3430:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3433:	50                   	push   %eax
    3434:	68 38 4d 00 00       	push   $0x4d38
    3439:	6a 01                	push   $0x1
    343b:	e8 20 06 00 00       	call   3a60 <printf>
    3440:	58                   	pop    %eax
    3441:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3444:	5a                   	pop    %edx
    3445:	68 02 02 00 00       	push   $0x202
    344a:	50                   	push   %eax
    344b:	e8 c3 04 00 00       	call   3913 <open>
    3450:	83 c4 10             	add    $0x10,%esp
    3453:	89 c7                	mov    %eax,%edi
    3455:	85 c0                	test   %eax,%eax
    3457:	78 4d                	js     34a6 <fsfull+0x106>
    3459:	31 db                	xor    %ebx,%ebx
    345b:	eb 05                	jmp    3462 <fsfull+0xc2>
    345d:	8d 76 00             	lea    0x0(%esi),%esi
    3460:	01 c3                	add    %eax,%ebx
    3462:	83 ec 04             	sub    $0x4,%esp
    3465:	68 00 02 00 00       	push   $0x200
    346a:	68 40 86 00 00       	push   $0x8640
    346f:	57                   	push   %edi
    3470:	e8 7e 04 00 00       	call   38f3 <write>
    3475:	83 c4 10             	add    $0x10,%esp
    3478:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    347d:	7f e1                	jg     3460 <fsfull+0xc0>
    347f:	83 ec 04             	sub    $0x4,%esp
    3482:	53                   	push   %ebx
    3483:	68 54 4d 00 00       	push   $0x4d54
    3488:	6a 01                	push   $0x1
    348a:	e8 d1 05 00 00       	call   3a60 <printf>
    348f:	89 3c 24             	mov    %edi,(%esp)
    3492:	e8 64 04 00 00       	call   38fb <close>
    3497:	83 c4 10             	add    $0x10,%esp
    349a:	85 db                	test   %ebx,%ebx
    349c:	74 1e                	je     34bc <fsfull+0x11c>
    349e:	83 c6 01             	add    $0x1,%esi
    34a1:	e9 1a ff ff ff       	jmp    33c0 <fsfull+0x20>
    34a6:	83 ec 04             	sub    $0x4,%esp
    34a9:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34ac:	50                   	push   %eax
    34ad:	68 44 4d 00 00       	push   $0x4d44
    34b2:	6a 01                	push   $0x1
    34b4:	e8 a7 05 00 00       	call   3a60 <printf>
    34b9:	83 c4 10             	add    $0x10,%esp
    34bc:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    34c1:	bb 1f 85 eb 51       	mov    $0x51eb851f,%ebx
    34c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34cd:	8d 76 00             	lea    0x0(%esi),%esi
    34d0:	89 f0                	mov    %esi,%eax
    34d2:	89 f1                	mov    %esi,%ecx
    34d4:	83 ec 0c             	sub    $0xc,%esp
    34d7:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    34db:	f7 ef                	imul   %edi
    34dd:	c1 f9 1f             	sar    $0x1f,%ecx
    34e0:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    34e4:	c1 fa 06             	sar    $0x6,%edx
    34e7:	29 ca                	sub    %ecx,%edx
    34e9:	8d 42 30             	lea    0x30(%edx),%eax
    34ec:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    34f2:	88 45 a9             	mov    %al,-0x57(%ebp)
    34f5:	89 f0                	mov    %esi,%eax
    34f7:	29 d0                	sub    %edx,%eax
    34f9:	f7 e3                	mul    %ebx
    34fb:	89 f0                	mov    %esi,%eax
    34fd:	c1 ea 05             	shr    $0x5,%edx
    3500:	83 c2 30             	add    $0x30,%edx
    3503:	88 55 aa             	mov    %dl,-0x56(%ebp)
    3506:	f7 eb                	imul   %ebx
    3508:	89 f0                	mov    %esi,%eax
    350a:	c1 fa 05             	sar    $0x5,%edx
    350d:	29 ca                	sub    %ecx,%edx
    350f:	6b d2 64             	imul   $0x64,%edx,%edx
    3512:	29 d0                	sub    %edx,%eax
    3514:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    3519:	f7 e2                	mul    %edx
    351b:	89 f0                	mov    %esi,%eax
    351d:	c1 ea 03             	shr    $0x3,%edx
    3520:	83 c2 30             	add    $0x30,%edx
    3523:	88 55 ab             	mov    %dl,-0x55(%ebp)
    3526:	ba 67 66 66 66       	mov    $0x66666667,%edx
    352b:	f7 ea                	imul   %edx
    352d:	c1 fa 02             	sar    $0x2,%edx
    3530:	29 ca                	sub    %ecx,%edx
    3532:	89 f1                	mov    %esi,%ecx
    3534:	83 ee 01             	sub    $0x1,%esi
    3537:	8d 04 92             	lea    (%edx,%edx,4),%eax
    353a:	01 c0                	add    %eax,%eax
    353c:	29 c1                	sub    %eax,%ecx
    353e:	89 c8                	mov    %ecx,%eax
    3540:	83 c0 30             	add    $0x30,%eax
    3543:	88 45 ac             	mov    %al,-0x54(%ebp)
    3546:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3549:	50                   	push   %eax
    354a:	e8 d4 03 00 00       	call   3923 <unlink>
    354f:	83 c4 10             	add    $0x10,%esp
    3552:	83 fe ff             	cmp    $0xffffffff,%esi
    3555:	0f 85 75 ff ff ff    	jne    34d0 <fsfull+0x130>
    355b:	83 ec 08             	sub    $0x8,%esp
    355e:	68 64 4d 00 00       	push   $0x4d64
    3563:	6a 01                	push   $0x1
    3565:	e8 f6 04 00 00       	call   3a60 <printf>
    356a:	83 c4 10             	add    $0x10,%esp
    356d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3570:	5b                   	pop    %ebx
    3571:	5e                   	pop    %esi
    3572:	5f                   	pop    %edi
    3573:	5d                   	pop    %ebp
    3574:	c3                   	ret    
    3575:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    357c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003580 <uio>:
    3580:	55                   	push   %ebp
    3581:	89 e5                	mov    %esp,%ebp
    3583:	83 ec 10             	sub    $0x10,%esp
    3586:	68 7a 4d 00 00       	push   $0x4d7a
    358b:	6a 01                	push   $0x1
    358d:	e8 ce 04 00 00       	call   3a60 <printf>
    3592:	e8 34 03 00 00       	call   38cb <fork>
    3597:	83 c4 10             	add    $0x10,%esp
    359a:	85 c0                	test   %eax,%eax
    359c:	74 1b                	je     35b9 <uio+0x39>
    359e:	78 3d                	js     35dd <uio+0x5d>
    35a0:	e8 36 03 00 00       	call   38db <wait>
    35a5:	83 ec 08             	sub    $0x8,%esp
    35a8:	68 84 4d 00 00       	push   $0x4d84
    35ad:	6a 01                	push   $0x1
    35af:	e8 ac 04 00 00       	call   3a60 <printf>
    35b4:	83 c4 10             	add    $0x10,%esp
    35b7:	c9                   	leave  
    35b8:	c3                   	ret    
    35b9:	b8 09 00 00 00       	mov    $0x9,%eax
    35be:	ba 70 00 00 00       	mov    $0x70,%edx
    35c3:	ee                   	out    %al,(%dx)
    35c4:	ba 71 00 00 00       	mov    $0x71,%edx
    35c9:	ec                   	in     (%dx),%al
    35ca:	52                   	push   %edx
    35cb:	52                   	push   %edx
    35cc:	68 10 55 00 00       	push   $0x5510
    35d1:	6a 01                	push   $0x1
    35d3:	e8 88 04 00 00       	call   3a60 <printf>
    35d8:	e8 f6 02 00 00       	call   38d3 <exit>
    35dd:	50                   	push   %eax
    35de:	50                   	push   %eax
    35df:	68 09 4d 00 00       	push   $0x4d09
    35e4:	6a 01                	push   $0x1
    35e6:	e8 75 04 00 00       	call   3a60 <printf>
    35eb:	e8 e3 02 00 00       	call   38d3 <exit>

000035f0 <argptest>:
    35f0:	55                   	push   %ebp
    35f1:	89 e5                	mov    %esp,%ebp
    35f3:	53                   	push   %ebx
    35f4:	83 ec 0c             	sub    $0xc,%esp
    35f7:	6a 00                	push   $0x0
    35f9:	68 93 4d 00 00       	push   $0x4d93
    35fe:	e8 10 03 00 00       	call   3913 <open>
    3603:	83 c4 10             	add    $0x10,%esp
    3606:	85 c0                	test   %eax,%eax
    3608:	78 39                	js     3643 <argptest+0x53>
    360a:	83 ec 0c             	sub    $0xc,%esp
    360d:	89 c3                	mov    %eax,%ebx
    360f:	6a 00                	push   $0x0
    3611:	e8 45 03 00 00       	call   395b <sbrk>
    3616:	83 c4 0c             	add    $0xc,%esp
    3619:	83 e8 01             	sub    $0x1,%eax
    361c:	6a ff                	push   $0xffffffff
    361e:	50                   	push   %eax
    361f:	53                   	push   %ebx
    3620:	e8 c6 02 00 00       	call   38eb <read>
    3625:	89 1c 24             	mov    %ebx,(%esp)
    3628:	e8 ce 02 00 00       	call   38fb <close>
    362d:	58                   	pop    %eax
    362e:	5a                   	pop    %edx
    362f:	68 a5 4d 00 00       	push   $0x4da5
    3634:	6a 01                	push   $0x1
    3636:	e8 25 04 00 00       	call   3a60 <printf>
    363b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    363e:	83 c4 10             	add    $0x10,%esp
    3641:	c9                   	leave  
    3642:	c3                   	ret    
    3643:	51                   	push   %ecx
    3644:	51                   	push   %ecx
    3645:	68 98 4d 00 00       	push   $0x4d98
    364a:	6a 02                	push   $0x2
    364c:	e8 0f 04 00 00       	call   3a60 <printf>
    3651:	e8 7d 02 00 00       	call   38d3 <exit>
    3656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    365d:	8d 76 00             	lea    0x0(%esi),%esi

00003660 <rand>:
    3660:	69 05 5c 5e 00 00 0d 	imul   $0x19660d,0x5e5c,%eax
    3667:	66 19 00 
    366a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    366f:	a3 5c 5e 00 00       	mov    %eax,0x5e5c
    3674:	c3                   	ret    
    3675:	66 90                	xchg   %ax,%ax
    3677:	66 90                	xchg   %ax,%ax
    3679:	66 90                	xchg   %ax,%ax
    367b:	66 90                	xchg   %ax,%ax
    367d:	66 90                	xchg   %ax,%ax
    367f:	90                   	nop

00003680 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3680:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3681:	31 c0                	xor    %eax,%eax
{
    3683:	89 e5                	mov    %esp,%ebp
    3685:	53                   	push   %ebx
    3686:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3689:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    368c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3690:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3694:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3697:	83 c0 01             	add    $0x1,%eax
    369a:	84 d2                	test   %dl,%dl
    369c:	75 f2                	jne    3690 <strcpy+0x10>
    ;
  return os;
}
    369e:	89 c8                	mov    %ecx,%eax
    36a0:	5b                   	pop    %ebx
    36a1:	5d                   	pop    %ebp
    36a2:	c3                   	ret    
    36a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000036b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    36b0:	55                   	push   %ebp
    36b1:	89 e5                	mov    %esp,%ebp
    36b3:	53                   	push   %ebx
    36b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    36b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    36ba:	0f b6 01             	movzbl (%ecx),%eax
    36bd:	0f b6 1a             	movzbl (%edx),%ebx
    36c0:	84 c0                	test   %al,%al
    36c2:	75 1d                	jne    36e1 <strcmp+0x31>
    36c4:	eb 2a                	jmp    36f0 <strcmp+0x40>
    36c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36cd:	8d 76 00             	lea    0x0(%esi),%esi
    36d0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    36d4:	83 c1 01             	add    $0x1,%ecx
    36d7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    36da:	0f b6 1a             	movzbl (%edx),%ebx
    36dd:	84 c0                	test   %al,%al
    36df:	74 0f                	je     36f0 <strcmp+0x40>
    36e1:	38 d8                	cmp    %bl,%al
    36e3:	74 eb                	je     36d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    36e5:	29 d8                	sub    %ebx,%eax
}
    36e7:	5b                   	pop    %ebx
    36e8:	5d                   	pop    %ebp
    36e9:	c3                   	ret    
    36ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    36f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    36f2:	29 d8                	sub    %ebx,%eax
}
    36f4:	5b                   	pop    %ebx
    36f5:	5d                   	pop    %ebp
    36f6:	c3                   	ret    
    36f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36fe:	66 90                	xchg   %ax,%ax

00003700 <strlen>:

uint
strlen(char *s)
{
    3700:	55                   	push   %ebp
    3701:	89 e5                	mov    %esp,%ebp
    3703:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3706:	80 3a 00             	cmpb   $0x0,(%edx)
    3709:	74 15                	je     3720 <strlen+0x20>
    370b:	31 c0                	xor    %eax,%eax
    370d:	8d 76 00             	lea    0x0(%esi),%esi
    3710:	83 c0 01             	add    $0x1,%eax
    3713:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3717:	89 c1                	mov    %eax,%ecx
    3719:	75 f5                	jne    3710 <strlen+0x10>
    ;
  return n;
}
    371b:	89 c8                	mov    %ecx,%eax
    371d:	5d                   	pop    %ebp
    371e:	c3                   	ret    
    371f:	90                   	nop
  for(n = 0; s[n]; n++)
    3720:	31 c9                	xor    %ecx,%ecx
}
    3722:	5d                   	pop    %ebp
    3723:	89 c8                	mov    %ecx,%eax
    3725:	c3                   	ret    
    3726:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    372d:	8d 76 00             	lea    0x0(%esi),%esi

00003730 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3730:	55                   	push   %ebp
    3731:	89 e5                	mov    %esp,%ebp
    3733:	57                   	push   %edi
    3734:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3737:	8b 4d 10             	mov    0x10(%ebp),%ecx
    373a:	8b 45 0c             	mov    0xc(%ebp),%eax
    373d:	89 d7                	mov    %edx,%edi
    373f:	fc                   	cld    
    3740:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3742:	89 d0                	mov    %edx,%eax
    3744:	5f                   	pop    %edi
    3745:	5d                   	pop    %ebp
    3746:	c3                   	ret    
    3747:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    374e:	66 90                	xchg   %ax,%ax

00003750 <strchr>:

char*
strchr(const char *s, char c)
{
    3750:	55                   	push   %ebp
    3751:	89 e5                	mov    %esp,%ebp
    3753:	8b 45 08             	mov    0x8(%ebp),%eax
    3756:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    375a:	0f b6 10             	movzbl (%eax),%edx
    375d:	84 d2                	test   %dl,%dl
    375f:	75 12                	jne    3773 <strchr+0x23>
    3761:	eb 1d                	jmp    3780 <strchr+0x30>
    3763:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3767:	90                   	nop
    3768:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    376c:	83 c0 01             	add    $0x1,%eax
    376f:	84 d2                	test   %dl,%dl
    3771:	74 0d                	je     3780 <strchr+0x30>
    if(*s == c)
    3773:	38 d1                	cmp    %dl,%cl
    3775:	75 f1                	jne    3768 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3777:	5d                   	pop    %ebp
    3778:	c3                   	ret    
    3779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3780:	31 c0                	xor    %eax,%eax
}
    3782:	5d                   	pop    %ebp
    3783:	c3                   	ret    
    3784:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    378b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    378f:	90                   	nop

00003790 <gets>:

char*
gets(char *buf, int max)
{
    3790:	55                   	push   %ebp
    3791:	89 e5                	mov    %esp,%ebp
    3793:	57                   	push   %edi
    3794:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3795:	31 f6                	xor    %esi,%esi
{
    3797:	53                   	push   %ebx
    3798:	89 f3                	mov    %esi,%ebx
    379a:	83 ec 1c             	sub    $0x1c,%esp
    379d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    37a0:	eb 2f                	jmp    37d1 <gets+0x41>
    37a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    37a8:	83 ec 04             	sub    $0x4,%esp
    37ab:	8d 45 e7             	lea    -0x19(%ebp),%eax
    37ae:	6a 01                	push   $0x1
    37b0:	50                   	push   %eax
    37b1:	6a 00                	push   $0x0
    37b3:	e8 33 01 00 00       	call   38eb <read>
    if(cc < 1)
    37b8:	83 c4 10             	add    $0x10,%esp
    37bb:	85 c0                	test   %eax,%eax
    37bd:	7e 1c                	jle    37db <gets+0x4b>
      break;
    buf[i++] = c;
    37bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    37c3:	83 c7 01             	add    $0x1,%edi
    37c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    37c9:	3c 0a                	cmp    $0xa,%al
    37cb:	74 23                	je     37f0 <gets+0x60>
    37cd:	3c 0d                	cmp    $0xd,%al
    37cf:	74 1f                	je     37f0 <gets+0x60>
  for(i=0; i+1 < max; ){
    37d1:	83 c3 01             	add    $0x1,%ebx
    37d4:	89 fe                	mov    %edi,%esi
    37d6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    37d9:	7c cd                	jl     37a8 <gets+0x18>
    37db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    37dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    37e0:	c6 03 00             	movb   $0x0,(%ebx)
}
    37e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37e6:	5b                   	pop    %ebx
    37e7:	5e                   	pop    %esi
    37e8:	5f                   	pop    %edi
    37e9:	5d                   	pop    %ebp
    37ea:	c3                   	ret    
    37eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    37ef:	90                   	nop
    37f0:	8b 75 08             	mov    0x8(%ebp),%esi
    37f3:	8b 45 08             	mov    0x8(%ebp),%eax
    37f6:	01 de                	add    %ebx,%esi
    37f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    37fa:	c6 03 00             	movb   $0x0,(%ebx)
}
    37fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3800:	5b                   	pop    %ebx
    3801:	5e                   	pop    %esi
    3802:	5f                   	pop    %edi
    3803:	5d                   	pop    %ebp
    3804:	c3                   	ret    
    3805:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    380c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003810 <stat>:

int
stat(char *n, struct stat *st)
{
    3810:	55                   	push   %ebp
    3811:	89 e5                	mov    %esp,%ebp
    3813:	56                   	push   %esi
    3814:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3815:	83 ec 08             	sub    $0x8,%esp
    3818:	6a 00                	push   $0x0
    381a:	ff 75 08             	pushl  0x8(%ebp)
    381d:	e8 f1 00 00 00       	call   3913 <open>
  if(fd < 0)
    3822:	83 c4 10             	add    $0x10,%esp
    3825:	85 c0                	test   %eax,%eax
    3827:	78 27                	js     3850 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3829:	83 ec 08             	sub    $0x8,%esp
    382c:	ff 75 0c             	pushl  0xc(%ebp)
    382f:	89 c3                	mov    %eax,%ebx
    3831:	50                   	push   %eax
    3832:	e8 f4 00 00 00       	call   392b <fstat>
  close(fd);
    3837:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    383a:	89 c6                	mov    %eax,%esi
  close(fd);
    383c:	e8 ba 00 00 00       	call   38fb <close>
  return r;
    3841:	83 c4 10             	add    $0x10,%esp
}
    3844:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3847:	89 f0                	mov    %esi,%eax
    3849:	5b                   	pop    %ebx
    384a:	5e                   	pop    %esi
    384b:	5d                   	pop    %ebp
    384c:	c3                   	ret    
    384d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3850:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3855:	eb ed                	jmp    3844 <stat+0x34>
    3857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    385e:	66 90                	xchg   %ax,%ax

00003860 <atoi>:

int
atoi(const char *s)
{
    3860:	55                   	push   %ebp
    3861:	89 e5                	mov    %esp,%ebp
    3863:	53                   	push   %ebx
    3864:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3867:	0f be 02             	movsbl (%edx),%eax
    386a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    386d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3870:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3875:	77 1e                	ja     3895 <atoi+0x35>
    3877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    387e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3880:	83 c2 01             	add    $0x1,%edx
    3883:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3886:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    388a:	0f be 02             	movsbl (%edx),%eax
    388d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3890:	80 fb 09             	cmp    $0x9,%bl
    3893:	76 eb                	jbe    3880 <atoi+0x20>
  return n;
}
    3895:	89 c8                	mov    %ecx,%eax
    3897:	5b                   	pop    %ebx
    3898:	5d                   	pop    %ebp
    3899:	c3                   	ret    
    389a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000038a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    38a0:	55                   	push   %ebp
    38a1:	89 e5                	mov    %esp,%ebp
    38a3:	57                   	push   %edi
    38a4:	8b 45 10             	mov    0x10(%ebp),%eax
    38a7:	8b 55 08             	mov    0x8(%ebp),%edx
    38aa:	56                   	push   %esi
    38ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    38ae:	85 c0                	test   %eax,%eax
    38b0:	7e 13                	jle    38c5 <memmove+0x25>
    38b2:	01 d0                	add    %edx,%eax
  dst = vdst;
    38b4:	89 d7                	mov    %edx,%edi
    38b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    38bd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    38c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    38c1:	39 f8                	cmp    %edi,%eax
    38c3:	75 fb                	jne    38c0 <memmove+0x20>
  return vdst;
}
    38c5:	5e                   	pop    %esi
    38c6:	89 d0                	mov    %edx,%eax
    38c8:	5f                   	pop    %edi
    38c9:	5d                   	pop    %ebp
    38ca:	c3                   	ret    

000038cb <fork>:
    38cb:	b8 01 00 00 00       	mov    $0x1,%eax
    38d0:	cd 40                	int    $0x40
    38d2:	c3                   	ret    

000038d3 <exit>:
    38d3:	b8 02 00 00 00       	mov    $0x2,%eax
    38d8:	cd 40                	int    $0x40
    38da:	c3                   	ret    

000038db <wait>:
    38db:	b8 03 00 00 00       	mov    $0x3,%eax
    38e0:	cd 40                	int    $0x40
    38e2:	c3                   	ret    

000038e3 <pipe>:
    38e3:	b8 04 00 00 00       	mov    $0x4,%eax
    38e8:	cd 40                	int    $0x40
    38ea:	c3                   	ret    

000038eb <read>:
    38eb:	b8 05 00 00 00       	mov    $0x5,%eax
    38f0:	cd 40                	int    $0x40
    38f2:	c3                   	ret    

000038f3 <write>:
    38f3:	b8 10 00 00 00       	mov    $0x10,%eax
    38f8:	cd 40                	int    $0x40
    38fa:	c3                   	ret    

000038fb <close>:
    38fb:	b8 15 00 00 00       	mov    $0x15,%eax
    3900:	cd 40                	int    $0x40
    3902:	c3                   	ret    

00003903 <kill>:
    3903:	b8 06 00 00 00       	mov    $0x6,%eax
    3908:	cd 40                	int    $0x40
    390a:	c3                   	ret    

0000390b <exec>:
    390b:	b8 07 00 00 00       	mov    $0x7,%eax
    3910:	cd 40                	int    $0x40
    3912:	c3                   	ret    

00003913 <open>:
    3913:	b8 0f 00 00 00       	mov    $0xf,%eax
    3918:	cd 40                	int    $0x40
    391a:	c3                   	ret    

0000391b <mknod>:
    391b:	b8 11 00 00 00       	mov    $0x11,%eax
    3920:	cd 40                	int    $0x40
    3922:	c3                   	ret    

00003923 <unlink>:
    3923:	b8 12 00 00 00       	mov    $0x12,%eax
    3928:	cd 40                	int    $0x40
    392a:	c3                   	ret    

0000392b <fstat>:
    392b:	b8 08 00 00 00       	mov    $0x8,%eax
    3930:	cd 40                	int    $0x40
    3932:	c3                   	ret    

00003933 <link>:
    3933:	b8 13 00 00 00       	mov    $0x13,%eax
    3938:	cd 40                	int    $0x40
    393a:	c3                   	ret    

0000393b <mkdir>:
    393b:	b8 14 00 00 00       	mov    $0x14,%eax
    3940:	cd 40                	int    $0x40
    3942:	c3                   	ret    

00003943 <chdir>:
    3943:	b8 09 00 00 00       	mov    $0x9,%eax
    3948:	cd 40                	int    $0x40
    394a:	c3                   	ret    

0000394b <dup>:
    394b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3950:	cd 40                	int    $0x40
    3952:	c3                   	ret    

00003953 <getpid>:
    3953:	b8 0b 00 00 00       	mov    $0xb,%eax
    3958:	cd 40                	int    $0x40
    395a:	c3                   	ret    

0000395b <sbrk>:
    395b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3960:	cd 40                	int    $0x40
    3962:	c3                   	ret    

00003963 <sleep>:
    3963:	b8 0d 00 00 00       	mov    $0xd,%eax
    3968:	cd 40                	int    $0x40
    396a:	c3                   	ret    

0000396b <uptime>:
    396b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3970:	cd 40                	int    $0x40
    3972:	c3                   	ret    

00003973 <date>:
    3973:	b8 16 00 00 00       	mov    $0x16,%eax
    3978:	cd 40                	int    $0x40
    397a:	c3                   	ret    

0000397b <cps>:
    397b:	b8 17 00 00 00       	mov    $0x17,%eax
    3980:	cd 40                	int    $0x40
    3982:	c3                   	ret    

00003983 <getuid>:
    3983:	b8 18 00 00 00       	mov    $0x18,%eax
    3988:	cd 40                	int    $0x40
    398a:	c3                   	ret    

0000398b <getgid>:
    398b:	b8 19 00 00 00       	mov    $0x19,%eax
    3990:	cd 40                	int    $0x40
    3992:	c3                   	ret    

00003993 <getppid>:
    3993:	b8 1a 00 00 00       	mov    $0x1a,%eax
    3998:	cd 40                	int    $0x40
    399a:	c3                   	ret    

0000399b <setuid>:
    399b:	b8 1b 00 00 00       	mov    $0x1b,%eax
    39a0:	cd 40                	int    $0x40
    39a2:	c3                   	ret    

000039a3 <setgid>:
    39a3:	b8 1c 00 00 00       	mov    $0x1c,%eax
    39a8:	cd 40                	int    $0x40
    39aa:	c3                   	ret    
    39ab:	66 90                	xchg   %ax,%ax
    39ad:	66 90                	xchg   %ax,%ax
    39af:	90                   	nop

000039b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    39b0:	55                   	push   %ebp
    39b1:	89 e5                	mov    %esp,%ebp
    39b3:	57                   	push   %edi
    39b4:	56                   	push   %esi
    39b5:	53                   	push   %ebx
    39b6:	83 ec 3c             	sub    $0x3c,%esp
    39b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    39bc:	89 d1                	mov    %edx,%ecx
{
    39be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    39c1:	85 d2                	test   %edx,%edx
    39c3:	0f 89 7f 00 00 00    	jns    3a48 <printint+0x98>
    39c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    39cd:	74 79                	je     3a48 <printint+0x98>
    neg = 1;
    39cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    39d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    39d8:	31 db                	xor    %ebx,%ebx
    39da:	8d 75 d7             	lea    -0x29(%ebp),%esi
    39dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    39e0:	89 c8                	mov    %ecx,%eax
    39e2:	31 d2                	xor    %edx,%edx
    39e4:	89 cf                	mov    %ecx,%edi
    39e6:	f7 75 c4             	divl   -0x3c(%ebp)
    39e9:	0f b6 92 68 55 00 00 	movzbl 0x5568(%edx),%edx
    39f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    39f3:	89 d8                	mov    %ebx,%eax
    39f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    39f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    39fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    39fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3a01:	76 dd                	jbe    39e0 <printint+0x30>
  if(neg)
    3a03:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3a06:	85 c9                	test   %ecx,%ecx
    3a08:	74 0c                	je     3a16 <printint+0x66>
    buf[i++] = '-';
    3a0a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    3a0f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    3a11:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    3a16:	8b 7d b8             	mov    -0x48(%ebp),%edi
    3a19:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    3a1d:	eb 07                	jmp    3a26 <printint+0x76>
    3a1f:	90                   	nop
    3a20:	0f b6 13             	movzbl (%ebx),%edx
    3a23:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3a26:	83 ec 04             	sub    $0x4,%esp
    3a29:	88 55 d7             	mov    %dl,-0x29(%ebp)
    3a2c:	6a 01                	push   $0x1
    3a2e:	56                   	push   %esi
    3a2f:	57                   	push   %edi
    3a30:	e8 be fe ff ff       	call   38f3 <write>
  while(--i >= 0)
    3a35:	83 c4 10             	add    $0x10,%esp
    3a38:	39 de                	cmp    %ebx,%esi
    3a3a:	75 e4                	jne    3a20 <printint+0x70>
    putc(fd, buf[i]);
}
    3a3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3a3f:	5b                   	pop    %ebx
    3a40:	5e                   	pop    %esi
    3a41:	5f                   	pop    %edi
    3a42:	5d                   	pop    %ebp
    3a43:	c3                   	ret    
    3a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3a48:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    3a4f:	eb 87                	jmp    39d8 <printint+0x28>
    3a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a5f:	90                   	nop

00003a60 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3a60:	55                   	push   %ebp
    3a61:	89 e5                	mov    %esp,%ebp
    3a63:	57                   	push   %edi
    3a64:	56                   	push   %esi
    3a65:	53                   	push   %ebx
    3a66:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3a69:	8b 75 0c             	mov    0xc(%ebp),%esi
    3a6c:	0f b6 1e             	movzbl (%esi),%ebx
    3a6f:	84 db                	test   %bl,%bl
    3a71:	0f 84 b8 00 00 00    	je     3b2f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    3a77:	8d 45 10             	lea    0x10(%ebp),%eax
    3a7a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    3a7d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    3a80:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    3a82:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3a85:	eb 37                	jmp    3abe <printf+0x5e>
    3a87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a8e:	66 90                	xchg   %ax,%ax
    3a90:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3a93:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    3a98:	83 f8 25             	cmp    $0x25,%eax
    3a9b:	74 17                	je     3ab4 <printf+0x54>
  write(fd, &c, 1);
    3a9d:	83 ec 04             	sub    $0x4,%esp
    3aa0:	88 5d e7             	mov    %bl,-0x19(%ebp)
    3aa3:	6a 01                	push   $0x1
    3aa5:	57                   	push   %edi
    3aa6:	ff 75 08             	pushl  0x8(%ebp)
    3aa9:	e8 45 fe ff ff       	call   38f3 <write>
    3aae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    3ab1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3ab4:	0f b6 1e             	movzbl (%esi),%ebx
    3ab7:	83 c6 01             	add    $0x1,%esi
    3aba:	84 db                	test   %bl,%bl
    3abc:	74 71                	je     3b2f <printf+0xcf>
    c = fmt[i] & 0xff;
    3abe:	0f be cb             	movsbl %bl,%ecx
    3ac1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    3ac4:	85 d2                	test   %edx,%edx
    3ac6:	74 c8                	je     3a90 <printf+0x30>
      }
    } else if(state == '%'){
    3ac8:	83 fa 25             	cmp    $0x25,%edx
    3acb:	75 e7                	jne    3ab4 <printf+0x54>
      if(c == 'd'){
    3acd:	83 f8 64             	cmp    $0x64,%eax
    3ad0:	0f 84 9a 00 00 00    	je     3b70 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3ad6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    3adc:	83 f9 70             	cmp    $0x70,%ecx
    3adf:	74 5f                	je     3b40 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3ae1:	83 f8 73             	cmp    $0x73,%eax
    3ae4:	0f 84 d6 00 00 00    	je     3bc0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3aea:	83 f8 63             	cmp    $0x63,%eax
    3aed:	0f 84 8d 00 00 00    	je     3b80 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3af3:	83 f8 25             	cmp    $0x25,%eax
    3af6:	0f 84 b4 00 00 00    	je     3bb0 <printf+0x150>
  write(fd, &c, 1);
    3afc:	83 ec 04             	sub    $0x4,%esp
    3aff:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3b03:	6a 01                	push   $0x1
    3b05:	57                   	push   %edi
    3b06:	ff 75 08             	pushl  0x8(%ebp)
    3b09:	e8 e5 fd ff ff       	call   38f3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3b0e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    3b11:	83 c4 0c             	add    $0xc,%esp
    3b14:	6a 01                	push   $0x1
    3b16:	83 c6 01             	add    $0x1,%esi
    3b19:	57                   	push   %edi
    3b1a:	ff 75 08             	pushl  0x8(%ebp)
    3b1d:	e8 d1 fd ff ff       	call   38f3 <write>
  for(i = 0; fmt[i]; i++){
    3b22:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    3b26:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    3b29:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    3b2b:	84 db                	test   %bl,%bl
    3b2d:	75 8f                	jne    3abe <printf+0x5e>
    }
  }
}
    3b2f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3b32:	5b                   	pop    %ebx
    3b33:	5e                   	pop    %esi
    3b34:	5f                   	pop    %edi
    3b35:	5d                   	pop    %ebp
    3b36:	c3                   	ret    
    3b37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b3e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    3b40:	83 ec 0c             	sub    $0xc,%esp
    3b43:	b9 10 00 00 00       	mov    $0x10,%ecx
    3b48:	6a 00                	push   $0x0
    3b4a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    3b4d:	8b 45 08             	mov    0x8(%ebp),%eax
    3b50:	8b 13                	mov    (%ebx),%edx
    3b52:	e8 59 fe ff ff       	call   39b0 <printint>
        ap++;
    3b57:	89 d8                	mov    %ebx,%eax
    3b59:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b5c:	31 d2                	xor    %edx,%edx
        ap++;
    3b5e:	83 c0 04             	add    $0x4,%eax
    3b61:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3b64:	e9 4b ff ff ff       	jmp    3ab4 <printf+0x54>
    3b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    3b70:	83 ec 0c             	sub    $0xc,%esp
    3b73:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3b78:	6a 01                	push   $0x1
    3b7a:	eb ce                	jmp    3b4a <printf+0xea>
    3b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    3b80:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    3b83:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3b86:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    3b88:	6a 01                	push   $0x1
        ap++;
    3b8a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    3b8d:	57                   	push   %edi
    3b8e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    3b91:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3b94:	e8 5a fd ff ff       	call   38f3 <write>
        ap++;
    3b99:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    3b9c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b9f:	31 d2                	xor    %edx,%edx
    3ba1:	e9 0e ff ff ff       	jmp    3ab4 <printf+0x54>
    3ba6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3bad:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    3bb0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    3bb3:	83 ec 04             	sub    $0x4,%esp
    3bb6:	e9 59 ff ff ff       	jmp    3b14 <printf+0xb4>
    3bbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3bbf:	90                   	nop
        s = (char*)*ap;
    3bc0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3bc3:	8b 18                	mov    (%eax),%ebx
        ap++;
    3bc5:	83 c0 04             	add    $0x4,%eax
    3bc8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3bcb:	85 db                	test   %ebx,%ebx
    3bcd:	74 17                	je     3be6 <printf+0x186>
        while(*s != 0){
    3bcf:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    3bd2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    3bd4:	84 c0                	test   %al,%al
    3bd6:	0f 84 d8 fe ff ff    	je     3ab4 <printf+0x54>
    3bdc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    3bdf:	89 de                	mov    %ebx,%esi
    3be1:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3be4:	eb 1a                	jmp    3c00 <printf+0x1a0>
          s = "(null)";
    3be6:	bb 60 55 00 00       	mov    $0x5560,%ebx
        while(*s != 0){
    3beb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    3bee:	b8 28 00 00 00       	mov    $0x28,%eax
    3bf3:	89 de                	mov    %ebx,%esi
    3bf5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3bf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3bff:	90                   	nop
  write(fd, &c, 1);
    3c00:	83 ec 04             	sub    $0x4,%esp
          s++;
    3c03:	83 c6 01             	add    $0x1,%esi
    3c06:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3c09:	6a 01                	push   $0x1
    3c0b:	57                   	push   %edi
    3c0c:	53                   	push   %ebx
    3c0d:	e8 e1 fc ff ff       	call   38f3 <write>
        while(*s != 0){
    3c12:	0f b6 06             	movzbl (%esi),%eax
    3c15:	83 c4 10             	add    $0x10,%esp
    3c18:	84 c0                	test   %al,%al
    3c1a:	75 e4                	jne    3c00 <printf+0x1a0>
    3c1c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    3c1f:	31 d2                	xor    %edx,%edx
    3c21:	e9 8e fe ff ff       	jmp    3ab4 <printf+0x54>
    3c26:	66 90                	xchg   %ax,%ax
    3c28:	66 90                	xchg   %ax,%ax
    3c2a:	66 90                	xchg   %ax,%ax
    3c2c:	66 90                	xchg   %ax,%ax
    3c2e:	66 90                	xchg   %ax,%ax

00003c30 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3c30:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c31:	a1 00 5f 00 00       	mov    0x5f00,%eax
{
    3c36:	89 e5                	mov    %esp,%ebp
    3c38:	57                   	push   %edi
    3c39:	56                   	push   %esi
    3c3a:	53                   	push   %ebx
    3c3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3c3e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
    3c40:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c43:	39 c8                	cmp    %ecx,%eax
    3c45:	73 19                	jae    3c60 <free+0x30>
    3c47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c4e:	66 90                	xchg   %ax,%ax
    3c50:	39 d1                	cmp    %edx,%ecx
    3c52:	72 14                	jb     3c68 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c54:	39 d0                	cmp    %edx,%eax
    3c56:	73 10                	jae    3c68 <free+0x38>
{
    3c58:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c5a:	8b 10                	mov    (%eax),%edx
    3c5c:	39 c8                	cmp    %ecx,%eax
    3c5e:	72 f0                	jb     3c50 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c60:	39 d0                	cmp    %edx,%eax
    3c62:	72 f4                	jb     3c58 <free+0x28>
    3c64:	39 d1                	cmp    %edx,%ecx
    3c66:	73 f0                	jae    3c58 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3c68:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3c6b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3c6e:	39 fa                	cmp    %edi,%edx
    3c70:	74 1e                	je     3c90 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3c72:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c75:	8b 50 04             	mov    0x4(%eax),%edx
    3c78:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c7b:	39 f1                	cmp    %esi,%ecx
    3c7d:	74 28                	je     3ca7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3c7f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    3c81:	5b                   	pop    %ebx
  freep = p;
    3c82:	a3 00 5f 00 00       	mov    %eax,0x5f00
}
    3c87:	5e                   	pop    %esi
    3c88:	5f                   	pop    %edi
    3c89:	5d                   	pop    %ebp
    3c8a:	c3                   	ret    
    3c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3c8f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
    3c90:	03 72 04             	add    0x4(%edx),%esi
    3c93:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3c96:	8b 10                	mov    (%eax),%edx
    3c98:	8b 12                	mov    (%edx),%edx
    3c9a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c9d:	8b 50 04             	mov    0x4(%eax),%edx
    3ca0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3ca3:	39 f1                	cmp    %esi,%ecx
    3ca5:	75 d8                	jne    3c7f <free+0x4f>
    p->s.size += bp->s.size;
    3ca7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    3caa:	a3 00 5f 00 00       	mov    %eax,0x5f00
    p->s.size += bp->s.size;
    3caf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3cb2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3cb5:	89 10                	mov    %edx,(%eax)
}
    3cb7:	5b                   	pop    %ebx
    3cb8:	5e                   	pop    %esi
    3cb9:	5f                   	pop    %edi
    3cba:	5d                   	pop    %ebp
    3cbb:	c3                   	ret    
    3cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003cc0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3cc0:	55                   	push   %ebp
    3cc1:	89 e5                	mov    %esp,%ebp
    3cc3:	57                   	push   %edi
    3cc4:	56                   	push   %esi
    3cc5:	53                   	push   %ebx
    3cc6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3ccc:	8b 3d 00 5f 00 00    	mov    0x5f00,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3cd2:	8d 70 07             	lea    0x7(%eax),%esi
    3cd5:	c1 ee 03             	shr    $0x3,%esi
    3cd8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    3cdb:	85 ff                	test   %edi,%edi
    3cdd:	0f 84 ad 00 00 00    	je     3d90 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3ce3:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    3ce5:	8b 48 04             	mov    0x4(%eax),%ecx
    3ce8:	39 f1                	cmp    %esi,%ecx
    3cea:	73 71                	jae    3d5d <malloc+0x9d>
    3cec:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    3cf2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3cf7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3cfa:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    3d01:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    3d04:	eb 1b                	jmp    3d21 <malloc+0x61>
    3d06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3d0d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3d10:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    3d12:	8b 4a 04             	mov    0x4(%edx),%ecx
    3d15:	39 f1                	cmp    %esi,%ecx
    3d17:	73 4f                	jae    3d68 <malloc+0xa8>
    3d19:	8b 3d 00 5f 00 00    	mov    0x5f00,%edi
    3d1f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3d21:	39 c7                	cmp    %eax,%edi
    3d23:	75 eb                	jne    3d10 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    3d25:	83 ec 0c             	sub    $0xc,%esp
    3d28:	ff 75 e4             	pushl  -0x1c(%ebp)
    3d2b:	e8 2b fc ff ff       	call   395b <sbrk>
  if(p == (char*)-1)
    3d30:	83 c4 10             	add    $0x10,%esp
    3d33:	83 f8 ff             	cmp    $0xffffffff,%eax
    3d36:	74 1b                	je     3d53 <malloc+0x93>
  hp->s.size = nu;
    3d38:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3d3b:	83 ec 0c             	sub    $0xc,%esp
    3d3e:	83 c0 08             	add    $0x8,%eax
    3d41:	50                   	push   %eax
    3d42:	e8 e9 fe ff ff       	call   3c30 <free>
  return freep;
    3d47:	a1 00 5f 00 00       	mov    0x5f00,%eax
      if((p = morecore(nunits)) == 0)
    3d4c:	83 c4 10             	add    $0x10,%esp
    3d4f:	85 c0                	test   %eax,%eax
    3d51:	75 bd                	jne    3d10 <malloc+0x50>
        return 0;
  }
}
    3d53:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3d56:	31 c0                	xor    %eax,%eax
}
    3d58:	5b                   	pop    %ebx
    3d59:	5e                   	pop    %esi
    3d5a:	5f                   	pop    %edi
    3d5b:	5d                   	pop    %ebp
    3d5c:	c3                   	ret    
    if(p->s.size >= nunits){
    3d5d:	89 c2                	mov    %eax,%edx
    3d5f:	89 f8                	mov    %edi,%eax
    3d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    3d68:	39 ce                	cmp    %ecx,%esi
    3d6a:	74 54                	je     3dc0 <malloc+0x100>
        p->s.size -= nunits;
    3d6c:	29 f1                	sub    %esi,%ecx
    3d6e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    3d71:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    3d74:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    3d77:	a3 00 5f 00 00       	mov    %eax,0x5f00
}
    3d7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3d7f:	8d 42 08             	lea    0x8(%edx),%eax
}
    3d82:	5b                   	pop    %ebx
    3d83:	5e                   	pop    %esi
    3d84:	5f                   	pop    %edi
    3d85:	5d                   	pop    %ebp
    3d86:	c3                   	ret    
    3d87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3d8e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    3d90:	c7 05 00 5f 00 00 04 	movl   $0x5f04,0x5f00
    3d97:	5f 00 00 
    base.s.size = 0;
    3d9a:	bf 04 5f 00 00       	mov    $0x5f04,%edi
    base.s.ptr = freep = prevp = &base;
    3d9f:	c7 05 04 5f 00 00 04 	movl   $0x5f04,0x5f04
    3da6:	5f 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3da9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    3dab:	c7 05 08 5f 00 00 00 	movl   $0x0,0x5f08
    3db2:	00 00 00 
    if(p->s.size >= nunits){
    3db5:	e9 32 ff ff ff       	jmp    3cec <malloc+0x2c>
    3dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3dc0:	8b 0a                	mov    (%edx),%ecx
    3dc2:	89 08                	mov    %ecx,(%eax)
    3dc4:	eb b1                	jmp    3d77 <malloc+0xb7>
