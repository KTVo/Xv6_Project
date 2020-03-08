
_rm:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	bf 01 00 00 00       	mov    $0x1,%edi
  13:	56                   	push   %esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
  1c:	8b 31                	mov    (%ecx),%esi
  1e:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
  21:	83 fe 01             	cmp    $0x1,%esi
  24:	7e 3e                	jle    64 <main+0x64>
  26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  2d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	pushl  (%ebx)
  35:	e8 e7 02 00 00       	call   321 <unlink>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	78 0f                	js     50 <main+0x50>
  for(i = 1; i < argc; i++){
  41:	83 c7 01             	add    $0x1,%edi
  44:	83 c3 04             	add    $0x4,%ebx
  47:	39 fe                	cmp    %edi,%esi
  49:	75 e5                	jne    30 <main+0x30>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
  4b:	e8 81 02 00 00       	call   2d1 <exit>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  50:	50                   	push   %eax
  51:	ff 33                	pushl  (%ebx)
  53:	68 cc 07 00 00       	push   $0x7cc
  58:	6a 02                	push   $0x2
  5a:	e8 f1 03 00 00       	call   450 <printf>
      break;
  5f:	83 c4 10             	add    $0x10,%esp
  62:	eb e7                	jmp    4b <main+0x4b>
    printf(2, "Usage: rm files...\n");
  64:	52                   	push   %edx
  65:	52                   	push   %edx
  66:	68 b8 07 00 00       	push   $0x7b8
  6b:	6a 02                	push   $0x2
  6d:	e8 de 03 00 00       	call   450 <printf>
    exit();
  72:	e8 5a 02 00 00       	call   2d1 <exit>
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  80:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  81:	31 d2                	xor    %edx,%edx
{
  83:	89 e5                	mov    %esp,%ebp
  85:	53                   	push   %ebx
  86:	8b 45 08             	mov    0x8(%ebp),%eax
  89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  90:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 c9                	test   %cl,%cl
  9c:	75 f2                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9e:	5b                   	pop    %ebx
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    
  a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  af:	90                   	nop

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	56                   	push   %esi
  b4:	53                   	push   %ebx
  b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
  bb:	0f b6 13             	movzbl (%ebx),%edx
  be:	0f b6 0e             	movzbl (%esi),%ecx
  c1:	84 d2                	test   %dl,%dl
  c3:	74 1e                	je     e3 <strcmp+0x33>
  c5:	b8 01 00 00 00       	mov    $0x1,%eax
  ca:	38 ca                	cmp    %cl,%dl
  cc:	74 09                	je     d7 <strcmp+0x27>
  ce:	eb 20                	jmp    f0 <strcmp+0x40>
  d0:	83 c0 01             	add    $0x1,%eax
  d3:	38 ca                	cmp    %cl,%dl
  d5:	75 19                	jne    f0 <strcmp+0x40>
  d7:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  db:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
  df:	84 d2                	test   %dl,%dl
  e1:	75 ed                	jne    d0 <strcmp+0x20>
  e3:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  e5:	5b                   	pop    %ebx
  e6:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
  e7:	29 c8                	sub    %ecx,%eax
}
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    
  eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ef:	90                   	nop
  f0:	0f b6 c2             	movzbl %dl,%eax
  f3:	5b                   	pop    %ebx
  f4:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
  f5:	29 c8                	sub    %ecx,%eax
}
  f7:	5d                   	pop    %ebp
  f8:	c3                   	ret    
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000100 <strlen>:

uint
strlen(char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 39 00             	cmpb   $0x0,(%ecx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 d2                	xor    %edx,%edx
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 120:	31 c0                	xor    %eax,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 12f:	90                   	nop

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	89 d0                	mov    %edx,%eax
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14e:	66 90                	xchg   %ax,%ax

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 15a:	0f b6 18             	movzbl (%eax),%ebx
 15d:	84 db                	test   %bl,%bl
 15f:	74 1d                	je     17e <strchr+0x2e>
 161:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 163:	38 d3                	cmp    %dl,%bl
 165:	75 0d                	jne    174 <strchr+0x24>
 167:	eb 17                	jmp    180 <strchr+0x30>
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 170:	38 ca                	cmp    %cl,%dl
 172:	74 0c                	je     180 <strchr+0x30>
  for(; *s; s++)
 174:	83 c0 01             	add    $0x1,%eax
 177:	0f b6 10             	movzbl (%eax),%edx
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strchr+0x20>
      return (char*)s;
  return 0;
 17e:	31 c0                	xor    %eax,%eax
}
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 195:	31 f6                	xor    %esi,%esi
{
 197:	53                   	push   %ebx
 198:	89 f3                	mov    %esi,%ebx
 19a:	83 ec 1c             	sub    $0x1c,%esp
 19d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1a0:	eb 2f                	jmp    1d1 <gets+0x41>
 1a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1a8:	83 ec 04             	sub    $0x4,%esp
 1ab:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1ae:	6a 01                	push   $0x1
 1b0:	50                   	push   %eax
 1b1:	6a 00                	push   $0x0
 1b3:	e8 31 01 00 00       	call   2e9 <read>
    if(cc < 1)
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	85 c0                	test   %eax,%eax
 1bd:	7e 1c                	jle    1db <gets+0x4b>
      break;
    buf[i++] = c;
 1bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c3:	83 c7 01             	add    $0x1,%edi
 1c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1c9:	3c 0a                	cmp    $0xa,%al
 1cb:	74 23                	je     1f0 <gets+0x60>
 1cd:	3c 0d                	cmp    $0xd,%al
 1cf:	74 1f                	je     1f0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1d1:	83 c3 01             	add    $0x1,%ebx
 1d4:	89 fe                	mov    %edi,%esi
 1d6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d9:	7c cd                	jl     1a8 <gets+0x18>
 1db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1e0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e6:	5b                   	pop    %ebx
 1e7:	5e                   	pop    %esi
 1e8:	5f                   	pop    %edi
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    
 1eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ef:	90                   	nop
 1f0:	8b 75 08             	mov    0x8(%ebp),%esi
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	01 de                	add    %ebx,%esi
 1f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1fa:	c6 03 00             	movb   $0x0,(%ebx)
}
 1fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 200:	5b                   	pop    %ebx
 201:	5e                   	pop    %esi
 202:	5f                   	pop    %edi
 203:	5d                   	pop    %ebp
 204:	c3                   	ret    
 205:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <stat>:

int
stat(char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 75 08             	pushl  0x8(%ebp)
 21d:	e8 ef 00 00 00       	call   311 <open>
  if(fd < 0)
 222:	83 c4 10             	add    $0x10,%esp
 225:	85 c0                	test   %eax,%eax
 227:	78 27                	js     250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	pushl  0xc(%ebp)
 22f:	89 c3                	mov    %eax,%ebx
 231:	50                   	push   %eax
 232:	e8 f2 00 00 00       	call   329 <fstat>
  close(fd);
 237:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 23a:	89 c6                	mov    %eax,%esi
  close(fd);
 23c:	e8 b8 00 00 00       	call   2f9 <close>
  return r;
 241:	83 c4 10             	add    $0x10,%esp
}
 244:	8d 65 f8             	lea    -0x8(%ebp),%esp
 247:	89 f0                	mov    %esi,%eax
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    
 24d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb ed                	jmp    244 <stat+0x34>
 257:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25e:	66 90                	xchg   %ax,%ax

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 11             	movsbl (%ecx),%edx
 26a:	8d 42 d0             	lea    -0x30(%edx),%eax
 26d:	3c 09                	cmp    $0x9,%al
  n = 0;
 26f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 274:	77 1f                	ja     295 <atoi+0x35>
 276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 27d:	8d 76 00             	lea    0x0(%esi),%esi
    n = n*10 + *s++ - '0';
 280:	83 c1 01             	add    $0x1,%ecx
 283:	8d 04 80             	lea    (%eax,%eax,4),%eax
 286:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 28a:	0f be 11             	movsbl (%ecx),%edx
 28d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
  return n;
}
 295:	5b                   	pop    %ebx
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    
 298:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29f:	90                   	nop

000002a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	8b 55 10             	mov    0x10(%ebp),%edx
 2a7:	8b 45 08             	mov    0x8(%ebp),%eax
 2aa:	56                   	push   %esi
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	85 d2                	test   %edx,%edx
 2b0:	7e 13                	jle    2c5 <memmove+0x25>
 2b2:	01 c2                	add    %eax,%edx
  dst = vdst;
 2b4:	89 c7                	mov    %eax,%edi
 2b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2c1:	39 fa                	cmp    %edi,%edx
 2c3:	75 fb                	jne    2c0 <memmove+0x20>
  return vdst;
}
 2c5:	5e                   	pop    %esi
 2c6:	5f                   	pop    %edi
 2c7:	5d                   	pop    %ebp
 2c8:	c3                   	ret    

000002c9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c9:	b8 01 00 00 00       	mov    $0x1,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <exit>:
SYSCALL(exit)
 2d1:	b8 02 00 00 00       	mov    $0x2,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <wait>:
SYSCALL(wait)
 2d9:	b8 03 00 00 00       	mov    $0x3,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <pipe>:
SYSCALL(pipe)
 2e1:	b8 04 00 00 00       	mov    $0x4,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <read>:
SYSCALL(read)
 2e9:	b8 05 00 00 00       	mov    $0x5,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <write>:
SYSCALL(write)
 2f1:	b8 10 00 00 00       	mov    $0x10,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <close>:
SYSCALL(close)
 2f9:	b8 15 00 00 00       	mov    $0x15,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <kill>:
SYSCALL(kill)
 301:	b8 06 00 00 00       	mov    $0x6,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <exec>:
SYSCALL(exec)
 309:	b8 07 00 00 00       	mov    $0x7,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <open>:
SYSCALL(open)
 311:	b8 0f 00 00 00       	mov    $0xf,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <mknod>:
SYSCALL(mknod)
 319:	b8 11 00 00 00       	mov    $0x11,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <unlink>:
SYSCALL(unlink)
 321:	b8 12 00 00 00       	mov    $0x12,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <fstat>:
SYSCALL(fstat)
 329:	b8 08 00 00 00       	mov    $0x8,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <link>:
SYSCALL(link)
 331:	b8 13 00 00 00       	mov    $0x13,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <mkdir>:
SYSCALL(mkdir)
 339:	b8 14 00 00 00       	mov    $0x14,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <chdir>:
SYSCALL(chdir)
 341:	b8 09 00 00 00       	mov    $0x9,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <dup>:
SYSCALL(dup)
 349:	b8 0a 00 00 00       	mov    $0xa,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <getpid>:
SYSCALL(getpid)
 351:	b8 0b 00 00 00       	mov    $0xb,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <sbrk>:
SYSCALL(sbrk)
 359:	b8 0c 00 00 00       	mov    $0xc,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <sleep>:
SYSCALL(sleep)
 361:	b8 0d 00 00 00       	mov    $0xd,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <uptime>:
SYSCALL(uptime)
 369:	b8 0e 00 00 00       	mov    $0xe,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <date>:
SYSCALL(date)
 371:	b8 16 00 00 00       	mov    $0x16,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <cps>:
SYSCALL(cps)
 379:	b8 17 00 00 00       	mov    $0x17,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <nps>:
SYSCALL(nps)
 381:	b8 18 00 00 00       	mov    $0x18,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    
 389:	66 90                	xchg   %ax,%ax
 38b:	66 90                	xchg   %ax,%ax
 38d:	66 90                	xchg   %ax,%ax
 38f:	90                   	nop

00000390 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 396:	89 d3                	mov    %edx,%ebx
{
 398:	83 ec 3c             	sub    $0x3c,%esp
 39b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 39e:	85 d2                	test   %edx,%edx
 3a0:	0f 89 92 00 00 00    	jns    438 <printint+0xa8>
 3a6:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3aa:	0f 84 88 00 00 00    	je     438 <printint+0xa8>
    neg = 1;
 3b0:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 3b7:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 3b9:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3c0:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3c3:	eb 08                	jmp    3cd <printint+0x3d>
 3c5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3c8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 3cb:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 3cd:	89 d8                	mov    %ebx,%eax
 3cf:	31 d2                	xor    %edx,%edx
 3d1:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 3d4:	f7 f1                	div    %ecx
 3d6:	83 c7 01             	add    $0x1,%edi
 3d9:	0f b6 92 ec 07 00 00 	movzbl 0x7ec(%edx),%edx
 3e0:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 3e3:	39 d9                	cmp    %ebx,%ecx
 3e5:	76 e1                	jbe    3c8 <printint+0x38>
  if(neg)
 3e7:	8b 45 c0             	mov    -0x40(%ebp),%eax
 3ea:	85 c0                	test   %eax,%eax
 3ec:	74 0d                	je     3fb <printint+0x6b>
    buf[i++] = '-';
 3ee:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3f3:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 3f8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 3fb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3fe:	8b 7d bc             	mov    -0x44(%ebp),%edi
 401:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 405:	eb 0f                	jmp    416 <printint+0x86>
 407:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 40e:	66 90                	xchg   %ax,%ax
 410:	0f b6 13             	movzbl (%ebx),%edx
 413:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 416:	83 ec 04             	sub    $0x4,%esp
 419:	88 55 d7             	mov    %dl,-0x29(%ebp)
 41c:	6a 01                	push   $0x1
 41e:	56                   	push   %esi
 41f:	57                   	push   %edi
 420:	e8 cc fe ff ff       	call   2f1 <write>

  while(--i >= 0)
 425:	83 c4 10             	add    $0x10,%esp
 428:	39 de                	cmp    %ebx,%esi
 42a:	75 e4                	jne    410 <printint+0x80>
    putc(fd, buf[i]);
}
 42c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 42f:	5b                   	pop    %ebx
 430:	5e                   	pop    %esi
 431:	5f                   	pop    %edi
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 438:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 43f:	e9 75 ff ff ff       	jmp    3b9 <printint+0x29>
 444:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 44b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 44f:	90                   	nop

00000450 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 459:	8b 75 0c             	mov    0xc(%ebp),%esi
 45c:	0f b6 1e             	movzbl (%esi),%ebx
 45f:	84 db                	test   %bl,%bl
 461:	0f 84 b9 00 00 00    	je     520 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 467:	8d 45 10             	lea    0x10(%ebp),%eax
 46a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 46d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 470:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 472:	89 45 d0             	mov    %eax,-0x30(%ebp)
 475:	eb 38                	jmp    4af <printf+0x5f>
 477:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47e:	66 90                	xchg   %ax,%ax
 480:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 483:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 488:	83 f8 25             	cmp    $0x25,%eax
 48b:	74 17                	je     4a4 <printf+0x54>
  write(fd, &c, 1);
 48d:	83 ec 04             	sub    $0x4,%esp
 490:	88 5d e7             	mov    %bl,-0x19(%ebp)
 493:	6a 01                	push   $0x1
 495:	57                   	push   %edi
 496:	ff 75 08             	pushl  0x8(%ebp)
 499:	e8 53 fe ff ff       	call   2f1 <write>
 49e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 4a1:	83 c4 10             	add    $0x10,%esp
 4a4:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 4a7:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4ab:	84 db                	test   %bl,%bl
 4ad:	74 71                	je     520 <printf+0xd0>
    c = fmt[i] & 0xff;
 4af:	0f be cb             	movsbl %bl,%ecx
 4b2:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4b5:	85 d2                	test   %edx,%edx
 4b7:	74 c7                	je     480 <printf+0x30>
      }
    } else if(state == '%'){
 4b9:	83 fa 25             	cmp    $0x25,%edx
 4bc:	75 e6                	jne    4a4 <printf+0x54>
      if(c == 'd'){
 4be:	83 f8 64             	cmp    $0x64,%eax
 4c1:	0f 84 99 00 00 00    	je     560 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4c7:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4cd:	83 f9 70             	cmp    $0x70,%ecx
 4d0:	74 5e                	je     530 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4d2:	83 f8 73             	cmp    $0x73,%eax
 4d5:	0f 84 d5 00 00 00    	je     5b0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4db:	83 f8 63             	cmp    $0x63,%eax
 4de:	0f 84 8c 00 00 00    	je     570 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4e4:	83 f8 25             	cmp    $0x25,%eax
 4e7:	0f 84 b3 00 00 00    	je     5a0 <printf+0x150>
  write(fd, &c, 1);
 4ed:	83 ec 04             	sub    $0x4,%esp
 4f0:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4f4:	6a 01                	push   $0x1
 4f6:	57                   	push   %edi
 4f7:	ff 75 08             	pushl  0x8(%ebp)
 4fa:	e8 f2 fd ff ff       	call   2f1 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4ff:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 502:	83 c4 0c             	add    $0xc,%esp
 505:	6a 01                	push   $0x1
 507:	83 c6 01             	add    $0x1,%esi
 50a:	57                   	push   %edi
 50b:	ff 75 08             	pushl  0x8(%ebp)
 50e:	e8 de fd ff ff       	call   2f1 <write>
  for(i = 0; fmt[i]; i++){
 513:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 517:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 51a:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 51c:	84 db                	test   %bl,%bl
 51e:	75 8f                	jne    4af <printf+0x5f>
    }
  }
}
 520:	8d 65 f4             	lea    -0xc(%ebp),%esp
 523:	5b                   	pop    %ebx
 524:	5e                   	pop    %esi
 525:	5f                   	pop    %edi
 526:	5d                   	pop    %ebp
 527:	c3                   	ret    
 528:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52f:	90                   	nop
        printint(fd, *ap, 16, 0);
 530:	83 ec 0c             	sub    $0xc,%esp
 533:	b9 10 00 00 00       	mov    $0x10,%ecx
 538:	6a 00                	push   $0x0
 53a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 53d:	8b 45 08             	mov    0x8(%ebp),%eax
 540:	8b 13                	mov    (%ebx),%edx
 542:	e8 49 fe ff ff       	call   390 <printint>
        ap++;
 547:	89 d8                	mov    %ebx,%eax
 549:	83 c4 10             	add    $0x10,%esp
      state = 0;
 54c:	31 d2                	xor    %edx,%edx
        ap++;
 54e:	83 c0 04             	add    $0x4,%eax
 551:	89 45 d0             	mov    %eax,-0x30(%ebp)
 554:	e9 4b ff ff ff       	jmp    4a4 <printf+0x54>
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 560:	83 ec 0c             	sub    $0xc,%esp
 563:	b9 0a 00 00 00       	mov    $0xa,%ecx
 568:	6a 01                	push   $0x1
 56a:	eb ce                	jmp    53a <printf+0xea>
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 570:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 573:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 576:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 578:	6a 01                	push   $0x1
        ap++;
 57a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 57d:	57                   	push   %edi
 57e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 581:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 584:	e8 68 fd ff ff       	call   2f1 <write>
        ap++;
 589:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 58c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 58f:	31 d2                	xor    %edx,%edx
 591:	e9 0e ff ff ff       	jmp    4a4 <printf+0x54>
 596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 5a0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5a3:	83 ec 04             	sub    $0x4,%esp
 5a6:	e9 5a ff ff ff       	jmp    505 <printf+0xb5>
 5ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop
        s = (char*)*ap;
 5b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5b3:	8b 18                	mov    (%eax),%ebx
        ap++;
 5b5:	83 c0 04             	add    $0x4,%eax
 5b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5bb:	85 db                	test   %ebx,%ebx
 5bd:	74 17                	je     5d6 <printf+0x186>
        while(*s != 0){
 5bf:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 5c2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 5c4:	84 c0                	test   %al,%al
 5c6:	0f 84 d8 fe ff ff    	je     4a4 <printf+0x54>
 5cc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5cf:	89 de                	mov    %ebx,%esi
 5d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5d4:	eb 1a                	jmp    5f0 <printf+0x1a0>
          s = "(null)";
 5d6:	bb e5 07 00 00       	mov    $0x7e5,%ebx
        while(*s != 0){
 5db:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5de:	b8 28 00 00 00       	mov    $0x28,%eax
 5e3:	89 de                	mov    %ebx,%esi
 5e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ef:	90                   	nop
  write(fd, &c, 1);
 5f0:	83 ec 04             	sub    $0x4,%esp
          s++;
 5f3:	83 c6 01             	add    $0x1,%esi
 5f6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5f9:	6a 01                	push   $0x1
 5fb:	57                   	push   %edi
 5fc:	53                   	push   %ebx
 5fd:	e8 ef fc ff ff       	call   2f1 <write>
        while(*s != 0){
 602:	0f b6 06             	movzbl (%esi),%eax
 605:	83 c4 10             	add    $0x10,%esp
 608:	84 c0                	test   %al,%al
 60a:	75 e4                	jne    5f0 <printf+0x1a0>
 60c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 60f:	31 d2                	xor    %edx,%edx
 611:	e9 8e fe ff ff       	jmp    4a4 <printf+0x54>
 616:	66 90                	xchg   %ax,%ax
 618:	66 90                	xchg   %ax,%ax
 61a:	66 90                	xchg   %ax,%ax
 61c:	66 90                	xchg   %ax,%ax
 61e:	66 90                	xchg   %ax,%ax

00000620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 620:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	a1 a4 0a 00 00       	mov    0xaa4,%eax
{
 626:	89 e5                	mov    %esp,%ebp
 628:	57                   	push   %edi
 629:	56                   	push   %esi
 62a:	53                   	push   %ebx
 62b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 62e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 630:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 633:	39 c8                	cmp    %ecx,%eax
 635:	73 19                	jae    650 <free+0x30>
 637:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63e:	66 90                	xchg   %ax,%ax
 640:	39 d1                	cmp    %edx,%ecx
 642:	72 14                	jb     658 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 644:	39 d0                	cmp    %edx,%eax
 646:	73 10                	jae    658 <free+0x38>
{
 648:	89 d0                	mov    %edx,%eax
 64a:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 64c:	39 c8                	cmp    %ecx,%eax
 64e:	72 f0                	jb     640 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 650:	39 d0                	cmp    %edx,%eax
 652:	72 f4                	jb     648 <free+0x28>
 654:	39 d1                	cmp    %edx,%ecx
 656:	73 f0                	jae    648 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 658:	8b 73 fc             	mov    -0x4(%ebx),%esi
 65b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 65e:	39 fa                	cmp    %edi,%edx
 660:	74 1e                	je     680 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 662:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 665:	8b 50 04             	mov    0x4(%eax),%edx
 668:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 66b:	39 f1                	cmp    %esi,%ecx
 66d:	74 28                	je     697 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 66f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 671:	5b                   	pop    %ebx
  freep = p;
 672:	a3 a4 0a 00 00       	mov    %eax,0xaa4
}
 677:	5e                   	pop    %esi
 678:	5f                   	pop    %edi
 679:	5d                   	pop    %ebp
 67a:	c3                   	ret    
 67b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 67f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 680:	03 72 04             	add    0x4(%edx),%esi
 683:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 686:	8b 10                	mov    (%eax),%edx
 688:	8b 12                	mov    (%edx),%edx
 68a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 68d:	8b 50 04             	mov    0x4(%eax),%edx
 690:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 693:	39 f1                	cmp    %esi,%ecx
 695:	75 d8                	jne    66f <free+0x4f>
    p->s.size += bp->s.size;
 697:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 69a:	a3 a4 0a 00 00       	mov    %eax,0xaa4
    p->s.size += bp->s.size;
 69f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6a2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6a5:	89 10                	mov    %edx,(%eax)
}
 6a7:	5b                   	pop    %ebx
 6a8:	5e                   	pop    %esi
 6a9:	5f                   	pop    %edi
 6aa:	5d                   	pop    %ebp
 6ab:	c3                   	ret    
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6bc:	8b 3d a4 0a 00 00    	mov    0xaa4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c2:	8d 70 07             	lea    0x7(%eax),%esi
 6c5:	c1 ee 03             	shr    $0x3,%esi
 6c8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 6cb:	85 ff                	test   %edi,%edi
 6cd:	0f 84 ad 00 00 00    	je     780 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 6d5:	8b 4a 04             	mov    0x4(%edx),%ecx
 6d8:	39 f1                	cmp    %esi,%ecx
 6da:	73 72                	jae    74e <malloc+0x9e>
 6dc:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6e2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6e7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 6ea:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 6f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 6f4:	eb 1b                	jmp    711 <malloc+0x61>
 6f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 700:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 702:	8b 48 04             	mov    0x4(%eax),%ecx
 705:	39 f1                	cmp    %esi,%ecx
 707:	73 4f                	jae    758 <malloc+0xa8>
 709:	8b 3d a4 0a 00 00    	mov    0xaa4,%edi
 70f:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 711:	39 d7                	cmp    %edx,%edi
 713:	75 eb                	jne    700 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 715:	83 ec 0c             	sub    $0xc,%esp
 718:	ff 75 e4             	pushl  -0x1c(%ebp)
 71b:	e8 39 fc ff ff       	call   359 <sbrk>
  if(p == (char*)-1)
 720:	83 c4 10             	add    $0x10,%esp
 723:	83 f8 ff             	cmp    $0xffffffff,%eax
 726:	74 1c                	je     744 <malloc+0x94>
  hp->s.size = nu;
 728:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 72b:	83 ec 0c             	sub    $0xc,%esp
 72e:	83 c0 08             	add    $0x8,%eax
 731:	50                   	push   %eax
 732:	e8 e9 fe ff ff       	call   620 <free>
  return freep;
 737:	8b 15 a4 0a 00 00    	mov    0xaa4,%edx
      if((p = morecore(nunits)) == 0)
 73d:	83 c4 10             	add    $0x10,%esp
 740:	85 d2                	test   %edx,%edx
 742:	75 bc                	jne    700 <malloc+0x50>
        return 0;
  }
}
 744:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 747:	31 c0                	xor    %eax,%eax
}
 749:	5b                   	pop    %ebx
 74a:	5e                   	pop    %esi
 74b:	5f                   	pop    %edi
 74c:	5d                   	pop    %ebp
 74d:	c3                   	ret    
    if(p->s.size >= nunits){
 74e:	89 d0                	mov    %edx,%eax
 750:	89 fa                	mov    %edi,%edx
 752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 758:	39 ce                	cmp    %ecx,%esi
 75a:	74 54                	je     7b0 <malloc+0x100>
        p->s.size -= nunits;
 75c:	29 f1                	sub    %esi,%ecx
 75e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 761:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 764:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 767:	89 15 a4 0a 00 00    	mov    %edx,0xaa4
}
 76d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 770:	83 c0 08             	add    $0x8,%eax
}
 773:	5b                   	pop    %ebx
 774:	5e                   	pop    %esi
 775:	5f                   	pop    %edi
 776:	5d                   	pop    %ebp
 777:	c3                   	ret    
 778:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 780:	c7 05 a4 0a 00 00 a8 	movl   $0xaa8,0xaa4
 787:	0a 00 00 
    base.s.size = 0;
 78a:	bf a8 0a 00 00       	mov    $0xaa8,%edi
    base.s.ptr = freep = prevp = &base;
 78f:	c7 05 a8 0a 00 00 a8 	movl   $0xaa8,0xaa8
 796:	0a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 799:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 79b:	c7 05 ac 0a 00 00 00 	movl   $0x0,0xaac
 7a2:	00 00 00 
    if(p->s.size >= nunits){
 7a5:	e9 32 ff ff ff       	jmp    6dc <malloc+0x2c>
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 7b0:	8b 08                	mov    (%eax),%ecx
 7b2:	89 0a                	mov    %ecx,(%edx)
 7b4:	eb b1                	jmp    767 <malloc+0xb7>
