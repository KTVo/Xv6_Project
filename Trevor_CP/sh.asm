
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      17:	90                   	nop
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f b7 00 00 00    	jg     d8 <main+0xd8>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 99 12 00 00       	push   $0x1299
      2b:	e8 43 0d 00 00       	call   d73 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	eb 32                	jmp    6b <main+0x6b>
      39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      40:	80 3d e2 18 00 00 20 	cmpb   $0x20,0x18e2
      47:	74 51                	je     9a <main+0x9a>
      49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      50:	e8 d6 0c 00 00       	call   d2b <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	0f 84 9d 00 00 00    	je     fb <main+0xfb>
    if(fork1() == 0)
      5e:	85 c0                	test   %eax,%eax
      60:	0f 84 80 00 00 00    	je     e6 <main+0xe6>
    wait();
      66:	e8 d0 0c 00 00       	call   d3b <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      6b:	83 ec 08             	sub    $0x8,%esp
      6e:	6a 64                	push   $0x64
      70:	68 e0 18 00 00       	push   $0x18e0
      75:	e8 96 00 00 00       	call   110 <getcmd>
      7a:	83 c4 10             	add    $0x10,%esp
      7d:	85 c0                	test   %eax,%eax
      7f:	78 14                	js     95 <main+0x95>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      81:	80 3d e0 18 00 00 63 	cmpb   $0x63,0x18e0
      88:	75 c6                	jne    50 <main+0x50>
      8a:	80 3d e1 18 00 00 64 	cmpb   $0x64,0x18e1
      91:	75 bd                	jne    50 <main+0x50>
      93:	eb ab                	jmp    40 <main+0x40>
  exit();
      95:	e8 99 0c 00 00       	call   d33 <exit>
      buf[strlen(buf)-1] = 0;  // chop \n
      9a:	83 ec 0c             	sub    $0xc,%esp
      9d:	68 e0 18 00 00       	push   $0x18e0
      a2:	e8 b9 0a 00 00       	call   b60 <strlen>
      if(chdir(buf+3) < 0)
      a7:	c7 04 24 e3 18 00 00 	movl   $0x18e3,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      ae:	c6 80 df 18 00 00 00 	movb   $0x0,0x18df(%eax)
      if(chdir(buf+3) < 0)
      b5:	e8 e9 0c 00 00       	call   da3 <chdir>
      ba:	83 c4 10             	add    $0x10,%esp
      bd:	85 c0                	test   %eax,%eax
      bf:	79 aa                	jns    6b <main+0x6b>
        printf(2, "cannot cd %s\n", buf+3);
      c1:	50                   	push   %eax
      c2:	68 e3 18 00 00       	push   $0x18e3
      c7:	68 a1 12 00 00       	push   $0x12a1
      cc:	6a 02                	push   $0x2
      ce:	e8 bd 0d 00 00       	call   e90 <printf>
      d3:	83 c4 10             	add    $0x10,%esp
      d6:	eb 93                	jmp    6b <main+0x6b>
      close(fd);
      d8:	83 ec 0c             	sub    $0xc,%esp
      db:	50                   	push   %eax
      dc:	e8 7a 0c 00 00       	call   d5b <close>
      break;
      e1:	83 c4 10             	add    $0x10,%esp
      e4:	eb 85                	jmp    6b <main+0x6b>
      runcmd(parsecmd(buf));
      e6:	83 ec 0c             	sub    $0xc,%esp
      e9:	68 e0 18 00 00       	push   $0x18e0
      ee:	e8 7d 09 00 00       	call   a70 <parsecmd>
      f3:	89 04 24             	mov    %eax,(%esp)
      f6:	e8 85 00 00 00       	call   180 <runcmd>
    panic("fork");
      fb:	83 ec 0c             	sub    $0xc,%esp
      fe:	68 22 12 00 00       	push   $0x1222
     103:	e8 58 00 00 00       	call   160 <panic>
     108:	66 90                	xchg   %ax,%ax
     10a:	66 90                	xchg   %ax,%ax
     10c:	66 90                	xchg   %ax,%ax
     10e:	66 90                	xchg   %ax,%ax

00000110 <getcmd>:
{
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	56                   	push   %esi
     114:	53                   	push   %ebx
     115:	8b 75 0c             	mov    0xc(%ebp),%esi
     118:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
     11b:	83 ec 08             	sub    $0x8,%esp
     11e:	68 f8 11 00 00       	push   $0x11f8
     123:	6a 02                	push   $0x2
     125:	e8 66 0d 00 00       	call   e90 <printf>
  memset(buf, 0, nbuf);
     12a:	83 c4 0c             	add    $0xc,%esp
     12d:	56                   	push   %esi
     12e:	6a 00                	push   $0x0
     130:	53                   	push   %ebx
     131:	e8 5a 0a 00 00       	call   b90 <memset>
  gets(buf, nbuf);
     136:	58                   	pop    %eax
     137:	5a                   	pop    %edx
     138:	56                   	push   %esi
     139:	53                   	push   %ebx
     13a:	e8 b1 0a 00 00       	call   bf0 <gets>
  if(buf[0] == 0) // EOF
     13f:	83 c4 10             	add    $0x10,%esp
     142:	31 c0                	xor    %eax,%eax
     144:	80 3b 00             	cmpb   $0x0,(%ebx)
     147:	0f 94 c0             	sete   %al
}
     14a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     14d:	5b                   	pop    %ebx
  if(buf[0] == 0) // EOF
     14e:	f7 d8                	neg    %eax
}
     150:	5e                   	pop    %esi
     151:	5d                   	pop    %ebp
     152:	c3                   	ret    
     153:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     15a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000160 <panic>:
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     166:	ff 75 08             	pushl  0x8(%ebp)
     169:	68 95 12 00 00       	push   $0x1295
     16e:	6a 02                	push   $0x2
     170:	e8 1b 0d 00 00       	call   e90 <printf>
  exit();
     175:	e8 b9 0b 00 00       	call   d33 <exit>
     17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000180 <runcmd>:
{
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	53                   	push   %ebx
     184:	83 ec 14             	sub    $0x14,%esp
     187:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     18a:	85 db                	test   %ebx,%ebx
     18c:	74 7a                	je     208 <runcmd+0x88>
  switch(cmd->type){
     18e:	83 3b 05             	cmpl   $0x5,(%ebx)
     191:	0f 87 00 01 00 00    	ja     297 <runcmd+0x117>
     197:	8b 03                	mov    (%ebx),%eax
     199:	ff 24 85 b0 12 00 00 	jmp    *0x12b0(,%eax,4)
    if(pipe(p) < 0)
     1a0:	83 ec 0c             	sub    $0xc,%esp
     1a3:	8d 45 f0             	lea    -0x10(%ebp),%eax
     1a6:	50                   	push   %eax
     1a7:	e8 97 0b 00 00       	call   d43 <pipe>
     1ac:	83 c4 10             	add    $0x10,%esp
     1af:	85 c0                	test   %eax,%eax
     1b1:	0f 88 02 01 00 00    	js     2b9 <runcmd+0x139>
  pid = fork();
     1b7:	e8 6f 0b 00 00       	call   d2b <fork>
  if(pid == -1)
     1bc:	83 f8 ff             	cmp    $0xffffffff,%eax
     1bf:	0f 84 5d 01 00 00    	je     322 <runcmd+0x1a2>
    if(fork1() == 0){
     1c5:	85 c0                	test   %eax,%eax
     1c7:	0f 84 f9 00 00 00    	je     2c6 <runcmd+0x146>
  pid = fork();
     1cd:	e8 59 0b 00 00       	call   d2b <fork>
  if(pid == -1)
     1d2:	83 f8 ff             	cmp    $0xffffffff,%eax
     1d5:	0f 84 47 01 00 00    	je     322 <runcmd+0x1a2>
    if(fork1() == 0){
     1db:	85 c0                	test   %eax,%eax
     1dd:	0f 84 11 01 00 00    	je     2f4 <runcmd+0x174>
    close(p[0]);
     1e3:	83 ec 0c             	sub    $0xc,%esp
     1e6:	ff 75 f0             	pushl  -0x10(%ebp)
     1e9:	e8 6d 0b 00 00       	call   d5b <close>
    close(p[1]);
     1ee:	58                   	pop    %eax
     1ef:	ff 75 f4             	pushl  -0xc(%ebp)
     1f2:	e8 64 0b 00 00       	call   d5b <close>
    wait();
     1f7:	e8 3f 0b 00 00       	call   d3b <wait>
    wait();
     1fc:	e8 3a 0b 00 00       	call   d3b <wait>
    break;
     201:	83 c4 10             	add    $0x10,%esp
     204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
     208:	e8 26 0b 00 00       	call   d33 <exit>
  pid = fork();
     20d:	e8 19 0b 00 00       	call   d2b <fork>
  if(pid == -1)
     212:	83 f8 ff             	cmp    $0xffffffff,%eax
     215:	0f 84 07 01 00 00    	je     322 <runcmd+0x1a2>
    if(fork1() == 0)
     21b:	85 c0                	test   %eax,%eax
     21d:	75 e9                	jne    208 <runcmd+0x88>
     21f:	eb 6b                	jmp    28c <runcmd+0x10c>
    if(ecmd->argv[0] == 0)
     221:	8b 43 04             	mov    0x4(%ebx),%eax
     224:	85 c0                	test   %eax,%eax
     226:	74 e0                	je     208 <runcmd+0x88>
    exec(ecmd->argv[0], ecmd->argv);
     228:	8d 53 04             	lea    0x4(%ebx),%edx
     22b:	51                   	push   %ecx
     22c:	51                   	push   %ecx
     22d:	52                   	push   %edx
     22e:	50                   	push   %eax
     22f:	e8 37 0b 00 00       	call   d6b <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     234:	83 c4 0c             	add    $0xc,%esp
     237:	ff 73 04             	pushl  0x4(%ebx)
     23a:	68 02 12 00 00       	push   $0x1202
     23f:	6a 02                	push   $0x2
     241:	e8 4a 0c 00 00       	call   e90 <printf>
    break;
     246:	83 c4 10             	add    $0x10,%esp
     249:	eb bd                	jmp    208 <runcmd+0x88>
  pid = fork();
     24b:	e8 db 0a 00 00       	call   d2b <fork>
  if(pid == -1)
     250:	83 f8 ff             	cmp    $0xffffffff,%eax
     253:	0f 84 c9 00 00 00    	je     322 <runcmd+0x1a2>
    if(fork1() == 0)
     259:	85 c0                	test   %eax,%eax
     25b:	74 2f                	je     28c <runcmd+0x10c>
    wait();
     25d:	e8 d9 0a 00 00       	call   d3b <wait>
    runcmd(lcmd->right);
     262:	83 ec 0c             	sub    $0xc,%esp
     265:	ff 73 08             	pushl  0x8(%ebx)
     268:	e8 13 ff ff ff       	call   180 <runcmd>
    close(rcmd->fd);
     26d:	83 ec 0c             	sub    $0xc,%esp
     270:	ff 73 14             	pushl  0x14(%ebx)
     273:	e8 e3 0a 00 00       	call   d5b <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     278:	58                   	pop    %eax
     279:	5a                   	pop    %edx
     27a:	ff 73 10             	pushl  0x10(%ebx)
     27d:	ff 73 08             	pushl  0x8(%ebx)
     280:	e8 ee 0a 00 00       	call   d73 <open>
     285:	83 c4 10             	add    $0x10,%esp
     288:	85 c0                	test   %eax,%eax
     28a:	78 18                	js     2a4 <runcmd+0x124>
      runcmd(bcmd->cmd);
     28c:	83 ec 0c             	sub    $0xc,%esp
     28f:	ff 73 04             	pushl  0x4(%ebx)
     292:	e8 e9 fe ff ff       	call   180 <runcmd>
    panic("runcmd");
     297:	83 ec 0c             	sub    $0xc,%esp
     29a:	68 fb 11 00 00       	push   $0x11fb
     29f:	e8 bc fe ff ff       	call   160 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     2a4:	51                   	push   %ecx
     2a5:	ff 73 08             	pushl  0x8(%ebx)
     2a8:	68 12 12 00 00       	push   $0x1212
     2ad:	6a 02                	push   $0x2
     2af:	e8 dc 0b 00 00       	call   e90 <printf>
      exit();
     2b4:	e8 7a 0a 00 00       	call   d33 <exit>
      panic("pipe");
     2b9:	83 ec 0c             	sub    $0xc,%esp
     2bc:	68 27 12 00 00       	push   $0x1227
     2c1:	e8 9a fe ff ff       	call   160 <panic>
      close(1);
     2c6:	83 ec 0c             	sub    $0xc,%esp
     2c9:	6a 01                	push   $0x1
     2cb:	e8 8b 0a 00 00       	call   d5b <close>
      dup(p[1]);
     2d0:	58                   	pop    %eax
     2d1:	ff 75 f4             	pushl  -0xc(%ebp)
     2d4:	e8 d2 0a 00 00       	call   dab <dup>
      close(p[0]);
     2d9:	58                   	pop    %eax
     2da:	ff 75 f0             	pushl  -0x10(%ebp)
     2dd:	e8 79 0a 00 00       	call   d5b <close>
      close(p[1]);
     2e2:	58                   	pop    %eax
     2e3:	ff 75 f4             	pushl  -0xc(%ebp)
     2e6:	e8 70 0a 00 00       	call   d5b <close>
      runcmd(pcmd->left);
     2eb:	5a                   	pop    %edx
     2ec:	ff 73 04             	pushl  0x4(%ebx)
     2ef:	e8 8c fe ff ff       	call   180 <runcmd>
      close(0);
     2f4:	83 ec 0c             	sub    $0xc,%esp
     2f7:	6a 00                	push   $0x0
     2f9:	e8 5d 0a 00 00       	call   d5b <close>
      dup(p[0]);
     2fe:	5a                   	pop    %edx
     2ff:	ff 75 f0             	pushl  -0x10(%ebp)
     302:	e8 a4 0a 00 00       	call   dab <dup>
      close(p[0]);
     307:	59                   	pop    %ecx
     308:	ff 75 f0             	pushl  -0x10(%ebp)
     30b:	e8 4b 0a 00 00       	call   d5b <close>
      close(p[1]);
     310:	58                   	pop    %eax
     311:	ff 75 f4             	pushl  -0xc(%ebp)
     314:	e8 42 0a 00 00       	call   d5b <close>
      runcmd(pcmd->right);
     319:	58                   	pop    %eax
     31a:	ff 73 08             	pushl  0x8(%ebx)
     31d:	e8 5e fe ff ff       	call   180 <runcmd>
    panic("fork");
     322:	83 ec 0c             	sub    $0xc,%esp
     325:	68 22 12 00 00       	push   $0x1222
     32a:	e8 31 fe ff ff       	call   160 <panic>
     32f:	90                   	nop

00000330 <fork1>:
{
     330:	55                   	push   %ebp
     331:	89 e5                	mov    %esp,%ebp
     333:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     336:	e8 f0 09 00 00       	call   d2b <fork>
  if(pid == -1)
     33b:	83 f8 ff             	cmp    $0xffffffff,%eax
     33e:	74 02                	je     342 <fork1+0x12>
  return pid;
}
     340:	c9                   	leave  
     341:	c3                   	ret    
    panic("fork");
     342:	83 ec 0c             	sub    $0xc,%esp
     345:	68 22 12 00 00       	push   $0x1222
     34a:	e8 11 fe ff ff       	call   160 <panic>
     34f:	90                   	nop

00000350 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     350:	55                   	push   %ebp
     351:	89 e5                	mov    %esp,%ebp
     353:	53                   	push   %ebx
     354:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     357:	6a 54                	push   $0x54
     359:	e8 92 0d 00 00       	call   10f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     35e:	83 c4 0c             	add    $0xc,%esp
     361:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     363:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     365:	6a 00                	push   $0x0
     367:	50                   	push   %eax
     368:	e8 23 08 00 00       	call   b90 <memset>
  cmd->type = EXEC;
     36d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     373:	89 d8                	mov    %ebx,%eax
     375:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     378:	c9                   	leave  
     379:	c3                   	ret    
     37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000380 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	53                   	push   %ebx
     384:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     387:	6a 18                	push   $0x18
     389:	e8 62 0d 00 00       	call   10f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     38e:	83 c4 0c             	add    $0xc,%esp
     391:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     393:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     395:	6a 00                	push   $0x0
     397:	50                   	push   %eax
     398:	e8 f3 07 00 00       	call   b90 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     39d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     3a0:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     3a6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     3a9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ac:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     3af:	8b 45 10             	mov    0x10(%ebp),%eax
     3b2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3b5:	8b 45 14             	mov    0x14(%ebp),%eax
     3b8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3bb:	8b 45 18             	mov    0x18(%ebp),%eax
     3be:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3c1:	89 d8                	mov    %ebx,%eax
     3c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3c6:	c9                   	leave  
     3c7:	c3                   	ret    
     3c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     3cf:	90                   	nop

000003d0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3d0:	55                   	push   %ebp
     3d1:	89 e5                	mov    %esp,%ebp
     3d3:	53                   	push   %ebx
     3d4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d7:	6a 0c                	push   $0xc
     3d9:	e8 12 0d 00 00       	call   10f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3de:	83 c4 0c             	add    $0xc,%esp
     3e1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     3e3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3e5:	6a 00                	push   $0x0
     3e7:	50                   	push   %eax
     3e8:	e8 a3 07 00 00       	call   b90 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     3ed:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     3f0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3f6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3f9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3fc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3ff:	89 d8                	mov    %ebx,%eax
     401:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     404:	c9                   	leave  
     405:	c3                   	ret    
     406:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     40d:	8d 76 00             	lea    0x0(%esi),%esi

00000410 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     410:	55                   	push   %ebp
     411:	89 e5                	mov    %esp,%ebp
     413:	53                   	push   %ebx
     414:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     417:	6a 0c                	push   $0xc
     419:	e8 d2 0c 00 00       	call   10f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     41e:	83 c4 0c             	add    $0xc,%esp
     421:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     423:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     425:	6a 00                	push   $0x0
     427:	50                   	push   %eax
     428:	e8 63 07 00 00       	call   b90 <memset>
  cmd->type = LIST;
  cmd->left = left;
     42d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     430:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     436:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     439:	8b 45 0c             	mov    0xc(%ebp),%eax
     43c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     43f:	89 d8                	mov    %ebx,%eax
     441:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     444:	c9                   	leave  
     445:	c3                   	ret    
     446:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     44d:	8d 76 00             	lea    0x0(%esi),%esi

00000450 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	53                   	push   %ebx
     454:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     457:	6a 08                	push   $0x8
     459:	e8 92 0c 00 00       	call   10f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     45e:	83 c4 0c             	add    $0xc,%esp
     461:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     463:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     465:	6a 00                	push   $0x0
     467:	50                   	push   %eax
     468:	e8 23 07 00 00       	call   b90 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     46d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     470:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     476:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     479:	89 d8                	mov    %ebx,%eax
     47b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     47e:	c9                   	leave  
     47f:	c3                   	ret    

00000480 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	57                   	push   %edi
     484:	56                   	push   %esi
     485:	53                   	push   %ebx
     486:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     489:	8b 45 08             	mov    0x8(%ebp),%eax
{
     48c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     48f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     492:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     494:	39 df                	cmp    %ebx,%edi
     496:	72 0f                	jb     4a7 <gettoken+0x27>
     498:	eb 25                	jmp    4bf <gettoken+0x3f>
     49a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     4a0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     4a3:	39 fb                	cmp    %edi,%ebx
     4a5:	74 18                	je     4bf <gettoken+0x3f>
     4a7:	0f be 07             	movsbl (%edi),%eax
     4aa:	83 ec 08             	sub    $0x8,%esp
     4ad:	50                   	push   %eax
     4ae:	68 c0 18 00 00       	push   $0x18c0
     4b3:	e8 f8 06 00 00       	call   bb0 <strchr>
     4b8:	83 c4 10             	add    $0x10,%esp
     4bb:	85 c0                	test   %eax,%eax
     4bd:	75 e1                	jne    4a0 <gettoken+0x20>
  if(q)
     4bf:	85 f6                	test   %esi,%esi
     4c1:	74 02                	je     4c5 <gettoken+0x45>
    *q = s;
     4c3:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     4c5:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     4c8:	3c 3c                	cmp    $0x3c,%al
     4ca:	0f 8f d0 00 00 00    	jg     5a0 <gettoken+0x120>
     4d0:	3c 3a                	cmp    $0x3a,%al
     4d2:	0f 8f b4 00 00 00    	jg     58c <gettoken+0x10c>
     4d8:	84 c0                	test   %al,%al
     4da:	75 44                	jne    520 <gettoken+0xa0>
     4dc:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4de:	8b 55 14             	mov    0x14(%ebp),%edx
     4e1:	85 d2                	test   %edx,%edx
     4e3:	74 05                	je     4ea <gettoken+0x6a>
    *eq = s;
     4e5:	8b 45 14             	mov    0x14(%ebp),%eax
     4e8:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     4ea:	39 df                	cmp    %ebx,%edi
     4ec:	72 09                	jb     4f7 <gettoken+0x77>
     4ee:	eb 1f                	jmp    50f <gettoken+0x8f>
    s++;
     4f0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     4f3:	39 fb                	cmp    %edi,%ebx
     4f5:	74 18                	je     50f <gettoken+0x8f>
     4f7:	0f be 07             	movsbl (%edi),%eax
     4fa:	83 ec 08             	sub    $0x8,%esp
     4fd:	50                   	push   %eax
     4fe:	68 c0 18 00 00       	push   $0x18c0
     503:	e8 a8 06 00 00       	call   bb0 <strchr>
     508:	83 c4 10             	add    $0x10,%esp
     50b:	85 c0                	test   %eax,%eax
     50d:	75 e1                	jne    4f0 <gettoken+0x70>
  *ps = s;
     50f:	8b 45 08             	mov    0x8(%ebp),%eax
     512:	89 38                	mov    %edi,(%eax)
  return ret;
}
     514:	8d 65 f4             	lea    -0xc(%ebp),%esp
     517:	89 f0                	mov    %esi,%eax
     519:	5b                   	pop    %ebx
     51a:	5e                   	pop    %esi
     51b:	5f                   	pop    %edi
     51c:	5d                   	pop    %ebp
     51d:	c3                   	ret    
     51e:	66 90                	xchg   %ax,%ax
  switch(*s){
     520:	79 5e                	jns    580 <gettoken+0x100>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     522:	39 fb                	cmp    %edi,%ebx
     524:	77 34                	ja     55a <gettoken+0xda>
  if(eq)
     526:	8b 45 14             	mov    0x14(%ebp),%eax
     529:	be 61 00 00 00       	mov    $0x61,%esi
     52e:	85 c0                	test   %eax,%eax
     530:	75 b3                	jne    4e5 <gettoken+0x65>
     532:	eb db                	jmp    50f <gettoken+0x8f>
     534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     538:	0f be 07             	movsbl (%edi),%eax
     53b:	83 ec 08             	sub    $0x8,%esp
     53e:	50                   	push   %eax
     53f:	68 b8 18 00 00       	push   $0x18b8
     544:	e8 67 06 00 00       	call   bb0 <strchr>
     549:	83 c4 10             	add    $0x10,%esp
     54c:	85 c0                	test   %eax,%eax
     54e:	75 22                	jne    572 <gettoken+0xf2>
      s++;
     550:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     553:	39 fb                	cmp    %edi,%ebx
     555:	74 cf                	je     526 <gettoken+0xa6>
     557:	0f b6 07             	movzbl (%edi),%eax
     55a:	83 ec 08             	sub    $0x8,%esp
     55d:	0f be f0             	movsbl %al,%esi
     560:	56                   	push   %esi
     561:	68 c0 18 00 00       	push   $0x18c0
     566:	e8 45 06 00 00       	call   bb0 <strchr>
     56b:	83 c4 10             	add    $0x10,%esp
     56e:	85 c0                	test   %eax,%eax
     570:	74 c6                	je     538 <gettoken+0xb8>
    ret = 'a';
     572:	be 61 00 00 00       	mov    $0x61,%esi
     577:	e9 62 ff ff ff       	jmp    4de <gettoken+0x5e>
     57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     580:	3c 26                	cmp    $0x26,%al
     582:	74 08                	je     58c <gettoken+0x10c>
     584:	8d 48 d8             	lea    -0x28(%eax),%ecx
     587:	80 f9 01             	cmp    $0x1,%cl
     58a:	77 96                	ja     522 <gettoken+0xa2>
  ret = *s;
     58c:	0f be f0             	movsbl %al,%esi
    s++;
     58f:	83 c7 01             	add    $0x1,%edi
    break;
     592:	e9 47 ff ff ff       	jmp    4de <gettoken+0x5e>
     597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     59e:	66 90                	xchg   %ax,%ax
  switch(*s){
     5a0:	3c 3e                	cmp    $0x3e,%al
     5a2:	75 1c                	jne    5c0 <gettoken+0x140>
    if(*s == '>'){
     5a4:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
    s++;
     5a8:	8d 47 01             	lea    0x1(%edi),%eax
    if(*s == '>'){
     5ab:	74 1c                	je     5c9 <gettoken+0x149>
    s++;
     5ad:	89 c7                	mov    %eax,%edi
     5af:	be 3e 00 00 00       	mov    $0x3e,%esi
     5b4:	e9 25 ff ff ff       	jmp    4de <gettoken+0x5e>
     5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     5c0:	3c 7c                	cmp    $0x7c,%al
     5c2:	74 c8                	je     58c <gettoken+0x10c>
     5c4:	e9 59 ff ff ff       	jmp    522 <gettoken+0xa2>
      s++;
     5c9:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     5cc:	be 2b 00 00 00       	mov    $0x2b,%esi
     5d1:	e9 08 ff ff ff       	jmp    4de <gettoken+0x5e>
     5d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5dd:	8d 76 00             	lea    0x0(%esi),%esi

000005e0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     5e0:	55                   	push   %ebp
     5e1:	89 e5                	mov    %esp,%ebp
     5e3:	57                   	push   %edi
     5e4:	56                   	push   %esi
     5e5:	53                   	push   %ebx
     5e6:	83 ec 0c             	sub    $0xc,%esp
     5e9:	8b 7d 08             	mov    0x8(%ebp),%edi
     5ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     5ef:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     5f1:	39 f3                	cmp    %esi,%ebx
     5f3:	72 12                	jb     607 <peek+0x27>
     5f5:	eb 28                	jmp    61f <peek+0x3f>
     5f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5fe:	66 90                	xchg   %ax,%ax
    s++;
     600:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     603:	39 de                	cmp    %ebx,%esi
     605:	74 18                	je     61f <peek+0x3f>
     607:	0f be 03             	movsbl (%ebx),%eax
     60a:	83 ec 08             	sub    $0x8,%esp
     60d:	50                   	push   %eax
     60e:	68 c0 18 00 00       	push   $0x18c0
     613:	e8 98 05 00 00       	call   bb0 <strchr>
     618:	83 c4 10             	add    $0x10,%esp
     61b:	85 c0                	test   %eax,%eax
     61d:	75 e1                	jne    600 <peek+0x20>
  *ps = s;
     61f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     621:	0f be 03             	movsbl (%ebx),%eax
     624:	31 d2                	xor    %edx,%edx
     626:	84 c0                	test   %al,%al
     628:	75 0e                	jne    638 <peek+0x58>
}
     62a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     62d:	89 d0                	mov    %edx,%eax
     62f:	5b                   	pop    %ebx
     630:	5e                   	pop    %esi
     631:	5f                   	pop    %edi
     632:	5d                   	pop    %ebp
     633:	c3                   	ret    
     634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     638:	83 ec 08             	sub    $0x8,%esp
     63b:	50                   	push   %eax
     63c:	ff 75 10             	pushl  0x10(%ebp)
     63f:	e8 6c 05 00 00       	call   bb0 <strchr>
     644:	83 c4 10             	add    $0x10,%esp
     647:	31 d2                	xor    %edx,%edx
     649:	85 c0                	test   %eax,%eax
     64b:	0f 95 c2             	setne  %dl
}
     64e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     651:	5b                   	pop    %ebx
     652:	89 d0                	mov    %edx,%eax
     654:	5e                   	pop    %esi
     655:	5f                   	pop    %edi
     656:	5d                   	pop    %ebp
     657:	c3                   	ret    
     658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     65f:	90                   	nop

00000660 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	57                   	push   %edi
     664:	56                   	push   %esi
     665:	53                   	push   %ebx
     666:	83 ec 1c             	sub    $0x1c,%esp
     669:	8b 75 0c             	mov    0xc(%ebp),%esi
     66c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     66f:	90                   	nop
     670:	83 ec 04             	sub    $0x4,%esp
     673:	68 49 12 00 00       	push   $0x1249
     678:	53                   	push   %ebx
     679:	56                   	push   %esi
     67a:	e8 61 ff ff ff       	call   5e0 <peek>
     67f:	83 c4 10             	add    $0x10,%esp
     682:	85 c0                	test   %eax,%eax
     684:	74 6a                	je     6f0 <parseredirs+0x90>
    tok = gettoken(ps, es, 0, 0);
     686:	6a 00                	push   $0x0
     688:	6a 00                	push   $0x0
     68a:	53                   	push   %ebx
     68b:	56                   	push   %esi
     68c:	e8 ef fd ff ff       	call   480 <gettoken>
     691:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     693:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     696:	50                   	push   %eax
     697:	8d 45 e0             	lea    -0x20(%ebp),%eax
     69a:	50                   	push   %eax
     69b:	53                   	push   %ebx
     69c:	56                   	push   %esi
     69d:	e8 de fd ff ff       	call   480 <gettoken>
     6a2:	83 c4 20             	add    $0x20,%esp
     6a5:	83 f8 61             	cmp    $0x61,%eax
     6a8:	75 51                	jne    6fb <parseredirs+0x9b>
      panic("missing file for redirection");
    switch(tok){
     6aa:	83 ff 3c             	cmp    $0x3c,%edi
     6ad:	74 31                	je     6e0 <parseredirs+0x80>
     6af:	83 ff 3e             	cmp    $0x3e,%edi
     6b2:	74 05                	je     6b9 <parseredirs+0x59>
     6b4:	83 ff 2b             	cmp    $0x2b,%edi
     6b7:	75 b7                	jne    670 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6b9:	83 ec 0c             	sub    $0xc,%esp
     6bc:	6a 01                	push   $0x1
     6be:	68 01 02 00 00       	push   $0x201
     6c3:	ff 75 e4             	pushl  -0x1c(%ebp)
     6c6:	ff 75 e0             	pushl  -0x20(%ebp)
     6c9:	ff 75 08             	pushl  0x8(%ebp)
     6cc:	e8 af fc ff ff       	call   380 <redircmd>
      break;
     6d1:	83 c4 20             	add    $0x20,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6d4:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     6d7:	eb 97                	jmp    670 <parseredirs+0x10>
     6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6e0:	83 ec 0c             	sub    $0xc,%esp
     6e3:	6a 00                	push   $0x0
     6e5:	6a 00                	push   $0x0
     6e7:	eb da                	jmp    6c3 <parseredirs+0x63>
     6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  return cmd;
}
     6f0:	8b 45 08             	mov    0x8(%ebp),%eax
     6f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6f6:	5b                   	pop    %ebx
     6f7:	5e                   	pop    %esi
     6f8:	5f                   	pop    %edi
     6f9:	5d                   	pop    %ebp
     6fa:	c3                   	ret    
      panic("missing file for redirection");
     6fb:	83 ec 0c             	sub    $0xc,%esp
     6fe:	68 2c 12 00 00       	push   $0x122c
     703:	e8 58 fa ff ff       	call   160 <panic>
     708:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     70f:	90                   	nop

00000710 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     710:	55                   	push   %ebp
     711:	89 e5                	mov    %esp,%ebp
     713:	57                   	push   %edi
     714:	56                   	push   %esi
     715:	53                   	push   %ebx
     716:	83 ec 30             	sub    $0x30,%esp
     719:	8b 75 08             	mov    0x8(%ebp),%esi
     71c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     71f:	68 4c 12 00 00       	push   $0x124c
     724:	57                   	push   %edi
     725:	56                   	push   %esi
     726:	e8 b5 fe ff ff       	call   5e0 <peek>
     72b:	83 c4 10             	add    $0x10,%esp
     72e:	85 c0                	test   %eax,%eax
     730:	0f 85 92 00 00 00    	jne    7c8 <parseexec+0xb8>
     736:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     738:	e8 13 fc ff ff       	call   350 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     73d:	83 ec 04             	sub    $0x4,%esp
     740:	57                   	push   %edi
     741:	56                   	push   %esi
     742:	50                   	push   %eax
  ret = execcmd();
     743:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = parseredirs(ret, ps, es);
     746:	e8 15 ff ff ff       	call   660 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     74b:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     74e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     751:	eb 18                	jmp    76b <parseexec+0x5b>
     753:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     757:	90                   	nop
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     758:	83 ec 04             	sub    $0x4,%esp
     75b:	57                   	push   %edi
     75c:	56                   	push   %esi
     75d:	ff 75 d4             	pushl  -0x2c(%ebp)
     760:	e8 fb fe ff ff       	call   660 <parseredirs>
     765:	83 c4 10             	add    $0x10,%esp
     768:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     76b:	83 ec 04             	sub    $0x4,%esp
     76e:	68 63 12 00 00       	push   $0x1263
     773:	57                   	push   %edi
     774:	56                   	push   %esi
     775:	e8 66 fe ff ff       	call   5e0 <peek>
     77a:	83 c4 10             	add    $0x10,%esp
     77d:	85 c0                	test   %eax,%eax
     77f:	75 67                	jne    7e8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     781:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     784:	50                   	push   %eax
     785:	8d 45 e0             	lea    -0x20(%ebp),%eax
     788:	50                   	push   %eax
     789:	57                   	push   %edi
     78a:	56                   	push   %esi
     78b:	e8 f0 fc ff ff       	call   480 <gettoken>
     790:	83 c4 10             	add    $0x10,%esp
     793:	85 c0                	test   %eax,%eax
     795:	74 51                	je     7e8 <parseexec+0xd8>
    if(tok != 'a')
     797:	83 f8 61             	cmp    $0x61,%eax
     79a:	75 6b                	jne    807 <parseexec+0xf7>
    cmd->argv[argc] = q;
     79c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     79f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     7a2:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     7a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7a9:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     7ad:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     7b0:	83 fb 0a             	cmp    $0xa,%ebx
     7b3:	75 a3                	jne    758 <parseexec+0x48>
      panic("too many args");
     7b5:	83 ec 0c             	sub    $0xc,%esp
     7b8:	68 55 12 00 00       	push   $0x1255
     7bd:	e8 9e f9 ff ff       	call   160 <panic>
     7c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     7c8:	83 ec 08             	sub    $0x8,%esp
     7cb:	57                   	push   %edi
     7cc:	56                   	push   %esi
     7cd:	e8 5e 01 00 00       	call   930 <parseblock>
     7d2:	83 c4 10             	add    $0x10,%esp
     7d5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7db:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7de:	5b                   	pop    %ebx
     7df:	5e                   	pop    %esi
     7e0:	5f                   	pop    %edi
     7e1:	5d                   	pop    %ebp
     7e2:	c3                   	ret    
     7e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     7e7:	90                   	nop
  cmd->argv[argc] = 0;
     7e8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7eb:	8d 04 98             	lea    (%eax,%ebx,4),%eax
     7ee:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     7f5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     7fc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
     802:	5b                   	pop    %ebx
     803:	5e                   	pop    %esi
     804:	5f                   	pop    %edi
     805:	5d                   	pop    %ebp
     806:	c3                   	ret    
      panic("syntax");
     807:	83 ec 0c             	sub    $0xc,%esp
     80a:	68 4e 12 00 00       	push   $0x124e
     80f:	e8 4c f9 ff ff       	call   160 <panic>
     814:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     81b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     81f:	90                   	nop

00000820 <parsepipe>:
{
     820:	55                   	push   %ebp
     821:	89 e5                	mov    %esp,%ebp
     823:	57                   	push   %edi
     824:	56                   	push   %esi
     825:	53                   	push   %ebx
     826:	83 ec 14             	sub    $0x14,%esp
     829:	8b 75 08             	mov    0x8(%ebp),%esi
     82c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     82f:	57                   	push   %edi
     830:	56                   	push   %esi
     831:	e8 da fe ff ff       	call   710 <parseexec>
  if(peek(ps, es, "|")){
     836:	83 c4 0c             	add    $0xc,%esp
     839:	68 68 12 00 00       	push   $0x1268
  cmd = parseexec(ps, es);
     83e:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     840:	57                   	push   %edi
     841:	56                   	push   %esi
     842:	e8 99 fd ff ff       	call   5e0 <peek>
     847:	83 c4 10             	add    $0x10,%esp
     84a:	85 c0                	test   %eax,%eax
     84c:	75 12                	jne    860 <parsepipe+0x40>
}
     84e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     851:	89 d8                	mov    %ebx,%eax
     853:	5b                   	pop    %ebx
     854:	5e                   	pop    %esi
     855:	5f                   	pop    %edi
     856:	5d                   	pop    %ebp
     857:	c3                   	ret    
     858:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     85f:	90                   	nop
    gettoken(ps, es, 0, 0);
     860:	6a 00                	push   $0x0
     862:	6a 00                	push   $0x0
     864:	57                   	push   %edi
     865:	56                   	push   %esi
     866:	e8 15 fc ff ff       	call   480 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     86b:	58                   	pop    %eax
     86c:	5a                   	pop    %edx
     86d:	57                   	push   %edi
     86e:	56                   	push   %esi
     86f:	e8 ac ff ff ff       	call   820 <parsepipe>
     874:	89 5d 08             	mov    %ebx,0x8(%ebp)
     877:	83 c4 10             	add    $0x10,%esp
     87a:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     87d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     880:	5b                   	pop    %ebx
     881:	5e                   	pop    %esi
     882:	5f                   	pop    %edi
     883:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     884:	e9 47 fb ff ff       	jmp    3d0 <pipecmd>
     889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000890 <parseline>:
{
     890:	55                   	push   %ebp
     891:	89 e5                	mov    %esp,%ebp
     893:	57                   	push   %edi
     894:	56                   	push   %esi
     895:	53                   	push   %ebx
     896:	83 ec 14             	sub    $0x14,%esp
     899:	8b 75 08             	mov    0x8(%ebp),%esi
     89c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     89f:	57                   	push   %edi
     8a0:	56                   	push   %esi
     8a1:	e8 7a ff ff ff       	call   820 <parsepipe>
  while(peek(ps, es, "&")){
     8a6:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     8a9:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     8ab:	eb 1b                	jmp    8c8 <parseline+0x38>
     8ad:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     8b0:	6a 00                	push   $0x0
     8b2:	6a 00                	push   $0x0
     8b4:	57                   	push   %edi
     8b5:	56                   	push   %esi
     8b6:	e8 c5 fb ff ff       	call   480 <gettoken>
    cmd = backcmd(cmd);
     8bb:	89 1c 24             	mov    %ebx,(%esp)
     8be:	e8 8d fb ff ff       	call   450 <backcmd>
     8c3:	83 c4 10             	add    $0x10,%esp
     8c6:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     8c8:	83 ec 04             	sub    $0x4,%esp
     8cb:	68 6a 12 00 00       	push   $0x126a
     8d0:	57                   	push   %edi
     8d1:	56                   	push   %esi
     8d2:	e8 09 fd ff ff       	call   5e0 <peek>
     8d7:	83 c4 10             	add    $0x10,%esp
     8da:	85 c0                	test   %eax,%eax
     8dc:	75 d2                	jne    8b0 <parseline+0x20>
  if(peek(ps, es, ";")){
     8de:	83 ec 04             	sub    $0x4,%esp
     8e1:	68 66 12 00 00       	push   $0x1266
     8e6:	57                   	push   %edi
     8e7:	56                   	push   %esi
     8e8:	e8 f3 fc ff ff       	call   5e0 <peek>
     8ed:	83 c4 10             	add    $0x10,%esp
     8f0:	85 c0                	test   %eax,%eax
     8f2:	75 0c                	jne    900 <parseline+0x70>
}
     8f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8f7:	89 d8                	mov    %ebx,%eax
     8f9:	5b                   	pop    %ebx
     8fa:	5e                   	pop    %esi
     8fb:	5f                   	pop    %edi
     8fc:	5d                   	pop    %ebp
     8fd:	c3                   	ret    
     8fe:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     900:	6a 00                	push   $0x0
     902:	6a 00                	push   $0x0
     904:	57                   	push   %edi
     905:	56                   	push   %esi
     906:	e8 75 fb ff ff       	call   480 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     90b:	58                   	pop    %eax
     90c:	5a                   	pop    %edx
     90d:	57                   	push   %edi
     90e:	56                   	push   %esi
     90f:	e8 7c ff ff ff       	call   890 <parseline>
     914:	89 5d 08             	mov    %ebx,0x8(%ebp)
     917:	83 c4 10             	add    $0x10,%esp
     91a:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     91d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     920:	5b                   	pop    %ebx
     921:	5e                   	pop    %esi
     922:	5f                   	pop    %edi
     923:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     924:	e9 e7 fa ff ff       	jmp    410 <listcmd>
     929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000930 <parseblock>:
{
     930:	55                   	push   %ebp
     931:	89 e5                	mov    %esp,%ebp
     933:	57                   	push   %edi
     934:	56                   	push   %esi
     935:	53                   	push   %ebx
     936:	83 ec 10             	sub    $0x10,%esp
     939:	8b 5d 08             	mov    0x8(%ebp),%ebx
     93c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     93f:	68 4c 12 00 00       	push   $0x124c
     944:	56                   	push   %esi
     945:	53                   	push   %ebx
     946:	e8 95 fc ff ff       	call   5e0 <peek>
     94b:	83 c4 10             	add    $0x10,%esp
     94e:	85 c0                	test   %eax,%eax
     950:	74 4a                	je     99c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     952:	6a 00                	push   $0x0
     954:	6a 00                	push   $0x0
     956:	56                   	push   %esi
     957:	53                   	push   %ebx
     958:	e8 23 fb ff ff       	call   480 <gettoken>
  cmd = parseline(ps, es);
     95d:	58                   	pop    %eax
     95e:	5a                   	pop    %edx
     95f:	56                   	push   %esi
     960:	53                   	push   %ebx
     961:	e8 2a ff ff ff       	call   890 <parseline>
  if(!peek(ps, es, ")"))
     966:	83 c4 0c             	add    $0xc,%esp
     969:	68 88 12 00 00       	push   $0x1288
  cmd = parseline(ps, es);
     96e:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     970:	56                   	push   %esi
     971:	53                   	push   %ebx
     972:	e8 69 fc ff ff       	call   5e0 <peek>
     977:	83 c4 10             	add    $0x10,%esp
     97a:	85 c0                	test   %eax,%eax
     97c:	74 2b                	je     9a9 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     97e:	6a 00                	push   $0x0
     980:	6a 00                	push   $0x0
     982:	56                   	push   %esi
     983:	53                   	push   %ebx
     984:	e8 f7 fa ff ff       	call   480 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     989:	83 c4 0c             	add    $0xc,%esp
     98c:	56                   	push   %esi
     98d:	53                   	push   %ebx
     98e:	57                   	push   %edi
     98f:	e8 cc fc ff ff       	call   660 <parseredirs>
}
     994:	8d 65 f4             	lea    -0xc(%ebp),%esp
     997:	5b                   	pop    %ebx
     998:	5e                   	pop    %esi
     999:	5f                   	pop    %edi
     99a:	5d                   	pop    %ebp
     99b:	c3                   	ret    
    panic("parseblock");
     99c:	83 ec 0c             	sub    $0xc,%esp
     99f:	68 6c 12 00 00       	push   $0x126c
     9a4:	e8 b7 f7 ff ff       	call   160 <panic>
    panic("syntax - missing )");
     9a9:	83 ec 0c             	sub    $0xc,%esp
     9ac:	68 77 12 00 00       	push   $0x1277
     9b1:	e8 aa f7 ff ff       	call   160 <panic>
     9b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     9bd:	8d 76 00             	lea    0x0(%esi),%esi

000009c0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	53                   	push   %ebx
     9c4:	83 ec 04             	sub    $0x4,%esp
     9c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9ca:	85 db                	test   %ebx,%ebx
     9cc:	0f 84 8e 00 00 00    	je     a60 <nulterminate+0xa0>
    return 0;

  switch(cmd->type){
     9d2:	83 3b 05             	cmpl   $0x5,(%ebx)
     9d5:	77 61                	ja     a38 <nulterminate+0x78>
     9d7:	8b 03                	mov    (%ebx),%eax
     9d9:	ff 24 85 c8 12 00 00 	jmp    *0x12c8(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     9e0:	83 ec 0c             	sub    $0xc,%esp
     9e3:	ff 73 04             	pushl  0x4(%ebx)
     9e6:	e8 d5 ff ff ff       	call   9c0 <nulterminate>
    nulterminate(lcmd->right);
     9eb:	58                   	pop    %eax
     9ec:	ff 73 08             	pushl  0x8(%ebx)
     9ef:	e8 cc ff ff ff       	call   9c0 <nulterminate>
    break;
     9f4:	83 c4 10             	add    $0x10,%esp
     9f7:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     9f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9fc:	c9                   	leave  
     9fd:	c3                   	ret    
     9fe:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     a00:	83 ec 0c             	sub    $0xc,%esp
     a03:	ff 73 04             	pushl  0x4(%ebx)
     a06:	e8 b5 ff ff ff       	call   9c0 <nulterminate>
    break;
     a0b:	89 d8                	mov    %ebx,%eax
     a0d:	83 c4 10             	add    $0x10,%esp
}
     a10:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a13:	c9                   	leave  
     a14:	c3                   	ret    
     a15:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     a18:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a1b:	8d 43 08             	lea    0x8(%ebx),%eax
     a1e:	85 c9                	test   %ecx,%ecx
     a20:	74 16                	je     a38 <nulterminate+0x78>
     a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a28:	8b 50 24             	mov    0x24(%eax),%edx
     a2b:	83 c0 04             	add    $0x4,%eax
     a2e:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     a31:	8b 50 fc             	mov    -0x4(%eax),%edx
     a34:	85 d2                	test   %edx,%edx
     a36:	75 f0                	jne    a28 <nulterminate+0x68>
  switch(cmd->type){
     a38:	89 d8                	mov    %ebx,%eax
}
     a3a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a3d:	c9                   	leave  
     a3e:	c3                   	ret    
     a3f:	90                   	nop
    nulterminate(rcmd->cmd);
     a40:	83 ec 0c             	sub    $0xc,%esp
     a43:	ff 73 04             	pushl  0x4(%ebx)
     a46:	e8 75 ff ff ff       	call   9c0 <nulterminate>
    *rcmd->efile = 0;
     a4b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     a4e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     a51:	c6 00 00             	movb   $0x0,(%eax)
    break;
     a54:	89 d8                	mov    %ebx,%eax
}
     a56:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a59:	c9                   	leave  
     a5a:	c3                   	ret    
     a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a5f:	90                   	nop
    return 0;
     a60:	31 c0                	xor    %eax,%eax
     a62:	eb 95                	jmp    9f9 <nulterminate+0x39>
     a64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a6f:	90                   	nop

00000a70 <parsecmd>:
{
     a70:	55                   	push   %ebp
     a71:	89 e5                	mov    %esp,%ebp
     a73:	56                   	push   %esi
     a74:	53                   	push   %ebx
  es = s + strlen(s);
     a75:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a78:	83 ec 0c             	sub    $0xc,%esp
     a7b:	53                   	push   %ebx
     a7c:	e8 df 00 00 00       	call   b60 <strlen>
  cmd = parseline(&s, es);
     a81:	59                   	pop    %ecx
     a82:	5e                   	pop    %esi
  es = s + strlen(s);
     a83:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a85:	8d 45 08             	lea    0x8(%ebp),%eax
     a88:	53                   	push   %ebx
     a89:	50                   	push   %eax
     a8a:	e8 01 fe ff ff       	call   890 <parseline>
  peek(&s, es, "");
     a8f:	83 c4 0c             	add    $0xc,%esp
  cmd = parseline(&s, es);
     a92:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     a94:	8d 45 08             	lea    0x8(%ebp),%eax
     a97:	68 11 12 00 00       	push   $0x1211
     a9c:	53                   	push   %ebx
     a9d:	50                   	push   %eax
     a9e:	e8 3d fb ff ff       	call   5e0 <peek>
  if(s != es){
     aa3:	8b 45 08             	mov    0x8(%ebp),%eax
     aa6:	83 c4 10             	add    $0x10,%esp
     aa9:	39 d8                	cmp    %ebx,%eax
     aab:	75 12                	jne    abf <parsecmd+0x4f>
  nulterminate(cmd);
     aad:	83 ec 0c             	sub    $0xc,%esp
     ab0:	56                   	push   %esi
     ab1:	e8 0a ff ff ff       	call   9c0 <nulterminate>
}
     ab6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ab9:	89 f0                	mov    %esi,%eax
     abb:	5b                   	pop    %ebx
     abc:	5e                   	pop    %esi
     abd:	5d                   	pop    %ebp
     abe:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     abf:	52                   	push   %edx
     ac0:	50                   	push   %eax
     ac1:	68 8a 12 00 00       	push   $0x128a
     ac6:	6a 02                	push   $0x2
     ac8:	e8 c3 03 00 00       	call   e90 <printf>
    panic("syntax");
     acd:	c7 04 24 4e 12 00 00 	movl   $0x124e,(%esp)
     ad4:	e8 87 f6 ff ff       	call   160 <panic>
     ad9:	66 90                	xchg   %ax,%ax
     adb:	66 90                	xchg   %ax,%ax
     add:	66 90                	xchg   %ax,%ax
     adf:	90                   	nop

00000ae0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     ae0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     ae1:	31 c0                	xor    %eax,%eax
{
     ae3:	89 e5                	mov    %esp,%ebp
     ae5:	53                   	push   %ebx
     ae6:	8b 4d 08             	mov    0x8(%ebp),%ecx
     ae9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     af0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     af4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     af7:	83 c0 01             	add    $0x1,%eax
     afa:	84 d2                	test   %dl,%dl
     afc:	75 f2                	jne    af0 <strcpy+0x10>
    ;
  return os;
}
     afe:	89 c8                	mov    %ecx,%eax
     b00:	5b                   	pop    %ebx
     b01:	5d                   	pop    %ebp
     b02:	c3                   	ret    
     b03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000b10 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	53                   	push   %ebx
     b14:	8b 4d 08             	mov    0x8(%ebp),%ecx
     b17:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
     b1a:	0f b6 01             	movzbl (%ecx),%eax
     b1d:	0f b6 1a             	movzbl (%edx),%ebx
     b20:	84 c0                	test   %al,%al
     b22:	75 1d                	jne    b41 <strcmp+0x31>
     b24:	eb 2a                	jmp    b50 <strcmp+0x40>
     b26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b2d:	8d 76 00             	lea    0x0(%esi),%esi
     b30:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
     b34:	83 c1 01             	add    $0x1,%ecx
     b37:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     b3a:	0f b6 1a             	movzbl (%edx),%ebx
     b3d:	84 c0                	test   %al,%al
     b3f:	74 0f                	je     b50 <strcmp+0x40>
     b41:	38 d8                	cmp    %bl,%al
     b43:	74 eb                	je     b30 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     b45:	29 d8                	sub    %ebx,%eax
}
     b47:	5b                   	pop    %ebx
     b48:	5d                   	pop    %ebp
     b49:	c3                   	ret    
     b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b50:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     b52:	29 d8                	sub    %ebx,%eax
}
     b54:	5b                   	pop    %ebx
     b55:	5d                   	pop    %ebp
     b56:	c3                   	ret    
     b57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b5e:	66 90                	xchg   %ax,%ax

00000b60 <strlen>:

uint
strlen(char *s)
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     b66:	80 3a 00             	cmpb   $0x0,(%edx)
     b69:	74 15                	je     b80 <strlen+0x20>
     b6b:	31 c0                	xor    %eax,%eax
     b6d:	8d 76 00             	lea    0x0(%esi),%esi
     b70:	83 c0 01             	add    $0x1,%eax
     b73:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     b77:	89 c1                	mov    %eax,%ecx
     b79:	75 f5                	jne    b70 <strlen+0x10>
    ;
  return n;
}
     b7b:	89 c8                	mov    %ecx,%eax
     b7d:	5d                   	pop    %ebp
     b7e:	c3                   	ret    
     b7f:	90                   	nop
  for(n = 0; s[n]; n++)
     b80:	31 c9                	xor    %ecx,%ecx
}
     b82:	5d                   	pop    %ebp
     b83:	89 c8                	mov    %ecx,%eax
     b85:	c3                   	ret    
     b86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b8d:	8d 76 00             	lea    0x0(%esi),%esi

00000b90 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	57                   	push   %edi
     b94:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b97:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b9a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b9d:	89 d7                	mov    %edx,%edi
     b9f:	fc                   	cld    
     ba0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     ba2:	89 d0                	mov    %edx,%eax
     ba4:	5f                   	pop    %edi
     ba5:	5d                   	pop    %ebp
     ba6:	c3                   	ret    
     ba7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bae:	66 90                	xchg   %ax,%ax

00000bb0 <strchr>:

char*
strchr(const char *s, char c)
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	8b 45 08             	mov    0x8(%ebp),%eax
     bb6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     bba:	0f b6 10             	movzbl (%eax),%edx
     bbd:	84 d2                	test   %dl,%dl
     bbf:	75 12                	jne    bd3 <strchr+0x23>
     bc1:	eb 1d                	jmp    be0 <strchr+0x30>
     bc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bc7:	90                   	nop
     bc8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     bcc:	83 c0 01             	add    $0x1,%eax
     bcf:	84 d2                	test   %dl,%dl
     bd1:	74 0d                	je     be0 <strchr+0x30>
    if(*s == c)
     bd3:	38 d1                	cmp    %dl,%cl
     bd5:	75 f1                	jne    bc8 <strchr+0x18>
      return (char*)s;
  return 0;
}
     bd7:	5d                   	pop    %ebp
     bd8:	c3                   	ret    
     bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     be0:	31 c0                	xor    %eax,%eax
}
     be2:	5d                   	pop    %ebp
     be3:	c3                   	ret    
     be4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     beb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bef:	90                   	nop

00000bf0 <gets>:

char*
gets(char *buf, int max)
{
     bf0:	55                   	push   %ebp
     bf1:	89 e5                	mov    %esp,%ebp
     bf3:	57                   	push   %edi
     bf4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bf5:	31 f6                	xor    %esi,%esi
{
     bf7:	53                   	push   %ebx
     bf8:	89 f3                	mov    %esi,%ebx
     bfa:	83 ec 1c             	sub    $0x1c,%esp
     bfd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     c00:	eb 2f                	jmp    c31 <gets+0x41>
     c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     c08:	83 ec 04             	sub    $0x4,%esp
     c0b:	8d 45 e7             	lea    -0x19(%ebp),%eax
     c0e:	6a 01                	push   $0x1
     c10:	50                   	push   %eax
     c11:	6a 00                	push   $0x0
     c13:	e8 33 01 00 00       	call   d4b <read>
    if(cc < 1)
     c18:	83 c4 10             	add    $0x10,%esp
     c1b:	85 c0                	test   %eax,%eax
     c1d:	7e 1c                	jle    c3b <gets+0x4b>
      break;
    buf[i++] = c;
     c1f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     c23:	83 c7 01             	add    $0x1,%edi
     c26:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     c29:	3c 0a                	cmp    $0xa,%al
     c2b:	74 23                	je     c50 <gets+0x60>
     c2d:	3c 0d                	cmp    $0xd,%al
     c2f:	74 1f                	je     c50 <gets+0x60>
  for(i=0; i+1 < max; ){
     c31:	83 c3 01             	add    $0x1,%ebx
     c34:	89 fe                	mov    %edi,%esi
     c36:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c39:	7c cd                	jl     c08 <gets+0x18>
     c3b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     c40:	c6 03 00             	movb   $0x0,(%ebx)
}
     c43:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c46:	5b                   	pop    %ebx
     c47:	5e                   	pop    %esi
     c48:	5f                   	pop    %edi
     c49:	5d                   	pop    %ebp
     c4a:	c3                   	ret    
     c4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c4f:	90                   	nop
     c50:	8b 75 08             	mov    0x8(%ebp),%esi
     c53:	8b 45 08             	mov    0x8(%ebp),%eax
     c56:	01 de                	add    %ebx,%esi
     c58:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     c5a:	c6 03 00             	movb   $0x0,(%ebx)
}
     c5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c60:	5b                   	pop    %ebx
     c61:	5e                   	pop    %esi
     c62:	5f                   	pop    %edi
     c63:	5d                   	pop    %ebp
     c64:	c3                   	ret    
     c65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c70 <stat>:

int
stat(char *n, struct stat *st)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	56                   	push   %esi
     c74:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c75:	83 ec 08             	sub    $0x8,%esp
     c78:	6a 00                	push   $0x0
     c7a:	ff 75 08             	pushl  0x8(%ebp)
     c7d:	e8 f1 00 00 00       	call   d73 <open>
  if(fd < 0)
     c82:	83 c4 10             	add    $0x10,%esp
     c85:	85 c0                	test   %eax,%eax
     c87:	78 27                	js     cb0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     c89:	83 ec 08             	sub    $0x8,%esp
     c8c:	ff 75 0c             	pushl  0xc(%ebp)
     c8f:	89 c3                	mov    %eax,%ebx
     c91:	50                   	push   %eax
     c92:	e8 f4 00 00 00       	call   d8b <fstat>
  close(fd);
     c97:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     c9a:	89 c6                	mov    %eax,%esi
  close(fd);
     c9c:	e8 ba 00 00 00       	call   d5b <close>
  return r;
     ca1:	83 c4 10             	add    $0x10,%esp
}
     ca4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ca7:	89 f0                	mov    %esi,%eax
     ca9:	5b                   	pop    %ebx
     caa:	5e                   	pop    %esi
     cab:	5d                   	pop    %ebp
     cac:	c3                   	ret    
     cad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     cb0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     cb5:	eb ed                	jmp    ca4 <stat+0x34>
     cb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cbe:	66 90                	xchg   %ax,%ax

00000cc0 <atoi>:

int
atoi(const char *s)
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	53                   	push   %ebx
     cc4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     cc7:	0f be 02             	movsbl (%edx),%eax
     cca:	8d 48 d0             	lea    -0x30(%eax),%ecx
     ccd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     cd0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     cd5:	77 1e                	ja     cf5 <atoi+0x35>
     cd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cde:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     ce0:	83 c2 01             	add    $0x1,%edx
     ce3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     ce6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     cea:	0f be 02             	movsbl (%edx),%eax
     ced:	8d 58 d0             	lea    -0x30(%eax),%ebx
     cf0:	80 fb 09             	cmp    $0x9,%bl
     cf3:	76 eb                	jbe    ce0 <atoi+0x20>
  return n;
}
     cf5:	89 c8                	mov    %ecx,%eax
     cf7:	5b                   	pop    %ebx
     cf8:	5d                   	pop    %ebp
     cf9:	c3                   	ret    
     cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000d00 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	57                   	push   %edi
     d04:	8b 45 10             	mov    0x10(%ebp),%eax
     d07:	8b 55 08             	mov    0x8(%ebp),%edx
     d0a:	56                   	push   %esi
     d0b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     d0e:	85 c0                	test   %eax,%eax
     d10:	7e 13                	jle    d25 <memmove+0x25>
     d12:	01 d0                	add    %edx,%eax
  dst = vdst;
     d14:	89 d7                	mov    %edx,%edi
     d16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d1d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
     d20:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     d21:	39 f8                	cmp    %edi,%eax
     d23:	75 fb                	jne    d20 <memmove+0x20>
  return vdst;
}
     d25:	5e                   	pop    %esi
     d26:	89 d0                	mov    %edx,%eax
     d28:	5f                   	pop    %edi
     d29:	5d                   	pop    %ebp
     d2a:	c3                   	ret    

00000d2b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     d2b:	b8 01 00 00 00       	mov    $0x1,%eax
     d30:	cd 40                	int    $0x40
     d32:	c3                   	ret    

00000d33 <exit>:
SYSCALL(exit)
     d33:	b8 02 00 00 00       	mov    $0x2,%eax
     d38:	cd 40                	int    $0x40
     d3a:	c3                   	ret    

00000d3b <wait>:
SYSCALL(wait)
     d3b:	b8 03 00 00 00       	mov    $0x3,%eax
     d40:	cd 40                	int    $0x40
     d42:	c3                   	ret    

00000d43 <pipe>:
SYSCALL(pipe)
     d43:	b8 04 00 00 00       	mov    $0x4,%eax
     d48:	cd 40                	int    $0x40
     d4a:	c3                   	ret    

00000d4b <read>:
SYSCALL(read)
     d4b:	b8 05 00 00 00       	mov    $0x5,%eax
     d50:	cd 40                	int    $0x40
     d52:	c3                   	ret    

00000d53 <write>:
SYSCALL(write)
     d53:	b8 10 00 00 00       	mov    $0x10,%eax
     d58:	cd 40                	int    $0x40
     d5a:	c3                   	ret    

00000d5b <close>:
SYSCALL(close)
     d5b:	b8 15 00 00 00       	mov    $0x15,%eax
     d60:	cd 40                	int    $0x40
     d62:	c3                   	ret    

00000d63 <kill>:
SYSCALL(kill)
     d63:	b8 06 00 00 00       	mov    $0x6,%eax
     d68:	cd 40                	int    $0x40
     d6a:	c3                   	ret    

00000d6b <exec>:
SYSCALL(exec)
     d6b:	b8 07 00 00 00       	mov    $0x7,%eax
     d70:	cd 40                	int    $0x40
     d72:	c3                   	ret    

00000d73 <open>:
SYSCALL(open)
     d73:	b8 0f 00 00 00       	mov    $0xf,%eax
     d78:	cd 40                	int    $0x40
     d7a:	c3                   	ret    

00000d7b <mknod>:
SYSCALL(mknod)
     d7b:	b8 11 00 00 00       	mov    $0x11,%eax
     d80:	cd 40                	int    $0x40
     d82:	c3                   	ret    

00000d83 <unlink>:
SYSCALL(unlink)
     d83:	b8 12 00 00 00       	mov    $0x12,%eax
     d88:	cd 40                	int    $0x40
     d8a:	c3                   	ret    

00000d8b <fstat>:
SYSCALL(fstat)
     d8b:	b8 08 00 00 00       	mov    $0x8,%eax
     d90:	cd 40                	int    $0x40
     d92:	c3                   	ret    

00000d93 <link>:
SYSCALL(link)
     d93:	b8 13 00 00 00       	mov    $0x13,%eax
     d98:	cd 40                	int    $0x40
     d9a:	c3                   	ret    

00000d9b <mkdir>:
SYSCALL(mkdir)
     d9b:	b8 14 00 00 00       	mov    $0x14,%eax
     da0:	cd 40                	int    $0x40
     da2:	c3                   	ret    

00000da3 <chdir>:
SYSCALL(chdir)
     da3:	b8 09 00 00 00       	mov    $0x9,%eax
     da8:	cd 40                	int    $0x40
     daa:	c3                   	ret    

00000dab <dup>:
SYSCALL(dup)
     dab:	b8 0a 00 00 00       	mov    $0xa,%eax
     db0:	cd 40                	int    $0x40
     db2:	c3                   	ret    

00000db3 <getpid>:
SYSCALL(getpid)
     db3:	b8 0b 00 00 00       	mov    $0xb,%eax
     db8:	cd 40                	int    $0x40
     dba:	c3                   	ret    

00000dbb <sbrk>:
SYSCALL(sbrk)
     dbb:	b8 0c 00 00 00       	mov    $0xc,%eax
     dc0:	cd 40                	int    $0x40
     dc2:	c3                   	ret    

00000dc3 <sleep>:
SYSCALL(sleep)
     dc3:	b8 0d 00 00 00       	mov    $0xd,%eax
     dc8:	cd 40                	int    $0x40
     dca:	c3                   	ret    

00000dcb <uptime>:
SYSCALL(uptime)
     dcb:	b8 0e 00 00 00       	mov    $0xe,%eax
     dd0:	cd 40                	int    $0x40
     dd2:	c3                   	ret    
     dd3:	66 90                	xchg   %ax,%ax
     dd5:	66 90                	xchg   %ax,%ax
     dd7:	66 90                	xchg   %ax,%ax
     dd9:	66 90                	xchg   %ax,%ax
     ddb:	66 90                	xchg   %ax,%ax
     ddd:	66 90                	xchg   %ax,%ax
     ddf:	90                   	nop

00000de0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     de0:	55                   	push   %ebp
     de1:	89 e5                	mov    %esp,%ebp
     de3:	57                   	push   %edi
     de4:	56                   	push   %esi
     de5:	53                   	push   %ebx
     de6:	83 ec 3c             	sub    $0x3c,%esp
     de9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     dec:	89 d1                	mov    %edx,%ecx
{
     dee:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
     df1:	85 d2                	test   %edx,%edx
     df3:	0f 89 7f 00 00 00    	jns    e78 <printint+0x98>
     df9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     dfd:	74 79                	je     e78 <printint+0x98>
    neg = 1;
     dff:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
     e06:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
     e08:	31 db                	xor    %ebx,%ebx
     e0a:	8d 75 d7             	lea    -0x29(%ebp),%esi
     e0d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     e10:	89 c8                	mov    %ecx,%eax
     e12:	31 d2                	xor    %edx,%edx
     e14:	89 cf                	mov    %ecx,%edi
     e16:	f7 75 c4             	divl   -0x3c(%ebp)
     e19:	0f b6 92 e8 12 00 00 	movzbl 0x12e8(%edx),%edx
     e20:	89 45 c0             	mov    %eax,-0x40(%ebp)
     e23:	89 d8                	mov    %ebx,%eax
     e25:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
     e28:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
     e2b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
     e2e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
     e31:	76 dd                	jbe    e10 <printint+0x30>
  if(neg)
     e33:	8b 4d bc             	mov    -0x44(%ebp),%ecx
     e36:	85 c9                	test   %ecx,%ecx
     e38:	74 0c                	je     e46 <printint+0x66>
    buf[i++] = '-';
     e3a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
     e3f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
     e41:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
     e46:	8b 7d b8             	mov    -0x48(%ebp),%edi
     e49:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
     e4d:	eb 07                	jmp    e56 <printint+0x76>
     e4f:	90                   	nop
     e50:	0f b6 13             	movzbl (%ebx),%edx
     e53:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
     e56:	83 ec 04             	sub    $0x4,%esp
     e59:	88 55 d7             	mov    %dl,-0x29(%ebp)
     e5c:	6a 01                	push   $0x1
     e5e:	56                   	push   %esi
     e5f:	57                   	push   %edi
     e60:	e8 ee fe ff ff       	call   d53 <write>
  while(--i >= 0)
     e65:	83 c4 10             	add    $0x10,%esp
     e68:	39 de                	cmp    %ebx,%esi
     e6a:	75 e4                	jne    e50 <printint+0x70>
    putc(fd, buf[i]);
}
     e6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e6f:	5b                   	pop    %ebx
     e70:	5e                   	pop    %esi
     e71:	5f                   	pop    %edi
     e72:	5d                   	pop    %ebp
     e73:	c3                   	ret    
     e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     e78:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
     e7f:	eb 87                	jmp    e08 <printint+0x28>
     e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e8f:	90                   	nop

00000e90 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	57                   	push   %edi
     e94:	56                   	push   %esi
     e95:	53                   	push   %ebx
     e96:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e99:	8b 75 0c             	mov    0xc(%ebp),%esi
     e9c:	0f b6 1e             	movzbl (%esi),%ebx
     e9f:	84 db                	test   %bl,%bl
     ea1:	0f 84 b8 00 00 00    	je     f5f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
     ea7:	8d 45 10             	lea    0x10(%ebp),%eax
     eaa:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
     ead:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
     eb0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
     eb2:	89 45 d0             	mov    %eax,-0x30(%ebp)
     eb5:	eb 37                	jmp    eee <printf+0x5e>
     eb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ebe:	66 90                	xchg   %ax,%ax
     ec0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
     ec3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
     ec8:	83 f8 25             	cmp    $0x25,%eax
     ecb:	74 17                	je     ee4 <printf+0x54>
  write(fd, &c, 1);
     ecd:	83 ec 04             	sub    $0x4,%esp
     ed0:	88 5d e7             	mov    %bl,-0x19(%ebp)
     ed3:	6a 01                	push   $0x1
     ed5:	57                   	push   %edi
     ed6:	ff 75 08             	pushl  0x8(%ebp)
     ed9:	e8 75 fe ff ff       	call   d53 <write>
     ede:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
     ee1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     ee4:	0f b6 1e             	movzbl (%esi),%ebx
     ee7:	83 c6 01             	add    $0x1,%esi
     eea:	84 db                	test   %bl,%bl
     eec:	74 71                	je     f5f <printf+0xcf>
    c = fmt[i] & 0xff;
     eee:	0f be cb             	movsbl %bl,%ecx
     ef1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     ef4:	85 d2                	test   %edx,%edx
     ef6:	74 c8                	je     ec0 <printf+0x30>
      }
    } else if(state == '%'){
     ef8:	83 fa 25             	cmp    $0x25,%edx
     efb:	75 e7                	jne    ee4 <printf+0x54>
      if(c == 'd'){
     efd:	83 f8 64             	cmp    $0x64,%eax
     f00:	0f 84 9a 00 00 00    	je     fa0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     f06:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     f0c:	83 f9 70             	cmp    $0x70,%ecx
     f0f:	74 5f                	je     f70 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     f11:	83 f8 73             	cmp    $0x73,%eax
     f14:	0f 84 d6 00 00 00    	je     ff0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     f1a:	83 f8 63             	cmp    $0x63,%eax
     f1d:	0f 84 8d 00 00 00    	je     fb0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     f23:	83 f8 25             	cmp    $0x25,%eax
     f26:	0f 84 b4 00 00 00    	je     fe0 <printf+0x150>
  write(fd, &c, 1);
     f2c:	83 ec 04             	sub    $0x4,%esp
     f2f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     f33:	6a 01                	push   $0x1
     f35:	57                   	push   %edi
     f36:	ff 75 08             	pushl  0x8(%ebp)
     f39:	e8 15 fe ff ff       	call   d53 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
     f3e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
     f41:	83 c4 0c             	add    $0xc,%esp
     f44:	6a 01                	push   $0x1
     f46:	83 c6 01             	add    $0x1,%esi
     f49:	57                   	push   %edi
     f4a:	ff 75 08             	pushl  0x8(%ebp)
     f4d:	e8 01 fe ff ff       	call   d53 <write>
  for(i = 0; fmt[i]; i++){
     f52:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
     f56:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     f59:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
     f5b:	84 db                	test   %bl,%bl
     f5d:	75 8f                	jne    eee <printf+0x5e>
    }
  }
}
     f5f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f62:	5b                   	pop    %ebx
     f63:	5e                   	pop    %esi
     f64:	5f                   	pop    %edi
     f65:	5d                   	pop    %ebp
     f66:	c3                   	ret    
     f67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f6e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
     f70:	83 ec 0c             	sub    $0xc,%esp
     f73:	b9 10 00 00 00       	mov    $0x10,%ecx
     f78:	6a 00                	push   $0x0
     f7a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     f7d:	8b 45 08             	mov    0x8(%ebp),%eax
     f80:	8b 13                	mov    (%ebx),%edx
     f82:	e8 59 fe ff ff       	call   de0 <printint>
        ap++;
     f87:	89 d8                	mov    %ebx,%eax
     f89:	83 c4 10             	add    $0x10,%esp
      state = 0;
     f8c:	31 d2                	xor    %edx,%edx
        ap++;
     f8e:	83 c0 04             	add    $0x4,%eax
     f91:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f94:	e9 4b ff ff ff       	jmp    ee4 <printf+0x54>
     f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
     fa0:	83 ec 0c             	sub    $0xc,%esp
     fa3:	b9 0a 00 00 00       	mov    $0xa,%ecx
     fa8:	6a 01                	push   $0x1
     faa:	eb ce                	jmp    f7a <printf+0xea>
     fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
     fb0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
     fb3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
     fb6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
     fb8:	6a 01                	push   $0x1
        ap++;
     fba:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
     fbd:	57                   	push   %edi
     fbe:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
     fc1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
     fc4:	e8 8a fd ff ff       	call   d53 <write>
        ap++;
     fc9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
     fcc:	83 c4 10             	add    $0x10,%esp
      state = 0;
     fcf:	31 d2                	xor    %edx,%edx
     fd1:	e9 0e ff ff ff       	jmp    ee4 <printf+0x54>
     fd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fdd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
     fe0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
     fe3:	83 ec 04             	sub    $0x4,%esp
     fe6:	e9 59 ff ff ff       	jmp    f44 <printf+0xb4>
     feb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     fef:	90                   	nop
        s = (char*)*ap;
     ff0:	8b 45 d0             	mov    -0x30(%ebp),%eax
     ff3:	8b 18                	mov    (%eax),%ebx
        ap++;
     ff5:	83 c0 04             	add    $0x4,%eax
     ff8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
     ffb:	85 db                	test   %ebx,%ebx
     ffd:	74 17                	je     1016 <printf+0x186>
        while(*s != 0){
     fff:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1002:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1004:	84 c0                	test   %al,%al
    1006:	0f 84 d8 fe ff ff    	je     ee4 <printf+0x54>
    100c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    100f:	89 de                	mov    %ebx,%esi
    1011:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1014:	eb 1a                	jmp    1030 <printf+0x1a0>
          s = "(null)";
    1016:	bb e0 12 00 00       	mov    $0x12e0,%ebx
        while(*s != 0){
    101b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    101e:	b8 28 00 00 00       	mov    $0x28,%eax
    1023:	89 de                	mov    %ebx,%esi
    1025:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1028:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    102f:	90                   	nop
  write(fd, &c, 1);
    1030:	83 ec 04             	sub    $0x4,%esp
          s++;
    1033:	83 c6 01             	add    $0x1,%esi
    1036:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1039:	6a 01                	push   $0x1
    103b:	57                   	push   %edi
    103c:	53                   	push   %ebx
    103d:	e8 11 fd ff ff       	call   d53 <write>
        while(*s != 0){
    1042:	0f b6 06             	movzbl (%esi),%eax
    1045:	83 c4 10             	add    $0x10,%esp
    1048:	84 c0                	test   %al,%al
    104a:	75 e4                	jne    1030 <printf+0x1a0>
    104c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    104f:	31 d2                	xor    %edx,%edx
    1051:	e9 8e fe ff ff       	jmp    ee4 <printf+0x54>
    1056:	66 90                	xchg   %ax,%ax
    1058:	66 90                	xchg   %ax,%ax
    105a:	66 90                	xchg   %ax,%ax
    105c:	66 90                	xchg   %ax,%ax
    105e:	66 90                	xchg   %ax,%ax

00001060 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1060:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1061:	a1 44 19 00 00       	mov    0x1944,%eax
{
    1066:	89 e5                	mov    %esp,%ebp
    1068:	57                   	push   %edi
    1069:	56                   	push   %esi
    106a:	53                   	push   %ebx
    106b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    106e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
    1070:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1073:	39 c8                	cmp    %ecx,%eax
    1075:	73 19                	jae    1090 <free+0x30>
    1077:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    107e:	66 90                	xchg   %ax,%ax
    1080:	39 d1                	cmp    %edx,%ecx
    1082:	72 14                	jb     1098 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1084:	39 d0                	cmp    %edx,%eax
    1086:	73 10                	jae    1098 <free+0x38>
{
    1088:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    108a:	8b 10                	mov    (%eax),%edx
    108c:	39 c8                	cmp    %ecx,%eax
    108e:	72 f0                	jb     1080 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1090:	39 d0                	cmp    %edx,%eax
    1092:	72 f4                	jb     1088 <free+0x28>
    1094:	39 d1                	cmp    %edx,%ecx
    1096:	73 f0                	jae    1088 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1098:	8b 73 fc             	mov    -0x4(%ebx),%esi
    109b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    109e:	39 fa                	cmp    %edi,%edx
    10a0:	74 1e                	je     10c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    10a2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    10a5:	8b 50 04             	mov    0x4(%eax),%edx
    10a8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    10ab:	39 f1                	cmp    %esi,%ecx
    10ad:	74 28                	je     10d7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    10af:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    10b1:	5b                   	pop    %ebx
  freep = p;
    10b2:	a3 44 19 00 00       	mov    %eax,0x1944
}
    10b7:	5e                   	pop    %esi
    10b8:	5f                   	pop    %edi
    10b9:	5d                   	pop    %ebp
    10ba:	c3                   	ret    
    10bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10bf:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
    10c0:	03 72 04             	add    0x4(%edx),%esi
    10c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    10c6:	8b 10                	mov    (%eax),%edx
    10c8:	8b 12                	mov    (%edx),%edx
    10ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    10cd:	8b 50 04             	mov    0x4(%eax),%edx
    10d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    10d3:	39 f1                	cmp    %esi,%ecx
    10d5:	75 d8                	jne    10af <free+0x4f>
    p->s.size += bp->s.size;
    10d7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    10da:	a3 44 19 00 00       	mov    %eax,0x1944
    p->s.size += bp->s.size;
    10df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    10e2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    10e5:	89 10                	mov    %edx,(%eax)
}
    10e7:	5b                   	pop    %ebx
    10e8:	5e                   	pop    %esi
    10e9:	5f                   	pop    %edi
    10ea:	5d                   	pop    %ebp
    10eb:	c3                   	ret    
    10ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000010f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	57                   	push   %edi
    10f4:	56                   	push   %esi
    10f5:	53                   	push   %ebx
    10f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    10fc:	8b 3d 44 19 00 00    	mov    0x1944,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1102:	8d 70 07             	lea    0x7(%eax),%esi
    1105:	c1 ee 03             	shr    $0x3,%esi
    1108:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    110b:	85 ff                	test   %edi,%edi
    110d:	0f 84 ad 00 00 00    	je     11c0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1113:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1115:	8b 48 04             	mov    0x4(%eax),%ecx
    1118:	39 f1                	cmp    %esi,%ecx
    111a:	73 71                	jae    118d <malloc+0x9d>
    111c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1122:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1127:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    112a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1131:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1134:	eb 1b                	jmp    1151 <malloc+0x61>
    1136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    113d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1140:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1142:	8b 4a 04             	mov    0x4(%edx),%ecx
    1145:	39 f1                	cmp    %esi,%ecx
    1147:	73 4f                	jae    1198 <malloc+0xa8>
    1149:	8b 3d 44 19 00 00    	mov    0x1944,%edi
    114f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1151:	39 c7                	cmp    %eax,%edi
    1153:	75 eb                	jne    1140 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1155:	83 ec 0c             	sub    $0xc,%esp
    1158:	ff 75 e4             	pushl  -0x1c(%ebp)
    115b:	e8 5b fc ff ff       	call   dbb <sbrk>
  if(p == (char*)-1)
    1160:	83 c4 10             	add    $0x10,%esp
    1163:	83 f8 ff             	cmp    $0xffffffff,%eax
    1166:	74 1b                	je     1183 <malloc+0x93>
  hp->s.size = nu;
    1168:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    116b:	83 ec 0c             	sub    $0xc,%esp
    116e:	83 c0 08             	add    $0x8,%eax
    1171:	50                   	push   %eax
    1172:	e8 e9 fe ff ff       	call   1060 <free>
  return freep;
    1177:	a1 44 19 00 00       	mov    0x1944,%eax
      if((p = morecore(nunits)) == 0)
    117c:	83 c4 10             	add    $0x10,%esp
    117f:	85 c0                	test   %eax,%eax
    1181:	75 bd                	jne    1140 <malloc+0x50>
        return 0;
  }
}
    1183:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1186:	31 c0                	xor    %eax,%eax
}
    1188:	5b                   	pop    %ebx
    1189:	5e                   	pop    %esi
    118a:	5f                   	pop    %edi
    118b:	5d                   	pop    %ebp
    118c:	c3                   	ret    
    if(p->s.size >= nunits){
    118d:	89 c2                	mov    %eax,%edx
    118f:	89 f8                	mov    %edi,%eax
    1191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1198:	39 ce                	cmp    %ecx,%esi
    119a:	74 54                	je     11f0 <malloc+0x100>
        p->s.size -= nunits;
    119c:	29 f1                	sub    %esi,%ecx
    119e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    11a1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    11a4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    11a7:	a3 44 19 00 00       	mov    %eax,0x1944
}
    11ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    11af:	8d 42 08             	lea    0x8(%edx),%eax
}
    11b2:	5b                   	pop    %ebx
    11b3:	5e                   	pop    %esi
    11b4:	5f                   	pop    %edi
    11b5:	5d                   	pop    %ebp
    11b6:	c3                   	ret    
    11b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11be:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    11c0:	c7 05 44 19 00 00 48 	movl   $0x1948,0x1944
    11c7:	19 00 00 
    base.s.size = 0;
    11ca:	bf 48 19 00 00       	mov    $0x1948,%edi
    base.s.ptr = freep = prevp = &base;
    11cf:	c7 05 48 19 00 00 48 	movl   $0x1948,0x1948
    11d6:	19 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11d9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    11db:	c7 05 4c 19 00 00 00 	movl   $0x0,0x194c
    11e2:	00 00 00 
    if(p->s.size >= nunits){
    11e5:	e9 32 ff ff ff       	jmp    111c <malloc+0x2c>
    11ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    11f0:	8b 0a                	mov    (%edx),%ecx
    11f2:	89 08                	mov    %ecx,(%eax)
    11f4:	eb b1                	jmp    11a7 <malloc+0xb7>
