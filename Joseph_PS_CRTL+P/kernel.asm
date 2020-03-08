
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 b0 2f 10 80       	mov    $0x80102fb0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 60 71 10 80       	push   $0x80107160
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 35 44 00 00       	call   80104490 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
  bcache.head.prev = &bcache.head;
80100063:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	83 ec 08             	sub    $0x8,%esp
80100085:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 71 10 80       	push   $0x80107167
80100097:	50                   	push   %eax
80100098:	e8 e3 42 00 00       	call   80104380 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
801000a2:	89 da                	mov    %ebx,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a4:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 7d 08             	mov    0x8(%ebp),%edi
801000dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 a7 44 00 00       	call   80104590 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 49 45 00 00       	call   801046b0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 4e 42 00 00       	call   801043c0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 6f 20 00 00       	call   80102200 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
  panic("bget: no buffers");
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 6e 71 10 80       	push   $0x8010716e
801001a8:	e8 e3 01 00 00       	call   80100390 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 9d 42 00 00       	call   80104460 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 27 20 00 00       	jmp    80102200 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 7f 71 10 80       	push   $0x8010717f
801001e1:	e8 aa 01 00 00       	call   80100390 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 5c 42 00 00       	call   80104460 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 0c 42 00 00       	call   80104420 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010021b:	e8 70 43 00 00       	call   80104590 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 3f 44 00 00       	jmp    801046b0 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 86 71 10 80       	push   $0x80107186
80100279:	e8 12 01 00 00       	call   80100390 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
80100289:	ff 75 08             	pushl  0x8(%ebp)
{
8010028c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010028f:	e8 6c 15 00 00       	call   80101800 <iunlock>
  target = n;
  acquire(&cons.lock);
80100294:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010029b:	e8 f0 42 00 00       	call   80104590 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002a0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while(n > 0){
801002a3:	83 c4 10             	add    $0x10,%esp
801002a6:	31 c0                	xor    %eax,%eax
    *dst++ = c;
801002a8:	01 f7                	add    %esi,%edi
  while(n > 0){
801002aa:	85 f6                	test   %esi,%esi
801002ac:	0f 8e a0 00 00 00    	jle    80100352 <consoleread+0xd2>
801002b2:	89 f3                	mov    %esi,%ebx
    while(input.r == input.w){
801002b4:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002ba:	39 15 a4 ff 10 80    	cmp    %edx,0x8010ffa4
801002c0:	74 29                	je     801002eb <consoleread+0x6b>
801002c2:	eb 5c                	jmp    80100320 <consoleread+0xa0>
801002c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      sleep(&input.r, &cons.lock);
801002c8:	83 ec 08             	sub    $0x8,%esp
801002cb:	68 20 a5 10 80       	push   $0x8010a520
801002d0:	68 a0 ff 10 80       	push   $0x8010ffa0
801002d5:	e8 b6 3b 00 00       	call   80103e90 <sleep>
    while(input.r == input.w){
801002da:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002e0:	83 c4 10             	add    $0x10,%esp
801002e3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002e9:	75 35                	jne    80100320 <consoleread+0xa0>
      if(myproc()->killed){
801002eb:	e8 00 36 00 00       	call   801038f0 <myproc>
801002f0:	8b 48 30             	mov    0x30(%eax),%ecx
801002f3:	85 c9                	test   %ecx,%ecx
801002f5:	74 d1                	je     801002c8 <consoleread+0x48>
        release(&cons.lock);
801002f7:	83 ec 0c             	sub    $0xc,%esp
801002fa:	68 20 a5 10 80       	push   $0x8010a520
801002ff:	e8 ac 43 00 00       	call   801046b0 <release>
        ilock(ip);
80100304:	5a                   	pop    %edx
80100305:	ff 75 08             	pushl  0x8(%ebp)
80100308:	e8 13 14 00 00       	call   80101720 <ilock>
        return -1;
8010030d:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100310:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100313:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100318:	5b                   	pop    %ebx
80100319:	5e                   	pop    %esi
8010031a:	5f                   	pop    %edi
8010031b:	5d                   	pop    %ebp
8010031c:	c3                   	ret    
8010031d:	8d 76 00             	lea    0x0(%esi),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100320:	8d 42 01             	lea    0x1(%edx),%eax
80100323:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100328:	89 d0                	mov    %edx,%eax
8010032a:	83 e0 7f             	and    $0x7f,%eax
8010032d:	0f be 80 20 ff 10 80 	movsbl -0x7fef00e0(%eax),%eax
    if(c == C('D')){  // EOF
80100334:	83 f8 04             	cmp    $0x4,%eax
80100337:	74 46                	je     8010037f <consoleread+0xff>
    *dst++ = c;
80100339:	89 da                	mov    %ebx,%edx
    --n;
8010033b:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
8010033e:	f7 da                	neg    %edx
80100340:	88 04 17             	mov    %al,(%edi,%edx,1)
    if(c == '\n')
80100343:	83 f8 0a             	cmp    $0xa,%eax
80100346:	74 31                	je     80100379 <consoleread+0xf9>
  while(n > 0){
80100348:	85 db                	test   %ebx,%ebx
8010034a:	0f 85 64 ff ff ff    	jne    801002b4 <consoleread+0x34>
80100350:	89 f0                	mov    %esi,%eax
  release(&cons.lock);
80100352:	83 ec 0c             	sub    $0xc,%esp
80100355:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100358:	68 20 a5 10 80       	push   $0x8010a520
8010035d:	e8 4e 43 00 00       	call   801046b0 <release>
  ilock(ip);
80100362:	58                   	pop    %eax
80100363:	ff 75 08             	pushl  0x8(%ebp)
80100366:	e8 b5 13 00 00       	call   80101720 <ilock>
  return target - n;
8010036b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010036e:	83 c4 10             	add    $0x10,%esp
}
80100371:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100374:	5b                   	pop    %ebx
80100375:	5e                   	pop    %esi
80100376:	5f                   	pop    %edi
80100377:	5d                   	pop    %ebp
80100378:	c3                   	ret    
80100379:	89 f0                	mov    %esi,%eax
8010037b:	29 d8                	sub    %ebx,%eax
8010037d:	eb d3                	jmp    80100352 <consoleread+0xd2>
      if(n < target){
8010037f:	89 f0                	mov    %esi,%eax
80100381:	29 d8                	sub    %ebx,%eax
80100383:	39 f3                	cmp    %esi,%ebx
80100385:	73 cb                	jae    80100352 <consoleread+0xd2>
        input.r--;
80100387:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
8010038d:	eb c3                	jmp    80100352 <consoleread+0xd2>
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 82 24 00 00       	call   80102830 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 8d 71 10 80       	push   $0x8010718d
801003b7:	e8 f4 02 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 eb 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 e3 7b 10 80 	movl   $0x80107be3,(%esp)
801003cc:	e8 df 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	8d 45 08             	lea    0x8(%ebp),%eax
801003d4:	5a                   	pop    %edx
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 d3 40 00 00       	call   801044b0 <getcallerpcs>
  for(i=0; i<10; i++)
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 79 77 10 80       	push   $0x80107779
801003ed:	e8 be 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100400:	00 00 00 
    ;
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010040c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100410 <consputc.part.0>:
consputc(int c)
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	89 c3                	mov    %eax,%ebx
80100418:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 ea 00 00 00    	je     80100510 <consputc.part.0+0x100>
    uartputc(c);
80100426:	83 ec 0c             	sub    $0xc,%esp
80100429:	50                   	push   %eax
8010042a:	e8 51 59 00 00       	call   80105d80 <uartputc>
8010042f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100432:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100437:	b8 0e 00 00 00       	mov    $0xe,%eax
8010043c:	89 fa                	mov    %edi,%edx
8010043e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010043f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100444:	89 ca                	mov    %ecx,%edx
80100446:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100447:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010044a:	89 fa                	mov    %edi,%edx
8010044c:	c1 e0 08             	shl    $0x8,%eax
8010044f:	89 c6                	mov    %eax,%esi
80100451:	b8 0f 00 00 00       	mov    $0xf,%eax
80100456:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100457:	89 ca                	mov    %ecx,%edx
80100459:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010045a:	0f b6 c0             	movzbl %al,%eax
8010045d:	09 f0                	or     %esi,%eax
  if(c == '\n')
8010045f:	83 fb 0a             	cmp    $0xa,%ebx
80100462:	0f 84 90 00 00 00    	je     801004f8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100468:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010046e:	74 70                	je     801004e0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100470:	0f b6 db             	movzbl %bl,%ebx
80100473:	8d 70 01             	lea    0x1(%eax),%esi
80100476:	80 cf 07             	or     $0x7,%bh
80100479:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100480:	80 
  if(pos < 0 || pos > 25*80)
80100481:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100487:	0f 8f f9 00 00 00    	jg     80100586 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010048d:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100493:	0f 8f a7 00 00 00    	jg     80100540 <consputc.part.0+0x130>
80100499:	89 f0                	mov    %esi,%eax
8010049b:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
801004a2:	88 45 e7             	mov    %al,-0x19(%ebp)
801004a5:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004a8:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801004ad:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004ba:	89 f8                	mov    %edi,%eax
801004bc:	89 ca                	mov    %ecx,%edx
801004be:	ee                   	out    %al,(%dx)
801004bf:	b8 0f 00 00 00       	mov    $0xf,%eax
801004c4:	89 da                	mov    %ebx,%edx
801004c6:	ee                   	out    %al,(%dx)
801004c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004cb:	89 ca                	mov    %ecx,%edx
801004cd:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004ce:	b8 20 07 00 00       	mov    $0x720,%eax
801004d3:	66 89 06             	mov    %ax,(%esi)
}
801004d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004d9:	5b                   	pop    %ebx
801004da:	5e                   	pop    %esi
801004db:	5f                   	pop    %edi
801004dc:	5d                   	pop    %ebp
801004dd:	c3                   	ret    
801004de:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
801004e0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004e3:	85 c0                	test   %eax,%eax
801004e5:	75 9a                	jne    80100481 <consputc.part.0+0x71>
801004e7:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004ec:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004f0:	31 ff                	xor    %edi,%edi
801004f2:	eb b4                	jmp    801004a8 <consputc.part.0+0x98>
801004f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004f8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004fd:	f7 e2                	mul    %edx
801004ff:	c1 ea 06             	shr    $0x6,%edx
80100502:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100505:	c1 e0 04             	shl    $0x4,%eax
80100508:	8d 70 50             	lea    0x50(%eax),%esi
8010050b:	e9 71 ff ff ff       	jmp    80100481 <consputc.part.0+0x71>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100510:	83 ec 0c             	sub    $0xc,%esp
80100513:	6a 08                	push   $0x8
80100515:	e8 66 58 00 00       	call   80105d80 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 5a 58 00 00       	call   80105d80 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 4e 58 00 00       	call   80105d80 <uartputc>
80100532:	83 c4 10             	add    $0x10,%esp
80100535:	e9 f8 fe ff ff       	jmp    80100432 <consputc.part.0+0x22>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010054b:	68 60 0e 00 00       	push   $0xe60
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100550:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 3a 42 00 00       	call   801047a0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 85 41 00 00       	call   80104700 <memset>
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 22 ff ff ff       	jmp    801004a8 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100586:	83 ec 0c             	sub    $0xc,%esp
80100589:	68 a1 71 10 80       	push   $0x801071a1
8010058e:	e8 fd fd ff ff       	call   80100390 <panic>
80100593:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010059a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801005a0 <printint>:
{
801005a0:	55                   	push   %ebp
801005a1:	89 e5                	mov    %esp,%ebp
801005a3:	57                   	push   %edi
801005a4:	56                   	push   %esi
801005a5:	53                   	push   %ebx
801005a6:	83 ec 2c             	sub    $0x2c,%esp
801005a9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
801005ac:	85 c9                	test   %ecx,%ecx
801005ae:	74 04                	je     801005b4 <printint+0x14>
801005b0:	85 c0                	test   %eax,%eax
801005b2:	78 68                	js     8010061c <printint+0x7c>
    x = xx;
801005b4:	89 c1                	mov    %eax,%ecx
801005b6:	31 f6                	xor    %esi,%esi
  i = 0;
801005b8:	31 db                	xor    %ebx,%ebx
801005ba:	eb 04                	jmp    801005c0 <printint+0x20>
  }while((x /= base) != 0);
801005bc:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
801005be:	89 fb                	mov    %edi,%ebx
801005c0:	89 c8                	mov    %ecx,%eax
801005c2:	31 d2                	xor    %edx,%edx
801005c4:	8d 7b 01             	lea    0x1(%ebx),%edi
801005c7:	f7 75 d4             	divl   -0x2c(%ebp)
801005ca:	0f b6 92 cc 71 10 80 	movzbl -0x7fef8e34(%edx),%edx
801005d1:	88 54 3d d7          	mov    %dl,-0x29(%ebp,%edi,1)
  }while((x /= base) != 0);
801005d5:	39 4d d4             	cmp    %ecx,-0x2c(%ebp)
801005d8:	76 e2                	jbe    801005bc <printint+0x1c>
  if(sign)
801005da:	85 f6                	test   %esi,%esi
801005dc:	75 32                	jne    80100610 <printint+0x70>
801005de:	0f be c2             	movsbl %dl,%eax
801005e1:	89 df                	mov    %ebx,%edi
  if(panicked){
801005e3:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801005e9:	85 c9                	test   %ecx,%ecx
801005eb:	75 20                	jne    8010060d <printint+0x6d>
801005ed:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005f1:	e8 1a fe ff ff       	call   80100410 <consputc.part.0>
  while(--i >= 0)
801005f6:	8d 45 d7             	lea    -0x29(%ebp),%eax
801005f9:	39 d8                	cmp    %ebx,%eax
801005fb:	74 27                	je     80100624 <printint+0x84>
  if(panicked){
801005fd:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
    consputc(buf[i]);
80100603:	0f be 03             	movsbl (%ebx),%eax
  if(panicked){
80100606:	83 eb 01             	sub    $0x1,%ebx
80100609:	85 d2                	test   %edx,%edx
8010060b:	74 e4                	je     801005f1 <printint+0x51>
  asm volatile("cli");
8010060d:	fa                   	cli    
      ;
8010060e:	eb fe                	jmp    8010060e <printint+0x6e>
    buf[i++] = '-';
80100610:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
80100615:	b8 2d 00 00 00       	mov    $0x2d,%eax
8010061a:	eb c7                	jmp    801005e3 <printint+0x43>
    x = -xx;
8010061c:	f7 d8                	neg    %eax
8010061e:	89 ce                	mov    %ecx,%esi
80100620:	89 c1                	mov    %eax,%ecx
80100622:	eb 94                	jmp    801005b8 <printint+0x18>
}
80100624:	83 c4 2c             	add    $0x2c,%esp
80100627:	5b                   	pop    %ebx
80100628:	5e                   	pop    %esi
80100629:	5f                   	pop    %edi
8010062a:	5d                   	pop    %ebp
8010062b:	c3                   	ret    
8010062c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100630 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100630:	55                   	push   %ebp
80100631:	89 e5                	mov    %esp,%ebp
80100633:	57                   	push   %edi
80100634:	56                   	push   %esi
80100635:	53                   	push   %ebx
80100636:	83 ec 18             	sub    $0x18,%esp
80100639:	8b 7d 10             	mov    0x10(%ebp),%edi
8010063c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int i;

  iunlock(ip);
8010063f:	ff 75 08             	pushl  0x8(%ebp)
80100642:	e8 b9 11 00 00       	call   80101800 <iunlock>
  acquire(&cons.lock);
80100647:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010064e:	e8 3d 3f 00 00       	call   80104590 <acquire>
  for(i = 0; i < n; i++)
80100653:	83 c4 10             	add    $0x10,%esp
80100656:	85 ff                	test   %edi,%edi
80100658:	7e 36                	jle    80100690 <consolewrite+0x60>
  if(panicked){
8010065a:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100660:	85 c9                	test   %ecx,%ecx
80100662:	75 21                	jne    80100685 <consolewrite+0x55>
    consputc(buf[i] & 0xff);
80100664:	0f b6 03             	movzbl (%ebx),%eax
80100667:	8d 73 01             	lea    0x1(%ebx),%esi
8010066a:	01 fb                	add    %edi,%ebx
8010066c:	e8 9f fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; i < n; i++)
80100671:	39 de                	cmp    %ebx,%esi
80100673:	74 1b                	je     80100690 <consolewrite+0x60>
  if(panicked){
80100675:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
    consputc(buf[i] & 0xff);
8010067b:	0f b6 06             	movzbl (%esi),%eax
  if(panicked){
8010067e:	83 c6 01             	add    $0x1,%esi
80100681:	85 d2                	test   %edx,%edx
80100683:	74 e7                	je     8010066c <consolewrite+0x3c>
80100685:	fa                   	cli    
      ;
80100686:	eb fe                	jmp    80100686 <consolewrite+0x56>
80100688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010068f:	90                   	nop
  release(&cons.lock);
80100690:	83 ec 0c             	sub    $0xc,%esp
80100693:	68 20 a5 10 80       	push   $0x8010a520
80100698:	e8 13 40 00 00       	call   801046b0 <release>
  ilock(ip);
8010069d:	58                   	pop    %eax
8010069e:	ff 75 08             	pushl  0x8(%ebp)
801006a1:	e8 7a 10 00 00       	call   80101720 <ilock>

  return n;
}
801006a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006a9:	89 f8                	mov    %edi,%eax
801006ab:	5b                   	pop    %ebx
801006ac:	5e                   	pop    %esi
801006ad:	5f                   	pop    %edi
801006ae:	5d                   	pop    %ebp
801006af:	c3                   	ret    

801006b0 <cprintf>:
{
801006b0:	55                   	push   %ebp
801006b1:	89 e5                	mov    %esp,%ebp
801006b3:	57                   	push   %edi
801006b4:	56                   	push   %esi
801006b5:	53                   	push   %ebx
801006b6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006b9:	a1 54 a5 10 80       	mov    0x8010a554,%eax
801006be:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801006c1:	85 c0                	test   %eax,%eax
801006c3:	0f 85 df 00 00 00    	jne    801007a8 <cprintf+0xf8>
  if (fmt == 0)
801006c9:	8b 45 08             	mov    0x8(%ebp),%eax
801006cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006cf:	85 c0                	test   %eax,%eax
801006d1:	0f 84 5e 01 00 00    	je     80100835 <cprintf+0x185>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d7:	0f b6 00             	movzbl (%eax),%eax
801006da:	85 c0                	test   %eax,%eax
801006dc:	74 32                	je     80100710 <cprintf+0x60>
  argp = (uint*)(void*)(&fmt + 1);
801006de:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e1:	31 f6                	xor    %esi,%esi
    if(c != '%'){
801006e3:	83 f8 25             	cmp    $0x25,%eax
801006e6:	74 40                	je     80100728 <cprintf+0x78>
  if(panicked){
801006e8:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801006ee:	85 c9                	test   %ecx,%ecx
801006f0:	74 0b                	je     801006fd <cprintf+0x4d>
801006f2:	fa                   	cli    
      ;
801006f3:	eb fe                	jmp    801006f3 <cprintf+0x43>
801006f5:	8d 76 00             	lea    0x0(%esi),%esi
801006f8:	b8 25 00 00 00       	mov    $0x25,%eax
801006fd:	e8 0e fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100702:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100705:	83 c6 01             	add    $0x1,%esi
80100708:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
8010070c:	85 c0                	test   %eax,%eax
8010070e:	75 d3                	jne    801006e3 <cprintf+0x33>
  if(locking)
80100710:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100713:	85 db                	test   %ebx,%ebx
80100715:	0f 85 05 01 00 00    	jne    80100820 <cprintf+0x170>
}
8010071b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010071e:	5b                   	pop    %ebx
8010071f:	5e                   	pop    %esi
80100720:	5f                   	pop    %edi
80100721:	5d                   	pop    %ebp
80100722:	c3                   	ret    
80100723:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100727:	90                   	nop
    c = fmt[++i] & 0xff;
80100728:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010072b:	83 c6 01             	add    $0x1,%esi
8010072e:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
    if(c == 0)
80100732:	85 ff                	test   %edi,%edi
80100734:	74 da                	je     80100710 <cprintf+0x60>
    switch(c){
80100736:	83 ff 70             	cmp    $0x70,%edi
80100739:	0f 84 7e 00 00 00    	je     801007bd <cprintf+0x10d>
8010073f:	7f 26                	jg     80100767 <cprintf+0xb7>
80100741:	83 ff 25             	cmp    $0x25,%edi
80100744:	0f 84 be 00 00 00    	je     80100808 <cprintf+0x158>
8010074a:	83 ff 64             	cmp    $0x64,%edi
8010074d:	75 46                	jne    80100795 <cprintf+0xe5>
      printint(*argp++, 10, 1);
8010074f:	8b 03                	mov    (%ebx),%eax
80100751:	8d 7b 04             	lea    0x4(%ebx),%edi
80100754:	b9 01 00 00 00       	mov    $0x1,%ecx
80100759:	ba 0a 00 00 00       	mov    $0xa,%edx
8010075e:	89 fb                	mov    %edi,%ebx
80100760:	e8 3b fe ff ff       	call   801005a0 <printint>
      break;
80100765:	eb 9b                	jmp    80100702 <cprintf+0x52>
    switch(c){
80100767:	83 ff 73             	cmp    $0x73,%edi
8010076a:	75 24                	jne    80100790 <cprintf+0xe0>
      if((s = (char*)*argp++) == 0)
8010076c:	8d 7b 04             	lea    0x4(%ebx),%edi
8010076f:	8b 1b                	mov    (%ebx),%ebx
80100771:	85 db                	test   %ebx,%ebx
80100773:	75 68                	jne    801007dd <cprintf+0x12d>
80100775:	b8 28 00 00 00       	mov    $0x28,%eax
        s = "(null)";
8010077a:	bb b4 71 10 80       	mov    $0x801071b4,%ebx
  if(panicked){
8010077f:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100785:	85 d2                	test   %edx,%edx
80100787:	74 4c                	je     801007d5 <cprintf+0x125>
80100789:	fa                   	cli    
      ;
8010078a:	eb fe                	jmp    8010078a <cprintf+0xda>
8010078c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100790:	83 ff 78             	cmp    $0x78,%edi
80100793:	74 28                	je     801007bd <cprintf+0x10d>
  if(panicked){
80100795:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
8010079b:	85 d2                	test   %edx,%edx
8010079d:	74 4c                	je     801007eb <cprintf+0x13b>
8010079f:	fa                   	cli    
      ;
801007a0:	eb fe                	jmp    801007a0 <cprintf+0xf0>
801007a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&cons.lock);
801007a8:	83 ec 0c             	sub    $0xc,%esp
801007ab:	68 20 a5 10 80       	push   $0x8010a520
801007b0:	e8 db 3d 00 00       	call   80104590 <acquire>
801007b5:	83 c4 10             	add    $0x10,%esp
801007b8:	e9 0c ff ff ff       	jmp    801006c9 <cprintf+0x19>
      printint(*argp++, 16, 0);
801007bd:	8b 03                	mov    (%ebx),%eax
801007bf:	8d 7b 04             	lea    0x4(%ebx),%edi
801007c2:	31 c9                	xor    %ecx,%ecx
801007c4:	ba 10 00 00 00       	mov    $0x10,%edx
801007c9:	89 fb                	mov    %edi,%ebx
801007cb:	e8 d0 fd ff ff       	call   801005a0 <printint>
      break;
801007d0:	e9 2d ff ff ff       	jmp    80100702 <cprintf+0x52>
801007d5:	e8 36 fc ff ff       	call   80100410 <consputc.part.0>
      for(; *s; s++)
801007da:	83 c3 01             	add    $0x1,%ebx
801007dd:	0f be 03             	movsbl (%ebx),%eax
801007e0:	84 c0                	test   %al,%al
801007e2:	75 9b                	jne    8010077f <cprintf+0xcf>
      if((s = (char*)*argp++) == 0)
801007e4:	89 fb                	mov    %edi,%ebx
801007e6:	e9 17 ff ff ff       	jmp    80100702 <cprintf+0x52>
801007eb:	b8 25 00 00 00       	mov    $0x25,%eax
801007f0:	e8 1b fc ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
801007f5:	a1 58 a5 10 80       	mov    0x8010a558,%eax
801007fa:	85 c0                	test   %eax,%eax
801007fc:	74 4a                	je     80100848 <cprintf+0x198>
801007fe:	fa                   	cli    
      ;
801007ff:	eb fe                	jmp    801007ff <cprintf+0x14f>
80100801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
80100808:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
8010080e:	85 c9                	test   %ecx,%ecx
80100810:	0f 84 e2 fe ff ff    	je     801006f8 <cprintf+0x48>
80100816:	fa                   	cli    
      ;
80100817:	eb fe                	jmp    80100817 <cprintf+0x167>
80100819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&cons.lock);
80100820:	83 ec 0c             	sub    $0xc,%esp
80100823:	68 20 a5 10 80       	push   $0x8010a520
80100828:	e8 83 3e 00 00       	call   801046b0 <release>
8010082d:	83 c4 10             	add    $0x10,%esp
}
80100830:	e9 e6 fe ff ff       	jmp    8010071b <cprintf+0x6b>
    panic("null fmt");
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 bb 71 10 80       	push   $0x801071bb
8010083d:	e8 4e fb ff ff       	call   80100390 <panic>
80100842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100848:	89 f8                	mov    %edi,%eax
8010084a:	e8 c1 fb ff ff       	call   80100410 <consputc.part.0>
8010084f:	e9 ae fe ff ff       	jmp    80100702 <cprintf+0x52>
80100854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010085b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010085f:	90                   	nop

80100860 <consoleintr>:
{
80100860:	55                   	push   %ebp
80100861:	89 e5                	mov    %esp,%ebp
80100863:	57                   	push   %edi
80100864:	56                   	push   %esi
  int c, doprocdump = 0;
80100865:	31 f6                	xor    %esi,%esi
{
80100867:	53                   	push   %ebx
80100868:	83 ec 18             	sub    $0x18,%esp
8010086b:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
8010086e:	68 20 a5 10 80       	push   $0x8010a520
80100873:	e8 18 3d 00 00       	call   80104590 <acquire>
  while((c = getc()) >= 0){
80100878:	83 c4 10             	add    $0x10,%esp
8010087b:	ff d7                	call   *%edi
8010087d:	89 c3                	mov    %eax,%ebx
8010087f:	85 c0                	test   %eax,%eax
80100881:	0f 88 38 01 00 00    	js     801009bf <consoleintr+0x15f>
    switch(c){
80100887:	83 fb 10             	cmp    $0x10,%ebx
8010088a:	0f 84 f0 00 00 00    	je     80100980 <consoleintr+0x120>
80100890:	0f 8e ba 00 00 00    	jle    80100950 <consoleintr+0xf0>
80100896:	83 fb 15             	cmp    $0x15,%ebx
80100899:	75 35                	jne    801008d0 <consoleintr+0x70>
      while(input.e != input.w &&
8010089b:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008a0:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
801008a6:	74 d3                	je     8010087b <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008a8:	83 e8 01             	sub    $0x1,%eax
801008ab:	89 c2                	mov    %eax,%edx
801008ad:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
801008b0:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
801008b7:	74 c2                	je     8010087b <consoleintr+0x1b>
  if(panicked){
801008b9:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
        input.e--;
801008bf:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
  if(panicked){
801008c4:	85 d2                	test   %edx,%edx
801008c6:	0f 84 be 00 00 00    	je     8010098a <consoleintr+0x12a>
801008cc:	fa                   	cli    
      ;
801008cd:	eb fe                	jmp    801008cd <consoleintr+0x6d>
801008cf:	90                   	nop
    switch(c){
801008d0:	83 fb 7f             	cmp    $0x7f,%ebx
801008d3:	0f 84 7c 00 00 00    	je     80100955 <consoleintr+0xf5>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008d9:	85 db                	test   %ebx,%ebx
801008db:	74 9e                	je     8010087b <consoleintr+0x1b>
801008dd:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008e2:	89 c2                	mov    %eax,%edx
801008e4:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
801008ea:	83 fa 7f             	cmp    $0x7f,%edx
801008ed:	77 8c                	ja     8010087b <consoleintr+0x1b>
        c = (c == '\r') ? '\n' : c;
801008ef:	8d 48 01             	lea    0x1(%eax),%ecx
801008f2:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801008f8:	83 e0 7f             	and    $0x7f,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
801008fb:	89 0d a8 ff 10 80    	mov    %ecx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
80100901:	83 fb 0d             	cmp    $0xd,%ebx
80100904:	0f 84 d1 00 00 00    	je     801009db <consoleintr+0x17b>
        input.buf[input.e++ % INPUT_BUF] = c;
8010090a:	88 98 20 ff 10 80    	mov    %bl,-0x7fef00e0(%eax)
  if(panicked){
80100910:	85 d2                	test   %edx,%edx
80100912:	0f 85 ce 00 00 00    	jne    801009e6 <consoleintr+0x186>
80100918:	89 d8                	mov    %ebx,%eax
8010091a:	e8 f1 fa ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
8010091f:	83 fb 0a             	cmp    $0xa,%ebx
80100922:	0f 84 d2 00 00 00    	je     801009fa <consoleintr+0x19a>
80100928:	83 fb 04             	cmp    $0x4,%ebx
8010092b:	0f 84 c9 00 00 00    	je     801009fa <consoleintr+0x19a>
80100931:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
80100936:	83 e8 80             	sub    $0xffffff80,%eax
80100939:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
8010093f:	0f 85 36 ff ff ff    	jne    8010087b <consoleintr+0x1b>
80100945:	e9 b5 00 00 00       	jmp    801009ff <consoleintr+0x19f>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100950:	83 fb 08             	cmp    $0x8,%ebx
80100953:	75 84                	jne    801008d9 <consoleintr+0x79>
      if(input.e != input.w){
80100955:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010095a:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100960:	0f 84 15 ff ff ff    	je     8010087b <consoleintr+0x1b>
        input.e--;
80100966:	83 e8 01             	sub    $0x1,%eax
80100969:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
  if(panicked){
8010096e:	a1 58 a5 10 80       	mov    0x8010a558,%eax
80100973:	85 c0                	test   %eax,%eax
80100975:	74 39                	je     801009b0 <consoleintr+0x150>
80100977:	fa                   	cli    
      ;
80100978:	eb fe                	jmp    80100978 <consoleintr+0x118>
8010097a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      doprocdump = 1;
80100980:	be 01 00 00 00       	mov    $0x1,%esi
80100985:	e9 f1 fe ff ff       	jmp    8010087b <consoleintr+0x1b>
8010098a:	b8 00 01 00 00       	mov    $0x100,%eax
8010098f:	e8 7c fa ff ff       	call   80100410 <consputc.part.0>
      while(input.e != input.w &&
80100994:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100999:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010099f:	0f 85 03 ff ff ff    	jne    801008a8 <consoleintr+0x48>
801009a5:	e9 d1 fe ff ff       	jmp    8010087b <consoleintr+0x1b>
801009aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801009b0:	b8 00 01 00 00       	mov    $0x100,%eax
801009b5:	e8 56 fa ff ff       	call   80100410 <consputc.part.0>
801009ba:	e9 bc fe ff ff       	jmp    8010087b <consoleintr+0x1b>
  release(&cons.lock);
801009bf:	83 ec 0c             	sub    $0xc,%esp
801009c2:	68 20 a5 10 80       	push   $0x8010a520
801009c7:	e8 e4 3c 00 00       	call   801046b0 <release>
  if(doprocdump) {
801009cc:	83 c4 10             	add    $0x10,%esp
801009cf:	85 f6                	test   %esi,%esi
801009d1:	75 46                	jne    80100a19 <consoleintr+0x1b9>
}
801009d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009d6:	5b                   	pop    %ebx
801009d7:	5e                   	pop    %esi
801009d8:	5f                   	pop    %edi
801009d9:	5d                   	pop    %ebp
801009da:	c3                   	ret    
        input.buf[input.e++ % INPUT_BUF] = c;
801009db:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
  if(panicked){
801009e2:	85 d2                	test   %edx,%edx
801009e4:	74 0a                	je     801009f0 <consoleintr+0x190>
801009e6:	fa                   	cli    
      ;
801009e7:	eb fe                	jmp    801009e7 <consoleintr+0x187>
801009e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009f0:	b8 0a 00 00 00       	mov    $0xa,%eax
801009f5:	e8 16 fa ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009fa:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
          wakeup(&input.r);
801009ff:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a02:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100a07:	68 a0 ff 10 80       	push   $0x8010ffa0
80100a0c:	e8 3f 36 00 00       	call   80104050 <wakeup>
80100a11:	83 c4 10             	add    $0x10,%esp
80100a14:	e9 62 fe ff ff       	jmp    8010087b <consoleintr+0x1b>
}
80100a19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a1c:	5b                   	pop    %ebx
80100a1d:	5e                   	pop    %esi
80100a1e:	5f                   	pop    %edi
80100a1f:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a20:	e9 0b 37 00 00       	jmp    80104130 <procdump>
80100a25:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100a30 <consoleinit>:

void
consoleinit(void)
{
80100a30:	55                   	push   %ebp
80100a31:	89 e5                	mov    %esp,%ebp
80100a33:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a36:	68 c4 71 10 80       	push   $0x801071c4
80100a3b:	68 20 a5 10 80       	push   $0x8010a520
80100a40:	e8 4b 3a 00 00       	call   80104490 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a45:	58                   	pop    %eax
80100a46:	5a                   	pop    %edx
80100a47:	6a 00                	push   $0x0
80100a49:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a4b:	c7 05 6c 09 11 80 30 	movl   $0x80100630,0x8011096c
80100a52:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100a55:	c7 05 68 09 11 80 80 	movl   $0x80100280,0x80110968
80100a5c:	02 10 80 
  cons.locking = 1;
80100a5f:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100a66:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a69:	e8 42 19 00 00       	call   801023b0 <ioapicenable>
}
80100a6e:	83 c4 10             	add    $0x10,%esp
80100a71:	c9                   	leave  
80100a72:	c3                   	ret    
80100a73:	66 90                	xchg   %ax,%ax
80100a75:	66 90                	xchg   %ax,%ax
80100a77:	66 90                	xchg   %ax,%ax
80100a79:	66 90                	xchg   %ax,%ax
80100a7b:	66 90                	xchg   %ax,%ax
80100a7d:	66 90                	xchg   %ax,%ax
80100a7f:	90                   	nop

80100a80 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a80:	55                   	push   %ebp
80100a81:	89 e5                	mov    %esp,%ebp
80100a83:	57                   	push   %edi
80100a84:	56                   	push   %esi
80100a85:	53                   	push   %ebx
80100a86:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a8c:	e8 5f 2e 00 00       	call   801038f0 <myproc>
80100a91:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100a97:	e8 04 22 00 00       	call   80102ca0 <begin_op>

  if((ip = namei(path)) == 0){
80100a9c:	83 ec 0c             	sub    $0xc,%esp
80100a9f:	ff 75 08             	pushl  0x8(%ebp)
80100aa2:	e8 19 15 00 00       	call   80101fc0 <namei>
80100aa7:	83 c4 10             	add    $0x10,%esp
80100aaa:	85 c0                	test   %eax,%eax
80100aac:	0f 84 02 03 00 00    	je     80100db4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ab2:	83 ec 0c             	sub    $0xc,%esp
80100ab5:	89 c3                	mov    %eax,%ebx
80100ab7:	50                   	push   %eax
80100ab8:	e8 63 0c 00 00       	call   80101720 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100abd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100ac3:	6a 34                	push   $0x34
80100ac5:	6a 00                	push   $0x0
80100ac7:	50                   	push   %eax
80100ac8:	53                   	push   %ebx
80100ac9:	e8 32 0f 00 00       	call   80101a00 <readi>
80100ace:	83 c4 20             	add    $0x20,%esp
80100ad1:	83 f8 34             	cmp    $0x34,%eax
80100ad4:	74 22                	je     80100af8 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ad6:	83 ec 0c             	sub    $0xc,%esp
80100ad9:	53                   	push   %ebx
80100ada:	e8 d1 0e 00 00       	call   801019b0 <iunlockput>
    end_op();
80100adf:	e8 2c 22 00 00       	call   80102d10 <end_op>
80100ae4:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100ae7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100aec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100aef:	5b                   	pop    %ebx
80100af0:	5e                   	pop    %esi
80100af1:	5f                   	pop    %edi
80100af2:	5d                   	pop    %ebp
80100af3:	c3                   	ret    
80100af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100af8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100aff:	45 4c 46 
80100b02:	75 d2                	jne    80100ad6 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100b04:	e8 c7 63 00 00       	call   80106ed0 <setupkvm>
80100b09:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b0f:	85 c0                	test   %eax,%eax
80100b11:	74 c3                	je     80100ad6 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b13:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b1a:	00 
80100b1b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b21:	0f 84 ac 02 00 00    	je     80100dd3 <exec+0x353>
  sz = 0;
80100b27:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b2e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b31:	31 ff                	xor    %edi,%edi
80100b33:	e9 8e 00 00 00       	jmp    80100bc6 <exec+0x146>
80100b38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b3f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80100b40:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b47:	75 6c                	jne    80100bb5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100b49:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b4f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b55:	0f 82 87 00 00 00    	jb     80100be2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b5b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b61:	72 7f                	jb     80100be2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b63:	83 ec 04             	sub    $0x4,%esp
80100b66:	50                   	push   %eax
80100b67:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b6d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b73:	e8 78 61 00 00       	call   80106cf0 <allocuvm>
80100b78:	83 c4 10             	add    $0x10,%esp
80100b7b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b81:	85 c0                	test   %eax,%eax
80100b83:	74 5d                	je     80100be2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100b85:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b8b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b90:	75 50                	jne    80100be2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b92:	83 ec 0c             	sub    $0xc,%esp
80100b95:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b9b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100ba1:	53                   	push   %ebx
80100ba2:	50                   	push   %eax
80100ba3:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ba9:	e8 82 60 00 00       	call   80106c30 <loaduvm>
80100bae:	83 c4 20             	add    $0x20,%esp
80100bb1:	85 c0                	test   %eax,%eax
80100bb3:	78 2d                	js     80100be2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bb5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bbc:	83 c7 01             	add    $0x1,%edi
80100bbf:	83 c6 20             	add    $0x20,%esi
80100bc2:	39 f8                	cmp    %edi,%eax
80100bc4:	7e 3a                	jle    80100c00 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bc6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bcc:	6a 20                	push   $0x20
80100bce:	56                   	push   %esi
80100bcf:	50                   	push   %eax
80100bd0:	53                   	push   %ebx
80100bd1:	e8 2a 0e 00 00       	call   80101a00 <readi>
80100bd6:	83 c4 10             	add    $0x10,%esp
80100bd9:	83 f8 20             	cmp    $0x20,%eax
80100bdc:	0f 84 5e ff ff ff    	je     80100b40 <exec+0xc0>
    freevm(pgdir);
80100be2:	83 ec 0c             	sub    $0xc,%esp
80100be5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100beb:	e8 60 62 00 00       	call   80106e50 <freevm>
  if(ip){
80100bf0:	83 c4 10             	add    $0x10,%esp
80100bf3:	e9 de fe ff ff       	jmp    80100ad6 <exec+0x56>
80100bf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100bff:	90                   	nop
80100c00:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100c06:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c0c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c12:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c18:	83 ec 0c             	sub    $0xc,%esp
80100c1b:	53                   	push   %ebx
80100c1c:	e8 8f 0d 00 00       	call   801019b0 <iunlockput>
  end_op();
80100c21:	e8 ea 20 00 00       	call   80102d10 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c26:	83 c4 0c             	add    $0xc,%esp
80100c29:	56                   	push   %esi
80100c2a:	57                   	push   %edi
80100c2b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c31:	57                   	push   %edi
80100c32:	e8 b9 60 00 00       	call   80106cf0 <allocuvm>
80100c37:	83 c4 10             	add    $0x10,%esp
80100c3a:	89 c6                	mov    %eax,%esi
80100c3c:	85 c0                	test   %eax,%eax
80100c3e:	0f 84 94 00 00 00    	je     80100cd8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c44:	83 ec 08             	sub    $0x8,%esp
80100c47:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100c4d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c4f:	50                   	push   %eax
80100c50:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100c51:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c53:	e8 18 63 00 00       	call   80106f70 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c58:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c5b:	83 c4 10             	add    $0x10,%esp
80100c5e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c64:	8b 00                	mov    (%eax),%eax
80100c66:	85 c0                	test   %eax,%eax
80100c68:	0f 84 8b 00 00 00    	je     80100cf9 <exec+0x279>
80100c6e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100c74:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c7a:	eb 23                	jmp    80100c9f <exec+0x21f>
80100c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c80:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c83:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c8a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c8d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c93:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c96:	85 c0                	test   %eax,%eax
80100c98:	74 59                	je     80100cf3 <exec+0x273>
    if(argc >= MAXARG)
80100c9a:	83 ff 20             	cmp    $0x20,%edi
80100c9d:	74 39                	je     80100cd8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c9f:	83 ec 0c             	sub    $0xc,%esp
80100ca2:	50                   	push   %eax
80100ca3:	e8 68 3c 00 00       	call   80104910 <strlen>
80100ca8:	f7 d0                	not    %eax
80100caa:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cac:	58                   	pop    %eax
80100cad:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cb0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cb3:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cb6:	e8 55 3c 00 00       	call   80104910 <strlen>
80100cbb:	83 c0 01             	add    $0x1,%eax
80100cbe:	50                   	push   %eax
80100cbf:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cc2:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cc5:	53                   	push   %ebx
80100cc6:	56                   	push   %esi
80100cc7:	e8 f4 63 00 00       	call   801070c0 <copyout>
80100ccc:	83 c4 20             	add    $0x20,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	79 ad                	jns    80100c80 <exec+0x200>
80100cd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cd7:	90                   	nop
    freevm(pgdir);
80100cd8:	83 ec 0c             	sub    $0xc,%esp
80100cdb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ce1:	e8 6a 61 00 00       	call   80106e50 <freevm>
80100ce6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100ce9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cee:	e9 f9 fd ff ff       	jmp    80100aec <exec+0x6c>
80100cf3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cf9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d00:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d02:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d09:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d0d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d0f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100d12:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100d18:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d1a:	50                   	push   %eax
80100d1b:	52                   	push   %edx
80100d1c:	53                   	push   %ebx
80100d1d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d23:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d2a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d2d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d33:	e8 88 63 00 00       	call   801070c0 <copyout>
80100d38:	83 c4 10             	add    $0x10,%esp
80100d3b:	85 c0                	test   %eax,%eax
80100d3d:	78 99                	js     80100cd8 <exec+0x258>
  for(last=s=path; *s; s++)
80100d3f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d42:	8b 55 08             	mov    0x8(%ebp),%edx
80100d45:	0f b6 00             	movzbl (%eax),%eax
80100d48:	84 c0                	test   %al,%al
80100d4a:	74 13                	je     80100d5f <exec+0x2df>
80100d4c:	89 d1                	mov    %edx,%ecx
80100d4e:	66 90                	xchg   %ax,%ax
    if(*s == '/')
80100d50:	83 c1 01             	add    $0x1,%ecx
80100d53:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d55:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80100d58:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d5b:	84 c0                	test   %al,%al
80100d5d:	75 f1                	jne    80100d50 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d5f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d65:	83 ec 04             	sub    $0x4,%esp
80100d68:	6a 10                	push   $0x10
80100d6a:	89 f8                	mov    %edi,%eax
80100d6c:	52                   	push   %edx
80100d6d:	83 c0 78             	add    $0x78,%eax
80100d70:	50                   	push   %eax
80100d71:	e8 5a 3b 00 00       	call   801048d0 <safestrcpy>
  curproc->pgdir = pgdir;
80100d76:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100d7c:	89 f8                	mov    %edi,%eax
80100d7e:	8b 7f 10             	mov    0x10(%edi),%edi
  curproc->sz = sz;
80100d81:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100d83:	89 48 10             	mov    %ecx,0x10(%eax)
  curproc->tf->eip = elf.entry;  // main
80100d86:	89 c1                	mov    %eax,%ecx
80100d88:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d8e:	8b 40 24             	mov    0x24(%eax),%eax
80100d91:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d94:	8b 41 24             	mov    0x24(%ecx),%eax
80100d97:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d9a:	89 0c 24             	mov    %ecx,(%esp)
80100d9d:	e8 fe 5c 00 00       	call   80106aa0 <switchuvm>
  freevm(oldpgdir);
80100da2:	89 3c 24             	mov    %edi,(%esp)
80100da5:	e8 a6 60 00 00       	call   80106e50 <freevm>
  return 0;
80100daa:	83 c4 10             	add    $0x10,%esp
80100dad:	31 c0                	xor    %eax,%eax
80100daf:	e9 38 fd ff ff       	jmp    80100aec <exec+0x6c>
    end_op();
80100db4:	e8 57 1f 00 00       	call   80102d10 <end_op>
    cprintf("exec: fail\n");
80100db9:	83 ec 0c             	sub    $0xc,%esp
80100dbc:	68 dd 71 10 80       	push   $0x801071dd
80100dc1:	e8 ea f8 ff ff       	call   801006b0 <cprintf>
    return -1;
80100dc6:	83 c4 10             	add    $0x10,%esp
80100dc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dce:	e9 19 fd ff ff       	jmp    80100aec <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100dd3:	31 ff                	xor    %edi,%edi
80100dd5:	be 00 20 00 00       	mov    $0x2000,%esi
80100dda:	e9 39 fe ff ff       	jmp    80100c18 <exec+0x198>
80100ddf:	90                   	nop

80100de0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100de6:	68 e9 71 10 80       	push   $0x801071e9
80100deb:	68 c0 ff 10 80       	push   $0x8010ffc0
80100df0:	e8 9b 36 00 00       	call   80104490 <initlock>
}
80100df5:	83 c4 10             	add    $0x10,%esp
80100df8:	c9                   	leave  
80100df9:	c3                   	ret    
80100dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e00 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e00:	55                   	push   %ebp
80100e01:	89 e5                	mov    %esp,%ebp
80100e03:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e04:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100e09:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e0c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e11:	e8 7a 37 00 00       	call   80104590 <acquire>
80100e16:	83 c4 10             	add    $0x10,%esp
80100e19:	eb 10                	jmp    80100e2b <filealloc+0x2b>
80100e1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e1f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e20:	83 c3 18             	add    $0x18,%ebx
80100e23:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100e29:	74 25                	je     80100e50 <filealloc+0x50>
    if(f->ref == 0){
80100e2b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e2e:	85 c0                	test   %eax,%eax
80100e30:	75 ee                	jne    80100e20 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e32:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e35:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e3c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e41:	e8 6a 38 00 00       	call   801046b0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e46:	89 d8                	mov    %ebx,%eax
      return f;
80100e48:	83 c4 10             	add    $0x10,%esp
}
80100e4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e4e:	c9                   	leave  
80100e4f:	c3                   	ret    
  release(&ftable.lock);
80100e50:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e53:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e55:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e5a:	e8 51 38 00 00       	call   801046b0 <release>
}
80100e5f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e61:	83 c4 10             	add    $0x10,%esp
}
80100e64:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e67:	c9                   	leave  
80100e68:	c3                   	ret    
80100e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e70 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e70:	55                   	push   %ebp
80100e71:	89 e5                	mov    %esp,%ebp
80100e73:	53                   	push   %ebx
80100e74:	83 ec 10             	sub    $0x10,%esp
80100e77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e7a:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e7f:	e8 0c 37 00 00       	call   80104590 <acquire>
  if(f->ref < 1)
80100e84:	8b 43 04             	mov    0x4(%ebx),%eax
80100e87:	83 c4 10             	add    $0x10,%esp
80100e8a:	85 c0                	test   %eax,%eax
80100e8c:	7e 1a                	jle    80100ea8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e8e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e91:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e94:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e97:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e9c:	e8 0f 38 00 00       	call   801046b0 <release>
  return f;
}
80100ea1:	89 d8                	mov    %ebx,%eax
80100ea3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ea6:	c9                   	leave  
80100ea7:	c3                   	ret    
    panic("filedup");
80100ea8:	83 ec 0c             	sub    $0xc,%esp
80100eab:	68 f0 71 10 80       	push   $0x801071f0
80100eb0:	e8 db f4 ff ff       	call   80100390 <panic>
80100eb5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ec0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	57                   	push   %edi
80100ec4:	56                   	push   %esi
80100ec5:	53                   	push   %ebx
80100ec6:	83 ec 28             	sub    $0x28,%esp
80100ec9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100ecc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100ed1:	e8 ba 36 00 00       	call   80104590 <acquire>
  if(f->ref < 1)
80100ed6:	8b 43 04             	mov    0x4(%ebx),%eax
80100ed9:	83 c4 10             	add    $0x10,%esp
80100edc:	85 c0                	test   %eax,%eax
80100ede:	0f 8e a3 00 00 00    	jle    80100f87 <fileclose+0xc7>
    panic("fileclose");
  if(--f->ref > 0){
80100ee4:	83 e8 01             	sub    $0x1,%eax
80100ee7:	89 43 04             	mov    %eax,0x4(%ebx)
80100eea:	75 44                	jne    80100f30 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100eec:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ef0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ef3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100ef5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100efb:	8b 73 0c             	mov    0xc(%ebx),%esi
80100efe:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f01:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f04:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100f09:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f0c:	e8 9f 37 00 00       	call   801046b0 <release>

  if(ff.type == FD_PIPE)
80100f11:	83 c4 10             	add    $0x10,%esp
80100f14:	83 ff 01             	cmp    $0x1,%edi
80100f17:	74 2f                	je     80100f48 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f19:	83 ff 02             	cmp    $0x2,%edi
80100f1c:	74 4a                	je     80100f68 <fileclose+0xa8>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f21:	5b                   	pop    %ebx
80100f22:	5e                   	pop    %esi
80100f23:	5f                   	pop    %edi
80100f24:	5d                   	pop    %ebp
80100f25:	c3                   	ret    
80100f26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f2d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80100f30:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
}
80100f37:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f3a:	5b                   	pop    %ebx
80100f3b:	5e                   	pop    %esi
80100f3c:	5f                   	pop    %edi
80100f3d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f3e:	e9 6d 37 00 00       	jmp    801046b0 <release>
80100f43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f47:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80100f48:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f4c:	83 ec 08             	sub    $0x8,%esp
80100f4f:	53                   	push   %ebx
80100f50:	56                   	push   %esi
80100f51:	e8 fa 24 00 00       	call   80103450 <pipeclose>
80100f56:	83 c4 10             	add    $0x10,%esp
}
80100f59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f5c:	5b                   	pop    %ebx
80100f5d:	5e                   	pop    %esi
80100f5e:	5f                   	pop    %edi
80100f5f:	5d                   	pop    %ebp
80100f60:	c3                   	ret    
80100f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100f68:	e8 33 1d 00 00       	call   80102ca0 <begin_op>
    iput(ff.ip);
80100f6d:	83 ec 0c             	sub    $0xc,%esp
80100f70:	ff 75 e0             	pushl  -0x20(%ebp)
80100f73:	e8 d8 08 00 00       	call   80101850 <iput>
    end_op();
80100f78:	83 c4 10             	add    $0x10,%esp
}
80100f7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f7e:	5b                   	pop    %ebx
80100f7f:	5e                   	pop    %esi
80100f80:	5f                   	pop    %edi
80100f81:	5d                   	pop    %ebp
    end_op();
80100f82:	e9 89 1d 00 00       	jmp    80102d10 <end_op>
    panic("fileclose");
80100f87:	83 ec 0c             	sub    $0xc,%esp
80100f8a:	68 f8 71 10 80       	push   $0x801071f8
80100f8f:	e8 fc f3 ff ff       	call   80100390 <panic>
80100f94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f9f:	90                   	nop

80100fa0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fa0:	55                   	push   %ebp
80100fa1:	89 e5                	mov    %esp,%ebp
80100fa3:	53                   	push   %ebx
80100fa4:	83 ec 04             	sub    $0x4,%esp
80100fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100faa:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fad:	75 31                	jne    80100fe0 <filestat+0x40>
    ilock(f->ip);
80100faf:	83 ec 0c             	sub    $0xc,%esp
80100fb2:	ff 73 10             	pushl  0x10(%ebx)
80100fb5:	e8 66 07 00 00       	call   80101720 <ilock>
    stati(f->ip, st);
80100fba:	58                   	pop    %eax
80100fbb:	5a                   	pop    %edx
80100fbc:	ff 75 0c             	pushl  0xc(%ebp)
80100fbf:	ff 73 10             	pushl  0x10(%ebx)
80100fc2:	e8 09 0a 00 00       	call   801019d0 <stati>
    iunlock(f->ip);
80100fc7:	59                   	pop    %ecx
80100fc8:	ff 73 10             	pushl  0x10(%ebx)
80100fcb:	e8 30 08 00 00       	call   80101800 <iunlock>
    return 0;
80100fd0:	83 c4 10             	add    $0x10,%esp
80100fd3:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100fd5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fd8:	c9                   	leave  
80100fd9:	c3                   	ret    
80100fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100fe5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fe8:	c9                   	leave  
80100fe9:	c3                   	ret    
80100fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ff0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 0c             	sub    $0xc,%esp
80100ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100ffc:	8b 75 0c             	mov    0xc(%ebp),%esi
80100fff:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101002:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101006:	74 60                	je     80101068 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101008:	8b 03                	mov    (%ebx),%eax
8010100a:	83 f8 01             	cmp    $0x1,%eax
8010100d:	74 41                	je     80101050 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010100f:	83 f8 02             	cmp    $0x2,%eax
80101012:	75 5b                	jne    8010106f <fileread+0x7f>
    ilock(f->ip);
80101014:	83 ec 0c             	sub    $0xc,%esp
80101017:	ff 73 10             	pushl  0x10(%ebx)
8010101a:	e8 01 07 00 00       	call   80101720 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010101f:	57                   	push   %edi
80101020:	ff 73 14             	pushl  0x14(%ebx)
80101023:	56                   	push   %esi
80101024:	ff 73 10             	pushl  0x10(%ebx)
80101027:	e8 d4 09 00 00       	call   80101a00 <readi>
8010102c:	83 c4 20             	add    $0x20,%esp
8010102f:	89 c6                	mov    %eax,%esi
80101031:	85 c0                	test   %eax,%eax
80101033:	7e 03                	jle    80101038 <fileread+0x48>
      f->off += r;
80101035:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101038:	83 ec 0c             	sub    $0xc,%esp
8010103b:	ff 73 10             	pushl  0x10(%ebx)
8010103e:	e8 bd 07 00 00       	call   80101800 <iunlock>
    return r;
80101043:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101046:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101049:	89 f0                	mov    %esi,%eax
8010104b:	5b                   	pop    %ebx
8010104c:	5e                   	pop    %esi
8010104d:	5f                   	pop    %edi
8010104e:	5d                   	pop    %ebp
8010104f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101050:	8b 43 0c             	mov    0xc(%ebx),%eax
80101053:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101056:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101059:	5b                   	pop    %ebx
8010105a:	5e                   	pop    %esi
8010105b:	5f                   	pop    %edi
8010105c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010105d:	e9 9e 25 00 00       	jmp    80103600 <piperead>
80101062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101068:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010106d:	eb d7                	jmp    80101046 <fileread+0x56>
  panic("fileread");
8010106f:	83 ec 0c             	sub    $0xc,%esp
80101072:	68 02 72 10 80       	push   $0x80107202
80101077:	e8 14 f3 ff ff       	call   80100390 <panic>
8010107c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101080 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101080:	55                   	push   %ebp
80101081:	89 e5                	mov    %esp,%ebp
80101083:	57                   	push   %edi
80101084:	56                   	push   %esi
80101085:	53                   	push   %ebx
80101086:	83 ec 1c             	sub    $0x1c,%esp
80101089:	8b 45 0c             	mov    0xc(%ebp),%eax
8010108c:	8b 75 08             	mov    0x8(%ebp),%esi
8010108f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101092:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101095:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101099:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010109c:	0f 84 bb 00 00 00    	je     8010115d <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
801010a2:	8b 06                	mov    (%esi),%eax
801010a4:	83 f8 01             	cmp    $0x1,%eax
801010a7:	0f 84 bf 00 00 00    	je     8010116c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010ad:	83 f8 02             	cmp    $0x2,%eax
801010b0:	0f 85 c8 00 00 00    	jne    8010117e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010b9:	31 ff                	xor    %edi,%edi
    while(i < n){
801010bb:	85 c0                	test   %eax,%eax
801010bd:	7f 30                	jg     801010ef <filewrite+0x6f>
801010bf:	e9 94 00 00 00       	jmp    80101158 <filewrite+0xd8>
801010c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010c8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801010cb:	83 ec 0c             	sub    $0xc,%esp
801010ce:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801010d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801010d4:	e8 27 07 00 00       	call   80101800 <iunlock>
      end_op();
801010d9:	e8 32 1c 00 00       	call   80102d10 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801010de:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010e1:	83 c4 10             	add    $0x10,%esp
801010e4:	39 c3                	cmp    %eax,%ebx
801010e6:	75 60                	jne    80101148 <filewrite+0xc8>
        panic("short filewrite");
      i += r;
801010e8:	01 df                	add    %ebx,%edi
    while(i < n){
801010ea:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010ed:	7e 69                	jle    80101158 <filewrite+0xd8>
      int n1 = n - i;
801010ef:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010f2:	b8 00 06 00 00       	mov    $0x600,%eax
801010f7:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
801010f9:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801010ff:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101102:	e8 99 1b 00 00       	call   80102ca0 <begin_op>
      ilock(f->ip);
80101107:	83 ec 0c             	sub    $0xc,%esp
8010110a:	ff 76 10             	pushl  0x10(%esi)
8010110d:	e8 0e 06 00 00       	call   80101720 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101112:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101115:	53                   	push   %ebx
80101116:	ff 76 14             	pushl  0x14(%esi)
80101119:	01 f8                	add    %edi,%eax
8010111b:	50                   	push   %eax
8010111c:	ff 76 10             	pushl  0x10(%esi)
8010111f:	e8 dc 09 00 00       	call   80101b00 <writei>
80101124:	83 c4 20             	add    $0x20,%esp
80101127:	85 c0                	test   %eax,%eax
80101129:	7f 9d                	jg     801010c8 <filewrite+0x48>
      iunlock(f->ip);
8010112b:	83 ec 0c             	sub    $0xc,%esp
8010112e:	ff 76 10             	pushl  0x10(%esi)
80101131:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101134:	e8 c7 06 00 00       	call   80101800 <iunlock>
      end_op();
80101139:	e8 d2 1b 00 00       	call   80102d10 <end_op>
      if(r < 0)
8010113e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101141:	83 c4 10             	add    $0x10,%esp
80101144:	85 c0                	test   %eax,%eax
80101146:	75 15                	jne    8010115d <filewrite+0xdd>
        panic("short filewrite");
80101148:	83 ec 0c             	sub    $0xc,%esp
8010114b:	68 0b 72 10 80       	push   $0x8010720b
80101150:	e8 3b f2 ff ff       	call   80100390 <panic>
80101155:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101158:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
8010115b:	74 05                	je     80101162 <filewrite+0xe2>
    return -1;
8010115d:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  }
  panic("filewrite");
}
80101162:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101165:	89 f8                	mov    %edi,%eax
80101167:	5b                   	pop    %ebx
80101168:	5e                   	pop    %esi
80101169:	5f                   	pop    %edi
8010116a:	5d                   	pop    %ebp
8010116b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
8010116c:	8b 46 0c             	mov    0xc(%esi),%eax
8010116f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101172:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101175:	5b                   	pop    %ebx
80101176:	5e                   	pop    %esi
80101177:	5f                   	pop    %edi
80101178:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101179:	e9 72 23 00 00       	jmp    801034f0 <pipewrite>
  panic("filewrite");
8010117e:	83 ec 0c             	sub    $0xc,%esp
80101181:	68 11 72 10 80       	push   $0x80107211
80101186:	e8 05 f2 ff ff       	call   80100390 <panic>
8010118b:	66 90                	xchg   %ax,%ax
8010118d:	66 90                	xchg   %ax,%ax
8010118f:	90                   	nop

80101190 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101190:	55                   	push   %ebp
80101191:	89 e5                	mov    %esp,%ebp
80101193:	57                   	push   %edi
80101194:	56                   	push   %esi
80101195:	53                   	push   %ebx
80101196:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101199:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
{
8010119f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801011a2:	85 c9                	test   %ecx,%ecx
801011a4:	0f 84 87 00 00 00    	je     80101231 <balloc+0xa1>
801011aa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011b1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011b4:	83 ec 08             	sub    $0x8,%esp
801011b7:	89 f0                	mov    %esi,%eax
801011b9:	c1 f8 0c             	sar    $0xc,%eax
801011bc:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801011c2:	50                   	push   %eax
801011c3:	ff 75 d8             	pushl  -0x28(%ebp)
801011c6:	e8 05 ef ff ff       	call   801000d0 <bread>
801011cb:	83 c4 10             	add    $0x10,%esp
801011ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011d1:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011d9:	31 c0                	xor    %eax,%eax
801011db:	eb 2f                	jmp    8010120c <balloc+0x7c>
801011dd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011e0:	89 c1                	mov    %eax,%ecx
801011e2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801011ea:	83 e1 07             	and    $0x7,%ecx
801011ed:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011ef:	89 c1                	mov    %eax,%ecx
801011f1:	c1 f9 03             	sar    $0x3,%ecx
801011f4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801011f9:	89 fa                	mov    %edi,%edx
801011fb:	85 df                	test   %ebx,%edi
801011fd:	74 41                	je     80101240 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011ff:	83 c0 01             	add    $0x1,%eax
80101202:	83 c6 01             	add    $0x1,%esi
80101205:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010120a:	74 05                	je     80101211 <balloc+0x81>
8010120c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010120f:	77 cf                	ja     801011e0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101211:	83 ec 0c             	sub    $0xc,%esp
80101214:	ff 75 e4             	pushl  -0x1c(%ebp)
80101217:	e8 d4 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010121c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101223:	83 c4 10             	add    $0x10,%esp
80101226:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101229:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010122f:	77 80                	ja     801011b1 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101231:	83 ec 0c             	sub    $0xc,%esp
80101234:	68 1b 72 10 80       	push   $0x8010721b
80101239:	e8 52 f1 ff ff       	call   80100390 <panic>
8010123e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101240:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101243:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101246:	09 da                	or     %ebx,%edx
80101248:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010124c:	57                   	push   %edi
8010124d:	e8 2e 1c 00 00       	call   80102e80 <log_write>
        brelse(bp);
80101252:	89 3c 24             	mov    %edi,(%esp)
80101255:	e8 96 ef ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010125a:	58                   	pop    %eax
8010125b:	5a                   	pop    %edx
8010125c:	56                   	push   %esi
8010125d:	ff 75 d8             	pushl  -0x28(%ebp)
80101260:	e8 6b ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101265:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101268:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010126a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010126d:	68 00 02 00 00       	push   $0x200
80101272:	6a 00                	push   $0x0
80101274:	50                   	push   %eax
80101275:	e8 86 34 00 00       	call   80104700 <memset>
  log_write(bp);
8010127a:	89 1c 24             	mov    %ebx,(%esp)
8010127d:	e8 fe 1b 00 00       	call   80102e80 <log_write>
  brelse(bp);
80101282:	89 1c 24             	mov    %ebx,(%esp)
80101285:	e8 66 ef ff ff       	call   801001f0 <brelse>
}
8010128a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010128d:	89 f0                	mov    %esi,%eax
8010128f:	5b                   	pop    %ebx
80101290:	5e                   	pop    %esi
80101291:	5f                   	pop    %edi
80101292:	5d                   	pop    %ebp
80101293:	c3                   	ret    
80101294:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010129b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010129f:	90                   	nop

801012a0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012a0:	55                   	push   %ebp
801012a1:	89 e5                	mov    %esp,%ebp
801012a3:	57                   	push   %edi
801012a4:	89 c7                	mov    %eax,%edi
801012a6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012a7:	31 f6                	xor    %esi,%esi
{
801012a9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012aa:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
801012af:	83 ec 28             	sub    $0x28,%esp
801012b2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012b5:	68 e0 09 11 80       	push   $0x801109e0
801012ba:	e8 d1 32 00 00       	call   80104590 <acquire>
801012bf:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012c5:	eb 1b                	jmp    801012e2 <iget+0x42>
801012c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012ce:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012d0:	39 3b                	cmp    %edi,(%ebx)
801012d2:	74 6c                	je     80101340 <iget+0xa0>
801012d4:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012da:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012e0:	73 26                	jae    80101308 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012e2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012e5:	85 c9                	test   %ecx,%ecx
801012e7:	7f e7                	jg     801012d0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012e9:	85 f6                	test   %esi,%esi
801012eb:	75 e7                	jne    801012d4 <iget+0x34>
801012ed:	8d 83 90 00 00 00    	lea    0x90(%ebx),%eax
801012f3:	85 c9                	test   %ecx,%ecx
801012f5:	75 70                	jne    80101367 <iget+0xc7>
801012f7:	89 de                	mov    %ebx,%esi
801012f9:	89 c3                	mov    %eax,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012fb:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101301:	72 df                	jb     801012e2 <iget+0x42>
80101303:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101307:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101308:	85 f6                	test   %esi,%esi
8010130a:	74 74                	je     80101380 <iget+0xe0>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010130c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010130f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101311:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101314:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010131b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101322:	68 e0 09 11 80       	push   $0x801109e0
80101327:	e8 84 33 00 00       	call   801046b0 <release>

  return ip;
8010132c:	83 c4 10             	add    $0x10,%esp
}
8010132f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101332:	89 f0                	mov    %esi,%eax
80101334:	5b                   	pop    %ebx
80101335:	5e                   	pop    %esi
80101336:	5f                   	pop    %edi
80101337:	5d                   	pop    %ebp
80101338:	c3                   	ret    
80101339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101340:	39 53 04             	cmp    %edx,0x4(%ebx)
80101343:	75 8f                	jne    801012d4 <iget+0x34>
      release(&icache.lock);
80101345:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101348:	83 c1 01             	add    $0x1,%ecx
      return ip;
8010134b:	89 de                	mov    %ebx,%esi
      ip->ref++;
8010134d:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101350:	68 e0 09 11 80       	push   $0x801109e0
80101355:	e8 56 33 00 00       	call   801046b0 <release>
      return ip;
8010135a:	83 c4 10             	add    $0x10,%esp
}
8010135d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101360:	89 f0                	mov    %esi,%eax
80101362:	5b                   	pop    %ebx
80101363:	5e                   	pop    %esi
80101364:	5f                   	pop    %edi
80101365:	5d                   	pop    %ebp
80101366:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101367:	3d 34 26 11 80       	cmp    $0x80112634,%eax
8010136c:	73 12                	jae    80101380 <iget+0xe0>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010136e:	8b 48 08             	mov    0x8(%eax),%ecx
80101371:	89 c3                	mov    %eax,%ebx
80101373:	85 c9                	test   %ecx,%ecx
80101375:	0f 8f 55 ff ff ff    	jg     801012d0 <iget+0x30>
8010137b:	e9 6d ff ff ff       	jmp    801012ed <iget+0x4d>
    panic("iget: no inodes");
80101380:	83 ec 0c             	sub    $0xc,%esp
80101383:	68 31 72 10 80       	push   $0x80107231
80101388:	e8 03 f0 ff ff       	call   80100390 <panic>
8010138d:	8d 76 00             	lea    0x0(%esi),%esi

80101390 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	57                   	push   %edi
80101394:	56                   	push   %esi
80101395:	89 c6                	mov    %eax,%esi
80101397:	53                   	push   %ebx
80101398:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010139b:	83 fa 0b             	cmp    $0xb,%edx
8010139e:	0f 86 84 00 00 00    	jbe    80101428 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801013a4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801013a7:	83 fb 7f             	cmp    $0x7f,%ebx
801013aa:	0f 87 98 00 00 00    	ja     80101448 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801013b0:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801013b6:	8b 00                	mov    (%eax),%eax
801013b8:	85 d2                	test   %edx,%edx
801013ba:	74 54                	je     80101410 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801013bc:	83 ec 08             	sub    $0x8,%esp
801013bf:	52                   	push   %edx
801013c0:	50                   	push   %eax
801013c1:	e8 0a ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801013c6:	83 c4 10             	add    $0x10,%esp
801013c9:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
801013cd:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013cf:	8b 1a                	mov    (%edx),%ebx
801013d1:	85 db                	test   %ebx,%ebx
801013d3:	74 1b                	je     801013f0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801013d5:	83 ec 0c             	sub    $0xc,%esp
801013d8:	57                   	push   %edi
801013d9:	e8 12 ee ff ff       	call   801001f0 <brelse>
    return addr;
801013de:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
801013e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e4:	89 d8                	mov    %ebx,%eax
801013e6:	5b                   	pop    %ebx
801013e7:	5e                   	pop    %esi
801013e8:	5f                   	pop    %edi
801013e9:	5d                   	pop    %ebp
801013ea:	c3                   	ret    
801013eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801013ef:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
801013f0:	8b 06                	mov    (%esi),%eax
801013f2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013f5:	e8 96 fd ff ff       	call   80101190 <balloc>
801013fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801013fd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101400:	89 c3                	mov    %eax,%ebx
80101402:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101404:	57                   	push   %edi
80101405:	e8 76 1a 00 00       	call   80102e80 <log_write>
8010140a:	83 c4 10             	add    $0x10,%esp
8010140d:	eb c6                	jmp    801013d5 <bmap+0x45>
8010140f:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101410:	e8 7b fd ff ff       	call   80101190 <balloc>
80101415:	89 c2                	mov    %eax,%edx
80101417:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010141d:	8b 06                	mov    (%esi),%eax
8010141f:	eb 9b                	jmp    801013bc <bmap+0x2c>
80101421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101428:	8d 3c 90             	lea    (%eax,%edx,4),%edi
8010142b:	8b 5f 5c             	mov    0x5c(%edi),%ebx
8010142e:	85 db                	test   %ebx,%ebx
80101430:	75 af                	jne    801013e1 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101432:	8b 00                	mov    (%eax),%eax
80101434:	e8 57 fd ff ff       	call   80101190 <balloc>
80101439:	89 47 5c             	mov    %eax,0x5c(%edi)
8010143c:	89 c3                	mov    %eax,%ebx
}
8010143e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101441:	89 d8                	mov    %ebx,%eax
80101443:	5b                   	pop    %ebx
80101444:	5e                   	pop    %esi
80101445:	5f                   	pop    %edi
80101446:	5d                   	pop    %ebp
80101447:	c3                   	ret    
  panic("bmap: out of range");
80101448:	83 ec 0c             	sub    $0xc,%esp
8010144b:	68 41 72 10 80       	push   $0x80107241
80101450:	e8 3b ef ff ff       	call   80100390 <panic>
80101455:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010145c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101460 <readsb>:
{
80101460:	55                   	push   %ebp
80101461:	89 e5                	mov    %esp,%ebp
80101463:	56                   	push   %esi
80101464:	53                   	push   %ebx
80101465:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101468:	83 ec 08             	sub    $0x8,%esp
8010146b:	6a 01                	push   $0x1
8010146d:	ff 75 08             	pushl  0x8(%ebp)
80101470:	e8 5b ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101475:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101478:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010147a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010147d:	6a 1c                	push   $0x1c
8010147f:	50                   	push   %eax
80101480:	56                   	push   %esi
80101481:	e8 1a 33 00 00       	call   801047a0 <memmove>
  brelse(bp);
80101486:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101489:	83 c4 10             	add    $0x10,%esp
}
8010148c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010148f:	5b                   	pop    %ebx
80101490:	5e                   	pop    %esi
80101491:	5d                   	pop    %ebp
  brelse(bp);
80101492:	e9 59 ed ff ff       	jmp    801001f0 <brelse>
80101497:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010149e:	66 90                	xchg   %ax,%ax

801014a0 <bfree>:
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	56                   	push   %esi
801014a4:	89 c6                	mov    %eax,%esi
801014a6:	53                   	push   %ebx
801014a7:	89 d3                	mov    %edx,%ebx
  readsb(dev, &sb);
801014a9:	83 ec 08             	sub    $0x8,%esp
801014ac:	68 c0 09 11 80       	push   $0x801109c0
801014b1:	50                   	push   %eax
801014b2:	e8 a9 ff ff ff       	call   80101460 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801014b7:	58                   	pop    %eax
801014b8:	5a                   	pop    %edx
801014b9:	89 da                	mov    %ebx,%edx
801014bb:	c1 ea 0c             	shr    $0xc,%edx
801014be:	03 15 d8 09 11 80    	add    0x801109d8,%edx
801014c4:	52                   	push   %edx
801014c5:	56                   	push   %esi
801014c6:	e8 05 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801014cb:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014cd:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801014d0:	ba 01 00 00 00       	mov    $0x1,%edx
801014d5:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801014d8:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801014de:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801014e1:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801014e3:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801014e8:	85 d1                	test   %edx,%ecx
801014ea:	74 25                	je     80101511 <bfree+0x71>
  bp->data[bi/8] &= ~m;
801014ec:	f7 d2                	not    %edx
801014ee:	89 c6                	mov    %eax,%esi
  log_write(bp);
801014f0:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801014f3:	21 ca                	and    %ecx,%edx
801014f5:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
801014f9:	56                   	push   %esi
801014fa:	e8 81 19 00 00       	call   80102e80 <log_write>
  brelse(bp);
801014ff:	89 34 24             	mov    %esi,(%esp)
80101502:	e8 e9 ec ff ff       	call   801001f0 <brelse>
}
80101507:	83 c4 10             	add    $0x10,%esp
8010150a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010150d:	5b                   	pop    %ebx
8010150e:	5e                   	pop    %esi
8010150f:	5d                   	pop    %ebp
80101510:	c3                   	ret    
    panic("freeing free block");
80101511:	83 ec 0c             	sub    $0xc,%esp
80101514:	68 54 72 10 80       	push   $0x80107254
80101519:	e8 72 ee ff ff       	call   80100390 <panic>
8010151e:	66 90                	xchg   %ax,%ax

80101520 <iinit>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	53                   	push   %ebx
80101524:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101529:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010152c:	68 67 72 10 80       	push   $0x80107267
80101531:	68 e0 09 11 80       	push   $0x801109e0
80101536:	e8 55 2f 00 00       	call   80104490 <initlock>
  for(i = 0; i < NINODE; i++) {
8010153b:	83 c4 10             	add    $0x10,%esp
8010153e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101540:	83 ec 08             	sub    $0x8,%esp
80101543:	68 6e 72 10 80       	push   $0x8010726e
80101548:	53                   	push   %ebx
80101549:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010154f:	e8 2c 2e 00 00       	call   80104380 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101554:	83 c4 10             	add    $0x10,%esp
80101557:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
8010155d:	75 e1                	jne    80101540 <iinit+0x20>
  readsb(dev, &sb);
8010155f:	83 ec 08             	sub    $0x8,%esp
80101562:	68 c0 09 11 80       	push   $0x801109c0
80101567:	ff 75 08             	pushl  0x8(%ebp)
8010156a:	e8 f1 fe ff ff       	call   80101460 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010156f:	ff 35 d8 09 11 80    	pushl  0x801109d8
80101575:	ff 35 d4 09 11 80    	pushl  0x801109d4
8010157b:	ff 35 d0 09 11 80    	pushl  0x801109d0
80101581:	ff 35 cc 09 11 80    	pushl  0x801109cc
80101587:	ff 35 c8 09 11 80    	pushl  0x801109c8
8010158d:	ff 35 c4 09 11 80    	pushl  0x801109c4
80101593:	ff 35 c0 09 11 80    	pushl  0x801109c0
80101599:	68 d4 72 10 80       	push   $0x801072d4
8010159e:	e8 0d f1 ff ff       	call   801006b0 <cprintf>
}
801015a3:	83 c4 30             	add    $0x30,%esp
801015a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015a9:	c9                   	leave  
801015aa:	c3                   	ret    
801015ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801015af:	90                   	nop

801015b0 <ialloc>:
{
801015b0:	55                   	push   %ebp
801015b1:	89 e5                	mov    %esp,%ebp
801015b3:	57                   	push   %edi
801015b4:	56                   	push   %esi
801015b5:	53                   	push   %ebx
801015b6:	83 ec 1c             	sub    $0x1c,%esp
801015b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801015bc:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
801015c3:	8b 75 08             	mov    0x8(%ebp),%esi
801015c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801015c9:	0f 86 91 00 00 00    	jbe    80101660 <ialloc+0xb0>
801015cf:	bb 01 00 00 00       	mov    $0x1,%ebx
801015d4:	eb 21                	jmp    801015f7 <ialloc+0x47>
801015d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015dd:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
801015e0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801015e3:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
801015e6:	57                   	push   %edi
801015e7:	e8 04 ec ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801015ec:	83 c4 10             	add    $0x10,%esp
801015ef:	3b 1d c8 09 11 80    	cmp    0x801109c8,%ebx
801015f5:	73 69                	jae    80101660 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801015f7:	89 d8                	mov    %ebx,%eax
801015f9:	83 ec 08             	sub    $0x8,%esp
801015fc:	c1 e8 03             	shr    $0x3,%eax
801015ff:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101605:	50                   	push   %eax
80101606:	56                   	push   %esi
80101607:	e8 c4 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010160c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010160f:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
80101611:	89 d8                	mov    %ebx,%eax
80101613:	83 e0 07             	and    $0x7,%eax
80101616:	c1 e0 06             	shl    $0x6,%eax
80101619:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010161d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101621:	75 bd                	jne    801015e0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101623:	83 ec 04             	sub    $0x4,%esp
80101626:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101629:	6a 40                	push   $0x40
8010162b:	6a 00                	push   $0x0
8010162d:	51                   	push   %ecx
8010162e:	e8 cd 30 00 00       	call   80104700 <memset>
      dip->type = type;
80101633:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101637:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010163a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010163d:	89 3c 24             	mov    %edi,(%esp)
80101640:	e8 3b 18 00 00       	call   80102e80 <log_write>
      brelse(bp);
80101645:	89 3c 24             	mov    %edi,(%esp)
80101648:	e8 a3 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010164d:	83 c4 10             	add    $0x10,%esp
}
80101650:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101653:	89 da                	mov    %ebx,%edx
80101655:	89 f0                	mov    %esi,%eax
}
80101657:	5b                   	pop    %ebx
80101658:	5e                   	pop    %esi
80101659:	5f                   	pop    %edi
8010165a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010165b:	e9 40 fc ff ff       	jmp    801012a0 <iget>
  panic("ialloc: no inodes");
80101660:	83 ec 0c             	sub    $0xc,%esp
80101663:	68 74 72 10 80       	push   $0x80107274
80101668:	e8 23 ed ff ff       	call   80100390 <panic>
8010166d:	8d 76 00             	lea    0x0(%esi),%esi

80101670 <iupdate>:
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	56                   	push   %esi
80101674:	53                   	push   %ebx
80101675:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101678:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010167b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010167e:	83 ec 08             	sub    $0x8,%esp
80101681:	c1 e8 03             	shr    $0x3,%eax
80101684:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010168a:	50                   	push   %eax
8010168b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010168e:	e8 3d ea ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101693:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101697:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010169a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010169c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010169f:	83 e0 07             	and    $0x7,%eax
801016a2:	c1 e0 06             	shl    $0x6,%eax
801016a5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801016a9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801016ac:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016b0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801016b3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801016b7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801016bb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801016bf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801016c3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801016c7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801016ca:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016cd:	6a 34                	push   $0x34
801016cf:	53                   	push   %ebx
801016d0:	50                   	push   %eax
801016d1:	e8 ca 30 00 00       	call   801047a0 <memmove>
  log_write(bp);
801016d6:	89 34 24             	mov    %esi,(%esp)
801016d9:	e8 a2 17 00 00       	call   80102e80 <log_write>
  brelse(bp);
801016de:	89 75 08             	mov    %esi,0x8(%ebp)
801016e1:	83 c4 10             	add    $0x10,%esp
}
801016e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016e7:	5b                   	pop    %ebx
801016e8:	5e                   	pop    %esi
801016e9:	5d                   	pop    %ebp
  brelse(bp);
801016ea:	e9 01 eb ff ff       	jmp    801001f0 <brelse>
801016ef:	90                   	nop

801016f0 <idup>:
{
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	53                   	push   %ebx
801016f4:	83 ec 10             	sub    $0x10,%esp
801016f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801016fa:	68 e0 09 11 80       	push   $0x801109e0
801016ff:	e8 8c 2e 00 00       	call   80104590 <acquire>
  ip->ref++;
80101704:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101708:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010170f:	e8 9c 2f 00 00       	call   801046b0 <release>
}
80101714:	89 d8                	mov    %ebx,%eax
80101716:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101719:	c9                   	leave  
8010171a:	c3                   	ret    
8010171b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010171f:	90                   	nop

80101720 <ilock>:
{
80101720:	55                   	push   %ebp
80101721:	89 e5                	mov    %esp,%ebp
80101723:	56                   	push   %esi
80101724:	53                   	push   %ebx
80101725:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101728:	85 db                	test   %ebx,%ebx
8010172a:	0f 84 b7 00 00 00    	je     801017e7 <ilock+0xc7>
80101730:	8b 53 08             	mov    0x8(%ebx),%edx
80101733:	85 d2                	test   %edx,%edx
80101735:	0f 8e ac 00 00 00    	jle    801017e7 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010173b:	83 ec 0c             	sub    $0xc,%esp
8010173e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101741:	50                   	push   %eax
80101742:	e8 79 2c 00 00       	call   801043c0 <acquiresleep>
  if(ip->valid == 0){
80101747:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010174a:	83 c4 10             	add    $0x10,%esp
8010174d:	85 c0                	test   %eax,%eax
8010174f:	74 0f                	je     80101760 <ilock+0x40>
}
80101751:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101754:	5b                   	pop    %ebx
80101755:	5e                   	pop    %esi
80101756:	5d                   	pop    %ebp
80101757:	c3                   	ret    
80101758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010175f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101760:	8b 43 04             	mov    0x4(%ebx),%eax
80101763:	83 ec 08             	sub    $0x8,%esp
80101766:	c1 e8 03             	shr    $0x3,%eax
80101769:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010176f:	50                   	push   %eax
80101770:	ff 33                	pushl  (%ebx)
80101772:	e8 59 e9 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101777:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010177a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010177c:	8b 43 04             	mov    0x4(%ebx),%eax
8010177f:	83 e0 07             	and    $0x7,%eax
80101782:	c1 e0 06             	shl    $0x6,%eax
80101785:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101789:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010178c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010178f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101793:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101797:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010179b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010179f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801017a3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801017a7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801017ab:	8b 50 fc             	mov    -0x4(%eax),%edx
801017ae:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017b1:	6a 34                	push   $0x34
801017b3:	50                   	push   %eax
801017b4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801017b7:	50                   	push   %eax
801017b8:	e8 e3 2f 00 00       	call   801047a0 <memmove>
    brelse(bp);
801017bd:	89 34 24             	mov    %esi,(%esp)
801017c0:	e8 2b ea ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
801017c5:	83 c4 10             	add    $0x10,%esp
801017c8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801017cd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801017d4:	0f 85 77 ff ff ff    	jne    80101751 <ilock+0x31>
      panic("ilock: no type");
801017da:	83 ec 0c             	sub    $0xc,%esp
801017dd:	68 8c 72 10 80       	push   $0x8010728c
801017e2:	e8 a9 eb ff ff       	call   80100390 <panic>
    panic("ilock");
801017e7:	83 ec 0c             	sub    $0xc,%esp
801017ea:	68 86 72 10 80       	push   $0x80107286
801017ef:	e8 9c eb ff ff       	call   80100390 <panic>
801017f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801017ff:	90                   	nop

80101800 <iunlock>:
{
80101800:	55                   	push   %ebp
80101801:	89 e5                	mov    %esp,%ebp
80101803:	56                   	push   %esi
80101804:	53                   	push   %ebx
80101805:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101808:	85 db                	test   %ebx,%ebx
8010180a:	74 28                	je     80101834 <iunlock+0x34>
8010180c:	83 ec 0c             	sub    $0xc,%esp
8010180f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101812:	56                   	push   %esi
80101813:	e8 48 2c 00 00       	call   80104460 <holdingsleep>
80101818:	83 c4 10             	add    $0x10,%esp
8010181b:	85 c0                	test   %eax,%eax
8010181d:	74 15                	je     80101834 <iunlock+0x34>
8010181f:	8b 43 08             	mov    0x8(%ebx),%eax
80101822:	85 c0                	test   %eax,%eax
80101824:	7e 0e                	jle    80101834 <iunlock+0x34>
  releasesleep(&ip->lock);
80101826:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101829:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010182c:	5b                   	pop    %ebx
8010182d:	5e                   	pop    %esi
8010182e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010182f:	e9 ec 2b 00 00       	jmp    80104420 <releasesleep>
    panic("iunlock");
80101834:	83 ec 0c             	sub    $0xc,%esp
80101837:	68 9b 72 10 80       	push   $0x8010729b
8010183c:	e8 4f eb ff ff       	call   80100390 <panic>
80101841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101848:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010184f:	90                   	nop

80101850 <iput>:
{
80101850:	55                   	push   %ebp
80101851:	89 e5                	mov    %esp,%ebp
80101853:	57                   	push   %edi
80101854:	56                   	push   %esi
80101855:	53                   	push   %ebx
80101856:	83 ec 28             	sub    $0x28,%esp
80101859:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010185c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010185f:	57                   	push   %edi
80101860:	e8 5b 2b 00 00       	call   801043c0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101865:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101868:	83 c4 10             	add    $0x10,%esp
8010186b:	85 d2                	test   %edx,%edx
8010186d:	74 07                	je     80101876 <iput+0x26>
8010186f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101874:	74 32                	je     801018a8 <iput+0x58>
  releasesleep(&ip->lock);
80101876:	83 ec 0c             	sub    $0xc,%esp
80101879:	57                   	push   %edi
8010187a:	e8 a1 2b 00 00       	call   80104420 <releasesleep>
  acquire(&icache.lock);
8010187f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101886:	e8 05 2d 00 00       	call   80104590 <acquire>
  ip->ref--;
8010188b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010188f:	83 c4 10             	add    $0x10,%esp
80101892:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101899:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010189c:	5b                   	pop    %ebx
8010189d:	5e                   	pop    %esi
8010189e:	5f                   	pop    %edi
8010189f:	5d                   	pop    %ebp
  release(&icache.lock);
801018a0:	e9 0b 2e 00 00       	jmp    801046b0 <release>
801018a5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801018a8:	83 ec 0c             	sub    $0xc,%esp
801018ab:	68 e0 09 11 80       	push   $0x801109e0
801018b0:	e8 db 2c 00 00       	call   80104590 <acquire>
    int r = ip->ref;
801018b5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801018b8:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801018bf:	e8 ec 2d 00 00       	call   801046b0 <release>
    if(r == 1){
801018c4:	83 c4 10             	add    $0x10,%esp
801018c7:	83 fe 01             	cmp    $0x1,%esi
801018ca:	75 aa                	jne    80101876 <iput+0x26>
801018cc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801018d2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801018d5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801018d8:	89 cf                	mov    %ecx,%edi
801018da:	eb 0b                	jmp    801018e7 <iput+0x97>
801018dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018e0:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801018e3:	39 fe                	cmp    %edi,%esi
801018e5:	74 19                	je     80101900 <iput+0xb0>
    if(ip->addrs[i]){
801018e7:	8b 16                	mov    (%esi),%edx
801018e9:	85 d2                	test   %edx,%edx
801018eb:	74 f3                	je     801018e0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801018ed:	8b 03                	mov    (%ebx),%eax
801018ef:	e8 ac fb ff ff       	call   801014a0 <bfree>
      ip->addrs[i] = 0;
801018f4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801018fa:	eb e4                	jmp    801018e0 <iput+0x90>
801018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101900:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101906:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101909:	85 c0                	test   %eax,%eax
8010190b:	75 33                	jne    80101940 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010190d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101910:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101917:	53                   	push   %ebx
80101918:	e8 53 fd ff ff       	call   80101670 <iupdate>
      ip->type = 0;
8010191d:	31 c0                	xor    %eax,%eax
8010191f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101923:	89 1c 24             	mov    %ebx,(%esp)
80101926:	e8 45 fd ff ff       	call   80101670 <iupdate>
      ip->valid = 0;
8010192b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101932:	83 c4 10             	add    $0x10,%esp
80101935:	e9 3c ff ff ff       	jmp    80101876 <iput+0x26>
8010193a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101940:	83 ec 08             	sub    $0x8,%esp
80101943:	50                   	push   %eax
80101944:	ff 33                	pushl  (%ebx)
80101946:	e8 85 e7 ff ff       	call   801000d0 <bread>
8010194b:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010194e:	83 c4 10             	add    $0x10,%esp
80101951:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101957:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
8010195a:	8d 70 5c             	lea    0x5c(%eax),%esi
8010195d:	89 cf                	mov    %ecx,%edi
8010195f:	eb 0e                	jmp    8010196f <iput+0x11f>
80101961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101968:	83 c6 04             	add    $0x4,%esi
8010196b:	39 f7                	cmp    %esi,%edi
8010196d:	74 11                	je     80101980 <iput+0x130>
      if(a[j])
8010196f:	8b 16                	mov    (%esi),%edx
80101971:	85 d2                	test   %edx,%edx
80101973:	74 f3                	je     80101968 <iput+0x118>
        bfree(ip->dev, a[j]);
80101975:	8b 03                	mov    (%ebx),%eax
80101977:	e8 24 fb ff ff       	call   801014a0 <bfree>
8010197c:	eb ea                	jmp    80101968 <iput+0x118>
8010197e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101980:	83 ec 0c             	sub    $0xc,%esp
80101983:	ff 75 e4             	pushl  -0x1c(%ebp)
80101986:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101989:	e8 62 e8 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010198e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101994:	8b 03                	mov    (%ebx),%eax
80101996:	e8 05 fb ff ff       	call   801014a0 <bfree>
    ip->addrs[NDIRECT] = 0;
8010199b:	83 c4 10             	add    $0x10,%esp
8010199e:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801019a5:	00 00 00 
801019a8:	e9 60 ff ff ff       	jmp    8010190d <iput+0xbd>
801019ad:	8d 76 00             	lea    0x0(%esi),%esi

801019b0 <iunlockput>:
{
801019b0:	55                   	push   %ebp
801019b1:	89 e5                	mov    %esp,%ebp
801019b3:	53                   	push   %ebx
801019b4:	83 ec 10             	sub    $0x10,%esp
801019b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019ba:	53                   	push   %ebx
801019bb:	e8 40 fe ff ff       	call   80101800 <iunlock>
  iput(ip);
801019c0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801019c3:	83 c4 10             	add    $0x10,%esp
}
801019c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019c9:	c9                   	leave  
  iput(ip);
801019ca:	e9 81 fe ff ff       	jmp    80101850 <iput>
801019cf:	90                   	nop

801019d0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	8b 55 08             	mov    0x8(%ebp),%edx
801019d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801019d9:	8b 0a                	mov    (%edx),%ecx
801019db:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801019de:	8b 4a 04             	mov    0x4(%edx),%ecx
801019e1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801019e4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801019e8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801019eb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801019ef:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801019f3:	8b 52 58             	mov    0x58(%edx),%edx
801019f6:	89 50 10             	mov    %edx,0x10(%eax)
}
801019f9:	5d                   	pop    %ebp
801019fa:	c3                   	ret    
801019fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019ff:	90                   	nop

80101a00 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a00:	55                   	push   %ebp
80101a01:	89 e5                	mov    %esp,%ebp
80101a03:	57                   	push   %edi
80101a04:	56                   	push   %esi
80101a05:	53                   	push   %ebx
80101a06:	83 ec 1c             	sub    $0x1c,%esp
80101a09:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101a0c:	8b 45 08             	mov    0x8(%ebp),%eax
80101a0f:	8b 75 10             	mov    0x10(%ebp),%esi
80101a12:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a15:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a18:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a1d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a20:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a23:	0f 84 a7 00 00 00    	je     80101ad0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a29:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a2c:	8b 40 58             	mov    0x58(%eax),%eax
80101a2f:	39 c6                	cmp    %eax,%esi
80101a31:	0f 87 ba 00 00 00    	ja     80101af1 <readi+0xf1>
80101a37:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a3a:	31 c9                	xor    %ecx,%ecx
80101a3c:	89 da                	mov    %ebx,%edx
80101a3e:	01 f2                	add    %esi,%edx
80101a40:	0f 92 c1             	setb   %cl
80101a43:	89 cf                	mov    %ecx,%edi
80101a45:	0f 82 a6 00 00 00    	jb     80101af1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a4b:	89 c1                	mov    %eax,%ecx
80101a4d:	29 f1                	sub    %esi,%ecx
80101a4f:	39 d0                	cmp    %edx,%eax
80101a51:	0f 43 cb             	cmovae %ebx,%ecx
80101a54:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a57:	85 c9                	test   %ecx,%ecx
80101a59:	74 67                	je     80101ac2 <readi+0xc2>
80101a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a5f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a60:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a63:	89 f2                	mov    %esi,%edx
80101a65:	c1 ea 09             	shr    $0x9,%edx
80101a68:	89 d8                	mov    %ebx,%eax
80101a6a:	e8 21 f9 ff ff       	call   80101390 <bmap>
80101a6f:	83 ec 08             	sub    $0x8,%esp
80101a72:	50                   	push   %eax
80101a73:	ff 33                	pushl  (%ebx)
80101a75:	e8 56 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a7a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a7d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a82:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a85:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a87:	89 f0                	mov    %esi,%eax
80101a89:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a8e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a90:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a93:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a95:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101a99:	39 d9                	cmp    %ebx,%ecx
80101a9b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a9e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a9f:	01 df                	add    %ebx,%edi
80101aa1:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101aa3:	50                   	push   %eax
80101aa4:	ff 75 e0             	pushl  -0x20(%ebp)
80101aa7:	e8 f4 2c 00 00       	call   801047a0 <memmove>
    brelse(bp);
80101aac:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101aaf:	89 14 24             	mov    %edx,(%esp)
80101ab2:	e8 39 e7 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ab7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101aba:	83 c4 10             	add    $0x10,%esp
80101abd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101ac0:	77 9e                	ja     80101a60 <readi+0x60>
  }
  return n;
80101ac2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101ac5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ac8:	5b                   	pop    %ebx
80101ac9:	5e                   	pop    %esi
80101aca:	5f                   	pop    %edi
80101acb:	5d                   	pop    %ebp
80101acc:	c3                   	ret    
80101acd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ad0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ad4:	66 83 f8 09          	cmp    $0x9,%ax
80101ad8:	77 17                	ja     80101af1 <readi+0xf1>
80101ada:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101ae1:	85 c0                	test   %eax,%eax
80101ae3:	74 0c                	je     80101af1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101ae5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ae8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101aeb:	5b                   	pop    %ebx
80101aec:	5e                   	pop    %esi
80101aed:	5f                   	pop    %edi
80101aee:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101aef:	ff e0                	jmp    *%eax
      return -1;
80101af1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101af6:	eb cd                	jmp    80101ac5 <readi+0xc5>
80101af8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101aff:	90                   	nop

80101b00 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b00:	55                   	push   %ebp
80101b01:	89 e5                	mov    %esp,%ebp
80101b03:	57                   	push   %edi
80101b04:	56                   	push   %esi
80101b05:	53                   	push   %ebx
80101b06:	83 ec 1c             	sub    $0x1c,%esp
80101b09:	8b 45 08             	mov    0x8(%ebp),%eax
80101b0c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b0f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b12:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b17:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b1a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b1d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b20:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b23:	0f 84 b7 00 00 00    	je     80101be0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b29:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b2f:	0f 82 e7 00 00 00    	jb     80101c1c <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b35:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b38:	89 f8                	mov    %edi,%eax
80101b3a:	01 f0                	add    %esi,%eax
80101b3c:	0f 82 da 00 00 00    	jb     80101c1c <writei+0x11c>
80101b42:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b47:	0f 87 cf 00 00 00    	ja     80101c1c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b4d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b54:	85 ff                	test   %edi,%edi
80101b56:	74 79                	je     80101bd1 <writei+0xd1>
80101b58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b5f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b60:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b63:	89 f2                	mov    %esi,%edx
80101b65:	c1 ea 09             	shr    $0x9,%edx
80101b68:	89 f8                	mov    %edi,%eax
80101b6a:	e8 21 f8 ff ff       	call   80101390 <bmap>
80101b6f:	83 ec 08             	sub    $0x8,%esp
80101b72:	50                   	push   %eax
80101b73:	ff 37                	pushl  (%edi)
80101b75:	e8 56 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b7a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b7f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b82:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b85:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b87:	89 f0                	mov    %esi,%eax
80101b89:	83 c4 0c             	add    $0xc,%esp
80101b8c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b91:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b93:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b97:	39 d9                	cmp    %ebx,%ecx
80101b99:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b9c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b9d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b9f:	ff 75 dc             	pushl  -0x24(%ebp)
80101ba2:	50                   	push   %eax
80101ba3:	e8 f8 2b 00 00       	call   801047a0 <memmove>
    log_write(bp);
80101ba8:	89 3c 24             	mov    %edi,(%esp)
80101bab:	e8 d0 12 00 00       	call   80102e80 <log_write>
    brelse(bp);
80101bb0:	89 3c 24             	mov    %edi,(%esp)
80101bb3:	e8 38 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bb8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101bbb:	83 c4 10             	add    $0x10,%esp
80101bbe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bc1:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101bc4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101bc7:	77 97                	ja     80101b60 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101bc9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bcc:	3b 70 58             	cmp    0x58(%eax),%esi
80101bcf:	77 37                	ja     80101c08 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101bd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101bd4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bd7:	5b                   	pop    %ebx
80101bd8:	5e                   	pop    %esi
80101bd9:	5f                   	pop    %edi
80101bda:	5d                   	pop    %ebp
80101bdb:	c3                   	ret    
80101bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101be0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101be4:	66 83 f8 09          	cmp    $0x9,%ax
80101be8:	77 32                	ja     80101c1c <writei+0x11c>
80101bea:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101bf1:	85 c0                	test   %eax,%eax
80101bf3:	74 27                	je     80101c1c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101bf5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101bf8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bfb:	5b                   	pop    %ebx
80101bfc:	5e                   	pop    %esi
80101bfd:	5f                   	pop    %edi
80101bfe:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101bff:	ff e0                	jmp    *%eax
80101c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c08:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c0b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c0e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c11:	50                   	push   %eax
80101c12:	e8 59 fa ff ff       	call   80101670 <iupdate>
80101c17:	83 c4 10             	add    $0x10,%esp
80101c1a:	eb b5                	jmp    80101bd1 <writei+0xd1>
      return -1;
80101c1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c21:	eb b1                	jmp    80101bd4 <writei+0xd4>
80101c23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c30 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c30:	55                   	push   %ebp
80101c31:	89 e5                	mov    %esp,%ebp
80101c33:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101c36:	6a 0e                	push   $0xe
80101c38:	ff 75 0c             	pushl  0xc(%ebp)
80101c3b:	ff 75 08             	pushl  0x8(%ebp)
80101c3e:	e8 cd 2b 00 00       	call   80104810 <strncmp>
}
80101c43:	c9                   	leave  
80101c44:	c3                   	ret    
80101c45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c50 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	57                   	push   %edi
80101c54:	56                   	push   %esi
80101c55:	53                   	push   %ebx
80101c56:	83 ec 1c             	sub    $0x1c,%esp
80101c59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c5c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c61:	0f 85 85 00 00 00    	jne    80101cec <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c67:	8b 53 58             	mov    0x58(%ebx),%edx
80101c6a:	31 ff                	xor    %edi,%edi
80101c6c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c6f:	85 d2                	test   %edx,%edx
80101c71:	74 3e                	je     80101cb1 <dirlookup+0x61>
80101c73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c77:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c78:	6a 10                	push   $0x10
80101c7a:	57                   	push   %edi
80101c7b:	56                   	push   %esi
80101c7c:	53                   	push   %ebx
80101c7d:	e8 7e fd ff ff       	call   80101a00 <readi>
80101c82:	83 c4 10             	add    $0x10,%esp
80101c85:	83 f8 10             	cmp    $0x10,%eax
80101c88:	75 55                	jne    80101cdf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101c8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c8f:	74 18                	je     80101ca9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c91:	83 ec 04             	sub    $0x4,%esp
80101c94:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c97:	6a 0e                	push   $0xe
80101c99:	50                   	push   %eax
80101c9a:	ff 75 0c             	pushl  0xc(%ebp)
80101c9d:	e8 6e 2b 00 00       	call   80104810 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101ca2:	83 c4 10             	add    $0x10,%esp
80101ca5:	85 c0                	test   %eax,%eax
80101ca7:	74 17                	je     80101cc0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ca9:	83 c7 10             	add    $0x10,%edi
80101cac:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101caf:	72 c7                	jb     80101c78 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101cb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101cb4:	31 c0                	xor    %eax,%eax
}
80101cb6:	5b                   	pop    %ebx
80101cb7:	5e                   	pop    %esi
80101cb8:	5f                   	pop    %edi
80101cb9:	5d                   	pop    %ebp
80101cba:	c3                   	ret    
80101cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101cbf:	90                   	nop
      if(poff)
80101cc0:	8b 45 10             	mov    0x10(%ebp),%eax
80101cc3:	85 c0                	test   %eax,%eax
80101cc5:	74 05                	je     80101ccc <dirlookup+0x7c>
        *poff = off;
80101cc7:	8b 45 10             	mov    0x10(%ebp),%eax
80101cca:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101ccc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101cd0:	8b 03                	mov    (%ebx),%eax
80101cd2:	e8 c9 f5 ff ff       	call   801012a0 <iget>
}
80101cd7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cda:	5b                   	pop    %ebx
80101cdb:	5e                   	pop    %esi
80101cdc:	5f                   	pop    %edi
80101cdd:	5d                   	pop    %ebp
80101cde:	c3                   	ret    
      panic("dirlookup read");
80101cdf:	83 ec 0c             	sub    $0xc,%esp
80101ce2:	68 b5 72 10 80       	push   $0x801072b5
80101ce7:	e8 a4 e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101cec:	83 ec 0c             	sub    $0xc,%esp
80101cef:	68 a3 72 10 80       	push   $0x801072a3
80101cf4:	e8 97 e6 ff ff       	call   80100390 <panic>
80101cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d00 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d00:	55                   	push   %ebp
80101d01:	89 e5                	mov    %esp,%ebp
80101d03:	57                   	push   %edi
80101d04:	56                   	push   %esi
80101d05:	53                   	push   %ebx
80101d06:	89 c3                	mov    %eax,%ebx
80101d08:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d0b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d0e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101d11:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101d14:	0f 84 86 01 00 00    	je     80101ea0 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d1a:	e8 d1 1b 00 00       	call   801038f0 <myproc>
  acquire(&icache.lock);
80101d1f:	83 ec 0c             	sub    $0xc,%esp
80101d22:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80101d24:	8b 70 74             	mov    0x74(%eax),%esi
  acquire(&icache.lock);
80101d27:	68 e0 09 11 80       	push   $0x801109e0
80101d2c:	e8 5f 28 00 00       	call   80104590 <acquire>
  ip->ref++;
80101d31:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d35:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101d3c:	e8 6f 29 00 00       	call   801046b0 <release>
80101d41:	83 c4 10             	add    $0x10,%esp
80101d44:	eb 0d                	jmp    80101d53 <namex+0x53>
80101d46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d4d:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80101d50:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101d53:	0f b6 07             	movzbl (%edi),%eax
80101d56:	3c 2f                	cmp    $0x2f,%al
80101d58:	74 f6                	je     80101d50 <namex+0x50>
  if(*path == 0)
80101d5a:	84 c0                	test   %al,%al
80101d5c:	0f 84 ee 00 00 00    	je     80101e50 <namex+0x150>
  while(*path != '/' && *path != 0)
80101d62:	0f b6 07             	movzbl (%edi),%eax
80101d65:	84 c0                	test   %al,%al
80101d67:	0f 84 fb 00 00 00    	je     80101e68 <namex+0x168>
80101d6d:	89 fb                	mov    %edi,%ebx
80101d6f:	3c 2f                	cmp    $0x2f,%al
80101d71:	0f 84 f1 00 00 00    	je     80101e68 <namex+0x168>
80101d77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d7e:	66 90                	xchg   %ax,%ax
    path++;
80101d80:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
80101d83:	0f b6 03             	movzbl (%ebx),%eax
80101d86:	3c 2f                	cmp    $0x2f,%al
80101d88:	74 04                	je     80101d8e <namex+0x8e>
80101d8a:	84 c0                	test   %al,%al
80101d8c:	75 f2                	jne    80101d80 <namex+0x80>
  len = path - s;
80101d8e:	89 d8                	mov    %ebx,%eax
80101d90:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
80101d92:	83 f8 0d             	cmp    $0xd,%eax
80101d95:	0f 8e 85 00 00 00    	jle    80101e20 <namex+0x120>
    memmove(name, s, DIRSIZ);
80101d9b:	83 ec 04             	sub    $0x4,%esp
80101d9e:	6a 0e                	push   $0xe
80101da0:	57                   	push   %edi
    path++;
80101da1:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80101da3:	ff 75 e4             	pushl  -0x1c(%ebp)
80101da6:	e8 f5 29 00 00       	call   801047a0 <memmove>
80101dab:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101dae:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101db1:	75 0d                	jne    80101dc0 <namex+0xc0>
80101db3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101db7:	90                   	nop
    path++;
80101db8:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101dbb:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101dbe:	74 f8                	je     80101db8 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101dc0:	83 ec 0c             	sub    $0xc,%esp
80101dc3:	56                   	push   %esi
80101dc4:	e8 57 f9 ff ff       	call   80101720 <ilock>
    if(ip->type != T_DIR){
80101dc9:	83 c4 10             	add    $0x10,%esp
80101dcc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101dd1:	0f 85 a1 00 00 00    	jne    80101e78 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101dd7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101dda:	85 d2                	test   %edx,%edx
80101ddc:	74 09                	je     80101de7 <namex+0xe7>
80101dde:	80 3f 00             	cmpb   $0x0,(%edi)
80101de1:	0f 84 d9 00 00 00    	je     80101ec0 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101de7:	83 ec 04             	sub    $0x4,%esp
80101dea:	6a 00                	push   $0x0
80101dec:	ff 75 e4             	pushl  -0x1c(%ebp)
80101def:	56                   	push   %esi
80101df0:	e8 5b fe ff ff       	call   80101c50 <dirlookup>
80101df5:	83 c4 10             	add    $0x10,%esp
80101df8:	89 c3                	mov    %eax,%ebx
80101dfa:	85 c0                	test   %eax,%eax
80101dfc:	74 7a                	je     80101e78 <namex+0x178>
  iunlock(ip);
80101dfe:	83 ec 0c             	sub    $0xc,%esp
80101e01:	56                   	push   %esi
80101e02:	e8 f9 f9 ff ff       	call   80101800 <iunlock>
  iput(ip);
80101e07:	89 34 24             	mov    %esi,(%esp)
80101e0a:	89 de                	mov    %ebx,%esi
80101e0c:	e8 3f fa ff ff       	call   80101850 <iput>
  while(*path == '/')
80101e11:	83 c4 10             	add    $0x10,%esp
80101e14:	e9 3a ff ff ff       	jmp    80101d53 <namex+0x53>
80101e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e20:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101e23:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80101e26:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80101e29:	83 ec 04             	sub    $0x4,%esp
80101e2c:	50                   	push   %eax
80101e2d:	57                   	push   %edi
    name[len] = 0;
80101e2e:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80101e30:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e33:	e8 68 29 00 00       	call   801047a0 <memmove>
    name[len] = 0;
80101e38:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e3b:	83 c4 10             	add    $0x10,%esp
80101e3e:	c6 00 00             	movb   $0x0,(%eax)
80101e41:	e9 68 ff ff ff       	jmp    80101dae <namex+0xae>
80101e46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e4d:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e50:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e53:	85 c0                	test   %eax,%eax
80101e55:	0f 85 85 00 00 00    	jne    80101ee0 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e5e:	89 f0                	mov    %esi,%eax
80101e60:	5b                   	pop    %ebx
80101e61:	5e                   	pop    %esi
80101e62:	5f                   	pop    %edi
80101e63:	5d                   	pop    %ebp
80101e64:	c3                   	ret    
80101e65:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80101e68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e6b:	89 fb                	mov    %edi,%ebx
80101e6d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101e70:	31 c0                	xor    %eax,%eax
80101e72:	eb b5                	jmp    80101e29 <namex+0x129>
80101e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e78:	83 ec 0c             	sub    $0xc,%esp
80101e7b:	56                   	push   %esi
80101e7c:	e8 7f f9 ff ff       	call   80101800 <iunlock>
  iput(ip);
80101e81:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e84:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e86:	e8 c5 f9 ff ff       	call   80101850 <iput>
      return 0;
80101e8b:	83 c4 10             	add    $0x10,%esp
}
80101e8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e91:	89 f0                	mov    %esi,%eax
80101e93:	5b                   	pop    %ebx
80101e94:	5e                   	pop    %esi
80101e95:	5f                   	pop    %edi
80101e96:	5d                   	pop    %ebp
80101e97:	c3                   	ret    
80101e98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e9f:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
80101ea0:	ba 01 00 00 00       	mov    $0x1,%edx
80101ea5:	b8 01 00 00 00       	mov    $0x1,%eax
80101eaa:	89 df                	mov    %ebx,%edi
80101eac:	e8 ef f3 ff ff       	call   801012a0 <iget>
80101eb1:	89 c6                	mov    %eax,%esi
80101eb3:	e9 9b fe ff ff       	jmp    80101d53 <namex+0x53>
80101eb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ebf:	90                   	nop
      iunlock(ip);
80101ec0:	83 ec 0c             	sub    $0xc,%esp
80101ec3:	56                   	push   %esi
80101ec4:	e8 37 f9 ff ff       	call   80101800 <iunlock>
      return ip;
80101ec9:	83 c4 10             	add    $0x10,%esp
}
80101ecc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ecf:	89 f0                	mov    %esi,%eax
80101ed1:	5b                   	pop    %ebx
80101ed2:	5e                   	pop    %esi
80101ed3:	5f                   	pop    %edi
80101ed4:	5d                   	pop    %ebp
80101ed5:	c3                   	ret    
80101ed6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101edd:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
80101ee0:	83 ec 0c             	sub    $0xc,%esp
80101ee3:	56                   	push   %esi
    return 0;
80101ee4:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ee6:	e8 65 f9 ff ff       	call   80101850 <iput>
    return 0;
80101eeb:	83 c4 10             	add    $0x10,%esp
80101eee:	e9 68 ff ff ff       	jmp    80101e5b <namex+0x15b>
80101ef3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101f00 <dirlink>:
{
80101f00:	55                   	push   %ebp
80101f01:	89 e5                	mov    %esp,%ebp
80101f03:	57                   	push   %edi
80101f04:	56                   	push   %esi
80101f05:	53                   	push   %ebx
80101f06:	83 ec 20             	sub    $0x20,%esp
80101f09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f0c:	6a 00                	push   $0x0
80101f0e:	ff 75 0c             	pushl  0xc(%ebp)
80101f11:	53                   	push   %ebx
80101f12:	e8 39 fd ff ff       	call   80101c50 <dirlookup>
80101f17:	83 c4 10             	add    $0x10,%esp
80101f1a:	85 c0                	test   %eax,%eax
80101f1c:	75 67                	jne    80101f85 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f1e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101f21:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f24:	85 ff                	test   %edi,%edi
80101f26:	74 29                	je     80101f51 <dirlink+0x51>
80101f28:	31 ff                	xor    %edi,%edi
80101f2a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f2d:	eb 09                	jmp    80101f38 <dirlink+0x38>
80101f2f:	90                   	nop
80101f30:	83 c7 10             	add    $0x10,%edi
80101f33:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f36:	73 19                	jae    80101f51 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f38:	6a 10                	push   $0x10
80101f3a:	57                   	push   %edi
80101f3b:	56                   	push   %esi
80101f3c:	53                   	push   %ebx
80101f3d:	e8 be fa ff ff       	call   80101a00 <readi>
80101f42:	83 c4 10             	add    $0x10,%esp
80101f45:	83 f8 10             	cmp    $0x10,%eax
80101f48:	75 4e                	jne    80101f98 <dirlink+0x98>
    if(de.inum == 0)
80101f4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f4f:	75 df                	jne    80101f30 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101f51:	83 ec 04             	sub    $0x4,%esp
80101f54:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f57:	6a 0e                	push   $0xe
80101f59:	ff 75 0c             	pushl  0xc(%ebp)
80101f5c:	50                   	push   %eax
80101f5d:	e8 0e 29 00 00       	call   80104870 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f62:	6a 10                	push   $0x10
  de.inum = inum;
80101f64:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f67:	57                   	push   %edi
80101f68:	56                   	push   %esi
80101f69:	53                   	push   %ebx
  de.inum = inum;
80101f6a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f6e:	e8 8d fb ff ff       	call   80101b00 <writei>
80101f73:	83 c4 20             	add    $0x20,%esp
80101f76:	83 f8 10             	cmp    $0x10,%eax
80101f79:	75 2a                	jne    80101fa5 <dirlink+0xa5>
  return 0;
80101f7b:	31 c0                	xor    %eax,%eax
}
80101f7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f80:	5b                   	pop    %ebx
80101f81:	5e                   	pop    %esi
80101f82:	5f                   	pop    %edi
80101f83:	5d                   	pop    %ebp
80101f84:	c3                   	ret    
    iput(ip);
80101f85:	83 ec 0c             	sub    $0xc,%esp
80101f88:	50                   	push   %eax
80101f89:	e8 c2 f8 ff ff       	call   80101850 <iput>
    return -1;
80101f8e:	83 c4 10             	add    $0x10,%esp
80101f91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f96:	eb e5                	jmp    80101f7d <dirlink+0x7d>
      panic("dirlink read");
80101f98:	83 ec 0c             	sub    $0xc,%esp
80101f9b:	68 c4 72 10 80       	push   $0x801072c4
80101fa0:	e8 eb e3 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101fa5:	83 ec 0c             	sub    $0xc,%esp
80101fa8:	68 ca 79 10 80       	push   $0x801079ca
80101fad:	e8 de e3 ff ff       	call   80100390 <panic>
80101fb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fc0 <namei>:

struct inode*
namei(char *path)
{
80101fc0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fc1:	31 d2                	xor    %edx,%edx
{
80101fc3:	89 e5                	mov    %esp,%ebp
80101fc5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101fc8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fcb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fce:	e8 2d fd ff ff       	call   80101d00 <namex>
}
80101fd3:	c9                   	leave  
80101fd4:	c3                   	ret    
80101fd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101fe0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101fe0:	55                   	push   %ebp
  return namex(path, 1, name);
80101fe1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101fe6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101fe8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101feb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101fee:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101fef:	e9 0c fd ff ff       	jmp    80101d00 <namex>
80101ff4:	66 90                	xchg   %ax,%ax
80101ff6:	66 90                	xchg   %ax,%ax
80101ff8:	66 90                	xchg   %ax,%ax
80101ffa:	66 90                	xchg   %ax,%ax
80101ffc:	66 90                	xchg   %ax,%ax
80101ffe:	66 90                	xchg   %ax,%ax

80102000 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	57                   	push   %edi
80102004:	56                   	push   %esi
80102005:	53                   	push   %ebx
80102006:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102009:	85 c0                	test   %eax,%eax
8010200b:	0f 84 b4 00 00 00    	je     801020c5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102011:	8b 70 08             	mov    0x8(%eax),%esi
80102014:	89 c3                	mov    %eax,%ebx
80102016:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010201c:	0f 87 96 00 00 00    	ja     801020b8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102022:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102027:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010202e:	66 90                	xchg   %ax,%ax
80102030:	89 ca                	mov    %ecx,%edx
80102032:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102033:	83 e0 c0             	and    $0xffffffc0,%eax
80102036:	3c 40                	cmp    $0x40,%al
80102038:	75 f6                	jne    80102030 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010203a:	31 ff                	xor    %edi,%edi
8010203c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102041:	89 f8                	mov    %edi,%eax
80102043:	ee                   	out    %al,(%dx)
80102044:	b8 01 00 00 00       	mov    $0x1,%eax
80102049:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010204e:	ee                   	out    %al,(%dx)
8010204f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102054:	89 f0                	mov    %esi,%eax
80102056:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102057:	89 f0                	mov    %esi,%eax
80102059:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010205e:	c1 f8 08             	sar    $0x8,%eax
80102061:	ee                   	out    %al,(%dx)
80102062:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102067:	89 f8                	mov    %edi,%eax
80102069:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010206a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010206e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102073:	c1 e0 04             	shl    $0x4,%eax
80102076:	83 e0 10             	and    $0x10,%eax
80102079:	83 c8 e0             	or     $0xffffffe0,%eax
8010207c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010207d:	f6 03 04             	testb  $0x4,(%ebx)
80102080:	75 16                	jne    80102098 <idestart+0x98>
80102082:	b8 20 00 00 00       	mov    $0x20,%eax
80102087:	89 ca                	mov    %ecx,%edx
80102089:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010208a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010208d:	5b                   	pop    %ebx
8010208e:	5e                   	pop    %esi
8010208f:	5f                   	pop    %edi
80102090:	5d                   	pop    %ebp
80102091:	c3                   	ret    
80102092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102098:	b8 30 00 00 00       	mov    $0x30,%eax
8010209d:	89 ca                	mov    %ecx,%edx
8010209f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801020a0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801020a5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801020a8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020ad:	fc                   	cld    
801020ae:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801020b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b3:	5b                   	pop    %ebx
801020b4:	5e                   	pop    %esi
801020b5:	5f                   	pop    %edi
801020b6:	5d                   	pop    %ebp
801020b7:	c3                   	ret    
    panic("incorrect blockno");
801020b8:	83 ec 0c             	sub    $0xc,%esp
801020bb:	68 30 73 10 80       	push   $0x80107330
801020c0:	e8 cb e2 ff ff       	call   80100390 <panic>
    panic("idestart");
801020c5:	83 ec 0c             	sub    $0xc,%esp
801020c8:	68 27 73 10 80       	push   $0x80107327
801020cd:	e8 be e2 ff ff       	call   80100390 <panic>
801020d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801020e6:	68 42 73 10 80       	push   $0x80107342
801020eb:	68 80 a5 10 80       	push   $0x8010a580
801020f0:	e8 9b 23 00 00       	call   80104490 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020f5:	58                   	pop    %eax
801020f6:	a1 00 2d 11 80       	mov    0x80112d00,%eax
801020fb:	5a                   	pop    %edx
801020fc:	83 e8 01             	sub    $0x1,%eax
801020ff:	50                   	push   %eax
80102100:	6a 0e                	push   $0xe
80102102:	e8 a9 02 00 00       	call   801023b0 <ioapicenable>
80102107:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010210a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010210f:	90                   	nop
80102110:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102111:	83 e0 c0             	and    $0xffffffc0,%eax
80102114:	3c 40                	cmp    $0x40,%al
80102116:	75 f8                	jne    80102110 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102118:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010211d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102122:	ee                   	out    %al,(%dx)
80102123:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102128:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010212d:	eb 06                	jmp    80102135 <ideinit+0x55>
8010212f:	90                   	nop
  for(i=0; i<1000; i++){
80102130:	83 e9 01             	sub    $0x1,%ecx
80102133:	74 0f                	je     80102144 <ideinit+0x64>
80102135:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102136:	84 c0                	test   %al,%al
80102138:	74 f6                	je     80102130 <ideinit+0x50>
      havedisk1 = 1;
8010213a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102141:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102144:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102149:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010214e:	ee                   	out    %al,(%dx)
}
8010214f:	c9                   	leave  
80102150:	c3                   	ret    
80102151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102158:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010215f:	90                   	nop

80102160 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102160:	55                   	push   %ebp
80102161:	89 e5                	mov    %esp,%ebp
80102163:	57                   	push   %edi
80102164:	56                   	push   %esi
80102165:	53                   	push   %ebx
80102166:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102169:	68 80 a5 10 80       	push   $0x8010a580
8010216e:	e8 1d 24 00 00       	call   80104590 <acquire>

  if((b = idequeue) == 0){
80102173:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102179:	83 c4 10             	add    $0x10,%esp
8010217c:	85 db                	test   %ebx,%ebx
8010217e:	74 63                	je     801021e3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102180:	8b 43 58             	mov    0x58(%ebx),%eax
80102183:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102188:	8b 33                	mov    (%ebx),%esi
8010218a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102190:	75 2f                	jne    801021c1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102192:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010219e:	66 90                	xchg   %ax,%ax
801021a0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021a1:	89 c1                	mov    %eax,%ecx
801021a3:	83 e1 c0             	and    $0xffffffc0,%ecx
801021a6:	80 f9 40             	cmp    $0x40,%cl
801021a9:	75 f5                	jne    801021a0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801021ab:	a8 21                	test   $0x21,%al
801021ad:	75 12                	jne    801021c1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
801021af:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801021b2:	b9 80 00 00 00       	mov    $0x80,%ecx
801021b7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021bc:	fc                   	cld    
801021bd:	f3 6d                	rep insl (%dx),%es:(%edi)
801021bf:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021c1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801021c4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801021c7:	83 ce 02             	or     $0x2,%esi
801021ca:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801021cc:	53                   	push   %ebx
801021cd:	e8 7e 1e 00 00       	call   80104050 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d2:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801021d7:	83 c4 10             	add    $0x10,%esp
801021da:	85 c0                	test   %eax,%eax
801021dc:	74 05                	je     801021e3 <ideintr+0x83>
    idestart(idequeue);
801021de:	e8 1d fe ff ff       	call   80102000 <idestart>
    release(&idelock);
801021e3:	83 ec 0c             	sub    $0xc,%esp
801021e6:	68 80 a5 10 80       	push   $0x8010a580
801021eb:	e8 c0 24 00 00       	call   801046b0 <release>

  release(&idelock);
}
801021f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021f3:	5b                   	pop    %ebx
801021f4:	5e                   	pop    %esi
801021f5:	5f                   	pop    %edi
801021f6:	5d                   	pop    %ebp
801021f7:	c3                   	ret    
801021f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021ff:	90                   	nop

80102200 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	53                   	push   %ebx
80102204:	83 ec 10             	sub    $0x10,%esp
80102207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010220a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010220d:	50                   	push   %eax
8010220e:	e8 4d 22 00 00       	call   80104460 <holdingsleep>
80102213:	83 c4 10             	add    $0x10,%esp
80102216:	85 c0                	test   %eax,%eax
80102218:	0f 84 d3 00 00 00    	je     801022f1 <iderw+0xf1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010221e:	8b 03                	mov    (%ebx),%eax
80102220:	83 e0 06             	and    $0x6,%eax
80102223:	83 f8 02             	cmp    $0x2,%eax
80102226:	0f 84 b8 00 00 00    	je     801022e4 <iderw+0xe4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010222c:	8b 53 04             	mov    0x4(%ebx),%edx
8010222f:	85 d2                	test   %edx,%edx
80102231:	74 0d                	je     80102240 <iderw+0x40>
80102233:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102238:	85 c0                	test   %eax,%eax
8010223a:	0f 84 97 00 00 00    	je     801022d7 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102240:	83 ec 0c             	sub    $0xc,%esp
80102243:	68 80 a5 10 80       	push   $0x8010a580
80102248:	e8 43 23 00 00       	call   80104590 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010224d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
  b->qnext = 0;
80102253:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010225a:	83 c4 10             	add    $0x10,%esp
8010225d:	85 d2                	test   %edx,%edx
8010225f:	75 09                	jne    8010226a <iderw+0x6a>
80102261:	eb 6d                	jmp    801022d0 <iderw+0xd0>
80102263:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102267:	90                   	nop
80102268:	89 c2                	mov    %eax,%edx
8010226a:	8b 42 58             	mov    0x58(%edx),%eax
8010226d:	85 c0                	test   %eax,%eax
8010226f:	75 f7                	jne    80102268 <iderw+0x68>
80102271:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102274:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102276:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
8010227c:	74 42                	je     801022c0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010227e:	8b 03                	mov    (%ebx),%eax
80102280:	83 e0 06             	and    $0x6,%eax
80102283:	83 f8 02             	cmp    $0x2,%eax
80102286:	74 23                	je     801022ab <iderw+0xab>
80102288:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010228f:	90                   	nop
    sleep(b, &idelock);
80102290:	83 ec 08             	sub    $0x8,%esp
80102293:	68 80 a5 10 80       	push   $0x8010a580
80102298:	53                   	push   %ebx
80102299:	e8 f2 1b 00 00       	call   80103e90 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010229e:	8b 03                	mov    (%ebx),%eax
801022a0:	83 c4 10             	add    $0x10,%esp
801022a3:	83 e0 06             	and    $0x6,%eax
801022a6:	83 f8 02             	cmp    $0x2,%eax
801022a9:	75 e5                	jne    80102290 <iderw+0x90>
  }


  release(&idelock);
801022ab:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801022b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022b5:	c9                   	leave  
  release(&idelock);
801022b6:	e9 f5 23 00 00       	jmp    801046b0 <release>
801022bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022bf:	90                   	nop
    idestart(b);
801022c0:	89 d8                	mov    %ebx,%eax
801022c2:	e8 39 fd ff ff       	call   80102000 <idestart>
801022c7:	eb b5                	jmp    8010227e <iderw+0x7e>
801022c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022d0:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801022d5:	eb 9d                	jmp    80102274 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
801022d7:	83 ec 0c             	sub    $0xc,%esp
801022da:	68 71 73 10 80       	push   $0x80107371
801022df:	e8 ac e0 ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
801022e4:	83 ec 0c             	sub    $0xc,%esp
801022e7:	68 5c 73 10 80       	push   $0x8010735c
801022ec:	e8 9f e0 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801022f1:	83 ec 0c             	sub    $0xc,%esp
801022f4:	68 46 73 10 80       	push   $0x80107346
801022f9:	e8 92 e0 ff ff       	call   80100390 <panic>
801022fe:	66 90                	xchg   %ax,%ax

80102300 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102300:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102301:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
80102308:	00 c0 fe 
{
8010230b:	89 e5                	mov    %esp,%ebp
8010230d:	56                   	push   %esi
8010230e:	53                   	push   %ebx
  ioapic->reg = reg;
8010230f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102316:	00 00 00 
  return ioapic->data;
80102319:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010231f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102322:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102328:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010232e:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102335:	c1 ee 10             	shr    $0x10,%esi
80102338:	89 f0                	mov    %esi,%eax
8010233a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010233d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102340:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102343:	39 c2                	cmp    %eax,%edx
80102345:	74 16                	je     8010235d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102347:	83 ec 0c             	sub    $0xc,%esp
8010234a:	68 90 73 10 80       	push   $0x80107390
8010234f:	e8 5c e3 ff ff       	call   801006b0 <cprintf>
80102354:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010235a:	83 c4 10             	add    $0x10,%esp
8010235d:	83 c6 21             	add    $0x21,%esi
{
80102360:	ba 10 00 00 00       	mov    $0x10,%edx
80102365:	b8 20 00 00 00       	mov    $0x20,%eax
8010236a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102370:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102372:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102374:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010237a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010237d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102383:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102386:	8d 5a 01             	lea    0x1(%edx),%ebx
80102389:	83 c2 02             	add    $0x2,%edx
8010238c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010238e:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102394:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010239b:	39 f0                	cmp    %esi,%eax
8010239d:	75 d1                	jne    80102370 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010239f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023a2:	5b                   	pop    %ebx
801023a3:	5e                   	pop    %esi
801023a4:	5d                   	pop    %ebp
801023a5:	c3                   	ret    
801023a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023ad:	8d 76 00             	lea    0x0(%esi),%esi

801023b0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801023b0:	55                   	push   %ebp
  ioapic->reg = reg;
801023b1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
801023b7:	89 e5                	mov    %esp,%ebp
801023b9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801023bc:	8d 50 20             	lea    0x20(%eax),%edx
801023bf:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801023c3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023c5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023cb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801023ce:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023d4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023d6:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023db:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801023de:	89 50 10             	mov    %edx,0x10(%eax)
}
801023e1:	5d                   	pop    %ebp
801023e2:	c3                   	ret    
801023e3:	66 90                	xchg   %ax,%ax
801023e5:	66 90                	xchg   %ax,%ax
801023e7:	66 90                	xchg   %ax,%ax
801023e9:	66 90                	xchg   %ax,%ax
801023eb:	66 90                	xchg   %ax,%ax
801023ed:	66 90                	xchg   %ax,%ax
801023ef:	90                   	nop

801023f0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	53                   	push   %ebx
801023f4:	83 ec 04             	sub    $0x4,%esp
801023f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023fa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102400:	75 76                	jne    80102478 <kfree+0x88>
80102402:	81 fb a8 57 11 80    	cmp    $0x801157a8,%ebx
80102408:	72 6e                	jb     80102478 <kfree+0x88>
8010240a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102410:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102415:	77 61                	ja     80102478 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102417:	83 ec 04             	sub    $0x4,%esp
8010241a:	68 00 10 00 00       	push   $0x1000
8010241f:	6a 01                	push   $0x1
80102421:	53                   	push   %ebx
80102422:	e8 d9 22 00 00       	call   80104700 <memset>

  if(kmem.use_lock)
80102427:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010242d:	83 c4 10             	add    $0x10,%esp
80102430:	85 d2                	test   %edx,%edx
80102432:	75 1c                	jne    80102450 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102434:	a1 78 26 11 80       	mov    0x80112678,%eax
80102439:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010243b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102440:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102446:	85 c0                	test   %eax,%eax
80102448:	75 1e                	jne    80102468 <kfree+0x78>
    release(&kmem.lock);
}
8010244a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010244d:	c9                   	leave  
8010244e:	c3                   	ret    
8010244f:	90                   	nop
    acquire(&kmem.lock);
80102450:	83 ec 0c             	sub    $0xc,%esp
80102453:	68 40 26 11 80       	push   $0x80112640
80102458:	e8 33 21 00 00       	call   80104590 <acquire>
8010245d:	83 c4 10             	add    $0x10,%esp
80102460:	eb d2                	jmp    80102434 <kfree+0x44>
80102462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102468:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010246f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102472:	c9                   	leave  
    release(&kmem.lock);
80102473:	e9 38 22 00 00       	jmp    801046b0 <release>
    panic("kfree");
80102478:	83 ec 0c             	sub    $0xc,%esp
8010247b:	68 c2 73 10 80       	push   $0x801073c2
80102480:	e8 0b df ff ff       	call   80100390 <panic>
80102485:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010248c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102490 <freerange>:
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102494:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102497:	8b 75 0c             	mov    0xc(%ebp),%esi
8010249a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010249b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024ad:	39 de                	cmp    %ebx,%esi
801024af:	72 23                	jb     801024d4 <freerange+0x44>
801024b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024b8:	83 ec 0c             	sub    $0xc,%esp
801024bb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024c7:	50                   	push   %eax
801024c8:	e8 23 ff ff ff       	call   801023f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024cd:	83 c4 10             	add    $0x10,%esp
801024d0:	39 f3                	cmp    %esi,%ebx
801024d2:	76 e4                	jbe    801024b8 <freerange+0x28>
}
801024d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024d7:	5b                   	pop    %ebx
801024d8:	5e                   	pop    %esi
801024d9:	5d                   	pop    %ebp
801024da:	c3                   	ret    
801024db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024df:	90                   	nop

801024e0 <kinit1>:
{
801024e0:	55                   	push   %ebp
801024e1:	89 e5                	mov    %esp,%ebp
801024e3:	56                   	push   %esi
801024e4:	53                   	push   %ebx
801024e5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024e8:	83 ec 08             	sub    $0x8,%esp
801024eb:	68 c8 73 10 80       	push   $0x801073c8
801024f0:	68 40 26 11 80       	push   $0x80112640
801024f5:	e8 96 1f 00 00       	call   80104490 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801024fa:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024fd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102500:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102507:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010250a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102510:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102516:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010251c:	39 de                	cmp    %ebx,%esi
8010251e:	72 1c                	jb     8010253c <kinit1+0x5c>
    kfree(p);
80102520:	83 ec 0c             	sub    $0xc,%esp
80102523:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102529:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010252f:	50                   	push   %eax
80102530:	e8 bb fe ff ff       	call   801023f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102535:	83 c4 10             	add    $0x10,%esp
80102538:	39 de                	cmp    %ebx,%esi
8010253a:	73 e4                	jae    80102520 <kinit1+0x40>
}
8010253c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010253f:	5b                   	pop    %ebx
80102540:	5e                   	pop    %esi
80102541:	5d                   	pop    %ebp
80102542:	c3                   	ret    
80102543:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010254a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102550 <kinit2>:
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102554:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102557:	8b 75 0c             	mov    0xc(%ebp),%esi
8010255a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010255b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102561:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102567:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010256d:	39 de                	cmp    %ebx,%esi
8010256f:	72 23                	jb     80102594 <kinit2+0x44>
80102571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102578:	83 ec 0c             	sub    $0xc,%esp
8010257b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102581:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102587:	50                   	push   %eax
80102588:	e8 63 fe ff ff       	call   801023f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010258d:	83 c4 10             	add    $0x10,%esp
80102590:	39 de                	cmp    %ebx,%esi
80102592:	73 e4                	jae    80102578 <kinit2+0x28>
  kmem.use_lock = 1;
80102594:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010259b:	00 00 00 
}
8010259e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025a1:	5b                   	pop    %ebx
801025a2:	5e                   	pop    %esi
801025a3:	5d                   	pop    %ebp
801025a4:	c3                   	ret    
801025a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801025b0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801025b0:	55                   	push   %ebp
801025b1:	89 e5                	mov    %esp,%ebp
801025b3:	53                   	push   %ebx
801025b4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801025b7:	a1 74 26 11 80       	mov    0x80112674,%eax
801025bc:	85 c0                	test   %eax,%eax
801025be:	75 20                	jne    801025e0 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
801025c0:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801025c6:	85 db                	test   %ebx,%ebx
801025c8:	74 07                	je     801025d1 <kalloc+0x21>
    kmem.freelist = r->next;
801025ca:	8b 03                	mov    (%ebx),%eax
801025cc:	a3 78 26 11 80       	mov    %eax,0x80112678
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801025d1:	89 d8                	mov    %ebx,%eax
801025d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025d6:	c9                   	leave  
801025d7:	c3                   	ret    
801025d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025df:	90                   	nop
    acquire(&kmem.lock);
801025e0:	83 ec 0c             	sub    $0xc,%esp
801025e3:	68 40 26 11 80       	push   $0x80112640
801025e8:	e8 a3 1f 00 00       	call   80104590 <acquire>
  r = kmem.freelist;
801025ed:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801025f3:	83 c4 10             	add    $0x10,%esp
801025f6:	a1 74 26 11 80       	mov    0x80112674,%eax
801025fb:	85 db                	test   %ebx,%ebx
801025fd:	74 08                	je     80102607 <kalloc+0x57>
    kmem.freelist = r->next;
801025ff:	8b 13                	mov    (%ebx),%edx
80102601:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
80102607:	85 c0                	test   %eax,%eax
80102609:	74 c6                	je     801025d1 <kalloc+0x21>
    release(&kmem.lock);
8010260b:	83 ec 0c             	sub    $0xc,%esp
8010260e:	68 40 26 11 80       	push   $0x80112640
80102613:	e8 98 20 00 00       	call   801046b0 <release>
}
80102618:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010261a:	83 c4 10             	add    $0x10,%esp
}
8010261d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102620:	c9                   	leave  
80102621:	c3                   	ret    
80102622:	66 90                	xchg   %ax,%ax
80102624:	66 90                	xchg   %ax,%ax
80102626:	66 90                	xchg   %ax,%ax
80102628:	66 90                	xchg   %ax,%ax
8010262a:	66 90                	xchg   %ax,%ax
8010262c:	66 90                	xchg   %ax,%ax
8010262e:	66 90                	xchg   %ax,%ax

80102630 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102630:	ba 64 00 00 00       	mov    $0x64,%edx
80102635:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102636:	a8 01                	test   $0x1,%al
80102638:	0f 84 c2 00 00 00    	je     80102700 <kbdgetc+0xd0>
{
8010263e:	55                   	push   %ebp
8010263f:	ba 60 00 00 00       	mov    $0x60,%edx
80102644:	89 e5                	mov    %esp,%ebp
80102646:	53                   	push   %ebx
80102647:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102648:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010264b:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
80102651:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102657:	74 57                	je     801026b0 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102659:	89 d9                	mov    %ebx,%ecx
8010265b:	83 e1 40             	and    $0x40,%ecx
8010265e:	84 c0                	test   %al,%al
80102660:	78 5e                	js     801026c0 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102662:	85 c9                	test   %ecx,%ecx
80102664:	74 09                	je     8010266f <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102666:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102669:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
8010266c:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
8010266f:	0f b6 8a 00 75 10 80 	movzbl -0x7fef8b00(%edx),%ecx
  shift ^= togglecode[data];
80102676:	0f b6 82 00 74 10 80 	movzbl -0x7fef8c00(%edx),%eax
  shift |= shiftcode[data];
8010267d:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
8010267f:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102681:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102683:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102689:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010268c:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
8010268f:	8b 04 85 e0 73 10 80 	mov    -0x7fef8c20(,%eax,4),%eax
80102696:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010269a:	74 0b                	je     801026a7 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
8010269c:	8d 50 9f             	lea    -0x61(%eax),%edx
8010269f:	83 fa 19             	cmp    $0x19,%edx
801026a2:	77 44                	ja     801026e8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801026a4:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801026a7:	5b                   	pop    %ebx
801026a8:	5d                   	pop    %ebp
801026a9:	c3                   	ret    
801026aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
801026b0:	83 cb 40             	or     $0x40,%ebx
    return 0;
801026b3:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801026b5:	89 1d b4 a5 10 80    	mov    %ebx,0x8010a5b4
}
801026bb:	5b                   	pop    %ebx
801026bc:	5d                   	pop    %ebp
801026bd:	c3                   	ret    
801026be:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801026c0:	83 e0 7f             	and    $0x7f,%eax
801026c3:	85 c9                	test   %ecx,%ecx
801026c5:	0f 44 d0             	cmove  %eax,%edx
    return 0;
801026c8:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801026ca:	0f b6 8a 00 75 10 80 	movzbl -0x7fef8b00(%edx),%ecx
801026d1:	83 c9 40             	or     $0x40,%ecx
801026d4:	0f b6 c9             	movzbl %cl,%ecx
801026d7:	f7 d1                	not    %ecx
801026d9:	21 d9                	and    %ebx,%ecx
}
801026db:	5b                   	pop    %ebx
801026dc:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
801026dd:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
801026e3:	c3                   	ret    
801026e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801026e8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801026eb:	8d 50 20             	lea    0x20(%eax),%edx
}
801026ee:	5b                   	pop    %ebx
801026ef:	5d                   	pop    %ebp
      c += 'a' - 'A';
801026f0:	83 f9 1a             	cmp    $0x1a,%ecx
801026f3:	0f 42 c2             	cmovb  %edx,%eax
}
801026f6:	c3                   	ret    
801026f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026fe:	66 90                	xchg   %ax,%ax
    return -1;
80102700:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102705:	c3                   	ret    
80102706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010270d:	8d 76 00             	lea    0x0(%esi),%esi

80102710 <kbdintr>:

void
kbdintr(void)
{
80102710:	55                   	push   %ebp
80102711:	89 e5                	mov    %esp,%ebp
80102713:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102716:	68 30 26 10 80       	push   $0x80102630
8010271b:	e8 40 e1 ff ff       	call   80100860 <consoleintr>
}
80102720:	83 c4 10             	add    $0x10,%esp
80102723:	c9                   	leave  
80102724:	c3                   	ret    
80102725:	66 90                	xchg   %ax,%ax
80102727:	66 90                	xchg   %ax,%ax
80102729:	66 90                	xchg   %ax,%ax
8010272b:	66 90                	xchg   %ax,%ax
8010272d:	66 90                	xchg   %ax,%ax
8010272f:	90                   	nop

80102730 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102730:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102735:	85 c0                	test   %eax,%eax
80102737:	0f 84 cb 00 00 00    	je     80102808 <lapicinit+0xd8>
  lapic[index] = value;
8010273d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102744:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102747:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010274a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102751:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102754:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102757:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010275e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102761:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102764:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010276b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010276e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102771:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102778:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010277b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010277e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102785:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102788:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010278b:	8b 50 30             	mov    0x30(%eax),%edx
8010278e:	c1 ea 10             	shr    $0x10,%edx
80102791:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102797:	75 77                	jne    80102810 <lapicinit+0xe0>
  lapic[index] = value;
80102799:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801027a0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027a3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027a6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801027ad:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027b0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027b3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801027ba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027bd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027c0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027c7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027ca:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027cd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801027d4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027da:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801027e1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801027e4:	8b 50 20             	mov    0x20(%eax),%edx
801027e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ee:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027f0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027f6:	80 e6 10             	and    $0x10,%dh
801027f9:	75 f5                	jne    801027f0 <lapicinit+0xc0>
  lapic[index] = value;
801027fb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102802:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102805:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102808:	c3                   	ret    
80102809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102810:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102817:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010281a:	8b 50 20             	mov    0x20(%eax),%edx
8010281d:	e9 77 ff ff ff       	jmp    80102799 <lapicinit+0x69>
80102822:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102830 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102830:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102835:	85 c0                	test   %eax,%eax
80102837:	74 07                	je     80102840 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102839:	8b 40 20             	mov    0x20(%eax),%eax
8010283c:	c1 e8 18             	shr    $0x18,%eax
8010283f:	c3                   	ret    
    return 0;
80102840:	31 c0                	xor    %eax,%eax
}
80102842:	c3                   	ret    
80102843:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010284a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102850 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102850:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102855:	85 c0                	test   %eax,%eax
80102857:	74 0d                	je     80102866 <lapiceoi+0x16>
  lapic[index] = value;
80102859:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102860:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102863:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102866:	c3                   	ret    
80102867:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010286e:	66 90                	xchg   %ax,%ax

80102870 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102870:	c3                   	ret    
80102871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010287f:	90                   	nop

80102880 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102880:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102881:	b8 0f 00 00 00       	mov    $0xf,%eax
80102886:	ba 70 00 00 00       	mov    $0x70,%edx
8010288b:	89 e5                	mov    %esp,%ebp
8010288d:	53                   	push   %ebx
8010288e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102891:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102894:	ee                   	out    %al,(%dx)
80102895:	b8 0a 00 00 00       	mov    $0xa,%eax
8010289a:	ba 71 00 00 00       	mov    $0x71,%edx
8010289f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801028a0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801028a2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801028a5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801028ab:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801028ad:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
801028b0:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
801028b2:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
801028b5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801028b8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801028be:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801028c3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028c9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028cc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801028d3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028d6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028d9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028e0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028e3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028e6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ec:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028ef:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028f5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028f8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028fe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102901:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
80102907:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102908:	8b 40 20             	mov    0x20(%eax),%eax
}
8010290b:	5d                   	pop    %ebp
8010290c:	c3                   	ret    
8010290d:	8d 76 00             	lea    0x0(%esi),%esi

80102910 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102910:	55                   	push   %ebp
80102911:	b8 0b 00 00 00       	mov    $0xb,%eax
80102916:	ba 70 00 00 00       	mov    $0x70,%edx
8010291b:	89 e5                	mov    %esp,%ebp
8010291d:	57                   	push   %edi
8010291e:	56                   	push   %esi
8010291f:	53                   	push   %ebx
80102920:	83 ec 4c             	sub    $0x4c,%esp
80102923:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102924:	ba 71 00 00 00       	mov    $0x71,%edx
80102929:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010292a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010292d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102932:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102935:	8d 76 00             	lea    0x0(%esi),%esi
80102938:	31 c0                	xor    %eax,%eax
8010293a:	89 da                	mov    %ebx,%edx
8010293c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102942:	89 ca                	mov    %ecx,%edx
80102944:	ec                   	in     (%dx),%al
80102945:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102948:	89 da                	mov    %ebx,%edx
8010294a:	b8 02 00 00 00       	mov    $0x2,%eax
8010294f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102950:	89 ca                	mov    %ecx,%edx
80102952:	ec                   	in     (%dx),%al
80102953:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102956:	89 da                	mov    %ebx,%edx
80102958:	b8 04 00 00 00       	mov    $0x4,%eax
8010295d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010295e:	89 ca                	mov    %ecx,%edx
80102960:	ec                   	in     (%dx),%al
80102961:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102964:	89 da                	mov    %ebx,%edx
80102966:	b8 07 00 00 00       	mov    $0x7,%eax
8010296b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010296c:	89 ca                	mov    %ecx,%edx
8010296e:	ec                   	in     (%dx),%al
8010296f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102972:	89 da                	mov    %ebx,%edx
80102974:	b8 08 00 00 00       	mov    $0x8,%eax
80102979:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010297a:	89 ca                	mov    %ecx,%edx
8010297c:	ec                   	in     (%dx),%al
8010297d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010297f:	89 da                	mov    %ebx,%edx
80102981:	b8 09 00 00 00       	mov    $0x9,%eax
80102986:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102987:	89 ca                	mov    %ecx,%edx
80102989:	ec                   	in     (%dx),%al
8010298a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010298c:	89 da                	mov    %ebx,%edx
8010298e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102993:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102994:	89 ca                	mov    %ecx,%edx
80102996:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102997:	84 c0                	test   %al,%al
80102999:	78 9d                	js     80102938 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010299b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010299f:	89 fa                	mov    %edi,%edx
801029a1:	0f b6 fa             	movzbl %dl,%edi
801029a4:	89 f2                	mov    %esi,%edx
801029a6:	89 45 b8             	mov    %eax,-0x48(%ebp)
801029a9:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801029ad:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b0:	89 da                	mov    %ebx,%edx
801029b2:	89 7d c8             	mov    %edi,-0x38(%ebp)
801029b5:	89 45 bc             	mov    %eax,-0x44(%ebp)
801029b8:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801029bc:	89 75 cc             	mov    %esi,-0x34(%ebp)
801029bf:	89 45 c0             	mov    %eax,-0x40(%ebp)
801029c2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801029c6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801029c9:	31 c0                	xor    %eax,%eax
801029cb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029cc:	89 ca                	mov    %ecx,%edx
801029ce:	ec                   	in     (%dx),%al
801029cf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d2:	89 da                	mov    %ebx,%edx
801029d4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029d7:	b8 02 00 00 00       	mov    $0x2,%eax
801029dc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029dd:	89 ca                	mov    %ecx,%edx
801029df:	ec                   	in     (%dx),%al
801029e0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e3:	89 da                	mov    %ebx,%edx
801029e5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029e8:	b8 04 00 00 00       	mov    $0x4,%eax
801029ed:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ee:	89 ca                	mov    %ecx,%edx
801029f0:	ec                   	in     (%dx),%al
801029f1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f4:	89 da                	mov    %ebx,%edx
801029f6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029f9:	b8 07 00 00 00       	mov    $0x7,%eax
801029fe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ff:	89 ca                	mov    %ecx,%edx
80102a01:	ec                   	in     (%dx),%al
80102a02:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a05:	89 da                	mov    %ebx,%edx
80102a07:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102a0a:	b8 08 00 00 00       	mov    $0x8,%eax
80102a0f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a10:	89 ca                	mov    %ecx,%edx
80102a12:	ec                   	in     (%dx),%al
80102a13:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a16:	89 da                	mov    %ebx,%edx
80102a18:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a1b:	b8 09 00 00 00       	mov    $0x9,%eax
80102a20:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a21:	89 ca                	mov    %ecx,%edx
80102a23:	ec                   	in     (%dx),%al
80102a24:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a27:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102a2a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a2d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102a30:	6a 18                	push   $0x18
80102a32:	50                   	push   %eax
80102a33:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a36:	50                   	push   %eax
80102a37:	e8 14 1d 00 00       	call   80104750 <memcmp>
80102a3c:	83 c4 10             	add    $0x10,%esp
80102a3f:	85 c0                	test   %eax,%eax
80102a41:	0f 85 f1 fe ff ff    	jne    80102938 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102a47:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102a4b:	75 78                	jne    80102ac5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a4d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a50:	89 c2                	mov    %eax,%edx
80102a52:	83 e0 0f             	and    $0xf,%eax
80102a55:	c1 ea 04             	shr    $0x4,%edx
80102a58:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a5b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a5e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a61:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a64:	89 c2                	mov    %eax,%edx
80102a66:	83 e0 0f             	and    $0xf,%eax
80102a69:	c1 ea 04             	shr    $0x4,%edx
80102a6c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a6f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a72:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a75:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a78:	89 c2                	mov    %eax,%edx
80102a7a:	83 e0 0f             	and    $0xf,%eax
80102a7d:	c1 ea 04             	shr    $0x4,%edx
80102a80:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a83:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a86:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a89:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a8c:	89 c2                	mov    %eax,%edx
80102a8e:	83 e0 0f             	and    $0xf,%eax
80102a91:	c1 ea 04             	shr    $0x4,%edx
80102a94:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a97:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a9a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a9d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102aa0:	89 c2                	mov    %eax,%edx
80102aa2:	83 e0 0f             	and    $0xf,%eax
80102aa5:	c1 ea 04             	shr    $0x4,%edx
80102aa8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102aab:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102aae:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102ab1:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ab4:	89 c2                	mov    %eax,%edx
80102ab6:	83 e0 0f             	and    $0xf,%eax
80102ab9:	c1 ea 04             	shr    $0x4,%edx
80102abc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102abf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ac2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102ac5:	8b 75 08             	mov    0x8(%ebp),%esi
80102ac8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102acb:	89 06                	mov    %eax,(%esi)
80102acd:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ad0:	89 46 04             	mov    %eax,0x4(%esi)
80102ad3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ad6:	89 46 08             	mov    %eax,0x8(%esi)
80102ad9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102adc:	89 46 0c             	mov    %eax,0xc(%esi)
80102adf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ae2:	89 46 10             	mov    %eax,0x10(%esi)
80102ae5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ae8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102aeb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102af2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102af5:	5b                   	pop    %ebx
80102af6:	5e                   	pop    %esi
80102af7:	5f                   	pop    %edi
80102af8:	5d                   	pop    %ebp
80102af9:	c3                   	ret    
80102afa:	66 90                	xchg   %ax,%ax
80102afc:	66 90                	xchg   %ax,%ax
80102afe:	66 90                	xchg   %ax,%ax

80102b00 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b00:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102b06:	85 c9                	test   %ecx,%ecx
80102b08:	0f 8e 8a 00 00 00    	jle    80102b98 <install_trans+0x98>
{
80102b0e:	55                   	push   %ebp
80102b0f:	89 e5                	mov    %esp,%ebp
80102b11:	57                   	push   %edi
80102b12:	56                   	push   %esi
80102b13:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102b14:	31 db                	xor    %ebx,%ebx
{
80102b16:	83 ec 0c             	sub    $0xc,%esp
80102b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b20:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102b25:	83 ec 08             	sub    $0x8,%esp
80102b28:	01 d8                	add    %ebx,%eax
80102b2a:	83 c0 01             	add    $0x1,%eax
80102b2d:	50                   	push   %eax
80102b2e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102b34:	e8 97 d5 ff ff       	call   801000d0 <bread>
80102b39:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b3b:	58                   	pop    %eax
80102b3c:	5a                   	pop    %edx
80102b3d:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102b44:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102b4a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b4d:	e8 7e d5 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b52:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b55:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b57:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b5a:	68 00 02 00 00       	push   $0x200
80102b5f:	50                   	push   %eax
80102b60:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b63:	50                   	push   %eax
80102b64:	e8 37 1c 00 00       	call   801047a0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b69:	89 34 24             	mov    %esi,(%esp)
80102b6c:	e8 3f d6 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102b71:	89 3c 24             	mov    %edi,(%esp)
80102b74:	e8 77 d6 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102b79:	89 34 24             	mov    %esi,(%esp)
80102b7c:	e8 6f d6 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b81:	83 c4 10             	add    $0x10,%esp
80102b84:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102b8a:	7f 94                	jg     80102b20 <install_trans+0x20>
  }
}
80102b8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b8f:	5b                   	pop    %ebx
80102b90:	5e                   	pop    %esi
80102b91:	5f                   	pop    %edi
80102b92:	5d                   	pop    %ebp
80102b93:	c3                   	ret    
80102b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b98:	c3                   	ret    
80102b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ba0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ba0:	55                   	push   %ebp
80102ba1:	89 e5                	mov    %esp,%ebp
80102ba3:	53                   	push   %ebx
80102ba4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ba7:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102bad:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102bb3:	e8 18 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102bb8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102bbb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102bbd:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102bc2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102bc5:	85 c0                	test   %eax,%eax
80102bc7:	7e 19                	jle    80102be2 <write_head+0x42>
80102bc9:	31 d2                	xor    %edx,%edx
80102bcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102bcf:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102bd0:	8b 0c 95 cc 26 11 80 	mov    -0x7feed934(,%edx,4),%ecx
80102bd7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102bdb:	83 c2 01             	add    $0x1,%edx
80102bde:	39 d0                	cmp    %edx,%eax
80102be0:	75 ee                	jne    80102bd0 <write_head+0x30>
  }
  bwrite(buf);
80102be2:	83 ec 0c             	sub    $0xc,%esp
80102be5:	53                   	push   %ebx
80102be6:	e8 c5 d5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102beb:	89 1c 24             	mov    %ebx,(%esp)
80102bee:	e8 fd d5 ff ff       	call   801001f0 <brelse>
}
80102bf3:	83 c4 10             	add    $0x10,%esp
80102bf6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bf9:	c9                   	leave  
80102bfa:	c3                   	ret    
80102bfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102bff:	90                   	nop

80102c00 <initlog>:
{
80102c00:	55                   	push   %ebp
80102c01:	89 e5                	mov    %esp,%ebp
80102c03:	53                   	push   %ebx
80102c04:	83 ec 2c             	sub    $0x2c,%esp
80102c07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102c0a:	68 00 76 10 80       	push   $0x80107600
80102c0f:	68 80 26 11 80       	push   $0x80112680
80102c14:	e8 77 18 00 00       	call   80104490 <initlock>
  readsb(dev, &sb);
80102c19:	58                   	pop    %eax
80102c1a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c1d:	5a                   	pop    %edx
80102c1e:	50                   	push   %eax
80102c1f:	53                   	push   %ebx
80102c20:	e8 3b e8 ff ff       	call   80101460 <readsb>
  log.start = sb.logstart;
80102c25:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102c28:	59                   	pop    %ecx
  log.dev = dev;
80102c29:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  log.size = sb.nlog;
80102c2f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102c32:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  log.size = sb.nlog;
80102c37:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  struct buf *buf = bread(log.dev, log.start);
80102c3d:	5a                   	pop    %edx
80102c3e:	50                   	push   %eax
80102c3f:	53                   	push   %ebx
80102c40:	e8 8b d4 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102c45:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102c48:	8b 48 5c             	mov    0x5c(%eax),%ecx
80102c4b:	89 0d c8 26 11 80    	mov    %ecx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102c51:	85 c9                	test   %ecx,%ecx
80102c53:	7e 1d                	jle    80102c72 <initlog+0x72>
80102c55:	31 d2                	xor    %edx,%edx
80102c57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c5e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102c60:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
80102c64:	89 1c 95 cc 26 11 80 	mov    %ebx,-0x7feed934(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102c6b:	83 c2 01             	add    $0x1,%edx
80102c6e:	39 d1                	cmp    %edx,%ecx
80102c70:	75 ee                	jne    80102c60 <initlog+0x60>
  brelse(buf);
80102c72:	83 ec 0c             	sub    $0xc,%esp
80102c75:	50                   	push   %eax
80102c76:	e8 75 d5 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c7b:	e8 80 fe ff ff       	call   80102b00 <install_trans>
  log.lh.n = 0;
80102c80:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102c87:	00 00 00 
  write_head(); // clear the log
80102c8a:	e8 11 ff ff ff       	call   80102ba0 <write_head>
}
80102c8f:	83 c4 10             	add    $0x10,%esp
80102c92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c95:	c9                   	leave  
80102c96:	c3                   	ret    
80102c97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c9e:	66 90                	xchg   %ax,%ax

80102ca0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102ca0:	55                   	push   %ebp
80102ca1:	89 e5                	mov    %esp,%ebp
80102ca3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102ca6:	68 80 26 11 80       	push   $0x80112680
80102cab:	e8 e0 18 00 00       	call   80104590 <acquire>
80102cb0:	83 c4 10             	add    $0x10,%esp
80102cb3:	eb 18                	jmp    80102ccd <begin_op+0x2d>
80102cb5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102cb8:	83 ec 08             	sub    $0x8,%esp
80102cbb:	68 80 26 11 80       	push   $0x80112680
80102cc0:	68 80 26 11 80       	push   $0x80112680
80102cc5:	e8 c6 11 00 00       	call   80103e90 <sleep>
80102cca:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102ccd:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102cd2:	85 c0                	test   %eax,%eax
80102cd4:	75 e2                	jne    80102cb8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102cd6:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102cdb:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102ce1:	83 c0 01             	add    $0x1,%eax
80102ce4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102ce7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cea:	83 fa 1e             	cmp    $0x1e,%edx
80102ced:	7f c9                	jg     80102cb8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102cef:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102cf2:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102cf7:	68 80 26 11 80       	push   $0x80112680
80102cfc:	e8 af 19 00 00       	call   801046b0 <release>
      break;
    }
  }
}
80102d01:	83 c4 10             	add    $0x10,%esp
80102d04:	c9                   	leave  
80102d05:	c3                   	ret    
80102d06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d0d:	8d 76 00             	lea    0x0(%esi),%esi

80102d10 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d10:	55                   	push   %ebp
80102d11:	89 e5                	mov    %esp,%ebp
80102d13:	57                   	push   %edi
80102d14:	56                   	push   %esi
80102d15:	53                   	push   %ebx
80102d16:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d19:	68 80 26 11 80       	push   $0x80112680
80102d1e:	e8 6d 18 00 00       	call   80104590 <acquire>
  log.outstanding -= 1;
80102d23:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102d28:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102d2e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102d31:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102d34:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102d3a:	85 f6                	test   %esi,%esi
80102d3c:	0f 85 22 01 00 00    	jne    80102e64 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102d42:	85 db                	test   %ebx,%ebx
80102d44:	0f 85 f6 00 00 00    	jne    80102e40 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102d4a:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102d51:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d54:	83 ec 0c             	sub    $0xc,%esp
80102d57:	68 80 26 11 80       	push   $0x80112680
80102d5c:	e8 4f 19 00 00       	call   801046b0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d61:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102d67:	83 c4 10             	add    $0x10,%esp
80102d6a:	85 c9                	test   %ecx,%ecx
80102d6c:	7f 42                	jg     80102db0 <end_op+0xa0>
    acquire(&log.lock);
80102d6e:	83 ec 0c             	sub    $0xc,%esp
80102d71:	68 80 26 11 80       	push   $0x80112680
80102d76:	e8 15 18 00 00       	call   80104590 <acquire>
    wakeup(&log);
80102d7b:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102d82:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102d89:	00 00 00 
    wakeup(&log);
80102d8c:	e8 bf 12 00 00       	call   80104050 <wakeup>
    release(&log.lock);
80102d91:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d98:	e8 13 19 00 00       	call   801046b0 <release>
80102d9d:	83 c4 10             	add    $0x10,%esp
}
80102da0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102da3:	5b                   	pop    %ebx
80102da4:	5e                   	pop    %esi
80102da5:	5f                   	pop    %edi
80102da6:	5d                   	pop    %ebp
80102da7:	c3                   	ret    
80102da8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102daf:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102db0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102db5:	83 ec 08             	sub    $0x8,%esp
80102db8:	01 d8                	add    %ebx,%eax
80102dba:	83 c0 01             	add    $0x1,%eax
80102dbd:	50                   	push   %eax
80102dbe:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102dc4:	e8 07 d3 ff ff       	call   801000d0 <bread>
80102dc9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102dcb:	58                   	pop    %eax
80102dcc:	5a                   	pop    %edx
80102dcd:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102dd4:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102dda:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ddd:	e8 ee d2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102de2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102de5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102de7:	8d 40 5c             	lea    0x5c(%eax),%eax
80102dea:	68 00 02 00 00       	push   $0x200
80102def:	50                   	push   %eax
80102df0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102df3:	50                   	push   %eax
80102df4:	e8 a7 19 00 00       	call   801047a0 <memmove>
    bwrite(to);  // write the log
80102df9:	89 34 24             	mov    %esi,(%esp)
80102dfc:	e8 af d3 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102e01:	89 3c 24             	mov    %edi,(%esp)
80102e04:	e8 e7 d3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102e09:	89 34 24             	mov    %esi,(%esp)
80102e0c:	e8 df d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e11:	83 c4 10             	add    $0x10,%esp
80102e14:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102e1a:	7c 94                	jl     80102db0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e1c:	e8 7f fd ff ff       	call   80102ba0 <write_head>
    install_trans(); // Now install writes to home locations
80102e21:	e8 da fc ff ff       	call   80102b00 <install_trans>
    log.lh.n = 0;
80102e26:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102e2d:	00 00 00 
    write_head();    // Erase the transaction from the log
80102e30:	e8 6b fd ff ff       	call   80102ba0 <write_head>
80102e35:	e9 34 ff ff ff       	jmp    80102d6e <end_op+0x5e>
80102e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102e40:	83 ec 0c             	sub    $0xc,%esp
80102e43:	68 80 26 11 80       	push   $0x80112680
80102e48:	e8 03 12 00 00       	call   80104050 <wakeup>
  release(&log.lock);
80102e4d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102e54:	e8 57 18 00 00       	call   801046b0 <release>
80102e59:	83 c4 10             	add    $0x10,%esp
}
80102e5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e5f:	5b                   	pop    %ebx
80102e60:	5e                   	pop    %esi
80102e61:	5f                   	pop    %edi
80102e62:	5d                   	pop    %ebp
80102e63:	c3                   	ret    
    panic("log.committing");
80102e64:	83 ec 0c             	sub    $0xc,%esp
80102e67:	68 04 76 10 80       	push   $0x80107604
80102e6c:	e8 1f d5 ff ff       	call   80100390 <panic>
80102e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e7f:	90                   	nop

80102e80 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e80:	55                   	push   %ebp
80102e81:	89 e5                	mov    %esp,%ebp
80102e83:	53                   	push   %ebx
80102e84:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e87:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
{
80102e8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e90:	83 fa 1d             	cmp    $0x1d,%edx
80102e93:	0f 8f 94 00 00 00    	jg     80102f2d <log_write+0xad>
80102e99:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102e9e:	83 e8 01             	sub    $0x1,%eax
80102ea1:	39 c2                	cmp    %eax,%edx
80102ea3:	0f 8d 84 00 00 00    	jge    80102f2d <log_write+0xad>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102ea9:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102eae:	85 c0                	test   %eax,%eax
80102eb0:	0f 8e 84 00 00 00    	jle    80102f3a <log_write+0xba>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102eb6:	83 ec 0c             	sub    $0xc,%esp
80102eb9:	68 80 26 11 80       	push   $0x80112680
80102ebe:	e8 cd 16 00 00       	call   80104590 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102ec3:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102ec9:	83 c4 10             	add    $0x10,%esp
80102ecc:	85 d2                	test   %edx,%edx
80102ece:	7e 51                	jle    80102f21 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ed0:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102ed3:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ed5:	3b 0d cc 26 11 80    	cmp    0x801126cc,%ecx
80102edb:	75 0c                	jne    80102ee9 <log_write+0x69>
80102edd:	eb 39                	jmp    80102f18 <log_write+0x98>
80102edf:	90                   	nop
80102ee0:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102ee7:	74 2f                	je     80102f18 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102ee9:	83 c0 01             	add    $0x1,%eax
80102eec:	39 c2                	cmp    %eax,%edx
80102eee:	75 f0                	jne    80102ee0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102ef0:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ef7:	83 c2 01             	add    $0x1,%edx
80102efa:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102f00:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102f03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102f06:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102f0d:	c9                   	leave  
  release(&log.lock);
80102f0e:	e9 9d 17 00 00       	jmp    801046b0 <release>
80102f13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f17:	90                   	nop
  log.lh.block[i] = b->blockno;
80102f18:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
  if (i == log.lh.n)
80102f1f:	eb df                	jmp    80102f00 <log_write+0x80>
  log.lh.block[i] = b->blockno;
80102f21:	8b 43 08             	mov    0x8(%ebx),%eax
80102f24:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102f29:	75 d5                	jne    80102f00 <log_write+0x80>
80102f2b:	eb ca                	jmp    80102ef7 <log_write+0x77>
    panic("too big a transaction");
80102f2d:	83 ec 0c             	sub    $0xc,%esp
80102f30:	68 13 76 10 80       	push   $0x80107613
80102f35:	e8 56 d4 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102f3a:	83 ec 0c             	sub    $0xc,%esp
80102f3d:	68 29 76 10 80       	push   $0x80107629
80102f42:	e8 49 d4 ff ff       	call   80100390 <panic>
80102f47:	66 90                	xchg   %ax,%ax
80102f49:	66 90                	xchg   %ax,%ax
80102f4b:	66 90                	xchg   %ax,%ax
80102f4d:	66 90                	xchg   %ax,%ax
80102f4f:	90                   	nop

80102f50 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f50:	55                   	push   %ebp
80102f51:	89 e5                	mov    %esp,%ebp
80102f53:	53                   	push   %ebx
80102f54:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f57:	e8 74 09 00 00       	call   801038d0 <cpuid>
80102f5c:	89 c3                	mov    %eax,%ebx
80102f5e:	e8 6d 09 00 00       	call   801038d0 <cpuid>
80102f63:	83 ec 04             	sub    $0x4,%esp
80102f66:	53                   	push   %ebx
80102f67:	50                   	push   %eax
80102f68:	68 44 76 10 80       	push   $0x80107644
80102f6d:	e8 3e d7 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
80102f72:	e8 19 2a 00 00       	call   80105990 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f77:	e8 d4 08 00 00       	call   80103850 <mycpu>
80102f7c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f7e:	b8 01 00 00 00       	mov    $0x1,%eax
80102f83:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f8a:	e8 21 0c 00 00       	call   80103bb0 <scheduler>
80102f8f:	90                   	nop

80102f90 <mpenter>:
{
80102f90:	55                   	push   %ebp
80102f91:	89 e5                	mov    %esp,%ebp
80102f93:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f96:	e8 f5 3a 00 00       	call   80106a90 <switchkvm>
  seginit();
80102f9b:	e8 60 3a 00 00       	call   80106a00 <seginit>
  lapicinit();
80102fa0:	e8 8b f7 ff ff       	call   80102730 <lapicinit>
  mpmain();
80102fa5:	e8 a6 ff ff ff       	call   80102f50 <mpmain>
80102faa:	66 90                	xchg   %ax,%ax
80102fac:	66 90                	xchg   %ax,%ax
80102fae:	66 90                	xchg   %ax,%ax

80102fb0 <main>:
{
80102fb0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102fb4:	83 e4 f0             	and    $0xfffffff0,%esp
80102fb7:	ff 71 fc             	pushl  -0x4(%ecx)
80102fba:	55                   	push   %ebp
80102fbb:	89 e5                	mov    %esp,%ebp
80102fbd:	53                   	push   %ebx
80102fbe:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102fbf:	83 ec 08             	sub    $0x8,%esp
80102fc2:	68 00 00 40 80       	push   $0x80400000
80102fc7:	68 a8 57 11 80       	push   $0x801157a8
80102fcc:	e8 0f f5 ff ff       	call   801024e0 <kinit1>
  kvmalloc();      // kernel page table
80102fd1:	e8 7a 3f 00 00       	call   80106f50 <kvmalloc>
  mpinit();        // detect other processors
80102fd6:	e8 85 01 00 00       	call   80103160 <mpinit>
  lapicinit();     // interrupt controller
80102fdb:	e8 50 f7 ff ff       	call   80102730 <lapicinit>
  seginit();       // segment descriptors
80102fe0:	e8 1b 3a 00 00       	call   80106a00 <seginit>
  picinit();       // disable pic
80102fe5:	e8 46 03 00 00       	call   80103330 <picinit>
  ioapicinit();    // another interrupt controller
80102fea:	e8 11 f3 ff ff       	call   80102300 <ioapicinit>
  consoleinit();   // console hardware
80102fef:	e8 3c da ff ff       	call   80100a30 <consoleinit>
  uartinit();      // serial port
80102ff4:	e8 c7 2c 00 00       	call   80105cc0 <uartinit>
  pinit();         // process table
80102ff9:	e8 32 08 00 00       	call   80103830 <pinit>
  tvinit();        // trap vectors
80102ffe:	e8 0d 29 00 00       	call   80105910 <tvinit>
  binit();         // buffer cache
80103003:	e8 38 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103008:	e8 d3 dd ff ff       	call   80100de0 <fileinit>
  ideinit();       // disk 
8010300d:	e8 ce f0 ff ff       	call   801020e0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103012:	83 c4 0c             	add    $0xc,%esp
80103015:	68 8a 00 00 00       	push   $0x8a
8010301a:	68 8c a4 10 80       	push   $0x8010a48c
8010301f:	68 00 70 00 80       	push   $0x80007000
80103024:	e8 77 17 00 00       	call   801047a0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103029:	83 c4 10             	add    $0x10,%esp
8010302c:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103033:	00 00 00 
80103036:	05 80 27 11 80       	add    $0x80112780,%eax
8010303b:	3d 80 27 11 80       	cmp    $0x80112780,%eax
80103040:	76 7e                	jbe    801030c0 <main+0x110>
80103042:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80103047:	eb 20                	jmp    80103069 <main+0xb9>
80103049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103050:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103057:	00 00 00 
8010305a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103060:	05 80 27 11 80       	add    $0x80112780,%eax
80103065:	39 c3                	cmp    %eax,%ebx
80103067:	73 57                	jae    801030c0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103069:	e8 e2 07 00 00       	call   80103850 <mycpu>
8010306e:	39 d8                	cmp    %ebx,%eax
80103070:	74 de                	je     80103050 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103072:	e8 39 f5 ff ff       	call   801025b0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103077:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-8) = mpenter;
8010307a:	c7 05 f8 6f 00 80 90 	movl   $0x80102f90,0x80006ff8
80103081:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103084:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010308b:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010308e:	05 00 10 00 00       	add    $0x1000,%eax
80103093:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103098:	0f b6 03             	movzbl (%ebx),%eax
8010309b:	68 00 70 00 00       	push   $0x7000
801030a0:	50                   	push   %eax
801030a1:	e8 da f7 ff ff       	call   80102880 <lapicstartap>
801030a6:	83 c4 10             	add    $0x10,%esp
801030a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801030b0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801030b6:	85 c0                	test   %eax,%eax
801030b8:	74 f6                	je     801030b0 <main+0x100>
801030ba:	eb 94                	jmp    80103050 <main+0xa0>
801030bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801030c0:	83 ec 08             	sub    $0x8,%esp
801030c3:	68 00 00 00 8e       	push   $0x8e000000
801030c8:	68 00 00 40 80       	push   $0x80400000
801030cd:	e8 7e f4 ff ff       	call   80102550 <kinit2>
  userinit();      // first user process
801030d2:	e8 49 08 00 00       	call   80103920 <userinit>
  mpmain();        // finish this processor's setup
801030d7:	e8 74 fe ff ff       	call   80102f50 <mpmain>
801030dc:	66 90                	xchg   %ax,%ax
801030de:	66 90                	xchg   %ax,%ax

801030e0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030e0:	55                   	push   %ebp
801030e1:	89 e5                	mov    %esp,%ebp
801030e3:	57                   	push   %edi
801030e4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801030e5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801030eb:	53                   	push   %ebx
  e = addr+len;
801030ec:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801030ef:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801030f2:	39 de                	cmp    %ebx,%esi
801030f4:	72 10                	jb     80103106 <mpsearch1+0x26>
801030f6:	eb 50                	jmp    80103148 <mpsearch1+0x68>
801030f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030ff:	90                   	nop
80103100:	89 fe                	mov    %edi,%esi
80103102:	39 fb                	cmp    %edi,%ebx
80103104:	76 42                	jbe    80103148 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103106:	83 ec 04             	sub    $0x4,%esp
80103109:	8d 7e 10             	lea    0x10(%esi),%edi
8010310c:	6a 04                	push   $0x4
8010310e:	68 58 76 10 80       	push   $0x80107658
80103113:	56                   	push   %esi
80103114:	e8 37 16 00 00       	call   80104750 <memcmp>
80103119:	83 c4 10             	add    $0x10,%esp
8010311c:	85 c0                	test   %eax,%eax
8010311e:	75 e0                	jne    80103100 <mpsearch1+0x20>
80103120:	89 f1                	mov    %esi,%ecx
80103122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103128:	0f b6 11             	movzbl (%ecx),%edx
8010312b:	83 c1 01             	add    $0x1,%ecx
8010312e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103130:	39 f9                	cmp    %edi,%ecx
80103132:	75 f4                	jne    80103128 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103134:	84 c0                	test   %al,%al
80103136:	75 c8                	jne    80103100 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103138:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010313b:	89 f0                	mov    %esi,%eax
8010313d:	5b                   	pop    %ebx
8010313e:	5e                   	pop    %esi
8010313f:	5f                   	pop    %edi
80103140:	5d                   	pop    %ebp
80103141:	c3                   	ret    
80103142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103148:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010314b:	31 f6                	xor    %esi,%esi
}
8010314d:	5b                   	pop    %ebx
8010314e:	89 f0                	mov    %esi,%eax
80103150:	5e                   	pop    %esi
80103151:	5f                   	pop    %edi
80103152:	5d                   	pop    %ebp
80103153:	c3                   	ret    
80103154:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010315b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010315f:	90                   	nop

80103160 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103160:	55                   	push   %ebp
80103161:	89 e5                	mov    %esp,%ebp
80103163:	57                   	push   %edi
80103164:	56                   	push   %esi
80103165:	53                   	push   %ebx
80103166:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103169:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103170:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103177:	c1 e0 08             	shl    $0x8,%eax
8010317a:	09 d0                	or     %edx,%eax
8010317c:	c1 e0 04             	shl    $0x4,%eax
8010317f:	75 1b                	jne    8010319c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103181:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103188:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010318f:	c1 e0 08             	shl    $0x8,%eax
80103192:	09 d0                	or     %edx,%eax
80103194:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103197:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010319c:	ba 00 04 00 00       	mov    $0x400,%edx
801031a1:	e8 3a ff ff ff       	call   801030e0 <mpsearch1>
801031a6:	89 c7                	mov    %eax,%edi
801031a8:	85 c0                	test   %eax,%eax
801031aa:	0f 84 c0 00 00 00    	je     80103270 <mpinit+0x110>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031b0:	8b 5f 04             	mov    0x4(%edi),%ebx
801031b3:	85 db                	test   %ebx,%ebx
801031b5:	0f 84 d5 00 00 00    	je     80103290 <mpinit+0x130>
  if(memcmp(conf, "PCMP", 4) != 0)
801031bb:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801031be:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
801031c4:	6a 04                	push   $0x4
801031c6:	68 75 76 10 80       	push   $0x80107675
801031cb:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801031cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801031cf:	e8 7c 15 00 00       	call   80104750 <memcmp>
801031d4:	83 c4 10             	add    $0x10,%esp
801031d7:	85 c0                	test   %eax,%eax
801031d9:	0f 85 b1 00 00 00    	jne    80103290 <mpinit+0x130>
  if(conf->version != 1 && conf->version != 4)
801031df:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801031e6:	3c 01                	cmp    $0x1,%al
801031e8:	0f 95 c2             	setne  %dl
801031eb:	3c 04                	cmp    $0x4,%al
801031ed:	0f 95 c0             	setne  %al
801031f0:	20 c2                	and    %al,%dl
801031f2:	0f 85 98 00 00 00    	jne    80103290 <mpinit+0x130>
  if(sum((uchar*)conf, conf->length) != 0)
801031f8:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
  for(i=0; i<len; i++)
801031ff:	66 85 c9             	test   %cx,%cx
80103202:	74 21                	je     80103225 <mpinit+0xc5>
80103204:	89 d8                	mov    %ebx,%eax
80103206:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
  sum = 0;
80103209:	31 d2                	xor    %edx,%edx
8010320b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010320f:	90                   	nop
    sum += addr[i];
80103210:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103217:	83 c0 01             	add    $0x1,%eax
8010321a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010321c:	39 c6                	cmp    %eax,%esi
8010321e:	75 f0                	jne    80103210 <mpinit+0xb0>
80103220:	84 d2                	test   %dl,%dl
80103222:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103225:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103228:	85 c9                	test   %ecx,%ecx
8010322a:	74 64                	je     80103290 <mpinit+0x130>
8010322c:	84 d2                	test   %dl,%dl
8010322e:	75 60                	jne    80103290 <mpinit+0x130>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103230:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103236:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010323b:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103242:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103248:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010324d:	01 d1                	add    %edx,%ecx
8010324f:	89 ce                	mov    %ecx,%esi
80103251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103258:	39 c6                	cmp    %eax,%esi
8010325a:	76 4b                	jbe    801032a7 <mpinit+0x147>
    switch(*p){
8010325c:	0f b6 10             	movzbl (%eax),%edx
8010325f:	80 fa 04             	cmp    $0x4,%dl
80103262:	0f 87 bf 00 00 00    	ja     80103327 <mpinit+0x1c7>
80103268:	ff 24 95 9c 76 10 80 	jmp    *-0x7fef8964(,%edx,4)
8010326f:	90                   	nop
  return mpsearch1(0xF0000, 0x10000);
80103270:	ba 00 00 01 00       	mov    $0x10000,%edx
80103275:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010327a:	e8 61 fe ff ff       	call   801030e0 <mpsearch1>
8010327f:	89 c7                	mov    %eax,%edi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103281:	85 c0                	test   %eax,%eax
80103283:	0f 85 27 ff ff ff    	jne    801031b0 <mpinit+0x50>
80103289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103290:	83 ec 0c             	sub    $0xc,%esp
80103293:	68 5d 76 10 80       	push   $0x8010765d
80103298:	e8 f3 d0 ff ff       	call   80100390 <panic>
8010329d:	8d 76 00             	lea    0x0(%esi),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032a0:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032a3:	39 c6                	cmp    %eax,%esi
801032a5:	77 b5                	ja     8010325c <mpinit+0xfc>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032a7:	85 db                	test   %ebx,%ebx
801032a9:	74 6f                	je     8010331a <mpinit+0x1ba>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032ab:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
801032af:	74 15                	je     801032c6 <mpinit+0x166>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032b1:	b8 70 00 00 00       	mov    $0x70,%eax
801032b6:	ba 22 00 00 00       	mov    $0x22,%edx
801032bb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032bc:	ba 23 00 00 00       	mov    $0x23,%edx
801032c1:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801032c2:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032c5:	ee                   	out    %al,(%dx)
  }
}
801032c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032c9:	5b                   	pop    %ebx
801032ca:	5e                   	pop    %esi
801032cb:	5f                   	pop    %edi
801032cc:	5d                   	pop    %ebp
801032cd:	c3                   	ret    
801032ce:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
801032d0:	8b 15 00 2d 11 80    	mov    0x80112d00,%edx
801032d6:	83 fa 07             	cmp    $0x7,%edx
801032d9:	7f 1f                	jg     801032fa <mpinit+0x19a>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801032db:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
801032e1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801032e4:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801032e8:	88 91 80 27 11 80    	mov    %dl,-0x7feed880(%ecx)
        ncpu++;
801032ee:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801032f1:	83 c2 01             	add    $0x1,%edx
801032f4:	89 15 00 2d 11 80    	mov    %edx,0x80112d00
      p += sizeof(struct mpproc);
801032fa:	83 c0 14             	add    $0x14,%eax
      continue;
801032fd:	e9 56 ff ff ff       	jmp    80103258 <mpinit+0xf8>
80103302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ioapicid = ioapic->apicno;
80103308:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010330c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010330f:	88 15 60 27 11 80    	mov    %dl,0x80112760
      continue;
80103315:	e9 3e ff ff ff       	jmp    80103258 <mpinit+0xf8>
    panic("Didn't find a suitable machine");
8010331a:	83 ec 0c             	sub    $0xc,%esp
8010331d:	68 7c 76 10 80       	push   $0x8010767c
80103322:	e8 69 d0 ff ff       	call   80100390 <panic>
      ismp = 0;
80103327:	31 db                	xor    %ebx,%ebx
80103329:	e9 31 ff ff ff       	jmp    8010325f <mpinit+0xff>
8010332e:	66 90                	xchg   %ax,%ax

80103330 <picinit>:
80103330:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103335:	ba 21 00 00 00       	mov    $0x21,%edx
8010333a:	ee                   	out    %al,(%dx)
8010333b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103340:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103341:	c3                   	ret    
80103342:	66 90                	xchg   %ax,%ax
80103344:	66 90                	xchg   %ax,%ax
80103346:	66 90                	xchg   %ax,%ax
80103348:	66 90                	xchg   %ax,%ax
8010334a:	66 90                	xchg   %ax,%ax
8010334c:	66 90                	xchg   %ax,%ax
8010334e:	66 90                	xchg   %ax,%ax

80103350 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103350:	55                   	push   %ebp
80103351:	89 e5                	mov    %esp,%ebp
80103353:	57                   	push   %edi
80103354:	56                   	push   %esi
80103355:	53                   	push   %ebx
80103356:	83 ec 0c             	sub    $0xc,%esp
80103359:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010335c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010335f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103365:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010336b:	e8 90 da ff ff       	call   80100e00 <filealloc>
80103370:	89 03                	mov    %eax,(%ebx)
80103372:	85 c0                	test   %eax,%eax
80103374:	0f 84 a8 00 00 00    	je     80103422 <pipealloc+0xd2>
8010337a:	e8 81 da ff ff       	call   80100e00 <filealloc>
8010337f:	89 06                	mov    %eax,(%esi)
80103381:	85 c0                	test   %eax,%eax
80103383:	0f 84 87 00 00 00    	je     80103410 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103389:	e8 22 f2 ff ff       	call   801025b0 <kalloc>
8010338e:	89 c7                	mov    %eax,%edi
80103390:	85 c0                	test   %eax,%eax
80103392:	0f 84 b0 00 00 00    	je     80103448 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103398:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010339f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801033a2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801033a5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801033ac:	00 00 00 
  p->nwrite = 0;
801033af:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801033b6:	00 00 00 
  p->nread = 0;
801033b9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801033c0:	00 00 00 
  initlock(&p->lock, "pipe");
801033c3:	68 b0 76 10 80       	push   $0x801076b0
801033c8:	50                   	push   %eax
801033c9:	e8 c2 10 00 00       	call   80104490 <initlock>
  (*f0)->type = FD_PIPE;
801033ce:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801033d0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801033d3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801033d9:	8b 03                	mov    (%ebx),%eax
801033db:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801033df:	8b 03                	mov    (%ebx),%eax
801033e1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801033e5:	8b 03                	mov    (%ebx),%eax
801033e7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801033ea:	8b 06                	mov    (%esi),%eax
801033ec:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801033f2:	8b 06                	mov    (%esi),%eax
801033f4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801033f8:	8b 06                	mov    (%esi),%eax
801033fa:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801033fe:	8b 06                	mov    (%esi),%eax
80103400:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103403:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103406:	31 c0                	xor    %eax,%eax
}
80103408:	5b                   	pop    %ebx
80103409:	5e                   	pop    %esi
8010340a:	5f                   	pop    %edi
8010340b:	5d                   	pop    %ebp
8010340c:	c3                   	ret    
8010340d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103410:	8b 03                	mov    (%ebx),%eax
80103412:	85 c0                	test   %eax,%eax
80103414:	74 1e                	je     80103434 <pipealloc+0xe4>
    fileclose(*f0);
80103416:	83 ec 0c             	sub    $0xc,%esp
80103419:	50                   	push   %eax
8010341a:	e8 a1 da ff ff       	call   80100ec0 <fileclose>
8010341f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103422:	8b 06                	mov    (%esi),%eax
80103424:	85 c0                	test   %eax,%eax
80103426:	74 0c                	je     80103434 <pipealloc+0xe4>
    fileclose(*f1);
80103428:	83 ec 0c             	sub    $0xc,%esp
8010342b:	50                   	push   %eax
8010342c:	e8 8f da ff ff       	call   80100ec0 <fileclose>
80103431:	83 c4 10             	add    $0x10,%esp
}
80103434:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103437:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010343c:	5b                   	pop    %ebx
8010343d:	5e                   	pop    %esi
8010343e:	5f                   	pop    %edi
8010343f:	5d                   	pop    %ebp
80103440:	c3                   	ret    
80103441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103448:	8b 03                	mov    (%ebx),%eax
8010344a:	85 c0                	test   %eax,%eax
8010344c:	75 c8                	jne    80103416 <pipealloc+0xc6>
8010344e:	eb d2                	jmp    80103422 <pipealloc+0xd2>

80103450 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103450:	55                   	push   %ebp
80103451:	89 e5                	mov    %esp,%ebp
80103453:	56                   	push   %esi
80103454:	53                   	push   %ebx
80103455:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103458:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010345b:	83 ec 0c             	sub    $0xc,%esp
8010345e:	53                   	push   %ebx
8010345f:	e8 2c 11 00 00       	call   80104590 <acquire>
  if(writable){
80103464:	83 c4 10             	add    $0x10,%esp
80103467:	85 f6                	test   %esi,%esi
80103469:	74 65                	je     801034d0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010346b:	83 ec 0c             	sub    $0xc,%esp
8010346e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103474:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010347b:	00 00 00 
    wakeup(&p->nread);
8010347e:	50                   	push   %eax
8010347f:	e8 cc 0b 00 00       	call   80104050 <wakeup>
80103484:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103487:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010348d:	85 d2                	test   %edx,%edx
8010348f:	75 0a                	jne    8010349b <pipeclose+0x4b>
80103491:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103497:	85 c0                	test   %eax,%eax
80103499:	74 15                	je     801034b0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010349b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010349e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034a1:	5b                   	pop    %ebx
801034a2:	5e                   	pop    %esi
801034a3:	5d                   	pop    %ebp
    release(&p->lock);
801034a4:	e9 07 12 00 00       	jmp    801046b0 <release>
801034a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801034b0:	83 ec 0c             	sub    $0xc,%esp
801034b3:	53                   	push   %ebx
801034b4:	e8 f7 11 00 00       	call   801046b0 <release>
    kfree((char*)p);
801034b9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034bc:	83 c4 10             	add    $0x10,%esp
}
801034bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034c2:	5b                   	pop    %ebx
801034c3:	5e                   	pop    %esi
801034c4:	5d                   	pop    %ebp
    kfree((char*)p);
801034c5:	e9 26 ef ff ff       	jmp    801023f0 <kfree>
801034ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801034d0:	83 ec 0c             	sub    $0xc,%esp
801034d3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801034d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801034e0:	00 00 00 
    wakeup(&p->nwrite);
801034e3:	50                   	push   %eax
801034e4:	e8 67 0b 00 00       	call   80104050 <wakeup>
801034e9:	83 c4 10             	add    $0x10,%esp
801034ec:	eb 99                	jmp    80103487 <pipeclose+0x37>
801034ee:	66 90                	xchg   %ax,%ax

801034f0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034f0:	55                   	push   %ebp
801034f1:	89 e5                	mov    %esp,%ebp
801034f3:	57                   	push   %edi
801034f4:	56                   	push   %esi
801034f5:	53                   	push   %ebx
801034f6:	83 ec 28             	sub    $0x28,%esp
801034f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801034fc:	53                   	push   %ebx
801034fd:	e8 8e 10 00 00       	call   80104590 <acquire>
  for(i = 0; i < n; i++){
80103502:	8b 45 10             	mov    0x10(%ebp),%eax
80103505:	83 c4 10             	add    $0x10,%esp
80103508:	85 c0                	test   %eax,%eax
8010350a:	0f 8e c8 00 00 00    	jle    801035d8 <pipewrite+0xe8>
80103510:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103513:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103519:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010351f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103522:	03 4d 10             	add    0x10(%ebp),%ecx
80103525:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103528:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010352e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103534:	39 d0                	cmp    %edx,%eax
80103536:	75 71                	jne    801035a9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103538:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010353e:	85 c0                	test   %eax,%eax
80103540:	74 4e                	je     80103590 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103542:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103548:	eb 3a                	jmp    80103584 <pipewrite+0x94>
8010354a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103550:	83 ec 0c             	sub    $0xc,%esp
80103553:	57                   	push   %edi
80103554:	e8 f7 0a 00 00       	call   80104050 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103559:	5a                   	pop    %edx
8010355a:	59                   	pop    %ecx
8010355b:	53                   	push   %ebx
8010355c:	56                   	push   %esi
8010355d:	e8 2e 09 00 00       	call   80103e90 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103562:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103568:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010356e:	83 c4 10             	add    $0x10,%esp
80103571:	05 00 02 00 00       	add    $0x200,%eax
80103576:	39 c2                	cmp    %eax,%edx
80103578:	75 36                	jne    801035b0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010357a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103580:	85 c0                	test   %eax,%eax
80103582:	74 0c                	je     80103590 <pipewrite+0xa0>
80103584:	e8 67 03 00 00       	call   801038f0 <myproc>
80103589:	8b 40 30             	mov    0x30(%eax),%eax
8010358c:	85 c0                	test   %eax,%eax
8010358e:	74 c0                	je     80103550 <pipewrite+0x60>
        release(&p->lock);
80103590:	83 ec 0c             	sub    $0xc,%esp
80103593:	53                   	push   %ebx
80103594:	e8 17 11 00 00       	call   801046b0 <release>
        return -1;
80103599:	83 c4 10             	add    $0x10,%esp
8010359c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801035a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035a4:	5b                   	pop    %ebx
801035a5:	5e                   	pop    %esi
801035a6:	5f                   	pop    %edi
801035a7:	5d                   	pop    %ebp
801035a8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035a9:	89 c2                	mov    %eax,%edx
801035ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035af:	90                   	nop
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801035b0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801035b3:	8d 42 01             	lea    0x1(%edx),%eax
801035b6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801035bc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801035c2:	0f b6 0e             	movzbl (%esi),%ecx
801035c5:	83 c6 01             	add    $0x1,%esi
801035c8:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801035cb:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801035cf:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801035d2:	0f 85 50 ff ff ff    	jne    80103528 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801035d8:	83 ec 0c             	sub    $0xc,%esp
801035db:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801035e1:	50                   	push   %eax
801035e2:	e8 69 0a 00 00       	call   80104050 <wakeup>
  release(&p->lock);
801035e7:	89 1c 24             	mov    %ebx,(%esp)
801035ea:	e8 c1 10 00 00       	call   801046b0 <release>
  return n;
801035ef:	83 c4 10             	add    $0x10,%esp
801035f2:	8b 45 10             	mov    0x10(%ebp),%eax
801035f5:	eb aa                	jmp    801035a1 <pipewrite+0xb1>
801035f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035fe:	66 90                	xchg   %ax,%ax

80103600 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103600:	55                   	push   %ebp
80103601:	89 e5                	mov    %esp,%ebp
80103603:	57                   	push   %edi
80103604:	56                   	push   %esi
80103605:	53                   	push   %ebx
80103606:	83 ec 18             	sub    $0x18,%esp
80103609:	8b 75 08             	mov    0x8(%ebp),%esi
8010360c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010360f:	56                   	push   %esi
80103610:	e8 7b 0f 00 00       	call   80104590 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103615:	83 c4 10             	add    $0x10,%esp
80103618:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010361e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103624:	75 6a                	jne    80103690 <piperead+0x90>
80103626:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010362c:	85 db                	test   %ebx,%ebx
8010362e:	0f 84 c4 00 00 00    	je     801036f8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103634:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010363a:	eb 2d                	jmp    80103669 <piperead+0x69>
8010363c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103640:	83 ec 08             	sub    $0x8,%esp
80103643:	56                   	push   %esi
80103644:	53                   	push   %ebx
80103645:	e8 46 08 00 00       	call   80103e90 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010364a:	83 c4 10             	add    $0x10,%esp
8010364d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103653:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103659:	75 35                	jne    80103690 <piperead+0x90>
8010365b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103661:	85 d2                	test   %edx,%edx
80103663:	0f 84 8f 00 00 00    	je     801036f8 <piperead+0xf8>
    if(myproc()->killed){
80103669:	e8 82 02 00 00       	call   801038f0 <myproc>
8010366e:	8b 48 30             	mov    0x30(%eax),%ecx
80103671:	85 c9                	test   %ecx,%ecx
80103673:	74 cb                	je     80103640 <piperead+0x40>
      release(&p->lock);
80103675:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103678:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010367d:	56                   	push   %esi
8010367e:	e8 2d 10 00 00       	call   801046b0 <release>
      return -1;
80103683:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103686:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103689:	89 d8                	mov    %ebx,%eax
8010368b:	5b                   	pop    %ebx
8010368c:	5e                   	pop    %esi
8010368d:	5f                   	pop    %edi
8010368e:	5d                   	pop    %ebp
8010368f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103690:	8b 45 10             	mov    0x10(%ebp),%eax
80103693:	85 c0                	test   %eax,%eax
80103695:	7e 61                	jle    801036f8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103697:	31 db                	xor    %ebx,%ebx
80103699:	eb 13                	jmp    801036ae <piperead+0xae>
8010369b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010369f:	90                   	nop
801036a0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036a6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036ac:	74 1f                	je     801036cd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801036ae:	8d 41 01             	lea    0x1(%ecx),%eax
801036b1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801036b7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801036bd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801036c2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036c5:	83 c3 01             	add    $0x1,%ebx
801036c8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801036cb:	75 d3                	jne    801036a0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801036cd:	83 ec 0c             	sub    $0xc,%esp
801036d0:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801036d6:	50                   	push   %eax
801036d7:	e8 74 09 00 00       	call   80104050 <wakeup>
  release(&p->lock);
801036dc:	89 34 24             	mov    %esi,(%esp)
801036df:	e8 cc 0f 00 00       	call   801046b0 <release>
  return i;
801036e4:	83 c4 10             	add    $0x10,%esp
}
801036e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036ea:	89 d8                	mov    %ebx,%eax
801036ec:	5b                   	pop    %ebx
801036ed:	5e                   	pop    %esi
801036ee:	5f                   	pop    %edi
801036ef:	5d                   	pop    %ebp
801036f0:	c3                   	ret    
801036f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->nread == p->nwrite)
801036f8:	31 db                	xor    %ebx,%ebx
801036fa:	eb d1                	jmp    801036cd <piperead+0xcd>
801036fc:	66 90                	xchg   %ax,%ax
801036fe:	66 90                	xchg   %ax,%ax

80103700 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103700:	55                   	push   %ebp
80103701:	89 e5                	mov    %esp,%ebp
80103703:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103704:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
80103709:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010370c:	68 20 2d 11 80       	push   $0x80112d20
80103711:	e8 7a 0e 00 00       	call   80104590 <acquire>
80103716:	83 c4 10             	add    $0x10,%esp
80103719:	eb 17                	jmp    80103732 <allocproc+0x32>
8010371b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010371f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103720:	81 c3 88 00 00 00    	add    $0x88,%ebx
80103726:	81 fb 54 4f 11 80    	cmp    $0x80114f54,%ebx
8010372c:	0f 84 7e 00 00 00    	je     801037b0 <allocproc+0xb0>
    if(p->state == UNUSED)
80103732:	8b 43 18             	mov    0x18(%ebx),%eax
80103735:	85 c0                	test   %eax,%eax
80103737:	75 e7                	jne    80103720 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103739:	a1 04 a0 10 80       	mov    0x8010a004,%eax
  
  release(&ptable.lock);
8010373e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103741:	c7 43 18 01 00 00 00 	movl   $0x1,0x18(%ebx)
  p->pid = nextpid++;
80103748:	89 43 1c             	mov    %eax,0x1c(%ebx)
8010374b:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
8010374e:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
80103753:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103759:	e8 52 0f 00 00       	call   801046b0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010375e:	e8 4d ee ff ff       	call   801025b0 <kalloc>
80103763:	83 c4 10             	add    $0x10,%esp
80103766:	89 43 14             	mov    %eax,0x14(%ebx)
80103769:	85 c0                	test   %eax,%eax
8010376b:	74 5c                	je     801037c9 <allocproc+0xc9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010376d:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103773:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103776:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010377b:	89 53 24             	mov    %edx,0x24(%ebx)
  *(uint*)sp = (uint)trapret;
8010377e:	c7 40 14 fd 58 10 80 	movl   $0x801058fd,0x14(%eax)
  p->context = (struct context*)sp;
80103785:	89 43 28             	mov    %eax,0x28(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103788:	6a 14                	push   $0x14
8010378a:	6a 00                	push   $0x0
8010378c:	50                   	push   %eax
8010378d:	e8 6e 0f 00 00       	call   80104700 <memset>
  p->context->eip = (uint)forkret;
80103792:	8b 43 28             	mov    0x28(%ebx),%eax
  //initializing field start_ticks to global variable ticks
  p->start_ticks = ticks;

  return p;
80103795:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103798:	c7 40 10 e0 37 10 80 	movl   $0x801037e0,0x10(%eax)
  p->start_ticks = ticks;
8010379f:	a1 a0 57 11 80       	mov    0x801157a0,%eax
801037a4:	89 43 04             	mov    %eax,0x4(%ebx)
}
801037a7:	89 d8                	mov    %ebx,%eax
801037a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037ac:	c9                   	leave  
801037ad:	c3                   	ret    
801037ae:	66 90                	xchg   %ax,%ax
  release(&ptable.lock);
801037b0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801037b3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801037b5:	68 20 2d 11 80       	push   $0x80112d20
801037ba:	e8 f1 0e 00 00       	call   801046b0 <release>
}
801037bf:	89 d8                	mov    %ebx,%eax
  return 0;
801037c1:	83 c4 10             	add    $0x10,%esp
}
801037c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037c7:	c9                   	leave  
801037c8:	c3                   	ret    
    p->state = UNUSED;
801037c9:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
    return 0;
801037d0:	31 db                	xor    %ebx,%ebx
}
801037d2:	89 d8                	mov    %ebx,%eax
801037d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037d7:	c9                   	leave  
801037d8:	c3                   	ret    
801037d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801037e0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801037e6:	68 20 2d 11 80       	push   $0x80112d20
801037eb:	e8 c0 0e 00 00       	call   801046b0 <release>

  if (first) {
801037f0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801037f5:	83 c4 10             	add    $0x10,%esp
801037f8:	85 c0                	test   %eax,%eax
801037fa:	75 04                	jne    80103800 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801037fc:	c9                   	leave  
801037fd:	c3                   	ret    
801037fe:	66 90                	xchg   %ax,%ax
    first = 0;
80103800:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103807:	00 00 00 
    iinit(ROOTDEV);
8010380a:	83 ec 0c             	sub    $0xc,%esp
8010380d:	6a 01                	push   $0x1
8010380f:	e8 0c dd ff ff       	call   80101520 <iinit>
    initlog(ROOTDEV);
80103814:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010381b:	e8 e0 f3 ff ff       	call   80102c00 <initlog>
80103820:	83 c4 10             	add    $0x10,%esp
}
80103823:	c9                   	leave  
80103824:	c3                   	ret    
80103825:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010382c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103830 <pinit>:
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103836:	68 b5 76 10 80       	push   $0x801076b5
8010383b:	68 20 2d 11 80       	push   $0x80112d20
80103840:	e8 4b 0c 00 00       	call   80104490 <initlock>
}
80103845:	83 c4 10             	add    $0x10,%esp
80103848:	c9                   	leave  
80103849:	c3                   	ret    
8010384a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103850 <mycpu>:
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	56                   	push   %esi
80103854:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103855:	9c                   	pushf  
80103856:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103857:	f6 c4 02             	test   $0x2,%ah
8010385a:	75 5d                	jne    801038b9 <mycpu+0x69>
  apicid = lapicid();
8010385c:	e8 cf ef ff ff       	call   80102830 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103861:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
80103867:	85 f6                	test   %esi,%esi
80103869:	7e 41                	jle    801038ac <mycpu+0x5c>
    if (cpus[i].apicid == apicid)
8010386b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103872:	39 d0                	cmp    %edx,%eax
80103874:	74 2f                	je     801038a5 <mycpu+0x55>
  for (i = 0; i < ncpu; ++i) {
80103876:	31 d2                	xor    %edx,%edx
80103878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010387f:	90                   	nop
80103880:	83 c2 01             	add    $0x1,%edx
80103883:	39 f2                	cmp    %esi,%edx
80103885:	74 25                	je     801038ac <mycpu+0x5c>
    if (cpus[i].apicid == apicid)
80103887:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010388d:	0f b6 99 80 27 11 80 	movzbl -0x7feed880(%ecx),%ebx
80103894:	39 c3                	cmp    %eax,%ebx
80103896:	75 e8                	jne    80103880 <mycpu+0x30>
80103898:	8d 81 80 27 11 80    	lea    -0x7feed880(%ecx),%eax
}
8010389e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038a1:	5b                   	pop    %ebx
801038a2:	5e                   	pop    %esi
801038a3:	5d                   	pop    %ebp
801038a4:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801038a5:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
801038aa:	eb f2                	jmp    8010389e <mycpu+0x4e>
  panic("unknown apicid\n");
801038ac:	83 ec 0c             	sub    $0xc,%esp
801038af:	68 bc 76 10 80       	push   $0x801076bc
801038b4:	e8 d7 ca ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
801038b9:	83 ec 0c             	sub    $0xc,%esp
801038bc:	68 24 78 10 80       	push   $0x80107824
801038c1:	e8 ca ca ff ff       	call   80100390 <panic>
801038c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038cd:	8d 76 00             	lea    0x0(%esi),%esi

801038d0 <cpuid>:
cpuid() {
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801038d6:	e8 75 ff ff ff       	call   80103850 <mycpu>
}
801038db:	c9                   	leave  
  return mycpu()-cpus;
801038dc:	2d 80 27 11 80       	sub    $0x80112780,%eax
801038e1:	c1 f8 04             	sar    $0x4,%eax
801038e4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801038ea:	c3                   	ret    
801038eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038ef:	90                   	nop

801038f0 <myproc>:
myproc(void) {
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	53                   	push   %ebx
801038f4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801038f7:	e8 44 0c 00 00       	call   80104540 <pushcli>
  c = mycpu();
801038fc:	e8 4f ff ff ff       	call   80103850 <mycpu>
  p = c->proc;
80103901:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103907:	e8 44 0d 00 00       	call   80104650 <popcli>
}
8010390c:	83 c4 04             	add    $0x4,%esp
8010390f:	89 d8                	mov    %ebx,%eax
80103911:	5b                   	pop    %ebx
80103912:	5d                   	pop    %ebp
80103913:	c3                   	ret    
80103914:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010391b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010391f:	90                   	nop

80103920 <userinit>:
{
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	53                   	push   %ebx
80103924:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103927:	e8 d4 fd ff ff       	call   80103700 <allocproc>
8010392c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010392e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103933:	e8 98 35 00 00       	call   80106ed0 <setupkvm>
80103938:	89 43 10             	mov    %eax,0x10(%ebx)
8010393b:	85 c0                	test   %eax,%eax
8010393d:	0f 84 bd 00 00 00    	je     80103a00 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103943:	83 ec 04             	sub    $0x4,%esp
80103946:	68 2c 00 00 00       	push   $0x2c
8010394b:	68 60 a4 10 80       	push   $0x8010a460
80103950:	50                   	push   %eax
80103951:	e8 5a 32 00 00       	call   80106bb0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103956:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103959:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010395f:	6a 4c                	push   $0x4c
80103961:	6a 00                	push   $0x0
80103963:	ff 73 24             	pushl  0x24(%ebx)
80103966:	e8 95 0d 00 00       	call   80104700 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010396b:	8b 43 24             	mov    0x24(%ebx),%eax
8010396e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103973:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103976:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010397b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010397f:	8b 43 24             	mov    0x24(%ebx),%eax
80103982:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103986:	8b 43 24             	mov    0x24(%ebx),%eax
80103989:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010398d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103991:	8b 43 24             	mov    0x24(%ebx),%eax
80103994:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103998:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010399c:	8b 43 24             	mov    0x24(%ebx),%eax
8010399f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801039a6:	8b 43 24             	mov    0x24(%ebx),%eax
801039a9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801039b0:	8b 43 24             	mov    0x24(%ebx),%eax
801039b3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039ba:	8d 43 78             	lea    0x78(%ebx),%eax
801039bd:	6a 10                	push   $0x10
801039bf:	68 e5 76 10 80       	push   $0x801076e5
801039c4:	50                   	push   %eax
801039c5:	e8 06 0f 00 00       	call   801048d0 <safestrcpy>
  p->cwd = namei("/");
801039ca:	c7 04 24 ee 76 10 80 	movl   $0x801076ee,(%esp)
801039d1:	e8 ea e5 ff ff       	call   80101fc0 <namei>
801039d6:	89 43 74             	mov    %eax,0x74(%ebx)
  acquire(&ptable.lock);
801039d9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039e0:	e8 ab 0b 00 00       	call   80104590 <acquire>
  p->state = RUNNABLE;
801039e5:	c7 43 18 03 00 00 00 	movl   $0x3,0x18(%ebx)
  release(&ptable.lock);
801039ec:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039f3:	e8 b8 0c 00 00       	call   801046b0 <release>
}
801039f8:	83 c4 10             	add    $0x10,%esp
801039fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039fe:	c9                   	leave  
801039ff:	c3                   	ret    
    panic("userinit: out of memory?");
80103a00:	83 ec 0c             	sub    $0xc,%esp
80103a03:	68 cc 76 10 80       	push   $0x801076cc
80103a08:	e8 83 c9 ff ff       	call   80100390 <panic>
80103a0d:	8d 76 00             	lea    0x0(%esi),%esi

80103a10 <growproc>:
{
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	56                   	push   %esi
80103a14:	53                   	push   %ebx
80103a15:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103a18:	e8 23 0b 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103a1d:	e8 2e fe ff ff       	call   80103850 <mycpu>
  p = c->proc;
80103a22:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a28:	e8 23 0c 00 00       	call   80104650 <popcli>
  sz = curproc->sz;
80103a2d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a2f:	85 f6                	test   %esi,%esi
80103a31:	7f 1d                	jg     80103a50 <growproc+0x40>
  } else if(n < 0){
80103a33:	75 3b                	jne    80103a70 <growproc+0x60>
  switchuvm(curproc);
80103a35:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103a38:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a3a:	53                   	push   %ebx
80103a3b:	e8 60 30 00 00       	call   80106aa0 <switchuvm>
  return 0;
80103a40:	83 c4 10             	add    $0x10,%esp
80103a43:	31 c0                	xor    %eax,%eax
}
80103a45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a48:	5b                   	pop    %ebx
80103a49:	5e                   	pop    %esi
80103a4a:	5d                   	pop    %ebp
80103a4b:	c3                   	ret    
80103a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a50:	83 ec 04             	sub    $0x4,%esp
80103a53:	01 c6                	add    %eax,%esi
80103a55:	56                   	push   %esi
80103a56:	50                   	push   %eax
80103a57:	ff 73 10             	pushl  0x10(%ebx)
80103a5a:	e8 91 32 00 00       	call   80106cf0 <allocuvm>
80103a5f:	83 c4 10             	add    $0x10,%esp
80103a62:	85 c0                	test   %eax,%eax
80103a64:	75 cf                	jne    80103a35 <growproc+0x25>
      return -1;
80103a66:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a6b:	eb d8                	jmp    80103a45 <growproc+0x35>
80103a6d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a70:	83 ec 04             	sub    $0x4,%esp
80103a73:	01 c6                	add    %eax,%esi
80103a75:	56                   	push   %esi
80103a76:	50                   	push   %eax
80103a77:	ff 73 10             	pushl  0x10(%ebx)
80103a7a:	e8 a1 33 00 00       	call   80106e20 <deallocuvm>
80103a7f:	83 c4 10             	add    $0x10,%esp
80103a82:	85 c0                	test   %eax,%eax
80103a84:	75 af                	jne    80103a35 <growproc+0x25>
80103a86:	eb de                	jmp    80103a66 <growproc+0x56>
80103a88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a8f:	90                   	nop

80103a90 <fork>:
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	57                   	push   %edi
80103a94:	56                   	push   %esi
80103a95:	53                   	push   %ebx
80103a96:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103a99:	e8 a2 0a 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103a9e:	e8 ad fd ff ff       	call   80103850 <mycpu>
  p = c->proc;
80103aa3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103aa9:	e8 a2 0b 00 00       	call   80104650 <popcli>
  if((np = allocproc()) == 0){
80103aae:	e8 4d fc ff ff       	call   80103700 <allocproc>
80103ab3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103ab6:	85 c0                	test   %eax,%eax
80103ab8:	0f 84 b7 00 00 00    	je     80103b75 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103abe:	83 ec 08             	sub    $0x8,%esp
80103ac1:	ff 33                	pushl  (%ebx)
80103ac3:	89 c7                	mov    %eax,%edi
80103ac5:	ff 73 10             	pushl  0x10(%ebx)
80103ac8:	e8 d3 34 00 00       	call   80106fa0 <copyuvm>
80103acd:	83 c4 10             	add    $0x10,%esp
80103ad0:	89 47 10             	mov    %eax,0x10(%edi)
80103ad3:	85 c0                	test   %eax,%eax
80103ad5:	0f 84 a1 00 00 00    	je     80103b7c <fork+0xec>
  np->sz = curproc->sz;
80103adb:	8b 03                	mov    (%ebx),%eax
80103add:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103ae0:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103ae2:	8b 79 24             	mov    0x24(%ecx),%edi
  np->parent = curproc;
80103ae5:	89 c8                	mov    %ecx,%eax
80103ae7:	89 59 20             	mov    %ebx,0x20(%ecx)
  *np->tf = *curproc->tf;
80103aea:	b9 13 00 00 00       	mov    $0x13,%ecx
80103aef:	8b 73 24             	mov    0x24(%ebx),%esi
80103af2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103af4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103af6:	8b 40 24             	mov    0x24(%eax),%eax
80103af9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103b00:	8b 44 b3 34          	mov    0x34(%ebx,%esi,4),%eax
80103b04:	85 c0                	test   %eax,%eax
80103b06:	74 13                	je     80103b1b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b08:	83 ec 0c             	sub    $0xc,%esp
80103b0b:	50                   	push   %eax
80103b0c:	e8 5f d3 ff ff       	call   80100e70 <filedup>
80103b11:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b14:	83 c4 10             	add    $0x10,%esp
80103b17:	89 44 b2 34          	mov    %eax,0x34(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103b1b:	83 c6 01             	add    $0x1,%esi
80103b1e:	83 fe 10             	cmp    $0x10,%esi
80103b21:	75 dd                	jne    80103b00 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103b23:	83 ec 0c             	sub    $0xc,%esp
80103b26:	ff 73 74             	pushl  0x74(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b29:	83 c3 78             	add    $0x78,%ebx
  np->cwd = idup(curproc->cwd);
80103b2c:	e8 bf db ff ff       	call   801016f0 <idup>
80103b31:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b34:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103b37:	89 47 74             	mov    %eax,0x74(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b3a:	8d 47 78             	lea    0x78(%edi),%eax
80103b3d:	6a 10                	push   $0x10
80103b3f:	53                   	push   %ebx
80103b40:	50                   	push   %eax
80103b41:	e8 8a 0d 00 00       	call   801048d0 <safestrcpy>
  pid = np->pid;
80103b46:	8b 5f 1c             	mov    0x1c(%edi),%ebx
  acquire(&ptable.lock);
80103b49:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b50:	e8 3b 0a 00 00       	call   80104590 <acquire>
  np->state = RUNNABLE;
80103b55:	c7 47 18 03 00 00 00 	movl   $0x3,0x18(%edi)
  release(&ptable.lock);
80103b5c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b63:	e8 48 0b 00 00       	call   801046b0 <release>
  return pid;
80103b68:	83 c4 10             	add    $0x10,%esp
}
80103b6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b6e:	89 d8                	mov    %ebx,%eax
80103b70:	5b                   	pop    %ebx
80103b71:	5e                   	pop    %esi
80103b72:	5f                   	pop    %edi
80103b73:	5d                   	pop    %ebp
80103b74:	c3                   	ret    
    return -1;
80103b75:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b7a:	eb ef                	jmp    80103b6b <fork+0xdb>
    kfree(np->kstack);
80103b7c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103b7f:	83 ec 0c             	sub    $0xc,%esp
80103b82:	ff 73 14             	pushl  0x14(%ebx)
80103b85:	e8 66 e8 ff ff       	call   801023f0 <kfree>
    np->kstack = 0;
80103b8a:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
    return -1;
80103b91:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103b94:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
    return -1;
80103b9b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103ba0:	eb c9                	jmp    80103b6b <fork+0xdb>
80103ba2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103bb0 <scheduler>:
{
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	57                   	push   %edi
80103bb4:	56                   	push   %esi
80103bb5:	53                   	push   %ebx
80103bb6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103bb9:	e8 92 fc ff ff       	call   80103850 <mycpu>
  c->proc = 0;
80103bbe:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103bc5:	00 00 00 
  struct cpu *c = mycpu();
80103bc8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103bca:	8d 78 04             	lea    0x4(%eax),%edi
80103bcd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103bd0:	fb                   	sti    
    acquire(&ptable.lock);
80103bd1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bd4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103bd9:	68 20 2d 11 80       	push   $0x80112d20
80103bde:	e8 ad 09 00 00       	call   80104590 <acquire>
80103be3:	83 c4 10             	add    $0x10,%esp
80103be6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bed:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103bf0:	83 7b 18 03          	cmpl   $0x3,0x18(%ebx)
80103bf4:	75 33                	jne    80103c29 <scheduler+0x79>
      switchuvm(p);
80103bf6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103bf9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103bff:	53                   	push   %ebx
80103c00:	e8 9b 2e 00 00       	call   80106aa0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103c05:	58                   	pop    %eax
80103c06:	5a                   	pop    %edx
80103c07:	ff 73 28             	pushl  0x28(%ebx)
80103c0a:	57                   	push   %edi
      p->state = RUNNING;
80103c0b:	c7 43 18 04 00 00 00 	movl   $0x4,0x18(%ebx)
      swtch(&(c->scheduler), p->context);
80103c12:	e8 14 0d 00 00       	call   8010492b <swtch>
      switchkvm();
80103c17:	e8 74 2e 00 00       	call   80106a90 <switchkvm>
      c->proc = 0;
80103c1c:	83 c4 10             	add    $0x10,%esp
80103c1f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103c26:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c29:	81 c3 88 00 00 00    	add    $0x88,%ebx
80103c2f:	81 fb 54 4f 11 80    	cmp    $0x80114f54,%ebx
80103c35:	75 b9                	jne    80103bf0 <scheduler+0x40>
    release(&ptable.lock);
80103c37:	83 ec 0c             	sub    $0xc,%esp
80103c3a:	68 20 2d 11 80       	push   $0x80112d20
80103c3f:	e8 6c 0a 00 00       	call   801046b0 <release>
    sti();
80103c44:	83 c4 10             	add    $0x10,%esp
80103c47:	eb 87                	jmp    80103bd0 <scheduler+0x20>
80103c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c50 <sched>:
{
80103c50:	55                   	push   %ebp
80103c51:	89 e5                	mov    %esp,%ebp
80103c53:	56                   	push   %esi
80103c54:	53                   	push   %ebx
  pushcli();
80103c55:	e8 e6 08 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103c5a:	e8 f1 fb ff ff       	call   80103850 <mycpu>
  p = c->proc;
80103c5f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c65:	e8 e6 09 00 00       	call   80104650 <popcli>
  if(!holding(&ptable.lock))
80103c6a:	83 ec 0c             	sub    $0xc,%esp
80103c6d:	68 20 2d 11 80       	push   $0x80112d20
80103c72:	e8 89 08 00 00       	call   80104500 <holding>
80103c77:	83 c4 10             	add    $0x10,%esp
80103c7a:	85 c0                	test   %eax,%eax
80103c7c:	74 4f                	je     80103ccd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103c7e:	e8 cd fb ff ff       	call   80103850 <mycpu>
80103c83:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c8a:	75 68                	jne    80103cf4 <sched+0xa4>
  if(p->state == RUNNING)
80103c8c:	83 7b 18 04          	cmpl   $0x4,0x18(%ebx)
80103c90:	74 55                	je     80103ce7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c92:	9c                   	pushf  
80103c93:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c94:	f6 c4 02             	test   $0x2,%ah
80103c97:	75 41                	jne    80103cda <sched+0x8a>
  intena = mycpu()->intena;
80103c99:	e8 b2 fb ff ff       	call   80103850 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c9e:	83 c3 28             	add    $0x28,%ebx
  intena = mycpu()->intena;
80103ca1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103ca7:	e8 a4 fb ff ff       	call   80103850 <mycpu>
80103cac:	83 ec 08             	sub    $0x8,%esp
80103caf:	ff 70 04             	pushl  0x4(%eax)
80103cb2:	53                   	push   %ebx
80103cb3:	e8 73 0c 00 00       	call   8010492b <swtch>
  mycpu()->intena = intena;
80103cb8:	e8 93 fb ff ff       	call   80103850 <mycpu>
}
80103cbd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103cc0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103cc6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103cc9:	5b                   	pop    %ebx
80103cca:	5e                   	pop    %esi
80103ccb:	5d                   	pop    %ebp
80103ccc:	c3                   	ret    
    panic("sched ptable.lock");
80103ccd:	83 ec 0c             	sub    $0xc,%esp
80103cd0:	68 f0 76 10 80       	push   $0x801076f0
80103cd5:	e8 b6 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103cda:	83 ec 0c             	sub    $0xc,%esp
80103cdd:	68 1c 77 10 80       	push   $0x8010771c
80103ce2:	e8 a9 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103ce7:	83 ec 0c             	sub    $0xc,%esp
80103cea:	68 0e 77 10 80       	push   $0x8010770e
80103cef:	e8 9c c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103cf4:	83 ec 0c             	sub    $0xc,%esp
80103cf7:	68 02 77 10 80       	push   $0x80107702
80103cfc:	e8 8f c6 ff ff       	call   80100390 <panic>
80103d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d0f:	90                   	nop

80103d10 <exit>:
{
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	57                   	push   %edi
80103d14:	56                   	push   %esi
80103d15:	53                   	push   %ebx
80103d16:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103d19:	e8 22 08 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103d1e:	e8 2d fb ff ff       	call   80103850 <mycpu>
  p = c->proc;
80103d23:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d29:	e8 22 09 00 00       	call   80104650 <popcli>
  if(curproc == initproc)
80103d2e:	8d 5e 34             	lea    0x34(%esi),%ebx
80103d31:	8d 7e 74             	lea    0x74(%esi),%edi
80103d34:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103d3a:	0f 84 f1 00 00 00    	je     80103e31 <exit+0x121>
    if(curproc->ofile[fd]){
80103d40:	8b 03                	mov    (%ebx),%eax
80103d42:	85 c0                	test   %eax,%eax
80103d44:	74 12                	je     80103d58 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103d46:	83 ec 0c             	sub    $0xc,%esp
80103d49:	50                   	push   %eax
80103d4a:	e8 71 d1 ff ff       	call   80100ec0 <fileclose>
      curproc->ofile[fd] = 0;
80103d4f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d55:	83 c4 10             	add    $0x10,%esp
80103d58:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103d5b:	39 fb                	cmp    %edi,%ebx
80103d5d:	75 e1                	jne    80103d40 <exit+0x30>
  begin_op();
80103d5f:	e8 3c ef ff ff       	call   80102ca0 <begin_op>
  iput(curproc->cwd);
80103d64:	83 ec 0c             	sub    $0xc,%esp
80103d67:	ff 76 74             	pushl  0x74(%esi)
80103d6a:	e8 e1 da ff ff       	call   80101850 <iput>
  end_op();
80103d6f:	e8 9c ef ff ff       	call   80102d10 <end_op>
  curproc->cwd = 0;
80103d74:	c7 46 74 00 00 00 00 	movl   $0x0,0x74(%esi)
  acquire(&ptable.lock);
80103d7b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d82:	e8 09 08 00 00       	call   80104590 <acquire>
  wakeup1(curproc->parent);
80103d87:	8b 56 20             	mov    0x20(%esi),%edx
80103d8a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d8d:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d92:	eb 10                	jmp    80103da4 <exit+0x94>
80103d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d98:	05 88 00 00 00       	add    $0x88,%eax
80103d9d:	3d 54 4f 11 80       	cmp    $0x80114f54,%eax
80103da2:	74 1e                	je     80103dc2 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80103da4:	83 78 18 02          	cmpl   $0x2,0x18(%eax)
80103da8:	75 ee                	jne    80103d98 <exit+0x88>
80103daa:	3b 50 2c             	cmp    0x2c(%eax),%edx
80103dad:	75 e9                	jne    80103d98 <exit+0x88>
      p->state = RUNNABLE;
80103daf:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103db6:	05 88 00 00 00       	add    $0x88,%eax
80103dbb:	3d 54 4f 11 80       	cmp    $0x80114f54,%eax
80103dc0:	75 e2                	jne    80103da4 <exit+0x94>
      p->parent = initproc;
80103dc2:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dc8:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103dcd:	eb 0f                	jmp    80103dde <exit+0xce>
80103dcf:	90                   	nop
80103dd0:	81 c2 88 00 00 00    	add    $0x88,%edx
80103dd6:	81 fa 54 4f 11 80    	cmp    $0x80114f54,%edx
80103ddc:	74 3a                	je     80103e18 <exit+0x108>
    if(p->parent == curproc){
80103dde:	39 72 20             	cmp    %esi,0x20(%edx)
80103de1:	75 ed                	jne    80103dd0 <exit+0xc0>
      if(p->state == ZOMBIE)
80103de3:	83 7a 18 05          	cmpl   $0x5,0x18(%edx)
      p->parent = initproc;
80103de7:	89 4a 20             	mov    %ecx,0x20(%edx)
      if(p->state == ZOMBIE)
80103dea:	75 e4                	jne    80103dd0 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dec:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103df1:	eb 11                	jmp    80103e04 <exit+0xf4>
80103df3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103df7:	90                   	nop
80103df8:	05 88 00 00 00       	add    $0x88,%eax
80103dfd:	3d 54 4f 11 80       	cmp    $0x80114f54,%eax
80103e02:	74 cc                	je     80103dd0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103e04:	83 78 18 02          	cmpl   $0x2,0x18(%eax)
80103e08:	75 ee                	jne    80103df8 <exit+0xe8>
80103e0a:	3b 48 2c             	cmp    0x2c(%eax),%ecx
80103e0d:	75 e9                	jne    80103df8 <exit+0xe8>
      p->state = RUNNABLE;
80103e0f:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%eax)
80103e16:	eb e0                	jmp    80103df8 <exit+0xe8>
  curproc->state = ZOMBIE;
80103e18:	c7 46 18 05 00 00 00 	movl   $0x5,0x18(%esi)
  sched();
80103e1f:	e8 2c fe ff ff       	call   80103c50 <sched>
  panic("zombie exit");
80103e24:	83 ec 0c             	sub    $0xc,%esp
80103e27:	68 3d 77 10 80       	push   $0x8010773d
80103e2c:	e8 5f c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103e31:	83 ec 0c             	sub    $0xc,%esp
80103e34:	68 30 77 10 80       	push   $0x80107730
80103e39:	e8 52 c5 ff ff       	call   80100390 <panic>
80103e3e:	66 90                	xchg   %ax,%ax

80103e40 <yield>:
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	53                   	push   %ebx
80103e44:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e47:	68 20 2d 11 80       	push   $0x80112d20
80103e4c:	e8 3f 07 00 00       	call   80104590 <acquire>
  pushcli();
80103e51:	e8 ea 06 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103e56:	e8 f5 f9 ff ff       	call   80103850 <mycpu>
  p = c->proc;
80103e5b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e61:	e8 ea 07 00 00       	call   80104650 <popcli>
  myproc()->state = RUNNABLE;
80103e66:	c7 43 18 03 00 00 00 	movl   $0x3,0x18(%ebx)
  sched();
80103e6d:	e8 de fd ff ff       	call   80103c50 <sched>
  release(&ptable.lock);
80103e72:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e79:	e8 32 08 00 00       	call   801046b0 <release>
}
80103e7e:	83 c4 10             	add    $0x10,%esp
80103e81:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e84:	c9                   	leave  
80103e85:	c3                   	ret    
80103e86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e8d:	8d 76 00             	lea    0x0(%esi),%esi

80103e90 <sleep>:
{
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	57                   	push   %edi
80103e94:	56                   	push   %esi
80103e95:	53                   	push   %ebx
80103e96:	83 ec 0c             	sub    $0xc,%esp
80103e99:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e9c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103e9f:	e8 9c 06 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103ea4:	e8 a7 f9 ff ff       	call   80103850 <mycpu>
  p = c->proc;
80103ea9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103eaf:	e8 9c 07 00 00       	call   80104650 <popcli>
  if(p == 0)
80103eb4:	85 db                	test   %ebx,%ebx
80103eb6:	0f 84 87 00 00 00    	je     80103f43 <sleep+0xb3>
  if(lk == 0)
80103ebc:	85 f6                	test   %esi,%esi
80103ebe:	74 76                	je     80103f36 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103ec0:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103ec6:	74 50                	je     80103f18 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103ec8:	83 ec 0c             	sub    $0xc,%esp
80103ecb:	68 20 2d 11 80       	push   $0x80112d20
80103ed0:	e8 bb 06 00 00       	call   80104590 <acquire>
    release(lk);
80103ed5:	89 34 24             	mov    %esi,(%esp)
80103ed8:	e8 d3 07 00 00       	call   801046b0 <release>
  p->chan = chan;
80103edd:	89 7b 2c             	mov    %edi,0x2c(%ebx)
  p->state = SLEEPING;
80103ee0:	c7 43 18 02 00 00 00 	movl   $0x2,0x18(%ebx)
  sched();
80103ee7:	e8 64 fd ff ff       	call   80103c50 <sched>
  p->chan = 0;
80103eec:	c7 43 2c 00 00 00 00 	movl   $0x0,0x2c(%ebx)
    release(&ptable.lock);
80103ef3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103efa:	e8 b1 07 00 00       	call   801046b0 <release>
    acquire(lk);
80103eff:	89 75 08             	mov    %esi,0x8(%ebp)
80103f02:	83 c4 10             	add    $0x10,%esp
}
80103f05:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f08:	5b                   	pop    %ebx
80103f09:	5e                   	pop    %esi
80103f0a:	5f                   	pop    %edi
80103f0b:	5d                   	pop    %ebp
    acquire(lk);
80103f0c:	e9 7f 06 00 00       	jmp    80104590 <acquire>
80103f11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103f18:	89 7b 2c             	mov    %edi,0x2c(%ebx)
  p->state = SLEEPING;
80103f1b:	c7 43 18 02 00 00 00 	movl   $0x2,0x18(%ebx)
  sched();
80103f22:	e8 29 fd ff ff       	call   80103c50 <sched>
  p->chan = 0;
80103f27:	c7 43 2c 00 00 00 00 	movl   $0x0,0x2c(%ebx)
}
80103f2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f31:	5b                   	pop    %ebx
80103f32:	5e                   	pop    %esi
80103f33:	5f                   	pop    %edi
80103f34:	5d                   	pop    %ebp
80103f35:	c3                   	ret    
    panic("sleep without lk");
80103f36:	83 ec 0c             	sub    $0xc,%esp
80103f39:	68 4f 77 10 80       	push   $0x8010774f
80103f3e:	e8 4d c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103f43:	83 ec 0c             	sub    $0xc,%esp
80103f46:	68 49 77 10 80       	push   $0x80107749
80103f4b:	e8 40 c4 ff ff       	call   80100390 <panic>

80103f50 <wait>:
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	56                   	push   %esi
80103f54:	53                   	push   %ebx
  pushcli();
80103f55:	e8 e6 05 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103f5a:	e8 f1 f8 ff ff       	call   80103850 <mycpu>
  p = c->proc;
80103f5f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f65:	e8 e6 06 00 00       	call   80104650 <popcli>
  acquire(&ptable.lock);
80103f6a:	83 ec 0c             	sub    $0xc,%esp
80103f6d:	68 20 2d 11 80       	push   $0x80112d20
80103f72:	e8 19 06 00 00       	call   80104590 <acquire>
80103f77:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f7a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f7c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103f81:	eb 13                	jmp    80103f96 <wait+0x46>
80103f83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f87:	90                   	nop
80103f88:	81 c3 88 00 00 00    	add    $0x88,%ebx
80103f8e:	81 fb 54 4f 11 80    	cmp    $0x80114f54,%ebx
80103f94:	74 1e                	je     80103fb4 <wait+0x64>
      if(p->parent != curproc)
80103f96:	39 73 20             	cmp    %esi,0x20(%ebx)
80103f99:	75 ed                	jne    80103f88 <wait+0x38>
      if(p->state == ZOMBIE){
80103f9b:	83 7b 18 05          	cmpl   $0x5,0x18(%ebx)
80103f9f:	74 37                	je     80103fd8 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fa1:	81 c3 88 00 00 00    	add    $0x88,%ebx
      havekids = 1;
80103fa7:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fac:	81 fb 54 4f 11 80    	cmp    $0x80114f54,%ebx
80103fb2:	75 e2                	jne    80103f96 <wait+0x46>
    if(!havekids || curproc->killed){
80103fb4:	85 c0                	test   %eax,%eax
80103fb6:	74 76                	je     8010402e <wait+0xde>
80103fb8:	8b 46 30             	mov    0x30(%esi),%eax
80103fbb:	85 c0                	test   %eax,%eax
80103fbd:	75 6f                	jne    8010402e <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103fbf:	83 ec 08             	sub    $0x8,%esp
80103fc2:	68 20 2d 11 80       	push   $0x80112d20
80103fc7:	56                   	push   %esi
80103fc8:	e8 c3 fe ff ff       	call   80103e90 <sleep>
    havekids = 0;
80103fcd:	83 c4 10             	add    $0x10,%esp
80103fd0:	eb a8                	jmp    80103f7a <wait+0x2a>
80103fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80103fd8:	83 ec 0c             	sub    $0xc,%esp
80103fdb:	ff 73 14             	pushl  0x14(%ebx)
        pid = p->pid;
80103fde:	8b 73 1c             	mov    0x1c(%ebx),%esi
        kfree(p->kstack);
80103fe1:	e8 0a e4 ff ff       	call   801023f0 <kfree>
        freevm(p->pgdir);
80103fe6:	5a                   	pop    %edx
80103fe7:	ff 73 10             	pushl  0x10(%ebx)
        p->kstack = 0;
80103fea:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        freevm(p->pgdir);
80103ff1:	e8 5a 2e 00 00       	call   80106e50 <freevm>
        release(&ptable.lock);
80103ff6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p->pid = 0;
80103ffd:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
        p->parent = 0;
80104004:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
        p->name[0] = 0;
8010400b:	c6 43 78 00          	movb   $0x0,0x78(%ebx)
        p->killed = 0;
8010400f:	c7 43 30 00 00 00 00 	movl   $0x0,0x30(%ebx)
        p->state = UNUSED;
80104016:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
        release(&ptable.lock);
8010401d:	e8 8e 06 00 00       	call   801046b0 <release>
        return pid;
80104022:	83 c4 10             	add    $0x10,%esp
}
80104025:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104028:	89 f0                	mov    %esi,%eax
8010402a:	5b                   	pop    %ebx
8010402b:	5e                   	pop    %esi
8010402c:	5d                   	pop    %ebp
8010402d:	c3                   	ret    
      release(&ptable.lock);
8010402e:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104031:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104036:	68 20 2d 11 80       	push   $0x80112d20
8010403b:	e8 70 06 00 00       	call   801046b0 <release>
      return -1;
80104040:	83 c4 10             	add    $0x10,%esp
80104043:	eb e0                	jmp    80104025 <wait+0xd5>
80104045:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010404c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104050 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	53                   	push   %ebx
80104054:	83 ec 10             	sub    $0x10,%esp
80104057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010405a:	68 20 2d 11 80       	push   $0x80112d20
8010405f:	e8 2c 05 00 00       	call   80104590 <acquire>
80104064:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104067:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010406c:	eb 0e                	jmp    8010407c <wakeup+0x2c>
8010406e:	66 90                	xchg   %ax,%ax
80104070:	05 88 00 00 00       	add    $0x88,%eax
80104075:	3d 54 4f 11 80       	cmp    $0x80114f54,%eax
8010407a:	74 1e                	je     8010409a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010407c:	83 78 18 02          	cmpl   $0x2,0x18(%eax)
80104080:	75 ee                	jne    80104070 <wakeup+0x20>
80104082:	3b 58 2c             	cmp    0x2c(%eax),%ebx
80104085:	75 e9                	jne    80104070 <wakeup+0x20>
      p->state = RUNNABLE;
80104087:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010408e:	05 88 00 00 00       	add    $0x88,%eax
80104093:	3d 54 4f 11 80       	cmp    $0x80114f54,%eax
80104098:	75 e2                	jne    8010407c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010409a:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
801040a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040a4:	c9                   	leave  
  release(&ptable.lock);
801040a5:	e9 06 06 00 00       	jmp    801046b0 <release>
801040aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040b0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801040b0:	55                   	push   %ebp
801040b1:	89 e5                	mov    %esp,%ebp
801040b3:	53                   	push   %ebx
801040b4:	83 ec 10             	sub    $0x10,%esp
801040b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801040ba:	68 20 2d 11 80       	push   $0x80112d20
801040bf:	e8 cc 04 00 00       	call   80104590 <acquire>
801040c4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040c7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801040cc:	eb 0e                	jmp    801040dc <kill+0x2c>
801040ce:	66 90                	xchg   %ax,%ax
801040d0:	05 88 00 00 00       	add    $0x88,%eax
801040d5:	3d 54 4f 11 80       	cmp    $0x80114f54,%eax
801040da:	74 34                	je     80104110 <kill+0x60>
    if(p->pid == pid){
801040dc:	39 58 1c             	cmp    %ebx,0x1c(%eax)
801040df:	75 ef                	jne    801040d0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801040e1:	83 78 18 02          	cmpl   $0x2,0x18(%eax)
      p->killed = 1;
801040e5:	c7 40 30 01 00 00 00 	movl   $0x1,0x30(%eax)
      if(p->state == SLEEPING)
801040ec:	75 07                	jne    801040f5 <kill+0x45>
        p->state = RUNNABLE;
801040ee:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%eax)
      release(&ptable.lock);
801040f5:	83 ec 0c             	sub    $0xc,%esp
801040f8:	68 20 2d 11 80       	push   $0x80112d20
801040fd:	e8 ae 05 00 00       	call   801046b0 <release>
      return 0;
80104102:	83 c4 10             	add    $0x10,%esp
80104105:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104107:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010410a:	c9                   	leave  
8010410b:	c3                   	ret    
8010410c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104110:	83 ec 0c             	sub    $0xc,%esp
80104113:	68 20 2d 11 80       	push   $0x80112d20
80104118:	e8 93 05 00 00       	call   801046b0 <release>
  return -1;
8010411d:	83 c4 10             	add    $0x10,%esp
80104120:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104125:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104128:	c9                   	leave  
80104129:	c3                   	ret    
8010412a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104130 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	57                   	push   %edi
80104134:	56                   	push   %esi
80104135:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104138:	53                   	push   %ebx
80104139:	bb cc 2d 11 80       	mov    $0x80112dcc,%ebx
8010413e:	83 ec 48             	sub    $0x48,%esp
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  cprintf("pid \t name \t size \t state \t PCs\n");
80104141:	68 4c 78 10 80       	push   $0x8010784c
80104146:	e8 65 c5 ff ff       	call   801006b0 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010414b:	83 c4 10             	add    $0x10,%esp
8010414e:	eb 22                	jmp    80104172 <procdump+0x42>
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf("  %p", pc[i]);
    }
    cprintf("\n");
80104150:	83 ec 0c             	sub    $0xc,%esp
80104153:	68 e3 7b 10 80       	push   $0x80107be3
80104158:	e8 53 c5 ff ff       	call   801006b0 <cprintf>
8010415d:	83 c4 10             	add    $0x10,%esp
80104160:	81 c3 88 00 00 00    	add    $0x88,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104166:	81 fb cc 4f 11 80    	cmp    $0x80114fcc,%ebx
8010416c:	0f 84 8e 00 00 00    	je     80104200 <procdump+0xd0>
    if(p->state == UNUSED)
80104172:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104175:	85 c0                	test   %eax,%eax
80104177:	74 e7                	je     80104160 <procdump+0x30>
      state = "???";
80104179:	ba 60 77 10 80       	mov    $0x80107760,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010417e:	83 f8 05             	cmp    $0x5,%eax
80104181:	77 11                	ja     80104194 <procdump+0x64>
80104183:	8b 14 85 cc 78 10 80 	mov    -0x7fef8734(,%eax,4),%edx
      state = "???";
8010418a:	b8 60 77 10 80       	mov    $0x80107760,%eax
8010418f:	85 d2                	test   %edx,%edx
80104191:	0f 44 d0             	cmove  %eax,%edx
    cprintf("  %d \t %s \t %d \t %s", p->pid, p->name, p->sz, state);
80104194:	83 ec 0c             	sub    $0xc,%esp
80104197:	52                   	push   %edx
80104198:	ff 73 88             	pushl  -0x78(%ebx)
8010419b:	53                   	push   %ebx
8010419c:	ff 73 a4             	pushl  -0x5c(%ebx)
8010419f:	68 64 77 10 80       	push   $0x80107764
801041a4:	e8 07 c5 ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
801041a9:	83 c4 20             	add    $0x20,%esp
801041ac:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801041b0:	75 9e                	jne    80104150 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801041b2:	83 ec 08             	sub    $0x8,%esp
801041b5:	8d 45 c0             	lea    -0x40(%ebp),%eax
801041b8:	8d 7d c0             	lea    -0x40(%ebp),%edi
801041bb:	50                   	push   %eax
801041bc:	8b 43 b0             	mov    -0x50(%ebx),%eax
801041bf:	8b 40 0c             	mov    0xc(%eax),%eax
801041c2:	83 c0 08             	add    $0x8,%eax
801041c5:	50                   	push   %eax
801041c6:	e8 e5 02 00 00       	call   801044b0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801041cb:	83 c4 10             	add    $0x10,%esp
801041ce:	66 90                	xchg   %ax,%ax
801041d0:	8b 17                	mov    (%edi),%edx
801041d2:	85 d2                	test   %edx,%edx
801041d4:	0f 84 76 ff ff ff    	je     80104150 <procdump+0x20>
        cprintf("  %p", pc[i]);
801041da:	83 ec 08             	sub    $0x8,%esp
801041dd:	83 c7 04             	add    $0x4,%edi
801041e0:	52                   	push   %edx
801041e1:	68 78 77 10 80       	push   $0x80107778
801041e6:	e8 c5 c4 ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801041eb:	83 c4 10             	add    $0x10,%esp
801041ee:	39 fe                	cmp    %edi,%esi
801041f0:	75 de                	jne    801041d0 <procdump+0xa0>
801041f2:	e9 59 ff ff ff       	jmp    80104150 <procdump+0x20>
801041f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041fe:	66 90                	xchg   %ax,%ax
  }
}
80104200:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104203:	5b                   	pop    %ebx
80104204:	5e                   	pop    %esi
80104205:	5f                   	pop    %edi
80104206:	5d                   	pop    %ebp
80104207:	c3                   	ret    
80104208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010420f:	90                   	nop

80104210 <cps>:
//current process status
int
cps()
{
80104210:	55                   	push   %ebp
80104211:	89 e5                	mov    %esp,%ebp
80104213:	53                   	push   %ebx
80104214:	83 ec 10             	sub    $0x10,%esp
  asm volatile("sti");
80104217:	fb                   	sti    
  
  // Enable interrupts on this processor.
  sti();

  // Loop over process table looking for process with pid.
  acquire(&ptable.lock);
80104218:	68 20 2d 11 80       	push   $0x80112d20
  cprintf("pid \t name \t size \t state\n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010421d:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  acquire(&ptable.lock);
80104222:	e8 69 03 00 00       	call   80104590 <acquire>
  cprintf("pid \t name \t size \t state\n");
80104227:	c7 04 24 7d 77 10 80 	movl   $0x8010777d,(%esp)
8010422e:	e8 7d c4 ff ff       	call   801006b0 <cprintf>
80104233:	83 c4 10             	add    $0x10,%esp
80104236:	eb 29                	jmp    80104261 <cps+0x51>
80104238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010423f:	90                   	nop
  {
      if(p->state == SLEEPING)
        cprintf("%d \t %s \t %d \t SLEEPING\n", p->pid, p->name, p->sz);
      else if(p->state == RUNNING)
80104240:	83 f8 04             	cmp    $0x4,%eax
80104243:	74 63                	je     801042a8 <cps+0x98>
         cprintf("%d \t %s \t %d \t RUNNING\n", p->pid, p->name, p->sz);
      else if(p->state == RUNNABLE)
80104245:	83 f8 03             	cmp    $0x3,%eax
80104248:	74 76                	je     801042c0 <cps+0xb0>
        cprintf("%d \t %s \t %d \t RUNNABLE\n", p->pid, p->name, p->sz);
      else if(p->state == ZOMBIE)
8010424a:	83 f8 05             	cmp    $0x5,%eax
8010424d:	0f 84 8d 00 00 00    	je     801042e0 <cps+0xd0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104253:	81 c3 88 00 00 00    	add    $0x88,%ebx
80104259:	81 fb 54 4f 11 80    	cmp    $0x80114f54,%ebx
8010425f:	74 2c                	je     8010428d <cps+0x7d>
      if(p->state == SLEEPING)
80104261:	8b 43 18             	mov    0x18(%ebx),%eax
80104264:	83 f8 02             	cmp    $0x2,%eax
80104267:	75 d7                	jne    80104240 <cps+0x30>
        cprintf("%d \t %s \t %d \t SLEEPING\n", p->pid, p->name, p->sz);
80104269:	8d 43 78             	lea    0x78(%ebx),%eax
8010426c:	ff 33                	pushl  (%ebx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010426e:	81 c3 88 00 00 00    	add    $0x88,%ebx
        cprintf("%d \t %s \t %d \t SLEEPING\n", p->pid, p->name, p->sz);
80104274:	50                   	push   %eax
80104275:	ff 73 94             	pushl  -0x6c(%ebx)
80104278:	68 98 77 10 80       	push   $0x80107798
8010427d:	e8 2e c4 ff ff       	call   801006b0 <cprintf>
80104282:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104285:	81 fb 54 4f 11 80    	cmp    $0x80114f54,%ebx
8010428b:	75 d4                	jne    80104261 <cps+0x51>
       cprintf("%d \t  %s \t %d \t ZOMBIE\n", p->pid, p->name, p->sz);
  
  }
  release(&ptable.lock);
8010428d:	83 ec 0c             	sub    $0xc,%esp
80104290:	68 20 2d 11 80       	push   $0x80112d20
80104295:	e8 16 04 00 00       	call   801046b0 <release>
  
  return 22;
}
8010429a:	b8 16 00 00 00       	mov    $0x16,%eax
8010429f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042a2:	c9                   	leave  
801042a3:	c3                   	ret    
801042a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
         cprintf("%d \t %s \t %d \t RUNNING\n", p->pid, p->name, p->sz);
801042a8:	8d 43 78             	lea    0x78(%ebx),%eax
801042ab:	ff 33                	pushl  (%ebx)
801042ad:	50                   	push   %eax
801042ae:	ff 73 1c             	pushl  0x1c(%ebx)
801042b1:	68 b1 77 10 80       	push   $0x801077b1
801042b6:	e8 f5 c3 ff ff       	call   801006b0 <cprintf>
801042bb:	83 c4 10             	add    $0x10,%esp
801042be:	eb 93                	jmp    80104253 <cps+0x43>
        cprintf("%d \t %s \t %d \t RUNNABLE\n", p->pid, p->name, p->sz);
801042c0:	8d 43 78             	lea    0x78(%ebx),%eax
801042c3:	ff 33                	pushl  (%ebx)
801042c5:	50                   	push   %eax
801042c6:	ff 73 1c             	pushl  0x1c(%ebx)
801042c9:	68 c9 77 10 80       	push   $0x801077c9
801042ce:	e8 dd c3 ff ff       	call   801006b0 <cprintf>
801042d3:	83 c4 10             	add    $0x10,%esp
801042d6:	e9 78 ff ff ff       	jmp    80104253 <cps+0x43>
801042db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042df:	90                   	nop
       cprintf("%d \t  %s \t %d \t ZOMBIE\n", p->pid, p->name, p->sz);
801042e0:	8d 43 78             	lea    0x78(%ebx),%eax
801042e3:	ff 33                	pushl  (%ebx)
801042e5:	50                   	push   %eax
801042e6:	ff 73 1c             	pushl  0x1c(%ebx)
801042e9:	68 e2 77 10 80       	push   $0x801077e2
801042ee:	e8 bd c3 ff ff       	call   801006b0 <cprintf>
801042f3:	83 c4 10             	add    $0x10,%esp
801042f6:	e9 58 ff ff ff       	jmp    80104253 <cps+0x43>
801042fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042ff:	90                   	nop

80104300 <nps>:
int
nps()
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	56                   	push   %esi
80104304:	53                   	push   %ebx
80104305:	fb                   	sti    

  // Enable interrupts on this processor.
  sti();

  // Loop over process table looking for process with pid.
  acquire(&ptable.lock);
80104306:	83 ec 0c             	sub    $0xc,%esp
  int j = 0;
80104309:	31 db                	xor    %ebx,%ebx
  int i = 0;
8010430b:	31 f6                	xor    %esi,%esi
  acquire(&ptable.lock);
8010430d:	68 20 2d 11 80       	push   $0x80112d20
80104312:	e8 79 02 00 00       	call   80104590 <acquire>
80104317:	83 c4 10             	add    $0x10,%esp

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010431a:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010431f:	eb 1e                	jmp    8010433f <nps+0x3f>
80104321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  {
      if(p->state == SLEEPING)
        i++;
      else if(p->state == RUNNING)
        j++;
80104328:	83 fa 04             	cmp    $0x4,%edx
8010432b:	0f 94 c2             	sete   %dl
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010432e:	05 88 00 00 00       	add    $0x88,%eax
        j++;
80104333:	0f b6 d2             	movzbl %dl,%edx
80104336:	01 d3                	add    %edx,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104338:	3d 54 4f 11 80       	cmp    $0x80114f54,%eax
8010433d:	74 17                	je     80104356 <nps+0x56>
      if(p->state == SLEEPING)
8010433f:	8b 50 18             	mov    0x18(%eax),%edx
80104342:	83 fa 02             	cmp    $0x2,%edx
80104345:	75 e1                	jne    80104328 <nps+0x28>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104347:	05 88 00 00 00       	add    $0x88,%eax
        i++;
8010434c:	83 c6 01             	add    $0x1,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010434f:	3d 54 4f 11 80       	cmp    $0x80114f54,%eax
80104354:	75 e9                	jne    8010433f <nps+0x3f>
  }

  release(&ptable.lock);
80104356:	83 ec 0c             	sub    $0xc,%esp
80104359:	68 20 2d 11 80       	push   $0x80112d20
8010435e:	e8 4d 03 00 00       	call   801046b0 <release>

  cprintf("The total number of SLEEPING processes is %d.\nThe total number of RUNNING processes is %d.\n", i, j);
80104363:	83 c4 0c             	add    $0xc,%esp
80104366:	53                   	push   %ebx
80104367:	56                   	push   %esi
80104368:	68 70 78 10 80       	push   $0x80107870
8010436d:	e8 3e c3 ff ff       	call   801006b0 <cprintf>

  return 22;
}
80104372:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104375:	b8 16 00 00 00       	mov    $0x16,%eax
8010437a:	5b                   	pop    %ebx
8010437b:	5e                   	pop    %esi
8010437c:	5d                   	pop    %ebp
8010437d:	c3                   	ret    
8010437e:	66 90                	xchg   %ax,%ax

80104380 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	53                   	push   %ebx
80104384:	83 ec 0c             	sub    $0xc,%esp
80104387:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010438a:	68 e4 78 10 80       	push   $0x801078e4
8010438f:	8d 43 04             	lea    0x4(%ebx),%eax
80104392:	50                   	push   %eax
80104393:	e8 f8 00 00 00       	call   80104490 <initlock>
  lk->name = name;
80104398:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010439b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801043a1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801043a4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801043ab:	89 43 38             	mov    %eax,0x38(%ebx)
}
801043ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043b1:	c9                   	leave  
801043b2:	c3                   	ret    
801043b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043c0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	56                   	push   %esi
801043c4:	53                   	push   %ebx
801043c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043c8:	8d 73 04             	lea    0x4(%ebx),%esi
801043cb:	83 ec 0c             	sub    $0xc,%esp
801043ce:	56                   	push   %esi
801043cf:	e8 bc 01 00 00       	call   80104590 <acquire>
  while (lk->locked) {
801043d4:	8b 13                	mov    (%ebx),%edx
801043d6:	83 c4 10             	add    $0x10,%esp
801043d9:	85 d2                	test   %edx,%edx
801043db:	74 16                	je     801043f3 <acquiresleep+0x33>
801043dd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801043e0:	83 ec 08             	sub    $0x8,%esp
801043e3:	56                   	push   %esi
801043e4:	53                   	push   %ebx
801043e5:	e8 a6 fa ff ff       	call   80103e90 <sleep>
  while (lk->locked) {
801043ea:	8b 03                	mov    (%ebx),%eax
801043ec:	83 c4 10             	add    $0x10,%esp
801043ef:	85 c0                	test   %eax,%eax
801043f1:	75 ed                	jne    801043e0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801043f3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801043f9:	e8 f2 f4 ff ff       	call   801038f0 <myproc>
801043fe:	8b 40 1c             	mov    0x1c(%eax),%eax
80104401:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104404:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104407:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010440a:	5b                   	pop    %ebx
8010440b:	5e                   	pop    %esi
8010440c:	5d                   	pop    %ebp
  release(&lk->lk);
8010440d:	e9 9e 02 00 00       	jmp    801046b0 <release>
80104412:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104420 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	56                   	push   %esi
80104424:	53                   	push   %ebx
80104425:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104428:	8d 73 04             	lea    0x4(%ebx),%esi
8010442b:	83 ec 0c             	sub    $0xc,%esp
8010442e:	56                   	push   %esi
8010442f:	e8 5c 01 00 00       	call   80104590 <acquire>
  lk->locked = 0;
80104434:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010443a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104441:	89 1c 24             	mov    %ebx,(%esp)
80104444:	e8 07 fc ff ff       	call   80104050 <wakeup>
  release(&lk->lk);
80104449:	89 75 08             	mov    %esi,0x8(%ebp)
8010444c:	83 c4 10             	add    $0x10,%esp
}
8010444f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104452:	5b                   	pop    %ebx
80104453:	5e                   	pop    %esi
80104454:	5d                   	pop    %ebp
  release(&lk->lk);
80104455:	e9 56 02 00 00       	jmp    801046b0 <release>
8010445a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104460 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	56                   	push   %esi
80104464:	53                   	push   %ebx
80104465:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104468:	8d 5e 04             	lea    0x4(%esi),%ebx
8010446b:	83 ec 0c             	sub    $0xc,%esp
8010446e:	53                   	push   %ebx
8010446f:	e8 1c 01 00 00       	call   80104590 <acquire>
  r = lk->locked;
80104474:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104476:	89 1c 24             	mov    %ebx,(%esp)
80104479:	e8 32 02 00 00       	call   801046b0 <release>
  return r;
}
8010447e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104481:	89 f0                	mov    %esi,%eax
80104483:	5b                   	pop    %ebx
80104484:	5e                   	pop    %esi
80104485:	5d                   	pop    %ebp
80104486:	c3                   	ret    
80104487:	66 90                	xchg   %ax,%ax
80104489:	66 90                	xchg   %ax,%ax
8010448b:	66 90                	xchg   %ax,%ax
8010448d:	66 90                	xchg   %ax,%ax
8010448f:	90                   	nop

80104490 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104496:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104499:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010449f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801044a2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801044a9:	5d                   	pop    %ebp
801044aa:	c3                   	ret    
801044ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044af:	90                   	nop

801044b0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801044b0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801044b1:	31 d2                	xor    %edx,%edx
{
801044b3:	89 e5                	mov    %esp,%ebp
801044b5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801044b6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801044b9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801044bc:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
801044bf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044c0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801044c6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801044cc:	77 1a                	ja     801044e8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801044ce:	8b 58 04             	mov    0x4(%eax),%ebx
801044d1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801044d4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801044d7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801044d9:	83 fa 0a             	cmp    $0xa,%edx
801044dc:	75 e2                	jne    801044c0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801044de:	5b                   	pop    %ebx
801044df:	5d                   	pop    %ebp
801044e0:	c3                   	ret    
801044e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044e8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801044eb:	8d 51 28             	lea    0x28(%ecx),%edx
801044ee:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801044f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801044f6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801044f9:	39 c2                	cmp    %eax,%edx
801044fb:	75 f3                	jne    801044f0 <getcallerpcs+0x40>
}
801044fd:	5b                   	pop    %ebx
801044fe:	5d                   	pop    %ebp
801044ff:	c3                   	ret    

80104500 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	53                   	push   %ebx
80104504:	83 ec 04             	sub    $0x4,%esp
80104507:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
8010450a:	8b 02                	mov    (%edx),%eax
8010450c:	85 c0                	test   %eax,%eax
8010450e:	75 10                	jne    80104520 <holding+0x20>
}
80104510:	83 c4 04             	add    $0x4,%esp
80104513:	31 c0                	xor    %eax,%eax
80104515:	5b                   	pop    %ebx
80104516:	5d                   	pop    %ebp
80104517:	c3                   	ret    
80104518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010451f:	90                   	nop
  return lock->locked && lock->cpu == mycpu();
80104520:	8b 5a 08             	mov    0x8(%edx),%ebx
80104523:	e8 28 f3 ff ff       	call   80103850 <mycpu>
80104528:	39 c3                	cmp    %eax,%ebx
8010452a:	0f 94 c0             	sete   %al
}
8010452d:	83 c4 04             	add    $0x4,%esp
  return lock->locked && lock->cpu == mycpu();
80104530:	0f b6 c0             	movzbl %al,%eax
}
80104533:	5b                   	pop    %ebx
80104534:	5d                   	pop    %ebp
80104535:	c3                   	ret    
80104536:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010453d:	8d 76 00             	lea    0x0(%esi),%esi

80104540 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	53                   	push   %ebx
80104544:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104547:	9c                   	pushf  
80104548:	5b                   	pop    %ebx
  asm volatile("cli");
80104549:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010454a:	e8 01 f3 ff ff       	call   80103850 <mycpu>
8010454f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104555:	85 c0                	test   %eax,%eax
80104557:	74 17                	je     80104570 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104559:	e8 f2 f2 ff ff       	call   80103850 <mycpu>
8010455e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104565:	83 c4 04             	add    $0x4,%esp
80104568:	5b                   	pop    %ebx
80104569:	5d                   	pop    %ebp
8010456a:	c3                   	ret    
8010456b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010456f:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104570:	e8 db f2 ff ff       	call   80103850 <mycpu>
80104575:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010457b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104581:	eb d6                	jmp    80104559 <pushcli+0x19>
80104583:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010458a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104590 <acquire>:
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	56                   	push   %esi
80104594:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104595:	e8 a6 ff ff ff       	call   80104540 <pushcli>
  if(holding(lk))
8010459a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
8010459d:	8b 03                	mov    (%ebx),%eax
8010459f:	85 c0                	test   %eax,%eax
801045a1:	0f 85 81 00 00 00    	jne    80104628 <acquire+0x98>
  asm volatile("lock; xchgl %0, %1" :
801045a7:	ba 01 00 00 00       	mov    $0x1,%edx
801045ac:	eb 05                	jmp    801045b3 <acquire+0x23>
801045ae:	66 90                	xchg   %ax,%ax
801045b0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045b3:	89 d0                	mov    %edx,%eax
801045b5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801045b8:	85 c0                	test   %eax,%eax
801045ba:	75 f4                	jne    801045b0 <acquire+0x20>
  __sync_synchronize();
801045bc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801045c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045c4:	e8 87 f2 ff ff       	call   80103850 <mycpu>
  ebp = (uint*)v - 2;
801045c9:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
801045cb:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
801045ce:	31 c0                	xor    %eax,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045d0:	8d 8a 00 00 00 80    	lea    -0x80000000(%edx),%ecx
801045d6:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801045dc:	77 22                	ja     80104600 <acquire+0x70>
    pcs[i] = ebp[1];     // saved %eip
801045de:	8b 4a 04             	mov    0x4(%edx),%ecx
801045e1:	89 4c 83 0c          	mov    %ecx,0xc(%ebx,%eax,4)
  for(i = 0; i < 10; i++){
801045e5:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801045e8:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801045ea:	83 f8 0a             	cmp    $0xa,%eax
801045ed:	75 e1                	jne    801045d0 <acquire+0x40>
}
801045ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045f2:	5b                   	pop    %ebx
801045f3:	5e                   	pop    %esi
801045f4:	5d                   	pop    %ebp
801045f5:	c3                   	ret    
801045f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045fd:	8d 76 00             	lea    0x0(%esi),%esi
80104600:	8d 44 83 0c          	lea    0xc(%ebx,%eax,4),%eax
80104604:	83 c3 34             	add    $0x34,%ebx
80104607:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010460e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104610:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104616:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104619:	39 c3                	cmp    %eax,%ebx
8010461b:	75 f3                	jne    80104610 <acquire+0x80>
}
8010461d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104620:	5b                   	pop    %ebx
80104621:	5e                   	pop    %esi
80104622:	5d                   	pop    %ebp
80104623:	c3                   	ret    
80104624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return lock->locked && lock->cpu == mycpu();
80104628:	8b 73 08             	mov    0x8(%ebx),%esi
8010462b:	e8 20 f2 ff ff       	call   80103850 <mycpu>
80104630:	39 c6                	cmp    %eax,%esi
80104632:	0f 85 6f ff ff ff    	jne    801045a7 <acquire+0x17>
    panic("acquire");
80104638:	83 ec 0c             	sub    $0xc,%esp
8010463b:	68 ef 78 10 80       	push   $0x801078ef
80104640:	e8 4b bd ff ff       	call   80100390 <panic>
80104645:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010464c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104650 <popcli>:

void
popcli(void)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104656:	9c                   	pushf  
80104657:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104658:	f6 c4 02             	test   $0x2,%ah
8010465b:	75 35                	jne    80104692 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010465d:	e8 ee f1 ff ff       	call   80103850 <mycpu>
80104662:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104669:	78 34                	js     8010469f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010466b:	e8 e0 f1 ff ff       	call   80103850 <mycpu>
80104670:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104676:	85 d2                	test   %edx,%edx
80104678:	74 06                	je     80104680 <popcli+0x30>
    sti();
}
8010467a:	c9                   	leave  
8010467b:	c3                   	ret    
8010467c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104680:	e8 cb f1 ff ff       	call   80103850 <mycpu>
80104685:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010468b:	85 c0                	test   %eax,%eax
8010468d:	74 eb                	je     8010467a <popcli+0x2a>
  asm volatile("sti");
8010468f:	fb                   	sti    
}
80104690:	c9                   	leave  
80104691:	c3                   	ret    
    panic("popcli - interruptible");
80104692:	83 ec 0c             	sub    $0xc,%esp
80104695:	68 f7 78 10 80       	push   $0x801078f7
8010469a:	e8 f1 bc ff ff       	call   80100390 <panic>
    panic("popcli");
8010469f:	83 ec 0c             	sub    $0xc,%esp
801046a2:	68 0e 79 10 80       	push   $0x8010790e
801046a7:	e8 e4 bc ff ff       	call   80100390 <panic>
801046ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046b0 <release>:
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	56                   	push   %esi
801046b4:	53                   	push   %ebx
801046b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
801046b8:	8b 03                	mov    (%ebx),%eax
801046ba:	85 c0                	test   %eax,%eax
801046bc:	75 12                	jne    801046d0 <release+0x20>
    panic("release");
801046be:	83 ec 0c             	sub    $0xc,%esp
801046c1:	68 15 79 10 80       	push   $0x80107915
801046c6:	e8 c5 bc ff ff       	call   80100390 <panic>
801046cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046cf:	90                   	nop
  return lock->locked && lock->cpu == mycpu();
801046d0:	8b 73 08             	mov    0x8(%ebx),%esi
801046d3:	e8 78 f1 ff ff       	call   80103850 <mycpu>
801046d8:	39 c6                	cmp    %eax,%esi
801046da:	75 e2                	jne    801046be <release+0xe>
  lk->pcs[0] = 0;
801046dc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801046e3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801046ea:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801046ef:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801046f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046f8:	5b                   	pop    %ebx
801046f9:	5e                   	pop    %esi
801046fa:	5d                   	pop    %ebp
  popcli();
801046fb:	e9 50 ff ff ff       	jmp    80104650 <popcli>

80104700 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	57                   	push   %edi
80104704:	8b 55 08             	mov    0x8(%ebp),%edx
80104707:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010470a:	53                   	push   %ebx
  if ((int)dst%4 == 0 && n%4 == 0){
8010470b:	89 d0                	mov    %edx,%eax
8010470d:	09 c8                	or     %ecx,%eax
8010470f:	a8 03                	test   $0x3,%al
80104711:	75 2d                	jne    80104740 <memset+0x40>
    c &= 0xFF;
80104713:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104717:	c1 e9 02             	shr    $0x2,%ecx
8010471a:	89 f8                	mov    %edi,%eax
8010471c:	89 fb                	mov    %edi,%ebx
8010471e:	c1 e0 18             	shl    $0x18,%eax
80104721:	c1 e3 10             	shl    $0x10,%ebx
80104724:	09 d8                	or     %ebx,%eax
80104726:	09 f8                	or     %edi,%eax
80104728:	c1 e7 08             	shl    $0x8,%edi
8010472b:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
8010472d:	89 d7                	mov    %edx,%edi
8010472f:	fc                   	cld    
80104730:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104732:	5b                   	pop    %ebx
80104733:	89 d0                	mov    %edx,%eax
80104735:	5f                   	pop    %edi
80104736:	5d                   	pop    %ebp
80104737:	c3                   	ret    
80104738:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010473f:	90                   	nop
  asm volatile("cld; rep stosb" :
80104740:	89 d7                	mov    %edx,%edi
80104742:	8b 45 0c             	mov    0xc(%ebp),%eax
80104745:	fc                   	cld    
80104746:	f3 aa                	rep stos %al,%es:(%edi)
80104748:	5b                   	pop    %ebx
80104749:	89 d0                	mov    %edx,%eax
8010474b:	5f                   	pop    %edi
8010474c:	5d                   	pop    %ebp
8010474d:	c3                   	ret    
8010474e:	66 90                	xchg   %ax,%ax

80104750 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	56                   	push   %esi
80104754:	8b 75 10             	mov    0x10(%ebp),%esi
80104757:	8b 45 08             	mov    0x8(%ebp),%eax
8010475a:	53                   	push   %ebx
8010475b:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010475e:	85 f6                	test   %esi,%esi
80104760:	74 22                	je     80104784 <memcmp+0x34>
    if(*s1 != *s2)
80104762:	0f b6 08             	movzbl (%eax),%ecx
80104765:	0f b6 1a             	movzbl (%edx),%ebx
80104768:	01 c6                	add    %eax,%esi
8010476a:	38 cb                	cmp    %cl,%bl
8010476c:	74 0c                	je     8010477a <memcmp+0x2a>
8010476e:	eb 20                	jmp    80104790 <memcmp+0x40>
80104770:	0f b6 08             	movzbl (%eax),%ecx
80104773:	0f b6 1a             	movzbl (%edx),%ebx
80104776:	38 d9                	cmp    %bl,%cl
80104778:	75 16                	jne    80104790 <memcmp+0x40>
      return *s1 - *s2;
    s1++, s2++;
8010477a:	83 c0 01             	add    $0x1,%eax
8010477d:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104780:	39 c6                	cmp    %eax,%esi
80104782:	75 ec                	jne    80104770 <memcmp+0x20>
  }

  return 0;
}
80104784:	5b                   	pop    %ebx
  return 0;
80104785:	31 c0                	xor    %eax,%eax
}
80104787:	5e                   	pop    %esi
80104788:	5d                   	pop    %ebp
80104789:	c3                   	ret    
8010478a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return *s1 - *s2;
80104790:	0f b6 c1             	movzbl %cl,%eax
80104793:	29 d8                	sub    %ebx,%eax
}
80104795:	5b                   	pop    %ebx
80104796:	5e                   	pop    %esi
80104797:	5d                   	pop    %ebp
80104798:	c3                   	ret    
80104799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047a0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	57                   	push   %edi
801047a4:	8b 45 08             	mov    0x8(%ebp),%eax
801047a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047aa:	56                   	push   %esi
801047ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801047ae:	39 c6                	cmp    %eax,%esi
801047b0:	73 26                	jae    801047d8 <memmove+0x38>
801047b2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
801047b5:	39 f8                	cmp    %edi,%eax
801047b7:	73 1f                	jae    801047d8 <memmove+0x38>
801047b9:	8d 51 ff             	lea    -0x1(%ecx),%edx
    s += n;
    d += n;
    while(n-- > 0)
801047bc:	85 c9                	test   %ecx,%ecx
801047be:	74 0f                	je     801047cf <memmove+0x2f>
      *--d = *--s;
801047c0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801047c4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
801047c7:	83 ea 01             	sub    $0x1,%edx
801047ca:	83 fa ff             	cmp    $0xffffffff,%edx
801047cd:	75 f1                	jne    801047c0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801047cf:	5e                   	pop    %esi
801047d0:	5f                   	pop    %edi
801047d1:	5d                   	pop    %ebp
801047d2:	c3                   	ret    
801047d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047d7:	90                   	nop
801047d8:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
    while(n-- > 0)
801047db:	89 c7                	mov    %eax,%edi
801047dd:	85 c9                	test   %ecx,%ecx
801047df:	74 ee                	je     801047cf <memmove+0x2f>
801047e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
801047e8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
801047e9:	39 d6                	cmp    %edx,%esi
801047eb:	75 fb                	jne    801047e8 <memmove+0x48>
}
801047ed:	5e                   	pop    %esi
801047ee:	5f                   	pop    %edi
801047ef:	5d                   	pop    %ebp
801047f0:	c3                   	ret    
801047f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047ff:	90                   	nop

80104800 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104800:	eb 9e                	jmp    801047a0 <memmove>
80104802:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104810 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	57                   	push   %edi
80104814:	8b 7d 10             	mov    0x10(%ebp),%edi
80104817:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010481a:	56                   	push   %esi
8010481b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010481e:	53                   	push   %ebx
  while(n > 0 && *p && *p == *q)
8010481f:	85 ff                	test   %edi,%edi
80104821:	74 2f                	je     80104852 <strncmp+0x42>
80104823:	0f b6 11             	movzbl (%ecx),%edx
80104826:	0f b6 1e             	movzbl (%esi),%ebx
80104829:	84 d2                	test   %dl,%dl
8010482b:	74 37                	je     80104864 <strncmp+0x54>
8010482d:	38 da                	cmp    %bl,%dl
8010482f:	75 33                	jne    80104864 <strncmp+0x54>
80104831:	01 f7                	add    %esi,%edi
80104833:	eb 13                	jmp    80104848 <strncmp+0x38>
80104835:	8d 76 00             	lea    0x0(%esi),%esi
80104838:	0f b6 11             	movzbl (%ecx),%edx
8010483b:	84 d2                	test   %dl,%dl
8010483d:	74 21                	je     80104860 <strncmp+0x50>
8010483f:	0f b6 18             	movzbl (%eax),%ebx
80104842:	89 c6                	mov    %eax,%esi
80104844:	38 da                	cmp    %bl,%dl
80104846:	75 1c                	jne    80104864 <strncmp+0x54>
    n--, p++, q++;
80104848:	8d 46 01             	lea    0x1(%esi),%eax
8010484b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010484e:	39 f8                	cmp    %edi,%eax
80104850:	75 e6                	jne    80104838 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104852:	5b                   	pop    %ebx
    return 0;
80104853:	31 c0                	xor    %eax,%eax
}
80104855:	5e                   	pop    %esi
80104856:	5f                   	pop    %edi
80104857:	5d                   	pop    %ebp
80104858:	c3                   	ret    
80104859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104860:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104864:	0f b6 c2             	movzbl %dl,%eax
80104867:	29 d8                	sub    %ebx,%eax
}
80104869:	5b                   	pop    %ebx
8010486a:	5e                   	pop    %esi
8010486b:	5f                   	pop    %edi
8010486c:	5d                   	pop    %ebp
8010486d:	c3                   	ret    
8010486e:	66 90                	xchg   %ax,%ax

80104870 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	57                   	push   %edi
80104874:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104877:	8b 4d 08             	mov    0x8(%ebp),%ecx
{
8010487a:	56                   	push   %esi
8010487b:	53                   	push   %ebx
8010487c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  while(n-- > 0 && (*s++ = *t++) != 0)
8010487f:	eb 1a                	jmp    8010489b <strncpy+0x2b>
80104881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104888:	83 c2 01             	add    $0x1,%edx
8010488b:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
8010488f:	83 c1 01             	add    $0x1,%ecx
80104892:	88 41 ff             	mov    %al,-0x1(%ecx)
80104895:	84 c0                	test   %al,%al
80104897:	74 09                	je     801048a2 <strncpy+0x32>
80104899:	89 fb                	mov    %edi,%ebx
8010489b:	8d 7b ff             	lea    -0x1(%ebx),%edi
8010489e:	85 db                	test   %ebx,%ebx
801048a0:	7f e6                	jg     80104888 <strncpy+0x18>
    ;
  while(n-- > 0)
801048a2:	89 ce                	mov    %ecx,%esi
801048a4:	85 ff                	test   %edi,%edi
801048a6:	7e 1b                	jle    801048c3 <strncpy+0x53>
801048a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048af:	90                   	nop
    *s++ = 0;
801048b0:	83 c6 01             	add    $0x1,%esi
801048b3:	c6 46 ff 00          	movb   $0x0,-0x1(%esi)
801048b7:	89 f2                	mov    %esi,%edx
801048b9:	f7 d2                	not    %edx
801048bb:	01 ca                	add    %ecx,%edx
801048bd:	01 da                	add    %ebx,%edx
  while(n-- > 0)
801048bf:	85 d2                	test   %edx,%edx
801048c1:	7f ed                	jg     801048b0 <strncpy+0x40>
  return os;
}
801048c3:	5b                   	pop    %ebx
801048c4:	8b 45 08             	mov    0x8(%ebp),%eax
801048c7:	5e                   	pop    %esi
801048c8:	5f                   	pop    %edi
801048c9:	5d                   	pop    %ebp
801048ca:	c3                   	ret    
801048cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048cf:	90                   	nop

801048d0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	56                   	push   %esi
801048d4:	8b 4d 10             	mov    0x10(%ebp),%ecx
801048d7:	8b 45 08             	mov    0x8(%ebp),%eax
801048da:	53                   	push   %ebx
801048db:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801048de:	85 c9                	test   %ecx,%ecx
801048e0:	7e 26                	jle    80104908 <safestrcpy+0x38>
801048e2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801048e6:	89 c1                	mov    %eax,%ecx
801048e8:	eb 17                	jmp    80104901 <safestrcpy+0x31>
801048ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801048f0:	83 c2 01             	add    $0x1,%edx
801048f3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801048f7:	83 c1 01             	add    $0x1,%ecx
801048fa:	88 59 ff             	mov    %bl,-0x1(%ecx)
801048fd:	84 db                	test   %bl,%bl
801048ff:	74 04                	je     80104905 <safestrcpy+0x35>
80104901:	39 f2                	cmp    %esi,%edx
80104903:	75 eb                	jne    801048f0 <safestrcpy+0x20>
    ;
  *s = 0;
80104905:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104908:	5b                   	pop    %ebx
80104909:	5e                   	pop    %esi
8010490a:	5d                   	pop    %ebp
8010490b:	c3                   	ret    
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104910 <strlen>:

int
strlen(const char *s)
{
80104910:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104911:	31 c0                	xor    %eax,%eax
{
80104913:	89 e5                	mov    %esp,%ebp
80104915:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104918:	80 3a 00             	cmpb   $0x0,(%edx)
8010491b:	74 0c                	je     80104929 <strlen+0x19>
8010491d:	8d 76 00             	lea    0x0(%esi),%esi
80104920:	83 c0 01             	add    $0x1,%eax
80104923:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104927:	75 f7                	jne    80104920 <strlen+0x10>
    ;
  return n;
}
80104929:	5d                   	pop    %ebp
8010492a:	c3                   	ret    

8010492b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010492b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010492f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104933:	55                   	push   %ebp
  pushl %ebx
80104934:	53                   	push   %ebx
  pushl %esi
80104935:	56                   	push   %esi
  pushl %edi
80104936:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104937:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104939:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010493b:	5f                   	pop    %edi
  popl %esi
8010493c:	5e                   	pop    %esi
  popl %ebx
8010493d:	5b                   	pop    %ebx
  popl %ebp
8010493e:	5d                   	pop    %ebp
  ret
8010493f:	c3                   	ret    

80104940 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104940:	55                   	push   %ebp
80104941:	89 e5                	mov    %esp,%ebp
80104943:	53                   	push   %ebx
80104944:	83 ec 04             	sub    $0x4,%esp
80104947:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010494a:	e8 a1 ef ff ff       	call   801038f0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010494f:	8b 00                	mov    (%eax),%eax
80104951:	39 d8                	cmp    %ebx,%eax
80104953:	76 1b                	jbe    80104970 <fetchint+0x30>
80104955:	8d 53 04             	lea    0x4(%ebx),%edx
80104958:	39 d0                	cmp    %edx,%eax
8010495a:	72 14                	jb     80104970 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010495c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010495f:	8b 13                	mov    (%ebx),%edx
80104961:	89 10                	mov    %edx,(%eax)
  return 0;
80104963:	31 c0                	xor    %eax,%eax
}
80104965:	83 c4 04             	add    $0x4,%esp
80104968:	5b                   	pop    %ebx
80104969:	5d                   	pop    %ebp
8010496a:	c3                   	ret    
8010496b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010496f:	90                   	nop
    return -1;
80104970:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104975:	eb ee                	jmp    80104965 <fetchint+0x25>
80104977:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010497e:	66 90                	xchg   %ax,%ax

80104980 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	53                   	push   %ebx
80104984:	83 ec 04             	sub    $0x4,%esp
80104987:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010498a:	e8 61 ef ff ff       	call   801038f0 <myproc>

  if(addr >= curproc->sz)
8010498f:	39 18                	cmp    %ebx,(%eax)
80104991:	76 29                	jbe    801049bc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104993:	8b 55 0c             	mov    0xc(%ebp),%edx
80104996:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104998:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010499a:	39 d3                	cmp    %edx,%ebx
8010499c:	73 1e                	jae    801049bc <fetchstr+0x3c>
    if(*s == 0)
8010499e:	80 3b 00             	cmpb   $0x0,(%ebx)
801049a1:	74 35                	je     801049d8 <fetchstr+0x58>
801049a3:	89 d8                	mov    %ebx,%eax
801049a5:	eb 0e                	jmp    801049b5 <fetchstr+0x35>
801049a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049ae:	66 90                	xchg   %ax,%ax
801049b0:	80 38 00             	cmpb   $0x0,(%eax)
801049b3:	74 1b                	je     801049d0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
801049b5:	83 c0 01             	add    $0x1,%eax
801049b8:	39 c2                	cmp    %eax,%edx
801049ba:	77 f4                	ja     801049b0 <fetchstr+0x30>
    return -1;
801049bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
801049c1:	83 c4 04             	add    $0x4,%esp
801049c4:	5b                   	pop    %ebx
801049c5:	5d                   	pop    %ebp
801049c6:	c3                   	ret    
801049c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049ce:	66 90                	xchg   %ax,%ax
801049d0:	83 c4 04             	add    $0x4,%esp
801049d3:	29 d8                	sub    %ebx,%eax
801049d5:	5b                   	pop    %ebx
801049d6:	5d                   	pop    %ebp
801049d7:	c3                   	ret    
    if(*s == 0)
801049d8:	31 c0                	xor    %eax,%eax
      return s - *pp;
801049da:	eb e5                	jmp    801049c1 <fetchstr+0x41>
801049dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049e0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	56                   	push   %esi
801049e4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049e5:	e8 06 ef ff ff       	call   801038f0 <myproc>
801049ea:	8b 55 08             	mov    0x8(%ebp),%edx
801049ed:	8b 40 24             	mov    0x24(%eax),%eax
801049f0:	8b 40 44             	mov    0x44(%eax),%eax
801049f3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801049f6:	e8 f5 ee ff ff       	call   801038f0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049fb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049fe:	8b 00                	mov    (%eax),%eax
80104a00:	39 c6                	cmp    %eax,%esi
80104a02:	73 1c                	jae    80104a20 <argint+0x40>
80104a04:	8d 53 08             	lea    0x8(%ebx),%edx
80104a07:	39 d0                	cmp    %edx,%eax
80104a09:	72 15                	jb     80104a20 <argint+0x40>
  *ip = *(int*)(addr);
80104a0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a0e:	8b 53 04             	mov    0x4(%ebx),%edx
80104a11:	89 10                	mov    %edx,(%eax)
  return 0;
80104a13:	31 c0                	xor    %eax,%eax
}
80104a15:	5b                   	pop    %ebx
80104a16:	5e                   	pop    %esi
80104a17:	5d                   	pop    %ebp
80104a18:	c3                   	ret    
80104a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a25:	eb ee                	jmp    80104a15 <argint+0x35>
80104a27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a2e:	66 90                	xchg   %ax,%ax

80104a30 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	56                   	push   %esi
80104a34:	53                   	push   %ebx
80104a35:	83 ec 10             	sub    $0x10,%esp
80104a38:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104a3b:	e8 b0 ee ff ff       	call   801038f0 <myproc>
 
  if(argint(n, &i) < 0)
80104a40:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80104a43:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
80104a45:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a48:	50                   	push   %eax
80104a49:	ff 75 08             	pushl  0x8(%ebp)
80104a4c:	e8 8f ff ff ff       	call   801049e0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104a51:	83 c4 10             	add    $0x10,%esp
80104a54:	85 c0                	test   %eax,%eax
80104a56:	78 28                	js     80104a80 <argptr+0x50>
80104a58:	85 db                	test   %ebx,%ebx
80104a5a:	78 24                	js     80104a80 <argptr+0x50>
80104a5c:	8b 16                	mov    (%esi),%edx
80104a5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a61:	39 c2                	cmp    %eax,%edx
80104a63:	76 1b                	jbe    80104a80 <argptr+0x50>
80104a65:	01 c3                	add    %eax,%ebx
80104a67:	39 da                	cmp    %ebx,%edx
80104a69:	72 15                	jb     80104a80 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104a6b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a6e:	89 02                	mov    %eax,(%edx)
  return 0;
80104a70:	31 c0                	xor    %eax,%eax
}
80104a72:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a75:	5b                   	pop    %ebx
80104a76:	5e                   	pop    %esi
80104a77:	5d                   	pop    %ebp
80104a78:	c3                   	ret    
80104a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a85:	eb eb                	jmp    80104a72 <argptr+0x42>
80104a87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a8e:	66 90                	xchg   %ax,%ax

80104a90 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104a96:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a99:	50                   	push   %eax
80104a9a:	ff 75 08             	pushl  0x8(%ebp)
80104a9d:	e8 3e ff ff ff       	call   801049e0 <argint>
80104aa2:	83 c4 10             	add    $0x10,%esp
80104aa5:	85 c0                	test   %eax,%eax
80104aa7:	78 17                	js     80104ac0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104aa9:	83 ec 08             	sub    $0x8,%esp
80104aac:	ff 75 0c             	pushl  0xc(%ebp)
80104aaf:	ff 75 f4             	pushl  -0xc(%ebp)
80104ab2:	e8 c9 fe ff ff       	call   80104980 <fetchstr>
80104ab7:	83 c4 10             	add    $0x10,%esp
}
80104aba:	c9                   	leave  
80104abb:	c3                   	ret    
80104abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ac0:	c9                   	leave  
    return -1;
80104ac1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ac6:	c3                   	ret    
80104ac7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ace:	66 90                	xchg   %ax,%ax

80104ad0 <syscall>:
[SYS_nps]     sys_nps,
};

void
syscall(void)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	53                   	push   %ebx
80104ad4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104ad7:	e8 14 ee ff ff       	call   801038f0 <myproc>
80104adc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104ade:	8b 40 24             	mov    0x24(%eax),%eax
80104ae1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104ae4:	8d 50 ff             	lea    -0x1(%eax),%edx
80104ae7:	83 fa 17             	cmp    $0x17,%edx
80104aea:	77 1c                	ja     80104b08 <syscall+0x38>
80104aec:	8b 14 85 40 79 10 80 	mov    -0x7fef86c0(,%eax,4),%edx
80104af3:	85 d2                	test   %edx,%edx
80104af5:	74 11                	je     80104b08 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104af7:	ff d2                	call   *%edx
80104af9:	8b 53 24             	mov    0x24(%ebx),%edx
80104afc:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104aff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b02:	c9                   	leave  
80104b03:	c3                   	ret    
80104b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104b08:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104b09:	8d 43 78             	lea    0x78(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104b0c:	50                   	push   %eax
80104b0d:	ff 73 1c             	pushl  0x1c(%ebx)
80104b10:	68 1d 79 10 80       	push   $0x8010791d
80104b15:	e8 96 bb ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
80104b1a:	8b 43 24             	mov    0x24(%ebx),%eax
80104b1d:	83 c4 10             	add    $0x10,%esp
80104b20:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104b27:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b2a:	c9                   	leave  
80104b2b:	c3                   	ret    
80104b2c:	66 90                	xchg   %ax,%ax
80104b2e:	66 90                	xchg   %ax,%ax

80104b30 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	57                   	push   %edi
80104b34:	56                   	push   %esi
80104b35:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b36:	8d 5d da             	lea    -0x26(%ebp),%ebx
{
80104b39:	83 ec 44             	sub    $0x44,%esp
80104b3c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104b3f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104b42:	53                   	push   %ebx
80104b43:	50                   	push   %eax
{
80104b44:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104b47:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104b4a:	e8 91 d4 ff ff       	call   80101fe0 <nameiparent>
80104b4f:	83 c4 10             	add    $0x10,%esp
80104b52:	85 c0                	test   %eax,%eax
80104b54:	0f 84 46 01 00 00    	je     80104ca0 <create+0x170>
    return 0;
  ilock(dp);
80104b5a:	83 ec 0c             	sub    $0xc,%esp
80104b5d:	89 c6                	mov    %eax,%esi
80104b5f:	50                   	push   %eax
80104b60:	e8 bb cb ff ff       	call   80101720 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104b65:	83 c4 0c             	add    $0xc,%esp
80104b68:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b6b:	50                   	push   %eax
80104b6c:	53                   	push   %ebx
80104b6d:	56                   	push   %esi
80104b6e:	e8 dd d0 ff ff       	call   80101c50 <dirlookup>
80104b73:	83 c4 10             	add    $0x10,%esp
80104b76:	89 c7                	mov    %eax,%edi
80104b78:	85 c0                	test   %eax,%eax
80104b7a:	74 54                	je     80104bd0 <create+0xa0>
    iunlockput(dp);
80104b7c:	83 ec 0c             	sub    $0xc,%esp
80104b7f:	56                   	push   %esi
80104b80:	e8 2b ce ff ff       	call   801019b0 <iunlockput>
    ilock(ip);
80104b85:	89 3c 24             	mov    %edi,(%esp)
80104b88:	e8 93 cb ff ff       	call   80101720 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104b8d:	83 c4 10             	add    $0x10,%esp
80104b90:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104b95:	75 19                	jne    80104bb0 <create+0x80>
80104b97:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104b9c:	75 12                	jne    80104bb0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ba1:	89 f8                	mov    %edi,%eax
80104ba3:	5b                   	pop    %ebx
80104ba4:	5e                   	pop    %esi
80104ba5:	5f                   	pop    %edi
80104ba6:	5d                   	pop    %ebp
80104ba7:	c3                   	ret    
80104ba8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104baf:	90                   	nop
    iunlockput(ip);
80104bb0:	83 ec 0c             	sub    $0xc,%esp
80104bb3:	57                   	push   %edi
    return 0;
80104bb4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104bb6:	e8 f5 cd ff ff       	call   801019b0 <iunlockput>
    return 0;
80104bbb:	83 c4 10             	add    $0x10,%esp
}
80104bbe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bc1:	89 f8                	mov    %edi,%eax
80104bc3:	5b                   	pop    %ebx
80104bc4:	5e                   	pop    %esi
80104bc5:	5f                   	pop    %edi
80104bc6:	5d                   	pop    %ebp
80104bc7:	c3                   	ret    
80104bc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bcf:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104bd0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104bd4:	83 ec 08             	sub    $0x8,%esp
80104bd7:	50                   	push   %eax
80104bd8:	ff 36                	pushl  (%esi)
80104bda:	e8 d1 c9 ff ff       	call   801015b0 <ialloc>
80104bdf:	83 c4 10             	add    $0x10,%esp
80104be2:	89 c7                	mov    %eax,%edi
80104be4:	85 c0                	test   %eax,%eax
80104be6:	0f 84 cd 00 00 00    	je     80104cb9 <create+0x189>
  ilock(ip);
80104bec:	83 ec 0c             	sub    $0xc,%esp
80104bef:	50                   	push   %eax
80104bf0:	e8 2b cb ff ff       	call   80101720 <ilock>
  ip->major = major;
80104bf5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104bf9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104bfd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104c01:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104c05:	b8 01 00 00 00       	mov    $0x1,%eax
80104c0a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104c0e:	89 3c 24             	mov    %edi,(%esp)
80104c11:	e8 5a ca ff ff       	call   80101670 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104c16:	83 c4 10             	add    $0x10,%esp
80104c19:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104c1e:	74 30                	je     80104c50 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104c20:	83 ec 04             	sub    $0x4,%esp
80104c23:	ff 77 04             	pushl  0x4(%edi)
80104c26:	53                   	push   %ebx
80104c27:	56                   	push   %esi
80104c28:	e8 d3 d2 ff ff       	call   80101f00 <dirlink>
80104c2d:	83 c4 10             	add    $0x10,%esp
80104c30:	85 c0                	test   %eax,%eax
80104c32:	78 78                	js     80104cac <create+0x17c>
  iunlockput(dp);
80104c34:	83 ec 0c             	sub    $0xc,%esp
80104c37:	56                   	push   %esi
80104c38:	e8 73 cd ff ff       	call   801019b0 <iunlockput>
  return ip;
80104c3d:	83 c4 10             	add    $0x10,%esp
}
80104c40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c43:	89 f8                	mov    %edi,%eax
80104c45:	5b                   	pop    %ebx
80104c46:	5e                   	pop    %esi
80104c47:	5f                   	pop    %edi
80104c48:	5d                   	pop    %ebp
80104c49:	c3                   	ret    
80104c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104c50:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104c53:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
    iupdate(dp);
80104c58:	56                   	push   %esi
80104c59:	e8 12 ca ff ff       	call   80101670 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104c5e:	83 c4 0c             	add    $0xc,%esp
80104c61:	ff 77 04             	pushl  0x4(%edi)
80104c64:	68 c0 79 10 80       	push   $0x801079c0
80104c69:	57                   	push   %edi
80104c6a:	e8 91 d2 ff ff       	call   80101f00 <dirlink>
80104c6f:	83 c4 10             	add    $0x10,%esp
80104c72:	85 c0                	test   %eax,%eax
80104c74:	78 18                	js     80104c8e <create+0x15e>
80104c76:	83 ec 04             	sub    $0x4,%esp
80104c79:	ff 76 04             	pushl  0x4(%esi)
80104c7c:	68 bf 79 10 80       	push   $0x801079bf
80104c81:	57                   	push   %edi
80104c82:	e8 79 d2 ff ff       	call   80101f00 <dirlink>
80104c87:	83 c4 10             	add    $0x10,%esp
80104c8a:	85 c0                	test   %eax,%eax
80104c8c:	79 92                	jns    80104c20 <create+0xf0>
      panic("create dots");
80104c8e:	83 ec 0c             	sub    $0xc,%esp
80104c91:	68 b3 79 10 80       	push   $0x801079b3
80104c96:	e8 f5 b6 ff ff       	call   80100390 <panic>
80104c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c9f:	90                   	nop
}
80104ca0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104ca3:	31 ff                	xor    %edi,%edi
}
80104ca5:	5b                   	pop    %ebx
80104ca6:	89 f8                	mov    %edi,%eax
80104ca8:	5e                   	pop    %esi
80104ca9:	5f                   	pop    %edi
80104caa:	5d                   	pop    %ebp
80104cab:	c3                   	ret    
    panic("create: dirlink");
80104cac:	83 ec 0c             	sub    $0xc,%esp
80104caf:	68 c2 79 10 80       	push   $0x801079c2
80104cb4:	e8 d7 b6 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104cb9:	83 ec 0c             	sub    $0xc,%esp
80104cbc:	68 a4 79 10 80       	push   $0x801079a4
80104cc1:	e8 ca b6 ff ff       	call   80100390 <panic>
80104cc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ccd:	8d 76 00             	lea    0x0(%esi),%esi

80104cd0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104cd0:	55                   	push   %ebp
80104cd1:	89 e5                	mov    %esp,%ebp
80104cd3:	56                   	push   %esi
80104cd4:	89 d6                	mov    %edx,%esi
80104cd6:	53                   	push   %ebx
80104cd7:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104cd9:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104cdc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104cdf:	50                   	push   %eax
80104ce0:	6a 00                	push   $0x0
80104ce2:	e8 f9 fc ff ff       	call   801049e0 <argint>
80104ce7:	83 c4 10             	add    $0x10,%esp
80104cea:	85 c0                	test   %eax,%eax
80104cec:	78 2a                	js     80104d18 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104cee:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104cf2:	77 24                	ja     80104d18 <argfd.constprop.0+0x48>
80104cf4:	e8 f7 eb ff ff       	call   801038f0 <myproc>
80104cf9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104cfc:	8b 44 90 34          	mov    0x34(%eax,%edx,4),%eax
80104d00:	85 c0                	test   %eax,%eax
80104d02:	74 14                	je     80104d18 <argfd.constprop.0+0x48>
  if(pfd)
80104d04:	85 db                	test   %ebx,%ebx
80104d06:	74 02                	je     80104d0a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104d08:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104d0a:	89 06                	mov    %eax,(%esi)
  return 0;
80104d0c:	31 c0                	xor    %eax,%eax
}
80104d0e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d11:	5b                   	pop    %ebx
80104d12:	5e                   	pop    %esi
80104d13:	5d                   	pop    %ebp
80104d14:	c3                   	ret    
80104d15:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104d18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d1d:	eb ef                	jmp    80104d0e <argfd.constprop.0+0x3e>
80104d1f:	90                   	nop

80104d20 <sys_dup>:
{
80104d20:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104d21:	31 c0                	xor    %eax,%eax
{
80104d23:	89 e5                	mov    %esp,%ebp
80104d25:	56                   	push   %esi
80104d26:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104d27:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104d2a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104d2d:	e8 9e ff ff ff       	call   80104cd0 <argfd.constprop.0>
80104d32:	85 c0                	test   %eax,%eax
80104d34:	78 1a                	js     80104d50 <sys_dup+0x30>
  if((fd=fdalloc(f)) < 0)
80104d36:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104d39:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104d3b:	e8 b0 eb ff ff       	call   801038f0 <myproc>
    if(curproc->ofile[fd] == 0){
80104d40:	8b 54 98 34          	mov    0x34(%eax,%ebx,4),%edx
80104d44:	85 d2                	test   %edx,%edx
80104d46:	74 18                	je     80104d60 <sys_dup+0x40>
  for(fd = 0; fd < NOFILE; fd++){
80104d48:	83 c3 01             	add    $0x1,%ebx
80104d4b:	83 fb 10             	cmp    $0x10,%ebx
80104d4e:	75 f0                	jne    80104d40 <sys_dup+0x20>
}
80104d50:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104d53:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104d58:	89 d8                	mov    %ebx,%eax
80104d5a:	5b                   	pop    %ebx
80104d5b:	5e                   	pop    %esi
80104d5c:	5d                   	pop    %ebp
80104d5d:	c3                   	ret    
80104d5e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80104d60:	89 74 98 34          	mov    %esi,0x34(%eax,%ebx,4)
  filedup(f);
80104d64:	83 ec 0c             	sub    $0xc,%esp
80104d67:	ff 75 f4             	pushl  -0xc(%ebp)
80104d6a:	e8 01 c1 ff ff       	call   80100e70 <filedup>
  return fd;
80104d6f:	83 c4 10             	add    $0x10,%esp
}
80104d72:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d75:	89 d8                	mov    %ebx,%eax
80104d77:	5b                   	pop    %ebx
80104d78:	5e                   	pop    %esi
80104d79:	5d                   	pop    %ebp
80104d7a:	c3                   	ret    
80104d7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d7f:	90                   	nop

80104d80 <sys_read>:
{
80104d80:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d81:	31 c0                	xor    %eax,%eax
{
80104d83:	89 e5                	mov    %esp,%ebp
80104d85:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d88:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d8b:	e8 40 ff ff ff       	call   80104cd0 <argfd.constprop.0>
80104d90:	85 c0                	test   %eax,%eax
80104d92:	78 4c                	js     80104de0 <sys_read+0x60>
80104d94:	83 ec 08             	sub    $0x8,%esp
80104d97:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d9a:	50                   	push   %eax
80104d9b:	6a 02                	push   $0x2
80104d9d:	e8 3e fc ff ff       	call   801049e0 <argint>
80104da2:	83 c4 10             	add    $0x10,%esp
80104da5:	85 c0                	test   %eax,%eax
80104da7:	78 37                	js     80104de0 <sys_read+0x60>
80104da9:	83 ec 04             	sub    $0x4,%esp
80104dac:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104daf:	ff 75 f0             	pushl  -0x10(%ebp)
80104db2:	50                   	push   %eax
80104db3:	6a 01                	push   $0x1
80104db5:	e8 76 fc ff ff       	call   80104a30 <argptr>
80104dba:	83 c4 10             	add    $0x10,%esp
80104dbd:	85 c0                	test   %eax,%eax
80104dbf:	78 1f                	js     80104de0 <sys_read+0x60>
  return fileread(f, p, n);
80104dc1:	83 ec 04             	sub    $0x4,%esp
80104dc4:	ff 75 f0             	pushl  -0x10(%ebp)
80104dc7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dca:	ff 75 ec             	pushl  -0x14(%ebp)
80104dcd:	e8 1e c2 ff ff       	call   80100ff0 <fileread>
80104dd2:	83 c4 10             	add    $0x10,%esp
}
80104dd5:	c9                   	leave  
80104dd6:	c3                   	ret    
80104dd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dde:	66 90                	xchg   %ax,%ax
80104de0:	c9                   	leave  
    return -1;
80104de1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104de6:	c3                   	ret    
80104de7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dee:	66 90                	xchg   %ax,%ax

80104df0 <sys_write>:
{
80104df0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104df1:	31 c0                	xor    %eax,%eax
{
80104df3:	89 e5                	mov    %esp,%ebp
80104df5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104df8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104dfb:	e8 d0 fe ff ff       	call   80104cd0 <argfd.constprop.0>
80104e00:	85 c0                	test   %eax,%eax
80104e02:	78 4c                	js     80104e50 <sys_write+0x60>
80104e04:	83 ec 08             	sub    $0x8,%esp
80104e07:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e0a:	50                   	push   %eax
80104e0b:	6a 02                	push   $0x2
80104e0d:	e8 ce fb ff ff       	call   801049e0 <argint>
80104e12:	83 c4 10             	add    $0x10,%esp
80104e15:	85 c0                	test   %eax,%eax
80104e17:	78 37                	js     80104e50 <sys_write+0x60>
80104e19:	83 ec 04             	sub    $0x4,%esp
80104e1c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e1f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e22:	50                   	push   %eax
80104e23:	6a 01                	push   $0x1
80104e25:	e8 06 fc ff ff       	call   80104a30 <argptr>
80104e2a:	83 c4 10             	add    $0x10,%esp
80104e2d:	85 c0                	test   %eax,%eax
80104e2f:	78 1f                	js     80104e50 <sys_write+0x60>
  return filewrite(f, p, n);
80104e31:	83 ec 04             	sub    $0x4,%esp
80104e34:	ff 75 f0             	pushl  -0x10(%ebp)
80104e37:	ff 75 f4             	pushl  -0xc(%ebp)
80104e3a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e3d:	e8 3e c2 ff ff       	call   80101080 <filewrite>
80104e42:	83 c4 10             	add    $0x10,%esp
}
80104e45:	c9                   	leave  
80104e46:	c3                   	ret    
80104e47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e4e:	66 90                	xchg   %ax,%ax
80104e50:	c9                   	leave  
    return -1;
80104e51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e56:	c3                   	ret    
80104e57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e5e:	66 90                	xchg   %ax,%ax

80104e60 <sys_close>:
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104e66:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e69:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e6c:	e8 5f fe ff ff       	call   80104cd0 <argfd.constprop.0>
80104e71:	85 c0                	test   %eax,%eax
80104e73:	78 2b                	js     80104ea0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104e75:	e8 76 ea ff ff       	call   801038f0 <myproc>
80104e7a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104e7d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104e80:	c7 44 90 34 00 00 00 	movl   $0x0,0x34(%eax,%edx,4)
80104e87:	00 
  fileclose(f);
80104e88:	ff 75 f4             	pushl  -0xc(%ebp)
80104e8b:	e8 30 c0 ff ff       	call   80100ec0 <fileclose>
  return 0;
80104e90:	83 c4 10             	add    $0x10,%esp
80104e93:	31 c0                	xor    %eax,%eax
}
80104e95:	c9                   	leave  
80104e96:	c3                   	ret    
80104e97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e9e:	66 90                	xchg   %ax,%ax
80104ea0:	c9                   	leave  
    return -1;
80104ea1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ea6:	c3                   	ret    
80104ea7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eae:	66 90                	xchg   %ax,%ax

80104eb0 <sys_fstat>:
{
80104eb0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104eb1:	31 c0                	xor    %eax,%eax
{
80104eb3:	89 e5                	mov    %esp,%ebp
80104eb5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104eb8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104ebb:	e8 10 fe ff ff       	call   80104cd0 <argfd.constprop.0>
80104ec0:	85 c0                	test   %eax,%eax
80104ec2:	78 2c                	js     80104ef0 <sys_fstat+0x40>
80104ec4:	83 ec 04             	sub    $0x4,%esp
80104ec7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104eca:	6a 14                	push   $0x14
80104ecc:	50                   	push   %eax
80104ecd:	6a 01                	push   $0x1
80104ecf:	e8 5c fb ff ff       	call   80104a30 <argptr>
80104ed4:	83 c4 10             	add    $0x10,%esp
80104ed7:	85 c0                	test   %eax,%eax
80104ed9:	78 15                	js     80104ef0 <sys_fstat+0x40>
  return filestat(f, st);
80104edb:	83 ec 08             	sub    $0x8,%esp
80104ede:	ff 75 f4             	pushl  -0xc(%ebp)
80104ee1:	ff 75 f0             	pushl  -0x10(%ebp)
80104ee4:	e8 b7 c0 ff ff       	call   80100fa0 <filestat>
80104ee9:	83 c4 10             	add    $0x10,%esp
}
80104eec:	c9                   	leave  
80104eed:	c3                   	ret    
80104eee:	66 90                	xchg   %ax,%ax
80104ef0:	c9                   	leave  
    return -1;
80104ef1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ef6:	c3                   	ret    
80104ef7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104efe:	66 90                	xchg   %ax,%ax

80104f00 <sys_link>:
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	57                   	push   %edi
80104f04:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f05:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104f08:	53                   	push   %ebx
80104f09:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f0c:	50                   	push   %eax
80104f0d:	6a 00                	push   $0x0
80104f0f:	e8 7c fb ff ff       	call   80104a90 <argstr>
80104f14:	83 c4 10             	add    $0x10,%esp
80104f17:	85 c0                	test   %eax,%eax
80104f19:	0f 88 fb 00 00 00    	js     8010501a <sys_link+0x11a>
80104f1f:	83 ec 08             	sub    $0x8,%esp
80104f22:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f25:	50                   	push   %eax
80104f26:	6a 01                	push   $0x1
80104f28:	e8 63 fb ff ff       	call   80104a90 <argstr>
80104f2d:	83 c4 10             	add    $0x10,%esp
80104f30:	85 c0                	test   %eax,%eax
80104f32:	0f 88 e2 00 00 00    	js     8010501a <sys_link+0x11a>
  begin_op();
80104f38:	e8 63 dd ff ff       	call   80102ca0 <begin_op>
  if((ip = namei(old)) == 0){
80104f3d:	83 ec 0c             	sub    $0xc,%esp
80104f40:	ff 75 d4             	pushl  -0x2c(%ebp)
80104f43:	e8 78 d0 ff ff       	call   80101fc0 <namei>
80104f48:	83 c4 10             	add    $0x10,%esp
80104f4b:	89 c3                	mov    %eax,%ebx
80104f4d:	85 c0                	test   %eax,%eax
80104f4f:	0f 84 e4 00 00 00    	je     80105039 <sys_link+0x139>
  ilock(ip);
80104f55:	83 ec 0c             	sub    $0xc,%esp
80104f58:	50                   	push   %eax
80104f59:	e8 c2 c7 ff ff       	call   80101720 <ilock>
  if(ip->type == T_DIR){
80104f5e:	83 c4 10             	add    $0x10,%esp
80104f61:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f66:	0f 84 b5 00 00 00    	je     80105021 <sys_link+0x121>
  iupdate(ip);
80104f6c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80104f6f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80104f74:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104f77:	53                   	push   %ebx
80104f78:	e8 f3 c6 ff ff       	call   80101670 <iupdate>
  iunlock(ip);
80104f7d:	89 1c 24             	mov    %ebx,(%esp)
80104f80:	e8 7b c8 ff ff       	call   80101800 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104f85:	58                   	pop    %eax
80104f86:	5a                   	pop    %edx
80104f87:	57                   	push   %edi
80104f88:	ff 75 d0             	pushl  -0x30(%ebp)
80104f8b:	e8 50 d0 ff ff       	call   80101fe0 <nameiparent>
80104f90:	83 c4 10             	add    $0x10,%esp
80104f93:	89 c6                	mov    %eax,%esi
80104f95:	85 c0                	test   %eax,%eax
80104f97:	74 5b                	je     80104ff4 <sys_link+0xf4>
  ilock(dp);
80104f99:	83 ec 0c             	sub    $0xc,%esp
80104f9c:	50                   	push   %eax
80104f9d:	e8 7e c7 ff ff       	call   80101720 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104fa2:	83 c4 10             	add    $0x10,%esp
80104fa5:	8b 03                	mov    (%ebx),%eax
80104fa7:	39 06                	cmp    %eax,(%esi)
80104fa9:	75 3d                	jne    80104fe8 <sys_link+0xe8>
80104fab:	83 ec 04             	sub    $0x4,%esp
80104fae:	ff 73 04             	pushl  0x4(%ebx)
80104fb1:	57                   	push   %edi
80104fb2:	56                   	push   %esi
80104fb3:	e8 48 cf ff ff       	call   80101f00 <dirlink>
80104fb8:	83 c4 10             	add    $0x10,%esp
80104fbb:	85 c0                	test   %eax,%eax
80104fbd:	78 29                	js     80104fe8 <sys_link+0xe8>
  iunlockput(dp);
80104fbf:	83 ec 0c             	sub    $0xc,%esp
80104fc2:	56                   	push   %esi
80104fc3:	e8 e8 c9 ff ff       	call   801019b0 <iunlockput>
  iput(ip);
80104fc8:	89 1c 24             	mov    %ebx,(%esp)
80104fcb:	e8 80 c8 ff ff       	call   80101850 <iput>
  end_op();
80104fd0:	e8 3b dd ff ff       	call   80102d10 <end_op>
  return 0;
80104fd5:	83 c4 10             	add    $0x10,%esp
80104fd8:	31 c0                	xor    %eax,%eax
}
80104fda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fdd:	5b                   	pop    %ebx
80104fde:	5e                   	pop    %esi
80104fdf:	5f                   	pop    %edi
80104fe0:	5d                   	pop    %ebp
80104fe1:	c3                   	ret    
80104fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104fe8:	83 ec 0c             	sub    $0xc,%esp
80104feb:	56                   	push   %esi
80104fec:	e8 bf c9 ff ff       	call   801019b0 <iunlockput>
    goto bad;
80104ff1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104ff4:	83 ec 0c             	sub    $0xc,%esp
80104ff7:	53                   	push   %ebx
80104ff8:	e8 23 c7 ff ff       	call   80101720 <ilock>
  ip->nlink--;
80104ffd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105002:	89 1c 24             	mov    %ebx,(%esp)
80105005:	e8 66 c6 ff ff       	call   80101670 <iupdate>
  iunlockput(ip);
8010500a:	89 1c 24             	mov    %ebx,(%esp)
8010500d:	e8 9e c9 ff ff       	call   801019b0 <iunlockput>
  end_op();
80105012:	e8 f9 dc ff ff       	call   80102d10 <end_op>
  return -1;
80105017:	83 c4 10             	add    $0x10,%esp
8010501a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010501f:	eb b9                	jmp    80104fda <sys_link+0xda>
    iunlockput(ip);
80105021:	83 ec 0c             	sub    $0xc,%esp
80105024:	53                   	push   %ebx
80105025:	e8 86 c9 ff ff       	call   801019b0 <iunlockput>
    end_op();
8010502a:	e8 e1 dc ff ff       	call   80102d10 <end_op>
    return -1;
8010502f:	83 c4 10             	add    $0x10,%esp
80105032:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105037:	eb a1                	jmp    80104fda <sys_link+0xda>
    end_op();
80105039:	e8 d2 dc ff ff       	call   80102d10 <end_op>
    return -1;
8010503e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105043:	eb 95                	jmp    80104fda <sys_link+0xda>
80105045:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010504c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105050 <sys_unlink>:
{
80105050:	55                   	push   %ebp
80105051:	89 e5                	mov    %esp,%ebp
80105053:	57                   	push   %edi
80105054:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105055:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105058:	53                   	push   %ebx
80105059:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010505c:	50                   	push   %eax
8010505d:	6a 00                	push   $0x0
8010505f:	e8 2c fa ff ff       	call   80104a90 <argstr>
80105064:	83 c4 10             	add    $0x10,%esp
80105067:	85 c0                	test   %eax,%eax
80105069:	0f 88 91 01 00 00    	js     80105200 <sys_unlink+0x1b0>
  begin_op();
8010506f:	e8 2c dc ff ff       	call   80102ca0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105074:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105077:	83 ec 08             	sub    $0x8,%esp
8010507a:	53                   	push   %ebx
8010507b:	ff 75 c0             	pushl  -0x40(%ebp)
8010507e:	e8 5d cf ff ff       	call   80101fe0 <nameiparent>
80105083:	83 c4 10             	add    $0x10,%esp
80105086:	89 c6                	mov    %eax,%esi
80105088:	85 c0                	test   %eax,%eax
8010508a:	0f 84 7a 01 00 00    	je     8010520a <sys_unlink+0x1ba>
  ilock(dp);
80105090:	83 ec 0c             	sub    $0xc,%esp
80105093:	50                   	push   %eax
80105094:	e8 87 c6 ff ff       	call   80101720 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105099:	58                   	pop    %eax
8010509a:	5a                   	pop    %edx
8010509b:	68 c0 79 10 80       	push   $0x801079c0
801050a0:	53                   	push   %ebx
801050a1:	e8 8a cb ff ff       	call   80101c30 <namecmp>
801050a6:	83 c4 10             	add    $0x10,%esp
801050a9:	85 c0                	test   %eax,%eax
801050ab:	0f 84 0f 01 00 00    	je     801051c0 <sys_unlink+0x170>
801050b1:	83 ec 08             	sub    $0x8,%esp
801050b4:	68 bf 79 10 80       	push   $0x801079bf
801050b9:	53                   	push   %ebx
801050ba:	e8 71 cb ff ff       	call   80101c30 <namecmp>
801050bf:	83 c4 10             	add    $0x10,%esp
801050c2:	85 c0                	test   %eax,%eax
801050c4:	0f 84 f6 00 00 00    	je     801051c0 <sys_unlink+0x170>
  if((ip = dirlookup(dp, name, &off)) == 0)
801050ca:	83 ec 04             	sub    $0x4,%esp
801050cd:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801050d0:	50                   	push   %eax
801050d1:	53                   	push   %ebx
801050d2:	56                   	push   %esi
801050d3:	e8 78 cb ff ff       	call   80101c50 <dirlookup>
801050d8:	83 c4 10             	add    $0x10,%esp
801050db:	89 c3                	mov    %eax,%ebx
801050dd:	85 c0                	test   %eax,%eax
801050df:	0f 84 db 00 00 00    	je     801051c0 <sys_unlink+0x170>
  ilock(ip);
801050e5:	83 ec 0c             	sub    $0xc,%esp
801050e8:	50                   	push   %eax
801050e9:	e8 32 c6 ff ff       	call   80101720 <ilock>
  if(ip->nlink < 1)
801050ee:	83 c4 10             	add    $0x10,%esp
801050f1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801050f6:	0f 8e 37 01 00 00    	jle    80105233 <sys_unlink+0x1e3>
  if(ip->type == T_DIR && !isdirempty(ip)){
801050fc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105101:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105104:	74 6a                	je     80105170 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105106:	83 ec 04             	sub    $0x4,%esp
80105109:	6a 10                	push   $0x10
8010510b:	6a 00                	push   $0x0
8010510d:	57                   	push   %edi
8010510e:	e8 ed f5 ff ff       	call   80104700 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105113:	6a 10                	push   $0x10
80105115:	ff 75 c4             	pushl  -0x3c(%ebp)
80105118:	57                   	push   %edi
80105119:	56                   	push   %esi
8010511a:	e8 e1 c9 ff ff       	call   80101b00 <writei>
8010511f:	83 c4 20             	add    $0x20,%esp
80105122:	83 f8 10             	cmp    $0x10,%eax
80105125:	0f 85 fb 00 00 00    	jne    80105226 <sys_unlink+0x1d6>
  if(ip->type == T_DIR){
8010512b:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105130:	0f 84 aa 00 00 00    	je     801051e0 <sys_unlink+0x190>
  iunlockput(dp);
80105136:	83 ec 0c             	sub    $0xc,%esp
80105139:	56                   	push   %esi
8010513a:	e8 71 c8 ff ff       	call   801019b0 <iunlockput>
  ip->nlink--;
8010513f:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105144:	89 1c 24             	mov    %ebx,(%esp)
80105147:	e8 24 c5 ff ff       	call   80101670 <iupdate>
  iunlockput(ip);
8010514c:	89 1c 24             	mov    %ebx,(%esp)
8010514f:	e8 5c c8 ff ff       	call   801019b0 <iunlockput>
  end_op();
80105154:	e8 b7 db ff ff       	call   80102d10 <end_op>
  return 0;
80105159:	83 c4 10             	add    $0x10,%esp
8010515c:	31 c0                	xor    %eax,%eax
}
8010515e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105161:	5b                   	pop    %ebx
80105162:	5e                   	pop    %esi
80105163:	5f                   	pop    %edi
80105164:	5d                   	pop    %ebp
80105165:	c3                   	ret    
80105166:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010516d:	8d 76 00             	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105170:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105174:	76 90                	jbe    80105106 <sys_unlink+0xb6>
80105176:	ba 20 00 00 00       	mov    $0x20,%edx
8010517b:	eb 0f                	jmp    8010518c <sys_unlink+0x13c>
8010517d:	8d 76 00             	lea    0x0(%esi),%esi
80105180:	83 c2 10             	add    $0x10,%edx
80105183:	39 53 58             	cmp    %edx,0x58(%ebx)
80105186:	0f 86 7a ff ff ff    	jbe    80105106 <sys_unlink+0xb6>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010518c:	6a 10                	push   $0x10
8010518e:	52                   	push   %edx
8010518f:	57                   	push   %edi
80105190:	53                   	push   %ebx
80105191:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105194:	e8 67 c8 ff ff       	call   80101a00 <readi>
80105199:	83 c4 10             	add    $0x10,%esp
8010519c:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010519f:	83 f8 10             	cmp    $0x10,%eax
801051a2:	75 75                	jne    80105219 <sys_unlink+0x1c9>
    if(de.inum != 0)
801051a4:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801051a9:	74 d5                	je     80105180 <sys_unlink+0x130>
    iunlockput(ip);
801051ab:	83 ec 0c             	sub    $0xc,%esp
801051ae:	53                   	push   %ebx
801051af:	e8 fc c7 ff ff       	call   801019b0 <iunlockput>
    goto bad;
801051b4:	83 c4 10             	add    $0x10,%esp
801051b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051be:	66 90                	xchg   %ax,%ax
  iunlockput(dp);
801051c0:	83 ec 0c             	sub    $0xc,%esp
801051c3:	56                   	push   %esi
801051c4:	e8 e7 c7 ff ff       	call   801019b0 <iunlockput>
  end_op();
801051c9:	e8 42 db ff ff       	call   80102d10 <end_op>
  return -1;
801051ce:	83 c4 10             	add    $0x10,%esp
801051d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051d6:	eb 86                	jmp    8010515e <sys_unlink+0x10e>
801051d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051df:	90                   	nop
    iupdate(dp);
801051e0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801051e3:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801051e8:	56                   	push   %esi
801051e9:	e8 82 c4 ff ff       	call   80101670 <iupdate>
801051ee:	83 c4 10             	add    $0x10,%esp
801051f1:	e9 40 ff ff ff       	jmp    80105136 <sys_unlink+0xe6>
801051f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105200:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105205:	e9 54 ff ff ff       	jmp    8010515e <sys_unlink+0x10e>
    end_op();
8010520a:	e8 01 db ff ff       	call   80102d10 <end_op>
    return -1;
8010520f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105214:	e9 45 ff ff ff       	jmp    8010515e <sys_unlink+0x10e>
      panic("isdirempty: readi");
80105219:	83 ec 0c             	sub    $0xc,%esp
8010521c:	68 e4 79 10 80       	push   $0x801079e4
80105221:	e8 6a b1 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105226:	83 ec 0c             	sub    $0xc,%esp
80105229:	68 f6 79 10 80       	push   $0x801079f6
8010522e:	e8 5d b1 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105233:	83 ec 0c             	sub    $0xc,%esp
80105236:	68 d2 79 10 80       	push   $0x801079d2
8010523b:	e8 50 b1 ff ff       	call   80100390 <panic>

80105240 <sys_open>:

int
sys_open(void)
{
80105240:	55                   	push   %ebp
80105241:	89 e5                	mov    %esp,%ebp
80105243:	57                   	push   %edi
80105244:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105245:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105248:	53                   	push   %ebx
80105249:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010524c:	50                   	push   %eax
8010524d:	6a 00                	push   $0x0
8010524f:	e8 3c f8 ff ff       	call   80104a90 <argstr>
80105254:	83 c4 10             	add    $0x10,%esp
80105257:	85 c0                	test   %eax,%eax
80105259:	0f 88 8e 00 00 00    	js     801052ed <sys_open+0xad>
8010525f:	83 ec 08             	sub    $0x8,%esp
80105262:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105265:	50                   	push   %eax
80105266:	6a 01                	push   $0x1
80105268:	e8 73 f7 ff ff       	call   801049e0 <argint>
8010526d:	83 c4 10             	add    $0x10,%esp
80105270:	85 c0                	test   %eax,%eax
80105272:	78 79                	js     801052ed <sys_open+0xad>
    return -1;

  begin_op();
80105274:	e8 27 da ff ff       	call   80102ca0 <begin_op>

  if(omode & O_CREATE){
80105279:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010527d:	75 79                	jne    801052f8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010527f:	83 ec 0c             	sub    $0xc,%esp
80105282:	ff 75 e0             	pushl  -0x20(%ebp)
80105285:	e8 36 cd ff ff       	call   80101fc0 <namei>
8010528a:	83 c4 10             	add    $0x10,%esp
8010528d:	89 c6                	mov    %eax,%esi
8010528f:	85 c0                	test   %eax,%eax
80105291:	0f 84 7e 00 00 00    	je     80105315 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105297:	83 ec 0c             	sub    $0xc,%esp
8010529a:	50                   	push   %eax
8010529b:	e8 80 c4 ff ff       	call   80101720 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801052a0:	83 c4 10             	add    $0x10,%esp
801052a3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801052a8:	0f 84 c2 00 00 00    	je     80105370 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801052ae:	e8 4d bb ff ff       	call   80100e00 <filealloc>
801052b3:	89 c7                	mov    %eax,%edi
801052b5:	85 c0                	test   %eax,%eax
801052b7:	74 23                	je     801052dc <sys_open+0x9c>
  struct proc *curproc = myproc();
801052b9:	e8 32 e6 ff ff       	call   801038f0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801052be:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801052c0:	8b 54 98 34          	mov    0x34(%eax,%ebx,4),%edx
801052c4:	85 d2                	test   %edx,%edx
801052c6:	74 60                	je     80105328 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
801052c8:	83 c3 01             	add    $0x1,%ebx
801052cb:	83 fb 10             	cmp    $0x10,%ebx
801052ce:	75 f0                	jne    801052c0 <sys_open+0x80>
    if(f)
      fileclose(f);
801052d0:	83 ec 0c             	sub    $0xc,%esp
801052d3:	57                   	push   %edi
801052d4:	e8 e7 bb ff ff       	call   80100ec0 <fileclose>
801052d9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801052dc:	83 ec 0c             	sub    $0xc,%esp
801052df:	56                   	push   %esi
801052e0:	e8 cb c6 ff ff       	call   801019b0 <iunlockput>
    end_op();
801052e5:	e8 26 da ff ff       	call   80102d10 <end_op>
    return -1;
801052ea:	83 c4 10             	add    $0x10,%esp
801052ed:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801052f2:	eb 6d                	jmp    80105361 <sys_open+0x121>
801052f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801052f8:	83 ec 0c             	sub    $0xc,%esp
801052fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801052fe:	31 c9                	xor    %ecx,%ecx
80105300:	ba 02 00 00 00       	mov    $0x2,%edx
80105305:	6a 00                	push   $0x0
80105307:	e8 24 f8 ff ff       	call   80104b30 <create>
    if(ip == 0){
8010530c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010530f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105311:	85 c0                	test   %eax,%eax
80105313:	75 99                	jne    801052ae <sys_open+0x6e>
      end_op();
80105315:	e8 f6 d9 ff ff       	call   80102d10 <end_op>
      return -1;
8010531a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010531f:	eb 40                	jmp    80105361 <sys_open+0x121>
80105321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105328:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010532b:	89 7c 98 34          	mov    %edi,0x34(%eax,%ebx,4)
  iunlock(ip);
8010532f:	56                   	push   %esi
80105330:	e8 cb c4 ff ff       	call   80101800 <iunlock>
  end_op();
80105335:	e8 d6 d9 ff ff       	call   80102d10 <end_op>

  f->type = FD_INODE;
8010533a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105340:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105343:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105346:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105349:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010534b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105352:	f7 d0                	not    %eax
80105354:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105357:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010535a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010535d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105361:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105364:	89 d8                	mov    %ebx,%eax
80105366:	5b                   	pop    %ebx
80105367:	5e                   	pop    %esi
80105368:	5f                   	pop    %edi
80105369:	5d                   	pop    %ebp
8010536a:	c3                   	ret    
8010536b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010536f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105370:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105373:	85 c9                	test   %ecx,%ecx
80105375:	0f 84 33 ff ff ff    	je     801052ae <sys_open+0x6e>
8010537b:	e9 5c ff ff ff       	jmp    801052dc <sys_open+0x9c>

80105380 <sys_mkdir>:

int
sys_mkdir(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105386:	e8 15 d9 ff ff       	call   80102ca0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010538b:	83 ec 08             	sub    $0x8,%esp
8010538e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105391:	50                   	push   %eax
80105392:	6a 00                	push   $0x0
80105394:	e8 f7 f6 ff ff       	call   80104a90 <argstr>
80105399:	83 c4 10             	add    $0x10,%esp
8010539c:	85 c0                	test   %eax,%eax
8010539e:	78 30                	js     801053d0 <sys_mkdir+0x50>
801053a0:	83 ec 0c             	sub    $0xc,%esp
801053a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053a6:	31 c9                	xor    %ecx,%ecx
801053a8:	ba 01 00 00 00       	mov    $0x1,%edx
801053ad:	6a 00                	push   $0x0
801053af:	e8 7c f7 ff ff       	call   80104b30 <create>
801053b4:	83 c4 10             	add    $0x10,%esp
801053b7:	85 c0                	test   %eax,%eax
801053b9:	74 15                	je     801053d0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053bb:	83 ec 0c             	sub    $0xc,%esp
801053be:	50                   	push   %eax
801053bf:	e8 ec c5 ff ff       	call   801019b0 <iunlockput>
  end_op();
801053c4:	e8 47 d9 ff ff       	call   80102d10 <end_op>
  return 0;
801053c9:	83 c4 10             	add    $0x10,%esp
801053cc:	31 c0                	xor    %eax,%eax
}
801053ce:	c9                   	leave  
801053cf:	c3                   	ret    
    end_op();
801053d0:	e8 3b d9 ff ff       	call   80102d10 <end_op>
    return -1;
801053d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053da:	c9                   	leave  
801053db:	c3                   	ret    
801053dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053e0 <sys_mknod>:

int
sys_mknod(void)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801053e6:	e8 b5 d8 ff ff       	call   80102ca0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801053eb:	83 ec 08             	sub    $0x8,%esp
801053ee:	8d 45 ec             	lea    -0x14(%ebp),%eax
801053f1:	50                   	push   %eax
801053f2:	6a 00                	push   $0x0
801053f4:	e8 97 f6 ff ff       	call   80104a90 <argstr>
801053f9:	83 c4 10             	add    $0x10,%esp
801053fc:	85 c0                	test   %eax,%eax
801053fe:	78 60                	js     80105460 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105400:	83 ec 08             	sub    $0x8,%esp
80105403:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105406:	50                   	push   %eax
80105407:	6a 01                	push   $0x1
80105409:	e8 d2 f5 ff ff       	call   801049e0 <argint>
  if((argstr(0, &path)) < 0 ||
8010540e:	83 c4 10             	add    $0x10,%esp
80105411:	85 c0                	test   %eax,%eax
80105413:	78 4b                	js     80105460 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105415:	83 ec 08             	sub    $0x8,%esp
80105418:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010541b:	50                   	push   %eax
8010541c:	6a 02                	push   $0x2
8010541e:	e8 bd f5 ff ff       	call   801049e0 <argint>
     argint(1, &major) < 0 ||
80105423:	83 c4 10             	add    $0x10,%esp
80105426:	85 c0                	test   %eax,%eax
80105428:	78 36                	js     80105460 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010542a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010542e:	83 ec 0c             	sub    $0xc,%esp
80105431:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105435:	ba 03 00 00 00       	mov    $0x3,%edx
8010543a:	50                   	push   %eax
8010543b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010543e:	e8 ed f6 ff ff       	call   80104b30 <create>
     argint(2, &minor) < 0 ||
80105443:	83 c4 10             	add    $0x10,%esp
80105446:	85 c0                	test   %eax,%eax
80105448:	74 16                	je     80105460 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010544a:	83 ec 0c             	sub    $0xc,%esp
8010544d:	50                   	push   %eax
8010544e:	e8 5d c5 ff ff       	call   801019b0 <iunlockput>
  end_op();
80105453:	e8 b8 d8 ff ff       	call   80102d10 <end_op>
  return 0;
80105458:	83 c4 10             	add    $0x10,%esp
8010545b:	31 c0                	xor    %eax,%eax
}
8010545d:	c9                   	leave  
8010545e:	c3                   	ret    
8010545f:	90                   	nop
    end_op();
80105460:	e8 ab d8 ff ff       	call   80102d10 <end_op>
    return -1;
80105465:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010546a:	c9                   	leave  
8010546b:	c3                   	ret    
8010546c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105470 <sys_chdir>:

int
sys_chdir(void)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	56                   	push   %esi
80105474:	53                   	push   %ebx
80105475:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105478:	e8 73 e4 ff ff       	call   801038f0 <myproc>
8010547d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010547f:	e8 1c d8 ff ff       	call   80102ca0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105484:	83 ec 08             	sub    $0x8,%esp
80105487:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010548a:	50                   	push   %eax
8010548b:	6a 00                	push   $0x0
8010548d:	e8 fe f5 ff ff       	call   80104a90 <argstr>
80105492:	83 c4 10             	add    $0x10,%esp
80105495:	85 c0                	test   %eax,%eax
80105497:	78 77                	js     80105510 <sys_chdir+0xa0>
80105499:	83 ec 0c             	sub    $0xc,%esp
8010549c:	ff 75 f4             	pushl  -0xc(%ebp)
8010549f:	e8 1c cb ff ff       	call   80101fc0 <namei>
801054a4:	83 c4 10             	add    $0x10,%esp
801054a7:	89 c3                	mov    %eax,%ebx
801054a9:	85 c0                	test   %eax,%eax
801054ab:	74 63                	je     80105510 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801054ad:	83 ec 0c             	sub    $0xc,%esp
801054b0:	50                   	push   %eax
801054b1:	e8 6a c2 ff ff       	call   80101720 <ilock>
  if(ip->type != T_DIR){
801054b6:	83 c4 10             	add    $0x10,%esp
801054b9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054be:	75 30                	jne    801054f0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054c0:	83 ec 0c             	sub    $0xc,%esp
801054c3:	53                   	push   %ebx
801054c4:	e8 37 c3 ff ff       	call   80101800 <iunlock>
  iput(curproc->cwd);
801054c9:	58                   	pop    %eax
801054ca:	ff 76 74             	pushl  0x74(%esi)
801054cd:	e8 7e c3 ff ff       	call   80101850 <iput>
  end_op();
801054d2:	e8 39 d8 ff ff       	call   80102d10 <end_op>
  curproc->cwd = ip;
801054d7:	89 5e 74             	mov    %ebx,0x74(%esi)
  return 0;
801054da:	83 c4 10             	add    $0x10,%esp
801054dd:	31 c0                	xor    %eax,%eax
}
801054df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054e2:	5b                   	pop    %ebx
801054e3:	5e                   	pop    %esi
801054e4:	5d                   	pop    %ebp
801054e5:	c3                   	ret    
801054e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054ed:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
801054f0:	83 ec 0c             	sub    $0xc,%esp
801054f3:	53                   	push   %ebx
801054f4:	e8 b7 c4 ff ff       	call   801019b0 <iunlockput>
    end_op();
801054f9:	e8 12 d8 ff ff       	call   80102d10 <end_op>
    return -1;
801054fe:	83 c4 10             	add    $0x10,%esp
80105501:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105506:	eb d7                	jmp    801054df <sys_chdir+0x6f>
80105508:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010550f:	90                   	nop
    end_op();
80105510:	e8 fb d7 ff ff       	call   80102d10 <end_op>
    return -1;
80105515:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010551a:	eb c3                	jmp    801054df <sys_chdir+0x6f>
8010551c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105520 <sys_exec>:

int
sys_exec(void)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	57                   	push   %edi
80105524:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105525:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010552b:	53                   	push   %ebx
8010552c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105532:	50                   	push   %eax
80105533:	6a 00                	push   $0x0
80105535:	e8 56 f5 ff ff       	call   80104a90 <argstr>
8010553a:	83 c4 10             	add    $0x10,%esp
8010553d:	85 c0                	test   %eax,%eax
8010553f:	0f 88 87 00 00 00    	js     801055cc <sys_exec+0xac>
80105545:	83 ec 08             	sub    $0x8,%esp
80105548:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010554e:	50                   	push   %eax
8010554f:	6a 01                	push   $0x1
80105551:	e8 8a f4 ff ff       	call   801049e0 <argint>
80105556:	83 c4 10             	add    $0x10,%esp
80105559:	85 c0                	test   %eax,%eax
8010555b:	78 6f                	js     801055cc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010555d:	83 ec 04             	sub    $0x4,%esp
80105560:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80105566:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105568:	68 80 00 00 00       	push   $0x80
8010556d:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105573:	6a 00                	push   $0x0
80105575:	50                   	push   %eax
80105576:	e8 85 f1 ff ff       	call   80104700 <memset>
8010557b:	83 c4 10             	add    $0x10,%esp
8010557e:	66 90                	xchg   %ax,%ax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105580:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105586:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
8010558d:	83 ec 08             	sub    $0x8,%esp
80105590:	57                   	push   %edi
80105591:	01 f0                	add    %esi,%eax
80105593:	50                   	push   %eax
80105594:	e8 a7 f3 ff ff       	call   80104940 <fetchint>
80105599:	83 c4 10             	add    $0x10,%esp
8010559c:	85 c0                	test   %eax,%eax
8010559e:	78 2c                	js     801055cc <sys_exec+0xac>
      return -1;
    if(uarg == 0){
801055a0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801055a6:	85 c0                	test   %eax,%eax
801055a8:	74 36                	je     801055e0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801055aa:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801055b0:	83 ec 08             	sub    $0x8,%esp
801055b3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801055b6:	52                   	push   %edx
801055b7:	50                   	push   %eax
801055b8:	e8 c3 f3 ff ff       	call   80104980 <fetchstr>
801055bd:	83 c4 10             	add    $0x10,%esp
801055c0:	85 c0                	test   %eax,%eax
801055c2:	78 08                	js     801055cc <sys_exec+0xac>
  for(i=0;; i++){
801055c4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801055c7:	83 fb 20             	cmp    $0x20,%ebx
801055ca:	75 b4                	jne    80105580 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801055cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801055cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055d4:	5b                   	pop    %ebx
801055d5:	5e                   	pop    %esi
801055d6:	5f                   	pop    %edi
801055d7:	5d                   	pop    %ebp
801055d8:	c3                   	ret    
801055d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801055e0:	83 ec 08             	sub    $0x8,%esp
801055e3:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
801055e9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801055f0:	00 00 00 00 
  return exec(path, argv);
801055f4:	50                   	push   %eax
801055f5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801055fb:	e8 80 b4 ff ff       	call   80100a80 <exec>
80105600:	83 c4 10             	add    $0x10,%esp
}
80105603:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105606:	5b                   	pop    %ebx
80105607:	5e                   	pop    %esi
80105608:	5f                   	pop    %edi
80105609:	5d                   	pop    %ebp
8010560a:	c3                   	ret    
8010560b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010560f:	90                   	nop

80105610 <sys_pipe>:

int
sys_pipe(void)
{
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	57                   	push   %edi
80105614:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105615:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105618:	53                   	push   %ebx
80105619:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010561c:	6a 08                	push   $0x8
8010561e:	50                   	push   %eax
8010561f:	6a 00                	push   $0x0
80105621:	e8 0a f4 ff ff       	call   80104a30 <argptr>
80105626:	83 c4 10             	add    $0x10,%esp
80105629:	85 c0                	test   %eax,%eax
8010562b:	78 4a                	js     80105677 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010562d:	83 ec 08             	sub    $0x8,%esp
80105630:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105633:	50                   	push   %eax
80105634:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105637:	50                   	push   %eax
80105638:	e8 13 dd ff ff       	call   80103350 <pipealloc>
8010563d:	83 c4 10             	add    $0x10,%esp
80105640:	85 c0                	test   %eax,%eax
80105642:	78 33                	js     80105677 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105644:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105647:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105649:	e8 a2 e2 ff ff       	call   801038f0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010564e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105650:	8b 74 98 34          	mov    0x34(%eax,%ebx,4),%esi
80105654:	85 f6                	test   %esi,%esi
80105656:	74 28                	je     80105680 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105658:	83 c3 01             	add    $0x1,%ebx
8010565b:	83 fb 10             	cmp    $0x10,%ebx
8010565e:	75 f0                	jne    80105650 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105660:	83 ec 0c             	sub    $0xc,%esp
80105663:	ff 75 e0             	pushl  -0x20(%ebp)
80105666:	e8 55 b8 ff ff       	call   80100ec0 <fileclose>
    fileclose(wf);
8010566b:	58                   	pop    %eax
8010566c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010566f:	e8 4c b8 ff ff       	call   80100ec0 <fileclose>
    return -1;
80105674:	83 c4 10             	add    $0x10,%esp
80105677:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010567c:	eb 53                	jmp    801056d1 <sys_pipe+0xc1>
8010567e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105680:	8d 73 0c             	lea    0xc(%ebx),%esi
80105683:	89 7c b0 04          	mov    %edi,0x4(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105687:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010568a:	e8 61 e2 ff ff       	call   801038f0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010568f:	31 d2                	xor    %edx,%edx
80105691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105698:	8b 4c 90 34          	mov    0x34(%eax,%edx,4),%ecx
8010569c:	85 c9                	test   %ecx,%ecx
8010569e:	74 20                	je     801056c0 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
801056a0:	83 c2 01             	add    $0x1,%edx
801056a3:	83 fa 10             	cmp    $0x10,%edx
801056a6:	75 f0                	jne    80105698 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
801056a8:	e8 43 e2 ff ff       	call   801038f0 <myproc>
801056ad:	c7 44 b0 04 00 00 00 	movl   $0x0,0x4(%eax,%esi,4)
801056b4:	00 
801056b5:	eb a9                	jmp    80105660 <sys_pipe+0x50>
801056b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056be:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801056c0:	89 7c 90 34          	mov    %edi,0x34(%eax,%edx,4)
  }
  fd[0] = fd0;
801056c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056c7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801056c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056cc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801056cf:	31 c0                	xor    %eax,%eax
}
801056d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056d4:	5b                   	pop    %ebx
801056d5:	5e                   	pop    %esi
801056d6:	5f                   	pop    %edi
801056d7:	5d                   	pop    %ebp
801056d8:	c3                   	ret    
801056d9:	66 90                	xchg   %ax,%ax
801056db:	66 90                	xchg   %ax,%ax
801056dd:	66 90                	xchg   %ax,%ax
801056df:	90                   	nop

801056e0 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801056e0:	e9 ab e3 ff ff       	jmp    80103a90 <fork>
801056e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056f0 <sys_exit>:
}

int
sys_exit(void)
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	83 ec 08             	sub    $0x8,%esp
  exit();
801056f6:	e8 15 e6 ff ff       	call   80103d10 <exit>
  return 0;  // not reached
}
801056fb:	31 c0                	xor    %eax,%eax
801056fd:	c9                   	leave  
801056fe:	c3                   	ret    
801056ff:	90                   	nop

80105700 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105700:	e9 4b e8 ff ff       	jmp    80103f50 <wait>
80105705:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010570c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105710 <sys_kill>:
}

int
sys_kill(void)
{
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105716:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105719:	50                   	push   %eax
8010571a:	6a 00                	push   $0x0
8010571c:	e8 bf f2 ff ff       	call   801049e0 <argint>
80105721:	83 c4 10             	add    $0x10,%esp
80105724:	85 c0                	test   %eax,%eax
80105726:	78 18                	js     80105740 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105728:	83 ec 0c             	sub    $0xc,%esp
8010572b:	ff 75 f4             	pushl  -0xc(%ebp)
8010572e:	e8 7d e9 ff ff       	call   801040b0 <kill>
80105733:	83 c4 10             	add    $0x10,%esp
}
80105736:	c9                   	leave  
80105737:	c3                   	ret    
80105738:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010573f:	90                   	nop
80105740:	c9                   	leave  
    return -1;
80105741:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105746:	c3                   	ret    
80105747:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010574e:	66 90                	xchg   %ax,%ax

80105750 <sys_getpid>:

int
sys_getpid(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105756:	e8 95 e1 ff ff       	call   801038f0 <myproc>
8010575b:	8b 40 1c             	mov    0x1c(%eax),%eax
}
8010575e:	c9                   	leave  
8010575f:	c3                   	ret    

80105760 <sys_sbrk>:

int
sys_sbrk(void)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105764:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105767:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010576a:	50                   	push   %eax
8010576b:	6a 00                	push   $0x0
8010576d:	e8 6e f2 ff ff       	call   801049e0 <argint>
80105772:	83 c4 10             	add    $0x10,%esp
80105775:	85 c0                	test   %eax,%eax
80105777:	78 27                	js     801057a0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105779:	e8 72 e1 ff ff       	call   801038f0 <myproc>
  if(growproc(n) < 0)
8010577e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105781:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105783:	ff 75 f4             	pushl  -0xc(%ebp)
80105786:	e8 85 e2 ff ff       	call   80103a10 <growproc>
8010578b:	83 c4 10             	add    $0x10,%esp
8010578e:	85 c0                	test   %eax,%eax
80105790:	78 0e                	js     801057a0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105792:	89 d8                	mov    %ebx,%eax
80105794:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105797:	c9                   	leave  
80105798:	c3                   	ret    
80105799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801057a0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801057a5:	eb eb                	jmp    80105792 <sys_sbrk+0x32>
801057a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057ae:	66 90                	xchg   %ax,%ax

801057b0 <sys_sleep>:

int
sys_sleep(void)
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801057b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801057b7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801057ba:	50                   	push   %eax
801057bb:	6a 00                	push   $0x0
801057bd:	e8 1e f2 ff ff       	call   801049e0 <argint>
801057c2:	83 c4 10             	add    $0x10,%esp
801057c5:	85 c0                	test   %eax,%eax
801057c7:	0f 88 8a 00 00 00    	js     80105857 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801057cd:	83 ec 0c             	sub    $0xc,%esp
801057d0:	68 60 4f 11 80       	push   $0x80114f60
801057d5:	e8 b6 ed ff ff       	call   80104590 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801057da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801057dd:	8b 1d a0 57 11 80    	mov    0x801157a0,%ebx
  while(ticks - ticks0 < n){
801057e3:	83 c4 10             	add    $0x10,%esp
801057e6:	85 d2                	test   %edx,%edx
801057e8:	75 27                	jne    80105811 <sys_sleep+0x61>
801057ea:	eb 54                	jmp    80105840 <sys_sleep+0x90>
801057ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801057f0:	83 ec 08             	sub    $0x8,%esp
801057f3:	68 60 4f 11 80       	push   $0x80114f60
801057f8:	68 a0 57 11 80       	push   $0x801157a0
801057fd:	e8 8e e6 ff ff       	call   80103e90 <sleep>
  while(ticks - ticks0 < n){
80105802:	a1 a0 57 11 80       	mov    0x801157a0,%eax
80105807:	83 c4 10             	add    $0x10,%esp
8010580a:	29 d8                	sub    %ebx,%eax
8010580c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010580f:	73 2f                	jae    80105840 <sys_sleep+0x90>
    if(myproc()->killed){
80105811:	e8 da e0 ff ff       	call   801038f0 <myproc>
80105816:	8b 40 30             	mov    0x30(%eax),%eax
80105819:	85 c0                	test   %eax,%eax
8010581b:	74 d3                	je     801057f0 <sys_sleep+0x40>
      release(&tickslock);
8010581d:	83 ec 0c             	sub    $0xc,%esp
80105820:	68 60 4f 11 80       	push   $0x80114f60
80105825:	e8 86 ee ff ff       	call   801046b0 <release>
      return -1;
8010582a:	83 c4 10             	add    $0x10,%esp
8010582d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105832:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105835:	c9                   	leave  
80105836:	c3                   	ret    
80105837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010583e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105840:	83 ec 0c             	sub    $0xc,%esp
80105843:	68 60 4f 11 80       	push   $0x80114f60
80105848:	e8 63 ee ff ff       	call   801046b0 <release>
  return 0;
8010584d:	83 c4 10             	add    $0x10,%esp
80105850:	31 c0                	xor    %eax,%eax
}
80105852:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105855:	c9                   	leave  
80105856:	c3                   	ret    
    return -1;
80105857:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010585c:	eb f4                	jmp    80105852 <sys_sleep+0xa2>
8010585e:	66 90                	xchg   %ax,%ax

80105860 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	53                   	push   %ebx
80105864:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105867:	68 60 4f 11 80       	push   $0x80114f60
8010586c:	e8 1f ed ff ff       	call   80104590 <acquire>
  xticks = ticks;
80105871:	8b 1d a0 57 11 80    	mov    0x801157a0,%ebx
  release(&tickslock);
80105877:	c7 04 24 60 4f 11 80 	movl   $0x80114f60,(%esp)
8010587e:	e8 2d ee ff ff       	call   801046b0 <release>
  return xticks;
}
80105883:	89 d8                	mov    %ebx,%eax
80105885:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105888:	c9                   	leave  
80105889:	c3                   	ret    
8010588a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105890 <sys_date>:
int
sys_date (void)
{
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	83 ec 1c             	sub    $0x1c,%esp
	struct rtcdate *d;

	if(argptr(0, (void*)&d, sizeof(struct rtcdate)) < 0)
80105896:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105899:	6a 18                	push   $0x18
8010589b:	50                   	push   %eax
8010589c:	6a 00                	push   $0x0
8010589e:	e8 8d f1 ff ff       	call   80104a30 <argptr>
801058a3:	83 c4 10             	add    $0x10,%esp
801058a6:	85 c0                	test   %eax,%eax
801058a8:	78 16                	js     801058c0 <sys_date+0x30>
	{
		return -1;
	}

	cmostime(d);
801058aa:	83 ec 0c             	sub    $0xc,%esp
801058ad:	ff 75 f4             	pushl  -0xc(%ebp)
801058b0:	e8 5b d0 ff ff       	call   80102910 <cmostime>
	return 0;
801058b5:	83 c4 10             	add    $0x10,%esp
801058b8:	31 c0                	xor    %eax,%eax
}
801058ba:	c9                   	leave  
801058bb:	c3                   	ret    
801058bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058c0:	c9                   	leave  
		return -1;
801058c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058c6:	c3                   	ret    
801058c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058ce:	66 90                	xchg   %ax,%ax

801058d0 <sys_cps>:
int
sys_cps(void)
{
  return cps();
801058d0:	e9 3b e9 ff ff       	jmp    80104210 <cps>
801058d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058e0 <sys_nps>:
}
int
sys_nps(void)
{
  return nps();
801058e0:	e9 1b ea ff ff       	jmp    80104300 <nps>

801058e5 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801058e5:	1e                   	push   %ds
  pushl %es
801058e6:	06                   	push   %es
  pushl %fs
801058e7:	0f a0                	push   %fs
  pushl %gs
801058e9:	0f a8                	push   %gs
  pushal
801058eb:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801058ec:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801058f0:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801058f2:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801058f4:	54                   	push   %esp
  call trap
801058f5:	e8 c6 00 00 00       	call   801059c0 <trap>
  addl $4, %esp
801058fa:	83 c4 04             	add    $0x4,%esp

801058fd <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801058fd:	61                   	popa   
  popl %gs
801058fe:	0f a9                	pop    %gs
  popl %fs
80105900:	0f a1                	pop    %fs
  popl %es
80105902:	07                   	pop    %es
  popl %ds
80105903:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105904:	83 c4 08             	add    $0x8,%esp
  iret
80105907:	cf                   	iret   
80105908:	66 90                	xchg   %ax,%ax
8010590a:	66 90                	xchg   %ax,%ax
8010590c:	66 90                	xchg   %ax,%ax
8010590e:	66 90                	xchg   %ax,%ax

80105910 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105910:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105911:	31 c0                	xor    %eax,%eax
{
80105913:	89 e5                	mov    %esp,%ebp
80105915:	83 ec 08             	sub    $0x8,%esp
80105918:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010591f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105920:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105927:	c7 04 c5 a2 4f 11 80 	movl   $0x8e000008,-0x7feeb05e(,%eax,8)
8010592e:	08 00 00 8e 
80105932:	66 89 14 c5 a0 4f 11 	mov    %dx,-0x7feeb060(,%eax,8)
80105939:	80 
8010593a:	c1 ea 10             	shr    $0x10,%edx
8010593d:	66 89 14 c5 a6 4f 11 	mov    %dx,-0x7feeb05a(,%eax,8)
80105944:	80 
  for(i = 0; i < 256; i++)
80105945:	83 c0 01             	add    $0x1,%eax
80105948:	3d 00 01 00 00       	cmp    $0x100,%eax
8010594d:	75 d1                	jne    80105920 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010594f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105952:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105957:	c7 05 a2 51 11 80 08 	movl   $0xef000008,0x801151a2
8010595e:	00 00 ef 
  initlock(&tickslock, "time");
80105961:	68 05 7a 10 80       	push   $0x80107a05
80105966:	68 60 4f 11 80       	push   $0x80114f60
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010596b:	66 a3 a0 51 11 80    	mov    %ax,0x801151a0
80105971:	c1 e8 10             	shr    $0x10,%eax
80105974:	66 a3 a6 51 11 80    	mov    %ax,0x801151a6
  initlock(&tickslock, "time");
8010597a:	e8 11 eb ff ff       	call   80104490 <initlock>
}
8010597f:	83 c4 10             	add    $0x10,%esp
80105982:	c9                   	leave  
80105983:	c3                   	ret    
80105984:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010598b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010598f:	90                   	nop

80105990 <idtinit>:

void
idtinit(void)
{
80105990:	55                   	push   %ebp
  pd[0] = size-1;
80105991:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105996:	89 e5                	mov    %esp,%ebp
80105998:	83 ec 10             	sub    $0x10,%esp
8010599b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010599f:	b8 a0 4f 11 80       	mov    $0x80114fa0,%eax
801059a4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801059a8:	c1 e8 10             	shr    $0x10,%eax
801059ab:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801059af:	8d 45 fa             	lea    -0x6(%ebp),%eax
801059b2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801059b5:	c9                   	leave  
801059b6:	c3                   	ret    
801059b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059be:	66 90                	xchg   %ax,%ax

801059c0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801059c0:	55                   	push   %ebp
801059c1:	89 e5                	mov    %esp,%ebp
801059c3:	57                   	push   %edi
801059c4:	56                   	push   %esi
801059c5:	53                   	push   %ebx
801059c6:	83 ec 1c             	sub    $0x1c,%esp
801059c9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801059cc:	8b 47 30             	mov    0x30(%edi),%eax
801059cf:	83 f8 40             	cmp    $0x40,%eax
801059d2:	0f 84 b8 01 00 00    	je     80105b90 <trap+0x1d0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801059d8:	83 e8 20             	sub    $0x20,%eax
801059db:	83 f8 1f             	cmp    $0x1f,%eax
801059de:	77 10                	ja     801059f0 <trap+0x30>
801059e0:	ff 24 85 ac 7a 10 80 	jmp    *-0x7fef8554(,%eax,4)
801059e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ee:	66 90                	xchg   %ax,%ax
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801059f0:	e8 fb de ff ff       	call   801038f0 <myproc>
801059f5:	8b 5f 38             	mov    0x38(%edi),%ebx
801059f8:	85 c0                	test   %eax,%eax
801059fa:	0f 84 17 02 00 00    	je     80105c17 <trap+0x257>
80105a00:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105a04:	0f 84 0d 02 00 00    	je     80105c17 <trap+0x257>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105a0a:	0f 20 d1             	mov    %cr2,%ecx
80105a0d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a10:	e8 bb de ff ff       	call   801038d0 <cpuid>
80105a15:	8b 77 30             	mov    0x30(%edi),%esi
80105a18:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105a1b:	8b 47 34             	mov    0x34(%edi),%eax
80105a1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105a21:	e8 ca de ff ff       	call   801038f0 <myproc>
80105a26:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105a29:	e8 c2 de ff ff       	call   801038f0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a2e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105a31:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105a34:	51                   	push   %ecx
80105a35:	53                   	push   %ebx
80105a36:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105a37:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a3a:	ff 75 e4             	pushl  -0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105a3d:	83 c2 78             	add    $0x78,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a40:	56                   	push   %esi
80105a41:	52                   	push   %edx
80105a42:	ff 70 1c             	pushl  0x1c(%eax)
80105a45:	68 68 7a 10 80       	push   $0x80107a68
80105a4a:	e8 61 ac ff ff       	call   801006b0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105a4f:	83 c4 20             	add    $0x20,%esp
80105a52:	e8 99 de ff ff       	call   801038f0 <myproc>
80105a57:	c7 40 30 01 00 00 00 	movl   $0x1,0x30(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a5e:	e8 8d de ff ff       	call   801038f0 <myproc>
80105a63:	85 c0                	test   %eax,%eax
80105a65:	74 1d                	je     80105a84 <trap+0xc4>
80105a67:	e8 84 de ff ff       	call   801038f0 <myproc>
80105a6c:	8b 50 30             	mov    0x30(%eax),%edx
80105a6f:	85 d2                	test   %edx,%edx
80105a71:	74 11                	je     80105a84 <trap+0xc4>
80105a73:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105a77:	83 e0 03             	and    $0x3,%eax
80105a7a:	66 83 f8 03          	cmp    $0x3,%ax
80105a7e:	0f 84 44 01 00 00    	je     80105bc8 <trap+0x208>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105a84:	e8 67 de ff ff       	call   801038f0 <myproc>
80105a89:	85 c0                	test   %eax,%eax
80105a8b:	74 0b                	je     80105a98 <trap+0xd8>
80105a8d:	e8 5e de ff ff       	call   801038f0 <myproc>
80105a92:	83 78 18 04          	cmpl   $0x4,0x18(%eax)
80105a96:	74 38                	je     80105ad0 <trap+0x110>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a98:	e8 53 de ff ff       	call   801038f0 <myproc>
80105a9d:	85 c0                	test   %eax,%eax
80105a9f:	74 1d                	je     80105abe <trap+0xfe>
80105aa1:	e8 4a de ff ff       	call   801038f0 <myproc>
80105aa6:	8b 40 30             	mov    0x30(%eax),%eax
80105aa9:	85 c0                	test   %eax,%eax
80105aab:	74 11                	je     80105abe <trap+0xfe>
80105aad:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105ab1:	83 e0 03             	and    $0x3,%eax
80105ab4:	66 83 f8 03          	cmp    $0x3,%ax
80105ab8:	0f 84 fb 00 00 00    	je     80105bb9 <trap+0x1f9>
    exit();
}
80105abe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ac1:	5b                   	pop    %ebx
80105ac2:	5e                   	pop    %esi
80105ac3:	5f                   	pop    %edi
80105ac4:	5d                   	pop    %ebp
80105ac5:	c3                   	ret    
80105ac6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105acd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105ad0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105ad4:	75 c2                	jne    80105a98 <trap+0xd8>
    yield();
80105ad6:	e8 65 e3 ff ff       	call   80103e40 <yield>
80105adb:	eb bb                	jmp    80105a98 <trap+0xd8>
80105add:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105ae0:	e8 eb dd ff ff       	call   801038d0 <cpuid>
80105ae5:	85 c0                	test   %eax,%eax
80105ae7:	0f 84 eb 00 00 00    	je     80105bd8 <trap+0x218>
    lapiceoi();
80105aed:	e8 5e cd ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105af2:	e8 f9 dd ff ff       	call   801038f0 <myproc>
80105af7:	85 c0                	test   %eax,%eax
80105af9:	0f 85 68 ff ff ff    	jne    80105a67 <trap+0xa7>
80105aff:	eb 83                	jmp    80105a84 <trap+0xc4>
80105b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105b08:	e8 03 cc ff ff       	call   80102710 <kbdintr>
    lapiceoi();
80105b0d:	e8 3e cd ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b12:	e8 d9 dd ff ff       	call   801038f0 <myproc>
80105b17:	85 c0                	test   %eax,%eax
80105b19:	0f 85 48 ff ff ff    	jne    80105a67 <trap+0xa7>
80105b1f:	e9 60 ff ff ff       	jmp    80105a84 <trap+0xc4>
80105b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105b28:	e8 83 02 00 00       	call   80105db0 <uartintr>
    lapiceoi();
80105b2d:	e8 1e cd ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b32:	e8 b9 dd ff ff       	call   801038f0 <myproc>
80105b37:	85 c0                	test   %eax,%eax
80105b39:	0f 85 28 ff ff ff    	jne    80105a67 <trap+0xa7>
80105b3f:	e9 40 ff ff ff       	jmp    80105a84 <trap+0xc4>
80105b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b48:	8b 77 38             	mov    0x38(%edi),%esi
80105b4b:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105b4f:	e8 7c dd ff ff       	call   801038d0 <cpuid>
80105b54:	56                   	push   %esi
80105b55:	53                   	push   %ebx
80105b56:	50                   	push   %eax
80105b57:	68 10 7a 10 80       	push   $0x80107a10
80105b5c:	e8 4f ab ff ff       	call   801006b0 <cprintf>
    lapiceoi();
80105b61:	e8 ea cc ff ff       	call   80102850 <lapiceoi>
    break;
80105b66:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b69:	e8 82 dd ff ff       	call   801038f0 <myproc>
80105b6e:	85 c0                	test   %eax,%eax
80105b70:	0f 85 f1 fe ff ff    	jne    80105a67 <trap+0xa7>
80105b76:	e9 09 ff ff ff       	jmp    80105a84 <trap+0xc4>
80105b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b7f:	90                   	nop
    ideintr();
80105b80:	e8 db c5 ff ff       	call   80102160 <ideintr>
80105b85:	e9 63 ff ff ff       	jmp    80105aed <trap+0x12d>
80105b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105b90:	e8 5b dd ff ff       	call   801038f0 <myproc>
80105b95:	8b 58 30             	mov    0x30(%eax),%ebx
80105b98:	85 db                	test   %ebx,%ebx
80105b9a:	75 74                	jne    80105c10 <trap+0x250>
    myproc()->tf = tf;
80105b9c:	e8 4f dd ff ff       	call   801038f0 <myproc>
80105ba1:	89 78 24             	mov    %edi,0x24(%eax)
    syscall();
80105ba4:	e8 27 ef ff ff       	call   80104ad0 <syscall>
    if(myproc()->killed)
80105ba9:	e8 42 dd ff ff       	call   801038f0 <myproc>
80105bae:	8b 48 30             	mov    0x30(%eax),%ecx
80105bb1:	85 c9                	test   %ecx,%ecx
80105bb3:	0f 84 05 ff ff ff    	je     80105abe <trap+0xfe>
}
80105bb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bbc:	5b                   	pop    %ebx
80105bbd:	5e                   	pop    %esi
80105bbe:	5f                   	pop    %edi
80105bbf:	5d                   	pop    %ebp
      exit();
80105bc0:	e9 4b e1 ff ff       	jmp    80103d10 <exit>
80105bc5:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80105bc8:	e8 43 e1 ff ff       	call   80103d10 <exit>
80105bcd:	e9 b2 fe ff ff       	jmp    80105a84 <trap+0xc4>
80105bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105bd8:	83 ec 0c             	sub    $0xc,%esp
80105bdb:	68 60 4f 11 80       	push   $0x80114f60
80105be0:	e8 ab e9 ff ff       	call   80104590 <acquire>
      wakeup(&ticks);
80105be5:	c7 04 24 a0 57 11 80 	movl   $0x801157a0,(%esp)
      ticks++;
80105bec:	83 05 a0 57 11 80 01 	addl   $0x1,0x801157a0
      wakeup(&ticks);
80105bf3:	e8 58 e4 ff ff       	call   80104050 <wakeup>
      release(&tickslock);
80105bf8:	c7 04 24 60 4f 11 80 	movl   $0x80114f60,(%esp)
80105bff:	e8 ac ea ff ff       	call   801046b0 <release>
80105c04:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105c07:	e9 e1 fe ff ff       	jmp    80105aed <trap+0x12d>
80105c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      exit();
80105c10:	e8 fb e0 ff ff       	call   80103d10 <exit>
80105c15:	eb 85                	jmp    80105b9c <trap+0x1dc>
80105c17:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105c1a:	e8 b1 dc ff ff       	call   801038d0 <cpuid>
80105c1f:	83 ec 0c             	sub    $0xc,%esp
80105c22:	56                   	push   %esi
80105c23:	53                   	push   %ebx
80105c24:	50                   	push   %eax
80105c25:	ff 77 30             	pushl  0x30(%edi)
80105c28:	68 34 7a 10 80       	push   $0x80107a34
80105c2d:	e8 7e aa ff ff       	call   801006b0 <cprintf>
      panic("trap");
80105c32:	83 c4 14             	add    $0x14,%esp
80105c35:	68 0a 7a 10 80       	push   $0x80107a0a
80105c3a:	e8 51 a7 ff ff       	call   80100390 <panic>
80105c3f:	90                   	nop

80105c40 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105c40:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
80105c45:	85 c0                	test   %eax,%eax
80105c47:	74 17                	je     80105c60 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c49:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c4e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105c4f:	a8 01                	test   $0x1,%al
80105c51:	74 0d                	je     80105c60 <uartgetc+0x20>
80105c53:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c58:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105c59:	0f b6 c0             	movzbl %al,%eax
80105c5c:	c3                   	ret    
80105c5d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c65:	c3                   	ret    
80105c66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c6d:	8d 76 00             	lea    0x0(%esi),%esi

80105c70 <uartputc.part.0>:
uartputc(int c)
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
80105c73:	57                   	push   %edi
80105c74:	89 c7                	mov    %eax,%edi
80105c76:	56                   	push   %esi
80105c77:	be fd 03 00 00       	mov    $0x3fd,%esi
80105c7c:	53                   	push   %ebx
80105c7d:	bb 80 00 00 00       	mov    $0x80,%ebx
80105c82:	83 ec 0c             	sub    $0xc,%esp
80105c85:	eb 1b                	jmp    80105ca2 <uartputc.part.0+0x32>
80105c87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c8e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80105c90:	83 ec 0c             	sub    $0xc,%esp
80105c93:	6a 0a                	push   $0xa
80105c95:	e8 d6 cb ff ff       	call   80102870 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105c9a:	83 c4 10             	add    $0x10,%esp
80105c9d:	83 eb 01             	sub    $0x1,%ebx
80105ca0:	74 07                	je     80105ca9 <uartputc.part.0+0x39>
80105ca2:	89 f2                	mov    %esi,%edx
80105ca4:	ec                   	in     (%dx),%al
80105ca5:	a8 20                	test   $0x20,%al
80105ca7:	74 e7                	je     80105c90 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105ca9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cae:	89 f8                	mov    %edi,%eax
80105cb0:	ee                   	out    %al,(%dx)
}
80105cb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cb4:	5b                   	pop    %ebx
80105cb5:	5e                   	pop    %esi
80105cb6:	5f                   	pop    %edi
80105cb7:	5d                   	pop    %ebp
80105cb8:	c3                   	ret    
80105cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cc0 <uartinit>:
{
80105cc0:	55                   	push   %ebp
80105cc1:	31 c9                	xor    %ecx,%ecx
80105cc3:	89 c8                	mov    %ecx,%eax
80105cc5:	89 e5                	mov    %esp,%ebp
80105cc7:	57                   	push   %edi
80105cc8:	56                   	push   %esi
80105cc9:	53                   	push   %ebx
80105cca:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105ccf:	89 da                	mov    %ebx,%edx
80105cd1:	83 ec 0c             	sub    $0xc,%esp
80105cd4:	ee                   	out    %al,(%dx)
80105cd5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105cda:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105cdf:	89 fa                	mov    %edi,%edx
80105ce1:	ee                   	out    %al,(%dx)
80105ce2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105ce7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cec:	ee                   	out    %al,(%dx)
80105ced:	be f9 03 00 00       	mov    $0x3f9,%esi
80105cf2:	89 c8                	mov    %ecx,%eax
80105cf4:	89 f2                	mov    %esi,%edx
80105cf6:	ee                   	out    %al,(%dx)
80105cf7:	b8 03 00 00 00       	mov    $0x3,%eax
80105cfc:	89 fa                	mov    %edi,%edx
80105cfe:	ee                   	out    %al,(%dx)
80105cff:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105d04:	89 c8                	mov    %ecx,%eax
80105d06:	ee                   	out    %al,(%dx)
80105d07:	b8 01 00 00 00       	mov    $0x1,%eax
80105d0c:	89 f2                	mov    %esi,%edx
80105d0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d0f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d14:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105d15:	3c ff                	cmp    $0xff,%al
80105d17:	74 56                	je     80105d6f <uartinit+0xaf>
  uart = 1;
80105d19:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105d20:	00 00 00 
80105d23:	89 da                	mov    %ebx,%edx
80105d25:	ec                   	in     (%dx),%al
80105d26:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d2b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105d2c:	83 ec 08             	sub    $0x8,%esp
80105d2f:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80105d34:	bb 2c 7b 10 80       	mov    $0x80107b2c,%ebx
  ioapicenable(IRQ_COM1, 0);
80105d39:	6a 00                	push   $0x0
80105d3b:	6a 04                	push   $0x4
80105d3d:	e8 6e c6 ff ff       	call   801023b0 <ioapicenable>
80105d42:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105d45:	b8 78 00 00 00       	mov    $0x78,%eax
80105d4a:	eb 08                	jmp    80105d54 <uartinit+0x94>
80105d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d50:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80105d54:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105d5a:	85 d2                	test   %edx,%edx
80105d5c:	74 08                	je     80105d66 <uartinit+0xa6>
    uartputc(*p);
80105d5e:	0f be c0             	movsbl %al,%eax
80105d61:	e8 0a ff ff ff       	call   80105c70 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80105d66:	89 f0                	mov    %esi,%eax
80105d68:	83 c3 01             	add    $0x1,%ebx
80105d6b:	84 c0                	test   %al,%al
80105d6d:	75 e1                	jne    80105d50 <uartinit+0x90>
}
80105d6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d72:	5b                   	pop    %ebx
80105d73:	5e                   	pop    %esi
80105d74:	5f                   	pop    %edi
80105d75:	5d                   	pop    %ebp
80105d76:	c3                   	ret    
80105d77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d7e:	66 90                	xchg   %ax,%ax

80105d80 <uartputc>:
{
80105d80:	55                   	push   %ebp
  if(!uart)
80105d81:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105d87:	89 e5                	mov    %esp,%ebp
80105d89:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105d8c:	85 d2                	test   %edx,%edx
80105d8e:	74 10                	je     80105da0 <uartputc+0x20>
}
80105d90:	5d                   	pop    %ebp
80105d91:	e9 da fe ff ff       	jmp    80105c70 <uartputc.part.0>
80105d96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d9d:	8d 76 00             	lea    0x0(%esi),%esi
80105da0:	5d                   	pop    %ebp
80105da1:	c3                   	ret    
80105da2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105db0 <uartintr>:

void
uartintr(void)
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105db6:	68 40 5c 10 80       	push   $0x80105c40
80105dbb:	e8 a0 aa ff ff       	call   80100860 <consoleintr>
}
80105dc0:	83 c4 10             	add    $0x10,%esp
80105dc3:	c9                   	leave  
80105dc4:	c3                   	ret    

80105dc5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105dc5:	6a 00                	push   $0x0
  pushl $0
80105dc7:	6a 00                	push   $0x0
  jmp alltraps
80105dc9:	e9 17 fb ff ff       	jmp    801058e5 <alltraps>

80105dce <vector1>:
.globl vector1
vector1:
  pushl $0
80105dce:	6a 00                	push   $0x0
  pushl $1
80105dd0:	6a 01                	push   $0x1
  jmp alltraps
80105dd2:	e9 0e fb ff ff       	jmp    801058e5 <alltraps>

80105dd7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105dd7:	6a 00                	push   $0x0
  pushl $2
80105dd9:	6a 02                	push   $0x2
  jmp alltraps
80105ddb:	e9 05 fb ff ff       	jmp    801058e5 <alltraps>

80105de0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105de0:	6a 00                	push   $0x0
  pushl $3
80105de2:	6a 03                	push   $0x3
  jmp alltraps
80105de4:	e9 fc fa ff ff       	jmp    801058e5 <alltraps>

80105de9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105de9:	6a 00                	push   $0x0
  pushl $4
80105deb:	6a 04                	push   $0x4
  jmp alltraps
80105ded:	e9 f3 fa ff ff       	jmp    801058e5 <alltraps>

80105df2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105df2:	6a 00                	push   $0x0
  pushl $5
80105df4:	6a 05                	push   $0x5
  jmp alltraps
80105df6:	e9 ea fa ff ff       	jmp    801058e5 <alltraps>

80105dfb <vector6>:
.globl vector6
vector6:
  pushl $0
80105dfb:	6a 00                	push   $0x0
  pushl $6
80105dfd:	6a 06                	push   $0x6
  jmp alltraps
80105dff:	e9 e1 fa ff ff       	jmp    801058e5 <alltraps>

80105e04 <vector7>:
.globl vector7
vector7:
  pushl $0
80105e04:	6a 00                	push   $0x0
  pushl $7
80105e06:	6a 07                	push   $0x7
  jmp alltraps
80105e08:	e9 d8 fa ff ff       	jmp    801058e5 <alltraps>

80105e0d <vector8>:
.globl vector8
vector8:
  pushl $8
80105e0d:	6a 08                	push   $0x8
  jmp alltraps
80105e0f:	e9 d1 fa ff ff       	jmp    801058e5 <alltraps>

80105e14 <vector9>:
.globl vector9
vector9:
  pushl $0
80105e14:	6a 00                	push   $0x0
  pushl $9
80105e16:	6a 09                	push   $0x9
  jmp alltraps
80105e18:	e9 c8 fa ff ff       	jmp    801058e5 <alltraps>

80105e1d <vector10>:
.globl vector10
vector10:
  pushl $10
80105e1d:	6a 0a                	push   $0xa
  jmp alltraps
80105e1f:	e9 c1 fa ff ff       	jmp    801058e5 <alltraps>

80105e24 <vector11>:
.globl vector11
vector11:
  pushl $11
80105e24:	6a 0b                	push   $0xb
  jmp alltraps
80105e26:	e9 ba fa ff ff       	jmp    801058e5 <alltraps>

80105e2b <vector12>:
.globl vector12
vector12:
  pushl $12
80105e2b:	6a 0c                	push   $0xc
  jmp alltraps
80105e2d:	e9 b3 fa ff ff       	jmp    801058e5 <alltraps>

80105e32 <vector13>:
.globl vector13
vector13:
  pushl $13
80105e32:	6a 0d                	push   $0xd
  jmp alltraps
80105e34:	e9 ac fa ff ff       	jmp    801058e5 <alltraps>

80105e39 <vector14>:
.globl vector14
vector14:
  pushl $14
80105e39:	6a 0e                	push   $0xe
  jmp alltraps
80105e3b:	e9 a5 fa ff ff       	jmp    801058e5 <alltraps>

80105e40 <vector15>:
.globl vector15
vector15:
  pushl $0
80105e40:	6a 00                	push   $0x0
  pushl $15
80105e42:	6a 0f                	push   $0xf
  jmp alltraps
80105e44:	e9 9c fa ff ff       	jmp    801058e5 <alltraps>

80105e49 <vector16>:
.globl vector16
vector16:
  pushl $0
80105e49:	6a 00                	push   $0x0
  pushl $16
80105e4b:	6a 10                	push   $0x10
  jmp alltraps
80105e4d:	e9 93 fa ff ff       	jmp    801058e5 <alltraps>

80105e52 <vector17>:
.globl vector17
vector17:
  pushl $17
80105e52:	6a 11                	push   $0x11
  jmp alltraps
80105e54:	e9 8c fa ff ff       	jmp    801058e5 <alltraps>

80105e59 <vector18>:
.globl vector18
vector18:
  pushl $0
80105e59:	6a 00                	push   $0x0
  pushl $18
80105e5b:	6a 12                	push   $0x12
  jmp alltraps
80105e5d:	e9 83 fa ff ff       	jmp    801058e5 <alltraps>

80105e62 <vector19>:
.globl vector19
vector19:
  pushl $0
80105e62:	6a 00                	push   $0x0
  pushl $19
80105e64:	6a 13                	push   $0x13
  jmp alltraps
80105e66:	e9 7a fa ff ff       	jmp    801058e5 <alltraps>

80105e6b <vector20>:
.globl vector20
vector20:
  pushl $0
80105e6b:	6a 00                	push   $0x0
  pushl $20
80105e6d:	6a 14                	push   $0x14
  jmp alltraps
80105e6f:	e9 71 fa ff ff       	jmp    801058e5 <alltraps>

80105e74 <vector21>:
.globl vector21
vector21:
  pushl $0
80105e74:	6a 00                	push   $0x0
  pushl $21
80105e76:	6a 15                	push   $0x15
  jmp alltraps
80105e78:	e9 68 fa ff ff       	jmp    801058e5 <alltraps>

80105e7d <vector22>:
.globl vector22
vector22:
  pushl $0
80105e7d:	6a 00                	push   $0x0
  pushl $22
80105e7f:	6a 16                	push   $0x16
  jmp alltraps
80105e81:	e9 5f fa ff ff       	jmp    801058e5 <alltraps>

80105e86 <vector23>:
.globl vector23
vector23:
  pushl $0
80105e86:	6a 00                	push   $0x0
  pushl $23
80105e88:	6a 17                	push   $0x17
  jmp alltraps
80105e8a:	e9 56 fa ff ff       	jmp    801058e5 <alltraps>

80105e8f <vector24>:
.globl vector24
vector24:
  pushl $0
80105e8f:	6a 00                	push   $0x0
  pushl $24
80105e91:	6a 18                	push   $0x18
  jmp alltraps
80105e93:	e9 4d fa ff ff       	jmp    801058e5 <alltraps>

80105e98 <vector25>:
.globl vector25
vector25:
  pushl $0
80105e98:	6a 00                	push   $0x0
  pushl $25
80105e9a:	6a 19                	push   $0x19
  jmp alltraps
80105e9c:	e9 44 fa ff ff       	jmp    801058e5 <alltraps>

80105ea1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105ea1:	6a 00                	push   $0x0
  pushl $26
80105ea3:	6a 1a                	push   $0x1a
  jmp alltraps
80105ea5:	e9 3b fa ff ff       	jmp    801058e5 <alltraps>

80105eaa <vector27>:
.globl vector27
vector27:
  pushl $0
80105eaa:	6a 00                	push   $0x0
  pushl $27
80105eac:	6a 1b                	push   $0x1b
  jmp alltraps
80105eae:	e9 32 fa ff ff       	jmp    801058e5 <alltraps>

80105eb3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105eb3:	6a 00                	push   $0x0
  pushl $28
80105eb5:	6a 1c                	push   $0x1c
  jmp alltraps
80105eb7:	e9 29 fa ff ff       	jmp    801058e5 <alltraps>

80105ebc <vector29>:
.globl vector29
vector29:
  pushl $0
80105ebc:	6a 00                	push   $0x0
  pushl $29
80105ebe:	6a 1d                	push   $0x1d
  jmp alltraps
80105ec0:	e9 20 fa ff ff       	jmp    801058e5 <alltraps>

80105ec5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105ec5:	6a 00                	push   $0x0
  pushl $30
80105ec7:	6a 1e                	push   $0x1e
  jmp alltraps
80105ec9:	e9 17 fa ff ff       	jmp    801058e5 <alltraps>

80105ece <vector31>:
.globl vector31
vector31:
  pushl $0
80105ece:	6a 00                	push   $0x0
  pushl $31
80105ed0:	6a 1f                	push   $0x1f
  jmp alltraps
80105ed2:	e9 0e fa ff ff       	jmp    801058e5 <alltraps>

80105ed7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105ed7:	6a 00                	push   $0x0
  pushl $32
80105ed9:	6a 20                	push   $0x20
  jmp alltraps
80105edb:	e9 05 fa ff ff       	jmp    801058e5 <alltraps>

80105ee0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105ee0:	6a 00                	push   $0x0
  pushl $33
80105ee2:	6a 21                	push   $0x21
  jmp alltraps
80105ee4:	e9 fc f9 ff ff       	jmp    801058e5 <alltraps>

80105ee9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105ee9:	6a 00                	push   $0x0
  pushl $34
80105eeb:	6a 22                	push   $0x22
  jmp alltraps
80105eed:	e9 f3 f9 ff ff       	jmp    801058e5 <alltraps>

80105ef2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105ef2:	6a 00                	push   $0x0
  pushl $35
80105ef4:	6a 23                	push   $0x23
  jmp alltraps
80105ef6:	e9 ea f9 ff ff       	jmp    801058e5 <alltraps>

80105efb <vector36>:
.globl vector36
vector36:
  pushl $0
80105efb:	6a 00                	push   $0x0
  pushl $36
80105efd:	6a 24                	push   $0x24
  jmp alltraps
80105eff:	e9 e1 f9 ff ff       	jmp    801058e5 <alltraps>

80105f04 <vector37>:
.globl vector37
vector37:
  pushl $0
80105f04:	6a 00                	push   $0x0
  pushl $37
80105f06:	6a 25                	push   $0x25
  jmp alltraps
80105f08:	e9 d8 f9 ff ff       	jmp    801058e5 <alltraps>

80105f0d <vector38>:
.globl vector38
vector38:
  pushl $0
80105f0d:	6a 00                	push   $0x0
  pushl $38
80105f0f:	6a 26                	push   $0x26
  jmp alltraps
80105f11:	e9 cf f9 ff ff       	jmp    801058e5 <alltraps>

80105f16 <vector39>:
.globl vector39
vector39:
  pushl $0
80105f16:	6a 00                	push   $0x0
  pushl $39
80105f18:	6a 27                	push   $0x27
  jmp alltraps
80105f1a:	e9 c6 f9 ff ff       	jmp    801058e5 <alltraps>

80105f1f <vector40>:
.globl vector40
vector40:
  pushl $0
80105f1f:	6a 00                	push   $0x0
  pushl $40
80105f21:	6a 28                	push   $0x28
  jmp alltraps
80105f23:	e9 bd f9 ff ff       	jmp    801058e5 <alltraps>

80105f28 <vector41>:
.globl vector41
vector41:
  pushl $0
80105f28:	6a 00                	push   $0x0
  pushl $41
80105f2a:	6a 29                	push   $0x29
  jmp alltraps
80105f2c:	e9 b4 f9 ff ff       	jmp    801058e5 <alltraps>

80105f31 <vector42>:
.globl vector42
vector42:
  pushl $0
80105f31:	6a 00                	push   $0x0
  pushl $42
80105f33:	6a 2a                	push   $0x2a
  jmp alltraps
80105f35:	e9 ab f9 ff ff       	jmp    801058e5 <alltraps>

80105f3a <vector43>:
.globl vector43
vector43:
  pushl $0
80105f3a:	6a 00                	push   $0x0
  pushl $43
80105f3c:	6a 2b                	push   $0x2b
  jmp alltraps
80105f3e:	e9 a2 f9 ff ff       	jmp    801058e5 <alltraps>

80105f43 <vector44>:
.globl vector44
vector44:
  pushl $0
80105f43:	6a 00                	push   $0x0
  pushl $44
80105f45:	6a 2c                	push   $0x2c
  jmp alltraps
80105f47:	e9 99 f9 ff ff       	jmp    801058e5 <alltraps>

80105f4c <vector45>:
.globl vector45
vector45:
  pushl $0
80105f4c:	6a 00                	push   $0x0
  pushl $45
80105f4e:	6a 2d                	push   $0x2d
  jmp alltraps
80105f50:	e9 90 f9 ff ff       	jmp    801058e5 <alltraps>

80105f55 <vector46>:
.globl vector46
vector46:
  pushl $0
80105f55:	6a 00                	push   $0x0
  pushl $46
80105f57:	6a 2e                	push   $0x2e
  jmp alltraps
80105f59:	e9 87 f9 ff ff       	jmp    801058e5 <alltraps>

80105f5e <vector47>:
.globl vector47
vector47:
  pushl $0
80105f5e:	6a 00                	push   $0x0
  pushl $47
80105f60:	6a 2f                	push   $0x2f
  jmp alltraps
80105f62:	e9 7e f9 ff ff       	jmp    801058e5 <alltraps>

80105f67 <vector48>:
.globl vector48
vector48:
  pushl $0
80105f67:	6a 00                	push   $0x0
  pushl $48
80105f69:	6a 30                	push   $0x30
  jmp alltraps
80105f6b:	e9 75 f9 ff ff       	jmp    801058e5 <alltraps>

80105f70 <vector49>:
.globl vector49
vector49:
  pushl $0
80105f70:	6a 00                	push   $0x0
  pushl $49
80105f72:	6a 31                	push   $0x31
  jmp alltraps
80105f74:	e9 6c f9 ff ff       	jmp    801058e5 <alltraps>

80105f79 <vector50>:
.globl vector50
vector50:
  pushl $0
80105f79:	6a 00                	push   $0x0
  pushl $50
80105f7b:	6a 32                	push   $0x32
  jmp alltraps
80105f7d:	e9 63 f9 ff ff       	jmp    801058e5 <alltraps>

80105f82 <vector51>:
.globl vector51
vector51:
  pushl $0
80105f82:	6a 00                	push   $0x0
  pushl $51
80105f84:	6a 33                	push   $0x33
  jmp alltraps
80105f86:	e9 5a f9 ff ff       	jmp    801058e5 <alltraps>

80105f8b <vector52>:
.globl vector52
vector52:
  pushl $0
80105f8b:	6a 00                	push   $0x0
  pushl $52
80105f8d:	6a 34                	push   $0x34
  jmp alltraps
80105f8f:	e9 51 f9 ff ff       	jmp    801058e5 <alltraps>

80105f94 <vector53>:
.globl vector53
vector53:
  pushl $0
80105f94:	6a 00                	push   $0x0
  pushl $53
80105f96:	6a 35                	push   $0x35
  jmp alltraps
80105f98:	e9 48 f9 ff ff       	jmp    801058e5 <alltraps>

80105f9d <vector54>:
.globl vector54
vector54:
  pushl $0
80105f9d:	6a 00                	push   $0x0
  pushl $54
80105f9f:	6a 36                	push   $0x36
  jmp alltraps
80105fa1:	e9 3f f9 ff ff       	jmp    801058e5 <alltraps>

80105fa6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105fa6:	6a 00                	push   $0x0
  pushl $55
80105fa8:	6a 37                	push   $0x37
  jmp alltraps
80105faa:	e9 36 f9 ff ff       	jmp    801058e5 <alltraps>

80105faf <vector56>:
.globl vector56
vector56:
  pushl $0
80105faf:	6a 00                	push   $0x0
  pushl $56
80105fb1:	6a 38                	push   $0x38
  jmp alltraps
80105fb3:	e9 2d f9 ff ff       	jmp    801058e5 <alltraps>

80105fb8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105fb8:	6a 00                	push   $0x0
  pushl $57
80105fba:	6a 39                	push   $0x39
  jmp alltraps
80105fbc:	e9 24 f9 ff ff       	jmp    801058e5 <alltraps>

80105fc1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105fc1:	6a 00                	push   $0x0
  pushl $58
80105fc3:	6a 3a                	push   $0x3a
  jmp alltraps
80105fc5:	e9 1b f9 ff ff       	jmp    801058e5 <alltraps>

80105fca <vector59>:
.globl vector59
vector59:
  pushl $0
80105fca:	6a 00                	push   $0x0
  pushl $59
80105fcc:	6a 3b                	push   $0x3b
  jmp alltraps
80105fce:	e9 12 f9 ff ff       	jmp    801058e5 <alltraps>

80105fd3 <vector60>:
.globl vector60
vector60:
  pushl $0
80105fd3:	6a 00                	push   $0x0
  pushl $60
80105fd5:	6a 3c                	push   $0x3c
  jmp alltraps
80105fd7:	e9 09 f9 ff ff       	jmp    801058e5 <alltraps>

80105fdc <vector61>:
.globl vector61
vector61:
  pushl $0
80105fdc:	6a 00                	push   $0x0
  pushl $61
80105fde:	6a 3d                	push   $0x3d
  jmp alltraps
80105fe0:	e9 00 f9 ff ff       	jmp    801058e5 <alltraps>

80105fe5 <vector62>:
.globl vector62
vector62:
  pushl $0
80105fe5:	6a 00                	push   $0x0
  pushl $62
80105fe7:	6a 3e                	push   $0x3e
  jmp alltraps
80105fe9:	e9 f7 f8 ff ff       	jmp    801058e5 <alltraps>

80105fee <vector63>:
.globl vector63
vector63:
  pushl $0
80105fee:	6a 00                	push   $0x0
  pushl $63
80105ff0:	6a 3f                	push   $0x3f
  jmp alltraps
80105ff2:	e9 ee f8 ff ff       	jmp    801058e5 <alltraps>

80105ff7 <vector64>:
.globl vector64
vector64:
  pushl $0
80105ff7:	6a 00                	push   $0x0
  pushl $64
80105ff9:	6a 40                	push   $0x40
  jmp alltraps
80105ffb:	e9 e5 f8 ff ff       	jmp    801058e5 <alltraps>

80106000 <vector65>:
.globl vector65
vector65:
  pushl $0
80106000:	6a 00                	push   $0x0
  pushl $65
80106002:	6a 41                	push   $0x41
  jmp alltraps
80106004:	e9 dc f8 ff ff       	jmp    801058e5 <alltraps>

80106009 <vector66>:
.globl vector66
vector66:
  pushl $0
80106009:	6a 00                	push   $0x0
  pushl $66
8010600b:	6a 42                	push   $0x42
  jmp alltraps
8010600d:	e9 d3 f8 ff ff       	jmp    801058e5 <alltraps>

80106012 <vector67>:
.globl vector67
vector67:
  pushl $0
80106012:	6a 00                	push   $0x0
  pushl $67
80106014:	6a 43                	push   $0x43
  jmp alltraps
80106016:	e9 ca f8 ff ff       	jmp    801058e5 <alltraps>

8010601b <vector68>:
.globl vector68
vector68:
  pushl $0
8010601b:	6a 00                	push   $0x0
  pushl $68
8010601d:	6a 44                	push   $0x44
  jmp alltraps
8010601f:	e9 c1 f8 ff ff       	jmp    801058e5 <alltraps>

80106024 <vector69>:
.globl vector69
vector69:
  pushl $0
80106024:	6a 00                	push   $0x0
  pushl $69
80106026:	6a 45                	push   $0x45
  jmp alltraps
80106028:	e9 b8 f8 ff ff       	jmp    801058e5 <alltraps>

8010602d <vector70>:
.globl vector70
vector70:
  pushl $0
8010602d:	6a 00                	push   $0x0
  pushl $70
8010602f:	6a 46                	push   $0x46
  jmp alltraps
80106031:	e9 af f8 ff ff       	jmp    801058e5 <alltraps>

80106036 <vector71>:
.globl vector71
vector71:
  pushl $0
80106036:	6a 00                	push   $0x0
  pushl $71
80106038:	6a 47                	push   $0x47
  jmp alltraps
8010603a:	e9 a6 f8 ff ff       	jmp    801058e5 <alltraps>

8010603f <vector72>:
.globl vector72
vector72:
  pushl $0
8010603f:	6a 00                	push   $0x0
  pushl $72
80106041:	6a 48                	push   $0x48
  jmp alltraps
80106043:	e9 9d f8 ff ff       	jmp    801058e5 <alltraps>

80106048 <vector73>:
.globl vector73
vector73:
  pushl $0
80106048:	6a 00                	push   $0x0
  pushl $73
8010604a:	6a 49                	push   $0x49
  jmp alltraps
8010604c:	e9 94 f8 ff ff       	jmp    801058e5 <alltraps>

80106051 <vector74>:
.globl vector74
vector74:
  pushl $0
80106051:	6a 00                	push   $0x0
  pushl $74
80106053:	6a 4a                	push   $0x4a
  jmp alltraps
80106055:	e9 8b f8 ff ff       	jmp    801058e5 <alltraps>

8010605a <vector75>:
.globl vector75
vector75:
  pushl $0
8010605a:	6a 00                	push   $0x0
  pushl $75
8010605c:	6a 4b                	push   $0x4b
  jmp alltraps
8010605e:	e9 82 f8 ff ff       	jmp    801058e5 <alltraps>

80106063 <vector76>:
.globl vector76
vector76:
  pushl $0
80106063:	6a 00                	push   $0x0
  pushl $76
80106065:	6a 4c                	push   $0x4c
  jmp alltraps
80106067:	e9 79 f8 ff ff       	jmp    801058e5 <alltraps>

8010606c <vector77>:
.globl vector77
vector77:
  pushl $0
8010606c:	6a 00                	push   $0x0
  pushl $77
8010606e:	6a 4d                	push   $0x4d
  jmp alltraps
80106070:	e9 70 f8 ff ff       	jmp    801058e5 <alltraps>

80106075 <vector78>:
.globl vector78
vector78:
  pushl $0
80106075:	6a 00                	push   $0x0
  pushl $78
80106077:	6a 4e                	push   $0x4e
  jmp alltraps
80106079:	e9 67 f8 ff ff       	jmp    801058e5 <alltraps>

8010607e <vector79>:
.globl vector79
vector79:
  pushl $0
8010607e:	6a 00                	push   $0x0
  pushl $79
80106080:	6a 4f                	push   $0x4f
  jmp alltraps
80106082:	e9 5e f8 ff ff       	jmp    801058e5 <alltraps>

80106087 <vector80>:
.globl vector80
vector80:
  pushl $0
80106087:	6a 00                	push   $0x0
  pushl $80
80106089:	6a 50                	push   $0x50
  jmp alltraps
8010608b:	e9 55 f8 ff ff       	jmp    801058e5 <alltraps>

80106090 <vector81>:
.globl vector81
vector81:
  pushl $0
80106090:	6a 00                	push   $0x0
  pushl $81
80106092:	6a 51                	push   $0x51
  jmp alltraps
80106094:	e9 4c f8 ff ff       	jmp    801058e5 <alltraps>

80106099 <vector82>:
.globl vector82
vector82:
  pushl $0
80106099:	6a 00                	push   $0x0
  pushl $82
8010609b:	6a 52                	push   $0x52
  jmp alltraps
8010609d:	e9 43 f8 ff ff       	jmp    801058e5 <alltraps>

801060a2 <vector83>:
.globl vector83
vector83:
  pushl $0
801060a2:	6a 00                	push   $0x0
  pushl $83
801060a4:	6a 53                	push   $0x53
  jmp alltraps
801060a6:	e9 3a f8 ff ff       	jmp    801058e5 <alltraps>

801060ab <vector84>:
.globl vector84
vector84:
  pushl $0
801060ab:	6a 00                	push   $0x0
  pushl $84
801060ad:	6a 54                	push   $0x54
  jmp alltraps
801060af:	e9 31 f8 ff ff       	jmp    801058e5 <alltraps>

801060b4 <vector85>:
.globl vector85
vector85:
  pushl $0
801060b4:	6a 00                	push   $0x0
  pushl $85
801060b6:	6a 55                	push   $0x55
  jmp alltraps
801060b8:	e9 28 f8 ff ff       	jmp    801058e5 <alltraps>

801060bd <vector86>:
.globl vector86
vector86:
  pushl $0
801060bd:	6a 00                	push   $0x0
  pushl $86
801060bf:	6a 56                	push   $0x56
  jmp alltraps
801060c1:	e9 1f f8 ff ff       	jmp    801058e5 <alltraps>

801060c6 <vector87>:
.globl vector87
vector87:
  pushl $0
801060c6:	6a 00                	push   $0x0
  pushl $87
801060c8:	6a 57                	push   $0x57
  jmp alltraps
801060ca:	e9 16 f8 ff ff       	jmp    801058e5 <alltraps>

801060cf <vector88>:
.globl vector88
vector88:
  pushl $0
801060cf:	6a 00                	push   $0x0
  pushl $88
801060d1:	6a 58                	push   $0x58
  jmp alltraps
801060d3:	e9 0d f8 ff ff       	jmp    801058e5 <alltraps>

801060d8 <vector89>:
.globl vector89
vector89:
  pushl $0
801060d8:	6a 00                	push   $0x0
  pushl $89
801060da:	6a 59                	push   $0x59
  jmp alltraps
801060dc:	e9 04 f8 ff ff       	jmp    801058e5 <alltraps>

801060e1 <vector90>:
.globl vector90
vector90:
  pushl $0
801060e1:	6a 00                	push   $0x0
  pushl $90
801060e3:	6a 5a                	push   $0x5a
  jmp alltraps
801060e5:	e9 fb f7 ff ff       	jmp    801058e5 <alltraps>

801060ea <vector91>:
.globl vector91
vector91:
  pushl $0
801060ea:	6a 00                	push   $0x0
  pushl $91
801060ec:	6a 5b                	push   $0x5b
  jmp alltraps
801060ee:	e9 f2 f7 ff ff       	jmp    801058e5 <alltraps>

801060f3 <vector92>:
.globl vector92
vector92:
  pushl $0
801060f3:	6a 00                	push   $0x0
  pushl $92
801060f5:	6a 5c                	push   $0x5c
  jmp alltraps
801060f7:	e9 e9 f7 ff ff       	jmp    801058e5 <alltraps>

801060fc <vector93>:
.globl vector93
vector93:
  pushl $0
801060fc:	6a 00                	push   $0x0
  pushl $93
801060fe:	6a 5d                	push   $0x5d
  jmp alltraps
80106100:	e9 e0 f7 ff ff       	jmp    801058e5 <alltraps>

80106105 <vector94>:
.globl vector94
vector94:
  pushl $0
80106105:	6a 00                	push   $0x0
  pushl $94
80106107:	6a 5e                	push   $0x5e
  jmp alltraps
80106109:	e9 d7 f7 ff ff       	jmp    801058e5 <alltraps>

8010610e <vector95>:
.globl vector95
vector95:
  pushl $0
8010610e:	6a 00                	push   $0x0
  pushl $95
80106110:	6a 5f                	push   $0x5f
  jmp alltraps
80106112:	e9 ce f7 ff ff       	jmp    801058e5 <alltraps>

80106117 <vector96>:
.globl vector96
vector96:
  pushl $0
80106117:	6a 00                	push   $0x0
  pushl $96
80106119:	6a 60                	push   $0x60
  jmp alltraps
8010611b:	e9 c5 f7 ff ff       	jmp    801058e5 <alltraps>

80106120 <vector97>:
.globl vector97
vector97:
  pushl $0
80106120:	6a 00                	push   $0x0
  pushl $97
80106122:	6a 61                	push   $0x61
  jmp alltraps
80106124:	e9 bc f7 ff ff       	jmp    801058e5 <alltraps>

80106129 <vector98>:
.globl vector98
vector98:
  pushl $0
80106129:	6a 00                	push   $0x0
  pushl $98
8010612b:	6a 62                	push   $0x62
  jmp alltraps
8010612d:	e9 b3 f7 ff ff       	jmp    801058e5 <alltraps>

80106132 <vector99>:
.globl vector99
vector99:
  pushl $0
80106132:	6a 00                	push   $0x0
  pushl $99
80106134:	6a 63                	push   $0x63
  jmp alltraps
80106136:	e9 aa f7 ff ff       	jmp    801058e5 <alltraps>

8010613b <vector100>:
.globl vector100
vector100:
  pushl $0
8010613b:	6a 00                	push   $0x0
  pushl $100
8010613d:	6a 64                	push   $0x64
  jmp alltraps
8010613f:	e9 a1 f7 ff ff       	jmp    801058e5 <alltraps>

80106144 <vector101>:
.globl vector101
vector101:
  pushl $0
80106144:	6a 00                	push   $0x0
  pushl $101
80106146:	6a 65                	push   $0x65
  jmp alltraps
80106148:	e9 98 f7 ff ff       	jmp    801058e5 <alltraps>

8010614d <vector102>:
.globl vector102
vector102:
  pushl $0
8010614d:	6a 00                	push   $0x0
  pushl $102
8010614f:	6a 66                	push   $0x66
  jmp alltraps
80106151:	e9 8f f7 ff ff       	jmp    801058e5 <alltraps>

80106156 <vector103>:
.globl vector103
vector103:
  pushl $0
80106156:	6a 00                	push   $0x0
  pushl $103
80106158:	6a 67                	push   $0x67
  jmp alltraps
8010615a:	e9 86 f7 ff ff       	jmp    801058e5 <alltraps>

8010615f <vector104>:
.globl vector104
vector104:
  pushl $0
8010615f:	6a 00                	push   $0x0
  pushl $104
80106161:	6a 68                	push   $0x68
  jmp alltraps
80106163:	e9 7d f7 ff ff       	jmp    801058e5 <alltraps>

80106168 <vector105>:
.globl vector105
vector105:
  pushl $0
80106168:	6a 00                	push   $0x0
  pushl $105
8010616a:	6a 69                	push   $0x69
  jmp alltraps
8010616c:	e9 74 f7 ff ff       	jmp    801058e5 <alltraps>

80106171 <vector106>:
.globl vector106
vector106:
  pushl $0
80106171:	6a 00                	push   $0x0
  pushl $106
80106173:	6a 6a                	push   $0x6a
  jmp alltraps
80106175:	e9 6b f7 ff ff       	jmp    801058e5 <alltraps>

8010617a <vector107>:
.globl vector107
vector107:
  pushl $0
8010617a:	6a 00                	push   $0x0
  pushl $107
8010617c:	6a 6b                	push   $0x6b
  jmp alltraps
8010617e:	e9 62 f7 ff ff       	jmp    801058e5 <alltraps>

80106183 <vector108>:
.globl vector108
vector108:
  pushl $0
80106183:	6a 00                	push   $0x0
  pushl $108
80106185:	6a 6c                	push   $0x6c
  jmp alltraps
80106187:	e9 59 f7 ff ff       	jmp    801058e5 <alltraps>

8010618c <vector109>:
.globl vector109
vector109:
  pushl $0
8010618c:	6a 00                	push   $0x0
  pushl $109
8010618e:	6a 6d                	push   $0x6d
  jmp alltraps
80106190:	e9 50 f7 ff ff       	jmp    801058e5 <alltraps>

80106195 <vector110>:
.globl vector110
vector110:
  pushl $0
80106195:	6a 00                	push   $0x0
  pushl $110
80106197:	6a 6e                	push   $0x6e
  jmp alltraps
80106199:	e9 47 f7 ff ff       	jmp    801058e5 <alltraps>

8010619e <vector111>:
.globl vector111
vector111:
  pushl $0
8010619e:	6a 00                	push   $0x0
  pushl $111
801061a0:	6a 6f                	push   $0x6f
  jmp alltraps
801061a2:	e9 3e f7 ff ff       	jmp    801058e5 <alltraps>

801061a7 <vector112>:
.globl vector112
vector112:
  pushl $0
801061a7:	6a 00                	push   $0x0
  pushl $112
801061a9:	6a 70                	push   $0x70
  jmp alltraps
801061ab:	e9 35 f7 ff ff       	jmp    801058e5 <alltraps>

801061b0 <vector113>:
.globl vector113
vector113:
  pushl $0
801061b0:	6a 00                	push   $0x0
  pushl $113
801061b2:	6a 71                	push   $0x71
  jmp alltraps
801061b4:	e9 2c f7 ff ff       	jmp    801058e5 <alltraps>

801061b9 <vector114>:
.globl vector114
vector114:
  pushl $0
801061b9:	6a 00                	push   $0x0
  pushl $114
801061bb:	6a 72                	push   $0x72
  jmp alltraps
801061bd:	e9 23 f7 ff ff       	jmp    801058e5 <alltraps>

801061c2 <vector115>:
.globl vector115
vector115:
  pushl $0
801061c2:	6a 00                	push   $0x0
  pushl $115
801061c4:	6a 73                	push   $0x73
  jmp alltraps
801061c6:	e9 1a f7 ff ff       	jmp    801058e5 <alltraps>

801061cb <vector116>:
.globl vector116
vector116:
  pushl $0
801061cb:	6a 00                	push   $0x0
  pushl $116
801061cd:	6a 74                	push   $0x74
  jmp alltraps
801061cf:	e9 11 f7 ff ff       	jmp    801058e5 <alltraps>

801061d4 <vector117>:
.globl vector117
vector117:
  pushl $0
801061d4:	6a 00                	push   $0x0
  pushl $117
801061d6:	6a 75                	push   $0x75
  jmp alltraps
801061d8:	e9 08 f7 ff ff       	jmp    801058e5 <alltraps>

801061dd <vector118>:
.globl vector118
vector118:
  pushl $0
801061dd:	6a 00                	push   $0x0
  pushl $118
801061df:	6a 76                	push   $0x76
  jmp alltraps
801061e1:	e9 ff f6 ff ff       	jmp    801058e5 <alltraps>

801061e6 <vector119>:
.globl vector119
vector119:
  pushl $0
801061e6:	6a 00                	push   $0x0
  pushl $119
801061e8:	6a 77                	push   $0x77
  jmp alltraps
801061ea:	e9 f6 f6 ff ff       	jmp    801058e5 <alltraps>

801061ef <vector120>:
.globl vector120
vector120:
  pushl $0
801061ef:	6a 00                	push   $0x0
  pushl $120
801061f1:	6a 78                	push   $0x78
  jmp alltraps
801061f3:	e9 ed f6 ff ff       	jmp    801058e5 <alltraps>

801061f8 <vector121>:
.globl vector121
vector121:
  pushl $0
801061f8:	6a 00                	push   $0x0
  pushl $121
801061fa:	6a 79                	push   $0x79
  jmp alltraps
801061fc:	e9 e4 f6 ff ff       	jmp    801058e5 <alltraps>

80106201 <vector122>:
.globl vector122
vector122:
  pushl $0
80106201:	6a 00                	push   $0x0
  pushl $122
80106203:	6a 7a                	push   $0x7a
  jmp alltraps
80106205:	e9 db f6 ff ff       	jmp    801058e5 <alltraps>

8010620a <vector123>:
.globl vector123
vector123:
  pushl $0
8010620a:	6a 00                	push   $0x0
  pushl $123
8010620c:	6a 7b                	push   $0x7b
  jmp alltraps
8010620e:	e9 d2 f6 ff ff       	jmp    801058e5 <alltraps>

80106213 <vector124>:
.globl vector124
vector124:
  pushl $0
80106213:	6a 00                	push   $0x0
  pushl $124
80106215:	6a 7c                	push   $0x7c
  jmp alltraps
80106217:	e9 c9 f6 ff ff       	jmp    801058e5 <alltraps>

8010621c <vector125>:
.globl vector125
vector125:
  pushl $0
8010621c:	6a 00                	push   $0x0
  pushl $125
8010621e:	6a 7d                	push   $0x7d
  jmp alltraps
80106220:	e9 c0 f6 ff ff       	jmp    801058e5 <alltraps>

80106225 <vector126>:
.globl vector126
vector126:
  pushl $0
80106225:	6a 00                	push   $0x0
  pushl $126
80106227:	6a 7e                	push   $0x7e
  jmp alltraps
80106229:	e9 b7 f6 ff ff       	jmp    801058e5 <alltraps>

8010622e <vector127>:
.globl vector127
vector127:
  pushl $0
8010622e:	6a 00                	push   $0x0
  pushl $127
80106230:	6a 7f                	push   $0x7f
  jmp alltraps
80106232:	e9 ae f6 ff ff       	jmp    801058e5 <alltraps>

80106237 <vector128>:
.globl vector128
vector128:
  pushl $0
80106237:	6a 00                	push   $0x0
  pushl $128
80106239:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010623e:	e9 a2 f6 ff ff       	jmp    801058e5 <alltraps>

80106243 <vector129>:
.globl vector129
vector129:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $129
80106245:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010624a:	e9 96 f6 ff ff       	jmp    801058e5 <alltraps>

8010624f <vector130>:
.globl vector130
vector130:
  pushl $0
8010624f:	6a 00                	push   $0x0
  pushl $130
80106251:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106256:	e9 8a f6 ff ff       	jmp    801058e5 <alltraps>

8010625b <vector131>:
.globl vector131
vector131:
  pushl $0
8010625b:	6a 00                	push   $0x0
  pushl $131
8010625d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106262:	e9 7e f6 ff ff       	jmp    801058e5 <alltraps>

80106267 <vector132>:
.globl vector132
vector132:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $132
80106269:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010626e:	e9 72 f6 ff ff       	jmp    801058e5 <alltraps>

80106273 <vector133>:
.globl vector133
vector133:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $133
80106275:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010627a:	e9 66 f6 ff ff       	jmp    801058e5 <alltraps>

8010627f <vector134>:
.globl vector134
vector134:
  pushl $0
8010627f:	6a 00                	push   $0x0
  pushl $134
80106281:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106286:	e9 5a f6 ff ff       	jmp    801058e5 <alltraps>

8010628b <vector135>:
.globl vector135
vector135:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $135
8010628d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106292:	e9 4e f6 ff ff       	jmp    801058e5 <alltraps>

80106297 <vector136>:
.globl vector136
vector136:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $136
80106299:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010629e:	e9 42 f6 ff ff       	jmp    801058e5 <alltraps>

801062a3 <vector137>:
.globl vector137
vector137:
  pushl $0
801062a3:	6a 00                	push   $0x0
  pushl $137
801062a5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801062aa:	e9 36 f6 ff ff       	jmp    801058e5 <alltraps>

801062af <vector138>:
.globl vector138
vector138:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $138
801062b1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801062b6:	e9 2a f6 ff ff       	jmp    801058e5 <alltraps>

801062bb <vector139>:
.globl vector139
vector139:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $139
801062bd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801062c2:	e9 1e f6 ff ff       	jmp    801058e5 <alltraps>

801062c7 <vector140>:
.globl vector140
vector140:
  pushl $0
801062c7:	6a 00                	push   $0x0
  pushl $140
801062c9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801062ce:	e9 12 f6 ff ff       	jmp    801058e5 <alltraps>

801062d3 <vector141>:
.globl vector141
vector141:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $141
801062d5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801062da:	e9 06 f6 ff ff       	jmp    801058e5 <alltraps>

801062df <vector142>:
.globl vector142
vector142:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $142
801062e1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801062e6:	e9 fa f5 ff ff       	jmp    801058e5 <alltraps>

801062eb <vector143>:
.globl vector143
vector143:
  pushl $0
801062eb:	6a 00                	push   $0x0
  pushl $143
801062ed:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801062f2:	e9 ee f5 ff ff       	jmp    801058e5 <alltraps>

801062f7 <vector144>:
.globl vector144
vector144:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $144
801062f9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801062fe:	e9 e2 f5 ff ff       	jmp    801058e5 <alltraps>

80106303 <vector145>:
.globl vector145
vector145:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $145
80106305:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010630a:	e9 d6 f5 ff ff       	jmp    801058e5 <alltraps>

8010630f <vector146>:
.globl vector146
vector146:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $146
80106311:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106316:	e9 ca f5 ff ff       	jmp    801058e5 <alltraps>

8010631b <vector147>:
.globl vector147
vector147:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $147
8010631d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106322:	e9 be f5 ff ff       	jmp    801058e5 <alltraps>

80106327 <vector148>:
.globl vector148
vector148:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $148
80106329:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010632e:	e9 b2 f5 ff ff       	jmp    801058e5 <alltraps>

80106333 <vector149>:
.globl vector149
vector149:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $149
80106335:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010633a:	e9 a6 f5 ff ff       	jmp    801058e5 <alltraps>

8010633f <vector150>:
.globl vector150
vector150:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $150
80106341:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106346:	e9 9a f5 ff ff       	jmp    801058e5 <alltraps>

8010634b <vector151>:
.globl vector151
vector151:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $151
8010634d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106352:	e9 8e f5 ff ff       	jmp    801058e5 <alltraps>

80106357 <vector152>:
.globl vector152
vector152:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $152
80106359:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010635e:	e9 82 f5 ff ff       	jmp    801058e5 <alltraps>

80106363 <vector153>:
.globl vector153
vector153:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $153
80106365:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010636a:	e9 76 f5 ff ff       	jmp    801058e5 <alltraps>

8010636f <vector154>:
.globl vector154
vector154:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $154
80106371:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106376:	e9 6a f5 ff ff       	jmp    801058e5 <alltraps>

8010637b <vector155>:
.globl vector155
vector155:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $155
8010637d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106382:	e9 5e f5 ff ff       	jmp    801058e5 <alltraps>

80106387 <vector156>:
.globl vector156
vector156:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $156
80106389:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010638e:	e9 52 f5 ff ff       	jmp    801058e5 <alltraps>

80106393 <vector157>:
.globl vector157
vector157:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $157
80106395:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010639a:	e9 46 f5 ff ff       	jmp    801058e5 <alltraps>

8010639f <vector158>:
.globl vector158
vector158:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $158
801063a1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801063a6:	e9 3a f5 ff ff       	jmp    801058e5 <alltraps>

801063ab <vector159>:
.globl vector159
vector159:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $159
801063ad:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801063b2:	e9 2e f5 ff ff       	jmp    801058e5 <alltraps>

801063b7 <vector160>:
.globl vector160
vector160:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $160
801063b9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801063be:	e9 22 f5 ff ff       	jmp    801058e5 <alltraps>

801063c3 <vector161>:
.globl vector161
vector161:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $161
801063c5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801063ca:	e9 16 f5 ff ff       	jmp    801058e5 <alltraps>

801063cf <vector162>:
.globl vector162
vector162:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $162
801063d1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801063d6:	e9 0a f5 ff ff       	jmp    801058e5 <alltraps>

801063db <vector163>:
.globl vector163
vector163:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $163
801063dd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801063e2:	e9 fe f4 ff ff       	jmp    801058e5 <alltraps>

801063e7 <vector164>:
.globl vector164
vector164:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $164
801063e9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801063ee:	e9 f2 f4 ff ff       	jmp    801058e5 <alltraps>

801063f3 <vector165>:
.globl vector165
vector165:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $165
801063f5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801063fa:	e9 e6 f4 ff ff       	jmp    801058e5 <alltraps>

801063ff <vector166>:
.globl vector166
vector166:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $166
80106401:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106406:	e9 da f4 ff ff       	jmp    801058e5 <alltraps>

8010640b <vector167>:
.globl vector167
vector167:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $167
8010640d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106412:	e9 ce f4 ff ff       	jmp    801058e5 <alltraps>

80106417 <vector168>:
.globl vector168
vector168:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $168
80106419:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010641e:	e9 c2 f4 ff ff       	jmp    801058e5 <alltraps>

80106423 <vector169>:
.globl vector169
vector169:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $169
80106425:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010642a:	e9 b6 f4 ff ff       	jmp    801058e5 <alltraps>

8010642f <vector170>:
.globl vector170
vector170:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $170
80106431:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106436:	e9 aa f4 ff ff       	jmp    801058e5 <alltraps>

8010643b <vector171>:
.globl vector171
vector171:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $171
8010643d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106442:	e9 9e f4 ff ff       	jmp    801058e5 <alltraps>

80106447 <vector172>:
.globl vector172
vector172:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $172
80106449:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010644e:	e9 92 f4 ff ff       	jmp    801058e5 <alltraps>

80106453 <vector173>:
.globl vector173
vector173:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $173
80106455:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010645a:	e9 86 f4 ff ff       	jmp    801058e5 <alltraps>

8010645f <vector174>:
.globl vector174
vector174:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $174
80106461:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106466:	e9 7a f4 ff ff       	jmp    801058e5 <alltraps>

8010646b <vector175>:
.globl vector175
vector175:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $175
8010646d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106472:	e9 6e f4 ff ff       	jmp    801058e5 <alltraps>

80106477 <vector176>:
.globl vector176
vector176:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $176
80106479:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010647e:	e9 62 f4 ff ff       	jmp    801058e5 <alltraps>

80106483 <vector177>:
.globl vector177
vector177:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $177
80106485:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010648a:	e9 56 f4 ff ff       	jmp    801058e5 <alltraps>

8010648f <vector178>:
.globl vector178
vector178:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $178
80106491:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106496:	e9 4a f4 ff ff       	jmp    801058e5 <alltraps>

8010649b <vector179>:
.globl vector179
vector179:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $179
8010649d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801064a2:	e9 3e f4 ff ff       	jmp    801058e5 <alltraps>

801064a7 <vector180>:
.globl vector180
vector180:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $180
801064a9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801064ae:	e9 32 f4 ff ff       	jmp    801058e5 <alltraps>

801064b3 <vector181>:
.globl vector181
vector181:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $181
801064b5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801064ba:	e9 26 f4 ff ff       	jmp    801058e5 <alltraps>

801064bf <vector182>:
.globl vector182
vector182:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $182
801064c1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801064c6:	e9 1a f4 ff ff       	jmp    801058e5 <alltraps>

801064cb <vector183>:
.globl vector183
vector183:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $183
801064cd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801064d2:	e9 0e f4 ff ff       	jmp    801058e5 <alltraps>

801064d7 <vector184>:
.globl vector184
vector184:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $184
801064d9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801064de:	e9 02 f4 ff ff       	jmp    801058e5 <alltraps>

801064e3 <vector185>:
.globl vector185
vector185:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $185
801064e5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801064ea:	e9 f6 f3 ff ff       	jmp    801058e5 <alltraps>

801064ef <vector186>:
.globl vector186
vector186:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $186
801064f1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801064f6:	e9 ea f3 ff ff       	jmp    801058e5 <alltraps>

801064fb <vector187>:
.globl vector187
vector187:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $187
801064fd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106502:	e9 de f3 ff ff       	jmp    801058e5 <alltraps>

80106507 <vector188>:
.globl vector188
vector188:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $188
80106509:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010650e:	e9 d2 f3 ff ff       	jmp    801058e5 <alltraps>

80106513 <vector189>:
.globl vector189
vector189:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $189
80106515:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010651a:	e9 c6 f3 ff ff       	jmp    801058e5 <alltraps>

8010651f <vector190>:
.globl vector190
vector190:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $190
80106521:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106526:	e9 ba f3 ff ff       	jmp    801058e5 <alltraps>

8010652b <vector191>:
.globl vector191
vector191:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $191
8010652d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106532:	e9 ae f3 ff ff       	jmp    801058e5 <alltraps>

80106537 <vector192>:
.globl vector192
vector192:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $192
80106539:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010653e:	e9 a2 f3 ff ff       	jmp    801058e5 <alltraps>

80106543 <vector193>:
.globl vector193
vector193:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $193
80106545:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010654a:	e9 96 f3 ff ff       	jmp    801058e5 <alltraps>

8010654f <vector194>:
.globl vector194
vector194:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $194
80106551:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106556:	e9 8a f3 ff ff       	jmp    801058e5 <alltraps>

8010655b <vector195>:
.globl vector195
vector195:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $195
8010655d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106562:	e9 7e f3 ff ff       	jmp    801058e5 <alltraps>

80106567 <vector196>:
.globl vector196
vector196:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $196
80106569:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010656e:	e9 72 f3 ff ff       	jmp    801058e5 <alltraps>

80106573 <vector197>:
.globl vector197
vector197:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $197
80106575:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010657a:	e9 66 f3 ff ff       	jmp    801058e5 <alltraps>

8010657f <vector198>:
.globl vector198
vector198:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $198
80106581:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106586:	e9 5a f3 ff ff       	jmp    801058e5 <alltraps>

8010658b <vector199>:
.globl vector199
vector199:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $199
8010658d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106592:	e9 4e f3 ff ff       	jmp    801058e5 <alltraps>

80106597 <vector200>:
.globl vector200
vector200:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $200
80106599:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010659e:	e9 42 f3 ff ff       	jmp    801058e5 <alltraps>

801065a3 <vector201>:
.globl vector201
vector201:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $201
801065a5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801065aa:	e9 36 f3 ff ff       	jmp    801058e5 <alltraps>

801065af <vector202>:
.globl vector202
vector202:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $202
801065b1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801065b6:	e9 2a f3 ff ff       	jmp    801058e5 <alltraps>

801065bb <vector203>:
.globl vector203
vector203:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $203
801065bd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801065c2:	e9 1e f3 ff ff       	jmp    801058e5 <alltraps>

801065c7 <vector204>:
.globl vector204
vector204:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $204
801065c9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801065ce:	e9 12 f3 ff ff       	jmp    801058e5 <alltraps>

801065d3 <vector205>:
.globl vector205
vector205:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $205
801065d5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801065da:	e9 06 f3 ff ff       	jmp    801058e5 <alltraps>

801065df <vector206>:
.globl vector206
vector206:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $206
801065e1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801065e6:	e9 fa f2 ff ff       	jmp    801058e5 <alltraps>

801065eb <vector207>:
.globl vector207
vector207:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $207
801065ed:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801065f2:	e9 ee f2 ff ff       	jmp    801058e5 <alltraps>

801065f7 <vector208>:
.globl vector208
vector208:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $208
801065f9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801065fe:	e9 e2 f2 ff ff       	jmp    801058e5 <alltraps>

80106603 <vector209>:
.globl vector209
vector209:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $209
80106605:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010660a:	e9 d6 f2 ff ff       	jmp    801058e5 <alltraps>

8010660f <vector210>:
.globl vector210
vector210:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $210
80106611:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106616:	e9 ca f2 ff ff       	jmp    801058e5 <alltraps>

8010661b <vector211>:
.globl vector211
vector211:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $211
8010661d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106622:	e9 be f2 ff ff       	jmp    801058e5 <alltraps>

80106627 <vector212>:
.globl vector212
vector212:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $212
80106629:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010662e:	e9 b2 f2 ff ff       	jmp    801058e5 <alltraps>

80106633 <vector213>:
.globl vector213
vector213:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $213
80106635:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010663a:	e9 a6 f2 ff ff       	jmp    801058e5 <alltraps>

8010663f <vector214>:
.globl vector214
vector214:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $214
80106641:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106646:	e9 9a f2 ff ff       	jmp    801058e5 <alltraps>

8010664b <vector215>:
.globl vector215
vector215:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $215
8010664d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106652:	e9 8e f2 ff ff       	jmp    801058e5 <alltraps>

80106657 <vector216>:
.globl vector216
vector216:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $216
80106659:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010665e:	e9 82 f2 ff ff       	jmp    801058e5 <alltraps>

80106663 <vector217>:
.globl vector217
vector217:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $217
80106665:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010666a:	e9 76 f2 ff ff       	jmp    801058e5 <alltraps>

8010666f <vector218>:
.globl vector218
vector218:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $218
80106671:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106676:	e9 6a f2 ff ff       	jmp    801058e5 <alltraps>

8010667b <vector219>:
.globl vector219
vector219:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $219
8010667d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106682:	e9 5e f2 ff ff       	jmp    801058e5 <alltraps>

80106687 <vector220>:
.globl vector220
vector220:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $220
80106689:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010668e:	e9 52 f2 ff ff       	jmp    801058e5 <alltraps>

80106693 <vector221>:
.globl vector221
vector221:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $221
80106695:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010669a:	e9 46 f2 ff ff       	jmp    801058e5 <alltraps>

8010669f <vector222>:
.globl vector222
vector222:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $222
801066a1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801066a6:	e9 3a f2 ff ff       	jmp    801058e5 <alltraps>

801066ab <vector223>:
.globl vector223
vector223:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $223
801066ad:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801066b2:	e9 2e f2 ff ff       	jmp    801058e5 <alltraps>

801066b7 <vector224>:
.globl vector224
vector224:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $224
801066b9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801066be:	e9 22 f2 ff ff       	jmp    801058e5 <alltraps>

801066c3 <vector225>:
.globl vector225
vector225:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $225
801066c5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801066ca:	e9 16 f2 ff ff       	jmp    801058e5 <alltraps>

801066cf <vector226>:
.globl vector226
vector226:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $226
801066d1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801066d6:	e9 0a f2 ff ff       	jmp    801058e5 <alltraps>

801066db <vector227>:
.globl vector227
vector227:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $227
801066dd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801066e2:	e9 fe f1 ff ff       	jmp    801058e5 <alltraps>

801066e7 <vector228>:
.globl vector228
vector228:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $228
801066e9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801066ee:	e9 f2 f1 ff ff       	jmp    801058e5 <alltraps>

801066f3 <vector229>:
.globl vector229
vector229:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $229
801066f5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801066fa:	e9 e6 f1 ff ff       	jmp    801058e5 <alltraps>

801066ff <vector230>:
.globl vector230
vector230:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $230
80106701:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106706:	e9 da f1 ff ff       	jmp    801058e5 <alltraps>

8010670b <vector231>:
.globl vector231
vector231:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $231
8010670d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106712:	e9 ce f1 ff ff       	jmp    801058e5 <alltraps>

80106717 <vector232>:
.globl vector232
vector232:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $232
80106719:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010671e:	e9 c2 f1 ff ff       	jmp    801058e5 <alltraps>

80106723 <vector233>:
.globl vector233
vector233:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $233
80106725:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010672a:	e9 b6 f1 ff ff       	jmp    801058e5 <alltraps>

8010672f <vector234>:
.globl vector234
vector234:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $234
80106731:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106736:	e9 aa f1 ff ff       	jmp    801058e5 <alltraps>

8010673b <vector235>:
.globl vector235
vector235:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $235
8010673d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106742:	e9 9e f1 ff ff       	jmp    801058e5 <alltraps>

80106747 <vector236>:
.globl vector236
vector236:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $236
80106749:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010674e:	e9 92 f1 ff ff       	jmp    801058e5 <alltraps>

80106753 <vector237>:
.globl vector237
vector237:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $237
80106755:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010675a:	e9 86 f1 ff ff       	jmp    801058e5 <alltraps>

8010675f <vector238>:
.globl vector238
vector238:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $238
80106761:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106766:	e9 7a f1 ff ff       	jmp    801058e5 <alltraps>

8010676b <vector239>:
.globl vector239
vector239:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $239
8010676d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106772:	e9 6e f1 ff ff       	jmp    801058e5 <alltraps>

80106777 <vector240>:
.globl vector240
vector240:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $240
80106779:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010677e:	e9 62 f1 ff ff       	jmp    801058e5 <alltraps>

80106783 <vector241>:
.globl vector241
vector241:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $241
80106785:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010678a:	e9 56 f1 ff ff       	jmp    801058e5 <alltraps>

8010678f <vector242>:
.globl vector242
vector242:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $242
80106791:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106796:	e9 4a f1 ff ff       	jmp    801058e5 <alltraps>

8010679b <vector243>:
.globl vector243
vector243:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $243
8010679d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801067a2:	e9 3e f1 ff ff       	jmp    801058e5 <alltraps>

801067a7 <vector244>:
.globl vector244
vector244:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $244
801067a9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801067ae:	e9 32 f1 ff ff       	jmp    801058e5 <alltraps>

801067b3 <vector245>:
.globl vector245
vector245:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $245
801067b5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801067ba:	e9 26 f1 ff ff       	jmp    801058e5 <alltraps>

801067bf <vector246>:
.globl vector246
vector246:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $246
801067c1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801067c6:	e9 1a f1 ff ff       	jmp    801058e5 <alltraps>

801067cb <vector247>:
.globl vector247
vector247:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $247
801067cd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801067d2:	e9 0e f1 ff ff       	jmp    801058e5 <alltraps>

801067d7 <vector248>:
.globl vector248
vector248:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $248
801067d9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801067de:	e9 02 f1 ff ff       	jmp    801058e5 <alltraps>

801067e3 <vector249>:
.globl vector249
vector249:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $249
801067e5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801067ea:	e9 f6 f0 ff ff       	jmp    801058e5 <alltraps>

801067ef <vector250>:
.globl vector250
vector250:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $250
801067f1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801067f6:	e9 ea f0 ff ff       	jmp    801058e5 <alltraps>

801067fb <vector251>:
.globl vector251
vector251:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $251
801067fd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106802:	e9 de f0 ff ff       	jmp    801058e5 <alltraps>

80106807 <vector252>:
.globl vector252
vector252:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $252
80106809:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010680e:	e9 d2 f0 ff ff       	jmp    801058e5 <alltraps>

80106813 <vector253>:
.globl vector253
vector253:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $253
80106815:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010681a:	e9 c6 f0 ff ff       	jmp    801058e5 <alltraps>

8010681f <vector254>:
.globl vector254
vector254:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $254
80106821:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106826:	e9 ba f0 ff ff       	jmp    801058e5 <alltraps>

8010682b <vector255>:
.globl vector255
vector255:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $255
8010682d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106832:	e9 ae f0 ff ff       	jmp    801058e5 <alltraps>
80106837:	66 90                	xchg   %ax,%ax
80106839:	66 90                	xchg   %ax,%ax
8010683b:	66 90                	xchg   %ax,%ax
8010683d:	66 90                	xchg   %ax,%ax
8010683f:	90                   	nop

80106840 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106840:	55                   	push   %ebp
80106841:	89 e5                	mov    %esp,%ebp
80106843:	57                   	push   %edi
80106844:	56                   	push   %esi
80106845:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106847:	c1 ea 16             	shr    $0x16,%edx
{
8010684a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
8010684b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
8010684e:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106851:	8b 07                	mov    (%edi),%eax
80106853:	a8 01                	test   $0x1,%al
80106855:	74 29                	je     80106880 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106857:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010685c:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106862:	c1 ee 0a             	shr    $0xa,%esi
}
80106865:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106868:	89 f2                	mov    %esi,%edx
8010686a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106870:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106873:	5b                   	pop    %ebx
80106874:	5e                   	pop    %esi
80106875:	5f                   	pop    %edi
80106876:	5d                   	pop    %ebp
80106877:	c3                   	ret    
80106878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010687f:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106880:	85 c9                	test   %ecx,%ecx
80106882:	74 2c                	je     801068b0 <walkpgdir+0x70>
80106884:	e8 27 bd ff ff       	call   801025b0 <kalloc>
80106889:	89 c3                	mov    %eax,%ebx
8010688b:	85 c0                	test   %eax,%eax
8010688d:	74 21                	je     801068b0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010688f:	83 ec 04             	sub    $0x4,%esp
80106892:	68 00 10 00 00       	push   $0x1000
80106897:	6a 00                	push   $0x0
80106899:	50                   	push   %eax
8010689a:	e8 61 de ff ff       	call   80104700 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010689f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801068a5:	83 c4 10             	add    $0x10,%esp
801068a8:	83 c8 07             	or     $0x7,%eax
801068ab:	89 07                	mov    %eax,(%edi)
801068ad:	eb b3                	jmp    80106862 <walkpgdir+0x22>
801068af:	90                   	nop
}
801068b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801068b3:	31 c0                	xor    %eax,%eax
}
801068b5:	5b                   	pop    %ebx
801068b6:	5e                   	pop    %esi
801068b7:	5f                   	pop    %edi
801068b8:	5d                   	pop    %ebp
801068b9:	c3                   	ret    
801068ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801068c0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	57                   	push   %edi
801068c4:	56                   	push   %esi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801068c5:	89 d6                	mov    %edx,%esi
{
801068c7:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
801068c8:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
801068ce:	83 ec 1c             	sub    $0x1c,%esp
801068d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801068d4:	8b 7d 08             	mov    0x8(%ebp),%edi
801068d7:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801068db:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801068e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801068e3:	29 f7                	sub    %esi,%edi
801068e5:	eb 21                	jmp    80106908 <mappages+0x48>
801068e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068ee:	66 90                	xchg   %ax,%ax
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801068f0:	f6 00 01             	testb  $0x1,(%eax)
801068f3:	75 45                	jne    8010693a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801068f5:	0b 5d 0c             	or     0xc(%ebp),%ebx
801068f8:	83 cb 01             	or     $0x1,%ebx
801068fb:	89 18                	mov    %ebx,(%eax)
    if(a == last)
801068fd:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80106900:	74 2e                	je     80106930 <mappages+0x70>
      break;
    a += PGSIZE;
80106902:	81 c6 00 10 00 00    	add    $0x1000,%esi
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106908:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010690b:	b9 01 00 00 00       	mov    $0x1,%ecx
80106910:	89 f2                	mov    %esi,%edx
80106912:	8d 1c 3e             	lea    (%esi,%edi,1),%ebx
80106915:	e8 26 ff ff ff       	call   80106840 <walkpgdir>
8010691a:	85 c0                	test   %eax,%eax
8010691c:	75 d2                	jne    801068f0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010691e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106921:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106926:	5b                   	pop    %ebx
80106927:	5e                   	pop    %esi
80106928:	5f                   	pop    %edi
80106929:	5d                   	pop    %ebp
8010692a:	c3                   	ret    
8010692b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010692f:	90                   	nop
80106930:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106933:	31 c0                	xor    %eax,%eax
}
80106935:	5b                   	pop    %ebx
80106936:	5e                   	pop    %esi
80106937:	5f                   	pop    %edi
80106938:	5d                   	pop    %ebp
80106939:	c3                   	ret    
      panic("remap");
8010693a:	83 ec 0c             	sub    $0xc,%esp
8010693d:	68 34 7b 10 80       	push   $0x80107b34
80106942:	e8 49 9a ff ff       	call   80100390 <panic>
80106947:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010694e:	66 90                	xchg   %ax,%ax

80106950 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106950:	55                   	push   %ebp
80106951:	89 e5                	mov    %esp,%ebp
80106953:	57                   	push   %edi
80106954:	89 c7                	mov    %eax,%edi
80106956:	56                   	push   %esi
80106957:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106958:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010695e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106964:	83 ec 1c             	sub    $0x1c,%esp
80106967:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010696a:	39 d3                	cmp    %edx,%ebx
8010696c:	73 5a                	jae    801069c8 <deallocuvm.part.0+0x78>
8010696e:	89 d6                	mov    %edx,%esi
80106970:	eb 10                	jmp    80106982 <deallocuvm.part.0+0x32>
80106972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106978:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010697e:	39 de                	cmp    %ebx,%esi
80106980:	76 46                	jbe    801069c8 <deallocuvm.part.0+0x78>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106982:	31 c9                	xor    %ecx,%ecx
80106984:	89 da                	mov    %ebx,%edx
80106986:	89 f8                	mov    %edi,%eax
80106988:	e8 b3 fe ff ff       	call   80106840 <walkpgdir>
    if(!pte)
8010698d:	85 c0                	test   %eax,%eax
8010698f:	74 47                	je     801069d8 <deallocuvm.part.0+0x88>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106991:	8b 10                	mov    (%eax),%edx
80106993:	f6 c2 01             	test   $0x1,%dl
80106996:	74 e0                	je     80106978 <deallocuvm.part.0+0x28>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106998:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
8010699e:	74 46                	je     801069e6 <deallocuvm.part.0+0x96>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801069a0:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801069a3:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801069a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801069ac:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069b2:	52                   	push   %edx
801069b3:	e8 38 ba ff ff       	call   801023f0 <kfree>
      *pte = 0;
801069b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069bb:	83 c4 10             	add    $0x10,%esp
801069be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801069c4:	39 de                	cmp    %ebx,%esi
801069c6:	77 ba                	ja     80106982 <deallocuvm.part.0+0x32>
    }
  }
  return newsz;
}
801069c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801069cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069ce:	5b                   	pop    %ebx
801069cf:	5e                   	pop    %esi
801069d0:	5f                   	pop    %edi
801069d1:	5d                   	pop    %ebp
801069d2:	c3                   	ret    
801069d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801069d7:	90                   	nop
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801069d8:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801069de:	81 c3 00 00 40 00    	add    $0x400000,%ebx
801069e4:	eb 98                	jmp    8010697e <deallocuvm.part.0+0x2e>
        panic("kfree");
801069e6:	83 ec 0c             	sub    $0xc,%esp
801069e9:	68 c2 73 10 80       	push   $0x801073c2
801069ee:	e8 9d 99 ff ff       	call   80100390 <panic>
801069f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106a00 <seginit>:
{
80106a00:	55                   	push   %ebp
80106a01:	89 e5                	mov    %esp,%ebp
80106a03:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106a06:	e8 c5 ce ff ff       	call   801038d0 <cpuid>
  pd[0] = size-1;
80106a0b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106a10:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106a16:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a1a:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
80106a21:	ff 00 00 
80106a24:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
80106a2b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a2e:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
80106a35:	ff 00 00 
80106a38:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
80106a3f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a42:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
80106a49:	ff 00 00 
80106a4c:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
80106a53:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a56:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
80106a5d:	ff 00 00 
80106a60:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
80106a67:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106a6a:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
80106a6f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106a73:	c1 e8 10             	shr    $0x10,%eax
80106a76:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106a7a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106a7d:	0f 01 10             	lgdtl  (%eax)
}
80106a80:	c9                   	leave  
80106a81:	c3                   	ret    
80106a82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a90 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106a90:	a1 a4 57 11 80       	mov    0x801157a4,%eax
80106a95:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106a9a:	0f 22 d8             	mov    %eax,%cr3
}
80106a9d:	c3                   	ret    
80106a9e:	66 90                	xchg   %ax,%ax

80106aa0 <switchuvm>:
{
80106aa0:	55                   	push   %ebp
80106aa1:	89 e5                	mov    %esp,%ebp
80106aa3:	57                   	push   %edi
80106aa4:	56                   	push   %esi
80106aa5:	53                   	push   %ebx
80106aa6:	83 ec 1c             	sub    $0x1c,%esp
80106aa9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106aac:	85 db                	test   %ebx,%ebx
80106aae:	0f 84 cb 00 00 00    	je     80106b7f <switchuvm+0xdf>
  if(p->kstack == 0)
80106ab4:	8b 43 14             	mov    0x14(%ebx),%eax
80106ab7:	85 c0                	test   %eax,%eax
80106ab9:	0f 84 da 00 00 00    	je     80106b99 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106abf:	8b 43 10             	mov    0x10(%ebx),%eax
80106ac2:	85 c0                	test   %eax,%eax
80106ac4:	0f 84 c2 00 00 00    	je     80106b8c <switchuvm+0xec>
  pushcli();
80106aca:	e8 71 da ff ff       	call   80104540 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106acf:	e8 7c cd ff ff       	call   80103850 <mycpu>
80106ad4:	89 c6                	mov    %eax,%esi
80106ad6:	e8 75 cd ff ff       	call   80103850 <mycpu>
80106adb:	89 c7                	mov    %eax,%edi
80106add:	e8 6e cd ff ff       	call   80103850 <mycpu>
80106ae2:	83 c7 08             	add    $0x8,%edi
80106ae5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ae8:	e8 63 cd ff ff       	call   80103850 <mycpu>
80106aed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106af0:	ba 67 00 00 00       	mov    $0x67,%edx
80106af5:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106afc:	83 c0 08             	add    $0x8,%eax
80106aff:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b06:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b0b:	83 c1 08             	add    $0x8,%ecx
80106b0e:	c1 e8 18             	shr    $0x18,%eax
80106b11:	c1 e9 10             	shr    $0x10,%ecx
80106b14:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
80106b1a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106b20:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106b25:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106b2c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106b31:	e8 1a cd ff ff       	call   80103850 <mycpu>
80106b36:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106b3d:	e8 0e cd ff ff       	call   80103850 <mycpu>
80106b42:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106b46:	8b 73 14             	mov    0x14(%ebx),%esi
80106b49:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106b4f:	e8 fc cc ff ff       	call   80103850 <mycpu>
80106b54:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b57:	e8 f4 cc ff ff       	call   80103850 <mycpu>
80106b5c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106b60:	b8 28 00 00 00       	mov    $0x28,%eax
80106b65:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106b68:	8b 43 10             	mov    0x10(%ebx),%eax
80106b6b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b70:	0f 22 d8             	mov    %eax,%cr3
}
80106b73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b76:	5b                   	pop    %ebx
80106b77:	5e                   	pop    %esi
80106b78:	5f                   	pop    %edi
80106b79:	5d                   	pop    %ebp
  popcli();
80106b7a:	e9 d1 da ff ff       	jmp    80104650 <popcli>
    panic("switchuvm: no process");
80106b7f:	83 ec 0c             	sub    $0xc,%esp
80106b82:	68 3a 7b 10 80       	push   $0x80107b3a
80106b87:	e8 04 98 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106b8c:	83 ec 0c             	sub    $0xc,%esp
80106b8f:	68 65 7b 10 80       	push   $0x80107b65
80106b94:	e8 f7 97 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106b99:	83 ec 0c             	sub    $0xc,%esp
80106b9c:	68 50 7b 10 80       	push   $0x80107b50
80106ba1:	e8 ea 97 ff ff       	call   80100390 <panic>
80106ba6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bad:	8d 76 00             	lea    0x0(%esi),%esi

80106bb0 <inituvm>:
{
80106bb0:	55                   	push   %ebp
80106bb1:	89 e5                	mov    %esp,%ebp
80106bb3:	57                   	push   %edi
80106bb4:	56                   	push   %esi
80106bb5:	53                   	push   %ebx
80106bb6:	83 ec 1c             	sub    $0x1c,%esp
80106bb9:	8b 45 08             	mov    0x8(%ebp),%eax
80106bbc:	8b 75 10             	mov    0x10(%ebp),%esi
80106bbf:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106bc2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106bc5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106bcb:	77 49                	ja     80106c16 <inituvm+0x66>
  mem = kalloc();
80106bcd:	e8 de b9 ff ff       	call   801025b0 <kalloc>
  memset(mem, 0, PGSIZE);
80106bd2:	83 ec 04             	sub    $0x4,%esp
80106bd5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106bda:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106bdc:	6a 00                	push   $0x0
80106bde:	50                   	push   %eax
80106bdf:	e8 1c db ff ff       	call   80104700 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106be4:	58                   	pop    %eax
80106be5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106beb:	5a                   	pop    %edx
80106bec:	6a 06                	push   $0x6
80106bee:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106bf3:	31 d2                	xor    %edx,%edx
80106bf5:	50                   	push   %eax
80106bf6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106bf9:	e8 c2 fc ff ff       	call   801068c0 <mappages>
  memmove(mem, init, sz);
80106bfe:	89 75 10             	mov    %esi,0x10(%ebp)
80106c01:	83 c4 10             	add    $0x10,%esp
80106c04:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106c07:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106c0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c0d:	5b                   	pop    %ebx
80106c0e:	5e                   	pop    %esi
80106c0f:	5f                   	pop    %edi
80106c10:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106c11:	e9 8a db ff ff       	jmp    801047a0 <memmove>
    panic("inituvm: more than a page");
80106c16:	83 ec 0c             	sub    $0xc,%esp
80106c19:	68 79 7b 10 80       	push   $0x80107b79
80106c1e:	e8 6d 97 ff ff       	call   80100390 <panic>
80106c23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106c30 <loaduvm>:
{
80106c30:	55                   	push   %ebp
80106c31:	89 e5                	mov    %esp,%ebp
80106c33:	57                   	push   %edi
80106c34:	56                   	push   %esi
80106c35:	53                   	push   %ebx
80106c36:	83 ec 1c             	sub    $0x1c,%esp
80106c39:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c3c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80106c3f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106c44:	0f 85 8d 00 00 00    	jne    80106cd7 <loaduvm+0xa7>
80106c4a:	01 f0                	add    %esi,%eax
  for(i = 0; i < sz; i += PGSIZE){
80106c4c:	89 f3                	mov    %esi,%ebx
80106c4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106c51:	8b 45 14             	mov    0x14(%ebp),%eax
80106c54:	01 f0                	add    %esi,%eax
80106c56:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80106c59:	85 f6                	test   %esi,%esi
80106c5b:	75 11                	jne    80106c6e <loaduvm+0x3e>
80106c5d:	eb 61                	jmp    80106cc0 <loaduvm+0x90>
80106c5f:	90                   	nop
80106c60:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80106c66:	89 f0                	mov    %esi,%eax
80106c68:	29 d8                	sub    %ebx,%eax
80106c6a:	39 c6                	cmp    %eax,%esi
80106c6c:	76 52                	jbe    80106cc0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106c6e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106c71:	8b 45 08             	mov    0x8(%ebp),%eax
80106c74:	31 c9                	xor    %ecx,%ecx
80106c76:	29 da                	sub    %ebx,%edx
80106c78:	e8 c3 fb ff ff       	call   80106840 <walkpgdir>
80106c7d:	85 c0                	test   %eax,%eax
80106c7f:	74 49                	je     80106cca <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106c81:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106c83:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80106c86:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106c8b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106c90:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80106c96:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106c99:	29 d9                	sub    %ebx,%ecx
80106c9b:	05 00 00 00 80       	add    $0x80000000,%eax
80106ca0:	57                   	push   %edi
80106ca1:	51                   	push   %ecx
80106ca2:	50                   	push   %eax
80106ca3:	ff 75 10             	pushl  0x10(%ebp)
80106ca6:	e8 55 ad ff ff       	call   80101a00 <readi>
80106cab:	83 c4 10             	add    $0x10,%esp
80106cae:	39 f8                	cmp    %edi,%eax
80106cb0:	74 ae                	je     80106c60 <loaduvm+0x30>
}
80106cb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106cb5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106cba:	5b                   	pop    %ebx
80106cbb:	5e                   	pop    %esi
80106cbc:	5f                   	pop    %edi
80106cbd:	5d                   	pop    %ebp
80106cbe:	c3                   	ret    
80106cbf:	90                   	nop
80106cc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106cc3:	31 c0                	xor    %eax,%eax
}
80106cc5:	5b                   	pop    %ebx
80106cc6:	5e                   	pop    %esi
80106cc7:	5f                   	pop    %edi
80106cc8:	5d                   	pop    %ebp
80106cc9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106cca:	83 ec 0c             	sub    $0xc,%esp
80106ccd:	68 93 7b 10 80       	push   $0x80107b93
80106cd2:	e8 b9 96 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106cd7:	83 ec 0c             	sub    $0xc,%esp
80106cda:	68 34 7c 10 80       	push   $0x80107c34
80106cdf:	e8 ac 96 ff ff       	call   80100390 <panic>
80106ce4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ceb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106cef:	90                   	nop

80106cf0 <allocuvm>:
{
80106cf0:	55                   	push   %ebp
80106cf1:	89 e5                	mov    %esp,%ebp
80106cf3:	57                   	push   %edi
80106cf4:	56                   	push   %esi
80106cf5:	53                   	push   %ebx
80106cf6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106cf9:	8b 7d 10             	mov    0x10(%ebp),%edi
80106cfc:	85 ff                	test   %edi,%edi
80106cfe:	0f 88 bc 00 00 00    	js     80106dc0 <allocuvm+0xd0>
  if(newsz < oldsz)
80106d04:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106d07:	0f 82 a3 00 00 00    	jb     80106db0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106d0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d10:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106d16:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106d1c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106d1f:	0f 86 8e 00 00 00    	jbe    80106db3 <allocuvm+0xc3>
80106d25:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106d28:	8b 7d 08             	mov    0x8(%ebp),%edi
80106d2b:	eb 42                	jmp    80106d6f <allocuvm+0x7f>
80106d2d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106d30:	83 ec 04             	sub    $0x4,%esp
80106d33:	68 00 10 00 00       	push   $0x1000
80106d38:	6a 00                	push   $0x0
80106d3a:	50                   	push   %eax
80106d3b:	e8 c0 d9 ff ff       	call   80104700 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106d40:	58                   	pop    %eax
80106d41:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106d47:	5a                   	pop    %edx
80106d48:	6a 06                	push   $0x6
80106d4a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d4f:	89 da                	mov    %ebx,%edx
80106d51:	50                   	push   %eax
80106d52:	89 f8                	mov    %edi,%eax
80106d54:	e8 67 fb ff ff       	call   801068c0 <mappages>
80106d59:	83 c4 10             	add    $0x10,%esp
80106d5c:	85 c0                	test   %eax,%eax
80106d5e:	78 70                	js     80106dd0 <allocuvm+0xe0>
  for(; a < newsz; a += PGSIZE){
80106d60:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d66:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106d69:	0f 86 a1 00 00 00    	jbe    80106e10 <allocuvm+0x120>
    mem = kalloc();
80106d6f:	e8 3c b8 ff ff       	call   801025b0 <kalloc>
80106d74:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106d76:	85 c0                	test   %eax,%eax
80106d78:	75 b6                	jne    80106d30 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106d7a:	83 ec 0c             	sub    $0xc,%esp
80106d7d:	68 b1 7b 10 80       	push   $0x80107bb1
80106d82:	e8 29 99 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80106d87:	83 c4 10             	add    $0x10,%esp
80106d8a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d8d:	39 45 10             	cmp    %eax,0x10(%ebp)
80106d90:	74 2e                	je     80106dc0 <allocuvm+0xd0>
80106d92:	89 c1                	mov    %eax,%ecx
80106d94:	8b 55 10             	mov    0x10(%ebp),%edx
80106d97:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106d9a:	31 ff                	xor    %edi,%edi
80106d9c:	e8 af fb ff ff       	call   80106950 <deallocuvm.part.0>
}
80106da1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106da4:	89 f8                	mov    %edi,%eax
80106da6:	5b                   	pop    %ebx
80106da7:	5e                   	pop    %esi
80106da8:	5f                   	pop    %edi
80106da9:	5d                   	pop    %ebp
80106daa:	c3                   	ret    
80106dab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106daf:	90                   	nop
    return oldsz;
80106db0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106db3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106db6:	89 f8                	mov    %edi,%eax
80106db8:	5b                   	pop    %ebx
80106db9:	5e                   	pop    %esi
80106dba:	5f                   	pop    %edi
80106dbb:	5d                   	pop    %ebp
80106dbc:	c3                   	ret    
80106dbd:	8d 76 00             	lea    0x0(%esi),%esi
80106dc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106dc3:	31 ff                	xor    %edi,%edi
}
80106dc5:	5b                   	pop    %ebx
80106dc6:	89 f8                	mov    %edi,%eax
80106dc8:	5e                   	pop    %esi
80106dc9:	5f                   	pop    %edi
80106dca:	5d                   	pop    %ebp
80106dcb:	c3                   	ret    
80106dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory (2)\n");
80106dd0:	83 ec 0c             	sub    $0xc,%esp
80106dd3:	68 c9 7b 10 80       	push   $0x80107bc9
80106dd8:	e8 d3 98 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80106ddd:	83 c4 10             	add    $0x10,%esp
80106de0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106de3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106de6:	74 0d                	je     80106df5 <allocuvm+0x105>
80106de8:	89 c1                	mov    %eax,%ecx
80106dea:	8b 55 10             	mov    0x10(%ebp),%edx
80106ded:	8b 45 08             	mov    0x8(%ebp),%eax
80106df0:	e8 5b fb ff ff       	call   80106950 <deallocuvm.part.0>
      kfree(mem);
80106df5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106df8:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106dfa:	56                   	push   %esi
80106dfb:	e8 f0 b5 ff ff       	call   801023f0 <kfree>
      return 0;
80106e00:	83 c4 10             	add    $0x10,%esp
}
80106e03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e06:	89 f8                	mov    %edi,%eax
80106e08:	5b                   	pop    %ebx
80106e09:	5e                   	pop    %esi
80106e0a:	5f                   	pop    %edi
80106e0b:	5d                   	pop    %ebp
80106e0c:	c3                   	ret    
80106e0d:	8d 76 00             	lea    0x0(%esi),%esi
80106e10:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106e13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e16:	5b                   	pop    %ebx
80106e17:	5e                   	pop    %esi
80106e18:	89 f8                	mov    %edi,%eax
80106e1a:	5f                   	pop    %edi
80106e1b:	5d                   	pop    %ebp
80106e1c:	c3                   	ret    
80106e1d:	8d 76 00             	lea    0x0(%esi),%esi

80106e20 <deallocuvm>:
{
80106e20:	55                   	push   %ebp
80106e21:	89 e5                	mov    %esp,%ebp
80106e23:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e26:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106e29:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106e2c:	39 d1                	cmp    %edx,%ecx
80106e2e:	73 10                	jae    80106e40 <deallocuvm+0x20>
}
80106e30:	5d                   	pop    %ebp
80106e31:	e9 1a fb ff ff       	jmp    80106950 <deallocuvm.part.0>
80106e36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e3d:	8d 76 00             	lea    0x0(%esi),%esi
80106e40:	89 d0                	mov    %edx,%eax
80106e42:	5d                   	pop    %ebp
80106e43:	c3                   	ret    
80106e44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106e4f:	90                   	nop

80106e50 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	57                   	push   %edi
80106e54:	56                   	push   %esi
80106e55:	53                   	push   %ebx
80106e56:	83 ec 0c             	sub    $0xc,%esp
80106e59:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106e5c:	85 f6                	test   %esi,%esi
80106e5e:	74 59                	je     80106eb9 <freevm+0x69>
  if(newsz >= oldsz)
80106e60:	31 c9                	xor    %ecx,%ecx
80106e62:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106e67:	89 f0                	mov    %esi,%eax
80106e69:	89 f3                	mov    %esi,%ebx
80106e6b:	e8 e0 fa ff ff       	call   80106950 <deallocuvm.part.0>
freevm(pde_t *pgdir)
80106e70:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106e76:	eb 0f                	jmp    80106e87 <freevm+0x37>
80106e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e7f:	90                   	nop
80106e80:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106e83:	39 df                	cmp    %ebx,%edi
80106e85:	74 23                	je     80106eaa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106e87:	8b 03                	mov    (%ebx),%eax
80106e89:	a8 01                	test   $0x1,%al
80106e8b:	74 f3                	je     80106e80 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106e8d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106e92:	83 ec 0c             	sub    $0xc,%esp
80106e95:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106e98:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106e9d:	50                   	push   %eax
80106e9e:	e8 4d b5 ff ff       	call   801023f0 <kfree>
80106ea3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106ea6:	39 df                	cmp    %ebx,%edi
80106ea8:	75 dd                	jne    80106e87 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106eaa:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106ead:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106eb0:	5b                   	pop    %ebx
80106eb1:	5e                   	pop    %esi
80106eb2:	5f                   	pop    %edi
80106eb3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106eb4:	e9 37 b5 ff ff       	jmp    801023f0 <kfree>
    panic("freevm: no pgdir");
80106eb9:	83 ec 0c             	sub    $0xc,%esp
80106ebc:	68 e5 7b 10 80       	push   $0x80107be5
80106ec1:	e8 ca 94 ff ff       	call   80100390 <panic>
80106ec6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ecd:	8d 76 00             	lea    0x0(%esi),%esi

80106ed0 <setupkvm>:
{
80106ed0:	55                   	push   %ebp
80106ed1:	89 e5                	mov    %esp,%ebp
80106ed3:	56                   	push   %esi
80106ed4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106ed5:	e8 d6 b6 ff ff       	call   801025b0 <kalloc>
80106eda:	89 c6                	mov    %eax,%esi
80106edc:	85 c0                	test   %eax,%eax
80106ede:	74 42                	je     80106f22 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106ee0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ee3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106ee8:	68 00 10 00 00       	push   $0x1000
80106eed:	6a 00                	push   $0x0
80106eef:	50                   	push   %eax
80106ef0:	e8 0b d8 ff ff       	call   80104700 <memset>
80106ef5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106ef8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106efb:	83 ec 08             	sub    $0x8,%esp
80106efe:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f01:	ff 73 0c             	pushl  0xc(%ebx)
80106f04:	8b 13                	mov    (%ebx),%edx
80106f06:	50                   	push   %eax
80106f07:	29 c1                	sub    %eax,%ecx
80106f09:	89 f0                	mov    %esi,%eax
80106f0b:	e8 b0 f9 ff ff       	call   801068c0 <mappages>
80106f10:	83 c4 10             	add    $0x10,%esp
80106f13:	85 c0                	test   %eax,%eax
80106f15:	78 19                	js     80106f30 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f17:	83 c3 10             	add    $0x10,%ebx
80106f1a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106f20:	75 d6                	jne    80106ef8 <setupkvm+0x28>
}
80106f22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f25:	89 f0                	mov    %esi,%eax
80106f27:	5b                   	pop    %ebx
80106f28:	5e                   	pop    %esi
80106f29:	5d                   	pop    %ebp
80106f2a:	c3                   	ret    
80106f2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f2f:	90                   	nop
      freevm(pgdir);
80106f30:	83 ec 0c             	sub    $0xc,%esp
80106f33:	56                   	push   %esi
      return 0;
80106f34:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106f36:	e8 15 ff ff ff       	call   80106e50 <freevm>
      return 0;
80106f3b:	83 c4 10             	add    $0x10,%esp
}
80106f3e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f41:	89 f0                	mov    %esi,%eax
80106f43:	5b                   	pop    %ebx
80106f44:	5e                   	pop    %esi
80106f45:	5d                   	pop    %ebp
80106f46:	c3                   	ret    
80106f47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f4e:	66 90                	xchg   %ax,%ax

80106f50 <kvmalloc>:
{
80106f50:	55                   	push   %ebp
80106f51:	89 e5                	mov    %esp,%ebp
80106f53:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106f56:	e8 75 ff ff ff       	call   80106ed0 <setupkvm>
80106f5b:	a3 a4 57 11 80       	mov    %eax,0x801157a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f60:	05 00 00 00 80       	add    $0x80000000,%eax
80106f65:	0f 22 d8             	mov    %eax,%cr3
}
80106f68:	c9                   	leave  
80106f69:	c3                   	ret    
80106f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f70 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106f70:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106f71:	31 c9                	xor    %ecx,%ecx
{
80106f73:	89 e5                	mov    %esp,%ebp
80106f75:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106f78:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f7b:	8b 45 08             	mov    0x8(%ebp),%eax
80106f7e:	e8 bd f8 ff ff       	call   80106840 <walkpgdir>
  if(pte == 0)
80106f83:	85 c0                	test   %eax,%eax
80106f85:	74 05                	je     80106f8c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106f87:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106f8a:	c9                   	leave  
80106f8b:	c3                   	ret    
    panic("clearpteu");
80106f8c:	83 ec 0c             	sub    $0xc,%esp
80106f8f:	68 f6 7b 10 80       	push   $0x80107bf6
80106f94:	e8 f7 93 ff ff       	call   80100390 <panic>
80106f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106fa0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106fa0:	55                   	push   %ebp
80106fa1:	89 e5                	mov    %esp,%ebp
80106fa3:	57                   	push   %edi
80106fa4:	56                   	push   %esi
80106fa5:	53                   	push   %ebx
80106fa6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106fa9:	e8 22 ff ff ff       	call   80106ed0 <setupkvm>
80106fae:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106fb1:	85 c0                	test   %eax,%eax
80106fb3:	0f 84 a0 00 00 00    	je     80107059 <copyuvm+0xb9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106fb9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106fbc:	85 c9                	test   %ecx,%ecx
80106fbe:	0f 84 95 00 00 00    	je     80107059 <copyuvm+0xb9>
80106fc4:	31 f6                	xor    %esi,%esi
80106fc6:	eb 4e                	jmp    80107016 <copyuvm+0x76>
80106fc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fcf:	90                   	nop
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106fd0:	83 ec 04             	sub    $0x4,%esp
80106fd3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106fd9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106fdc:	68 00 10 00 00       	push   $0x1000
80106fe1:	57                   	push   %edi
80106fe2:	50                   	push   %eax
80106fe3:	e8 b8 d7 ff ff       	call   801047a0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106fe8:	58                   	pop    %eax
80106fe9:	5a                   	pop    %edx
80106fea:	53                   	push   %ebx
80106feb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106fee:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ff1:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ff6:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106ffc:	52                   	push   %edx
80106ffd:	89 f2                	mov    %esi,%edx
80106fff:	e8 bc f8 ff ff       	call   801068c0 <mappages>
80107004:	83 c4 10             	add    $0x10,%esp
80107007:	85 c0                	test   %eax,%eax
80107009:	78 39                	js     80107044 <copyuvm+0xa4>
  for(i = 0; i < sz; i += PGSIZE){
8010700b:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107011:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107014:	76 43                	jbe    80107059 <copyuvm+0xb9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107016:	8b 45 08             	mov    0x8(%ebp),%eax
80107019:	31 c9                	xor    %ecx,%ecx
8010701b:	89 f2                	mov    %esi,%edx
8010701d:	e8 1e f8 ff ff       	call   80106840 <walkpgdir>
80107022:	85 c0                	test   %eax,%eax
80107024:	74 3e                	je     80107064 <copyuvm+0xc4>
    if(!(*pte & PTE_P))
80107026:	8b 18                	mov    (%eax),%ebx
80107028:	f6 c3 01             	test   $0x1,%bl
8010702b:	74 44                	je     80107071 <copyuvm+0xd1>
    pa = PTE_ADDR(*pte);
8010702d:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
8010702f:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80107035:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
8010703b:	e8 70 b5 ff ff       	call   801025b0 <kalloc>
80107040:	85 c0                	test   %eax,%eax
80107042:	75 8c                	jne    80106fd0 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107044:	83 ec 0c             	sub    $0xc,%esp
80107047:	ff 75 e0             	pushl  -0x20(%ebp)
8010704a:	e8 01 fe ff ff       	call   80106e50 <freevm>
  return 0;
8010704f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107056:	83 c4 10             	add    $0x10,%esp
}
80107059:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010705c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010705f:	5b                   	pop    %ebx
80107060:	5e                   	pop    %esi
80107061:	5f                   	pop    %edi
80107062:	5d                   	pop    %ebp
80107063:	c3                   	ret    
      panic("copyuvm: pte should exist");
80107064:	83 ec 0c             	sub    $0xc,%esp
80107067:	68 00 7c 10 80       	push   $0x80107c00
8010706c:	e8 1f 93 ff ff       	call   80100390 <panic>
      panic("copyuvm: page not present");
80107071:	83 ec 0c             	sub    $0xc,%esp
80107074:	68 1a 7c 10 80       	push   $0x80107c1a
80107079:	e8 12 93 ff ff       	call   80100390 <panic>
8010707e:	66 90                	xchg   %ax,%ax

80107080 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107080:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107081:	31 c9                	xor    %ecx,%ecx
{
80107083:	89 e5                	mov    %esp,%ebp
80107085:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107088:	8b 55 0c             	mov    0xc(%ebp),%edx
8010708b:	8b 45 08             	mov    0x8(%ebp),%eax
8010708e:	e8 ad f7 ff ff       	call   80106840 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107093:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107095:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107096:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107098:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010709d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801070a0:	05 00 00 00 80       	add    $0x80000000,%eax
801070a5:	83 fa 05             	cmp    $0x5,%edx
801070a8:	ba 00 00 00 00       	mov    $0x0,%edx
801070ad:	0f 45 c2             	cmovne %edx,%eax
}
801070b0:	c3                   	ret    
801070b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070bf:	90                   	nop

801070c0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801070c0:	55                   	push   %ebp
801070c1:	89 e5                	mov    %esp,%ebp
801070c3:	57                   	push   %edi
801070c4:	56                   	push   %esi
801070c5:	53                   	push   %ebx
801070c6:	83 ec 0c             	sub    $0xc,%esp
801070c9:	8b 75 14             	mov    0x14(%ebp),%esi
801070cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801070cf:	85 f6                	test   %esi,%esi
801070d1:	75 38                	jne    8010710b <copyout+0x4b>
801070d3:	eb 6b                	jmp    80107140 <copyout+0x80>
801070d5:	8d 76 00             	lea    0x0(%esi),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801070d8:	8b 55 0c             	mov    0xc(%ebp),%edx
801070db:	89 fb                	mov    %edi,%ebx
801070dd:	29 d3                	sub    %edx,%ebx
801070df:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801070e5:	39 f3                	cmp    %esi,%ebx
801070e7:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801070ea:	29 fa                	sub    %edi,%edx
801070ec:	83 ec 04             	sub    $0x4,%esp
801070ef:	01 c2                	add    %eax,%edx
801070f1:	53                   	push   %ebx
801070f2:	ff 75 10             	pushl  0x10(%ebp)
801070f5:	52                   	push   %edx
801070f6:	e8 a5 d6 ff ff       	call   801047a0 <memmove>
    len -= n;
    buf += n;
801070fb:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
801070fe:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
80107104:	83 c4 10             	add    $0x10,%esp
80107107:	29 de                	sub    %ebx,%esi
80107109:	74 35                	je     80107140 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
8010710b:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
8010710d:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107110:	89 55 0c             	mov    %edx,0xc(%ebp)
80107113:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107119:	57                   	push   %edi
8010711a:	ff 75 08             	pushl  0x8(%ebp)
8010711d:	e8 5e ff ff ff       	call   80107080 <uva2ka>
    if(pa0 == 0)
80107122:	83 c4 10             	add    $0x10,%esp
80107125:	85 c0                	test   %eax,%eax
80107127:	75 af                	jne    801070d8 <copyout+0x18>
  }
  return 0;
}
80107129:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010712c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107131:	5b                   	pop    %ebx
80107132:	5e                   	pop    %esi
80107133:	5f                   	pop    %edi
80107134:	5d                   	pop    %ebp
80107135:	c3                   	ret    
80107136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010713d:	8d 76 00             	lea    0x0(%esi),%esi
80107140:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107143:	31 c0                	xor    %eax,%eax
}
80107145:	5b                   	pop    %ebx
80107146:	5e                   	pop    %esi
80107147:	5f                   	pop    %edi
80107148:	5d                   	pop    %ebp
80107149:	c3                   	ret    
