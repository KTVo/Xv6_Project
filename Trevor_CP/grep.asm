
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
  1c:	83 f8 01             	cmp    $0x1,%eax
  1f:	7e 6f                	jle    90 <main+0x90>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  21:	8b 43 04             	mov    0x4(%ebx),%eax
  24:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  27:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  2b:	be 02 00 00 00       	mov    $0x2,%esi
  pattern = argv[1];
  30:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
  33:	75 2d                	jne    62 <main+0x62>
  35:	eb 6c                	jmp    a3 <main+0xa3>
  37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  3e:	66 90                	xchg   %ax,%ax
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  40:	83 ec 08             	sub    $0x8,%esp
  for(i = 2; i < argc; i++){
  43:	83 c6 01             	add    $0x1,%esi
  46:	83 c3 04             	add    $0x4,%ebx
    grep(pattern, fd);
  49:	50                   	push   %eax
  4a:	ff 75 e0             	pushl  -0x20(%ebp)
  4d:	e8 ce 01 00 00       	call   220 <grep>
    close(fd);
  52:	89 3c 24             	mov    %edi,(%esp)
  55:	e8 51 05 00 00       	call   5ab <close>
  for(i = 2; i < argc; i++){
  5a:	83 c4 10             	add    $0x10,%esp
  5d:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  60:	7e 29                	jle    8b <main+0x8b>
    if((fd = open(argv[i], 0)) < 0){
  62:	83 ec 08             	sub    $0x8,%esp
  65:	6a 00                	push   $0x0
  67:	ff 33                	pushl  (%ebx)
  69:	e8 55 05 00 00       	call   5c3 <open>
  6e:	83 c4 10             	add    $0x10,%esp
  71:	89 c7                	mov    %eax,%edi
  73:	85 c0                	test   %eax,%eax
  75:	79 c9                	jns    40 <main+0x40>
      printf(1, "grep: cannot open %s\n", argv[i]);
  77:	50                   	push   %eax
  78:	ff 33                	pushl  (%ebx)
  7a:	68 68 0a 00 00       	push   $0xa68
  7f:	6a 01                	push   $0x1
  81:	e8 5a 06 00 00       	call   6e0 <printf>
      exit();
  86:	e8 f8 04 00 00       	call   583 <exit>
  }
  exit();
  8b:	e8 f3 04 00 00       	call   583 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  90:	51                   	push   %ecx
  91:	51                   	push   %ecx
  92:	68 48 0a 00 00       	push   $0xa48
  97:	6a 02                	push   $0x2
  99:	e8 42 06 00 00       	call   6e0 <printf>
    exit();
  9e:	e8 e0 04 00 00       	call   583 <exit>
    grep(pattern, 0);
  a3:	52                   	push   %edx
  a4:	52                   	push   %edx
  a5:	6a 00                	push   $0x0
  a7:	50                   	push   %eax
  a8:	e8 73 01 00 00       	call   220 <grep>
    exit();
  ad:	e8 d1 04 00 00       	call   583 <exit>
  b2:	66 90                	xchg   %ax,%ax
  b4:	66 90                	xchg   %ax,%ax
  b6:	66 90                	xchg   %ax,%ax
  b8:	66 90                	xchg   %ax,%ax
  ba:	66 90                	xchg   %ax,%ax
  bc:	66 90                	xchg   %ax,%ax
  be:	66 90                	xchg   %ax,%ax

000000c0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	56                   	push   %esi
  c5:	53                   	push   %ebx
  c6:	83 ec 0c             	sub    $0xc,%esp
  c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  cf:	8b 7d 10             	mov    0x10(%ebp),%edi
  d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  d8:	83 ec 08             	sub    $0x8,%esp
  db:	57                   	push   %edi
  dc:	56                   	push   %esi
  dd:	e8 3e 00 00 00       	call   120 <matchhere>
  e2:	83 c4 10             	add    $0x10,%esp
  e5:	85 c0                	test   %eax,%eax
  e7:	75 1f                	jne    108 <matchstar+0x48>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  e9:	0f be 17             	movsbl (%edi),%edx
  ec:	84 d2                	test   %dl,%dl
  ee:	74 0c                	je     fc <matchstar+0x3c>
  f0:	83 c7 01             	add    $0x1,%edi
  f3:	39 da                	cmp    %ebx,%edx
  f5:	74 e1                	je     d8 <matchstar+0x18>
  f7:	83 fb 2e             	cmp    $0x2e,%ebx
  fa:	74 dc                	je     d8 <matchstar+0x18>
  return 0;
}
  fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ff:	5b                   	pop    %ebx
 100:	5e                   	pop    %esi
 101:	5f                   	pop    %edi
 102:	5d                   	pop    %ebp
 103:	c3                   	ret    
 104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 108:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 1;
 10b:	b8 01 00 00 00       	mov    $0x1,%eax
}
 110:	5b                   	pop    %ebx
 111:	5e                   	pop    %esi
 112:	5f                   	pop    %edi
 113:	5d                   	pop    %ebp
 114:	c3                   	ret    
 115:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000120 <matchhere>:
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	56                   	push   %esi
 125:	53                   	push   %ebx
 126:	83 ec 0c             	sub    $0xc,%esp
 129:	8b 4d 08             	mov    0x8(%ebp),%ecx
 12c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(re[0] == '\0')
 12f:	0f b6 01             	movzbl (%ecx),%eax
 132:	84 c0                	test   %al,%al
 134:	75 2f                	jne    165 <matchhere+0x45>
 136:	eb 68                	jmp    1a0 <matchhere+0x80>
 138:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13f:	90                   	nop
  if(re[0] == '$' && re[1] == '\0')
 140:	0f b6 37             	movzbl (%edi),%esi
 143:	80 fa 24             	cmp    $0x24,%dl
 146:	75 04                	jne    14c <matchhere+0x2c>
 148:	84 c0                	test   %al,%al
 14a:	74 61                	je     1ad <matchhere+0x8d>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 14c:	89 f3                	mov    %esi,%ebx
 14e:	84 db                	test   %bl,%bl
 150:	74 3e                	je     190 <matchhere+0x70>
 152:	80 fa 2e             	cmp    $0x2e,%dl
 155:	74 04                	je     15b <matchhere+0x3b>
 157:	38 d3                	cmp    %dl,%bl
 159:	75 35                	jne    190 <matchhere+0x70>
    return matchhere(re+1, text+1);
 15b:	83 c7 01             	add    $0x1,%edi
 15e:	83 c1 01             	add    $0x1,%ecx
  if(re[0] == '\0')
 161:	84 c0                	test   %al,%al
 163:	74 3b                	je     1a0 <matchhere+0x80>
  if(re[1] == '*')
 165:	0f be d0             	movsbl %al,%edx
 168:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
 16c:	3c 2a                	cmp    $0x2a,%al
 16e:	75 d0                	jne    140 <matchhere+0x20>
    return matchstar(re[0], re+2, text);
 170:	83 ec 04             	sub    $0x4,%esp
 173:	83 c1 02             	add    $0x2,%ecx
 176:	57                   	push   %edi
 177:	51                   	push   %ecx
 178:	52                   	push   %edx
 179:	e8 42 ff ff ff       	call   c0 <matchstar>
 17e:	83 c4 10             	add    $0x10,%esp
}
 181:	8d 65 f4             	lea    -0xc(%ebp),%esp
 184:	5b                   	pop    %ebx
 185:	5e                   	pop    %esi
 186:	5f                   	pop    %edi
 187:	5d                   	pop    %ebp
 188:	c3                   	ret    
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 190:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
 193:	31 c0                	xor    %eax,%eax
}
 195:	5b                   	pop    %ebx
 196:	5e                   	pop    %esi
 197:	5f                   	pop    %edi
 198:	5d                   	pop    %ebp
 199:	c3                   	ret    
 19a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 1;
 1a3:	b8 01 00 00 00       	mov    $0x1,%eax
}
 1a8:	5b                   	pop    %ebx
 1a9:	5e                   	pop    %esi
 1aa:	5f                   	pop    %edi
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
    return *text == '\0';
 1ad:	89 f0                	mov    %esi,%eax
 1af:	84 c0                	test   %al,%al
 1b1:	0f 94 c0             	sete   %al
 1b4:	0f b6 c0             	movzbl %al,%eax
 1b7:	eb c8                	jmp    181 <matchhere+0x61>
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001c0 <match>:
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	53                   	push   %ebx
 1c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(re[0] == '^')
 1cb:	80 3b 5e             	cmpb   $0x5e,(%ebx)
 1ce:	75 11                	jne    1e1 <match+0x21>
 1d0:	eb 2e                	jmp    200 <match+0x40>
 1d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1d8:	83 c6 01             	add    $0x1,%esi
 1db:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
 1df:	74 16                	je     1f7 <match+0x37>
    if(matchhere(re, text))
 1e1:	83 ec 08             	sub    $0x8,%esp
 1e4:	56                   	push   %esi
 1e5:	53                   	push   %ebx
 1e6:	e8 35 ff ff ff       	call   120 <matchhere>
 1eb:	83 c4 10             	add    $0x10,%esp
 1ee:	85 c0                	test   %eax,%eax
 1f0:	74 e6                	je     1d8 <match+0x18>
      return 1;
 1f2:	b8 01 00 00 00       	mov    $0x1,%eax
}
 1f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1fa:	5b                   	pop    %ebx
 1fb:	5e                   	pop    %esi
 1fc:	5d                   	pop    %ebp
 1fd:	c3                   	ret    
 1fe:	66 90                	xchg   %ax,%ax
    return matchhere(re+1, text);
 200:	83 c3 01             	add    $0x1,%ebx
 203:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 206:	8d 65 f8             	lea    -0x8(%ebp),%esp
 209:	5b                   	pop    %ebx
 20a:	5e                   	pop    %esi
 20b:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 20c:	e9 0f ff ff ff       	jmp    120 <matchhere>
 211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 218:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21f:	90                   	nop

00000220 <grep>:
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	53                   	push   %ebx
 226:	83 ec 1c             	sub    $0x1c,%esp
  m = 0;
 229:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
{
 230:	8b 75 08             	mov    0x8(%ebp),%esi
 233:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 237:	90                   	nop
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 238:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 23b:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 240:	83 ec 04             	sub    $0x4,%esp
 243:	29 c8                	sub    %ecx,%eax
 245:	50                   	push   %eax
 246:	8d 81 60 0e 00 00    	lea    0xe60(%ecx),%eax
 24c:	50                   	push   %eax
 24d:	ff 75 0c             	pushl  0xc(%ebp)
 250:	e8 46 03 00 00       	call   59b <read>
 255:	83 c4 10             	add    $0x10,%esp
 258:	85 c0                	test   %eax,%eax
 25a:	0f 8e c0 00 00 00    	jle    320 <grep+0x100>
    m += n;
 260:	01 45 e4             	add    %eax,-0x1c(%ebp)
 263:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p = buf;
 266:	bb 60 0e 00 00       	mov    $0xe60,%ebx
    buf[m] = '\0';
 26b:	c6 81 60 0e 00 00 00 	movb   $0x0,0xe60(%ecx)
    while((q = strchr(p, '\n')) != 0){
 272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 278:	83 ec 08             	sub    $0x8,%esp
 27b:	6a 0a                	push   $0xa
 27d:	53                   	push   %ebx
 27e:	e8 7d 01 00 00       	call   400 <strchr>
 283:	83 c4 10             	add    $0x10,%esp
 286:	89 c7                	mov    %eax,%edi
 288:	85 c0                	test   %eax,%eax
 28a:	74 44                	je     2d0 <grep+0xb0>
      if(match(pattern, p)){
 28c:	83 ec 08             	sub    $0x8,%esp
      *q = 0;
 28f:	c6 07 00             	movb   $0x0,(%edi)
      if(match(pattern, p)){
 292:	53                   	push   %ebx
 293:	56                   	push   %esi
 294:	e8 27 ff ff ff       	call   1c0 <match>
 299:	83 c4 10             	add    $0x10,%esp
 29c:	8d 57 01             	lea    0x1(%edi),%edx
 29f:	85 c0                	test   %eax,%eax
 2a1:	75 0d                	jne    2b0 <grep+0x90>
      p = q+1;
 2a3:	89 d3                	mov    %edx,%ebx
 2a5:	eb d1                	jmp    278 <grep+0x58>
 2a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ae:	66 90                	xchg   %ax,%ax
        write(1, p, q+1 - p);
 2b0:	89 d0                	mov    %edx,%eax
 2b2:	83 ec 04             	sub    $0x4,%esp
        *q = '\n';
 2b5:	c6 07 0a             	movb   $0xa,(%edi)
        write(1, p, q+1 - p);
 2b8:	29 d8                	sub    %ebx,%eax
 2ba:	89 55 e0             	mov    %edx,-0x20(%ebp)
 2bd:	50                   	push   %eax
 2be:	53                   	push   %ebx
 2bf:	6a 01                	push   $0x1
 2c1:	e8 dd 02 00 00       	call   5a3 <write>
 2c6:	8b 55 e0             	mov    -0x20(%ebp),%edx
 2c9:	83 c4 10             	add    $0x10,%esp
      p = q+1;
 2cc:	89 d3                	mov    %edx,%ebx
 2ce:	eb a8                	jmp    278 <grep+0x58>
    if(p == buf)
 2d0:	81 fb 60 0e 00 00    	cmp    $0xe60,%ebx
 2d6:	74 38                	je     310 <grep+0xf0>
    if(m > 0){
 2d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 2db:	85 c9                	test   %ecx,%ecx
 2dd:	0f 8e 55 ff ff ff    	jle    238 <grep+0x18>
      m -= p - buf;
 2e3:	89 d8                	mov    %ebx,%eax
      memmove(buf, p, m);
 2e5:	83 ec 04             	sub    $0x4,%esp
      m -= p - buf;
 2e8:	2d 60 0e 00 00       	sub    $0xe60,%eax
 2ed:	29 c1                	sub    %eax,%ecx
      memmove(buf, p, m);
 2ef:	51                   	push   %ecx
 2f0:	53                   	push   %ebx
 2f1:	68 60 0e 00 00       	push   $0xe60
      m -= p - buf;
 2f6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      memmove(buf, p, m);
 2f9:	e8 52 02 00 00       	call   550 <memmove>
 2fe:	83 c4 10             	add    $0x10,%esp
 301:	e9 32 ff ff ff       	jmp    238 <grep+0x18>
 306:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 30d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 0;
 310:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 317:	e9 1c ff ff ff       	jmp    238 <grep+0x18>
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
 320:	8d 65 f4             	lea    -0xc(%ebp),%esp
 323:	5b                   	pop    %ebx
 324:	5e                   	pop    %esi
 325:	5f                   	pop    %edi
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	66 90                	xchg   %ax,%ax
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 330:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 331:	31 c0                	xor    %eax,%eax
{
 333:	89 e5                	mov    %esp,%ebp
 335:	53                   	push   %ebx
 336:	8b 4d 08             	mov    0x8(%ebp),%ecx
 339:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 340:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 344:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 347:	83 c0 01             	add    $0x1,%eax
 34a:	84 d2                	test   %dl,%dl
 34c:	75 f2                	jne    340 <strcpy+0x10>
    ;
  return os;
}
 34e:	89 c8                	mov    %ecx,%eax
 350:	5b                   	pop    %ebx
 351:	5d                   	pop    %ebp
 352:	c3                   	ret    
 353:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000360 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 4d 08             	mov    0x8(%ebp),%ecx
 367:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 36a:	0f b6 01             	movzbl (%ecx),%eax
 36d:	0f b6 1a             	movzbl (%edx),%ebx
 370:	84 c0                	test   %al,%al
 372:	75 1d                	jne    391 <strcmp+0x31>
 374:	eb 2a                	jmp    3a0 <strcmp+0x40>
 376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 37d:	8d 76 00             	lea    0x0(%esi),%esi
 380:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 384:	83 c1 01             	add    $0x1,%ecx
 387:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 38a:	0f b6 1a             	movzbl (%edx),%ebx
 38d:	84 c0                	test   %al,%al
 38f:	74 0f                	je     3a0 <strcmp+0x40>
 391:	38 d8                	cmp    %bl,%al
 393:	74 eb                	je     380 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 395:	29 d8                	sub    %ebx,%eax
}
 397:	5b                   	pop    %ebx
 398:	5d                   	pop    %ebp
 399:	c3                   	ret    
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3a2:	29 d8                	sub    %ebx,%eax
}
 3a4:	5b                   	pop    %ebx
 3a5:	5d                   	pop    %ebp
 3a6:	c3                   	ret    
 3a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ae:	66 90                	xchg   %ax,%ax

000003b0 <strlen>:

uint
strlen(char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 3b6:	80 3a 00             	cmpb   $0x0,(%edx)
 3b9:	74 15                	je     3d0 <strlen+0x20>
 3bb:	31 c0                	xor    %eax,%eax
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
 3c0:	83 c0 01             	add    $0x1,%eax
 3c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 3c7:	89 c1                	mov    %eax,%ecx
 3c9:	75 f5                	jne    3c0 <strlen+0x10>
    ;
  return n;
}
 3cb:	89 c8                	mov    %ecx,%eax
 3cd:	5d                   	pop    %ebp
 3ce:	c3                   	ret    
 3cf:	90                   	nop
  for(n = 0; s[n]; n++)
 3d0:	31 c9                	xor    %ecx,%ecx
}
 3d2:	5d                   	pop    %ebp
 3d3:	89 c8                	mov    %ecx,%eax
 3d5:	c3                   	ret    
 3d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3dd:	8d 76 00             	lea    0x0(%esi),%esi

000003e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ed:	89 d7                	mov    %edx,%edi
 3ef:	fc                   	cld    
 3f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3f2:	89 d0                	mov    %edx,%eax
 3f4:	5f                   	pop    %edi
 3f5:	5d                   	pop    %ebp
 3f6:	c3                   	ret    
 3f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3fe:	66 90                	xchg   %ax,%ax

00000400 <strchr>:

char*
strchr(const char *s, char c)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	8b 45 08             	mov    0x8(%ebp),%eax
 406:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 40a:	0f b6 10             	movzbl (%eax),%edx
 40d:	84 d2                	test   %dl,%dl
 40f:	75 12                	jne    423 <strchr+0x23>
 411:	eb 1d                	jmp    430 <strchr+0x30>
 413:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 417:	90                   	nop
 418:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 41c:	83 c0 01             	add    $0x1,%eax
 41f:	84 d2                	test   %dl,%dl
 421:	74 0d                	je     430 <strchr+0x30>
    if(*s == c)
 423:	38 d1                	cmp    %dl,%cl
 425:	75 f1                	jne    418 <strchr+0x18>
      return (char*)s;
  return 0;
}
 427:	5d                   	pop    %ebp
 428:	c3                   	ret    
 429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 430:	31 c0                	xor    %eax,%eax
}
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
 434:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 43f:	90                   	nop

00000440 <gets>:

char*
gets(char *buf, int max)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 445:	31 f6                	xor    %esi,%esi
{
 447:	53                   	push   %ebx
 448:	89 f3                	mov    %esi,%ebx
 44a:	83 ec 1c             	sub    $0x1c,%esp
 44d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 450:	eb 2f                	jmp    481 <gets+0x41>
 452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 458:	83 ec 04             	sub    $0x4,%esp
 45b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 45e:	6a 01                	push   $0x1
 460:	50                   	push   %eax
 461:	6a 00                	push   $0x0
 463:	e8 33 01 00 00       	call   59b <read>
    if(cc < 1)
 468:	83 c4 10             	add    $0x10,%esp
 46b:	85 c0                	test   %eax,%eax
 46d:	7e 1c                	jle    48b <gets+0x4b>
      break;
    buf[i++] = c;
 46f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 473:	83 c7 01             	add    $0x1,%edi
 476:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 479:	3c 0a                	cmp    $0xa,%al
 47b:	74 23                	je     4a0 <gets+0x60>
 47d:	3c 0d                	cmp    $0xd,%al
 47f:	74 1f                	je     4a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 481:	83 c3 01             	add    $0x1,%ebx
 484:	89 fe                	mov    %edi,%esi
 486:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 489:	7c cd                	jl     458 <gets+0x18>
 48b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 48d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 490:	c6 03 00             	movb   $0x0,(%ebx)
}
 493:	8d 65 f4             	lea    -0xc(%ebp),%esp
 496:	5b                   	pop    %ebx
 497:	5e                   	pop    %esi
 498:	5f                   	pop    %edi
 499:	5d                   	pop    %ebp
 49a:	c3                   	ret    
 49b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 49f:	90                   	nop
 4a0:	8b 75 08             	mov    0x8(%ebp),%esi
 4a3:	8b 45 08             	mov    0x8(%ebp),%eax
 4a6:	01 de                	add    %ebx,%esi
 4a8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 4aa:	c6 03 00             	movb   $0x0,(%ebx)
}
 4ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b0:	5b                   	pop    %ebx
 4b1:	5e                   	pop    %esi
 4b2:	5f                   	pop    %edi
 4b3:	5d                   	pop    %ebp
 4b4:	c3                   	ret    
 4b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004c0 <stat>:

int
stat(char *n, struct stat *st)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	56                   	push   %esi
 4c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c5:	83 ec 08             	sub    $0x8,%esp
 4c8:	6a 00                	push   $0x0
 4ca:	ff 75 08             	pushl  0x8(%ebp)
 4cd:	e8 f1 00 00 00       	call   5c3 <open>
  if(fd < 0)
 4d2:	83 c4 10             	add    $0x10,%esp
 4d5:	85 c0                	test   %eax,%eax
 4d7:	78 27                	js     500 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4d9:	83 ec 08             	sub    $0x8,%esp
 4dc:	ff 75 0c             	pushl  0xc(%ebp)
 4df:	89 c3                	mov    %eax,%ebx
 4e1:	50                   	push   %eax
 4e2:	e8 f4 00 00 00       	call   5db <fstat>
  close(fd);
 4e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4ea:	89 c6                	mov    %eax,%esi
  close(fd);
 4ec:	e8 ba 00 00 00       	call   5ab <close>
  return r;
 4f1:	83 c4 10             	add    $0x10,%esp
}
 4f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4f7:	89 f0                	mov    %esi,%eax
 4f9:	5b                   	pop    %ebx
 4fa:	5e                   	pop    %esi
 4fb:	5d                   	pop    %ebp
 4fc:	c3                   	ret    
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 500:	be ff ff ff ff       	mov    $0xffffffff,%esi
 505:	eb ed                	jmp    4f4 <stat+0x34>
 507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50e:	66 90                	xchg   %ax,%ax

00000510 <atoi>:

int
atoi(const char *s)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	53                   	push   %ebx
 514:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 517:	0f be 02             	movsbl (%edx),%eax
 51a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 51d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 520:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 525:	77 1e                	ja     545 <atoi+0x35>
 527:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 530:	83 c2 01             	add    $0x1,%edx
 533:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 536:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 53a:	0f be 02             	movsbl (%edx),%eax
 53d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 540:	80 fb 09             	cmp    $0x9,%bl
 543:	76 eb                	jbe    530 <atoi+0x20>
  return n;
}
 545:	89 c8                	mov    %ecx,%eax
 547:	5b                   	pop    %ebx
 548:	5d                   	pop    %ebp
 549:	c3                   	ret    
 54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000550 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	57                   	push   %edi
 554:	8b 45 10             	mov    0x10(%ebp),%eax
 557:	8b 55 08             	mov    0x8(%ebp),%edx
 55a:	56                   	push   %esi
 55b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 55e:	85 c0                	test   %eax,%eax
 560:	7e 13                	jle    575 <memmove+0x25>
 562:	01 d0                	add    %edx,%eax
  dst = vdst;
 564:	89 d7                	mov    %edx,%edi
 566:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 570:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 571:	39 f8                	cmp    %edi,%eax
 573:	75 fb                	jne    570 <memmove+0x20>
  return vdst;
}
 575:	5e                   	pop    %esi
 576:	89 d0                	mov    %edx,%eax
 578:	5f                   	pop    %edi
 579:	5d                   	pop    %ebp
 57a:	c3                   	ret    

0000057b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 57b:	b8 01 00 00 00       	mov    $0x1,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    

00000583 <exit>:
SYSCALL(exit)
 583:	b8 02 00 00 00       	mov    $0x2,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret    

0000058b <wait>:
SYSCALL(wait)
 58b:	b8 03 00 00 00       	mov    $0x3,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret    

00000593 <pipe>:
SYSCALL(pipe)
 593:	b8 04 00 00 00       	mov    $0x4,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret    

0000059b <read>:
SYSCALL(read)
 59b:	b8 05 00 00 00       	mov    $0x5,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret    

000005a3 <write>:
SYSCALL(write)
 5a3:	b8 10 00 00 00       	mov    $0x10,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret    

000005ab <close>:
SYSCALL(close)
 5ab:	b8 15 00 00 00       	mov    $0x15,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <kill>:
SYSCALL(kill)
 5b3:	b8 06 00 00 00       	mov    $0x6,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <exec>:
SYSCALL(exec)
 5bb:	b8 07 00 00 00       	mov    $0x7,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <open>:
SYSCALL(open)
 5c3:	b8 0f 00 00 00       	mov    $0xf,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <mknod>:
SYSCALL(mknod)
 5cb:	b8 11 00 00 00       	mov    $0x11,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <unlink>:
SYSCALL(unlink)
 5d3:	b8 12 00 00 00       	mov    $0x12,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <fstat>:
SYSCALL(fstat)
 5db:	b8 08 00 00 00       	mov    $0x8,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <link>:
SYSCALL(link)
 5e3:	b8 13 00 00 00       	mov    $0x13,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <mkdir>:
SYSCALL(mkdir)
 5eb:	b8 14 00 00 00       	mov    $0x14,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <chdir>:
SYSCALL(chdir)
 5f3:	b8 09 00 00 00       	mov    $0x9,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <dup>:
SYSCALL(dup)
 5fb:	b8 0a 00 00 00       	mov    $0xa,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <getpid>:
SYSCALL(getpid)
 603:	b8 0b 00 00 00       	mov    $0xb,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <sbrk>:
SYSCALL(sbrk)
 60b:	b8 0c 00 00 00       	mov    $0xc,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <sleep>:
SYSCALL(sleep)
 613:	b8 0d 00 00 00       	mov    $0xd,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <uptime>:
SYSCALL(uptime)
 61b:	b8 0e 00 00 00       	mov    $0xe,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    
 623:	66 90                	xchg   %ax,%ax
 625:	66 90                	xchg   %ax,%ax
 627:	66 90                	xchg   %ax,%ax
 629:	66 90                	xchg   %ax,%ax
 62b:	66 90                	xchg   %ax,%ax
 62d:	66 90                	xchg   %ax,%ax
 62f:	90                   	nop

00000630 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	53                   	push   %ebx
 636:	83 ec 3c             	sub    $0x3c,%esp
 639:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 63c:	89 d1                	mov    %edx,%ecx
{
 63e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 641:	85 d2                	test   %edx,%edx
 643:	0f 89 7f 00 00 00    	jns    6c8 <printint+0x98>
 649:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 64d:	74 79                	je     6c8 <printint+0x98>
    neg = 1;
 64f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 656:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 658:	31 db                	xor    %ebx,%ebx
 65a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 65d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 660:	89 c8                	mov    %ecx,%eax
 662:	31 d2                	xor    %edx,%edx
 664:	89 cf                	mov    %ecx,%edi
 666:	f7 75 c4             	divl   -0x3c(%ebp)
 669:	0f b6 92 88 0a 00 00 	movzbl 0xa88(%edx),%edx
 670:	89 45 c0             	mov    %eax,-0x40(%ebp)
 673:	89 d8                	mov    %ebx,%eax
 675:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 678:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 67b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 67e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 681:	76 dd                	jbe    660 <printint+0x30>
  if(neg)
 683:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 686:	85 c9                	test   %ecx,%ecx
 688:	74 0c                	je     696 <printint+0x66>
    buf[i++] = '-';
 68a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 68f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 691:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 696:	8b 7d b8             	mov    -0x48(%ebp),%edi
 699:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 69d:	eb 07                	jmp    6a6 <printint+0x76>
 69f:	90                   	nop
 6a0:	0f b6 13             	movzbl (%ebx),%edx
 6a3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 6a6:	83 ec 04             	sub    $0x4,%esp
 6a9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 6ac:	6a 01                	push   $0x1
 6ae:	56                   	push   %esi
 6af:	57                   	push   %edi
 6b0:	e8 ee fe ff ff       	call   5a3 <write>
  while(--i >= 0)
 6b5:	83 c4 10             	add    $0x10,%esp
 6b8:	39 de                	cmp    %ebx,%esi
 6ba:	75 e4                	jne    6a0 <printint+0x70>
    putc(fd, buf[i]);
}
 6bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6bf:	5b                   	pop    %ebx
 6c0:	5e                   	pop    %esi
 6c1:	5f                   	pop    %edi
 6c2:	5d                   	pop    %ebp
 6c3:	c3                   	ret    
 6c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 6c8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 6cf:	eb 87                	jmp    658 <printint+0x28>
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop

000006e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e9:	8b 75 0c             	mov    0xc(%ebp),%esi
 6ec:	0f b6 1e             	movzbl (%esi),%ebx
 6ef:	84 db                	test   %bl,%bl
 6f1:	0f 84 b8 00 00 00    	je     7af <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 6f7:	8d 45 10             	lea    0x10(%ebp),%eax
 6fa:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 6fd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 700:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 702:	89 45 d0             	mov    %eax,-0x30(%ebp)
 705:	eb 37                	jmp    73e <printf+0x5e>
 707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 70e:	66 90                	xchg   %ax,%ax
 710:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 713:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 718:	83 f8 25             	cmp    $0x25,%eax
 71b:	74 17                	je     734 <printf+0x54>
  write(fd, &c, 1);
 71d:	83 ec 04             	sub    $0x4,%esp
 720:	88 5d e7             	mov    %bl,-0x19(%ebp)
 723:	6a 01                	push   $0x1
 725:	57                   	push   %edi
 726:	ff 75 08             	pushl  0x8(%ebp)
 729:	e8 75 fe ff ff       	call   5a3 <write>
 72e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 731:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 734:	0f b6 1e             	movzbl (%esi),%ebx
 737:	83 c6 01             	add    $0x1,%esi
 73a:	84 db                	test   %bl,%bl
 73c:	74 71                	je     7af <printf+0xcf>
    c = fmt[i] & 0xff;
 73e:	0f be cb             	movsbl %bl,%ecx
 741:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 744:	85 d2                	test   %edx,%edx
 746:	74 c8                	je     710 <printf+0x30>
      }
    } else if(state == '%'){
 748:	83 fa 25             	cmp    $0x25,%edx
 74b:	75 e7                	jne    734 <printf+0x54>
      if(c == 'd'){
 74d:	83 f8 64             	cmp    $0x64,%eax
 750:	0f 84 9a 00 00 00    	je     7f0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 756:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 75c:	83 f9 70             	cmp    $0x70,%ecx
 75f:	74 5f                	je     7c0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 761:	83 f8 73             	cmp    $0x73,%eax
 764:	0f 84 d6 00 00 00    	je     840 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 76a:	83 f8 63             	cmp    $0x63,%eax
 76d:	0f 84 8d 00 00 00    	je     800 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 773:	83 f8 25             	cmp    $0x25,%eax
 776:	0f 84 b4 00 00 00    	je     830 <printf+0x150>
  write(fd, &c, 1);
 77c:	83 ec 04             	sub    $0x4,%esp
 77f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 783:	6a 01                	push   $0x1
 785:	57                   	push   %edi
 786:	ff 75 08             	pushl  0x8(%ebp)
 789:	e8 15 fe ff ff       	call   5a3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 78e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 791:	83 c4 0c             	add    $0xc,%esp
 794:	6a 01                	push   $0x1
 796:	83 c6 01             	add    $0x1,%esi
 799:	57                   	push   %edi
 79a:	ff 75 08             	pushl  0x8(%ebp)
 79d:	e8 01 fe ff ff       	call   5a3 <write>
  for(i = 0; fmt[i]; i++){
 7a2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 7a6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 7a9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 7ab:	84 db                	test   %bl,%bl
 7ad:	75 8f                	jne    73e <printf+0x5e>
    }
  }
}
 7af:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7b2:	5b                   	pop    %ebx
 7b3:	5e                   	pop    %esi
 7b4:	5f                   	pop    %edi
 7b5:	5d                   	pop    %ebp
 7b6:	c3                   	ret    
 7b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7be:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 7c0:	83 ec 0c             	sub    $0xc,%esp
 7c3:	b9 10 00 00 00       	mov    $0x10,%ecx
 7c8:	6a 00                	push   $0x0
 7ca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 7cd:	8b 45 08             	mov    0x8(%ebp),%eax
 7d0:	8b 13                	mov    (%ebx),%edx
 7d2:	e8 59 fe ff ff       	call   630 <printint>
        ap++;
 7d7:	89 d8                	mov    %ebx,%eax
 7d9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7dc:	31 d2                	xor    %edx,%edx
        ap++;
 7de:	83 c0 04             	add    $0x4,%eax
 7e1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7e4:	e9 4b ff ff ff       	jmp    734 <printf+0x54>
 7e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 7f0:	83 ec 0c             	sub    $0xc,%esp
 7f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7f8:	6a 01                	push   $0x1
 7fa:	eb ce                	jmp    7ca <printf+0xea>
 7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 800:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 803:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 806:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 808:	6a 01                	push   $0x1
        ap++;
 80a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 80d:	57                   	push   %edi
 80e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 811:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 814:	e8 8a fd ff ff       	call   5a3 <write>
        ap++;
 819:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 81c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 81f:	31 d2                	xor    %edx,%edx
 821:	e9 0e ff ff ff       	jmp    734 <printf+0x54>
 826:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 82d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 830:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 833:	83 ec 04             	sub    $0x4,%esp
 836:	e9 59 ff ff ff       	jmp    794 <printf+0xb4>
 83b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 83f:	90                   	nop
        s = (char*)*ap;
 840:	8b 45 d0             	mov    -0x30(%ebp),%eax
 843:	8b 18                	mov    (%eax),%ebx
        ap++;
 845:	83 c0 04             	add    $0x4,%eax
 848:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 84b:	85 db                	test   %ebx,%ebx
 84d:	74 17                	je     866 <printf+0x186>
        while(*s != 0){
 84f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 852:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 854:	84 c0                	test   %al,%al
 856:	0f 84 d8 fe ff ff    	je     734 <printf+0x54>
 85c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 85f:	89 de                	mov    %ebx,%esi
 861:	8b 5d 08             	mov    0x8(%ebp),%ebx
 864:	eb 1a                	jmp    880 <printf+0x1a0>
          s = "(null)";
 866:	bb 7e 0a 00 00       	mov    $0xa7e,%ebx
        while(*s != 0){
 86b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 86e:	b8 28 00 00 00       	mov    $0x28,%eax
 873:	89 de                	mov    %ebx,%esi
 875:	8b 5d 08             	mov    0x8(%ebp),%ebx
 878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 87f:	90                   	nop
  write(fd, &c, 1);
 880:	83 ec 04             	sub    $0x4,%esp
          s++;
 883:	83 c6 01             	add    $0x1,%esi
 886:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 889:	6a 01                	push   $0x1
 88b:	57                   	push   %edi
 88c:	53                   	push   %ebx
 88d:	e8 11 fd ff ff       	call   5a3 <write>
        while(*s != 0){
 892:	0f b6 06             	movzbl (%esi),%eax
 895:	83 c4 10             	add    $0x10,%esp
 898:	84 c0                	test   %al,%al
 89a:	75 e4                	jne    880 <printf+0x1a0>
 89c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 89f:	31 d2                	xor    %edx,%edx
 8a1:	e9 8e fe ff ff       	jmp    734 <printf+0x54>
 8a6:	66 90                	xchg   %ax,%ax
 8a8:	66 90                	xchg   %ax,%ax
 8aa:	66 90                	xchg   %ax,%ax
 8ac:	66 90                	xchg   %ax,%ax
 8ae:	66 90                	xchg   %ax,%ax

000008b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b1:	a1 40 0e 00 00       	mov    0xe40,%eax
{
 8b6:	89 e5                	mov    %esp,%ebp
 8b8:	57                   	push   %edi
 8b9:	56                   	push   %esi
 8ba:	53                   	push   %ebx
 8bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8be:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 8c0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c3:	39 c8                	cmp    %ecx,%eax
 8c5:	73 19                	jae    8e0 <free+0x30>
 8c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ce:	66 90                	xchg   %ax,%ax
 8d0:	39 d1                	cmp    %edx,%ecx
 8d2:	72 14                	jb     8e8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d4:	39 d0                	cmp    %edx,%eax
 8d6:	73 10                	jae    8e8 <free+0x38>
{
 8d8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8da:	8b 10                	mov    (%eax),%edx
 8dc:	39 c8                	cmp    %ecx,%eax
 8de:	72 f0                	jb     8d0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e0:	39 d0                	cmp    %edx,%eax
 8e2:	72 f4                	jb     8d8 <free+0x28>
 8e4:	39 d1                	cmp    %edx,%ecx
 8e6:	73 f0                	jae    8d8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8ee:	39 fa                	cmp    %edi,%edx
 8f0:	74 1e                	je     910 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8f2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8f5:	8b 50 04             	mov    0x4(%eax),%edx
 8f8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8fb:	39 f1                	cmp    %esi,%ecx
 8fd:	74 28                	je     927 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8ff:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 901:	5b                   	pop    %ebx
  freep = p;
 902:	a3 40 0e 00 00       	mov    %eax,0xe40
}
 907:	5e                   	pop    %esi
 908:	5f                   	pop    %edi
 909:	5d                   	pop    %ebp
 90a:	c3                   	ret    
 90b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 90f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 910:	03 72 04             	add    0x4(%edx),%esi
 913:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 916:	8b 10                	mov    (%eax),%edx
 918:	8b 12                	mov    (%edx),%edx
 91a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 91d:	8b 50 04             	mov    0x4(%eax),%edx
 920:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 923:	39 f1                	cmp    %esi,%ecx
 925:	75 d8                	jne    8ff <free+0x4f>
    p->s.size += bp->s.size;
 927:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 92a:	a3 40 0e 00 00       	mov    %eax,0xe40
    p->s.size += bp->s.size;
 92f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 932:	8b 53 f8             	mov    -0x8(%ebx),%edx
 935:	89 10                	mov    %edx,(%eax)
}
 937:	5b                   	pop    %ebx
 938:	5e                   	pop    %esi
 939:	5f                   	pop    %edi
 93a:	5d                   	pop    %ebp
 93b:	c3                   	ret    
 93c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000940 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	57                   	push   %edi
 944:	56                   	push   %esi
 945:	53                   	push   %ebx
 946:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 949:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 94c:	8b 3d 40 0e 00 00    	mov    0xe40,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 952:	8d 70 07             	lea    0x7(%eax),%esi
 955:	c1 ee 03             	shr    $0x3,%esi
 958:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 95b:	85 ff                	test   %edi,%edi
 95d:	0f 84 ad 00 00 00    	je     a10 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 963:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 965:	8b 48 04             	mov    0x4(%eax),%ecx
 968:	39 f1                	cmp    %esi,%ecx
 96a:	73 71                	jae    9dd <malloc+0x9d>
 96c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 972:	bb 00 10 00 00       	mov    $0x1000,%ebx
 977:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 97a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 981:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 984:	eb 1b                	jmp    9a1 <malloc+0x61>
 986:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 98d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 990:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 992:	8b 4a 04             	mov    0x4(%edx),%ecx
 995:	39 f1                	cmp    %esi,%ecx
 997:	73 4f                	jae    9e8 <malloc+0xa8>
 999:	8b 3d 40 0e 00 00    	mov    0xe40,%edi
 99f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9a1:	39 c7                	cmp    %eax,%edi
 9a3:	75 eb                	jne    990 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 9a5:	83 ec 0c             	sub    $0xc,%esp
 9a8:	ff 75 e4             	pushl  -0x1c(%ebp)
 9ab:	e8 5b fc ff ff       	call   60b <sbrk>
  if(p == (char*)-1)
 9b0:	83 c4 10             	add    $0x10,%esp
 9b3:	83 f8 ff             	cmp    $0xffffffff,%eax
 9b6:	74 1b                	je     9d3 <malloc+0x93>
  hp->s.size = nu;
 9b8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 9bb:	83 ec 0c             	sub    $0xc,%esp
 9be:	83 c0 08             	add    $0x8,%eax
 9c1:	50                   	push   %eax
 9c2:	e8 e9 fe ff ff       	call   8b0 <free>
  return freep;
 9c7:	a1 40 0e 00 00       	mov    0xe40,%eax
      if((p = morecore(nunits)) == 0)
 9cc:	83 c4 10             	add    $0x10,%esp
 9cf:	85 c0                	test   %eax,%eax
 9d1:	75 bd                	jne    990 <malloc+0x50>
        return 0;
  }
}
 9d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 9d6:	31 c0                	xor    %eax,%eax
}
 9d8:	5b                   	pop    %ebx
 9d9:	5e                   	pop    %esi
 9da:	5f                   	pop    %edi
 9db:	5d                   	pop    %ebp
 9dc:	c3                   	ret    
    if(p->s.size >= nunits){
 9dd:	89 c2                	mov    %eax,%edx
 9df:	89 f8                	mov    %edi,%eax
 9e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 9e8:	39 ce                	cmp    %ecx,%esi
 9ea:	74 54                	je     a40 <malloc+0x100>
        p->s.size -= nunits;
 9ec:	29 f1                	sub    %esi,%ecx
 9ee:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 9f1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 9f4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 9f7:	a3 40 0e 00 00       	mov    %eax,0xe40
}
 9fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 9ff:	8d 42 08             	lea    0x8(%edx),%eax
}
 a02:	5b                   	pop    %ebx
 a03:	5e                   	pop    %esi
 a04:	5f                   	pop    %edi
 a05:	5d                   	pop    %ebp
 a06:	c3                   	ret    
 a07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a0e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 a10:	c7 05 40 0e 00 00 44 	movl   $0xe44,0xe40
 a17:	0e 00 00 
    base.s.size = 0;
 a1a:	bf 44 0e 00 00       	mov    $0xe44,%edi
    base.s.ptr = freep = prevp = &base;
 a1f:	c7 05 44 0e 00 00 44 	movl   $0xe44,0xe44
 a26:	0e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a29:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 a2b:	c7 05 48 0e 00 00 00 	movl   $0x0,0xe48
 a32:	00 00 00 
    if(p->s.size >= nunits){
 a35:	e9 32 ff ff ff       	jmp    96c <malloc+0x2c>
 a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 a40:	8b 0a                	mov    (%edx),%ecx
 a42:	89 08                	mov    %ecx,(%eax)
 a44:	eb b1                	jmp    9f7 <malloc+0xb7>
