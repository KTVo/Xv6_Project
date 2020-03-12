
_chgrp:     file format elf32-i386


Disassembly of section .text:

00000000 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
   0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
   1:	31 c0                	xor    %eax,%eax
{
   3:	89 e5                	mov    %esp,%ebp
   5:	53                   	push   %ebx
   6:	8b 4d 08             	mov    0x8(%ebp),%ecx
   9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
   c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  10:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  14:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  17:	83 c0 01             	add    $0x1,%eax
  1a:	84 d2                	test   %dl,%dl
  1c:	75 f2                	jne    10 <strcpy+0x10>
    ;
  return os;
}
  1e:	89 c8                	mov    %ecx,%eax
  20:	5b                   	pop    %ebx
  21:	5d                   	pop    %ebp
  22:	c3                   	ret    
  23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000030 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	53                   	push   %ebx
  34:	8b 4d 08             	mov    0x8(%ebp),%ecx
  37:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  3a:	0f b6 01             	movzbl (%ecx),%eax
  3d:	0f b6 1a             	movzbl (%edx),%ebx
  40:	84 c0                	test   %al,%al
  42:	75 1d                	jne    61 <strcmp+0x31>
  44:	eb 2a                	jmp    70 <strcmp+0x40>
  46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  4d:	8d 76 00             	lea    0x0(%esi),%esi
  50:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  54:	83 c1 01             	add    $0x1,%ecx
  57:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  5a:	0f b6 1a             	movzbl (%edx),%ebx
  5d:	84 c0                	test   %al,%al
  5f:	74 0f                	je     70 <strcmp+0x40>
  61:	38 d8                	cmp    %bl,%al
  63:	74 eb                	je     50 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  65:	29 d8                	sub    %ebx,%eax
}
  67:	5b                   	pop    %ebx
  68:	5d                   	pop    %ebp
  69:	c3                   	ret    
  6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  70:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  72:	29 d8                	sub    %ebx,%eax
}
  74:	5b                   	pop    %ebx
  75:	5d                   	pop    %ebp
  76:	c3                   	ret    
  77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  7e:	66 90                	xchg   %ax,%ax

00000080 <strlen>:

uint
strlen(char *s)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  86:	80 3a 00             	cmpb   $0x0,(%edx)
  89:	74 15                	je     a0 <strlen+0x20>
  8b:	31 c0                	xor    %eax,%eax
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	83 c0 01             	add    $0x1,%eax
  93:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  97:	89 c1                	mov    %eax,%ecx
  99:	75 f5                	jne    90 <strlen+0x10>
    ;
  return n;
}
  9b:	89 c8                	mov    %ecx,%eax
  9d:	5d                   	pop    %ebp
  9e:	c3                   	ret    
  9f:	90                   	nop
  for(n = 0; s[n]; n++)
  a0:	31 c9                	xor    %ecx,%ecx
}
  a2:	5d                   	pop    %ebp
  a3:	89 c8                	mov    %ecx,%eax
  a5:	c3                   	ret    
  a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ad:	8d 76 00             	lea    0x0(%esi),%esi

000000b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  bd:	89 d7                	mov    %edx,%edi
  bf:	fc                   	cld    
  c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  c2:	89 d0                	mov    %edx,%eax
  c4:	5f                   	pop    %edi
  c5:	5d                   	pop    %ebp
  c6:	c3                   	ret    
  c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ce:	66 90                	xchg   %ax,%ax

000000d0 <strchr>:

char*
strchr(const char *s, char c)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  da:	0f b6 10             	movzbl (%eax),%edx
  dd:	84 d2                	test   %dl,%dl
  df:	75 12                	jne    f3 <strchr+0x23>
  e1:	eb 1d                	jmp    100 <strchr+0x30>
  e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  e7:	90                   	nop
  e8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
  ec:	83 c0 01             	add    $0x1,%eax
  ef:	84 d2                	test   %dl,%dl
  f1:	74 0d                	je     100 <strchr+0x30>
    if(*s == c)
  f3:	38 d1                	cmp    %dl,%cl
  f5:	75 f1                	jne    e8 <strchr+0x18>
      return (char*)s;
  return 0;
}
  f7:	5d                   	pop    %ebp
  f8:	c3                   	ret    
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 100:	31 c0                	xor    %eax,%eax
}
 102:	5d                   	pop    %ebp
 103:	c3                   	ret    
 104:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 10b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 10f:	90                   	nop

00000110 <gets>:

char*
gets(char *buf, int max)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 115:	31 f6                	xor    %esi,%esi
{
 117:	53                   	push   %ebx
 118:	89 f3                	mov    %esi,%ebx
 11a:	83 ec 1c             	sub    $0x1c,%esp
 11d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 120:	eb 2f                	jmp    151 <gets+0x41>
 122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 128:	83 ec 04             	sub    $0x4,%esp
 12b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 12e:	6a 01                	push   $0x1
 130:	50                   	push   %eax
 131:	6a 00                	push   $0x0
 133:	e8 33 01 00 00       	call   26b <read>
    if(cc < 1)
 138:	83 c4 10             	add    $0x10,%esp
 13b:	85 c0                	test   %eax,%eax
 13d:	7e 1c                	jle    15b <gets+0x4b>
      break;
    buf[i++] = c;
 13f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 143:	83 c7 01             	add    $0x1,%edi
 146:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 149:	3c 0a                	cmp    $0xa,%al
 14b:	74 23                	je     170 <gets+0x60>
 14d:	3c 0d                	cmp    $0xd,%al
 14f:	74 1f                	je     170 <gets+0x60>
  for(i=0; i+1 < max; ){
 151:	83 c3 01             	add    $0x1,%ebx
 154:	89 fe                	mov    %edi,%esi
 156:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 159:	7c cd                	jl     128 <gets+0x18>
 15b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 15d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 160:	c6 03 00             	movb   $0x0,(%ebx)
}
 163:	8d 65 f4             	lea    -0xc(%ebp),%esp
 166:	5b                   	pop    %ebx
 167:	5e                   	pop    %esi
 168:	5f                   	pop    %edi
 169:	5d                   	pop    %ebp
 16a:	c3                   	ret    
 16b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 16f:	90                   	nop
 170:	8b 75 08             	mov    0x8(%ebp),%esi
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	01 de                	add    %ebx,%esi
 178:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 17a:	c6 03 00             	movb   $0x0,(%ebx)
}
 17d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 180:	5b                   	pop    %ebx
 181:	5e                   	pop    %esi
 182:	5f                   	pop    %edi
 183:	5d                   	pop    %ebp
 184:	c3                   	ret    
 185:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <stat>:

int
stat(char *n, struct stat *st)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	56                   	push   %esi
 194:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 195:	83 ec 08             	sub    $0x8,%esp
 198:	6a 00                	push   $0x0
 19a:	ff 75 08             	pushl  0x8(%ebp)
 19d:	e8 f1 00 00 00       	call   293 <open>
  if(fd < 0)
 1a2:	83 c4 10             	add    $0x10,%esp
 1a5:	85 c0                	test   %eax,%eax
 1a7:	78 27                	js     1d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1a9:	83 ec 08             	sub    $0x8,%esp
 1ac:	ff 75 0c             	pushl  0xc(%ebp)
 1af:	89 c3                	mov    %eax,%ebx
 1b1:	50                   	push   %eax
 1b2:	e8 f4 00 00 00       	call   2ab <fstat>
  close(fd);
 1b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1ba:	89 c6                	mov    %eax,%esi
  close(fd);
 1bc:	e8 ba 00 00 00       	call   27b <close>
  return r;
 1c1:	83 c4 10             	add    $0x10,%esp
}
 1c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c7:	89 f0                	mov    %esi,%eax
 1c9:	5b                   	pop    %ebx
 1ca:	5e                   	pop    %esi
 1cb:	5d                   	pop    %ebp
 1cc:	c3                   	ret    
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1d5:	eb ed                	jmp    1c4 <stat+0x34>
 1d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1de:	66 90                	xchg   %ax,%ax

000001e0 <atoi>:

int
atoi(const char *s)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
 1e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1e7:	0f be 02             	movsbl (%edx),%eax
 1ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 1ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 1f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 1f5:	77 1e                	ja     215 <atoi+0x35>
 1f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 200:	83 c2 01             	add    $0x1,%edx
 203:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 206:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 20a:	0f be 02             	movsbl (%edx),%eax
 20d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 210:	80 fb 09             	cmp    $0x9,%bl
 213:	76 eb                	jbe    200 <atoi+0x20>
  return n;
}
 215:	89 c8                	mov    %ecx,%eax
 217:	5b                   	pop    %ebx
 218:	5d                   	pop    %ebp
 219:	c3                   	ret    
 21a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000220 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	8b 45 10             	mov    0x10(%ebp),%eax
 227:	8b 55 08             	mov    0x8(%ebp),%edx
 22a:	56                   	push   %esi
 22b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 22e:	85 c0                	test   %eax,%eax
 230:	7e 13                	jle    245 <memmove+0x25>
 232:	01 d0                	add    %edx,%eax
  dst = vdst;
 234:	89 d7                	mov    %edx,%edi
 236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 240:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 241:	39 f8                	cmp    %edi,%eax
 243:	75 fb                	jne    240 <memmove+0x20>
  return vdst;
}
 245:	5e                   	pop    %esi
 246:	89 d0                	mov    %edx,%eax
 248:	5f                   	pop    %edi
 249:	5d                   	pop    %ebp
 24a:	c3                   	ret    

0000024b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 24b:	b8 01 00 00 00       	mov    $0x1,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret    

00000253 <exit>:
SYSCALL(exit)
 253:	b8 02 00 00 00       	mov    $0x2,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret    

0000025b <wait>:
SYSCALL(wait)
 25b:	b8 03 00 00 00       	mov    $0x3,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret    

00000263 <pipe>:
SYSCALL(pipe)
 263:	b8 04 00 00 00       	mov    $0x4,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret    

0000026b <read>:
SYSCALL(read)
 26b:	b8 05 00 00 00       	mov    $0x5,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <write>:
SYSCALL(write)
 273:	b8 10 00 00 00       	mov    $0x10,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <close>:
SYSCALL(close)
 27b:	b8 15 00 00 00       	mov    $0x15,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <kill>:
SYSCALL(kill)
 283:	b8 06 00 00 00       	mov    $0x6,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <exec>:
SYSCALL(exec)
 28b:	b8 07 00 00 00       	mov    $0x7,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <open>:
SYSCALL(open)
 293:	b8 0f 00 00 00       	mov    $0xf,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <mknod>:
SYSCALL(mknod)
 29b:	b8 11 00 00 00       	mov    $0x11,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <unlink>:
SYSCALL(unlink)
 2a3:	b8 12 00 00 00       	mov    $0x12,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <fstat>:
SYSCALL(fstat)
 2ab:	b8 08 00 00 00       	mov    $0x8,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <link>:
SYSCALL(link)
 2b3:	b8 13 00 00 00       	mov    $0x13,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <mkdir>:
SYSCALL(mkdir)
 2bb:	b8 14 00 00 00       	mov    $0x14,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <chdir>:
SYSCALL(chdir)
 2c3:	b8 09 00 00 00       	mov    $0x9,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <dup>:
SYSCALL(dup)
 2cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <getpid>:
SYSCALL(getpid)
 2d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <sbrk>:
SYSCALL(sbrk)
 2db:	b8 0c 00 00 00       	mov    $0xc,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <sleep>:
SYSCALL(sleep)
 2e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <uptime>:
SYSCALL(uptime)
 2eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <date>:
SYSCALL(date)
 2f3:	b8 16 00 00 00       	mov    $0x16,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <chmod>:
//SYSCALL(chown)
//SYSCALL(chgrp)
SYSCALL(chmod)
 2fb:	b8 17 00 00 00       	mov    $0x17,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    
 303:	66 90                	xchg   %ax,%ax
 305:	66 90                	xchg   %ax,%ax
 307:	66 90                	xchg   %ax,%ax
 309:	66 90                	xchg   %ax,%ax
 30b:	66 90                	xchg   %ax,%ax
 30d:	66 90                	xchg   %ax,%ax
 30f:	90                   	nop

00000310 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
 315:	53                   	push   %ebx
 316:	83 ec 3c             	sub    $0x3c,%esp
 319:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 31c:	89 d1                	mov    %edx,%ecx
{
 31e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 321:	85 d2                	test   %edx,%edx
 323:	0f 89 7f 00 00 00    	jns    3a8 <printint+0x98>
 329:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 32d:	74 79                	je     3a8 <printint+0x98>
    neg = 1;
 32f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 336:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 338:	31 db                	xor    %ebx,%ebx
 33a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 33d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 340:	89 c8                	mov    %ecx,%eax
 342:	31 d2                	xor    %edx,%edx
 344:	89 cf                	mov    %ecx,%edi
 346:	f7 75 c4             	divl   -0x3c(%ebp)
 349:	0f b6 92 30 07 00 00 	movzbl 0x730(%edx),%edx
 350:	89 45 c0             	mov    %eax,-0x40(%ebp)
 353:	89 d8                	mov    %ebx,%eax
 355:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 358:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 35b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 35e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 361:	76 dd                	jbe    340 <printint+0x30>
  if(neg)
 363:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 366:	85 c9                	test   %ecx,%ecx
 368:	74 0c                	je     376 <printint+0x66>
    buf[i++] = '-';
 36a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 36f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 371:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 376:	8b 7d b8             	mov    -0x48(%ebp),%edi
 379:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 37d:	eb 07                	jmp    386 <printint+0x76>
 37f:	90                   	nop
 380:	0f b6 13             	movzbl (%ebx),%edx
 383:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 386:	83 ec 04             	sub    $0x4,%esp
 389:	88 55 d7             	mov    %dl,-0x29(%ebp)
 38c:	6a 01                	push   $0x1
 38e:	56                   	push   %esi
 38f:	57                   	push   %edi
 390:	e8 de fe ff ff       	call   273 <write>
  while(--i >= 0)
 395:	83 c4 10             	add    $0x10,%esp
 398:	39 de                	cmp    %ebx,%esi
 39a:	75 e4                	jne    380 <printint+0x70>
    putc(fd, buf[i]);
}
 39c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 39f:	5b                   	pop    %ebx
 3a0:	5e                   	pop    %esi
 3a1:	5f                   	pop    %edi
 3a2:	5d                   	pop    %ebp
 3a3:	c3                   	ret    
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3a8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 3af:	eb 87                	jmp    338 <printint+0x28>
 3b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3bf:	90                   	nop

000003c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3c9:	8b 75 0c             	mov    0xc(%ebp),%esi
 3cc:	0f b6 1e             	movzbl (%esi),%ebx
 3cf:	84 db                	test   %bl,%bl
 3d1:	0f 84 b8 00 00 00    	je     48f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 3d7:	8d 45 10             	lea    0x10(%ebp),%eax
 3da:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 3dd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 3e0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 3e2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 3e5:	eb 37                	jmp    41e <printf+0x5e>
 3e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ee:	66 90                	xchg   %ax,%ax
 3f0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 3f3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 3f8:	83 f8 25             	cmp    $0x25,%eax
 3fb:	74 17                	je     414 <printf+0x54>
  write(fd, &c, 1);
 3fd:	83 ec 04             	sub    $0x4,%esp
 400:	88 5d e7             	mov    %bl,-0x19(%ebp)
 403:	6a 01                	push   $0x1
 405:	57                   	push   %edi
 406:	ff 75 08             	pushl  0x8(%ebp)
 409:	e8 65 fe ff ff       	call   273 <write>
 40e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 411:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 414:	0f b6 1e             	movzbl (%esi),%ebx
 417:	83 c6 01             	add    $0x1,%esi
 41a:	84 db                	test   %bl,%bl
 41c:	74 71                	je     48f <printf+0xcf>
    c = fmt[i] & 0xff;
 41e:	0f be cb             	movsbl %bl,%ecx
 421:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 424:	85 d2                	test   %edx,%edx
 426:	74 c8                	je     3f0 <printf+0x30>
      }
    } else if(state == '%'){
 428:	83 fa 25             	cmp    $0x25,%edx
 42b:	75 e7                	jne    414 <printf+0x54>
      if(c == 'd'){
 42d:	83 f8 64             	cmp    $0x64,%eax
 430:	0f 84 9a 00 00 00    	je     4d0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 436:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 43c:	83 f9 70             	cmp    $0x70,%ecx
 43f:	74 5f                	je     4a0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 441:	83 f8 73             	cmp    $0x73,%eax
 444:	0f 84 d6 00 00 00    	je     520 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 44a:	83 f8 63             	cmp    $0x63,%eax
 44d:	0f 84 8d 00 00 00    	je     4e0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 453:	83 f8 25             	cmp    $0x25,%eax
 456:	0f 84 b4 00 00 00    	je     510 <printf+0x150>
  write(fd, &c, 1);
 45c:	83 ec 04             	sub    $0x4,%esp
 45f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 463:	6a 01                	push   $0x1
 465:	57                   	push   %edi
 466:	ff 75 08             	pushl  0x8(%ebp)
 469:	e8 05 fe ff ff       	call   273 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 46e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 471:	83 c4 0c             	add    $0xc,%esp
 474:	6a 01                	push   $0x1
 476:	83 c6 01             	add    $0x1,%esi
 479:	57                   	push   %edi
 47a:	ff 75 08             	pushl  0x8(%ebp)
 47d:	e8 f1 fd ff ff       	call   273 <write>
  for(i = 0; fmt[i]; i++){
 482:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 486:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 489:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 48b:	84 db                	test   %bl,%bl
 48d:	75 8f                	jne    41e <printf+0x5e>
    }
  }
}
 48f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 492:	5b                   	pop    %ebx
 493:	5e                   	pop    %esi
 494:	5f                   	pop    %edi
 495:	5d                   	pop    %ebp
 496:	c3                   	ret    
 497:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 49e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 4a0:	83 ec 0c             	sub    $0xc,%esp
 4a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4a8:	6a 00                	push   $0x0
 4aa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4ad:	8b 45 08             	mov    0x8(%ebp),%eax
 4b0:	8b 13                	mov    (%ebx),%edx
 4b2:	e8 59 fe ff ff       	call   310 <printint>
        ap++;
 4b7:	89 d8                	mov    %ebx,%eax
 4b9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4bc:	31 d2                	xor    %edx,%edx
        ap++;
 4be:	83 c0 04             	add    $0x4,%eax
 4c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4c4:	e9 4b ff ff ff       	jmp    414 <printf+0x54>
 4c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 4d0:	83 ec 0c             	sub    $0xc,%esp
 4d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4d8:	6a 01                	push   $0x1
 4da:	eb ce                	jmp    4aa <printf+0xea>
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 4e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 4e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 4e6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 4e8:	6a 01                	push   $0x1
        ap++;
 4ea:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 4ed:	57                   	push   %edi
 4ee:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 4f1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 4f4:	e8 7a fd ff ff       	call   273 <write>
        ap++;
 4f9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 4fc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4ff:	31 d2                	xor    %edx,%edx
 501:	e9 0e ff ff ff       	jmp    414 <printf+0x54>
 506:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 510:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 513:	83 ec 04             	sub    $0x4,%esp
 516:	e9 59 ff ff ff       	jmp    474 <printf+0xb4>
 51b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 51f:	90                   	nop
        s = (char*)*ap;
 520:	8b 45 d0             	mov    -0x30(%ebp),%eax
 523:	8b 18                	mov    (%eax),%ebx
        ap++;
 525:	83 c0 04             	add    $0x4,%eax
 528:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 52b:	85 db                	test   %ebx,%ebx
 52d:	74 17                	je     546 <printf+0x186>
        while(*s != 0){
 52f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 532:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 534:	84 c0                	test   %al,%al
 536:	0f 84 d8 fe ff ff    	je     414 <printf+0x54>
 53c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 53f:	89 de                	mov    %ebx,%esi
 541:	8b 5d 08             	mov    0x8(%ebp),%ebx
 544:	eb 1a                	jmp    560 <printf+0x1a0>
          s = "(null)";
 546:	bb 28 07 00 00       	mov    $0x728,%ebx
        while(*s != 0){
 54b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 54e:	b8 28 00 00 00       	mov    $0x28,%eax
 553:	89 de                	mov    %ebx,%esi
 555:	8b 5d 08             	mov    0x8(%ebp),%ebx
 558:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55f:	90                   	nop
  write(fd, &c, 1);
 560:	83 ec 04             	sub    $0x4,%esp
          s++;
 563:	83 c6 01             	add    $0x1,%esi
 566:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 569:	6a 01                	push   $0x1
 56b:	57                   	push   %edi
 56c:	53                   	push   %ebx
 56d:	e8 01 fd ff ff       	call   273 <write>
        while(*s != 0){
 572:	0f b6 06             	movzbl (%esi),%eax
 575:	83 c4 10             	add    $0x10,%esp
 578:	84 c0                	test   %al,%al
 57a:	75 e4                	jne    560 <printf+0x1a0>
 57c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 57f:	31 d2                	xor    %edx,%edx
 581:	e9 8e fe ff ff       	jmp    414 <printf+0x54>
 586:	66 90                	xchg   %ax,%ax
 588:	66 90                	xchg   %ax,%ax
 58a:	66 90                	xchg   %ax,%ax
 58c:	66 90                	xchg   %ax,%ax
 58e:	66 90                	xchg   %ax,%ax

00000590 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 590:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 591:	a1 b4 09 00 00       	mov    0x9b4,%eax
{
 596:	89 e5                	mov    %esp,%ebp
 598:	57                   	push   %edi
 599:	56                   	push   %esi
 59a:	53                   	push   %ebx
 59b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 59e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 5a0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a3:	39 c8                	cmp    %ecx,%eax
 5a5:	73 19                	jae    5c0 <free+0x30>
 5a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ae:	66 90                	xchg   %ax,%ax
 5b0:	39 d1                	cmp    %edx,%ecx
 5b2:	72 14                	jb     5c8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b4:	39 d0                	cmp    %edx,%eax
 5b6:	73 10                	jae    5c8 <free+0x38>
{
 5b8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ba:	8b 10                	mov    (%eax),%edx
 5bc:	39 c8                	cmp    %ecx,%eax
 5be:	72 f0                	jb     5b0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c0:	39 d0                	cmp    %edx,%eax
 5c2:	72 f4                	jb     5b8 <free+0x28>
 5c4:	39 d1                	cmp    %edx,%ecx
 5c6:	73 f0                	jae    5b8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5ce:	39 fa                	cmp    %edi,%edx
 5d0:	74 1e                	je     5f0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5d2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5d5:	8b 50 04             	mov    0x4(%eax),%edx
 5d8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5db:	39 f1                	cmp    %esi,%ecx
 5dd:	74 28                	je     607 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5df:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 5e1:	5b                   	pop    %ebx
  freep = p;
 5e2:	a3 b4 09 00 00       	mov    %eax,0x9b4
}
 5e7:	5e                   	pop    %esi
 5e8:	5f                   	pop    %edi
 5e9:	5d                   	pop    %ebp
 5ea:	c3                   	ret    
 5eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5ef:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 5f0:	03 72 04             	add    0x4(%edx),%esi
 5f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5f6:	8b 10                	mov    (%eax),%edx
 5f8:	8b 12                	mov    (%edx),%edx
 5fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5fd:	8b 50 04             	mov    0x4(%eax),%edx
 600:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 603:	39 f1                	cmp    %esi,%ecx
 605:	75 d8                	jne    5df <free+0x4f>
    p->s.size += bp->s.size;
 607:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 60a:	a3 b4 09 00 00       	mov    %eax,0x9b4
    p->s.size += bp->s.size;
 60f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 612:	8b 53 f8             	mov    -0x8(%ebx),%edx
 615:	89 10                	mov    %edx,(%eax)
}
 617:	5b                   	pop    %ebx
 618:	5e                   	pop    %esi
 619:	5f                   	pop    %edi
 61a:	5d                   	pop    %ebp
 61b:	c3                   	ret    
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000620 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
 625:	53                   	push   %ebx
 626:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 629:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 62c:	8b 3d b4 09 00 00    	mov    0x9b4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 632:	8d 70 07             	lea    0x7(%eax),%esi
 635:	c1 ee 03             	shr    $0x3,%esi
 638:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 63b:	85 ff                	test   %edi,%edi
 63d:	0f 84 ad 00 00 00    	je     6f0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 643:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 645:	8b 48 04             	mov    0x4(%eax),%ecx
 648:	39 f1                	cmp    %esi,%ecx
 64a:	73 71                	jae    6bd <malloc+0x9d>
 64c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 652:	bb 00 10 00 00       	mov    $0x1000,%ebx
 657:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 65a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 661:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 664:	eb 1b                	jmp    681 <malloc+0x61>
 666:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 66d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 670:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 672:	8b 4a 04             	mov    0x4(%edx),%ecx
 675:	39 f1                	cmp    %esi,%ecx
 677:	73 4f                	jae    6c8 <malloc+0xa8>
 679:	8b 3d b4 09 00 00    	mov    0x9b4,%edi
 67f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 681:	39 c7                	cmp    %eax,%edi
 683:	75 eb                	jne    670 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 685:	83 ec 0c             	sub    $0xc,%esp
 688:	ff 75 e4             	pushl  -0x1c(%ebp)
 68b:	e8 4b fc ff ff       	call   2db <sbrk>
  if(p == (char*)-1)
 690:	83 c4 10             	add    $0x10,%esp
 693:	83 f8 ff             	cmp    $0xffffffff,%eax
 696:	74 1b                	je     6b3 <malloc+0x93>
  hp->s.size = nu;
 698:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 69b:	83 ec 0c             	sub    $0xc,%esp
 69e:	83 c0 08             	add    $0x8,%eax
 6a1:	50                   	push   %eax
 6a2:	e8 e9 fe ff ff       	call   590 <free>
  return freep;
 6a7:	a1 b4 09 00 00       	mov    0x9b4,%eax
      if((p = morecore(nunits)) == 0)
 6ac:	83 c4 10             	add    $0x10,%esp
 6af:	85 c0                	test   %eax,%eax
 6b1:	75 bd                	jne    670 <malloc+0x50>
        return 0;
  }
}
 6b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 6b6:	31 c0                	xor    %eax,%eax
}
 6b8:	5b                   	pop    %ebx
 6b9:	5e                   	pop    %esi
 6ba:	5f                   	pop    %edi
 6bb:	5d                   	pop    %ebp
 6bc:	c3                   	ret    
    if(p->s.size >= nunits){
 6bd:	89 c2                	mov    %eax,%edx
 6bf:	89 f8                	mov    %edi,%eax
 6c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 6c8:	39 ce                	cmp    %ecx,%esi
 6ca:	74 54                	je     720 <malloc+0x100>
        p->s.size -= nunits;
 6cc:	29 f1                	sub    %esi,%ecx
 6ce:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 6d1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 6d4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 6d7:	a3 b4 09 00 00       	mov    %eax,0x9b4
}
 6dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 6df:	8d 42 08             	lea    0x8(%edx),%eax
}
 6e2:	5b                   	pop    %ebx
 6e3:	5e                   	pop    %esi
 6e4:	5f                   	pop    %edi
 6e5:	5d                   	pop    %ebp
 6e6:	c3                   	ret    
 6e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ee:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 6f0:	c7 05 b4 09 00 00 b8 	movl   $0x9b8,0x9b4
 6f7:	09 00 00 
    base.s.size = 0;
 6fa:	bf b8 09 00 00       	mov    $0x9b8,%edi
    base.s.ptr = freep = prevp = &base;
 6ff:	c7 05 b8 09 00 00 b8 	movl   $0x9b8,0x9b8
 706:	09 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 709:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 70b:	c7 05 bc 09 00 00 00 	movl   $0x0,0x9bc
 712:	00 00 00 
    if(p->s.size >= nunits){
 715:	e9 32 ff ff ff       	jmp    64c <malloc+0x2c>
 71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 720:	8b 0a                	mov    (%edx),%ecx
 722:	89 08                	mov    %ecx,(%eax)
 724:	eb b1                	jmp    6d7 <malloc+0xb7>
