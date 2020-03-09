
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
8010002d:	b8 c0 31 10 80       	mov    $0x801031c0,%eax
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
8010004c:	68 e0 70 10 80       	push   $0x801070e0
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 55 44 00 00       	call   801044b0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 bc fc 10 80       	mov    $0x8010fcbc,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 e7 70 10 80       	push   $0x801070e7
80100097:	50                   	push   %eax
80100098:	e8 03 43 00 00       	call   801043a0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb 60 fa 10 80    	cmp    $0x8010fa60,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

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
801000e4:	e8 c7 44 00 00       	call   801045b0 <acquire>
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
80100162:	e8 69 45 00 00       	call   801046d0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 42 00 00       	call   801043e0 <acquiresleep>
      return b;
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
8010018c:	e8 af 22 00 00       	call   80102440 <iderw>
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
801001a3:	68 ee 70 10 80       	push   $0x801070ee
801001a8:	e8 d3 01 00 00       	call   80100380 <panic>
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
801001be:	e8 bd 42 00 00       	call   80104480 <holdingsleep>
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
801001d4:	e9 67 22 00 00       	jmp    80102440 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 ff 70 10 80       	push   $0x801070ff
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
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
801001ff:	e8 7c 42 00 00       	call   80104480 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 2c 42 00 00       	call   80104440 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010021b:	e8 90 43 00 00       	call   801045b0 <acquire>
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
8010026c:	e9 5f 44 00 00       	jmp    801046d0 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 06 71 10 80       	push   $0x80107106
80100279:	e8 02 01 00 00       	call   80100380 <panic>
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
80100286:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100289:	ff 75 08             	pushl  0x8(%ebp)
{
8010028c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  target = n;
8010028f:	89 de                	mov    %ebx,%esi
  iunlock(ip);
80100291:	e8 5a 15 00 00       	call   801017f0 <iunlock>
  acquire(&cons.lock);
80100296:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010029d:	e8 0e 43 00 00       	call   801045b0 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002a2:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
    *dst++ = c;
801002a8:	01 df                	add    %ebx,%edi
  while(n > 0){
801002aa:	85 db                	test   %ebx,%ebx
801002ac:	0f 8e 9b 00 00 00    	jle    8010034d <consoleread+0xcd>
    while(input.r == input.w){
801002b2:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002b7:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002bd:	74 2b                	je     801002ea <consoleread+0x6a>
801002bf:	eb 5f                	jmp    80100320 <consoleread+0xa0>
801002c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      sleep(&input.r, &cons.lock);
801002c8:	83 ec 08             	sub    $0x8,%esp
801002cb:	68 20 a5 10 80       	push   $0x8010a520
801002d0:	68 a0 ff 10 80       	push   $0x8010ffa0
801002d5:	e8 76 3d 00 00       	call   80104050 <sleep>
    while(input.r == input.w){
801002da:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002df:	83 c4 10             	add    $0x10,%esp
801002e2:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002e8:	75 36                	jne    80100320 <consoleread+0xa0>
      if(myproc()->killed){
801002ea:	e8 c1 37 00 00       	call   80103ab0 <myproc>
801002ef:	8b 48 24             	mov    0x24(%eax),%ecx
801002f2:	85 c9                	test   %ecx,%ecx
801002f4:	74 d2                	je     801002c8 <consoleread+0x48>
        release(&cons.lock);
801002f6:	83 ec 0c             	sub    $0xc,%esp
801002f9:	68 20 a5 10 80       	push   $0x8010a520
801002fe:	e8 cd 43 00 00       	call   801046d0 <release>
        ilock(ip);
80100303:	5a                   	pop    %edx
80100304:	ff 75 08             	pushl  0x8(%ebp)
80100307:	e8 04 14 00 00       	call   80101710 <ilock>
        return -1;
8010030c:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
8010030f:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100312:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100317:	5b                   	pop    %ebx
80100318:	5e                   	pop    %esi
80100319:	5f                   	pop    %edi
8010031a:	5d                   	pop    %ebp
8010031b:	c3                   	ret    
8010031c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100320:	8d 50 01             	lea    0x1(%eax),%edx
80100323:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100329:	89 c2                	mov    %eax,%edx
8010032b:	83 e2 7f             	and    $0x7f,%edx
8010032e:	0f be 8a 20 ff 10 80 	movsbl -0x7fef00e0(%edx),%ecx
    if(c == C('D')){  // EOF
80100335:	80 f9 04             	cmp    $0x4,%cl
80100338:	74 38                	je     80100372 <consoleread+0xf2>
    *dst++ = c;
8010033a:	89 d8                	mov    %ebx,%eax
    --n;
8010033c:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
8010033f:	f7 d8                	neg    %eax
80100341:	88 0c 07             	mov    %cl,(%edi,%eax,1)
    if(c == '\n')
80100344:	83 f9 0a             	cmp    $0xa,%ecx
80100347:	0f 85 5d ff ff ff    	jne    801002aa <consoleread+0x2a>
  release(&cons.lock);
8010034d:	83 ec 0c             	sub    $0xc,%esp
80100350:	68 20 a5 10 80       	push   $0x8010a520
80100355:	e8 76 43 00 00       	call   801046d0 <release>
  ilock(ip);
8010035a:	58                   	pop    %eax
8010035b:	ff 75 08             	pushl  0x8(%ebp)
8010035e:	e8 ad 13 00 00       	call   80101710 <ilock>
  return target - n;
80100363:	89 f0                	mov    %esi,%eax
80100365:	83 c4 10             	add    $0x10,%esp
}
80100368:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
8010036b:	29 d8                	sub    %ebx,%eax
}
8010036d:	5b                   	pop    %ebx
8010036e:	5e                   	pop    %esi
8010036f:	5f                   	pop    %edi
80100370:	5d                   	pop    %ebp
80100371:	c3                   	ret    
      if(n < target){
80100372:	39 f3                	cmp    %esi,%ebx
80100374:	73 d7                	jae    8010034d <consoleread+0xcd>
        input.r--;
80100376:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
8010037b:	eb d0                	jmp    8010034d <consoleread+0xcd>
8010037d:	8d 76 00             	lea    0x0(%esi),%esi

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  cons.locking = 0;
80100389:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 b2 26 00 00       	call   80102a50 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 0d 71 10 80       	push   $0x8010710d
801003a7:	e8 f4 02 00 00       	call   801006a0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	pushl  0x8(%ebp)
801003b0:	e8 eb 02 00 00       	call   801006a0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 3b 7b 10 80 	movl   $0x80107b3b,(%esp)
801003bc:	e8 df 02 00 00       	call   801006a0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 03 41 00 00       	call   801044d0 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	pushl  (%ebx)
801003d5:	83 c3 04             	add    $0x4,%ebx
801003d8:	68 21 71 10 80       	push   $0x80107121
801003dd:	e8 be 02 00 00       	call   801006a0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 ea 00 00 00    	je     80100500 <consputc.part.0+0x100>
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 f1 58 00 00       	call   80105d10 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100434:	89 ca                	mov    %ecx,%edx
80100436:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c6                	mov    %eax,%esi
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 ca                	mov    %ecx,%edx
80100449:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 f0                	or     %esi,%eax
  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 90 00 00 00    	je     801004e8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	74 70                	je     801004d0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100460:	0f b6 db             	movzbl %bl,%ebx
80100463:	8d 70 01             	lea    0x1(%eax),%esi
80100466:	80 cf 07             	or     $0x7,%bh
80100469:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100470:	80 
  if(pos < 0 || pos > 25*80)
80100471:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100477:	0f 8f f9 00 00 00    	jg     80100576 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010047d:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100483:	0f 8f a7 00 00 00    	jg     80100530 <consputc.part.0+0x130>
80100489:	89 f0                	mov    %esi,%eax
8010048b:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
80100492:	88 45 e7             	mov    %al,-0x19(%ebp)
80100495:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100498:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010049d:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a2:	89 da                	mov    %ebx,%edx
801004a4:	ee                   	out    %al,(%dx)
801004a5:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004aa:	89 f8                	mov    %edi,%eax
801004ac:	89 ca                	mov    %ecx,%edx
801004ae:	ee                   	out    %al,(%dx)
801004af:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b4:	89 da                	mov    %ebx,%edx
801004b6:	ee                   	out    %al,(%dx)
801004b7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004bb:	89 ca                	mov    %ecx,%edx
801004bd:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 06             	mov    %ax,(%esi)
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
801004ce:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
801004d0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004d3:	85 c0                	test   %eax,%eax
801004d5:	75 9a                	jne    80100471 <consputc.part.0+0x71>
801004d7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004db:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004e0:	31 ff                	xor    %edi,%edi
801004e2:	eb b4                	jmp    80100498 <consputc.part.0+0x98>
801004e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004e8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004ed:	f7 e2                	mul    %edx
801004ef:	c1 ea 06             	shr    $0x6,%edx
801004f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004f5:	c1 e0 04             	shl    $0x4,%eax
801004f8:	8d 70 50             	lea    0x50(%eax),%esi
801004fb:	e9 71 ff ff ff       	jmp    80100471 <consputc.part.0+0x71>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100500:	83 ec 0c             	sub    $0xc,%esp
80100503:	6a 08                	push   $0x8
80100505:	e8 06 58 00 00       	call   80105d10 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 fa 57 00 00       	call   80105d10 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 ee 57 00 00       	call   80105d10 <uartputc>
80100522:	83 c4 10             	add    $0x10,%esp
80100525:	e9 f8 fe ff ff       	jmp    80100422 <consputc.part.0+0x22>
8010052a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100530:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100533:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100536:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
8010053d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100542:	68 60 0e 00 00       	push   $0xe60
80100547:	68 a0 80 0b 80       	push   $0x800b80a0
8010054c:	68 00 80 0b 80       	push   $0x800b8000
80100551:	e8 6a 42 00 00       	call   801047c0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 b5 41 00 00       	call   80104720 <memset>
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 22 ff ff ff       	jmp    80100498 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 25 71 10 80       	push   $0x80107125
8010057e:	e8 fd fd ff ff       	call   80100380 <panic>
80100583:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100590 <printint>:
{
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	57                   	push   %edi
80100594:	56                   	push   %esi
80100595:	53                   	push   %ebx
80100596:	83 ec 2c             	sub    $0x2c,%esp
80100599:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
8010059c:	85 c9                	test   %ecx,%ecx
8010059e:	74 04                	je     801005a4 <printint+0x14>
801005a0:	85 c0                	test   %eax,%eax
801005a2:	78 6d                	js     80100611 <printint+0x81>
    x = xx;
801005a4:	89 c1                	mov    %eax,%ecx
801005a6:	31 f6                	xor    %esi,%esi
  i = 0;
801005a8:	89 75 cc             	mov    %esi,-0x34(%ebp)
801005ab:	31 db                	xor    %ebx,%ebx
801005ad:	8d 7d d7             	lea    -0x29(%ebp),%edi
    buf[i++] = digits[x % base];
801005b0:	89 c8                	mov    %ecx,%eax
801005b2:	31 d2                	xor    %edx,%edx
801005b4:	89 ce                	mov    %ecx,%esi
801005b6:	f7 75 d4             	divl   -0x2c(%ebp)
801005b9:	0f b6 92 50 71 10 80 	movzbl -0x7fef8eb0(%edx),%edx
801005c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
801005c3:	89 d8                	mov    %ebx,%eax
801005c5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
801005c8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801005cb:	89 75 d0             	mov    %esi,-0x30(%ebp)
    buf[i++] = digits[x % base];
801005ce:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
  }while((x /= base) != 0);
801005d1:	8b 75 d4             	mov    -0x2c(%ebp),%esi
801005d4:	39 75 d0             	cmp    %esi,-0x30(%ebp)
801005d7:	73 d7                	jae    801005b0 <printint+0x20>
801005d9:	8b 75 cc             	mov    -0x34(%ebp),%esi
  if(sign)
801005dc:	85 f6                	test   %esi,%esi
801005de:	74 0c                	je     801005ec <printint+0x5c>
    buf[i++] = '-';
801005e0:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
801005e5:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
801005e7:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
801005ec:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
801005f0:	0f be c2             	movsbl %dl,%eax
  if(panicked){
801005f3:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801005f9:	85 d2                	test   %edx,%edx
801005fb:	74 03                	je     80100600 <printint+0x70>
  asm volatile("cli");
801005fd:	fa                   	cli    
    for(;;)
801005fe:	eb fe                	jmp    801005fe <printint+0x6e>
80100600:	e8 fb fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
80100605:	39 fb                	cmp    %edi,%ebx
80100607:	74 10                	je     80100619 <printint+0x89>
80100609:	0f be 03             	movsbl (%ebx),%eax
8010060c:	83 eb 01             	sub    $0x1,%ebx
8010060f:	eb e2                	jmp    801005f3 <printint+0x63>
    x = -xx;
80100611:	f7 d8                	neg    %eax
80100613:	89 ce                	mov    %ecx,%esi
80100615:	89 c1                	mov    %eax,%ecx
80100617:	eb 8f                	jmp    801005a8 <printint+0x18>
}
80100619:	83 c4 2c             	add    $0x2c,%esp
8010061c:	5b                   	pop    %ebx
8010061d:	5e                   	pop    %esi
8010061e:	5f                   	pop    %edi
8010061f:	5d                   	pop    %ebp
80100620:	c3                   	ret    
80100621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010062f:	90                   	nop

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
  int i;

  iunlock(ip);
80100639:	ff 75 08             	pushl  0x8(%ebp)
{
8010063c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  iunlock(ip);
8010063f:	e8 ac 11 00 00       	call   801017f0 <iunlock>
  acquire(&cons.lock);
80100644:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010064b:	e8 60 3f 00 00       	call   801045b0 <acquire>
  for(i = 0; i < n; i++)
80100650:	83 c4 10             	add    $0x10,%esp
80100653:	85 db                	test   %ebx,%ebx
80100655:	7e 28                	jle    8010067f <consolewrite+0x4f>
80100657:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010065a:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
  if(panicked){
8010065d:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100663:	85 d2                	test   %edx,%edx
80100665:	74 09                	je     80100670 <consolewrite+0x40>
80100667:	fa                   	cli    
    for(;;)
80100668:	eb fe                	jmp    80100668 <consolewrite+0x38>
8010066a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100670:	0f b6 07             	movzbl (%edi),%eax
80100673:	83 c7 01             	add    $0x1,%edi
80100676:	e8 85 fd ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
8010067b:	39 fe                	cmp    %edi,%esi
8010067d:	75 de                	jne    8010065d <consolewrite+0x2d>
  release(&cons.lock);
8010067f:	83 ec 0c             	sub    $0xc,%esp
80100682:	68 20 a5 10 80       	push   $0x8010a520
80100687:	e8 44 40 00 00       	call   801046d0 <release>
  ilock(ip);
8010068c:	58                   	pop    %eax
8010068d:	ff 75 08             	pushl  0x8(%ebp)
80100690:	e8 7b 10 00 00       	call   80101710 <ilock>

  return n;
}
80100695:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100698:	89 d8                	mov    %ebx,%eax
8010069a:	5b                   	pop    %ebx
8010069b:	5e                   	pop    %esi
8010069c:	5f                   	pop    %edi
8010069d:	5d                   	pop    %ebp
8010069e:	c3                   	ret    
8010069f:	90                   	nop

801006a0 <cprintf>:
{
801006a0:	55                   	push   %ebp
801006a1:	89 e5                	mov    %esp,%ebp
801006a3:	57                   	push   %edi
801006a4:	56                   	push   %esi
801006a5:	53                   	push   %ebx
801006a6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006a9:	a1 54 a5 10 80       	mov    0x8010a554,%eax
801006ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801006b1:	85 c0                	test   %eax,%eax
801006b3:	0f 85 e4 00 00 00    	jne    8010079d <cprintf+0xfd>
  if (fmt == 0)
801006b9:	8b 45 08             	mov    0x8(%ebp),%eax
801006bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006bf:	85 c0                	test   %eax,%eax
801006c1:	0f 84 5e 01 00 00    	je     80100825 <cprintf+0x185>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c7:	0f b6 00             	movzbl (%eax),%eax
801006ca:	85 c0                	test   %eax,%eax
801006cc:	74 32                	je     80100700 <cprintf+0x60>
  argp = (uint*)(void*)(&fmt + 1);
801006ce:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d1:	31 f6                	xor    %esi,%esi
    if(c != '%'){
801006d3:	83 f8 25             	cmp    $0x25,%eax
801006d6:	74 40                	je     80100718 <cprintf+0x78>
  if(panicked){
801006d8:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801006de:	85 c9                	test   %ecx,%ecx
801006e0:	74 0b                	je     801006ed <cprintf+0x4d>
801006e2:	fa                   	cli    
    for(;;)
801006e3:	eb fe                	jmp    801006e3 <cprintf+0x43>
801006e5:	8d 76 00             	lea    0x0(%esi),%esi
801006e8:	b8 25 00 00 00       	mov    $0x25,%eax
801006ed:	e8 0e fd ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006f5:	83 c6 01             	add    $0x1,%esi
801006f8:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
801006fc:	85 c0                	test   %eax,%eax
801006fe:	75 d3                	jne    801006d3 <cprintf+0x33>
  if(locking)
80100700:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100703:	85 c0                	test   %eax,%eax
80100705:	0f 85 05 01 00 00    	jne    80100810 <cprintf+0x170>
}
8010070b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010070e:	5b                   	pop    %ebx
8010070f:	5e                   	pop    %esi
80100710:	5f                   	pop    %edi
80100711:	5d                   	pop    %ebp
80100712:	c3                   	ret    
80100713:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100717:	90                   	nop
    c = fmt[++i] & 0xff;
80100718:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010071b:	83 c6 01             	add    $0x1,%esi
8010071e:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
    if(c == 0)
80100722:	85 ff                	test   %edi,%edi
80100724:	74 da                	je     80100700 <cprintf+0x60>
    switch(c){
80100726:	83 ff 70             	cmp    $0x70,%edi
80100729:	74 5a                	je     80100785 <cprintf+0xe5>
8010072b:	7f 2a                	jg     80100757 <cprintf+0xb7>
8010072d:	83 ff 25             	cmp    $0x25,%edi
80100730:	0f 84 92 00 00 00    	je     801007c8 <cprintf+0x128>
80100736:	83 ff 64             	cmp    $0x64,%edi
80100739:	0f 85 a1 00 00 00    	jne    801007e0 <cprintf+0x140>
      printint(*argp++, 10, 1);
8010073f:	8b 03                	mov    (%ebx),%eax
80100741:	8d 7b 04             	lea    0x4(%ebx),%edi
80100744:	b9 01 00 00 00       	mov    $0x1,%ecx
80100749:	ba 0a 00 00 00       	mov    $0xa,%edx
8010074e:	89 fb                	mov    %edi,%ebx
80100750:	e8 3b fe ff ff       	call   80100590 <printint>
      break;
80100755:	eb 9b                	jmp    801006f2 <cprintf+0x52>
    switch(c){
80100757:	83 ff 73             	cmp    $0x73,%edi
8010075a:	75 24                	jne    80100780 <cprintf+0xe0>
      if((s = (char*)*argp++) == 0)
8010075c:	8d 7b 04             	lea    0x4(%ebx),%edi
8010075f:	8b 1b                	mov    (%ebx),%ebx
80100761:	85 db                	test   %ebx,%ebx
80100763:	75 55                	jne    801007ba <cprintf+0x11a>
        s = "(null)";
80100765:	bb 38 71 10 80       	mov    $0x80107138,%ebx
      for(; *s; s++)
8010076a:	b8 28 00 00 00       	mov    $0x28,%eax
  if(panicked){
8010076f:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100775:	85 d2                	test   %edx,%edx
80100777:	74 39                	je     801007b2 <cprintf+0x112>
80100779:	fa                   	cli    
    for(;;)
8010077a:	eb fe                	jmp    8010077a <cprintf+0xda>
8010077c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100780:	83 ff 78             	cmp    $0x78,%edi
80100783:	75 5b                	jne    801007e0 <cprintf+0x140>
      printint(*argp++, 16, 0);
80100785:	8b 03                	mov    (%ebx),%eax
80100787:	8d 7b 04             	lea    0x4(%ebx),%edi
8010078a:	31 c9                	xor    %ecx,%ecx
8010078c:	ba 10 00 00 00       	mov    $0x10,%edx
80100791:	89 fb                	mov    %edi,%ebx
80100793:	e8 f8 fd ff ff       	call   80100590 <printint>
      break;
80100798:	e9 55 ff ff ff       	jmp    801006f2 <cprintf+0x52>
    acquire(&cons.lock);
8010079d:	83 ec 0c             	sub    $0xc,%esp
801007a0:	68 20 a5 10 80       	push   $0x8010a520
801007a5:	e8 06 3e 00 00       	call   801045b0 <acquire>
801007aa:	83 c4 10             	add    $0x10,%esp
801007ad:	e9 07 ff ff ff       	jmp    801006b9 <cprintf+0x19>
801007b2:	e8 49 fc ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
801007b7:	83 c3 01             	add    $0x1,%ebx
801007ba:	0f be 03             	movsbl (%ebx),%eax
801007bd:	84 c0                	test   %al,%al
801007bf:	75 ae                	jne    8010076f <cprintf+0xcf>
      if((s = (char*)*argp++) == 0)
801007c1:	89 fb                	mov    %edi,%ebx
801007c3:	e9 2a ff ff ff       	jmp    801006f2 <cprintf+0x52>
  if(panicked){
801007c8:	8b 3d 58 a5 10 80    	mov    0x8010a558,%edi
801007ce:	85 ff                	test   %edi,%edi
801007d0:	0f 84 12 ff ff ff    	je     801006e8 <cprintf+0x48>
801007d6:	fa                   	cli    
    for(;;)
801007d7:	eb fe                	jmp    801007d7 <cprintf+0x137>
801007d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
801007e0:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801007e6:	85 c9                	test   %ecx,%ecx
801007e8:	74 06                	je     801007f0 <cprintf+0x150>
801007ea:	fa                   	cli    
    for(;;)
801007eb:	eb fe                	jmp    801007eb <cprintf+0x14b>
801007ed:	8d 76 00             	lea    0x0(%esi),%esi
801007f0:	b8 25 00 00 00       	mov    $0x25,%eax
801007f5:	e8 06 fc ff ff       	call   80100400 <consputc.part.0>
  if(panicked){
801007fa:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100800:	85 d2                	test   %edx,%edx
80100802:	74 34                	je     80100838 <cprintf+0x198>
80100804:	fa                   	cli    
    for(;;)
80100805:	eb fe                	jmp    80100805 <cprintf+0x165>
80100807:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010080e:	66 90                	xchg   %ax,%ax
    release(&cons.lock);
80100810:	83 ec 0c             	sub    $0xc,%esp
80100813:	68 20 a5 10 80       	push   $0x8010a520
80100818:	e8 b3 3e 00 00       	call   801046d0 <release>
8010081d:	83 c4 10             	add    $0x10,%esp
}
80100820:	e9 e6 fe ff ff       	jmp    8010070b <cprintf+0x6b>
    panic("null fmt");
80100825:	83 ec 0c             	sub    $0xc,%esp
80100828:	68 3f 71 10 80       	push   $0x8010713f
8010082d:	e8 4e fb ff ff       	call   80100380 <panic>
80100832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100838:	89 f8                	mov    %edi,%eax
8010083a:	e8 c1 fb ff ff       	call   80100400 <consputc.part.0>
8010083f:	e9 ae fe ff ff       	jmp    801006f2 <cprintf+0x52>
80100844:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010084b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010084f:	90                   	nop

80100850 <consoleintr>:
{
80100850:	55                   	push   %ebp
80100851:	89 e5                	mov    %esp,%ebp
80100853:	57                   	push   %edi
80100854:	56                   	push   %esi
  int c, doprocdump = 0;
80100855:	31 f6                	xor    %esi,%esi
{
80100857:	53                   	push   %ebx
80100858:	83 ec 18             	sub    $0x18,%esp
8010085b:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
8010085e:	68 20 a5 10 80       	push   $0x8010a520
80100863:	e8 48 3d 00 00       	call   801045b0 <acquire>
  while((c = getc()) >= 0){
80100868:	83 c4 10             	add    $0x10,%esp
8010086b:	eb 17                	jmp    80100884 <consoleintr+0x34>
    switch(c){
8010086d:	83 fb 08             	cmp    $0x8,%ebx
80100870:	0f 84 fa 00 00 00    	je     80100970 <consoleintr+0x120>
80100876:	83 fb 10             	cmp    $0x10,%ebx
80100879:	0f 85 19 01 00 00    	jne    80100998 <consoleintr+0x148>
8010087f:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
80100884:	ff d7                	call   *%edi
80100886:	89 c3                	mov    %eax,%ebx
80100888:	85 c0                	test   %eax,%eax
8010088a:	0f 88 27 01 00 00    	js     801009b7 <consoleintr+0x167>
    switch(c){
80100890:	83 fb 15             	cmp    $0x15,%ebx
80100893:	74 7b                	je     80100910 <consoleintr+0xc0>
80100895:	7e d6                	jle    8010086d <consoleintr+0x1d>
80100897:	83 fb 7f             	cmp    $0x7f,%ebx
8010089a:	0f 84 d0 00 00 00    	je     80100970 <consoleintr+0x120>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a0:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008a5:	89 c2                	mov    %eax,%edx
801008a7:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
801008ad:	83 fa 7f             	cmp    $0x7f,%edx
801008b0:	77 d2                	ja     80100884 <consoleintr+0x34>
        c = (c == '\r') ? '\n' : c;
801008b2:	8d 48 01             	lea    0x1(%eax),%ecx
801008b5:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801008bb:	83 e0 7f             	and    $0x7f,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
801008be:	89 0d a8 ff 10 80    	mov    %ecx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
801008c4:	83 fb 0d             	cmp    $0xd,%ebx
801008c7:	0f 84 06 01 00 00    	je     801009d3 <consoleintr+0x183>
        input.buf[input.e++ % INPUT_BUF] = c;
801008cd:	88 98 20 ff 10 80    	mov    %bl,-0x7fef00e0(%eax)
  if(panicked){
801008d3:	85 d2                	test   %edx,%edx
801008d5:	0f 85 03 01 00 00    	jne    801009de <consoleintr+0x18e>
801008db:	89 d8                	mov    %ebx,%eax
801008dd:	e8 1e fb ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e2:	83 fb 0a             	cmp    $0xa,%ebx
801008e5:	0f 84 13 01 00 00    	je     801009fe <consoleintr+0x1ae>
801008eb:	83 fb 04             	cmp    $0x4,%ebx
801008ee:	0f 84 0a 01 00 00    	je     801009fe <consoleintr+0x1ae>
801008f4:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008f9:	83 e8 80             	sub    $0xffffff80,%eax
801008fc:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
80100902:	75 80                	jne    80100884 <consoleintr+0x34>
80100904:	e9 fa 00 00 00       	jmp    80100a03 <consoleintr+0x1b3>
80100909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
80100910:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100915:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
8010091b:	0f 84 63 ff ff ff    	je     80100884 <consoleintr+0x34>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100921:	83 e8 01             	sub    $0x1,%eax
80100924:	89 c2                	mov    %eax,%edx
80100926:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100929:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
80100930:	0f 84 4e ff ff ff    	je     80100884 <consoleintr+0x34>
  if(panicked){
80100936:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
        input.e--;
8010093c:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
  if(panicked){
80100941:	85 d2                	test   %edx,%edx
80100943:	74 0b                	je     80100950 <consoleintr+0x100>
80100945:	fa                   	cli    
    for(;;)
80100946:	eb fe                	jmp    80100946 <consoleintr+0xf6>
80100948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010094f:	90                   	nop
80100950:	b8 00 01 00 00       	mov    $0x100,%eax
80100955:	e8 a6 fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
8010095a:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010095f:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100965:	75 ba                	jne    80100921 <consoleintr+0xd1>
80100967:	e9 18 ff ff ff       	jmp    80100884 <consoleintr+0x34>
8010096c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(input.e != input.w){
80100970:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100975:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010097b:	0f 84 03 ff ff ff    	je     80100884 <consoleintr+0x34>
        input.e--;
80100981:	83 e8 01             	sub    $0x1,%eax
80100984:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
  if(panicked){
80100989:	a1 58 a5 10 80       	mov    0x8010a558,%eax
8010098e:	85 c0                	test   %eax,%eax
80100990:	74 16                	je     801009a8 <consoleintr+0x158>
80100992:	fa                   	cli    
    for(;;)
80100993:	eb fe                	jmp    80100993 <consoleintr+0x143>
80100995:	8d 76 00             	lea    0x0(%esi),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100998:	85 db                	test   %ebx,%ebx
8010099a:	0f 84 e4 fe ff ff    	je     80100884 <consoleintr+0x34>
801009a0:	e9 fb fe ff ff       	jmp    801008a0 <consoleintr+0x50>
801009a5:	8d 76 00             	lea    0x0(%esi),%esi
801009a8:	b8 00 01 00 00       	mov    $0x100,%eax
801009ad:	e8 4e fa ff ff       	call   80100400 <consputc.part.0>
801009b2:	e9 cd fe ff ff       	jmp    80100884 <consoleintr+0x34>
  release(&cons.lock);
801009b7:	83 ec 0c             	sub    $0xc,%esp
801009ba:	68 20 a5 10 80       	push   $0x8010a520
801009bf:	e8 0c 3d 00 00       	call   801046d0 <release>
  if(doprocdump) {
801009c4:	83 c4 10             	add    $0x10,%esp
801009c7:	85 f6                	test   %esi,%esi
801009c9:	75 1d                	jne    801009e8 <consoleintr+0x198>
}
801009cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009ce:	5b                   	pop    %ebx
801009cf:	5e                   	pop    %esi
801009d0:	5f                   	pop    %edi
801009d1:	5d                   	pop    %ebp
801009d2:	c3                   	ret    
        input.buf[input.e++ % INPUT_BUF] = c;
801009d3:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
  if(panicked){
801009da:	85 d2                	test   %edx,%edx
801009dc:	74 16                	je     801009f4 <consoleintr+0x1a4>
801009de:	fa                   	cli    
    for(;;)
801009df:	eb fe                	jmp    801009df <consoleintr+0x18f>
801009e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
801009e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009eb:	5b                   	pop    %ebx
801009ec:	5e                   	pop    %esi
801009ed:	5f                   	pop    %edi
801009ee:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
801009ef:	e9 ec 38 00 00       	jmp    801042e0 <procdump>
801009f4:	b8 0a 00 00 00       	mov    $0xa,%eax
801009f9:	e8 02 fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009fe:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
          wakeup(&input.r);
80100a03:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a06:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100a0b:	68 a0 ff 10 80       	push   $0x8010ffa0
80100a10:	e8 eb 37 00 00       	call   80104200 <wakeup>
80100a15:	83 c4 10             	add    $0x10,%esp
80100a18:	e9 67 fe ff ff       	jmp    80100884 <consoleintr+0x34>
80100a1d:	8d 76 00             	lea    0x0(%esi),%esi

80100a20 <consoleinit>:

void
consoleinit(void)
{
80100a20:	55                   	push   %ebp
80100a21:	89 e5                	mov    %esp,%ebp
80100a23:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a26:	68 48 71 10 80       	push   $0x80107148
80100a2b:	68 20 a5 10 80       	push   $0x8010a520
80100a30:	e8 7b 3a 00 00       	call   801044b0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a35:	58                   	pop    %eax
80100a36:	5a                   	pop    %edx
80100a37:	6a 00                	push   $0x0
80100a39:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a3b:	c7 05 6c 09 11 80 30 	movl   $0x80100630,0x8011096c
80100a42:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100a45:	c7 05 68 09 11 80 80 	movl   $0x80100280,0x80110968
80100a4c:	02 10 80 
  cons.locking = 1;
80100a4f:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100a56:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a59:	e8 82 1b 00 00       	call   801025e0 <ioapicenable>
}
80100a5e:	83 c4 10             	add    $0x10,%esp
80100a61:	c9                   	leave  
80100a62:	c3                   	ret    
80100a63:	66 90                	xchg   %ax,%ax
80100a65:	66 90                	xchg   %ax,%ax
80100a67:	66 90                	xchg   %ax,%ax
80100a69:	66 90                	xchg   %ax,%ax
80100a6b:	66 90                	xchg   %ax,%ax
80100a6d:	66 90                	xchg   %ax,%ax
80100a6f:	90                   	nop

80100a70 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a70:	55                   	push   %ebp
80100a71:	89 e5                	mov    %esp,%ebp
80100a73:	57                   	push   %edi
80100a74:	56                   	push   %esi
80100a75:	53                   	push   %ebx
80100a76:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a7c:	e8 2f 30 00 00       	call   80103ab0 <myproc>
80100a81:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100a87:	e8 34 24 00 00       	call   80102ec0 <begin_op>

  if((ip = namei(path)) == 0){
80100a8c:	83 ec 0c             	sub    $0xc,%esp
80100a8f:	ff 75 08             	pushl  0x8(%ebp)
80100a92:	e8 19 15 00 00       	call   80101fb0 <namei>
80100a97:	83 c4 10             	add    $0x10,%esp
80100a9a:	85 c0                	test   %eax,%eax
80100a9c:	0f 84 02 03 00 00    	je     80100da4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100aa2:	83 ec 0c             	sub    $0xc,%esp
80100aa5:	89 c3                	mov    %eax,%ebx
80100aa7:	50                   	push   %eax
80100aa8:	e8 63 0c 00 00       	call   80101710 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100aad:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100ab3:	6a 34                	push   $0x34
80100ab5:	6a 00                	push   $0x0
80100ab7:	50                   	push   %eax
80100ab8:	53                   	push   %ebx
80100ab9:	e8 32 0f 00 00       	call   801019f0 <readi>
80100abe:	83 c4 20             	add    $0x20,%esp
80100ac1:	83 f8 34             	cmp    $0x34,%eax
80100ac4:	74 22                	je     80100ae8 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ac6:	83 ec 0c             	sub    $0xc,%esp
80100ac9:	53                   	push   %ebx
80100aca:	e8 d1 0e 00 00       	call   801019a0 <iunlockput>
    end_op();
80100acf:	e8 5c 24 00 00       	call   80102f30 <end_op>
80100ad4:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100ad7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100adc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100adf:	5b                   	pop    %ebx
80100ae0:	5e                   	pop    %esi
80100ae1:	5f                   	pop    %edi
80100ae2:	5d                   	pop    %ebp
80100ae3:	c3                   	ret    
80100ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100ae8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100aef:	45 4c 46 
80100af2:	75 d2                	jne    80100ac6 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100af4:	e8 67 63 00 00       	call   80106e60 <setupkvm>
80100af9:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100aff:	85 c0                	test   %eax,%eax
80100b01:	74 c3                	je     80100ac6 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b03:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b0a:	00 
80100b0b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b11:	0f 84 ac 02 00 00    	je     80100dc3 <exec+0x353>
  sz = 0;
80100b17:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b1e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b21:	31 ff                	xor    %edi,%edi
80100b23:	e9 8e 00 00 00       	jmp    80100bb6 <exec+0x146>
80100b28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b2f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80100b30:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b37:	75 6c                	jne    80100ba5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100b39:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b3f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b45:	0f 82 87 00 00 00    	jb     80100bd2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b4b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b51:	72 7f                	jb     80100bd2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b53:	83 ec 04             	sub    $0x4,%esp
80100b56:	50                   	push   %eax
80100b57:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b5d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b63:	e8 18 61 00 00       	call   80106c80 <allocuvm>
80100b68:	83 c4 10             	add    $0x10,%esp
80100b6b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b71:	85 c0                	test   %eax,%eax
80100b73:	74 5d                	je     80100bd2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100b75:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b7b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b80:	75 50                	jne    80100bd2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b82:	83 ec 0c             	sub    $0xc,%esp
80100b85:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b8b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b91:	53                   	push   %ebx
80100b92:	50                   	push   %eax
80100b93:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b99:	e8 22 60 00 00       	call   80106bc0 <loaduvm>
80100b9e:	83 c4 20             	add    $0x20,%esp
80100ba1:	85 c0                	test   %eax,%eax
80100ba3:	78 2d                	js     80100bd2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ba5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bac:	83 c7 01             	add    $0x1,%edi
80100baf:	83 c6 20             	add    $0x20,%esi
80100bb2:	39 f8                	cmp    %edi,%eax
80100bb4:	7e 3a                	jle    80100bf0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bb6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bbc:	6a 20                	push   $0x20
80100bbe:	56                   	push   %esi
80100bbf:	50                   	push   %eax
80100bc0:	53                   	push   %ebx
80100bc1:	e8 2a 0e 00 00       	call   801019f0 <readi>
80100bc6:	83 c4 10             	add    $0x10,%esp
80100bc9:	83 f8 20             	cmp    $0x20,%eax
80100bcc:	0f 84 5e ff ff ff    	je     80100b30 <exec+0xc0>
    freevm(pgdir);
80100bd2:	83 ec 0c             	sub    $0xc,%esp
80100bd5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bdb:	e8 00 62 00 00       	call   80106de0 <freevm>
  if(ip){
80100be0:	83 c4 10             	add    $0x10,%esp
80100be3:	e9 de fe ff ff       	jmp    80100ac6 <exec+0x56>
80100be8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100bef:	90                   	nop
80100bf0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100bf6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100bfc:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c02:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c08:	83 ec 0c             	sub    $0xc,%esp
80100c0b:	53                   	push   %ebx
80100c0c:	e8 8f 0d 00 00       	call   801019a0 <iunlockput>
  end_op();
80100c11:	e8 1a 23 00 00       	call   80102f30 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c16:	83 c4 0c             	add    $0xc,%esp
80100c19:	56                   	push   %esi
80100c1a:	57                   	push   %edi
80100c1b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c21:	57                   	push   %edi
80100c22:	e8 59 60 00 00       	call   80106c80 <allocuvm>
80100c27:	83 c4 10             	add    $0x10,%esp
80100c2a:	89 c6                	mov    %eax,%esi
80100c2c:	85 c0                	test   %eax,%eax
80100c2e:	0f 84 94 00 00 00    	je     80100cc8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c34:	83 ec 08             	sub    $0x8,%esp
80100c37:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100c3d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c3f:	50                   	push   %eax
80100c40:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100c41:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c43:	e8 b8 62 00 00       	call   80106f00 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c48:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4b:	83 c4 10             	add    $0x10,%esp
80100c4e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c54:	8b 00                	mov    (%eax),%eax
80100c56:	85 c0                	test   %eax,%eax
80100c58:	0f 84 8b 00 00 00    	je     80100ce9 <exec+0x279>
80100c5e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100c64:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c6a:	eb 23                	jmp    80100c8f <exec+0x21f>
80100c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c70:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c73:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c7a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c83:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c86:	85 c0                	test   %eax,%eax
80100c88:	74 59                	je     80100ce3 <exec+0x273>
    if(argc >= MAXARG)
80100c8a:	83 ff 20             	cmp    $0x20,%edi
80100c8d:	74 39                	je     80100cc8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c8f:	83 ec 0c             	sub    $0xc,%esp
80100c92:	50                   	push   %eax
80100c93:	e8 88 3c 00 00       	call   80104920 <strlen>
80100c98:	f7 d0                	not    %eax
80100c9a:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c9c:	58                   	pop    %eax
80100c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ca0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ca3:	ff 34 b8             	pushl  (%eax,%edi,4)
80100ca6:	e8 75 3c 00 00       	call   80104920 <strlen>
80100cab:	83 c0 01             	add    $0x1,%eax
80100cae:	50                   	push   %eax
80100caf:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cb2:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cb5:	53                   	push   %ebx
80100cb6:	56                   	push   %esi
80100cb7:	e8 94 63 00 00       	call   80107050 <copyout>
80100cbc:	83 c4 20             	add    $0x20,%esp
80100cbf:	85 c0                	test   %eax,%eax
80100cc1:	79 ad                	jns    80100c70 <exec+0x200>
80100cc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cc7:	90                   	nop
    freevm(pgdir);
80100cc8:	83 ec 0c             	sub    $0xc,%esp
80100ccb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100cd1:	e8 0a 61 00 00       	call   80106de0 <freevm>
80100cd6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100cd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cde:	e9 f9 fd ff ff       	jmp    80100adc <exec+0x6c>
80100ce3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ce9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100cf0:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100cf2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100cf9:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cfd:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cff:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100d02:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100d08:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d0a:	50                   	push   %eax
80100d0b:	52                   	push   %edx
80100d0c:	53                   	push   %ebx
80100d0d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d13:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d1a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d1d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d23:	e8 28 63 00 00       	call   80107050 <copyout>
80100d28:	83 c4 10             	add    $0x10,%esp
80100d2b:	85 c0                	test   %eax,%eax
80100d2d:	78 99                	js     80100cc8 <exec+0x258>
  for(last=s=path; *s; s++)
80100d2f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d32:	8b 55 08             	mov    0x8(%ebp),%edx
80100d35:	0f b6 00             	movzbl (%eax),%eax
80100d38:	84 c0                	test   %al,%al
80100d3a:	74 13                	je     80100d4f <exec+0x2df>
80100d3c:	89 d1                	mov    %edx,%ecx
80100d3e:	66 90                	xchg   %ax,%ax
    if(*s == '/')
80100d40:	83 c1 01             	add    $0x1,%ecx
80100d43:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d45:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80100d48:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d4b:	84 c0                	test   %al,%al
80100d4d:	75 f1                	jne    80100d40 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d4f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d55:	83 ec 04             	sub    $0x4,%esp
80100d58:	6a 10                	push   $0x10
80100d5a:	89 f8                	mov    %edi,%eax
80100d5c:	52                   	push   %edx
80100d5d:	83 c0 6c             	add    $0x6c,%eax
80100d60:	50                   	push   %eax
80100d61:	e8 7a 3b 00 00       	call   801048e0 <safestrcpy>
  curproc->pgdir = pgdir;
80100d66:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100d6c:	89 f8                	mov    %edi,%eax
80100d6e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100d71:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100d73:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100d76:	89 c1                	mov    %eax,%ecx
80100d78:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d7e:	8b 40 18             	mov    0x18(%eax),%eax
80100d81:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d84:	8b 41 18             	mov    0x18(%ecx),%eax
80100d87:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d8a:	89 0c 24             	mov    %ecx,(%esp)
80100d8d:	e8 9e 5c 00 00       	call   80106a30 <switchuvm>
  freevm(oldpgdir);
80100d92:	89 3c 24             	mov    %edi,(%esp)
80100d95:	e8 46 60 00 00       	call   80106de0 <freevm>
  return 0;
80100d9a:	83 c4 10             	add    $0x10,%esp
80100d9d:	31 c0                	xor    %eax,%eax
80100d9f:	e9 38 fd ff ff       	jmp    80100adc <exec+0x6c>
    end_op();
80100da4:	e8 87 21 00 00       	call   80102f30 <end_op>
    cprintf("exec: fail\n");
80100da9:	83 ec 0c             	sub    $0xc,%esp
80100dac:	68 61 71 10 80       	push   $0x80107161
80100db1:	e8 ea f8 ff ff       	call   801006a0 <cprintf>
    return -1;
80100db6:	83 c4 10             	add    $0x10,%esp
80100db9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dbe:	e9 19 fd ff ff       	jmp    80100adc <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100dc3:	31 ff                	xor    %edi,%edi
80100dc5:	be 00 20 00 00       	mov    $0x2000,%esi
80100dca:	e9 39 fe ff ff       	jmp    80100c08 <exec+0x198>
80100dcf:	90                   	nop

80100dd0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100dd0:	55                   	push   %ebp
80100dd1:	89 e5                	mov    %esp,%ebp
80100dd3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100dd6:	68 6d 71 10 80       	push   $0x8010716d
80100ddb:	68 c0 ff 10 80       	push   $0x8010ffc0
80100de0:	e8 cb 36 00 00       	call   801044b0 <initlock>
}
80100de5:	83 c4 10             	add    $0x10,%esp
80100de8:	c9                   	leave  
80100de9:	c3                   	ret    
80100dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100df0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100df4:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100df9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100dfc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e01:	e8 aa 37 00 00       	call   801045b0 <acquire>
80100e06:	83 c4 10             	add    $0x10,%esp
80100e09:	eb 10                	jmp    80100e1b <filealloc+0x2b>
80100e0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e0f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e10:	83 c3 18             	add    $0x18,%ebx
80100e13:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100e19:	74 25                	je     80100e40 <filealloc+0x50>
    if(f->ref == 0){
80100e1b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e1e:	85 c0                	test   %eax,%eax
80100e20:	75 ee                	jne    80100e10 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e22:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e25:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e2c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e31:	e8 9a 38 00 00       	call   801046d0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e36:	89 d8                	mov    %ebx,%eax
      return f;
80100e38:	83 c4 10             	add    $0x10,%esp
}
80100e3b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e3e:	c9                   	leave  
80100e3f:	c3                   	ret    
  release(&ftable.lock);
80100e40:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e43:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e45:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e4a:	e8 81 38 00 00       	call   801046d0 <release>
}
80100e4f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e51:	83 c4 10             	add    $0x10,%esp
}
80100e54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e57:	c9                   	leave  
80100e58:	c3                   	ret    
80100e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e60 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e60:	55                   	push   %ebp
80100e61:	89 e5                	mov    %esp,%ebp
80100e63:	53                   	push   %ebx
80100e64:	83 ec 10             	sub    $0x10,%esp
80100e67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e6a:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e6f:	e8 3c 37 00 00       	call   801045b0 <acquire>
  if(f->ref < 1)
80100e74:	8b 43 04             	mov    0x4(%ebx),%eax
80100e77:	83 c4 10             	add    $0x10,%esp
80100e7a:	85 c0                	test   %eax,%eax
80100e7c:	7e 1a                	jle    80100e98 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e7e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e81:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e84:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e87:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e8c:	e8 3f 38 00 00       	call   801046d0 <release>
  return f;
}
80100e91:	89 d8                	mov    %ebx,%eax
80100e93:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e96:	c9                   	leave  
80100e97:	c3                   	ret    
    panic("filedup");
80100e98:	83 ec 0c             	sub    $0xc,%esp
80100e9b:	68 74 71 10 80       	push   $0x80107174
80100ea0:	e8 db f4 ff ff       	call   80100380 <panic>
80100ea5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100eb0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100eb0:	55                   	push   %ebp
80100eb1:	89 e5                	mov    %esp,%ebp
80100eb3:	57                   	push   %edi
80100eb4:	56                   	push   %esi
80100eb5:	53                   	push   %ebx
80100eb6:	83 ec 28             	sub    $0x28,%esp
80100eb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100ebc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100ec1:	e8 ea 36 00 00       	call   801045b0 <acquire>
  if(f->ref < 1)
80100ec6:	8b 53 04             	mov    0x4(%ebx),%edx
80100ec9:	83 c4 10             	add    $0x10,%esp
80100ecc:	85 d2                	test   %edx,%edx
80100ece:	0f 8e a5 00 00 00    	jle    80100f79 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100ed4:	83 ea 01             	sub    $0x1,%edx
80100ed7:	89 53 04             	mov    %edx,0x4(%ebx)
80100eda:	75 44                	jne    80100f20 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100edc:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ee0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ee3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100ee5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100eeb:	8b 73 0c             	mov    0xc(%ebx),%esi
80100eee:	88 45 e7             	mov    %al,-0x19(%ebp)
80100ef1:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ef4:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100ef9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100efc:	e8 cf 37 00 00       	call   801046d0 <release>

  if(ff.type == FD_PIPE)
80100f01:	83 c4 10             	add    $0x10,%esp
80100f04:	83 ff 01             	cmp    $0x1,%edi
80100f07:	74 57                	je     80100f60 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f09:	83 ff 02             	cmp    $0x2,%edi
80100f0c:	74 2a                	je     80100f38 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f11:	5b                   	pop    %ebx
80100f12:	5e                   	pop    %esi
80100f13:	5f                   	pop    %edi
80100f14:	5d                   	pop    %ebp
80100f15:	c3                   	ret    
80100f16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f1d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80100f20:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
}
80100f27:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f2a:	5b                   	pop    %ebx
80100f2b:	5e                   	pop    %esi
80100f2c:	5f                   	pop    %edi
80100f2d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f2e:	e9 9d 37 00 00       	jmp    801046d0 <release>
80100f33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f37:	90                   	nop
    begin_op();
80100f38:	e8 83 1f 00 00       	call   80102ec0 <begin_op>
    iput(ff.ip);
80100f3d:	83 ec 0c             	sub    $0xc,%esp
80100f40:	ff 75 e0             	pushl  -0x20(%ebp)
80100f43:	e8 f8 08 00 00       	call   80101840 <iput>
    end_op();
80100f48:	83 c4 10             	add    $0x10,%esp
}
80100f4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f4e:	5b                   	pop    %ebx
80100f4f:	5e                   	pop    %esi
80100f50:	5f                   	pop    %edi
80100f51:	5d                   	pop    %ebp
    end_op();
80100f52:	e9 d9 1f 00 00       	jmp    80102f30 <end_op>
80100f57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f5e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100f60:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f64:	83 ec 08             	sub    $0x8,%esp
80100f67:	53                   	push   %ebx
80100f68:	56                   	push   %esi
80100f69:	e8 f2 26 00 00       	call   80103660 <pipeclose>
80100f6e:	83 c4 10             	add    $0x10,%esp
}
80100f71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f74:	5b                   	pop    %ebx
80100f75:	5e                   	pop    %esi
80100f76:	5f                   	pop    %edi
80100f77:	5d                   	pop    %ebp
80100f78:	c3                   	ret    
    panic("fileclose");
80100f79:	83 ec 0c             	sub    $0xc,%esp
80100f7c:	68 7c 71 10 80       	push   $0x8010717c
80100f81:	e8 fa f3 ff ff       	call   80100380 <panic>
80100f86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f8d:	8d 76 00             	lea    0x0(%esi),%esi

80100f90 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f90:	55                   	push   %ebp
80100f91:	89 e5                	mov    %esp,%ebp
80100f93:	53                   	push   %ebx
80100f94:	83 ec 04             	sub    $0x4,%esp
80100f97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f9a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f9d:	75 31                	jne    80100fd0 <filestat+0x40>
    ilock(f->ip);
80100f9f:	83 ec 0c             	sub    $0xc,%esp
80100fa2:	ff 73 10             	pushl  0x10(%ebx)
80100fa5:	e8 66 07 00 00       	call   80101710 <ilock>
    stati(f->ip, st);
80100faa:	58                   	pop    %eax
80100fab:	5a                   	pop    %edx
80100fac:	ff 75 0c             	pushl  0xc(%ebp)
80100faf:	ff 73 10             	pushl  0x10(%ebx)
80100fb2:	e8 09 0a 00 00       	call   801019c0 <stati>
    iunlock(f->ip);
80100fb7:	59                   	pop    %ecx
80100fb8:	ff 73 10             	pushl  0x10(%ebx)
80100fbb:	e8 30 08 00 00       	call   801017f0 <iunlock>
    return 0;
  }
  return -1;
}
80100fc0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80100fc3:	83 c4 10             	add    $0x10,%esp
80100fc6:	31 c0                	xor    %eax,%eax
}
80100fc8:	c9                   	leave  
80100fc9:	c3                   	ret    
80100fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fd0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80100fd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100fd8:	c9                   	leave  
80100fd9:	c3                   	ret    
80100fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100fe0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 0c             	sub    $0xc,%esp
80100fe9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100fec:	8b 75 0c             	mov    0xc(%ebp),%esi
80100fef:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100ff2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100ff6:	74 60                	je     80101058 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100ff8:	8b 03                	mov    (%ebx),%eax
80100ffa:	83 f8 01             	cmp    $0x1,%eax
80100ffd:	74 41                	je     80101040 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fff:	83 f8 02             	cmp    $0x2,%eax
80101002:	75 5b                	jne    8010105f <fileread+0x7f>
    ilock(f->ip);
80101004:	83 ec 0c             	sub    $0xc,%esp
80101007:	ff 73 10             	pushl  0x10(%ebx)
8010100a:	e8 01 07 00 00       	call   80101710 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010100f:	57                   	push   %edi
80101010:	ff 73 14             	pushl  0x14(%ebx)
80101013:	56                   	push   %esi
80101014:	ff 73 10             	pushl  0x10(%ebx)
80101017:	e8 d4 09 00 00       	call   801019f0 <readi>
8010101c:	83 c4 20             	add    $0x20,%esp
8010101f:	89 c6                	mov    %eax,%esi
80101021:	85 c0                	test   %eax,%eax
80101023:	7e 03                	jle    80101028 <fileread+0x48>
      f->off += r;
80101025:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101028:	83 ec 0c             	sub    $0xc,%esp
8010102b:	ff 73 10             	pushl  0x10(%ebx)
8010102e:	e8 bd 07 00 00       	call   801017f0 <iunlock>
    return r;
80101033:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101036:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101039:	89 f0                	mov    %esi,%eax
8010103b:	5b                   	pop    %ebx
8010103c:	5e                   	pop    %esi
8010103d:	5f                   	pop    %edi
8010103e:	5d                   	pop    %ebp
8010103f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101040:	8b 43 0c             	mov    0xc(%ebx),%eax
80101043:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101046:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101049:	5b                   	pop    %ebx
8010104a:	5e                   	pop    %esi
8010104b:	5f                   	pop    %edi
8010104c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010104d:	e9 ae 27 00 00       	jmp    80103800 <piperead>
80101052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101058:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010105d:	eb d7                	jmp    80101036 <fileread+0x56>
  panic("fileread");
8010105f:	83 ec 0c             	sub    $0xc,%esp
80101062:	68 86 71 10 80       	push   $0x80107186
80101067:	e8 14 f3 ff ff       	call   80100380 <panic>
8010106c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101070 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101070:	55                   	push   %ebp
80101071:	89 e5                	mov    %esp,%ebp
80101073:	57                   	push   %edi
80101074:	56                   	push   %esi
80101075:	53                   	push   %ebx
80101076:	83 ec 1c             	sub    $0x1c,%esp
80101079:	8b 45 0c             	mov    0xc(%ebp),%eax
8010107c:	8b 75 08             	mov    0x8(%ebp),%esi
8010107f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101082:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101085:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101089:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010108c:	0f 84 bd 00 00 00    	je     8010114f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
80101092:	8b 06                	mov    (%esi),%eax
80101094:	83 f8 01             	cmp    $0x1,%eax
80101097:	0f 84 bf 00 00 00    	je     8010115c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010109d:	83 f8 02             	cmp    $0x2,%eax
801010a0:	0f 85 c8 00 00 00    	jne    8010116e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010a9:	31 ff                	xor    %edi,%edi
    while(i < n){
801010ab:	85 c0                	test   %eax,%eax
801010ad:	7f 30                	jg     801010df <filewrite+0x6f>
801010af:	e9 94 00 00 00       	jmp    80101148 <filewrite+0xd8>
801010b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010b8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801010bb:	83 ec 0c             	sub    $0xc,%esp
801010be:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801010c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801010c4:	e8 27 07 00 00       	call   801017f0 <iunlock>
      end_op();
801010c9:	e8 62 1e 00 00       	call   80102f30 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801010ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010d1:	83 c4 10             	add    $0x10,%esp
801010d4:	39 c3                	cmp    %eax,%ebx
801010d6:	75 60                	jne    80101138 <filewrite+0xc8>
        panic("short filewrite");
      i += r;
801010d8:	01 df                	add    %ebx,%edi
    while(i < n){
801010da:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010dd:	7e 69                	jle    80101148 <filewrite+0xd8>
      int n1 = n - i;
801010df:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010e2:	b8 00 06 00 00       	mov    $0x600,%eax
801010e7:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
801010e9:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801010ef:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801010f2:	e8 c9 1d 00 00       	call   80102ec0 <begin_op>
      ilock(f->ip);
801010f7:	83 ec 0c             	sub    $0xc,%esp
801010fa:	ff 76 10             	pushl  0x10(%esi)
801010fd:	e8 0e 06 00 00       	call   80101710 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101102:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101105:	53                   	push   %ebx
80101106:	ff 76 14             	pushl  0x14(%esi)
80101109:	01 f8                	add    %edi,%eax
8010110b:	50                   	push   %eax
8010110c:	ff 76 10             	pushl  0x10(%esi)
8010110f:	e8 dc 09 00 00       	call   80101af0 <writei>
80101114:	83 c4 20             	add    $0x20,%esp
80101117:	85 c0                	test   %eax,%eax
80101119:	7f 9d                	jg     801010b8 <filewrite+0x48>
      iunlock(f->ip);
8010111b:	83 ec 0c             	sub    $0xc,%esp
8010111e:	ff 76 10             	pushl  0x10(%esi)
80101121:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101124:	e8 c7 06 00 00       	call   801017f0 <iunlock>
      end_op();
80101129:	e8 02 1e 00 00       	call   80102f30 <end_op>
      if(r < 0)
8010112e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101131:	83 c4 10             	add    $0x10,%esp
80101134:	85 c0                	test   %eax,%eax
80101136:	75 17                	jne    8010114f <filewrite+0xdf>
        panic("short filewrite");
80101138:	83 ec 0c             	sub    $0xc,%esp
8010113b:	68 8f 71 10 80       	push   $0x8010718f
80101140:	e8 3b f2 ff ff       	call   80100380 <panic>
80101145:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101148:	89 f8                	mov    %edi,%eax
8010114a:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
8010114d:	74 05                	je     80101154 <filewrite+0xe4>
8010114f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101154:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101157:	5b                   	pop    %ebx
80101158:	5e                   	pop    %esi
80101159:	5f                   	pop    %edi
8010115a:	5d                   	pop    %ebp
8010115b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
8010115c:	8b 46 0c             	mov    0xc(%esi),%eax
8010115f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101162:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101165:	5b                   	pop    %ebx
80101166:	5e                   	pop    %esi
80101167:	5f                   	pop    %edi
80101168:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101169:	e9 92 25 00 00       	jmp    80103700 <pipewrite>
  panic("filewrite");
8010116e:	83 ec 0c             	sub    $0xc,%esp
80101171:	68 95 71 10 80       	push   $0x80107195
80101176:	e8 05 f2 ff ff       	call   80100380 <panic>
8010117b:	66 90                	xchg   %ax,%ax
8010117d:	66 90                	xchg   %ax,%ax
8010117f:	90                   	nop

80101180 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101180:	55                   	push   %ebp
80101181:	89 e5                	mov    %esp,%ebp
80101183:	57                   	push   %edi
80101184:	56                   	push   %esi
80101185:	53                   	push   %ebx
80101186:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101189:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
{
8010118f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101192:	85 c9                	test   %ecx,%ecx
80101194:	0f 84 87 00 00 00    	je     80101221 <balloc+0xa1>
8010119a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011a1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011a4:	83 ec 08             	sub    $0x8,%esp
801011a7:	89 f0                	mov    %esi,%eax
801011a9:	c1 f8 0c             	sar    $0xc,%eax
801011ac:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801011b2:	50                   	push   %eax
801011b3:	ff 75 d8             	pushl  -0x28(%ebp)
801011b6:	e8 15 ef ff ff       	call   801000d0 <bread>
801011bb:	83 c4 10             	add    $0x10,%esp
801011be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011c1:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011c9:	31 c0                	xor    %eax,%eax
801011cb:	eb 2f                	jmp    801011fc <balloc+0x7c>
801011cd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011d0:	89 c1                	mov    %eax,%ecx
801011d2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011d7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801011da:	83 e1 07             	and    $0x7,%ecx
801011dd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011df:	89 c1                	mov    %eax,%ecx
801011e1:	c1 f9 03             	sar    $0x3,%ecx
801011e4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801011e9:	89 fa                	mov    %edi,%edx
801011eb:	85 df                	test   %ebx,%edi
801011ed:	74 41                	je     80101230 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011ef:	83 c0 01             	add    $0x1,%eax
801011f2:	83 c6 01             	add    $0x1,%esi
801011f5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011fa:	74 05                	je     80101201 <balloc+0x81>
801011fc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801011ff:	77 cf                	ja     801011d0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101201:	83 ec 0c             	sub    $0xc,%esp
80101204:	ff 75 e4             	pushl  -0x1c(%ebp)
80101207:	e8 e4 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010120c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101213:	83 c4 10             	add    $0x10,%esp
80101216:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101219:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010121f:	77 80                	ja     801011a1 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101221:	83 ec 0c             	sub    $0xc,%esp
80101224:	68 9f 71 10 80       	push   $0x8010719f
80101229:	e8 52 f1 ff ff       	call   80100380 <panic>
8010122e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101230:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101233:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101236:	09 da                	or     %ebx,%edx
80101238:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010123c:	57                   	push   %edi
8010123d:	e8 5e 1e 00 00       	call   801030a0 <log_write>
        brelse(bp);
80101242:	89 3c 24             	mov    %edi,(%esp)
80101245:	e8 a6 ef ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010124a:	58                   	pop    %eax
8010124b:	5a                   	pop    %edx
8010124c:	56                   	push   %esi
8010124d:	ff 75 d8             	pushl  -0x28(%ebp)
80101250:	e8 7b ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101255:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101258:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010125a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010125d:	68 00 02 00 00       	push   $0x200
80101262:	6a 00                	push   $0x0
80101264:	50                   	push   %eax
80101265:	e8 b6 34 00 00       	call   80104720 <memset>
  log_write(bp);
8010126a:	89 1c 24             	mov    %ebx,(%esp)
8010126d:	e8 2e 1e 00 00       	call   801030a0 <log_write>
  brelse(bp);
80101272:	89 1c 24             	mov    %ebx,(%esp)
80101275:	e8 76 ef ff ff       	call   801001f0 <brelse>
}
8010127a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127d:	89 f0                	mov    %esi,%eax
8010127f:	5b                   	pop    %ebx
80101280:	5e                   	pop    %esi
80101281:	5f                   	pop    %edi
80101282:	5d                   	pop    %ebp
80101283:	c3                   	ret    
80101284:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010128b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010128f:	90                   	nop

80101290 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101290:	55                   	push   %ebp
80101291:	89 e5                	mov    %esp,%ebp
80101293:	57                   	push   %edi
80101294:	89 c7                	mov    %eax,%edi
80101296:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101297:	31 f6                	xor    %esi,%esi
{
80101299:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010129a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
8010129f:	83 ec 28             	sub    $0x28,%esp
801012a2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012a5:	68 e0 09 11 80       	push   $0x801109e0
801012aa:	e8 01 33 00 00       	call   801045b0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012af:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801012b2:	83 c4 10             	add    $0x10,%esp
801012b5:	eb 1b                	jmp    801012d2 <iget+0x42>
801012b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012be:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012c0:	39 3b                	cmp    %edi,(%ebx)
801012c2:	74 6c                	je     80101330 <iget+0xa0>
801012c4:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ca:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012d0:	73 26                	jae    801012f8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012d2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012d5:	85 c9                	test   %ecx,%ecx
801012d7:	7f e7                	jg     801012c0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012d9:	85 f6                	test   %esi,%esi
801012db:	75 e7                	jne    801012c4 <iget+0x34>
801012dd:	89 d8                	mov    %ebx,%eax
801012df:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012e5:	85 c9                	test   %ecx,%ecx
801012e7:	75 6e                	jne    80101357 <iget+0xc7>
801012e9:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012eb:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012f1:	72 df                	jb     801012d2 <iget+0x42>
801012f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801012f7:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012f8:	85 f6                	test   %esi,%esi
801012fa:	74 73                	je     8010136f <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801012fc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801012ff:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101301:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101304:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010130b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101312:	68 e0 09 11 80       	push   $0x801109e0
80101317:	e8 b4 33 00 00       	call   801046d0 <release>

  return ip;
8010131c:	83 c4 10             	add    $0x10,%esp
}
8010131f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101322:	89 f0                	mov    %esi,%eax
80101324:	5b                   	pop    %ebx
80101325:	5e                   	pop    %esi
80101326:	5f                   	pop    %edi
80101327:	5d                   	pop    %ebp
80101328:	c3                   	ret    
80101329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101330:	39 53 04             	cmp    %edx,0x4(%ebx)
80101333:	75 8f                	jne    801012c4 <iget+0x34>
      release(&icache.lock);
80101335:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101338:	83 c1 01             	add    $0x1,%ecx
      return ip;
8010133b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010133d:	68 e0 09 11 80       	push   $0x801109e0
      ip->ref++;
80101342:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101345:	e8 86 33 00 00       	call   801046d0 <release>
      return ip;
8010134a:	83 c4 10             	add    $0x10,%esp
}
8010134d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101350:	89 f0                	mov    %esi,%eax
80101352:	5b                   	pop    %ebx
80101353:	5e                   	pop    %esi
80101354:	5f                   	pop    %edi
80101355:	5d                   	pop    %ebp
80101356:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101357:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
8010135d:	73 10                	jae    8010136f <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010135f:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101362:	85 c9                	test   %ecx,%ecx
80101364:	0f 8f 56 ff ff ff    	jg     801012c0 <iget+0x30>
8010136a:	e9 6e ff ff ff       	jmp    801012dd <iget+0x4d>
    panic("iget: no inodes");
8010136f:	83 ec 0c             	sub    $0xc,%esp
80101372:	68 b5 71 10 80       	push   $0x801071b5
80101377:	e8 04 f0 ff ff       	call   80100380 <panic>
8010137c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101380 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101380:	55                   	push   %ebp
80101381:	89 e5                	mov    %esp,%ebp
80101383:	57                   	push   %edi
80101384:	56                   	push   %esi
80101385:	89 c6                	mov    %eax,%esi
80101387:	53                   	push   %ebx
80101388:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010138b:	83 fa 0b             	cmp    $0xb,%edx
8010138e:	0f 86 84 00 00 00    	jbe    80101418 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101394:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101397:	83 fb 7f             	cmp    $0x7f,%ebx
8010139a:	0f 87 98 00 00 00    	ja     80101438 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801013a0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801013a6:	8b 16                	mov    (%esi),%edx
801013a8:	85 c0                	test   %eax,%eax
801013aa:	74 54                	je     80101400 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801013ac:	83 ec 08             	sub    $0x8,%esp
801013af:	50                   	push   %eax
801013b0:	52                   	push   %edx
801013b1:	e8 1a ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801013b6:	83 c4 10             	add    $0x10,%esp
801013b9:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
801013bd:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013bf:	8b 1a                	mov    (%edx),%ebx
801013c1:	85 db                	test   %ebx,%ebx
801013c3:	74 1b                	je     801013e0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801013c5:	83 ec 0c             	sub    $0xc,%esp
801013c8:	57                   	push   %edi
801013c9:	e8 22 ee ff ff       	call   801001f0 <brelse>
    return addr;
801013ce:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
801013d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013d4:	89 d8                	mov    %ebx,%eax
801013d6:	5b                   	pop    %ebx
801013d7:	5e                   	pop    %esi
801013d8:	5f                   	pop    %edi
801013d9:	5d                   	pop    %ebp
801013da:	c3                   	ret    
801013db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801013df:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
801013e0:	8b 06                	mov    (%esi),%eax
801013e2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013e5:	e8 96 fd ff ff       	call   80101180 <balloc>
801013ea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801013ed:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801013f0:	89 c3                	mov    %eax,%ebx
801013f2:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801013f4:	57                   	push   %edi
801013f5:	e8 a6 1c 00 00       	call   801030a0 <log_write>
801013fa:	83 c4 10             	add    $0x10,%esp
801013fd:	eb c6                	jmp    801013c5 <bmap+0x45>
801013ff:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101400:	89 d0                	mov    %edx,%eax
80101402:	e8 79 fd ff ff       	call   80101180 <balloc>
80101407:	8b 16                	mov    (%esi),%edx
80101409:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010140f:	eb 9b                	jmp    801013ac <bmap+0x2c>
80101411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101418:	8d 3c 90             	lea    (%eax,%edx,4),%edi
8010141b:	8b 5f 5c             	mov    0x5c(%edi),%ebx
8010141e:	85 db                	test   %ebx,%ebx
80101420:	75 af                	jne    801013d1 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101422:	8b 00                	mov    (%eax),%eax
80101424:	e8 57 fd ff ff       	call   80101180 <balloc>
80101429:	89 47 5c             	mov    %eax,0x5c(%edi)
8010142c:	89 c3                	mov    %eax,%ebx
}
8010142e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101431:	89 d8                	mov    %ebx,%eax
80101433:	5b                   	pop    %ebx
80101434:	5e                   	pop    %esi
80101435:	5f                   	pop    %edi
80101436:	5d                   	pop    %ebp
80101437:	c3                   	ret    
  panic("bmap: out of range");
80101438:	83 ec 0c             	sub    $0xc,%esp
8010143b:	68 c5 71 10 80       	push   $0x801071c5
80101440:	e8 3b ef ff ff       	call   80100380 <panic>
80101445:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010144c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101450 <readsb>:
{
80101450:	55                   	push   %ebp
80101451:	89 e5                	mov    %esp,%ebp
80101453:	56                   	push   %esi
80101454:	53                   	push   %ebx
80101455:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101458:	83 ec 08             	sub    $0x8,%esp
8010145b:	6a 01                	push   $0x1
8010145d:	ff 75 08             	pushl  0x8(%ebp)
80101460:	e8 6b ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101465:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101468:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010146a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010146d:	6a 1c                	push   $0x1c
8010146f:	50                   	push   %eax
80101470:	56                   	push   %esi
80101471:	e8 4a 33 00 00       	call   801047c0 <memmove>
  brelse(bp);
80101476:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101479:	83 c4 10             	add    $0x10,%esp
}
8010147c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010147f:	5b                   	pop    %ebx
80101480:	5e                   	pop    %esi
80101481:	5d                   	pop    %ebp
  brelse(bp);
80101482:	e9 69 ed ff ff       	jmp    801001f0 <brelse>
80101487:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010148e:	66 90                	xchg   %ax,%ax

80101490 <bfree>:
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	56                   	push   %esi
80101494:	89 c6                	mov    %eax,%esi
80101496:	53                   	push   %ebx
80101497:	89 d3                	mov    %edx,%ebx
  readsb(dev, &sb);
80101499:	83 ec 08             	sub    $0x8,%esp
8010149c:	68 c0 09 11 80       	push   $0x801109c0
801014a1:	50                   	push   %eax
801014a2:	e8 a9 ff ff ff       	call   80101450 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801014a7:	58                   	pop    %eax
801014a8:	89 d8                	mov    %ebx,%eax
801014aa:	5a                   	pop    %edx
801014ab:	c1 e8 0c             	shr    $0xc,%eax
801014ae:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801014b4:	50                   	push   %eax
801014b5:	56                   	push   %esi
801014b6:	e8 15 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801014bb:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014bd:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801014c0:	ba 01 00 00 00       	mov    $0x1,%edx
801014c5:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801014c8:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801014ce:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801014d1:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801014d3:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801014d8:	85 d1                	test   %edx,%ecx
801014da:	74 25                	je     80101501 <bfree+0x71>
  bp->data[bi/8] &= ~m;
801014dc:	f7 d2                	not    %edx
  log_write(bp);
801014de:	83 ec 0c             	sub    $0xc,%esp
801014e1:	89 c6                	mov    %eax,%esi
  bp->data[bi/8] &= ~m;
801014e3:	21 ca                	and    %ecx,%edx
801014e5:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
  log_write(bp);
801014e9:	50                   	push   %eax
801014ea:	e8 b1 1b 00 00       	call   801030a0 <log_write>
  brelse(bp);
801014ef:	89 34 24             	mov    %esi,(%esp)
801014f2:	e8 f9 ec ff ff       	call   801001f0 <brelse>
}
801014f7:	83 c4 10             	add    $0x10,%esp
801014fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014fd:	5b                   	pop    %ebx
801014fe:	5e                   	pop    %esi
801014ff:	5d                   	pop    %ebp
80101500:	c3                   	ret    
    panic("freeing free block");
80101501:	83 ec 0c             	sub    $0xc,%esp
80101504:	68 d8 71 10 80       	push   $0x801071d8
80101509:	e8 72 ee ff ff       	call   80100380 <panic>
8010150e:	66 90                	xchg   %ax,%ax

80101510 <iinit>:
{
80101510:	55                   	push   %ebp
80101511:	89 e5                	mov    %esp,%ebp
80101513:	53                   	push   %ebx
80101514:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101519:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010151c:	68 eb 71 10 80       	push   $0x801071eb
80101521:	68 e0 09 11 80       	push   $0x801109e0
80101526:	e8 85 2f 00 00       	call   801044b0 <initlock>
  for(i = 0; i < NINODE; i++) {
8010152b:	83 c4 10             	add    $0x10,%esp
8010152e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101530:	83 ec 08             	sub    $0x8,%esp
80101533:	68 f2 71 10 80       	push   $0x801071f2
80101538:	53                   	push   %ebx
80101539:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010153f:	e8 5c 2e 00 00       	call   801043a0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101544:	83 c4 10             	add    $0x10,%esp
80101547:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
8010154d:	75 e1                	jne    80101530 <iinit+0x20>
  readsb(dev, &sb);
8010154f:	83 ec 08             	sub    $0x8,%esp
80101552:	68 c0 09 11 80       	push   $0x801109c0
80101557:	ff 75 08             	pushl  0x8(%ebp)
8010155a:	e8 f1 fe ff ff       	call   80101450 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010155f:	ff 35 d8 09 11 80    	pushl  0x801109d8
80101565:	ff 35 d4 09 11 80    	pushl  0x801109d4
8010156b:	ff 35 d0 09 11 80    	pushl  0x801109d0
80101571:	ff 35 cc 09 11 80    	pushl  0x801109cc
80101577:	ff 35 c8 09 11 80    	pushl  0x801109c8
8010157d:	ff 35 c4 09 11 80    	pushl  0x801109c4
80101583:	ff 35 c0 09 11 80    	pushl  0x801109c0
80101589:	68 b8 72 10 80       	push   $0x801072b8
8010158e:	e8 0d f1 ff ff       	call   801006a0 <cprintf>
}
80101593:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101596:	83 c4 30             	add    $0x30,%esp
80101599:	c9                   	leave  
8010159a:	c3                   	ret    
8010159b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010159f:	90                   	nop

801015a0 <ialloc>:
{
801015a0:	55                   	push   %ebp
801015a1:	89 e5                	mov    %esp,%ebp
801015a3:	57                   	push   %edi
801015a4:	56                   	push   %esi
801015a5:	53                   	push   %ebx
801015a6:	83 ec 1c             	sub    $0x1c,%esp
801015a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801015ac:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
801015b3:	8b 75 08             	mov    0x8(%ebp),%esi
801015b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801015b9:	0f 86 91 00 00 00    	jbe    80101650 <ialloc+0xb0>
801015bf:	bf 01 00 00 00       	mov    $0x1,%edi
801015c4:	eb 21                	jmp    801015e7 <ialloc+0x47>
801015c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015cd:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
801015d0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801015d3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
801015d6:	53                   	push   %ebx
801015d7:	e8 14 ec ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801015dc:	83 c4 10             	add    $0x10,%esp
801015df:	3b 3d c8 09 11 80    	cmp    0x801109c8,%edi
801015e5:	73 69                	jae    80101650 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801015e7:	89 f8                	mov    %edi,%eax
801015e9:	83 ec 08             	sub    $0x8,%esp
801015ec:	c1 e8 03             	shr    $0x3,%eax
801015ef:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801015f5:	50                   	push   %eax
801015f6:	56                   	push   %esi
801015f7:	e8 d4 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
801015fc:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801015ff:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101601:	89 f8                	mov    %edi,%eax
80101603:	83 e0 07             	and    $0x7,%eax
80101606:	c1 e0 06             	shl    $0x6,%eax
80101609:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010160d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101611:	75 bd                	jne    801015d0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101613:	83 ec 04             	sub    $0x4,%esp
80101616:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101619:	6a 40                	push   $0x40
8010161b:	6a 00                	push   $0x0
8010161d:	51                   	push   %ecx
8010161e:	e8 fd 30 00 00       	call   80104720 <memset>
      dip->type = type;
80101623:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101627:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010162a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010162d:	89 1c 24             	mov    %ebx,(%esp)
80101630:	e8 6b 1a 00 00       	call   801030a0 <log_write>
      brelse(bp);
80101635:	89 1c 24             	mov    %ebx,(%esp)
80101638:	e8 b3 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010163d:	83 c4 10             	add    $0x10,%esp
}
80101640:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101643:	89 fa                	mov    %edi,%edx
}
80101645:	5b                   	pop    %ebx
      return iget(dev, inum);
80101646:	89 f0                	mov    %esi,%eax
}
80101648:	5e                   	pop    %esi
80101649:	5f                   	pop    %edi
8010164a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010164b:	e9 40 fc ff ff       	jmp    80101290 <iget>
  panic("ialloc: no inodes");
80101650:	83 ec 0c             	sub    $0xc,%esp
80101653:	68 f8 71 10 80       	push   $0x801071f8
80101658:	e8 23 ed ff ff       	call   80100380 <panic>
8010165d:	8d 76 00             	lea    0x0(%esi),%esi

80101660 <iupdate>:
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	56                   	push   %esi
80101664:	53                   	push   %ebx
80101665:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101668:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010166b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010166e:	83 ec 08             	sub    $0x8,%esp
80101671:	c1 e8 03             	shr    $0x3,%eax
80101674:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010167a:	50                   	push   %eax
8010167b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010167e:	e8 4d ea ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101683:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101687:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010168a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010168c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010168f:	83 e0 07             	and    $0x7,%eax
80101692:	c1 e0 06             	shl    $0x6,%eax
80101695:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101699:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010169c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016a0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801016a3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801016a7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801016ab:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801016af:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801016b3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801016b7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801016ba:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016bd:	6a 34                	push   $0x34
801016bf:	53                   	push   %ebx
801016c0:	50                   	push   %eax
801016c1:	e8 fa 30 00 00       	call   801047c0 <memmove>
  log_write(bp);
801016c6:	89 34 24             	mov    %esi,(%esp)
801016c9:	e8 d2 19 00 00       	call   801030a0 <log_write>
  brelse(bp);
801016ce:	89 75 08             	mov    %esi,0x8(%ebp)
801016d1:	83 c4 10             	add    $0x10,%esp
}
801016d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016d7:	5b                   	pop    %ebx
801016d8:	5e                   	pop    %esi
801016d9:	5d                   	pop    %ebp
  brelse(bp);
801016da:	e9 11 eb ff ff       	jmp    801001f0 <brelse>
801016df:	90                   	nop

801016e0 <idup>:
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	53                   	push   %ebx
801016e4:	83 ec 10             	sub    $0x10,%esp
801016e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801016ea:	68 e0 09 11 80       	push   $0x801109e0
801016ef:	e8 bc 2e 00 00       	call   801045b0 <acquire>
  ip->ref++;
801016f4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801016f8:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801016ff:	e8 cc 2f 00 00       	call   801046d0 <release>
}
80101704:	89 d8                	mov    %ebx,%eax
80101706:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101709:	c9                   	leave  
8010170a:	c3                   	ret    
8010170b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010170f:	90                   	nop

80101710 <ilock>:
{
80101710:	55                   	push   %ebp
80101711:	89 e5                	mov    %esp,%ebp
80101713:	56                   	push   %esi
80101714:	53                   	push   %ebx
80101715:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101718:	85 db                	test   %ebx,%ebx
8010171a:	0f 84 b7 00 00 00    	je     801017d7 <ilock+0xc7>
80101720:	8b 53 08             	mov    0x8(%ebx),%edx
80101723:	85 d2                	test   %edx,%edx
80101725:	0f 8e ac 00 00 00    	jle    801017d7 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010172b:	83 ec 0c             	sub    $0xc,%esp
8010172e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101731:	50                   	push   %eax
80101732:	e8 a9 2c 00 00       	call   801043e0 <acquiresleep>
  if(ip->valid == 0){
80101737:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010173a:	83 c4 10             	add    $0x10,%esp
8010173d:	85 c0                	test   %eax,%eax
8010173f:	74 0f                	je     80101750 <ilock+0x40>
}
80101741:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101744:	5b                   	pop    %ebx
80101745:	5e                   	pop    %esi
80101746:	5d                   	pop    %ebp
80101747:	c3                   	ret    
80101748:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010174f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101750:	8b 43 04             	mov    0x4(%ebx),%eax
80101753:	83 ec 08             	sub    $0x8,%esp
80101756:	c1 e8 03             	shr    $0x3,%eax
80101759:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010175f:	50                   	push   %eax
80101760:	ff 33                	pushl  (%ebx)
80101762:	e8 69 e9 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101767:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010176a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010176c:	8b 43 04             	mov    0x4(%ebx),%eax
8010176f:	83 e0 07             	and    $0x7,%eax
80101772:	c1 e0 06             	shl    $0x6,%eax
80101775:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101779:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010177c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010177f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101783:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101787:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010178b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010178f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101793:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101797:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010179b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010179e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017a1:	6a 34                	push   $0x34
801017a3:	50                   	push   %eax
801017a4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801017a7:	50                   	push   %eax
801017a8:	e8 13 30 00 00       	call   801047c0 <memmove>
    brelse(bp);
801017ad:	89 34 24             	mov    %esi,(%esp)
801017b0:	e8 3b ea ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
801017b5:	83 c4 10             	add    $0x10,%esp
801017b8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801017bd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801017c4:	0f 85 77 ff ff ff    	jne    80101741 <ilock+0x31>
      panic("ilock: no type");
801017ca:	83 ec 0c             	sub    $0xc,%esp
801017cd:	68 10 72 10 80       	push   $0x80107210
801017d2:	e8 a9 eb ff ff       	call   80100380 <panic>
    panic("ilock");
801017d7:	83 ec 0c             	sub    $0xc,%esp
801017da:	68 0a 72 10 80       	push   $0x8010720a
801017df:	e8 9c eb ff ff       	call   80100380 <panic>
801017e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801017ef:	90                   	nop

801017f0 <iunlock>:
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	56                   	push   %esi
801017f4:	53                   	push   %ebx
801017f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801017f8:	85 db                	test   %ebx,%ebx
801017fa:	74 28                	je     80101824 <iunlock+0x34>
801017fc:	83 ec 0c             	sub    $0xc,%esp
801017ff:	8d 73 0c             	lea    0xc(%ebx),%esi
80101802:	56                   	push   %esi
80101803:	e8 78 2c 00 00       	call   80104480 <holdingsleep>
80101808:	83 c4 10             	add    $0x10,%esp
8010180b:	85 c0                	test   %eax,%eax
8010180d:	74 15                	je     80101824 <iunlock+0x34>
8010180f:	8b 43 08             	mov    0x8(%ebx),%eax
80101812:	85 c0                	test   %eax,%eax
80101814:	7e 0e                	jle    80101824 <iunlock+0x34>
  releasesleep(&ip->lock);
80101816:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101819:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010181c:	5b                   	pop    %ebx
8010181d:	5e                   	pop    %esi
8010181e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010181f:	e9 1c 2c 00 00       	jmp    80104440 <releasesleep>
    panic("iunlock");
80101824:	83 ec 0c             	sub    $0xc,%esp
80101827:	68 1f 72 10 80       	push   $0x8010721f
8010182c:	e8 4f eb ff ff       	call   80100380 <panic>
80101831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101838:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010183f:	90                   	nop

80101840 <iput>:
{
80101840:	55                   	push   %ebp
80101841:	89 e5                	mov    %esp,%ebp
80101843:	57                   	push   %edi
80101844:	56                   	push   %esi
80101845:	53                   	push   %ebx
80101846:	83 ec 28             	sub    $0x28,%esp
80101849:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010184c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010184f:	57                   	push   %edi
80101850:	e8 8b 2b 00 00       	call   801043e0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101855:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101858:	83 c4 10             	add    $0x10,%esp
8010185b:	85 d2                	test   %edx,%edx
8010185d:	74 07                	je     80101866 <iput+0x26>
8010185f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101864:	74 32                	je     80101898 <iput+0x58>
  releasesleep(&ip->lock);
80101866:	83 ec 0c             	sub    $0xc,%esp
80101869:	57                   	push   %edi
8010186a:	e8 d1 2b 00 00       	call   80104440 <releasesleep>
  acquire(&icache.lock);
8010186f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101876:	e8 35 2d 00 00       	call   801045b0 <acquire>
  ip->ref--;
8010187b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010187f:	83 c4 10             	add    $0x10,%esp
80101882:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101889:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010188c:	5b                   	pop    %ebx
8010188d:	5e                   	pop    %esi
8010188e:	5f                   	pop    %edi
8010188f:	5d                   	pop    %ebp
  release(&icache.lock);
80101890:	e9 3b 2e 00 00       	jmp    801046d0 <release>
80101895:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101898:	83 ec 0c             	sub    $0xc,%esp
8010189b:	68 e0 09 11 80       	push   $0x801109e0
801018a0:	e8 0b 2d 00 00       	call   801045b0 <acquire>
    int r = ip->ref;
801018a5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801018a8:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801018af:	e8 1c 2e 00 00       	call   801046d0 <release>
    if(r == 1){
801018b4:	83 c4 10             	add    $0x10,%esp
801018b7:	83 fe 01             	cmp    $0x1,%esi
801018ba:	75 aa                	jne    80101866 <iput+0x26>
801018bc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801018c2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801018c5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801018c8:	89 cf                	mov    %ecx,%edi
801018ca:	eb 0b                	jmp    801018d7 <iput+0x97>
801018cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801018d0:	83 c6 04             	add    $0x4,%esi
801018d3:	39 fe                	cmp    %edi,%esi
801018d5:	74 19                	je     801018f0 <iput+0xb0>
    if(ip->addrs[i]){
801018d7:	8b 16                	mov    (%esi),%edx
801018d9:	85 d2                	test   %edx,%edx
801018db:	74 f3                	je     801018d0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801018dd:	8b 03                	mov    (%ebx),%eax
801018df:	e8 ac fb ff ff       	call   80101490 <bfree>
      ip->addrs[i] = 0;
801018e4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801018ea:	eb e4                	jmp    801018d0 <iput+0x90>
801018ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801018f0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801018f6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018f9:	85 c0                	test   %eax,%eax
801018fb:	75 33                	jne    80101930 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801018fd:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101900:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101907:	53                   	push   %ebx
80101908:	e8 53 fd ff ff       	call   80101660 <iupdate>
      ip->type = 0;
8010190d:	31 c0                	xor    %eax,%eax
8010190f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101913:	89 1c 24             	mov    %ebx,(%esp)
80101916:	e8 45 fd ff ff       	call   80101660 <iupdate>
      ip->valid = 0;
8010191b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101922:	83 c4 10             	add    $0x10,%esp
80101925:	e9 3c ff ff ff       	jmp    80101866 <iput+0x26>
8010192a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101930:	83 ec 08             	sub    $0x8,%esp
80101933:	50                   	push   %eax
80101934:	ff 33                	pushl  (%ebx)
80101936:	e8 95 e7 ff ff       	call   801000d0 <bread>
8010193b:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010193e:	83 c4 10             	add    $0x10,%esp
80101941:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101947:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
8010194a:	8d 70 5c             	lea    0x5c(%eax),%esi
8010194d:	89 cf                	mov    %ecx,%edi
8010194f:	eb 0e                	jmp    8010195f <iput+0x11f>
80101951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101958:	83 c6 04             	add    $0x4,%esi
8010195b:	39 f7                	cmp    %esi,%edi
8010195d:	74 11                	je     80101970 <iput+0x130>
      if(a[j])
8010195f:	8b 16                	mov    (%esi),%edx
80101961:	85 d2                	test   %edx,%edx
80101963:	74 f3                	je     80101958 <iput+0x118>
        bfree(ip->dev, a[j]);
80101965:	8b 03                	mov    (%ebx),%eax
80101967:	e8 24 fb ff ff       	call   80101490 <bfree>
8010196c:	eb ea                	jmp    80101958 <iput+0x118>
8010196e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101970:	83 ec 0c             	sub    $0xc,%esp
80101973:	ff 75 e4             	pushl  -0x1c(%ebp)
80101976:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101979:	e8 72 e8 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010197e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101984:	8b 03                	mov    (%ebx),%eax
80101986:	e8 05 fb ff ff       	call   80101490 <bfree>
    ip->addrs[NDIRECT] = 0;
8010198b:	83 c4 10             	add    $0x10,%esp
8010198e:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101995:	00 00 00 
80101998:	e9 60 ff ff ff       	jmp    801018fd <iput+0xbd>
8010199d:	8d 76 00             	lea    0x0(%esi),%esi

801019a0 <iunlockput>:
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	53                   	push   %ebx
801019a4:	83 ec 10             	sub    $0x10,%esp
801019a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019aa:	53                   	push   %ebx
801019ab:	e8 40 fe ff ff       	call   801017f0 <iunlock>
  iput(ip);
801019b0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801019b3:	83 c4 10             	add    $0x10,%esp
}
801019b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019b9:	c9                   	leave  
  iput(ip);
801019ba:	e9 81 fe ff ff       	jmp    80101840 <iput>
801019bf:	90                   	nop

801019c0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801019c0:	55                   	push   %ebp
801019c1:	89 e5                	mov    %esp,%ebp
801019c3:	8b 55 08             	mov    0x8(%ebp),%edx
801019c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801019c9:	8b 0a                	mov    (%edx),%ecx
801019cb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801019ce:	8b 4a 04             	mov    0x4(%edx),%ecx
801019d1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801019d4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801019d8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801019db:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801019df:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801019e3:	8b 52 58             	mov    0x58(%edx),%edx
801019e6:	89 50 10             	mov    %edx,0x10(%eax)
}
801019e9:	5d                   	pop    %ebp
801019ea:	c3                   	ret    
801019eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019ef:	90                   	nop

801019f0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019f0:	55                   	push   %ebp
801019f1:	89 e5                	mov    %esp,%ebp
801019f3:	57                   	push   %edi
801019f4:	56                   	push   %esi
801019f5:	53                   	push   %ebx
801019f6:	83 ec 1c             	sub    $0x1c,%esp
801019f9:	8b 7d 0c             	mov    0xc(%ebp),%edi
801019fc:	8b 45 08             	mov    0x8(%ebp),%eax
801019ff:	8b 75 10             	mov    0x10(%ebp),%esi
80101a02:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a05:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a08:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a0d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a10:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a13:	0f 84 a7 00 00 00    	je     80101ac0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a19:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a1c:	8b 40 58             	mov    0x58(%eax),%eax
80101a1f:	39 c6                	cmp    %eax,%esi
80101a21:	0f 87 ba 00 00 00    	ja     80101ae1 <readi+0xf1>
80101a27:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a2a:	31 c9                	xor    %ecx,%ecx
80101a2c:	89 da                	mov    %ebx,%edx
80101a2e:	01 f2                	add    %esi,%edx
80101a30:	0f 92 c1             	setb   %cl
80101a33:	89 cf                	mov    %ecx,%edi
80101a35:	0f 82 a6 00 00 00    	jb     80101ae1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a3b:	89 c1                	mov    %eax,%ecx
80101a3d:	29 f1                	sub    %esi,%ecx
80101a3f:	39 d0                	cmp    %edx,%eax
80101a41:	0f 43 cb             	cmovae %ebx,%ecx
80101a44:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a47:	85 c9                	test   %ecx,%ecx
80101a49:	74 67                	je     80101ab2 <readi+0xc2>
80101a4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a4f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a50:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a53:	89 f2                	mov    %esi,%edx
80101a55:	c1 ea 09             	shr    $0x9,%edx
80101a58:	89 d8                	mov    %ebx,%eax
80101a5a:	e8 21 f9 ff ff       	call   80101380 <bmap>
80101a5f:	83 ec 08             	sub    $0x8,%esp
80101a62:	50                   	push   %eax
80101a63:	ff 33                	pushl  (%ebx)
80101a65:	e8 66 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a6a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a6d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a72:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a75:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a77:	89 f0                	mov    %esi,%eax
80101a79:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a7e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a80:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a83:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a85:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101a89:	39 d9                	cmp    %ebx,%ecx
80101a8b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a8e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a8f:	01 df                	add    %ebx,%edi
80101a91:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a93:	50                   	push   %eax
80101a94:	ff 75 e0             	pushl  -0x20(%ebp)
80101a97:	e8 24 2d 00 00       	call   801047c0 <memmove>
    brelse(bp);
80101a9c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a9f:	89 14 24             	mov    %edx,(%esp)
80101aa2:	e8 49 e7 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101aa7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101aaa:	83 c4 10             	add    $0x10,%esp
80101aad:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101ab0:	77 9e                	ja     80101a50 <readi+0x60>
  }
  return n;
80101ab2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101ab5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ab8:	5b                   	pop    %ebx
80101ab9:	5e                   	pop    %esi
80101aba:	5f                   	pop    %edi
80101abb:	5d                   	pop    %ebp
80101abc:	c3                   	ret    
80101abd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ac0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ac4:	66 83 f8 09          	cmp    $0x9,%ax
80101ac8:	77 17                	ja     80101ae1 <readi+0xf1>
80101aca:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101ad1:	85 c0                	test   %eax,%eax
80101ad3:	74 0c                	je     80101ae1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101ad5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ad8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101adb:	5b                   	pop    %ebx
80101adc:	5e                   	pop    %esi
80101add:	5f                   	pop    %edi
80101ade:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101adf:	ff e0                	jmp    *%eax
      return -1;
80101ae1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ae6:	eb cd                	jmp    80101ab5 <readi+0xc5>
80101ae8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101aef:	90                   	nop

80101af0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101af0:	55                   	push   %ebp
80101af1:	89 e5                	mov    %esp,%ebp
80101af3:	57                   	push   %edi
80101af4:	56                   	push   %esi
80101af5:	53                   	push   %ebx
80101af6:	83 ec 1c             	sub    $0x1c,%esp
80101af9:	8b 45 08             	mov    0x8(%ebp),%eax
80101afc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101aff:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b02:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b07:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b0a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b0d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b10:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b13:	0f 84 b7 00 00 00    	je     80101bd0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b19:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b1c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b1f:	0f 82 e7 00 00 00    	jb     80101c0c <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b25:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b28:	89 f8                	mov    %edi,%eax
80101b2a:	01 f0                	add    %esi,%eax
80101b2c:	0f 82 da 00 00 00    	jb     80101c0c <writei+0x11c>
80101b32:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b37:	0f 87 cf 00 00 00    	ja     80101c0c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b3d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b44:	85 ff                	test   %edi,%edi
80101b46:	74 79                	je     80101bc1 <writei+0xd1>
80101b48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b4f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b50:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b53:	89 f2                	mov    %esi,%edx
80101b55:	c1 ea 09             	shr    $0x9,%edx
80101b58:	89 f8                	mov    %edi,%eax
80101b5a:	e8 21 f8 ff ff       	call   80101380 <bmap>
80101b5f:	83 ec 08             	sub    $0x8,%esp
80101b62:	50                   	push   %eax
80101b63:	ff 37                	pushl  (%edi)
80101b65:	e8 66 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b6a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b6f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b72:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b75:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b77:	89 f0                	mov    %esi,%eax
80101b79:	83 c4 0c             	add    $0xc,%esp
80101b7c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b81:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b83:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b87:	39 d9                	cmp    %ebx,%ecx
80101b89:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b8c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b8d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b8f:	ff 75 dc             	pushl  -0x24(%ebp)
80101b92:	50                   	push   %eax
80101b93:	e8 28 2c 00 00       	call   801047c0 <memmove>
    log_write(bp);
80101b98:	89 3c 24             	mov    %edi,(%esp)
80101b9b:	e8 00 15 00 00       	call   801030a0 <log_write>
    brelse(bp);
80101ba0:	89 3c 24             	mov    %edi,(%esp)
80101ba3:	e8 48 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ba8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101bab:	83 c4 10             	add    $0x10,%esp
80101bae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bb1:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101bb4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101bb7:	77 97                	ja     80101b50 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101bb9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bbc:	3b 70 58             	cmp    0x58(%eax),%esi
80101bbf:	77 37                	ja     80101bf8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101bc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101bc4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bc7:	5b                   	pop    %ebx
80101bc8:	5e                   	pop    %esi
80101bc9:	5f                   	pop    %edi
80101bca:	5d                   	pop    %ebp
80101bcb:	c3                   	ret    
80101bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101bd0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101bd4:	66 83 f8 09          	cmp    $0x9,%ax
80101bd8:	77 32                	ja     80101c0c <writei+0x11c>
80101bda:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101be1:	85 c0                	test   %eax,%eax
80101be3:	74 27                	je     80101c0c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101be5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101be8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101beb:	5b                   	pop    %ebx
80101bec:	5e                   	pop    %esi
80101bed:	5f                   	pop    %edi
80101bee:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101bef:	ff e0                	jmp    *%eax
80101bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101bf8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101bfb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101bfe:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c01:	50                   	push   %eax
80101c02:	e8 59 fa ff ff       	call   80101660 <iupdate>
80101c07:	83 c4 10             	add    $0x10,%esp
80101c0a:	eb b5                	jmp    80101bc1 <writei+0xd1>
      return -1;
80101c0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c11:	eb b1                	jmp    80101bc4 <writei+0xd4>
80101c13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c20 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c20:	55                   	push   %ebp
80101c21:	89 e5                	mov    %esp,%ebp
80101c23:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101c26:	6a 0e                	push   $0xe
80101c28:	ff 75 0c             	pushl  0xc(%ebp)
80101c2b:	ff 75 08             	pushl  0x8(%ebp)
80101c2e:	e8 fd 2b 00 00       	call   80104830 <strncmp>
}
80101c33:	c9                   	leave  
80101c34:	c3                   	ret    
80101c35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c40 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c40:	55                   	push   %ebp
80101c41:	89 e5                	mov    %esp,%ebp
80101c43:	57                   	push   %edi
80101c44:	56                   	push   %esi
80101c45:	53                   	push   %ebx
80101c46:	83 ec 1c             	sub    $0x1c,%esp
80101c49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c4c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c51:	0f 85 85 00 00 00    	jne    80101cdc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c57:	8b 53 58             	mov    0x58(%ebx),%edx
80101c5a:	31 ff                	xor    %edi,%edi
80101c5c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c5f:	85 d2                	test   %edx,%edx
80101c61:	74 3e                	je     80101ca1 <dirlookup+0x61>
80101c63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c67:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c68:	6a 10                	push   $0x10
80101c6a:	57                   	push   %edi
80101c6b:	56                   	push   %esi
80101c6c:	53                   	push   %ebx
80101c6d:	e8 7e fd ff ff       	call   801019f0 <readi>
80101c72:	83 c4 10             	add    $0x10,%esp
80101c75:	83 f8 10             	cmp    $0x10,%eax
80101c78:	75 55                	jne    80101ccf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101c7a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c7f:	74 18                	je     80101c99 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c81:	83 ec 04             	sub    $0x4,%esp
80101c84:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c87:	6a 0e                	push   $0xe
80101c89:	50                   	push   %eax
80101c8a:	ff 75 0c             	pushl  0xc(%ebp)
80101c8d:	e8 9e 2b 00 00       	call   80104830 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c92:	83 c4 10             	add    $0x10,%esp
80101c95:	85 c0                	test   %eax,%eax
80101c97:	74 17                	je     80101cb0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c99:	83 c7 10             	add    $0x10,%edi
80101c9c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c9f:	72 c7                	jb     80101c68 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101ca1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101ca4:	31 c0                	xor    %eax,%eax
}
80101ca6:	5b                   	pop    %ebx
80101ca7:	5e                   	pop    %esi
80101ca8:	5f                   	pop    %edi
80101ca9:	5d                   	pop    %ebp
80101caa:	c3                   	ret    
80101cab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101caf:	90                   	nop
      if(poff)
80101cb0:	8b 45 10             	mov    0x10(%ebp),%eax
80101cb3:	85 c0                	test   %eax,%eax
80101cb5:	74 05                	je     80101cbc <dirlookup+0x7c>
        *poff = off;
80101cb7:	8b 45 10             	mov    0x10(%ebp),%eax
80101cba:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101cbc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101cc0:	8b 03                	mov    (%ebx),%eax
80101cc2:	e8 c9 f5 ff ff       	call   80101290 <iget>
}
80101cc7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cca:	5b                   	pop    %ebx
80101ccb:	5e                   	pop    %esi
80101ccc:	5f                   	pop    %edi
80101ccd:	5d                   	pop    %ebp
80101cce:	c3                   	ret    
      panic("dirlookup read");
80101ccf:	83 ec 0c             	sub    $0xc,%esp
80101cd2:	68 39 72 10 80       	push   $0x80107239
80101cd7:	e8 a4 e6 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101cdc:	83 ec 0c             	sub    $0xc,%esp
80101cdf:	68 27 72 10 80       	push   $0x80107227
80101ce4:	e8 97 e6 ff ff       	call   80100380 <panic>
80101ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101cf0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	57                   	push   %edi
80101cf4:	56                   	push   %esi
80101cf5:	53                   	push   %ebx
80101cf6:	89 c3                	mov    %eax,%ebx
80101cf8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101cfb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101cfe:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101d01:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101d04:	0f 84 86 01 00 00    	je     80101e90 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d0a:	e8 a1 1d 00 00       	call   80103ab0 <myproc>
  acquire(&icache.lock);
80101d0f:	83 ec 0c             	sub    $0xc,%esp
80101d12:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80101d14:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d17:	68 e0 09 11 80       	push   $0x801109e0
80101d1c:	e8 8f 28 00 00       	call   801045b0 <acquire>
  ip->ref++;
80101d21:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d25:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101d2c:	e8 9f 29 00 00       	call   801046d0 <release>
80101d31:	83 c4 10             	add    $0x10,%esp
80101d34:	eb 0d                	jmp    80101d43 <namex+0x53>
80101d36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d3d:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80101d40:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101d43:	0f b6 07             	movzbl (%edi),%eax
80101d46:	3c 2f                	cmp    $0x2f,%al
80101d48:	74 f6                	je     80101d40 <namex+0x50>
  if(*path == 0)
80101d4a:	84 c0                	test   %al,%al
80101d4c:	0f 84 ee 00 00 00    	je     80101e40 <namex+0x150>
  while(*path != '/' && *path != 0)
80101d52:	0f b6 07             	movzbl (%edi),%eax
80101d55:	84 c0                	test   %al,%al
80101d57:	0f 84 fb 00 00 00    	je     80101e58 <namex+0x168>
80101d5d:	89 fb                	mov    %edi,%ebx
80101d5f:	3c 2f                	cmp    $0x2f,%al
80101d61:	0f 84 f1 00 00 00    	je     80101e58 <namex+0x168>
80101d67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d6e:	66 90                	xchg   %ax,%ax
80101d70:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    path++;
80101d74:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
80101d77:	3c 2f                	cmp    $0x2f,%al
80101d79:	74 04                	je     80101d7f <namex+0x8f>
80101d7b:	84 c0                	test   %al,%al
80101d7d:	75 f1                	jne    80101d70 <namex+0x80>
  len = path - s;
80101d7f:	89 d8                	mov    %ebx,%eax
80101d81:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
80101d83:	83 f8 0d             	cmp    $0xd,%eax
80101d86:	0f 8e 84 00 00 00    	jle    80101e10 <namex+0x120>
    memmove(name, s, DIRSIZ);
80101d8c:	83 ec 04             	sub    $0x4,%esp
80101d8f:	6a 0e                	push   $0xe
80101d91:	57                   	push   %edi
    path++;
80101d92:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80101d94:	ff 75 e4             	pushl  -0x1c(%ebp)
80101d97:	e8 24 2a 00 00       	call   801047c0 <memmove>
80101d9c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101d9f:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101da2:	75 0c                	jne    80101db0 <namex+0xc0>
80101da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101da8:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101dab:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101dae:	74 f8                	je     80101da8 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101db0:	83 ec 0c             	sub    $0xc,%esp
80101db3:	56                   	push   %esi
80101db4:	e8 57 f9 ff ff       	call   80101710 <ilock>
    if(ip->type != T_DIR){
80101db9:	83 c4 10             	add    $0x10,%esp
80101dbc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101dc1:	0f 85 a1 00 00 00    	jne    80101e68 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101dc7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101dca:	85 d2                	test   %edx,%edx
80101dcc:	74 09                	je     80101dd7 <namex+0xe7>
80101dce:	80 3f 00             	cmpb   $0x0,(%edi)
80101dd1:	0f 84 d9 00 00 00    	je     80101eb0 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101dd7:	83 ec 04             	sub    $0x4,%esp
80101dda:	6a 00                	push   $0x0
80101ddc:	ff 75 e4             	pushl  -0x1c(%ebp)
80101ddf:	56                   	push   %esi
80101de0:	e8 5b fe ff ff       	call   80101c40 <dirlookup>
80101de5:	83 c4 10             	add    $0x10,%esp
80101de8:	89 c3                	mov    %eax,%ebx
80101dea:	85 c0                	test   %eax,%eax
80101dec:	74 7a                	je     80101e68 <namex+0x178>
  iunlock(ip);
80101dee:	83 ec 0c             	sub    $0xc,%esp
80101df1:	56                   	push   %esi
80101df2:	e8 f9 f9 ff ff       	call   801017f0 <iunlock>
  iput(ip);
80101df7:	89 34 24             	mov    %esi,(%esp)
80101dfa:	89 de                	mov    %ebx,%esi
80101dfc:	e8 3f fa ff ff       	call   80101840 <iput>
80101e01:	83 c4 10             	add    $0x10,%esp
80101e04:	e9 3a ff ff ff       	jmp    80101d43 <namex+0x53>
80101e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e10:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101e13:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80101e16:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80101e19:	83 ec 04             	sub    $0x4,%esp
80101e1c:	50                   	push   %eax
80101e1d:	57                   	push   %edi
    name[len] = 0;
80101e1e:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80101e20:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e23:	e8 98 29 00 00       	call   801047c0 <memmove>
    name[len] = 0;
80101e28:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e2b:	83 c4 10             	add    $0x10,%esp
80101e2e:	c6 00 00             	movb   $0x0,(%eax)
80101e31:	e9 69 ff ff ff       	jmp    80101d9f <namex+0xaf>
80101e36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e3d:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e40:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e43:	85 c0                	test   %eax,%eax
80101e45:	0f 85 85 00 00 00    	jne    80101ed0 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e4e:	89 f0                	mov    %esi,%eax
80101e50:	5b                   	pop    %ebx
80101e51:	5e                   	pop    %esi
80101e52:	5f                   	pop    %edi
80101e53:	5d                   	pop    %ebp
80101e54:	c3                   	ret    
80101e55:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80101e58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e5b:	89 fb                	mov    %edi,%ebx
80101e5d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101e60:	31 c0                	xor    %eax,%eax
80101e62:	eb b5                	jmp    80101e19 <namex+0x129>
80101e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e68:	83 ec 0c             	sub    $0xc,%esp
80101e6b:	56                   	push   %esi
80101e6c:	e8 7f f9 ff ff       	call   801017f0 <iunlock>
  iput(ip);
80101e71:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e74:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e76:	e8 c5 f9 ff ff       	call   80101840 <iput>
      return 0;
80101e7b:	83 c4 10             	add    $0x10,%esp
}
80101e7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e81:	89 f0                	mov    %esi,%eax
80101e83:	5b                   	pop    %ebx
80101e84:	5e                   	pop    %esi
80101e85:	5f                   	pop    %edi
80101e86:	5d                   	pop    %ebp
80101e87:	c3                   	ret    
80101e88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e8f:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
80101e90:	ba 01 00 00 00       	mov    $0x1,%edx
80101e95:	b8 01 00 00 00       	mov    $0x1,%eax
80101e9a:	89 df                	mov    %ebx,%edi
80101e9c:	e8 ef f3 ff ff       	call   80101290 <iget>
80101ea1:	89 c6                	mov    %eax,%esi
80101ea3:	e9 9b fe ff ff       	jmp    80101d43 <namex+0x53>
80101ea8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eaf:	90                   	nop
      iunlock(ip);
80101eb0:	83 ec 0c             	sub    $0xc,%esp
80101eb3:	56                   	push   %esi
80101eb4:	e8 37 f9 ff ff       	call   801017f0 <iunlock>
      return ip;
80101eb9:	83 c4 10             	add    $0x10,%esp
}
80101ebc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ebf:	89 f0                	mov    %esi,%eax
80101ec1:	5b                   	pop    %ebx
80101ec2:	5e                   	pop    %esi
80101ec3:	5f                   	pop    %edi
80101ec4:	5d                   	pop    %ebp
80101ec5:	c3                   	ret    
80101ec6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ecd:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
80101ed0:	83 ec 0c             	sub    $0xc,%esp
80101ed3:	56                   	push   %esi
    return 0;
80101ed4:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ed6:	e8 65 f9 ff ff       	call   80101840 <iput>
    return 0;
80101edb:	83 c4 10             	add    $0x10,%esp
80101ede:	e9 68 ff ff ff       	jmp    80101e4b <namex+0x15b>
80101ee3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101ef0 <dirlink>:
{
80101ef0:	55                   	push   %ebp
80101ef1:	89 e5                	mov    %esp,%ebp
80101ef3:	57                   	push   %edi
80101ef4:	56                   	push   %esi
80101ef5:	53                   	push   %ebx
80101ef6:	83 ec 20             	sub    $0x20,%esp
80101ef9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101efc:	6a 00                	push   $0x0
80101efe:	ff 75 0c             	pushl  0xc(%ebp)
80101f01:	53                   	push   %ebx
80101f02:	e8 39 fd ff ff       	call   80101c40 <dirlookup>
80101f07:	83 c4 10             	add    $0x10,%esp
80101f0a:	85 c0                	test   %eax,%eax
80101f0c:	75 67                	jne    80101f75 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f0e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101f11:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f14:	85 ff                	test   %edi,%edi
80101f16:	74 29                	je     80101f41 <dirlink+0x51>
80101f18:	31 ff                	xor    %edi,%edi
80101f1a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f1d:	eb 09                	jmp    80101f28 <dirlink+0x38>
80101f1f:	90                   	nop
80101f20:	83 c7 10             	add    $0x10,%edi
80101f23:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f26:	73 19                	jae    80101f41 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f28:	6a 10                	push   $0x10
80101f2a:	57                   	push   %edi
80101f2b:	56                   	push   %esi
80101f2c:	53                   	push   %ebx
80101f2d:	e8 be fa ff ff       	call   801019f0 <readi>
80101f32:	83 c4 10             	add    $0x10,%esp
80101f35:	83 f8 10             	cmp    $0x10,%eax
80101f38:	75 4e                	jne    80101f88 <dirlink+0x98>
    if(de.inum == 0)
80101f3a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f3f:	75 df                	jne    80101f20 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101f41:	83 ec 04             	sub    $0x4,%esp
80101f44:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f47:	6a 0e                	push   $0xe
80101f49:	ff 75 0c             	pushl  0xc(%ebp)
80101f4c:	50                   	push   %eax
80101f4d:	e8 2e 29 00 00       	call   80104880 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f52:	6a 10                	push   $0x10
  de.inum = inum;
80101f54:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f57:	57                   	push   %edi
80101f58:	56                   	push   %esi
80101f59:	53                   	push   %ebx
  de.inum = inum;
80101f5a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f5e:	e8 8d fb ff ff       	call   80101af0 <writei>
80101f63:	83 c4 20             	add    $0x20,%esp
80101f66:	83 f8 10             	cmp    $0x10,%eax
80101f69:	75 2a                	jne    80101f95 <dirlink+0xa5>
  return 0;
80101f6b:	31 c0                	xor    %eax,%eax
}
80101f6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f70:	5b                   	pop    %ebx
80101f71:	5e                   	pop    %esi
80101f72:	5f                   	pop    %edi
80101f73:	5d                   	pop    %ebp
80101f74:	c3                   	ret    
    iput(ip);
80101f75:	83 ec 0c             	sub    $0xc,%esp
80101f78:	50                   	push   %eax
80101f79:	e8 c2 f8 ff ff       	call   80101840 <iput>
    return -1;
80101f7e:	83 c4 10             	add    $0x10,%esp
80101f81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f86:	eb e5                	jmp    80101f6d <dirlink+0x7d>
      panic("dirlink read");
80101f88:	83 ec 0c             	sub    $0xc,%esp
80101f8b:	68 48 72 10 80       	push   $0x80107248
80101f90:	e8 eb e3 ff ff       	call   80100380 <panic>
    panic("dirlink");
80101f95:	83 ec 0c             	sub    $0xc,%esp
80101f98:	68 22 79 10 80       	push   $0x80107922
80101f9d:	e8 de e3 ff ff       	call   80100380 <panic>
80101fa2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fb0 <namei>:

struct inode*
namei(char *path)
{
80101fb0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fb1:	31 d2                	xor    %edx,%edx
{
80101fb3:	89 e5                	mov    %esp,%ebp
80101fb5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101fb8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fbb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fbe:	e8 2d fd ff ff       	call   80101cf0 <namex>
}
80101fc3:	c9                   	leave  
80101fc4:	c3                   	ret    
80101fc5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101fd0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101fd0:	55                   	push   %ebp
  return namex(path, 1, name);
80101fd1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101fd6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101fd8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101fdb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101fde:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101fdf:	e9 0c fd ff ff       	jmp    80101cf0 <namex>
80101fe4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101feb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fef:	90                   	nop

80101ff0 <pfs>:

int
pfs()
{/*
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
80101ff4:	56                   	push   %esi
80101ff5:	53                   	push   %ebx
80101ff6:	83 ec 28             	sub    $0x28,%esp
  */
  int b, bi, m;
  struct buf *bp;
  int countt = 0, countf = 0, counta = 0, bn = 0, nb=0;;
  bp = 0;
  cprintf("\nFree blocks:\n");
80101ff9:	68 55 72 10 80       	push   $0x80107255
80101ffe:	e8 9d e6 ff ff       	call   801006a0 <cprintf>
  for(b = 0; b < sb.size; b += BPB){
80102003:	8b 1d c0 09 11 80    	mov    0x801109c0,%ebx
80102009:	83 c4 10             	add    $0x10,%esp
  int countt = 0, countf = 0, counta = 0, bn = 0, nb=0;;
8010200c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80102013:	85 db                	test   %ebx,%ebx
80102015:	0f 84 c9 00 00 00    	je     801020e4 <pfs+0xf4>
8010201b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  int countt = 0, countf = 0, counta = 0, bn = 0, nb=0;;
80102022:	31 f6                	xor    %esi,%esi
80102024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nb++;
    bp = bread(1, BBLOCK(b, sb));
80102028:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010202b:	83 ec 08             	sub    $0x8,%esp
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010202e:	31 db                	xor    %ebx,%ebx
    bp = bread(1, BBLOCK(b, sb));
80102030:	c1 f8 0c             	sar    $0xc,%eax
80102033:	03 05 d8 09 11 80    	add    0x801109d8,%eax
80102039:	50                   	push   %eax
8010203a:	6a 01                	push   $0x1
8010203c:	e8 8f e0 ff ff       	call   801000d0 <bread>
80102041:	83 c4 10             	add    $0x10,%esp
80102044:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80102047:	eb 29                	jmp    80102072 <pfs+0x82>
80102049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      m = 1 << (bi % 8);
      ++countt;
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        if ( (countf % 16) == 0 ) cprintf("\n");
        cprintf("%d  ", bn );
80102050:	83 ec 08             	sub    $0x8,%esp
80102053:	56                   	push   %esi
80102054:	68 64 72 10 80       	push   $0x80107264
80102059:	e8 42 e6 ff ff       	call   801006a0 <cprintf>
        ++countf;
8010205e:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
80102062:	83 c4 10             	add    $0x10,%esp
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80102065:	83 c3 01             	add    $0x1,%ebx
      ++countt;
80102068:	89 fe                	mov    %edi,%esi
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010206a:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
80102070:	74 4e                	je     801020c0 <pfs+0xd0>
80102072:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102075:	01 d8                	add    %ebx,%eax
80102077:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010207d:	76 41                	jbe    801020c0 <pfs+0xd0>
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010207f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102082:	89 d8                	mov    %ebx,%eax
      m = 1 << (bi % 8);
80102084:	89 d9                	mov    %ebx,%ecx
      ++countt;
80102086:	8d 7e 01             	lea    0x1(%esi),%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80102089:	c1 f8 03             	sar    $0x3,%eax
      m = 1 << (bi % 8);
8010208c:	83 e1 07             	and    $0x7,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010208f:	0f b6 44 02 5c       	movzbl 0x5c(%edx,%eax,1),%eax
      m = 1 << (bi % 8);
80102094:	ba 01 00 00 00       	mov    $0x1,%edx
80102099:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010209b:	85 d0                	test   %edx,%eax
8010209d:	75 c6                	jne    80102065 <pfs+0x75>
        if ( (countf % 16) == 0 ) cprintf("\n");
8010209f:	f6 45 dc 0f          	testb  $0xf,-0x24(%ebp)
801020a3:	75 ab                	jne    80102050 <pfs+0x60>
801020a5:	83 ec 0c             	sub    $0xc,%esp
801020a8:	68 3b 7b 10 80       	push   $0x80107b3b
801020ad:	e8 ee e5 ff ff       	call   801006a0 <cprintf>
801020b2:	83 c4 10             	add    $0x10,%esp
801020b5:	eb 99                	jmp    80102050 <pfs+0x60>
801020b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020be:	66 90                	xchg   %ax,%ax
      }
      bn++;
    }
    brelse(bp);
801020c0:	83 ec 0c             	sub    $0xc,%esp
801020c3:	ff 75 e0             	pushl  -0x20(%ebp)
801020c6:	e8 25 e1 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801020cb:	81 45 e4 00 10 00 00 	addl   $0x1000,-0x1c(%ebp)
801020d2:	83 c4 10             	add    $0x10,%esp
801020d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801020d8:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
801020de:	0f 87 44 ff ff ff    	ja     80102028 <pfs+0x38>
  }
  cprintf("\nTotal free blocks = %d", countf );
801020e4:	83 ec 08             	sub    $0x8,%esp
801020e7:	ff 75 dc             	pushl  -0x24(%ebp)
801020ea:	68 69 72 10 80       	push   $0x80107269
801020ef:	e8 ac e5 ff ff       	call   801006a0 <cprintf>

  cprintf("\nAlocated blocks:\n");
801020f4:	c7 04 24 81 72 10 80 	movl   $0x80107281,(%esp)
801020fb:	e8 a0 e5 ff ff       	call   801006a0 <cprintf>
  bn = 0;

  for(b = 0; b < sb.size; b += BPB){
80102100:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
80102106:	83 c4 10             	add    $0x10,%esp
80102109:	85 c9                	test   %ecx,%ecx
8010210b:	0f 84 1a 01 00 00    	je     8010222b <pfs+0x23b>
  int countt = 0, countf = 0, counta = 0, bn = 0, nb=0;;
80102111:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  bn = 0;
80102118:	31 ff                	xor    %edi,%edi
  for(b = 0; b < sb.size; b += BPB){
8010211a:	31 f6                	xor    %esi,%esi
8010211c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nb++;
    bp = bread(1, BBLOCK(b, sb));
80102120:	89 f8                	mov    %edi,%eax
80102122:	83 ec 08             	sub    $0x8,%esp
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80102125:	31 db                	xor    %ebx,%ebx
    bp = bread(1, BBLOCK(b, sb));
80102127:	c1 f8 0c             	sar    $0xc,%eax
8010212a:	03 05 d8 09 11 80    	add    0x801109d8,%eax
80102130:	50                   	push   %eax
80102131:	6a 01                	push   $0x1
80102133:	e8 98 df ff ff       	call   801000d0 <bread>
80102138:	83 c4 10             	add    $0x10,%esp
8010213b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010213e:	eb 23                	jmp    80102163 <pfs+0x173>
      m = 1 << (bi % 8);
      ++countt;
      if((bp->data[bi/8] & m) != 0){ // Is block allocated?
        if ( (counta % 16) == 0 ) cprintf("\n");
        cprintf("%d ", bn );
80102140:	83 ec 08             	sub    $0x8,%esp
80102143:	56                   	push   %esi
80102144:	68 94 72 10 80       	push   $0x80107294
80102149:	e8 52 e5 ff ff       	call   801006a0 <cprintf>
        ++counta;
8010214e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
80102152:	83 c4 10             	add    $0x10,%esp
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80102155:	83 c3 01             	add    $0x1,%ebx
      }
      bn++;
80102158:	83 c6 01             	add    $0x1,%esi
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010215b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
80102161:	74 45                	je     801021a8 <pfs+0x1b8>
80102163:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
80102166:	39 15 c0 09 11 80    	cmp    %edx,0x801109c0
8010216c:	76 3a                	jbe    801021a8 <pfs+0x1b8>
      if((bp->data[bi/8] & m) != 0){ // Is block allocated?
8010216e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102171:	89 da                	mov    %ebx,%edx
      m = 1 << (bi % 8);
80102173:	89 d9                	mov    %ebx,%ecx
      if((bp->data[bi/8] & m) != 0){ // Is block allocated?
80102175:	c1 fa 03             	sar    $0x3,%edx
      m = 1 << (bi % 8);
80102178:	83 e1 07             	and    $0x7,%ecx
      if((bp->data[bi/8] & m) != 0){ // Is block allocated?
8010217b:	0f b6 54 10 5c       	movzbl 0x5c(%eax,%edx,1),%edx
      m = 1 << (bi % 8);
80102180:	b8 01 00 00 00       	mov    $0x1,%eax
80102185:	d3 e0                	shl    %cl,%eax
      if((bp->data[bi/8] & m) != 0){ // Is block allocated?
80102187:	85 c2                	test   %eax,%edx
80102189:	74 ca                	je     80102155 <pfs+0x165>
        if ( (counta % 16) == 0 ) cprintf("\n");
8010218b:	f6 45 e0 0f          	testb  $0xf,-0x20(%ebp)
8010218f:	75 af                	jne    80102140 <pfs+0x150>
80102191:	83 ec 0c             	sub    $0xc,%esp
80102194:	68 3b 7b 10 80       	push   $0x80107b3b
80102199:	e8 02 e5 ff ff       	call   801006a0 <cprintf>
8010219e:	83 c4 10             	add    $0x10,%esp
801021a1:	eb 9d                	jmp    80102140 <pfs+0x150>
801021a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021a7:	90                   	nop
    }
    brelse(bp);
801021a8:	83 ec 0c             	sub    $0xc,%esp
801021ab:	ff 75 e4             	pushl  -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801021ae:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
801021b4:	e8 37 e0 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801021b9:	83 c4 10             	add    $0x10,%esp
801021bc:	39 3d c0 09 11 80    	cmp    %edi,0x801109c0
801021c2:	0f 87 58 ff ff ff    	ja     80102120 <pfs+0x130>
  }
  cprintf("\nTotal allocated blocks = %d\n", counta );
801021c8:	83 ec 08             	sub    $0x8,%esp
801021cb:	ff 75 e0             	pushl  -0x20(%ebp)
801021ce:	68 98 72 10 80       	push   $0x80107298
801021d3:	e8 c8 e4 ff ff       	call   801006a0 <cprintf>

  cprintf("sb: size nblocks ninodes nlog logstart inodestart bmap-start Inodes-per-block Bitmap-bits-per-block\n");
801021d8:	c7 04 24 0c 73 10 80 	movl   $0x8010730c,(%esp)
801021df:	e8 bc e4 ff ff       	call   801006a0 <cprintf>
  cprintf(" %d\t %d\t %d %d %d \t %d \t %d \t %d \t\t %d\n",
801021e4:	58                   	pop    %eax
801021e5:	5a                   	pop    %edx
801021e6:	68 00 10 00 00       	push   $0x1000
801021eb:	6a 08                	push   $0x8
801021ed:	ff 35 d8 09 11 80    	pushl  0x801109d8
801021f3:	ff 35 d4 09 11 80    	pushl  0x801109d4
801021f9:	ff 35 d0 09 11 80    	pushl  0x801109d0
801021ff:	ff 35 cc 09 11 80    	pushl  0x801109cc
80102205:	ff 35 c8 09 11 80    	pushl  0x801109c8
8010220b:	ff 35 c4 09 11 80    	pushl  0x801109c4
80102211:	ff 35 c0 09 11 80    	pushl  0x801109c0
80102217:	68 74 73 10 80       	push   $0x80107374
8010221c:	e8 7f e4 ff ff       	call   801006a0 <cprintf>
     sb.size, sb.nblocks, sb.ninodes, sb.nlog, sb.logstart, sb.inodestart, sb.bmapstart, IPB, BPB);
  return 0;


}
80102221:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102224:	31 c0                	xor    %eax,%eax
80102226:	5b                   	pop    %ebx
80102227:	5e                   	pop    %esi
80102228:	5f                   	pop    %edi
80102229:	5d                   	pop    %ebp
8010222a:	c3                   	ret    
  int countt = 0, countf = 0, counta = 0, bn = 0, nb=0;;
8010222b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80102232:	eb 94                	jmp    801021c8 <pfs+0x1d8>
80102234:	66 90                	xchg   %ax,%ax
80102236:	66 90                	xchg   %ax,%ax
80102238:	66 90                	xchg   %ax,%ax
8010223a:	66 90                	xchg   %ax,%ax
8010223c:	66 90                	xchg   %ax,%ax
8010223e:	66 90                	xchg   %ax,%ax

80102240 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	57                   	push   %edi
80102244:	56                   	push   %esi
80102245:	53                   	push   %ebx
80102246:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102249:	85 c0                	test   %eax,%eax
8010224b:	0f 84 b4 00 00 00    	je     80102305 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102251:	8b 70 08             	mov    0x8(%eax),%esi
80102254:	89 c3                	mov    %eax,%ebx
80102256:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010225c:	0f 87 96 00 00 00    	ja     801022f8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102262:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010226e:	66 90                	xchg   %ax,%ax
80102270:	89 ca                	mov    %ecx,%edx
80102272:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102273:	83 e0 c0             	and    $0xffffffc0,%eax
80102276:	3c 40                	cmp    $0x40,%al
80102278:	75 f6                	jne    80102270 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010227a:	31 ff                	xor    %edi,%edi
8010227c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102281:	89 f8                	mov    %edi,%eax
80102283:	ee                   	out    %al,(%dx)
80102284:	b8 01 00 00 00       	mov    $0x1,%eax
80102289:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010228e:	ee                   	out    %al,(%dx)
8010228f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102294:	89 f0                	mov    %esi,%eax
80102296:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102297:	89 f0                	mov    %esi,%eax
80102299:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010229e:	c1 f8 08             	sar    $0x8,%eax
801022a1:	ee                   	out    %al,(%dx)
801022a2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801022a7:	89 f8                	mov    %edi,%eax
801022a9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801022aa:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801022ae:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022b3:	c1 e0 04             	shl    $0x4,%eax
801022b6:	83 e0 10             	and    $0x10,%eax
801022b9:	83 c8 e0             	or     $0xffffffe0,%eax
801022bc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801022bd:	f6 03 04             	testb  $0x4,(%ebx)
801022c0:	75 16                	jne    801022d8 <idestart+0x98>
801022c2:	b8 20 00 00 00       	mov    $0x20,%eax
801022c7:	89 ca                	mov    %ecx,%edx
801022c9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801022ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022cd:	5b                   	pop    %ebx
801022ce:	5e                   	pop    %esi
801022cf:	5f                   	pop    %edi
801022d0:	5d                   	pop    %ebp
801022d1:	c3                   	ret    
801022d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801022d8:	b8 30 00 00 00       	mov    $0x30,%eax
801022dd:	89 ca                	mov    %ecx,%edx
801022df:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801022e0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801022e5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801022e8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801022ed:	fc                   	cld    
801022ee:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801022f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022f3:	5b                   	pop    %ebx
801022f4:	5e                   	pop    %esi
801022f5:	5f                   	pop    %edi
801022f6:	5d                   	pop    %ebp
801022f7:	c3                   	ret    
    panic("incorrect blockno");
801022f8:	83 ec 0c             	sub    $0xc,%esp
801022fb:	68 a5 73 10 80       	push   $0x801073a5
80102300:	e8 7b e0 ff ff       	call   80100380 <panic>
    panic("idestart");
80102305:	83 ec 0c             	sub    $0xc,%esp
80102308:	68 9c 73 10 80       	push   $0x8010739c
8010230d:	e8 6e e0 ff ff       	call   80100380 <panic>
80102312:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102320 <ideinit>:
{
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102326:	68 b7 73 10 80       	push   $0x801073b7
8010232b:	68 80 a5 10 80       	push   $0x8010a580
80102330:	e8 7b 21 00 00       	call   801044b0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102335:	58                   	pop    %eax
80102336:	a1 00 2d 11 80       	mov    0x80112d00,%eax
8010233b:	5a                   	pop    %edx
8010233c:	83 e8 01             	sub    $0x1,%eax
8010233f:	50                   	push   %eax
80102340:	6a 0e                	push   $0xe
80102342:	e8 99 02 00 00       	call   801025e0 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102347:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010234a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010234f:	90                   	nop
80102350:	ec                   	in     (%dx),%al
80102351:	83 e0 c0             	and    $0xffffffc0,%eax
80102354:	3c 40                	cmp    $0x40,%al
80102356:	75 f8                	jne    80102350 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102358:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010235d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102362:	ee                   	out    %al,(%dx)
80102363:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102368:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010236d:	eb 06                	jmp    80102375 <ideinit+0x55>
8010236f:	90                   	nop
  for(i=0; i<1000; i++){
80102370:	83 e9 01             	sub    $0x1,%ecx
80102373:	74 0f                	je     80102384 <ideinit+0x64>
80102375:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102376:	84 c0                	test   %al,%al
80102378:	74 f6                	je     80102370 <ideinit+0x50>
      havedisk1 = 1;
8010237a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102381:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102384:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102389:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010238e:	ee                   	out    %al,(%dx)
}
8010238f:	c9                   	leave  
80102390:	c3                   	ret    
80102391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102398:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010239f:	90                   	nop

801023a0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801023a0:	55                   	push   %ebp
801023a1:	89 e5                	mov    %esp,%ebp
801023a3:	57                   	push   %edi
801023a4:	56                   	push   %esi
801023a5:	53                   	push   %ebx
801023a6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801023a9:	68 80 a5 10 80       	push   $0x8010a580
801023ae:	e8 fd 21 00 00       	call   801045b0 <acquire>

  if((b = idequeue) == 0){
801023b3:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
801023b9:	83 c4 10             	add    $0x10,%esp
801023bc:	85 db                	test   %ebx,%ebx
801023be:	74 63                	je     80102423 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801023c0:	8b 43 58             	mov    0x58(%ebx),%eax
801023c3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801023c8:	8b 33                	mov    (%ebx),%esi
801023ca:	f7 c6 04 00 00 00    	test   $0x4,%esi
801023d0:	75 2f                	jne    80102401 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023d2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023de:	66 90                	xchg   %ax,%ax
801023e0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801023e1:	89 c1                	mov    %eax,%ecx
801023e3:	83 e1 c0             	and    $0xffffffc0,%ecx
801023e6:	80 f9 40             	cmp    $0x40,%cl
801023e9:	75 f5                	jne    801023e0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801023eb:	a8 21                	test   $0x21,%al
801023ed:	75 12                	jne    80102401 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
801023ef:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801023f2:	b9 80 00 00 00       	mov    $0x80,%ecx
801023f7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801023fc:	fc                   	cld    
801023fd:	f3 6d                	rep insl (%dx),%es:(%edi)
801023ff:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102401:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102404:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102407:	83 ce 02             	or     $0x2,%esi
8010240a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010240c:	53                   	push   %ebx
8010240d:	e8 ee 1d 00 00       	call   80104200 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102412:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102417:	83 c4 10             	add    $0x10,%esp
8010241a:	85 c0                	test   %eax,%eax
8010241c:	74 05                	je     80102423 <ideintr+0x83>
    idestart(idequeue);
8010241e:	e8 1d fe ff ff       	call   80102240 <idestart>
    release(&idelock);
80102423:	83 ec 0c             	sub    $0xc,%esp
80102426:	68 80 a5 10 80       	push   $0x8010a580
8010242b:	e8 a0 22 00 00       	call   801046d0 <release>

  release(&idelock);
}
80102430:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102433:	5b                   	pop    %ebx
80102434:	5e                   	pop    %esi
80102435:	5f                   	pop    %edi
80102436:	5d                   	pop    %ebp
80102437:	c3                   	ret    
80102438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010243f:	90                   	nop

80102440 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102440:	55                   	push   %ebp
80102441:	89 e5                	mov    %esp,%ebp
80102443:	53                   	push   %ebx
80102444:	83 ec 10             	sub    $0x10,%esp
80102447:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010244a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010244d:	50                   	push   %eax
8010244e:	e8 2d 20 00 00       	call   80104480 <holdingsleep>
80102453:	83 c4 10             	add    $0x10,%esp
80102456:	85 c0                	test   %eax,%eax
80102458:	0f 84 c3 00 00 00    	je     80102521 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010245e:	8b 03                	mov    (%ebx),%eax
80102460:	83 e0 06             	and    $0x6,%eax
80102463:	83 f8 02             	cmp    $0x2,%eax
80102466:	0f 84 a8 00 00 00    	je     80102514 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010246c:	8b 53 04             	mov    0x4(%ebx),%edx
8010246f:	85 d2                	test   %edx,%edx
80102471:	74 0d                	je     80102480 <iderw+0x40>
80102473:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102478:	85 c0                	test   %eax,%eax
8010247a:	0f 84 87 00 00 00    	je     80102507 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102480:	83 ec 0c             	sub    $0xc,%esp
80102483:	68 80 a5 10 80       	push   $0x8010a580
80102488:	e8 23 21 00 00       	call   801045b0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010248d:	a1 64 a5 10 80       	mov    0x8010a564,%eax
  b->qnext = 0;
80102492:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102499:	83 c4 10             	add    $0x10,%esp
8010249c:	85 c0                	test   %eax,%eax
8010249e:	74 60                	je     80102500 <iderw+0xc0>
801024a0:	89 c2                	mov    %eax,%edx
801024a2:	8b 40 58             	mov    0x58(%eax),%eax
801024a5:	85 c0                	test   %eax,%eax
801024a7:	75 f7                	jne    801024a0 <iderw+0x60>
801024a9:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801024ac:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801024ae:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
801024b4:	74 3a                	je     801024f0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801024b6:	8b 03                	mov    (%ebx),%eax
801024b8:	83 e0 06             	and    $0x6,%eax
801024bb:	83 f8 02             	cmp    $0x2,%eax
801024be:	74 1b                	je     801024db <iderw+0x9b>
    sleep(b, &idelock);
801024c0:	83 ec 08             	sub    $0x8,%esp
801024c3:	68 80 a5 10 80       	push   $0x8010a580
801024c8:	53                   	push   %ebx
801024c9:	e8 82 1b 00 00       	call   80104050 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801024ce:	8b 03                	mov    (%ebx),%eax
801024d0:	83 c4 10             	add    $0x10,%esp
801024d3:	83 e0 06             	and    $0x6,%eax
801024d6:	83 f8 02             	cmp    $0x2,%eax
801024d9:	75 e5                	jne    801024c0 <iderw+0x80>
  }


  release(&idelock);
801024db:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801024e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024e5:	c9                   	leave  
  release(&idelock);
801024e6:	e9 e5 21 00 00       	jmp    801046d0 <release>
801024eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024ef:	90                   	nop
    idestart(b);
801024f0:	89 d8                	mov    %ebx,%eax
801024f2:	e8 49 fd ff ff       	call   80102240 <idestart>
801024f7:	eb bd                	jmp    801024b6 <iderw+0x76>
801024f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102500:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102505:	eb a5                	jmp    801024ac <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102507:	83 ec 0c             	sub    $0xc,%esp
8010250a:	68 e6 73 10 80       	push   $0x801073e6
8010250f:	e8 6c de ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102514:	83 ec 0c             	sub    $0xc,%esp
80102517:	68 d1 73 10 80       	push   $0x801073d1
8010251c:	e8 5f de ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102521:	83 ec 0c             	sub    $0xc,%esp
80102524:	68 bb 73 10 80       	push   $0x801073bb
80102529:	e8 52 de ff ff       	call   80100380 <panic>
8010252e:	66 90                	xchg   %ax,%ax

80102530 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102530:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102531:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
80102538:	00 c0 fe 
{
8010253b:	89 e5                	mov    %esp,%ebp
8010253d:	56                   	push   %esi
8010253e:	53                   	push   %ebx
  ioapic->reg = reg;
8010253f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102546:	00 00 00 
  return ioapic->data;
80102549:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010254f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102552:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102558:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010255e:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102565:	c1 ee 10             	shr    $0x10,%esi
80102568:	89 f0                	mov    %esi,%eax
8010256a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010256d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102570:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102573:	39 c2                	cmp    %eax,%edx
80102575:	74 16                	je     8010258d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102577:	83 ec 0c             	sub    $0xc,%esp
8010257a:	68 04 74 10 80       	push   $0x80107404
8010257f:	e8 1c e1 ff ff       	call   801006a0 <cprintf>
80102584:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010258a:	83 c4 10             	add    $0x10,%esp
8010258d:	83 c6 21             	add    $0x21,%esi
{
80102590:	ba 10 00 00 00       	mov    $0x10,%edx
80102595:	b8 20 00 00 00       	mov    $0x20,%eax
8010259a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
801025a0:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801025a2:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
801025a4:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801025aa:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801025ad:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
801025b3:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
801025b6:	8d 5a 01             	lea    0x1(%edx),%ebx
801025b9:	83 c2 02             	add    $0x2,%edx
801025bc:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801025be:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801025c4:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801025cb:	39 f0                	cmp    %esi,%eax
801025cd:	75 d1                	jne    801025a0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801025cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025d2:	5b                   	pop    %ebx
801025d3:	5e                   	pop    %esi
801025d4:	5d                   	pop    %ebp
801025d5:	c3                   	ret    
801025d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025dd:	8d 76 00             	lea    0x0(%esi),%esi

801025e0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801025e0:	55                   	push   %ebp
  ioapic->reg = reg;
801025e1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
801025e7:	89 e5                	mov    %esp,%ebp
801025e9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801025ec:	8d 50 20             	lea    0x20(%eax),%edx
801025ef:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801025f3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801025f5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025fb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801025fe:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102601:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102604:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102606:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010260b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010260e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102611:	5d                   	pop    %ebp
80102612:	c3                   	ret    
80102613:	66 90                	xchg   %ax,%ax
80102615:	66 90                	xchg   %ax,%ax
80102617:	66 90                	xchg   %ax,%ax
80102619:	66 90                	xchg   %ax,%ax
8010261b:	66 90                	xchg   %ax,%ax
8010261d:	66 90                	xchg   %ax,%ax
8010261f:	90                   	nop

80102620 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	53                   	push   %ebx
80102624:	83 ec 04             	sub    $0x4,%esp
80102627:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010262a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102630:	75 76                	jne    801026a8 <kfree+0x88>
80102632:	81 fb a8 54 11 80    	cmp    $0x801154a8,%ebx
80102638:	72 6e                	jb     801026a8 <kfree+0x88>
8010263a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102640:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102645:	77 61                	ja     801026a8 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102647:	83 ec 04             	sub    $0x4,%esp
8010264a:	68 00 10 00 00       	push   $0x1000
8010264f:	6a 01                	push   $0x1
80102651:	53                   	push   %ebx
80102652:	e8 c9 20 00 00       	call   80104720 <memset>

  if(kmem.use_lock)
80102657:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010265d:	83 c4 10             	add    $0x10,%esp
80102660:	85 d2                	test   %edx,%edx
80102662:	75 1c                	jne    80102680 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102664:	a1 78 26 11 80       	mov    0x80112678,%eax
80102669:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010266b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102670:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102676:	85 c0                	test   %eax,%eax
80102678:	75 1e                	jne    80102698 <kfree+0x78>
    release(&kmem.lock);
}
8010267a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010267d:	c9                   	leave  
8010267e:	c3                   	ret    
8010267f:	90                   	nop
    acquire(&kmem.lock);
80102680:	83 ec 0c             	sub    $0xc,%esp
80102683:	68 40 26 11 80       	push   $0x80112640
80102688:	e8 23 1f 00 00       	call   801045b0 <acquire>
8010268d:	83 c4 10             	add    $0x10,%esp
80102690:	eb d2                	jmp    80102664 <kfree+0x44>
80102692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102698:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010269f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026a2:	c9                   	leave  
    release(&kmem.lock);
801026a3:	e9 28 20 00 00       	jmp    801046d0 <release>
    panic("kfree");
801026a8:	83 ec 0c             	sub    $0xc,%esp
801026ab:	68 36 74 10 80       	push   $0x80107436
801026b0:	e8 cb dc ff ff       	call   80100380 <panic>
801026b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801026c0 <freerange>:
{
801026c0:	55                   	push   %ebp
801026c1:	89 e5                	mov    %esp,%ebp
801026c3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801026c4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801026c7:	8b 75 0c             	mov    0xc(%ebp),%esi
801026ca:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801026cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026dd:	39 de                	cmp    %ebx,%esi
801026df:	72 23                	jb     80102704 <freerange+0x44>
801026e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801026e8:	83 ec 0c             	sub    $0xc,%esp
801026eb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026f7:	50                   	push   %eax
801026f8:	e8 23 ff ff ff       	call   80102620 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026fd:	83 c4 10             	add    $0x10,%esp
80102700:	39 f3                	cmp    %esi,%ebx
80102702:	76 e4                	jbe    801026e8 <freerange+0x28>
}
80102704:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102707:	5b                   	pop    %ebx
80102708:	5e                   	pop    %esi
80102709:	5d                   	pop    %ebp
8010270a:	c3                   	ret    
8010270b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010270f:	90                   	nop

80102710 <kinit1>:
{
80102710:	55                   	push   %ebp
80102711:	89 e5                	mov    %esp,%ebp
80102713:	56                   	push   %esi
80102714:	53                   	push   %ebx
80102715:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102718:	83 ec 08             	sub    $0x8,%esp
8010271b:	68 3c 74 10 80       	push   $0x8010743c
80102720:	68 40 26 11 80       	push   $0x80112640
80102725:	e8 86 1d 00 00       	call   801044b0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010272a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010272d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102730:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102737:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010273a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102740:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102746:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010274c:	39 de                	cmp    %ebx,%esi
8010274e:	72 1c                	jb     8010276c <kinit1+0x5c>
    kfree(p);
80102750:	83 ec 0c             	sub    $0xc,%esp
80102753:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102759:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010275f:	50                   	push   %eax
80102760:	e8 bb fe ff ff       	call   80102620 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102765:	83 c4 10             	add    $0x10,%esp
80102768:	39 de                	cmp    %ebx,%esi
8010276a:	73 e4                	jae    80102750 <kinit1+0x40>
}
8010276c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010276f:	5b                   	pop    %ebx
80102770:	5e                   	pop    %esi
80102771:	5d                   	pop    %ebp
80102772:	c3                   	ret    
80102773:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010277a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102780 <kinit2>:
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
80102783:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102784:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102787:	8b 75 0c             	mov    0xc(%ebp),%esi
8010278a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010278b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102791:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102797:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010279d:	39 de                	cmp    %ebx,%esi
8010279f:	72 23                	jb     801027c4 <kinit2+0x44>
801027a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801027a8:	83 ec 0c             	sub    $0xc,%esp
801027ab:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027b7:	50                   	push   %eax
801027b8:	e8 63 fe ff ff       	call   80102620 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027bd:	83 c4 10             	add    $0x10,%esp
801027c0:	39 de                	cmp    %ebx,%esi
801027c2:	73 e4                	jae    801027a8 <kinit2+0x28>
  kmem.use_lock = 1;
801027c4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801027cb:	00 00 00 
}
801027ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027d1:	5b                   	pop    %ebx
801027d2:	5e                   	pop    %esi
801027d3:	5d                   	pop    %ebp
801027d4:	c3                   	ret    
801027d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027e0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801027e0:	a1 74 26 11 80       	mov    0x80112674,%eax
801027e5:	85 c0                	test   %eax,%eax
801027e7:	75 1f                	jne    80102808 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801027e9:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
801027ee:	85 c0                	test   %eax,%eax
801027f0:	74 0e                	je     80102800 <kalloc+0x20>
    kmem.freelist = r->next;
801027f2:	8b 10                	mov    (%eax),%edx
801027f4:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801027fa:	c3                   	ret    
801027fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027ff:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102800:	c3                   	ret    
80102801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102808:	55                   	push   %ebp
80102809:	89 e5                	mov    %esp,%ebp
8010280b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010280e:	68 40 26 11 80       	push   $0x80112640
80102813:	e8 98 1d 00 00       	call   801045b0 <acquire>
  r = kmem.freelist;
80102818:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010281d:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102823:	83 c4 10             	add    $0x10,%esp
80102826:	85 c0                	test   %eax,%eax
80102828:	74 08                	je     80102832 <kalloc+0x52>
    kmem.freelist = r->next;
8010282a:	8b 08                	mov    (%eax),%ecx
8010282c:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
80102832:	85 d2                	test   %edx,%edx
80102834:	74 16                	je     8010284c <kalloc+0x6c>
    release(&kmem.lock);
80102836:	83 ec 0c             	sub    $0xc,%esp
80102839:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010283c:	68 40 26 11 80       	push   $0x80112640
80102841:	e8 8a 1e 00 00       	call   801046d0 <release>
  return (char*)r;
80102846:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102849:	83 c4 10             	add    $0x10,%esp
}
8010284c:	c9                   	leave  
8010284d:	c3                   	ret    
8010284e:	66 90                	xchg   %ax,%ax

80102850 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102850:	ba 64 00 00 00       	mov    $0x64,%edx
80102855:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102856:	a8 01                	test   $0x1,%al
80102858:	0f 84 c2 00 00 00    	je     80102920 <kbdgetc+0xd0>
{
8010285e:	55                   	push   %ebp
8010285f:	ba 60 00 00 00       	mov    $0x60,%edx
80102864:	89 e5                	mov    %esp,%ebp
80102866:	53                   	push   %ebx
80102867:	ec                   	in     (%dx),%al
  return data;
80102868:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
    return -1;
  data = inb(KBDATAP);
8010286e:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80102871:	3c e0                	cmp    $0xe0,%al
80102873:	74 5b                	je     801028d0 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102875:	89 d9                	mov    %ebx,%ecx
80102877:	83 e1 40             	and    $0x40,%ecx
8010287a:	84 c0                	test   %al,%al
8010287c:	78 62                	js     801028e0 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010287e:	85 c9                	test   %ecx,%ecx
80102880:	74 09                	je     8010288b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102882:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102885:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102888:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
8010288b:	0f b6 8a 80 75 10 80 	movzbl -0x7fef8a80(%edx),%ecx
  shift ^= togglecode[data];
80102892:	0f b6 82 80 74 10 80 	movzbl -0x7fef8b80(%edx),%eax
  shift |= shiftcode[data];
80102899:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
8010289b:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
8010289d:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
8010289f:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801028a5:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801028a8:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801028ab:	8b 04 85 60 74 10 80 	mov    -0x7fef8ba0(,%eax,4),%eax
801028b2:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801028b6:	74 0b                	je     801028c3 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
801028b8:	8d 50 9f             	lea    -0x61(%eax),%edx
801028bb:	83 fa 19             	cmp    $0x19,%edx
801028be:	77 48                	ja     80102908 <kbdgetc+0xb8>
      c += 'A' - 'a';
801028c0:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801028c3:	5b                   	pop    %ebx
801028c4:	5d                   	pop    %ebp
801028c5:	c3                   	ret    
801028c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028cd:	8d 76 00             	lea    0x0(%esi),%esi
    shift |= E0ESC;
801028d0:	83 cb 40             	or     $0x40,%ebx
    return 0;
801028d3:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801028d5:	89 1d b4 a5 10 80    	mov    %ebx,0x8010a5b4
}
801028db:	5b                   	pop    %ebx
801028dc:	5d                   	pop    %ebp
801028dd:	c3                   	ret    
801028de:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801028e0:	83 e0 7f             	and    $0x7f,%eax
801028e3:	85 c9                	test   %ecx,%ecx
801028e5:	0f 44 d0             	cmove  %eax,%edx
    return 0;
801028e8:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801028ea:	0f b6 8a 80 75 10 80 	movzbl -0x7fef8a80(%edx),%ecx
801028f1:	83 c9 40             	or     $0x40,%ecx
801028f4:	0f b6 c9             	movzbl %cl,%ecx
801028f7:	f7 d1                	not    %ecx
801028f9:	21 d9                	and    %ebx,%ecx
}
801028fb:	5b                   	pop    %ebx
801028fc:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
801028fd:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
80102903:	c3                   	ret    
80102904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102908:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010290b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010290e:	5b                   	pop    %ebx
8010290f:	5d                   	pop    %ebp
      c += 'a' - 'A';
80102910:	83 f9 1a             	cmp    $0x1a,%ecx
80102913:	0f 42 c2             	cmovb  %edx,%eax
}
80102916:	c3                   	ret    
80102917:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010291e:	66 90                	xchg   %ax,%ax
    return -1;
80102920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102925:	c3                   	ret    
80102926:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010292d:	8d 76 00             	lea    0x0(%esi),%esi

80102930 <kbdintr>:

void
kbdintr(void)
{
80102930:	55                   	push   %ebp
80102931:	89 e5                	mov    %esp,%ebp
80102933:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102936:	68 50 28 10 80       	push   $0x80102850
8010293b:	e8 10 df ff ff       	call   80100850 <consoleintr>
}
80102940:	83 c4 10             	add    $0x10,%esp
80102943:	c9                   	leave  
80102944:	c3                   	ret    
80102945:	66 90                	xchg   %ax,%ax
80102947:	66 90                	xchg   %ax,%ax
80102949:	66 90                	xchg   %ax,%ax
8010294b:	66 90                	xchg   %ax,%ax
8010294d:	66 90                	xchg   %ax,%ax
8010294f:	90                   	nop

80102950 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102950:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102955:	85 c0                	test   %eax,%eax
80102957:	0f 84 cb 00 00 00    	je     80102a28 <lapicinit+0xd8>
  lapic[index] = value;
8010295d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102964:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102967:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010296a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102971:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102974:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102977:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010297e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102981:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102984:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010298b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010298e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102991:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102998:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010299b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010299e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801029a5:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801029a8:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801029ab:	8b 50 30             	mov    0x30(%eax),%edx
801029ae:	c1 ea 10             	shr    $0x10,%edx
801029b1:	81 e2 fc 00 00 00    	and    $0xfc,%edx
801029b7:	75 77                	jne    80102a30 <lapicinit+0xe0>
  lapic[index] = value;
801029b9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801029c0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029c3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029c6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801029cd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029d0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029d3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801029da:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029dd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029e0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801029e7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029ea:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029ed:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801029f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029f7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029fa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102a01:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102a04:	8b 50 20             	mov    0x20(%eax),%edx
80102a07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a0e:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102a10:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102a16:	80 e6 10             	and    $0x10,%dh
80102a19:	75 f5                	jne    80102a10 <lapicinit+0xc0>
  lapic[index] = value;
80102a1b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102a22:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a25:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102a28:	c3                   	ret    
80102a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102a30:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102a37:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a3a:	8b 50 20             	mov    0x20(%eax),%edx
}
80102a3d:	e9 77 ff ff ff       	jmp    801029b9 <lapicinit+0x69>
80102a42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102a50 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102a50:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102a55:	85 c0                	test   %eax,%eax
80102a57:	74 07                	je     80102a60 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102a59:	8b 40 20             	mov    0x20(%eax),%eax
80102a5c:	c1 e8 18             	shr    $0x18,%eax
80102a5f:	c3                   	ret    
    return 0;
80102a60:	31 c0                	xor    %eax,%eax
}
80102a62:	c3                   	ret    
80102a63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102a70 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102a70:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102a75:	85 c0                	test   %eax,%eax
80102a77:	74 0d                	je     80102a86 <lapiceoi+0x16>
  lapic[index] = value;
80102a79:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a80:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a83:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102a86:	c3                   	ret    
80102a87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a8e:	66 90                	xchg   %ax,%ax

80102a90 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102a90:	c3                   	ret    
80102a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a9f:	90                   	nop

80102aa0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102aa0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa1:	b8 0f 00 00 00       	mov    $0xf,%eax
80102aa6:	ba 70 00 00 00       	mov    $0x70,%edx
80102aab:	89 e5                	mov    %esp,%ebp
80102aad:	53                   	push   %ebx
80102aae:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102ab1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102ab4:	ee                   	out    %al,(%dx)
80102ab5:	b8 0a 00 00 00       	mov    $0xa,%eax
80102aba:	ba 71 00 00 00       	mov    $0x71,%edx
80102abf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102ac0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102ac2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102ac5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102acb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102acd:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102ad0:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102ad2:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102ad5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102ad8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102ade:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102ae3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ae9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102aec:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102af3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102af6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102af9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102b00:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b03:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b06:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b0c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b0f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b15:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b18:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b1e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b21:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
80102b27:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102b28:	8b 40 20             	mov    0x20(%eax),%eax
}
80102b2b:	5d                   	pop    %ebp
80102b2c:	c3                   	ret    
80102b2d:	8d 76 00             	lea    0x0(%esi),%esi

80102b30 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102b30:	55                   	push   %ebp
80102b31:	b8 0b 00 00 00       	mov    $0xb,%eax
80102b36:	ba 70 00 00 00       	mov    $0x70,%edx
80102b3b:	89 e5                	mov    %esp,%ebp
80102b3d:	57                   	push   %edi
80102b3e:	56                   	push   %esi
80102b3f:	53                   	push   %ebx
80102b40:	83 ec 4c             	sub    $0x4c,%esp
80102b43:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b44:	ba 71 00 00 00       	mov    $0x71,%edx
80102b49:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102b4a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b4d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102b52:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102b55:	8d 76 00             	lea    0x0(%esi),%esi
80102b58:	31 c0                	xor    %eax,%eax
80102b5a:	89 da                	mov    %ebx,%edx
80102b5c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b5d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102b62:	89 ca                	mov    %ecx,%edx
80102b64:	ec                   	in     (%dx),%al
80102b65:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b68:	89 da                	mov    %ebx,%edx
80102b6a:	b8 02 00 00 00       	mov    $0x2,%eax
80102b6f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b70:	89 ca                	mov    %ecx,%edx
80102b72:	ec                   	in     (%dx),%al
80102b73:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b76:	89 da                	mov    %ebx,%edx
80102b78:	b8 04 00 00 00       	mov    $0x4,%eax
80102b7d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b7e:	89 ca                	mov    %ecx,%edx
80102b80:	ec                   	in     (%dx),%al
80102b81:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b84:	89 da                	mov    %ebx,%edx
80102b86:	b8 07 00 00 00       	mov    $0x7,%eax
80102b8b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b8c:	89 ca                	mov    %ecx,%edx
80102b8e:	ec                   	in     (%dx),%al
80102b8f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b92:	89 da                	mov    %ebx,%edx
80102b94:	b8 08 00 00 00       	mov    $0x8,%eax
80102b99:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b9a:	89 ca                	mov    %ecx,%edx
80102b9c:	ec                   	in     (%dx),%al
80102b9d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b9f:	89 da                	mov    %ebx,%edx
80102ba1:	b8 09 00 00 00       	mov    $0x9,%eax
80102ba6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ba7:	89 ca                	mov    %ecx,%edx
80102ba9:	ec                   	in     (%dx),%al
80102baa:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bac:	89 da                	mov    %ebx,%edx
80102bae:	b8 0a 00 00 00       	mov    $0xa,%eax
80102bb3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bb4:	89 ca                	mov    %ecx,%edx
80102bb6:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102bb7:	84 c0                	test   %al,%al
80102bb9:	78 9d                	js     80102b58 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102bbb:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102bbf:	89 fa                	mov    %edi,%edx
80102bc1:	0f b6 fa             	movzbl %dl,%edi
80102bc4:	89 f2                	mov    %esi,%edx
80102bc6:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102bc9:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102bcd:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bd0:	89 da                	mov    %ebx,%edx
80102bd2:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102bd5:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102bd8:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102bdc:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102bdf:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102be2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102be6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102be9:	31 c0                	xor    %eax,%eax
80102beb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bec:	89 ca                	mov    %ecx,%edx
80102bee:	ec                   	in     (%dx),%al
80102bef:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bf2:	89 da                	mov    %ebx,%edx
80102bf4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102bf7:	b8 02 00 00 00       	mov    $0x2,%eax
80102bfc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bfd:	89 ca                	mov    %ecx,%edx
80102bff:	ec                   	in     (%dx),%al
80102c00:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c03:	89 da                	mov    %ebx,%edx
80102c05:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102c08:	b8 04 00 00 00       	mov    $0x4,%eax
80102c0d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c0e:	89 ca                	mov    %ecx,%edx
80102c10:	ec                   	in     (%dx),%al
80102c11:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c14:	89 da                	mov    %ebx,%edx
80102c16:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102c19:	b8 07 00 00 00       	mov    $0x7,%eax
80102c1e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c1f:	89 ca                	mov    %ecx,%edx
80102c21:	ec                   	in     (%dx),%al
80102c22:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c25:	89 da                	mov    %ebx,%edx
80102c27:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102c2a:	b8 08 00 00 00       	mov    $0x8,%eax
80102c2f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c30:	89 ca                	mov    %ecx,%edx
80102c32:	ec                   	in     (%dx),%al
80102c33:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c36:	89 da                	mov    %ebx,%edx
80102c38:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102c3b:	b8 09 00 00 00       	mov    $0x9,%eax
80102c40:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c41:	89 ca                	mov    %ecx,%edx
80102c43:	ec                   	in     (%dx),%al
80102c44:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c47:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102c4a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c4d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102c50:	6a 18                	push   $0x18
80102c52:	50                   	push   %eax
80102c53:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102c56:	50                   	push   %eax
80102c57:	e8 14 1b 00 00       	call   80104770 <memcmp>
80102c5c:	83 c4 10             	add    $0x10,%esp
80102c5f:	85 c0                	test   %eax,%eax
80102c61:	0f 85 f1 fe ff ff    	jne    80102b58 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102c67:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102c6b:	75 78                	jne    80102ce5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102c6d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102c70:	89 c2                	mov    %eax,%edx
80102c72:	83 e0 0f             	and    $0xf,%eax
80102c75:	c1 ea 04             	shr    $0x4,%edx
80102c78:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c7b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c7e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102c81:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102c84:	89 c2                	mov    %eax,%edx
80102c86:	83 e0 0f             	and    $0xf,%eax
80102c89:	c1 ea 04             	shr    $0x4,%edx
80102c8c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c8f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c92:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102c95:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102c98:	89 c2                	mov    %eax,%edx
80102c9a:	83 e0 0f             	and    $0xf,%eax
80102c9d:	c1 ea 04             	shr    $0x4,%edx
80102ca0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ca3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ca6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102ca9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102cac:	89 c2                	mov    %eax,%edx
80102cae:	83 e0 0f             	and    $0xf,%eax
80102cb1:	c1 ea 04             	shr    $0x4,%edx
80102cb4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cb7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cba:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102cbd:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102cc0:	89 c2                	mov    %eax,%edx
80102cc2:	83 e0 0f             	and    $0xf,%eax
80102cc5:	c1 ea 04             	shr    $0x4,%edx
80102cc8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ccb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cce:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102cd1:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102cd4:	89 c2                	mov    %eax,%edx
80102cd6:	83 e0 0f             	and    $0xf,%eax
80102cd9:	c1 ea 04             	shr    $0x4,%edx
80102cdc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cdf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ce2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102ce5:	8b 75 08             	mov    0x8(%ebp),%esi
80102ce8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ceb:	89 06                	mov    %eax,(%esi)
80102ced:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102cf0:	89 46 04             	mov    %eax,0x4(%esi)
80102cf3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102cf6:	89 46 08             	mov    %eax,0x8(%esi)
80102cf9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102cfc:	89 46 0c             	mov    %eax,0xc(%esi)
80102cff:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d02:	89 46 10             	mov    %eax,0x10(%esi)
80102d05:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d08:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102d0b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102d12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d15:	5b                   	pop    %ebx
80102d16:	5e                   	pop    %esi
80102d17:	5f                   	pop    %edi
80102d18:	5d                   	pop    %ebp
80102d19:	c3                   	ret    
80102d1a:	66 90                	xchg   %ax,%ax
80102d1c:	66 90                	xchg   %ax,%ax
80102d1e:	66 90                	xchg   %ax,%ax

80102d20 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d20:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102d26:	85 c9                	test   %ecx,%ecx
80102d28:	0f 8e 8a 00 00 00    	jle    80102db8 <install_trans+0x98>
{
80102d2e:	55                   	push   %ebp
80102d2f:	89 e5                	mov    %esp,%ebp
80102d31:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102d32:	31 ff                	xor    %edi,%edi
{
80102d34:	56                   	push   %esi
80102d35:	53                   	push   %ebx
80102d36:	83 ec 0c             	sub    $0xc,%esp
80102d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102d40:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102d45:	83 ec 08             	sub    $0x8,%esp
80102d48:	01 f8                	add    %edi,%eax
80102d4a:	83 c0 01             	add    $0x1,%eax
80102d4d:	50                   	push   %eax
80102d4e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102d54:	e8 77 d3 ff ff       	call   801000d0 <bread>
80102d59:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d5b:	58                   	pop    %eax
80102d5c:	5a                   	pop    %edx
80102d5d:	ff 34 bd cc 26 11 80 	pushl  -0x7feed934(,%edi,4)
80102d64:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102d6a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d6d:	e8 5e d3 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102d72:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d75:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102d77:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d7a:	68 00 02 00 00       	push   $0x200
80102d7f:	50                   	push   %eax
80102d80:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102d83:	50                   	push   %eax
80102d84:	e8 37 1a 00 00       	call   801047c0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102d89:	89 1c 24             	mov    %ebx,(%esp)
80102d8c:	e8 1f d4 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102d91:	89 34 24             	mov    %esi,(%esp)
80102d94:	e8 57 d4 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102d99:	89 1c 24             	mov    %ebx,(%esp)
80102d9c:	e8 4f d4 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102da1:	83 c4 10             	add    $0x10,%esp
80102da4:	39 3d c8 26 11 80    	cmp    %edi,0x801126c8
80102daa:	7f 94                	jg     80102d40 <install_trans+0x20>
  }
}
80102dac:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102daf:	5b                   	pop    %ebx
80102db0:	5e                   	pop    %esi
80102db1:	5f                   	pop    %edi
80102db2:	5d                   	pop    %ebp
80102db3:	c3                   	ret    
80102db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102db8:	c3                   	ret    
80102db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102dc0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102dc0:	55                   	push   %ebp
80102dc1:	89 e5                	mov    %esp,%ebp
80102dc3:	53                   	push   %ebx
80102dc4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102dc7:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102dcd:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102dd3:	e8 f8 d2 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102dd8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ddb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102ddd:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102de2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102de5:	85 c0                	test   %eax,%eax
80102de7:	7e 19                	jle    80102e02 <write_head+0x42>
80102de9:	31 d2                	xor    %edx,%edx
80102deb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102def:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102df0:	8b 0c 95 cc 26 11 80 	mov    -0x7feed934(,%edx,4),%ecx
80102df7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102dfb:	83 c2 01             	add    $0x1,%edx
80102dfe:	39 d0                	cmp    %edx,%eax
80102e00:	75 ee                	jne    80102df0 <write_head+0x30>
  }
  bwrite(buf);
80102e02:	83 ec 0c             	sub    $0xc,%esp
80102e05:	53                   	push   %ebx
80102e06:	e8 a5 d3 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102e0b:	89 1c 24             	mov    %ebx,(%esp)
80102e0e:	e8 dd d3 ff ff       	call   801001f0 <brelse>
}
80102e13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e16:	83 c4 10             	add    $0x10,%esp
80102e19:	c9                   	leave  
80102e1a:	c3                   	ret    
80102e1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e1f:	90                   	nop

80102e20 <initlog>:
{
80102e20:	55                   	push   %ebp
80102e21:	89 e5                	mov    %esp,%ebp
80102e23:	53                   	push   %ebx
80102e24:	83 ec 2c             	sub    $0x2c,%esp
80102e27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102e2a:	68 80 76 10 80       	push   $0x80107680
80102e2f:	68 80 26 11 80       	push   $0x80112680
80102e34:	e8 77 16 00 00       	call   801044b0 <initlock>
  readsb(dev, &sb);
80102e39:	58                   	pop    %eax
80102e3a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102e3d:	5a                   	pop    %edx
80102e3e:	50                   	push   %eax
80102e3f:	53                   	push   %ebx
80102e40:	e8 0b e6 ff ff       	call   80101450 <readsb>
  log.start = sb.logstart;
80102e45:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102e48:	59                   	pop    %ecx
  log.dev = dev;
80102e49:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  log.size = sb.nlog;
80102e4f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102e52:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  log.size = sb.nlog;
80102e57:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  struct buf *buf = bread(log.dev, log.start);
80102e5d:	5a                   	pop    %edx
80102e5e:	50                   	push   %eax
80102e5f:	53                   	push   %ebx
80102e60:	e8 6b d2 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102e65:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102e68:	8b 48 5c             	mov    0x5c(%eax),%ecx
80102e6b:	89 0d c8 26 11 80    	mov    %ecx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102e71:	85 c9                	test   %ecx,%ecx
80102e73:	7e 1d                	jle    80102e92 <initlog+0x72>
80102e75:	31 d2                	xor    %edx,%edx
80102e77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e7e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102e80:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
80102e84:	89 1c 95 cc 26 11 80 	mov    %ebx,-0x7feed934(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102e8b:	83 c2 01             	add    $0x1,%edx
80102e8e:	39 d1                	cmp    %edx,%ecx
80102e90:	75 ee                	jne    80102e80 <initlog+0x60>
  brelse(buf);
80102e92:	83 ec 0c             	sub    $0xc,%esp
80102e95:	50                   	push   %eax
80102e96:	e8 55 d3 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102e9b:	e8 80 fe ff ff       	call   80102d20 <install_trans>
  log.lh.n = 0;
80102ea0:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102ea7:	00 00 00 
  write_head(); // clear the log
80102eaa:	e8 11 ff ff ff       	call   80102dc0 <write_head>
}
80102eaf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102eb2:	83 c4 10             	add    $0x10,%esp
80102eb5:	c9                   	leave  
80102eb6:	c3                   	ret    
80102eb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ebe:	66 90                	xchg   %ax,%ax

80102ec0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102ec0:	55                   	push   %ebp
80102ec1:	89 e5                	mov    %esp,%ebp
80102ec3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102ec6:	68 80 26 11 80       	push   $0x80112680
80102ecb:	e8 e0 16 00 00       	call   801045b0 <acquire>
80102ed0:	83 c4 10             	add    $0x10,%esp
80102ed3:	eb 18                	jmp    80102eed <begin_op+0x2d>
80102ed5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ed8:	83 ec 08             	sub    $0x8,%esp
80102edb:	68 80 26 11 80       	push   $0x80112680
80102ee0:	68 80 26 11 80       	push   $0x80112680
80102ee5:	e8 66 11 00 00       	call   80104050 <sleep>
80102eea:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102eed:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102ef2:	85 c0                	test   %eax,%eax
80102ef4:	75 e2                	jne    80102ed8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ef6:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102efb:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102f01:	83 c0 01             	add    $0x1,%eax
80102f04:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102f07:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102f0a:	83 fa 1e             	cmp    $0x1e,%edx
80102f0d:	7f c9                	jg     80102ed8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102f0f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102f12:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102f17:	68 80 26 11 80       	push   $0x80112680
80102f1c:	e8 af 17 00 00       	call   801046d0 <release>
      break;
    }
  }
}
80102f21:	83 c4 10             	add    $0x10,%esp
80102f24:	c9                   	leave  
80102f25:	c3                   	ret    
80102f26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f2d:	8d 76 00             	lea    0x0(%esi),%esi

80102f30 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102f30:	55                   	push   %ebp
80102f31:	89 e5                	mov    %esp,%ebp
80102f33:	57                   	push   %edi
80102f34:	56                   	push   %esi
80102f35:	53                   	push   %ebx
80102f36:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102f39:	68 80 26 11 80       	push   $0x80112680
80102f3e:	e8 6d 16 00 00       	call   801045b0 <acquire>
  log.outstanding -= 1;
80102f43:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102f48:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102f4e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102f51:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102f54:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102f5a:	85 f6                	test   %esi,%esi
80102f5c:	0f 85 22 01 00 00    	jne    80103084 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102f62:	85 db                	test   %ebx,%ebx
80102f64:	0f 85 f6 00 00 00    	jne    80103060 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102f6a:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102f71:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102f74:	83 ec 0c             	sub    $0xc,%esp
80102f77:	68 80 26 11 80       	push   $0x80112680
80102f7c:	e8 4f 17 00 00       	call   801046d0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102f81:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102f87:	83 c4 10             	add    $0x10,%esp
80102f8a:	85 c9                	test   %ecx,%ecx
80102f8c:	7f 42                	jg     80102fd0 <end_op+0xa0>
    acquire(&log.lock);
80102f8e:	83 ec 0c             	sub    $0xc,%esp
80102f91:	68 80 26 11 80       	push   $0x80112680
80102f96:	e8 15 16 00 00       	call   801045b0 <acquire>
    wakeup(&log);
80102f9b:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102fa2:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102fa9:	00 00 00 
    wakeup(&log);
80102fac:	e8 4f 12 00 00       	call   80104200 <wakeup>
    release(&log.lock);
80102fb1:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102fb8:	e8 13 17 00 00       	call   801046d0 <release>
80102fbd:	83 c4 10             	add    $0x10,%esp
}
80102fc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fc3:	5b                   	pop    %ebx
80102fc4:	5e                   	pop    %esi
80102fc5:	5f                   	pop    %edi
80102fc6:	5d                   	pop    %ebp
80102fc7:	c3                   	ret    
80102fc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fcf:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102fd0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102fd5:	83 ec 08             	sub    $0x8,%esp
80102fd8:	01 d8                	add    %ebx,%eax
80102fda:	83 c0 01             	add    $0x1,%eax
80102fdd:	50                   	push   %eax
80102fde:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102fe4:	e8 e7 d0 ff ff       	call   801000d0 <bread>
80102fe9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102feb:	58                   	pop    %eax
80102fec:	5a                   	pop    %edx
80102fed:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102ff4:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102ffa:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ffd:	e8 ce d0 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103002:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103005:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103007:	8d 40 5c             	lea    0x5c(%eax),%eax
8010300a:	68 00 02 00 00       	push   $0x200
8010300f:	50                   	push   %eax
80103010:	8d 46 5c             	lea    0x5c(%esi),%eax
80103013:	50                   	push   %eax
80103014:	e8 a7 17 00 00       	call   801047c0 <memmove>
    bwrite(to);  // write the log
80103019:	89 34 24             	mov    %esi,(%esp)
8010301c:	e8 8f d1 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103021:	89 3c 24             	mov    %edi,(%esp)
80103024:	e8 c7 d1 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103029:	89 34 24             	mov    %esi,(%esp)
8010302c:	e8 bf d1 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103031:	83 c4 10             	add    $0x10,%esp
80103034:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
8010303a:	7c 94                	jl     80102fd0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010303c:	e8 7f fd ff ff       	call   80102dc0 <write_head>
    install_trans(); // Now install writes to home locations
80103041:	e8 da fc ff ff       	call   80102d20 <install_trans>
    log.lh.n = 0;
80103046:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
8010304d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103050:	e8 6b fd ff ff       	call   80102dc0 <write_head>
80103055:	e9 34 ff ff ff       	jmp    80102f8e <end_op+0x5e>
8010305a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103060:	83 ec 0c             	sub    $0xc,%esp
80103063:	68 80 26 11 80       	push   $0x80112680
80103068:	e8 93 11 00 00       	call   80104200 <wakeup>
  release(&log.lock);
8010306d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80103074:	e8 57 16 00 00       	call   801046d0 <release>
80103079:	83 c4 10             	add    $0x10,%esp
}
8010307c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010307f:	5b                   	pop    %ebx
80103080:	5e                   	pop    %esi
80103081:	5f                   	pop    %edi
80103082:	5d                   	pop    %ebp
80103083:	c3                   	ret    
    panic("log.committing");
80103084:	83 ec 0c             	sub    $0xc,%esp
80103087:	68 84 76 10 80       	push   $0x80107684
8010308c:	e8 ef d2 ff ff       	call   80100380 <panic>
80103091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103098:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010309f:	90                   	nop

801030a0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	53                   	push   %ebx
801030a4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801030a7:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
{
801030ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801030b0:	83 fa 1d             	cmp    $0x1d,%edx
801030b3:	0f 8f 85 00 00 00    	jg     8010313e <log_write+0x9e>
801030b9:	a1 b8 26 11 80       	mov    0x801126b8,%eax
801030be:	83 e8 01             	sub    $0x1,%eax
801030c1:	39 c2                	cmp    %eax,%edx
801030c3:	7d 79                	jge    8010313e <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
801030c5:	a1 bc 26 11 80       	mov    0x801126bc,%eax
801030ca:	85 c0                	test   %eax,%eax
801030cc:	7e 7d                	jle    8010314b <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
801030ce:	83 ec 0c             	sub    $0xc,%esp
801030d1:	68 80 26 11 80       	push   $0x80112680
801030d6:	e8 d5 14 00 00       	call   801045b0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
801030db:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
801030e1:	83 c4 10             	add    $0x10,%esp
801030e4:	85 d2                	test   %edx,%edx
801030e6:	7e 4a                	jle    80103132 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801030e8:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
801030eb:	31 c0                	xor    %eax,%eax
801030ed:	eb 08                	jmp    801030f7 <log_write+0x57>
801030ef:	90                   	nop
801030f0:	83 c0 01             	add    $0x1,%eax
801030f3:	39 c2                	cmp    %eax,%edx
801030f5:	74 29                	je     80103120 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801030f7:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
801030fe:	75 f0                	jne    801030f0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103100:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103107:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010310a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010310d:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80103114:	c9                   	leave  
  release(&log.lock);
80103115:	e9 b6 15 00 00       	jmp    801046d0 <release>
8010311a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103120:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
    log.lh.n++;
80103127:	83 c2 01             	add    $0x1,%edx
8010312a:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
80103130:	eb d5                	jmp    80103107 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80103132:	8b 43 08             	mov    0x8(%ebx),%eax
80103135:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
8010313a:	75 cb                	jne    80103107 <log_write+0x67>
8010313c:	eb e9                	jmp    80103127 <log_write+0x87>
    panic("too big a transaction");
8010313e:	83 ec 0c             	sub    $0xc,%esp
80103141:	68 93 76 10 80       	push   $0x80107693
80103146:	e8 35 d2 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
8010314b:	83 ec 0c             	sub    $0xc,%esp
8010314e:	68 a9 76 10 80       	push   $0x801076a9
80103153:	e8 28 d2 ff ff       	call   80100380 <panic>
80103158:	66 90                	xchg   %ax,%ax
8010315a:	66 90                	xchg   %ax,%ax
8010315c:	66 90                	xchg   %ax,%ax
8010315e:	66 90                	xchg   %ax,%ax

80103160 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103160:	55                   	push   %ebp
80103161:	89 e5                	mov    %esp,%ebp
80103163:	53                   	push   %ebx
80103164:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103167:	e8 24 09 00 00       	call   80103a90 <cpuid>
8010316c:	89 c3                	mov    %eax,%ebx
8010316e:	e8 1d 09 00 00       	call   80103a90 <cpuid>
80103173:	83 ec 04             	sub    $0x4,%esp
80103176:	53                   	push   %ebx
80103177:	50                   	push   %eax
80103178:	68 c4 76 10 80       	push   $0x801076c4
8010317d:	e8 1e d5 ff ff       	call   801006a0 <cprintf>
  idtinit();       // load idt register
80103182:	e8 c9 27 00 00       	call   80105950 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103187:	e8 94 08 00 00       	call   80103a20 <mycpu>
8010318c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010318e:	b8 01 00 00 00       	mov    $0x1,%eax
80103193:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010319a:	e8 d1 0b 00 00       	call   80103d70 <scheduler>
8010319f:	90                   	nop

801031a0 <mpenter>:
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801031a6:	e8 75 38 00 00       	call   80106a20 <switchkvm>
  seginit();
801031ab:	e8 e0 37 00 00       	call   80106990 <seginit>
  lapicinit();
801031b0:	e8 9b f7 ff ff       	call   80102950 <lapicinit>
  mpmain();
801031b5:	e8 a6 ff ff ff       	call   80103160 <mpmain>
801031ba:	66 90                	xchg   %ax,%ax
801031bc:	66 90                	xchg   %ax,%ax
801031be:	66 90                	xchg   %ax,%ax

801031c0 <main>:
{
801031c0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801031c4:	83 e4 f0             	and    $0xfffffff0,%esp
801031c7:	ff 71 fc             	pushl  -0x4(%ecx)
801031ca:	55                   	push   %ebp
801031cb:	89 e5                	mov    %esp,%ebp
801031cd:	53                   	push   %ebx
801031ce:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801031cf:	83 ec 08             	sub    $0x8,%esp
801031d2:	68 00 00 40 80       	push   $0x80400000
801031d7:	68 a8 54 11 80       	push   $0x801154a8
801031dc:	e8 2f f5 ff ff       	call   80102710 <kinit1>
  kvmalloc();      // kernel page table
801031e1:	e8 fa 3c 00 00       	call   80106ee0 <kvmalloc>
  mpinit();        // detect other processors
801031e6:	e8 85 01 00 00       	call   80103370 <mpinit>
  lapicinit();     // interrupt controller
801031eb:	e8 60 f7 ff ff       	call   80102950 <lapicinit>
  seginit();       // segment descriptors
801031f0:	e8 9b 37 00 00       	call   80106990 <seginit>
  picinit();       // disable pic
801031f5:	e8 46 03 00 00       	call   80103540 <picinit>
  ioapicinit();    // another interrupt controller
801031fa:	e8 31 f3 ff ff       	call   80102530 <ioapicinit>
  consoleinit();   // console hardware
801031ff:	e8 1c d8 ff ff       	call   80100a20 <consoleinit>
  uartinit();      // serial port
80103204:	e8 47 2a 00 00       	call   80105c50 <uartinit>
  pinit();         // process table
80103209:	e8 f2 07 00 00       	call   80103a00 <pinit>
  tvinit();        // trap vectors
8010320e:	e8 bd 26 00 00       	call   801058d0 <tvinit>
  binit();         // buffer cache
80103213:	e8 28 ce ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103218:	e8 b3 db ff ff       	call   80100dd0 <fileinit>
  ideinit();       // disk 
8010321d:	e8 fe f0 ff ff       	call   80102320 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103222:	83 c4 0c             	add    $0xc,%esp
80103225:	68 8a 00 00 00       	push   $0x8a
8010322a:	68 8c a4 10 80       	push   $0x8010a48c
8010322f:	68 00 70 00 80       	push   $0x80007000
80103234:	e8 87 15 00 00       	call   801047c0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103239:	83 c4 10             	add    $0x10,%esp
8010323c:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103243:	00 00 00 
80103246:	05 80 27 11 80       	add    $0x80112780,%eax
8010324b:	3d 80 27 11 80       	cmp    $0x80112780,%eax
80103250:	76 7e                	jbe    801032d0 <main+0x110>
80103252:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80103257:	eb 20                	jmp    80103279 <main+0xb9>
80103259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103260:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103267:	00 00 00 
8010326a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103270:	05 80 27 11 80       	add    $0x80112780,%eax
80103275:	39 c3                	cmp    %eax,%ebx
80103277:	73 57                	jae    801032d0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103279:	e8 a2 07 00 00       	call   80103a20 <mycpu>
8010327e:	39 c3                	cmp    %eax,%ebx
80103280:	74 de                	je     80103260 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103282:	e8 59 f5 ff ff       	call   801027e0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103287:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-8) = mpenter;
8010328a:	c7 05 f8 6f 00 80 a0 	movl   $0x801031a0,0x80006ff8
80103291:	31 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103294:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010329b:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010329e:	05 00 10 00 00       	add    $0x1000,%eax
801032a3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801032a8:	0f b6 03             	movzbl (%ebx),%eax
801032ab:	68 00 70 00 00       	push   $0x7000
801032b0:	50                   	push   %eax
801032b1:	e8 ea f7 ff ff       	call   80102aa0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801032b6:	83 c4 10             	add    $0x10,%esp
801032b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032c0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801032c6:	85 c0                	test   %eax,%eax
801032c8:	74 f6                	je     801032c0 <main+0x100>
801032ca:	eb 94                	jmp    80103260 <main+0xa0>
801032cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801032d0:	83 ec 08             	sub    $0x8,%esp
801032d3:	68 00 00 00 8e       	push   $0x8e000000
801032d8:	68 00 00 40 80       	push   $0x80400000
801032dd:	e8 9e f4 ff ff       	call   80102780 <kinit2>
  userinit();      // first user process
801032e2:	e8 f9 07 00 00       	call   80103ae0 <userinit>
  mpmain();        // finish this processor's setup
801032e7:	e8 74 fe ff ff       	call   80103160 <mpmain>
801032ec:	66 90                	xchg   %ax,%ax
801032ee:	66 90                	xchg   %ax,%ax

801032f0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801032f0:	55                   	push   %ebp
801032f1:	89 e5                	mov    %esp,%ebp
801032f3:	57                   	push   %edi
801032f4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801032f5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801032fb:	53                   	push   %ebx
  e = addr+len;
801032fc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801032ff:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103302:	39 de                	cmp    %ebx,%esi
80103304:	72 10                	jb     80103316 <mpsearch1+0x26>
80103306:	eb 50                	jmp    80103358 <mpsearch1+0x68>
80103308:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010330f:	90                   	nop
80103310:	89 fe                	mov    %edi,%esi
80103312:	39 fb                	cmp    %edi,%ebx
80103314:	76 42                	jbe    80103358 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103316:	83 ec 04             	sub    $0x4,%esp
80103319:	8d 7e 10             	lea    0x10(%esi),%edi
8010331c:	6a 04                	push   $0x4
8010331e:	68 d8 76 10 80       	push   $0x801076d8
80103323:	56                   	push   %esi
80103324:	e8 47 14 00 00       	call   80104770 <memcmp>
80103329:	83 c4 10             	add    $0x10,%esp
8010332c:	85 c0                	test   %eax,%eax
8010332e:	75 e0                	jne    80103310 <mpsearch1+0x20>
80103330:	89 f2                	mov    %esi,%edx
80103332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103338:	0f b6 0a             	movzbl (%edx),%ecx
8010333b:	83 c2 01             	add    $0x1,%edx
8010333e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103340:	39 fa                	cmp    %edi,%edx
80103342:	75 f4                	jne    80103338 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103344:	84 c0                	test   %al,%al
80103346:	75 c8                	jne    80103310 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103348:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010334b:	89 f0                	mov    %esi,%eax
8010334d:	5b                   	pop    %ebx
8010334e:	5e                   	pop    %esi
8010334f:	5f                   	pop    %edi
80103350:	5d                   	pop    %ebp
80103351:	c3                   	ret    
80103352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103358:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010335b:	31 f6                	xor    %esi,%esi
}
8010335d:	5b                   	pop    %ebx
8010335e:	89 f0                	mov    %esi,%eax
80103360:	5e                   	pop    %esi
80103361:	5f                   	pop    %edi
80103362:	5d                   	pop    %ebp
80103363:	c3                   	ret    
80103364:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010336b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010336f:	90                   	nop

80103370 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103370:	55                   	push   %ebp
80103371:	89 e5                	mov    %esp,%ebp
80103373:	57                   	push   %edi
80103374:	56                   	push   %esi
80103375:	53                   	push   %ebx
80103376:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103379:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103380:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103387:	c1 e0 08             	shl    $0x8,%eax
8010338a:	09 d0                	or     %edx,%eax
8010338c:	c1 e0 04             	shl    $0x4,%eax
8010338f:	75 1b                	jne    801033ac <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103391:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103398:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010339f:	c1 e0 08             	shl    $0x8,%eax
801033a2:	09 d0                	or     %edx,%eax
801033a4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801033a7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801033ac:	ba 00 04 00 00       	mov    $0x400,%edx
801033b1:	e8 3a ff ff ff       	call   801032f0 <mpsearch1>
801033b6:	89 c6                	mov    %eax,%esi
801033b8:	85 c0                	test   %eax,%eax
801033ba:	0f 84 40 01 00 00    	je     80103500 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801033c0:	8b 5e 04             	mov    0x4(%esi),%ebx
801033c3:	85 db                	test   %ebx,%ebx
801033c5:	0f 84 55 01 00 00    	je     80103520 <mpinit+0x1b0>
  if(memcmp(conf, "PCMP", 4) != 0)
801033cb:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801033ce:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
801033d4:	6a 04                	push   $0x4
801033d6:	68 dd 76 10 80       	push   $0x801076dd
801033db:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801033dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801033df:	e8 8c 13 00 00       	call   80104770 <memcmp>
801033e4:	83 c4 10             	add    $0x10,%esp
801033e7:	85 c0                	test   %eax,%eax
801033e9:	0f 85 31 01 00 00    	jne    80103520 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801033ef:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801033f6:	3c 01                	cmp    $0x1,%al
801033f8:	74 08                	je     80103402 <mpinit+0x92>
801033fa:	3c 04                	cmp    $0x4,%al
801033fc:	0f 85 1e 01 00 00    	jne    80103520 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
80103402:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  for(i=0; i<len; i++)
80103409:	66 85 d2             	test   %dx,%dx
8010340c:	74 22                	je     80103430 <mpinit+0xc0>
8010340e:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
80103411:	89 d8                	mov    %ebx,%eax
  sum = 0;
80103413:	31 d2                	xor    %edx,%edx
80103415:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103418:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
8010341f:	83 c0 01             	add    $0x1,%eax
80103422:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103424:	39 f8                	cmp    %edi,%eax
80103426:	75 f0                	jne    80103418 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103428:	84 d2                	test   %dl,%dl
8010342a:	0f 85 f0 00 00 00    	jne    80103520 <mpinit+0x1b0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103430:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103436:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010343b:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103441:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  ismp = 1;
80103448:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010344d:	03 55 e4             	add    -0x1c(%ebp),%edx
80103450:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103453:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103457:	90                   	nop
80103458:	39 c2                	cmp    %eax,%edx
8010345a:	76 15                	jbe    80103471 <mpinit+0x101>
    switch(*p){
8010345c:	0f b6 08             	movzbl (%eax),%ecx
8010345f:	80 f9 02             	cmp    $0x2,%cl
80103462:	74 54                	je     801034b8 <mpinit+0x148>
80103464:	77 3a                	ja     801034a0 <mpinit+0x130>
80103466:	84 c9                	test   %cl,%cl
80103468:	74 66                	je     801034d0 <mpinit+0x160>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010346a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010346d:	39 c2                	cmp    %eax,%edx
8010346f:	77 eb                	ja     8010345c <mpinit+0xec>
80103471:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103474:	85 db                	test   %ebx,%ebx
80103476:	0f 84 b1 00 00 00    	je     8010352d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010347c:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
80103480:	74 15                	je     80103497 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103482:	b8 70 00 00 00       	mov    $0x70,%eax
80103487:	ba 22 00 00 00       	mov    $0x22,%edx
8010348c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010348d:	ba 23 00 00 00       	mov    $0x23,%edx
80103492:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103493:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103496:	ee                   	out    %al,(%dx)
  }
}
80103497:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010349a:	5b                   	pop    %ebx
8010349b:	5e                   	pop    %esi
8010349c:	5f                   	pop    %edi
8010349d:	5d                   	pop    %ebp
8010349e:	c3                   	ret    
8010349f:	90                   	nop
    switch(*p){
801034a0:	83 e9 03             	sub    $0x3,%ecx
801034a3:	80 f9 01             	cmp    $0x1,%cl
801034a6:	76 c2                	jbe    8010346a <mpinit+0xfa>
801034a8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801034af:	eb a7                	jmp    80103458 <mpinit+0xe8>
801034b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801034b8:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
801034bc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801034bf:	88 0d 60 27 11 80    	mov    %cl,0x80112760
      continue;
801034c5:	eb 91                	jmp    80103458 <mpinit+0xe8>
801034c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034ce:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
801034d0:	8b 0d 00 2d 11 80    	mov    0x80112d00,%ecx
801034d6:	83 f9 07             	cmp    $0x7,%ecx
801034d9:	7f 19                	jg     801034f4 <mpinit+0x184>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801034db:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
801034e1:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
801034e5:	83 c1 01             	add    $0x1,%ecx
801034e8:	89 0d 00 2d 11 80    	mov    %ecx,0x80112d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801034ee:	88 9f 80 27 11 80    	mov    %bl,-0x7feed880(%edi)
      p += sizeof(struct mpproc);
801034f4:	83 c0 14             	add    $0x14,%eax
      continue;
801034f7:	e9 5c ff ff ff       	jmp    80103458 <mpinit+0xe8>
801034fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
80103500:	ba 00 00 01 00       	mov    $0x10000,%edx
80103505:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010350a:	e8 e1 fd ff ff       	call   801032f0 <mpsearch1>
8010350f:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103511:	85 c0                	test   %eax,%eax
80103513:	0f 85 a7 fe ff ff    	jne    801033c0 <mpinit+0x50>
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103520:	83 ec 0c             	sub    $0xc,%esp
80103523:	68 e2 76 10 80       	push   $0x801076e2
80103528:	e8 53 ce ff ff       	call   80100380 <panic>
    panic("Didn't find a suitable machine");
8010352d:	83 ec 0c             	sub    $0xc,%esp
80103530:	68 fc 76 10 80       	push   $0x801076fc
80103535:	e8 46 ce ff ff       	call   80100380 <panic>
8010353a:	66 90                	xchg   %ax,%ax
8010353c:	66 90                	xchg   %ax,%ax
8010353e:	66 90                	xchg   %ax,%ax

80103540 <picinit>:
80103540:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103545:	ba 21 00 00 00       	mov    $0x21,%edx
8010354a:	ee                   	out    %al,(%dx)
8010354b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103550:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103551:	c3                   	ret    
80103552:	66 90                	xchg   %ax,%ax
80103554:	66 90                	xchg   %ax,%ax
80103556:	66 90                	xchg   %ax,%ax
80103558:	66 90                	xchg   %ax,%ax
8010355a:	66 90                	xchg   %ax,%ax
8010355c:	66 90                	xchg   %ax,%ax
8010355e:	66 90                	xchg   %ax,%ax

80103560 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103560:	55                   	push   %ebp
80103561:	89 e5                	mov    %esp,%ebp
80103563:	57                   	push   %edi
80103564:	56                   	push   %esi
80103565:	53                   	push   %ebx
80103566:	83 ec 0c             	sub    $0xc,%esp
80103569:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010356c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010356f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103575:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010357b:	e8 70 d8 ff ff       	call   80100df0 <filealloc>
80103580:	89 03                	mov    %eax,(%ebx)
80103582:	85 c0                	test   %eax,%eax
80103584:	0f 84 a8 00 00 00    	je     80103632 <pipealloc+0xd2>
8010358a:	e8 61 d8 ff ff       	call   80100df0 <filealloc>
8010358f:	89 06                	mov    %eax,(%esi)
80103591:	85 c0                	test   %eax,%eax
80103593:	0f 84 87 00 00 00    	je     80103620 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103599:	e8 42 f2 ff ff       	call   801027e0 <kalloc>
8010359e:	89 c7                	mov    %eax,%edi
801035a0:	85 c0                	test   %eax,%eax
801035a2:	0f 84 b0 00 00 00    	je     80103658 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
801035a8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801035af:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801035b2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801035b5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801035bc:	00 00 00 
  p->nwrite = 0;
801035bf:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801035c6:	00 00 00 
  p->nread = 0;
801035c9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801035d0:	00 00 00 
  initlock(&p->lock, "pipe");
801035d3:	68 1b 77 10 80       	push   $0x8010771b
801035d8:	50                   	push   %eax
801035d9:	e8 d2 0e 00 00       	call   801044b0 <initlock>
  (*f0)->type = FD_PIPE;
801035de:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801035e0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801035e3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801035e9:	8b 03                	mov    (%ebx),%eax
801035eb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801035ef:	8b 03                	mov    (%ebx),%eax
801035f1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801035f5:	8b 03                	mov    (%ebx),%eax
801035f7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801035fa:	8b 06                	mov    (%esi),%eax
801035fc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103602:	8b 06                	mov    (%esi),%eax
80103604:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103608:	8b 06                	mov    (%esi),%eax
8010360a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010360e:	8b 06                	mov    (%esi),%eax
80103610:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103613:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103616:	31 c0                	xor    %eax,%eax
}
80103618:	5b                   	pop    %ebx
80103619:	5e                   	pop    %esi
8010361a:	5f                   	pop    %edi
8010361b:	5d                   	pop    %ebp
8010361c:	c3                   	ret    
8010361d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103620:	8b 03                	mov    (%ebx),%eax
80103622:	85 c0                	test   %eax,%eax
80103624:	74 1e                	je     80103644 <pipealloc+0xe4>
    fileclose(*f0);
80103626:	83 ec 0c             	sub    $0xc,%esp
80103629:	50                   	push   %eax
8010362a:	e8 81 d8 ff ff       	call   80100eb0 <fileclose>
8010362f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103632:	8b 06                	mov    (%esi),%eax
80103634:	85 c0                	test   %eax,%eax
80103636:	74 0c                	je     80103644 <pipealloc+0xe4>
    fileclose(*f1);
80103638:	83 ec 0c             	sub    $0xc,%esp
8010363b:	50                   	push   %eax
8010363c:	e8 6f d8 ff ff       	call   80100eb0 <fileclose>
80103641:	83 c4 10             	add    $0x10,%esp
}
80103644:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103647:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010364c:	5b                   	pop    %ebx
8010364d:	5e                   	pop    %esi
8010364e:	5f                   	pop    %edi
8010364f:	5d                   	pop    %ebp
80103650:	c3                   	ret    
80103651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103658:	8b 03                	mov    (%ebx),%eax
8010365a:	85 c0                	test   %eax,%eax
8010365c:	75 c8                	jne    80103626 <pipealloc+0xc6>
8010365e:	eb d2                	jmp    80103632 <pipealloc+0xd2>

80103660 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103660:	55                   	push   %ebp
80103661:	89 e5                	mov    %esp,%ebp
80103663:	56                   	push   %esi
80103664:	53                   	push   %ebx
80103665:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103668:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010366b:	83 ec 0c             	sub    $0xc,%esp
8010366e:	53                   	push   %ebx
8010366f:	e8 3c 0f 00 00       	call   801045b0 <acquire>
  if(writable){
80103674:	83 c4 10             	add    $0x10,%esp
80103677:	85 f6                	test   %esi,%esi
80103679:	74 45                	je     801036c0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010367b:	83 ec 0c             	sub    $0xc,%esp
8010367e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103684:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010368b:	00 00 00 
    wakeup(&p->nread);
8010368e:	50                   	push   %eax
8010368f:	e8 6c 0b 00 00       	call   80104200 <wakeup>
80103694:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103697:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010369d:	85 d2                	test   %edx,%edx
8010369f:	75 0a                	jne    801036ab <pipeclose+0x4b>
801036a1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801036a7:	85 c0                	test   %eax,%eax
801036a9:	74 35                	je     801036e0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801036ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801036ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801036b1:	5b                   	pop    %ebx
801036b2:	5e                   	pop    %esi
801036b3:	5d                   	pop    %ebp
    release(&p->lock);
801036b4:	e9 17 10 00 00       	jmp    801046d0 <release>
801036b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801036c0:	83 ec 0c             	sub    $0xc,%esp
801036c3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801036c9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801036d0:	00 00 00 
    wakeup(&p->nwrite);
801036d3:	50                   	push   %eax
801036d4:	e8 27 0b 00 00       	call   80104200 <wakeup>
801036d9:	83 c4 10             	add    $0x10,%esp
801036dc:	eb b9                	jmp    80103697 <pipeclose+0x37>
801036de:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801036e0:	83 ec 0c             	sub    $0xc,%esp
801036e3:	53                   	push   %ebx
801036e4:	e8 e7 0f 00 00       	call   801046d0 <release>
    kfree((char*)p);
801036e9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801036ec:	83 c4 10             	add    $0x10,%esp
}
801036ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801036f2:	5b                   	pop    %ebx
801036f3:	5e                   	pop    %esi
801036f4:	5d                   	pop    %ebp
    kfree((char*)p);
801036f5:	e9 26 ef ff ff       	jmp    80102620 <kfree>
801036fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103700 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103700:	55                   	push   %ebp
80103701:	89 e5                	mov    %esp,%ebp
80103703:	57                   	push   %edi
80103704:	56                   	push   %esi
80103705:	53                   	push   %ebx
80103706:	83 ec 28             	sub    $0x28,%esp
80103709:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010370c:	53                   	push   %ebx
8010370d:	e8 9e 0e 00 00       	call   801045b0 <acquire>
  for(i = 0; i < n; i++){
80103712:	8b 45 10             	mov    0x10(%ebp),%eax
80103715:	83 c4 10             	add    $0x10,%esp
80103718:	85 c0                	test   %eax,%eax
8010371a:	0f 8e c0 00 00 00    	jle    801037e0 <pipewrite+0xe0>
80103720:	8b 45 0c             	mov    0xc(%ebp),%eax
80103723:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103729:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010372f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103732:	03 45 10             	add    0x10(%ebp),%eax
80103735:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103738:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010373e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103744:	89 ca                	mov    %ecx,%edx
80103746:	05 00 02 00 00       	add    $0x200,%eax
8010374b:	39 c1                	cmp    %eax,%ecx
8010374d:	74 3f                	je     8010378e <pipewrite+0x8e>
8010374f:	eb 67                	jmp    801037b8 <pipewrite+0xb8>
80103751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103758:	e8 53 03 00 00       	call   80103ab0 <myproc>
8010375d:	8b 48 24             	mov    0x24(%eax),%ecx
80103760:	85 c9                	test   %ecx,%ecx
80103762:	75 34                	jne    80103798 <pipewrite+0x98>
      wakeup(&p->nread);
80103764:	83 ec 0c             	sub    $0xc,%esp
80103767:	57                   	push   %edi
80103768:	e8 93 0a 00 00       	call   80104200 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010376d:	58                   	pop    %eax
8010376e:	5a                   	pop    %edx
8010376f:	53                   	push   %ebx
80103770:	56                   	push   %esi
80103771:	e8 da 08 00 00       	call   80104050 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103776:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010377c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103782:	83 c4 10             	add    $0x10,%esp
80103785:	05 00 02 00 00       	add    $0x200,%eax
8010378a:	39 c2                	cmp    %eax,%edx
8010378c:	75 2a                	jne    801037b8 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010378e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103794:	85 c0                	test   %eax,%eax
80103796:	75 c0                	jne    80103758 <pipewrite+0x58>
        release(&p->lock);
80103798:	83 ec 0c             	sub    $0xc,%esp
8010379b:	53                   	push   %ebx
8010379c:	e8 2f 0f 00 00       	call   801046d0 <release>
        return -1;
801037a1:	83 c4 10             	add    $0x10,%esp
801037a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801037a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037ac:	5b                   	pop    %ebx
801037ad:	5e                   	pop    %esi
801037ae:	5f                   	pop    %edi
801037af:	5d                   	pop    %ebp
801037b0:	c3                   	ret    
801037b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801037b8:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801037bb:	8d 4a 01             	lea    0x1(%edx),%ecx
801037be:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801037c4:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
801037ca:	0f b6 06             	movzbl (%esi),%eax
801037cd:	83 c6 01             	add    $0x1,%esi
801037d0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801037d3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801037d7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801037da:	0f 85 58 ff ff ff    	jne    80103738 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801037e0:	83 ec 0c             	sub    $0xc,%esp
801037e3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801037e9:	50                   	push   %eax
801037ea:	e8 11 0a 00 00       	call   80104200 <wakeup>
  release(&p->lock);
801037ef:	89 1c 24             	mov    %ebx,(%esp)
801037f2:	e8 d9 0e 00 00       	call   801046d0 <release>
  return n;
801037f7:	8b 45 10             	mov    0x10(%ebp),%eax
801037fa:	83 c4 10             	add    $0x10,%esp
801037fd:	eb aa                	jmp    801037a9 <pipewrite+0xa9>
801037ff:	90                   	nop

80103800 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	57                   	push   %edi
80103804:	56                   	push   %esi
80103805:	53                   	push   %ebx
80103806:	83 ec 18             	sub    $0x18,%esp
80103809:	8b 75 08             	mov    0x8(%ebp),%esi
8010380c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010380f:	56                   	push   %esi
80103810:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103816:	e8 95 0d 00 00       	call   801045b0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010381b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103821:	83 c4 10             	add    $0x10,%esp
80103824:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010382a:	74 2f                	je     8010385b <piperead+0x5b>
8010382c:	eb 37                	jmp    80103865 <piperead+0x65>
8010382e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103830:	e8 7b 02 00 00       	call   80103ab0 <myproc>
80103835:	8b 48 24             	mov    0x24(%eax),%ecx
80103838:	85 c9                	test   %ecx,%ecx
8010383a:	0f 85 80 00 00 00    	jne    801038c0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103840:	83 ec 08             	sub    $0x8,%esp
80103843:	56                   	push   %esi
80103844:	53                   	push   %ebx
80103845:	e8 06 08 00 00       	call   80104050 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010384a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103850:	83 c4 10             	add    $0x10,%esp
80103853:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103859:	75 0a                	jne    80103865 <piperead+0x65>
8010385b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103861:	85 c0                	test   %eax,%eax
80103863:	75 cb                	jne    80103830 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103865:	8b 55 10             	mov    0x10(%ebp),%edx
80103868:	31 db                	xor    %ebx,%ebx
8010386a:	85 d2                	test   %edx,%edx
8010386c:	7f 20                	jg     8010388e <piperead+0x8e>
8010386e:	eb 2c                	jmp    8010389c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103870:	8d 48 01             	lea    0x1(%eax),%ecx
80103873:	25 ff 01 00 00       	and    $0x1ff,%eax
80103878:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010387e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103883:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103886:	83 c3 01             	add    $0x1,%ebx
80103889:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010388c:	74 0e                	je     8010389c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010388e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103894:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010389a:	75 d4                	jne    80103870 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010389c:	83 ec 0c             	sub    $0xc,%esp
8010389f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801038a5:	50                   	push   %eax
801038a6:	e8 55 09 00 00       	call   80104200 <wakeup>
  release(&p->lock);
801038ab:	89 34 24             	mov    %esi,(%esp)
801038ae:	e8 1d 0e 00 00       	call   801046d0 <release>
  return i;
801038b3:	83 c4 10             	add    $0x10,%esp
}
801038b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038b9:	89 d8                	mov    %ebx,%eax
801038bb:	5b                   	pop    %ebx
801038bc:	5e                   	pop    %esi
801038bd:	5f                   	pop    %edi
801038be:	5d                   	pop    %ebp
801038bf:	c3                   	ret    
      release(&p->lock);
801038c0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801038c3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801038c8:	56                   	push   %esi
801038c9:	e8 02 0e 00 00       	call   801046d0 <release>
      return -1;
801038ce:	83 c4 10             	add    $0x10,%esp
}
801038d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038d4:	89 d8                	mov    %ebx,%eax
801038d6:	5b                   	pop    %ebx
801038d7:	5e                   	pop    %esi
801038d8:	5f                   	pop    %edi
801038d9:	5d                   	pop    %ebp
801038da:	c3                   	ret    
801038db:	66 90                	xchg   %ax,%ax
801038dd:	66 90                	xchg   %ax,%ax
801038df:	90                   	nop

801038e0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038e4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801038e9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801038ec:	68 20 2d 11 80       	push   $0x80112d20
801038f1:	e8 ba 0c 00 00       	call   801045b0 <acquire>
801038f6:	83 c4 10             	add    $0x10,%esp
801038f9:	eb 10                	jmp    8010390b <allocproc+0x2b>
801038fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038ff:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103900:	83 c3 7c             	add    $0x7c,%ebx
80103903:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103909:	74 75                	je     80103980 <allocproc+0xa0>
    if(p->state == UNUSED)
8010390b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010390e:	85 c0                	test   %eax,%eax
80103910:	75 ee                	jne    80103900 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103912:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103917:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010391a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103921:	89 43 10             	mov    %eax,0x10(%ebx)
80103924:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103927:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
8010392c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103932:	e8 99 0d 00 00       	call   801046d0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103937:	e8 a4 ee ff ff       	call   801027e0 <kalloc>
8010393c:	83 c4 10             	add    $0x10,%esp
8010393f:	89 43 08             	mov    %eax,0x8(%ebx)
80103942:	85 c0                	test   %eax,%eax
80103944:	74 53                	je     80103999 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103946:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010394c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010394f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103954:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103957:	c7 40 14 bd 58 10 80 	movl   $0x801058bd,0x14(%eax)
  p->context = (struct context*)sp;
8010395e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103961:	6a 14                	push   $0x14
80103963:	6a 00                	push   $0x0
80103965:	50                   	push   %eax
80103966:	e8 b5 0d 00 00       	call   80104720 <memset>
  p->context->eip = (uint)forkret;
8010396b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010396e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103971:	c7 40 10 b0 39 10 80 	movl   $0x801039b0,0x10(%eax)
}
80103978:	89 d8                	mov    %ebx,%eax
8010397a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010397d:	c9                   	leave  
8010397e:	c3                   	ret    
8010397f:	90                   	nop
  release(&ptable.lock);
80103980:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103983:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103985:	68 20 2d 11 80       	push   $0x80112d20
8010398a:	e8 41 0d 00 00       	call   801046d0 <release>
}
8010398f:	89 d8                	mov    %ebx,%eax
  return 0;
80103991:	83 c4 10             	add    $0x10,%esp
}
80103994:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103997:	c9                   	leave  
80103998:	c3                   	ret    
    p->state = UNUSED;
80103999:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801039a0:	31 db                	xor    %ebx,%ebx
}
801039a2:	89 d8                	mov    %ebx,%eax
801039a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039a7:	c9                   	leave  
801039a8:	c3                   	ret    
801039a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801039b0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801039b6:	68 20 2d 11 80       	push   $0x80112d20
801039bb:	e8 10 0d 00 00       	call   801046d0 <release>

  if (first) {
801039c0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801039c5:	83 c4 10             	add    $0x10,%esp
801039c8:	85 c0                	test   %eax,%eax
801039ca:	75 04                	jne    801039d0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801039cc:	c9                   	leave  
801039cd:	c3                   	ret    
801039ce:	66 90                	xchg   %ax,%ax
    first = 0;
801039d0:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801039d7:	00 00 00 
    iinit(ROOTDEV);
801039da:	83 ec 0c             	sub    $0xc,%esp
801039dd:	6a 01                	push   $0x1
801039df:	e8 2c db ff ff       	call   80101510 <iinit>
    initlog(ROOTDEV);
801039e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801039eb:	e8 30 f4 ff ff       	call   80102e20 <initlog>
}
801039f0:	83 c4 10             	add    $0x10,%esp
801039f3:	c9                   	leave  
801039f4:	c3                   	ret    
801039f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103a00 <pinit>:
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103a06:	68 20 77 10 80       	push   $0x80107720
80103a0b:	68 20 2d 11 80       	push   $0x80112d20
80103a10:	e8 9b 0a 00 00       	call   801044b0 <initlock>
}
80103a15:	83 c4 10             	add    $0x10,%esp
80103a18:	c9                   	leave  
80103a19:	c3                   	ret    
80103a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a20 <mycpu>:
{
80103a20:	55                   	push   %ebp
80103a21:	89 e5                	mov    %esp,%ebp
80103a23:	56                   	push   %esi
80103a24:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103a25:	9c                   	pushf  
80103a26:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103a27:	f6 c4 02             	test   $0x2,%ah
80103a2a:	75 4e                	jne    80103a7a <mycpu+0x5a>
  apicid = lapicid();
80103a2c:	e8 1f f0 ff ff       	call   80102a50 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103a31:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
  apicid = lapicid();
80103a37:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
80103a39:	85 f6                	test   %esi,%esi
80103a3b:	7e 30                	jle    80103a6d <mycpu+0x4d>
80103a3d:	31 d2                	xor    %edx,%edx
80103a3f:	eb 0e                	jmp    80103a4f <mycpu+0x2f>
80103a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a48:	83 c2 01             	add    $0x1,%edx
80103a4b:	39 f2                	cmp    %esi,%edx
80103a4d:	74 1e                	je     80103a6d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80103a4f:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103a55:	0f b6 81 80 27 11 80 	movzbl -0x7feed880(%ecx),%eax
80103a5c:	39 d8                	cmp    %ebx,%eax
80103a5e:	75 e8                	jne    80103a48 <mycpu+0x28>
}
80103a60:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103a63:	8d 81 80 27 11 80    	lea    -0x7feed880(%ecx),%eax
}
80103a69:	5b                   	pop    %ebx
80103a6a:	5e                   	pop    %esi
80103a6b:	5d                   	pop    %ebp
80103a6c:	c3                   	ret    
  panic("unknown apicid\n");
80103a6d:	83 ec 0c             	sub    $0xc,%esp
80103a70:	68 27 77 10 80       	push   $0x80107727
80103a75:	e8 06 c9 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103a7a:	83 ec 0c             	sub    $0xc,%esp
80103a7d:	68 04 78 10 80       	push   $0x80107804
80103a82:	e8 f9 c8 ff ff       	call   80100380 <panic>
80103a87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a8e:	66 90                	xchg   %ax,%ax

80103a90 <cpuid>:
cpuid() {
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103a96:	e8 85 ff ff ff       	call   80103a20 <mycpu>
}
80103a9b:	c9                   	leave  
  return mycpu()-cpus;
80103a9c:	2d 80 27 11 80       	sub    $0x80112780,%eax
80103aa1:	c1 f8 04             	sar    $0x4,%eax
80103aa4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103aaa:	c3                   	ret    
80103aab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103aaf:	90                   	nop

80103ab0 <myproc>:
myproc(void) {
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	53                   	push   %ebx
80103ab4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103ab7:	e8 a4 0a 00 00       	call   80104560 <pushcli>
  c = mycpu();
80103abc:	e8 5f ff ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80103ac1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ac7:	e8 a4 0b 00 00       	call   80104670 <popcli>
}
80103acc:	83 c4 04             	add    $0x4,%esp
80103acf:	89 d8                	mov    %ebx,%eax
80103ad1:	5b                   	pop    %ebx
80103ad2:	5d                   	pop    %ebp
80103ad3:	c3                   	ret    
80103ad4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103adb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103adf:	90                   	nop

80103ae0 <userinit>:
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	53                   	push   %ebx
80103ae4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103ae7:	e8 f4 fd ff ff       	call   801038e0 <allocproc>
80103aec:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103aee:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103af3:	e8 68 33 00 00       	call   80106e60 <setupkvm>
80103af8:	89 43 04             	mov    %eax,0x4(%ebx)
80103afb:	85 c0                	test   %eax,%eax
80103afd:	0f 84 bd 00 00 00    	je     80103bc0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b03:	83 ec 04             	sub    $0x4,%esp
80103b06:	68 2c 00 00 00       	push   $0x2c
80103b0b:	68 60 a4 10 80       	push   $0x8010a460
80103b10:	50                   	push   %eax
80103b11:	e8 2a 30 00 00       	call   80106b40 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103b16:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103b19:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103b1f:	6a 4c                	push   $0x4c
80103b21:	6a 00                	push   $0x0
80103b23:	ff 73 18             	pushl  0x18(%ebx)
80103b26:	e8 f5 0b 00 00       	call   80104720 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b2b:	8b 43 18             	mov    0x18(%ebx),%eax
80103b2e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b33:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b36:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b3b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b3f:	8b 43 18             	mov    0x18(%ebx),%eax
80103b42:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103b46:	8b 43 18             	mov    0x18(%ebx),%eax
80103b49:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b4d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103b51:	8b 43 18             	mov    0x18(%ebx),%eax
80103b54:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b58:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103b5c:	8b 43 18             	mov    0x18(%ebx),%eax
80103b5f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103b66:	8b 43 18             	mov    0x18(%ebx),%eax
80103b69:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103b70:	8b 43 18             	mov    0x18(%ebx),%eax
80103b73:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b7a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b7d:	6a 10                	push   $0x10
80103b7f:	68 50 77 10 80       	push   $0x80107750
80103b84:	50                   	push   %eax
80103b85:	e8 56 0d 00 00       	call   801048e0 <safestrcpy>
  p->cwd = namei("/");
80103b8a:	c7 04 24 59 77 10 80 	movl   $0x80107759,(%esp)
80103b91:	e8 1a e4 ff ff       	call   80101fb0 <namei>
80103b96:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103b99:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ba0:	e8 0b 0a 00 00       	call   801045b0 <acquire>
  p->state = RUNNABLE;
80103ba5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103bac:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103bb3:	e8 18 0b 00 00       	call   801046d0 <release>
}
80103bb8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bbb:	83 c4 10             	add    $0x10,%esp
80103bbe:	c9                   	leave  
80103bbf:	c3                   	ret    
    panic("userinit: out of memory?");
80103bc0:	83 ec 0c             	sub    $0xc,%esp
80103bc3:	68 37 77 10 80       	push   $0x80107737
80103bc8:	e8 b3 c7 ff ff       	call   80100380 <panic>
80103bcd:	8d 76 00             	lea    0x0(%esi),%esi

80103bd0 <growproc>:
{
80103bd0:	55                   	push   %ebp
80103bd1:	89 e5                	mov    %esp,%ebp
80103bd3:	56                   	push   %esi
80103bd4:	53                   	push   %ebx
80103bd5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103bd8:	e8 83 09 00 00       	call   80104560 <pushcli>
  c = mycpu();
80103bdd:	e8 3e fe ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80103be2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103be8:	e8 83 0a 00 00       	call   80104670 <popcli>
  sz = curproc->sz;
80103bed:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103bef:	85 f6                	test   %esi,%esi
80103bf1:	7f 1d                	jg     80103c10 <growproc+0x40>
  } else if(n < 0){
80103bf3:	75 3b                	jne    80103c30 <growproc+0x60>
  switchuvm(curproc);
80103bf5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103bf8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103bfa:	53                   	push   %ebx
80103bfb:	e8 30 2e 00 00       	call   80106a30 <switchuvm>
  return 0;
80103c00:	83 c4 10             	add    $0x10,%esp
80103c03:	31 c0                	xor    %eax,%eax
}
80103c05:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c08:	5b                   	pop    %ebx
80103c09:	5e                   	pop    %esi
80103c0a:	5d                   	pop    %ebp
80103c0b:	c3                   	ret    
80103c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c10:	83 ec 04             	sub    $0x4,%esp
80103c13:	01 c6                	add    %eax,%esi
80103c15:	56                   	push   %esi
80103c16:	50                   	push   %eax
80103c17:	ff 73 04             	pushl  0x4(%ebx)
80103c1a:	e8 61 30 00 00       	call   80106c80 <allocuvm>
80103c1f:	83 c4 10             	add    $0x10,%esp
80103c22:	85 c0                	test   %eax,%eax
80103c24:	75 cf                	jne    80103bf5 <growproc+0x25>
      return -1;
80103c26:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c2b:	eb d8                	jmp    80103c05 <growproc+0x35>
80103c2d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c30:	83 ec 04             	sub    $0x4,%esp
80103c33:	01 c6                	add    %eax,%esi
80103c35:	56                   	push   %esi
80103c36:	50                   	push   %eax
80103c37:	ff 73 04             	pushl  0x4(%ebx)
80103c3a:	e8 71 31 00 00       	call   80106db0 <deallocuvm>
80103c3f:	83 c4 10             	add    $0x10,%esp
80103c42:	85 c0                	test   %eax,%eax
80103c44:	75 af                	jne    80103bf5 <growproc+0x25>
80103c46:	eb de                	jmp    80103c26 <growproc+0x56>
80103c48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c4f:	90                   	nop

80103c50 <fork>:
{
80103c50:	55                   	push   %ebp
80103c51:	89 e5                	mov    %esp,%ebp
80103c53:	57                   	push   %edi
80103c54:	56                   	push   %esi
80103c55:	53                   	push   %ebx
80103c56:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103c59:	e8 02 09 00 00       	call   80104560 <pushcli>
  c = mycpu();
80103c5e:	e8 bd fd ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80103c63:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c69:	e8 02 0a 00 00       	call   80104670 <popcli>
  if((np = allocproc()) == 0){
80103c6e:	e8 6d fc ff ff       	call   801038e0 <allocproc>
80103c73:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c76:	85 c0                	test   %eax,%eax
80103c78:	0f 84 b7 00 00 00    	je     80103d35 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103c7e:	83 ec 08             	sub    $0x8,%esp
80103c81:	ff 33                	pushl  (%ebx)
80103c83:	89 c7                	mov    %eax,%edi
80103c85:	ff 73 04             	pushl  0x4(%ebx)
80103c88:	e8 a3 32 00 00       	call   80106f30 <copyuvm>
80103c8d:	83 c4 10             	add    $0x10,%esp
80103c90:	89 47 04             	mov    %eax,0x4(%edi)
80103c93:	85 c0                	test   %eax,%eax
80103c95:	0f 84 a1 00 00 00    	je     80103d3c <fork+0xec>
  np->sz = curproc->sz;
80103c9b:	8b 03                	mov    (%ebx),%eax
80103c9d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103ca0:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103ca2:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103ca5:	89 c8                	mov    %ecx,%eax
80103ca7:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103caa:	b9 13 00 00 00       	mov    $0x13,%ecx
80103caf:	8b 73 18             	mov    0x18(%ebx),%esi
80103cb2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103cb4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103cb6:	8b 40 18             	mov    0x18(%eax),%eax
80103cb9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103cc0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103cc4:	85 c0                	test   %eax,%eax
80103cc6:	74 13                	je     80103cdb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103cc8:	83 ec 0c             	sub    $0xc,%esp
80103ccb:	50                   	push   %eax
80103ccc:	e8 8f d1 ff ff       	call   80100e60 <filedup>
80103cd1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103cd4:	83 c4 10             	add    $0x10,%esp
80103cd7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103cdb:	83 c6 01             	add    $0x1,%esi
80103cde:	83 fe 10             	cmp    $0x10,%esi
80103ce1:	75 dd                	jne    80103cc0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103ce3:	83 ec 0c             	sub    $0xc,%esp
80103ce6:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ce9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103cec:	e8 ef d9 ff ff       	call   801016e0 <idup>
80103cf1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cf4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103cf7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cfa:	8d 47 6c             	lea    0x6c(%edi),%eax
80103cfd:	6a 10                	push   $0x10
80103cff:	53                   	push   %ebx
80103d00:	50                   	push   %eax
80103d01:	e8 da 0b 00 00       	call   801048e0 <safestrcpy>
  pid = np->pid;
80103d06:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103d09:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d10:	e8 9b 08 00 00       	call   801045b0 <acquire>
  np->state = RUNNABLE;
80103d15:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103d1c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d23:	e8 a8 09 00 00       	call   801046d0 <release>
  return pid;
80103d28:	83 c4 10             	add    $0x10,%esp
}
80103d2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d2e:	89 d8                	mov    %ebx,%eax
80103d30:	5b                   	pop    %ebx
80103d31:	5e                   	pop    %esi
80103d32:	5f                   	pop    %edi
80103d33:	5d                   	pop    %ebp
80103d34:	c3                   	ret    
    return -1;
80103d35:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103d3a:	eb ef                	jmp    80103d2b <fork+0xdb>
    kfree(np->kstack);
80103d3c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103d3f:	83 ec 0c             	sub    $0xc,%esp
80103d42:	ff 73 08             	pushl  0x8(%ebx)
80103d45:	e8 d6 e8 ff ff       	call   80102620 <kfree>
    np->kstack = 0;
80103d4a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103d51:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103d54:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103d5b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103d60:	eb c9                	jmp    80103d2b <fork+0xdb>
80103d62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d70 <scheduler>:
{
80103d70:	55                   	push   %ebp
80103d71:	89 e5                	mov    %esp,%ebp
80103d73:	57                   	push   %edi
80103d74:	56                   	push   %esi
80103d75:	53                   	push   %ebx
80103d76:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103d79:	e8 a2 fc ff ff       	call   80103a20 <mycpu>
  c->proc = 0;
80103d7e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103d85:	00 00 00 
  struct cpu *c = mycpu();
80103d88:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103d8a:	8d 78 04             	lea    0x4(%eax),%edi
80103d8d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103d90:	fb                   	sti    
    acquire(&ptable.lock);
80103d91:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d94:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103d99:	68 20 2d 11 80       	push   $0x80112d20
80103d9e:	e8 0d 08 00 00       	call   801045b0 <acquire>
80103da3:	83 c4 10             	add    $0x10,%esp
80103da6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dad:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103db0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103db4:	75 33                	jne    80103de9 <scheduler+0x79>
      switchuvm(p);
80103db6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103db9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103dbf:	53                   	push   %ebx
80103dc0:	e8 6b 2c 00 00       	call   80106a30 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103dc5:	58                   	pop    %eax
80103dc6:	5a                   	pop    %edx
80103dc7:	ff 73 1c             	pushl  0x1c(%ebx)
80103dca:	57                   	push   %edi
      p->state = RUNNING;
80103dcb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103dd2:	e8 64 0b 00 00       	call   8010493b <swtch>
      switchkvm();
80103dd7:	e8 44 2c 00 00       	call   80106a20 <switchkvm>
      c->proc = 0;
80103ddc:	83 c4 10             	add    $0x10,%esp
80103ddf:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103de6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103de9:	83 c3 7c             	add    $0x7c,%ebx
80103dec:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103df2:	75 bc                	jne    80103db0 <scheduler+0x40>
    release(&ptable.lock);
80103df4:	83 ec 0c             	sub    $0xc,%esp
80103df7:	68 20 2d 11 80       	push   $0x80112d20
80103dfc:	e8 cf 08 00 00       	call   801046d0 <release>
    sti();
80103e01:	83 c4 10             	add    $0x10,%esp
80103e04:	eb 8a                	jmp    80103d90 <scheduler+0x20>
80103e06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e0d:	8d 76 00             	lea    0x0(%esi),%esi

80103e10 <sched>:
{
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	56                   	push   %esi
80103e14:	53                   	push   %ebx
  pushcli();
80103e15:	e8 46 07 00 00       	call   80104560 <pushcli>
  c = mycpu();
80103e1a:	e8 01 fc ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80103e1f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e25:	e8 46 08 00 00       	call   80104670 <popcli>
  if(!holding(&ptable.lock))
80103e2a:	83 ec 0c             	sub    $0xc,%esp
80103e2d:	68 20 2d 11 80       	push   $0x80112d20
80103e32:	e8 e9 06 00 00       	call   80104520 <holding>
80103e37:	83 c4 10             	add    $0x10,%esp
80103e3a:	85 c0                	test   %eax,%eax
80103e3c:	74 4f                	je     80103e8d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103e3e:	e8 dd fb ff ff       	call   80103a20 <mycpu>
80103e43:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103e4a:	75 68                	jne    80103eb4 <sched+0xa4>
  if(p->state == RUNNING)
80103e4c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103e50:	74 55                	je     80103ea7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e52:	9c                   	pushf  
80103e53:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e54:	f6 c4 02             	test   $0x2,%ah
80103e57:	75 41                	jne    80103e9a <sched+0x8a>
  intena = mycpu()->intena;
80103e59:	e8 c2 fb ff ff       	call   80103a20 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103e5e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103e61:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103e67:	e8 b4 fb ff ff       	call   80103a20 <mycpu>
80103e6c:	83 ec 08             	sub    $0x8,%esp
80103e6f:	ff 70 04             	pushl  0x4(%eax)
80103e72:	53                   	push   %ebx
80103e73:	e8 c3 0a 00 00       	call   8010493b <swtch>
  mycpu()->intena = intena;
80103e78:	e8 a3 fb ff ff       	call   80103a20 <mycpu>
}
80103e7d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103e80:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e86:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e89:	5b                   	pop    %ebx
80103e8a:	5e                   	pop    %esi
80103e8b:	5d                   	pop    %ebp
80103e8c:	c3                   	ret    
    panic("sched ptable.lock");
80103e8d:	83 ec 0c             	sub    $0xc,%esp
80103e90:	68 5b 77 10 80       	push   $0x8010775b
80103e95:	e8 e6 c4 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103e9a:	83 ec 0c             	sub    $0xc,%esp
80103e9d:	68 87 77 10 80       	push   $0x80107787
80103ea2:	e8 d9 c4 ff ff       	call   80100380 <panic>
    panic("sched running");
80103ea7:	83 ec 0c             	sub    $0xc,%esp
80103eaa:	68 79 77 10 80       	push   $0x80107779
80103eaf:	e8 cc c4 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103eb4:	83 ec 0c             	sub    $0xc,%esp
80103eb7:	68 6d 77 10 80       	push   $0x8010776d
80103ebc:	e8 bf c4 ff ff       	call   80100380 <panic>
80103ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ec8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ecf:	90                   	nop

80103ed0 <exit>:
{
80103ed0:	55                   	push   %ebp
80103ed1:	89 e5                	mov    %esp,%ebp
80103ed3:	57                   	push   %edi
80103ed4:	56                   	push   %esi
80103ed5:	53                   	push   %ebx
80103ed6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103ed9:	e8 82 06 00 00       	call   80104560 <pushcli>
  c = mycpu();
80103ede:	e8 3d fb ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80103ee3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103ee9:	e8 82 07 00 00       	call   80104670 <popcli>
  if(curproc == initproc)
80103eee:	8d 5e 28             	lea    0x28(%esi),%ebx
80103ef1:	8d 7e 68             	lea    0x68(%esi),%edi
80103ef4:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103efa:	0f 84 e7 00 00 00    	je     80103fe7 <exit+0x117>
    if(curproc->ofile[fd]){
80103f00:	8b 03                	mov    (%ebx),%eax
80103f02:	85 c0                	test   %eax,%eax
80103f04:	74 12                	je     80103f18 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103f06:	83 ec 0c             	sub    $0xc,%esp
80103f09:	50                   	push   %eax
80103f0a:	e8 a1 cf ff ff       	call   80100eb0 <fileclose>
      curproc->ofile[fd] = 0;
80103f0f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103f15:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103f18:	83 c3 04             	add    $0x4,%ebx
80103f1b:	39 df                	cmp    %ebx,%edi
80103f1d:	75 e1                	jne    80103f00 <exit+0x30>
  begin_op();
80103f1f:	e8 9c ef ff ff       	call   80102ec0 <begin_op>
  iput(curproc->cwd);
80103f24:	83 ec 0c             	sub    $0xc,%esp
80103f27:	ff 76 68             	pushl  0x68(%esi)
80103f2a:	e8 11 d9 ff ff       	call   80101840 <iput>
  end_op();
80103f2f:	e8 fc ef ff ff       	call   80102f30 <end_op>
  curproc->cwd = 0;
80103f34:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103f3b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f42:	e8 69 06 00 00       	call   801045b0 <acquire>
  wakeup1(curproc->parent);
80103f47:	8b 56 14             	mov    0x14(%esi),%edx
80103f4a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f4d:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103f52:	eb 0e                	jmp    80103f62 <exit+0x92>
80103f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f58:	83 c0 7c             	add    $0x7c,%eax
80103f5b:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103f60:	74 1c                	je     80103f7e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103f62:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f66:	75 f0                	jne    80103f58 <exit+0x88>
80103f68:	3b 50 20             	cmp    0x20(%eax),%edx
80103f6b:	75 eb                	jne    80103f58 <exit+0x88>
      p->state = RUNNABLE;
80103f6d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f74:	83 c0 7c             	add    $0x7c,%eax
80103f77:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103f7c:	75 e4                	jne    80103f62 <exit+0x92>
      p->parent = initproc;
80103f7e:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f84:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103f89:	eb 10                	jmp    80103f9b <exit+0xcb>
80103f8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f8f:	90                   	nop
80103f90:	83 c2 7c             	add    $0x7c,%edx
80103f93:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103f99:	74 33                	je     80103fce <exit+0xfe>
    if(p->parent == curproc){
80103f9b:	39 72 14             	cmp    %esi,0x14(%edx)
80103f9e:	75 f0                	jne    80103f90 <exit+0xc0>
      if(p->state == ZOMBIE)
80103fa0:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103fa4:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103fa7:	75 e7                	jne    80103f90 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fa9:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103fae:	eb 0a                	jmp    80103fba <exit+0xea>
80103fb0:	83 c0 7c             	add    $0x7c,%eax
80103fb3:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103fb8:	74 d6                	je     80103f90 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103fba:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103fbe:	75 f0                	jne    80103fb0 <exit+0xe0>
80103fc0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103fc3:	75 eb                	jne    80103fb0 <exit+0xe0>
      p->state = RUNNABLE;
80103fc5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103fcc:	eb e2                	jmp    80103fb0 <exit+0xe0>
  curproc->state = ZOMBIE;
80103fce:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103fd5:	e8 36 fe ff ff       	call   80103e10 <sched>
  panic("zombie exit");
80103fda:	83 ec 0c             	sub    $0xc,%esp
80103fdd:	68 a8 77 10 80       	push   $0x801077a8
80103fe2:	e8 99 c3 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103fe7:	83 ec 0c             	sub    $0xc,%esp
80103fea:	68 9b 77 10 80       	push   $0x8010779b
80103fef:	e8 8c c3 ff ff       	call   80100380 <panic>
80103ff4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ffb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fff:	90                   	nop

80104000 <yield>:
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	53                   	push   %ebx
80104004:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104007:	68 20 2d 11 80       	push   $0x80112d20
8010400c:	e8 9f 05 00 00       	call   801045b0 <acquire>
  pushcli();
80104011:	e8 4a 05 00 00       	call   80104560 <pushcli>
  c = mycpu();
80104016:	e8 05 fa ff ff       	call   80103a20 <mycpu>
  p = c->proc;
8010401b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104021:	e8 4a 06 00 00       	call   80104670 <popcli>
  myproc()->state = RUNNABLE;
80104026:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010402d:	e8 de fd ff ff       	call   80103e10 <sched>
  release(&ptable.lock);
80104032:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104039:	e8 92 06 00 00       	call   801046d0 <release>
}
8010403e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104041:	83 c4 10             	add    $0x10,%esp
80104044:	c9                   	leave  
80104045:	c3                   	ret    
80104046:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010404d:	8d 76 00             	lea    0x0(%esi),%esi

80104050 <sleep>:
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	57                   	push   %edi
80104054:	56                   	push   %esi
80104055:	53                   	push   %ebx
80104056:	83 ec 0c             	sub    $0xc,%esp
80104059:	8b 7d 08             	mov    0x8(%ebp),%edi
8010405c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010405f:	e8 fc 04 00 00       	call   80104560 <pushcli>
  c = mycpu();
80104064:	e8 b7 f9 ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80104069:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010406f:	e8 fc 05 00 00       	call   80104670 <popcli>
  if(p == 0)
80104074:	85 db                	test   %ebx,%ebx
80104076:	0f 84 87 00 00 00    	je     80104103 <sleep+0xb3>
  if(lk == 0)
8010407c:	85 f6                	test   %esi,%esi
8010407e:	74 76                	je     801040f6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104080:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80104086:	74 50                	je     801040d8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104088:	83 ec 0c             	sub    $0xc,%esp
8010408b:	68 20 2d 11 80       	push   $0x80112d20
80104090:	e8 1b 05 00 00       	call   801045b0 <acquire>
    release(lk);
80104095:	89 34 24             	mov    %esi,(%esp)
80104098:	e8 33 06 00 00       	call   801046d0 <release>
  p->chan = chan;
8010409d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801040a0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801040a7:	e8 64 fd ff ff       	call   80103e10 <sched>
  p->chan = 0;
801040ac:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801040b3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801040ba:	e8 11 06 00 00       	call   801046d0 <release>
    acquire(lk);
801040bf:	89 75 08             	mov    %esi,0x8(%ebp)
801040c2:	83 c4 10             	add    $0x10,%esp
}
801040c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040c8:	5b                   	pop    %ebx
801040c9:	5e                   	pop    %esi
801040ca:	5f                   	pop    %edi
801040cb:	5d                   	pop    %ebp
    acquire(lk);
801040cc:	e9 df 04 00 00       	jmp    801045b0 <acquire>
801040d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801040d8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801040db:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801040e2:	e8 29 fd ff ff       	call   80103e10 <sched>
  p->chan = 0;
801040e7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801040ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040f1:	5b                   	pop    %ebx
801040f2:	5e                   	pop    %esi
801040f3:	5f                   	pop    %edi
801040f4:	5d                   	pop    %ebp
801040f5:	c3                   	ret    
    panic("sleep without lk");
801040f6:	83 ec 0c             	sub    $0xc,%esp
801040f9:	68 ba 77 10 80       	push   $0x801077ba
801040fe:	e8 7d c2 ff ff       	call   80100380 <panic>
    panic("sleep");
80104103:	83 ec 0c             	sub    $0xc,%esp
80104106:	68 b4 77 10 80       	push   $0x801077b4
8010410b:	e8 70 c2 ff ff       	call   80100380 <panic>

80104110 <wait>:
{
80104110:	55                   	push   %ebp
80104111:	89 e5                	mov    %esp,%ebp
80104113:	56                   	push   %esi
80104114:	53                   	push   %ebx
  pushcli();
80104115:	e8 46 04 00 00       	call   80104560 <pushcli>
  c = mycpu();
8010411a:	e8 01 f9 ff ff       	call   80103a20 <mycpu>
  p = c->proc;
8010411f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104125:	e8 46 05 00 00       	call   80104670 <popcli>
  acquire(&ptable.lock);
8010412a:	83 ec 0c             	sub    $0xc,%esp
8010412d:	68 20 2d 11 80       	push   $0x80112d20
80104132:	e8 79 04 00 00       	call   801045b0 <acquire>
80104137:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010413a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010413c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80104141:	eb 10                	jmp    80104153 <wait+0x43>
80104143:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104147:	90                   	nop
80104148:	83 c3 7c             	add    $0x7c,%ebx
8010414b:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80104151:	74 1b                	je     8010416e <wait+0x5e>
      if(p->parent != curproc)
80104153:	39 73 14             	cmp    %esi,0x14(%ebx)
80104156:	75 f0                	jne    80104148 <wait+0x38>
      if(p->state == ZOMBIE){
80104158:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010415c:	74 32                	je     80104190 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010415e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104161:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104166:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
8010416c:	75 e5                	jne    80104153 <wait+0x43>
    if(!havekids || curproc->killed){
8010416e:	85 c0                	test   %eax,%eax
80104170:	74 74                	je     801041e6 <wait+0xd6>
80104172:	8b 46 24             	mov    0x24(%esi),%eax
80104175:	85 c0                	test   %eax,%eax
80104177:	75 6d                	jne    801041e6 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104179:	83 ec 08             	sub    $0x8,%esp
8010417c:	68 20 2d 11 80       	push   $0x80112d20
80104181:	56                   	push   %esi
80104182:	e8 c9 fe ff ff       	call   80104050 <sleep>
    havekids = 0;
80104187:	83 c4 10             	add    $0x10,%esp
8010418a:	eb ae                	jmp    8010413a <wait+0x2a>
8010418c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104190:	83 ec 0c             	sub    $0xc,%esp
80104193:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104196:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104199:	e8 82 e4 ff ff       	call   80102620 <kfree>
        freevm(p->pgdir);
8010419e:	5a                   	pop    %edx
8010419f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801041a2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801041a9:	e8 32 2c 00 00       	call   80106de0 <freevm>
        release(&ptable.lock);
801041ae:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p->pid = 0;
801041b5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801041bc:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801041c3:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801041c7:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801041ce:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801041d5:	e8 f6 04 00 00       	call   801046d0 <release>
        return pid;
801041da:	83 c4 10             	add    $0x10,%esp
}
801041dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041e0:	89 f0                	mov    %esi,%eax
801041e2:	5b                   	pop    %ebx
801041e3:	5e                   	pop    %esi
801041e4:	5d                   	pop    %ebp
801041e5:	c3                   	ret    
      release(&ptable.lock);
801041e6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801041e9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801041ee:	68 20 2d 11 80       	push   $0x80112d20
801041f3:	e8 d8 04 00 00       	call   801046d0 <release>
      return -1;
801041f8:	83 c4 10             	add    $0x10,%esp
801041fb:	eb e0                	jmp    801041dd <wait+0xcd>
801041fd:	8d 76 00             	lea    0x0(%esi),%esi

80104200 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	53                   	push   %ebx
80104204:	83 ec 10             	sub    $0x10,%esp
80104207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010420a:	68 20 2d 11 80       	push   $0x80112d20
8010420f:	e8 9c 03 00 00       	call   801045b0 <acquire>
80104214:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104217:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010421c:	eb 0c                	jmp    8010422a <wakeup+0x2a>
8010421e:	66 90                	xchg   %ax,%ax
80104220:	83 c0 7c             	add    $0x7c,%eax
80104223:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104228:	74 1c                	je     80104246 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010422a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010422e:	75 f0                	jne    80104220 <wakeup+0x20>
80104230:	3b 58 20             	cmp    0x20(%eax),%ebx
80104233:	75 eb                	jne    80104220 <wakeup+0x20>
      p->state = RUNNABLE;
80104235:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010423c:	83 c0 7c             	add    $0x7c,%eax
8010423f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104244:	75 e4                	jne    8010422a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104246:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
8010424d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104250:	c9                   	leave  
  release(&ptable.lock);
80104251:	e9 7a 04 00 00       	jmp    801046d0 <release>
80104256:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010425d:	8d 76 00             	lea    0x0(%esi),%esi

80104260 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	53                   	push   %ebx
80104264:	83 ec 10             	sub    $0x10,%esp
80104267:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010426a:	68 20 2d 11 80       	push   $0x80112d20
8010426f:	e8 3c 03 00 00       	call   801045b0 <acquire>
80104274:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104277:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010427c:	eb 0c                	jmp    8010428a <kill+0x2a>
8010427e:	66 90                	xchg   %ax,%ax
80104280:	83 c0 7c             	add    $0x7c,%eax
80104283:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104288:	74 36                	je     801042c0 <kill+0x60>
    if(p->pid == pid){
8010428a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010428d:	75 f1                	jne    80104280 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010428f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104293:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010429a:	75 07                	jne    801042a3 <kill+0x43>
        p->state = RUNNABLE;
8010429c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801042a3:	83 ec 0c             	sub    $0xc,%esp
801042a6:	68 20 2d 11 80       	push   $0x80112d20
801042ab:	e8 20 04 00 00       	call   801046d0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801042b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801042b3:	83 c4 10             	add    $0x10,%esp
801042b6:	31 c0                	xor    %eax,%eax
}
801042b8:	c9                   	leave  
801042b9:	c3                   	ret    
801042ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801042c0:	83 ec 0c             	sub    $0xc,%esp
801042c3:	68 20 2d 11 80       	push   $0x80112d20
801042c8:	e8 03 04 00 00       	call   801046d0 <release>
}
801042cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801042d0:	83 c4 10             	add    $0x10,%esp
801042d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801042d8:	c9                   	leave  
801042d9:	c3                   	ret    
801042da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	57                   	push   %edi
801042e4:	56                   	push   %esi
801042e5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801042e8:	53                   	push   %ebx
801042e9:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
801042ee:	83 ec 3c             	sub    $0x3c,%esp
801042f1:	eb 24                	jmp    80104317 <procdump+0x37>
801042f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042f7:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801042f8:	83 ec 0c             	sub    $0xc,%esp
801042fb:	68 3b 7b 10 80       	push   $0x80107b3b
80104300:	e8 9b c3 ff ff       	call   801006a0 <cprintf>
80104305:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104308:	83 c3 7c             	add    $0x7c,%ebx
8010430b:	81 fb c0 4c 11 80    	cmp    $0x80114cc0,%ebx
80104311:	0f 84 81 00 00 00    	je     80104398 <procdump+0xb8>
    if(p->state == UNUSED)
80104317:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010431a:	85 c0                	test   %eax,%eax
8010431c:	74 ea                	je     80104308 <procdump+0x28>
      state = "???";
8010431e:	ba cb 77 10 80       	mov    $0x801077cb,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104323:	83 f8 05             	cmp    $0x5,%eax
80104326:	77 11                	ja     80104339 <procdump+0x59>
80104328:	8b 14 85 2c 78 10 80 	mov    -0x7fef87d4(,%eax,4),%edx
      state = "???";
8010432f:	b8 cb 77 10 80       	mov    $0x801077cb,%eax
80104334:	85 d2                	test   %edx,%edx
80104336:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104339:	53                   	push   %ebx
8010433a:	52                   	push   %edx
8010433b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010433e:	68 cf 77 10 80       	push   $0x801077cf
80104343:	e8 58 c3 ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
80104348:	83 c4 10             	add    $0x10,%esp
8010434b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010434f:	75 a7                	jne    801042f8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104351:	83 ec 08             	sub    $0x8,%esp
80104354:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104357:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010435a:	50                   	push   %eax
8010435b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010435e:	8b 40 0c             	mov    0xc(%eax),%eax
80104361:	83 c0 08             	add    $0x8,%eax
80104364:	50                   	push   %eax
80104365:	e8 66 01 00 00       	call   801044d0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010436a:	83 c4 10             	add    $0x10,%esp
8010436d:	8d 76 00             	lea    0x0(%esi),%esi
80104370:	8b 17                	mov    (%edi),%edx
80104372:	85 d2                	test   %edx,%edx
80104374:	74 82                	je     801042f8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104376:	83 ec 08             	sub    $0x8,%esp
80104379:	83 c7 04             	add    $0x4,%edi
8010437c:	52                   	push   %edx
8010437d:	68 21 71 10 80       	push   $0x80107121
80104382:	e8 19 c3 ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104387:	83 c4 10             	add    $0x10,%esp
8010438a:	39 fe                	cmp    %edi,%esi
8010438c:	75 e2                	jne    80104370 <procdump+0x90>
8010438e:	e9 65 ff ff ff       	jmp    801042f8 <procdump+0x18>
80104393:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104397:	90                   	nop
  }
}
80104398:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010439b:	5b                   	pop    %ebx
8010439c:	5e                   	pop    %esi
8010439d:	5f                   	pop    %edi
8010439e:	5d                   	pop    %ebp
8010439f:	c3                   	ret    

801043a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	53                   	push   %ebx
801043a4:	83 ec 0c             	sub    $0xc,%esp
801043a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801043aa:	68 44 78 10 80       	push   $0x80107844
801043af:	8d 43 04             	lea    0x4(%ebx),%eax
801043b2:	50                   	push   %eax
801043b3:	e8 f8 00 00 00       	call   801044b0 <initlock>
  lk->name = name;
801043b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801043bb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801043c1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801043c4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801043cb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801043ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043d1:	c9                   	leave  
801043d2:	c3                   	ret    
801043d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	56                   	push   %esi
801043e4:	53                   	push   %ebx
801043e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043e8:	8d 73 04             	lea    0x4(%ebx),%esi
801043eb:	83 ec 0c             	sub    $0xc,%esp
801043ee:	56                   	push   %esi
801043ef:	e8 bc 01 00 00       	call   801045b0 <acquire>
  while (lk->locked) {
801043f4:	8b 13                	mov    (%ebx),%edx
801043f6:	83 c4 10             	add    $0x10,%esp
801043f9:	85 d2                	test   %edx,%edx
801043fb:	74 16                	je     80104413 <acquiresleep+0x33>
801043fd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104400:	83 ec 08             	sub    $0x8,%esp
80104403:	56                   	push   %esi
80104404:	53                   	push   %ebx
80104405:	e8 46 fc ff ff       	call   80104050 <sleep>
  while (lk->locked) {
8010440a:	8b 03                	mov    (%ebx),%eax
8010440c:	83 c4 10             	add    $0x10,%esp
8010440f:	85 c0                	test   %eax,%eax
80104411:	75 ed                	jne    80104400 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104413:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104419:	e8 92 f6 ff ff       	call   80103ab0 <myproc>
8010441e:	8b 40 10             	mov    0x10(%eax),%eax
80104421:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104424:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104427:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010442a:	5b                   	pop    %ebx
8010442b:	5e                   	pop    %esi
8010442c:	5d                   	pop    %ebp
  release(&lk->lk);
8010442d:	e9 9e 02 00 00       	jmp    801046d0 <release>
80104432:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104440 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	56                   	push   %esi
80104444:	53                   	push   %ebx
80104445:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104448:	8d 73 04             	lea    0x4(%ebx),%esi
8010444b:	83 ec 0c             	sub    $0xc,%esp
8010444e:	56                   	push   %esi
8010444f:	e8 5c 01 00 00       	call   801045b0 <acquire>
  lk->locked = 0;
80104454:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010445a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104461:	89 1c 24             	mov    %ebx,(%esp)
80104464:	e8 97 fd ff ff       	call   80104200 <wakeup>
  release(&lk->lk);
80104469:	89 75 08             	mov    %esi,0x8(%ebp)
8010446c:	83 c4 10             	add    $0x10,%esp
}
8010446f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104472:	5b                   	pop    %ebx
80104473:	5e                   	pop    %esi
80104474:	5d                   	pop    %ebp
  release(&lk->lk);
80104475:	e9 56 02 00 00       	jmp    801046d0 <release>
8010447a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104480 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	56                   	push   %esi
80104484:	53                   	push   %ebx
80104485:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104488:	8d 5e 04             	lea    0x4(%esi),%ebx
8010448b:	83 ec 0c             	sub    $0xc,%esp
8010448e:	53                   	push   %ebx
8010448f:	e8 1c 01 00 00       	call   801045b0 <acquire>
  r = lk->locked;
80104494:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104496:	89 1c 24             	mov    %ebx,(%esp)
80104499:	e8 32 02 00 00       	call   801046d0 <release>
  return r;
}
8010449e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044a1:	89 f0                	mov    %esi,%eax
801044a3:	5b                   	pop    %ebx
801044a4:	5e                   	pop    %esi
801044a5:	5d                   	pop    %ebp
801044a6:	c3                   	ret    
801044a7:	66 90                	xchg   %ax,%ax
801044a9:	66 90                	xchg   %ax,%ax
801044ab:	66 90                	xchg   %ax,%ax
801044ad:	66 90                	xchg   %ax,%ax
801044af:	90                   	nop

801044b0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801044b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801044b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801044bf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801044c2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801044c9:	5d                   	pop    %ebp
801044ca:	c3                   	ret    
801044cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044cf:	90                   	nop

801044d0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801044d0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801044d1:	31 d2                	xor    %edx,%edx
{
801044d3:	89 e5                	mov    %esp,%ebp
801044d5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801044d6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801044d9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801044dc:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
801044df:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044e0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801044e6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801044ec:	77 1a                	ja     80104508 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801044ee:	8b 58 04             	mov    0x4(%eax),%ebx
801044f1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801044f4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801044f7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801044f9:	83 fa 0a             	cmp    $0xa,%edx
801044fc:	75 e2                	jne    801044e0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801044fe:	5b                   	pop    %ebx
801044ff:	5d                   	pop    %ebp
80104500:	c3                   	ret    
80104501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104508:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010450b:	8d 51 28             	lea    0x28(%ecx),%edx
8010450e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104510:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104516:	83 c0 04             	add    $0x4,%eax
80104519:	39 d0                	cmp    %edx,%eax
8010451b:	75 f3                	jne    80104510 <getcallerpcs+0x40>
}
8010451d:	5b                   	pop    %ebx
8010451e:	5d                   	pop    %ebp
8010451f:	c3                   	ret    

80104520 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	53                   	push   %ebx
80104524:	83 ec 04             	sub    $0x4,%esp
80104527:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
8010452a:	8b 02                	mov    (%edx),%eax
8010452c:	85 c0                	test   %eax,%eax
8010452e:	75 10                	jne    80104540 <holding+0x20>
}
80104530:	83 c4 04             	add    $0x4,%esp
80104533:	31 c0                	xor    %eax,%eax
80104535:	5b                   	pop    %ebx
80104536:	5d                   	pop    %ebp
80104537:	c3                   	ret    
80104538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010453f:	90                   	nop
  return lock->locked && lock->cpu == mycpu();
80104540:	8b 5a 08             	mov    0x8(%edx),%ebx
80104543:	e8 d8 f4 ff ff       	call   80103a20 <mycpu>
80104548:	39 c3                	cmp    %eax,%ebx
8010454a:	0f 94 c0             	sete   %al
}
8010454d:	83 c4 04             	add    $0x4,%esp
  return lock->locked && lock->cpu == mycpu();
80104550:	0f b6 c0             	movzbl %al,%eax
}
80104553:	5b                   	pop    %ebx
80104554:	5d                   	pop    %ebp
80104555:	c3                   	ret    
80104556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010455d:	8d 76 00             	lea    0x0(%esi),%esi

80104560 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	53                   	push   %ebx
80104564:	83 ec 04             	sub    $0x4,%esp
80104567:	9c                   	pushf  
80104568:	5b                   	pop    %ebx
  asm volatile("cli");
80104569:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010456a:	e8 b1 f4 ff ff       	call   80103a20 <mycpu>
8010456f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104575:	85 c0                	test   %eax,%eax
80104577:	74 17                	je     80104590 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104579:	e8 a2 f4 ff ff       	call   80103a20 <mycpu>
8010457e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104585:	83 c4 04             	add    $0x4,%esp
80104588:	5b                   	pop    %ebx
80104589:	5d                   	pop    %ebp
8010458a:	c3                   	ret    
8010458b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010458f:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104590:	e8 8b f4 ff ff       	call   80103a20 <mycpu>
80104595:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010459b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801045a1:	eb d6                	jmp    80104579 <pushcli+0x19>
801045a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045b0 <acquire>:
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	56                   	push   %esi
801045b4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801045b5:	e8 a6 ff ff ff       	call   80104560 <pushcli>
  if(holding(lk))
801045ba:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
801045bd:	8b 03                	mov    (%ebx),%eax
801045bf:	85 c0                	test   %eax,%eax
801045c1:	0f 85 81 00 00 00    	jne    80104648 <acquire+0x98>
  asm volatile("lock; xchgl %0, %1" :
801045c7:	ba 01 00 00 00       	mov    $0x1,%edx
801045cc:	eb 05                	jmp    801045d3 <acquire+0x23>
801045ce:	66 90                	xchg   %ax,%ax
801045d0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045d3:	89 d0                	mov    %edx,%eax
801045d5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801045d8:	85 c0                	test   %eax,%eax
801045da:	75 f4                	jne    801045d0 <acquire+0x20>
  __sync_synchronize();
801045dc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801045e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045e4:	e8 37 f4 ff ff       	call   80103a20 <mycpu>
  ebp = (uint*)v - 2;
801045e9:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
801045eb:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
801045ee:	31 c0                	xor    %eax,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045f0:	8d 8a 00 00 00 80    	lea    -0x80000000(%edx),%ecx
801045f6:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801045fc:	77 22                	ja     80104620 <acquire+0x70>
    pcs[i] = ebp[1];     // saved %eip
801045fe:	8b 4a 04             	mov    0x4(%edx),%ecx
80104601:	89 4c 83 0c          	mov    %ecx,0xc(%ebx,%eax,4)
  for(i = 0; i < 10; i++){
80104605:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104608:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010460a:	83 f8 0a             	cmp    $0xa,%eax
8010460d:	75 e1                	jne    801045f0 <acquire+0x40>
}
8010460f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104612:	5b                   	pop    %ebx
80104613:	5e                   	pop    %esi
80104614:	5d                   	pop    %ebp
80104615:	c3                   	ret    
80104616:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010461d:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80104620:	8d 44 83 0c          	lea    0xc(%ebx,%eax,4),%eax
80104624:	83 c3 34             	add    $0x34,%ebx
80104627:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010462e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104630:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104636:	83 c0 04             	add    $0x4,%eax
80104639:	39 d8                	cmp    %ebx,%eax
8010463b:	75 f3                	jne    80104630 <acquire+0x80>
}
8010463d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104640:	5b                   	pop    %ebx
80104641:	5e                   	pop    %esi
80104642:	5d                   	pop    %ebp
80104643:	c3                   	ret    
80104644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return lock->locked && lock->cpu == mycpu();
80104648:	8b 73 08             	mov    0x8(%ebx),%esi
8010464b:	e8 d0 f3 ff ff       	call   80103a20 <mycpu>
80104650:	39 c6                	cmp    %eax,%esi
80104652:	0f 85 6f ff ff ff    	jne    801045c7 <acquire+0x17>
    panic("acquire");
80104658:	83 ec 0c             	sub    $0xc,%esp
8010465b:	68 4f 78 10 80       	push   $0x8010784f
80104660:	e8 1b bd ff ff       	call   80100380 <panic>
80104665:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010466c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104670 <popcli>:

void
popcli(void)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104676:	9c                   	pushf  
80104677:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104678:	f6 c4 02             	test   $0x2,%ah
8010467b:	75 35                	jne    801046b2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010467d:	e8 9e f3 ff ff       	call   80103a20 <mycpu>
80104682:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104689:	78 34                	js     801046bf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010468b:	e8 90 f3 ff ff       	call   80103a20 <mycpu>
80104690:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104696:	85 d2                	test   %edx,%edx
80104698:	74 06                	je     801046a0 <popcli+0x30>
    sti();
}
8010469a:	c9                   	leave  
8010469b:	c3                   	ret    
8010469c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801046a0:	e8 7b f3 ff ff       	call   80103a20 <mycpu>
801046a5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801046ab:	85 c0                	test   %eax,%eax
801046ad:	74 eb                	je     8010469a <popcli+0x2a>
  asm volatile("sti");
801046af:	fb                   	sti    
}
801046b0:	c9                   	leave  
801046b1:	c3                   	ret    
    panic("popcli - interruptible");
801046b2:	83 ec 0c             	sub    $0xc,%esp
801046b5:	68 57 78 10 80       	push   $0x80107857
801046ba:	e8 c1 bc ff ff       	call   80100380 <panic>
    panic("popcli");
801046bf:	83 ec 0c             	sub    $0xc,%esp
801046c2:	68 6e 78 10 80       	push   $0x8010786e
801046c7:	e8 b4 bc ff ff       	call   80100380 <panic>
801046cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046d0 <release>:
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	56                   	push   %esi
801046d4:	53                   	push   %ebx
801046d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
801046d8:	8b 03                	mov    (%ebx),%eax
801046da:	85 c0                	test   %eax,%eax
801046dc:	75 12                	jne    801046f0 <release+0x20>
    panic("release");
801046de:	83 ec 0c             	sub    $0xc,%esp
801046e1:	68 75 78 10 80       	push   $0x80107875
801046e6:	e8 95 bc ff ff       	call   80100380 <panic>
801046eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046ef:	90                   	nop
  return lock->locked && lock->cpu == mycpu();
801046f0:	8b 73 08             	mov    0x8(%ebx),%esi
801046f3:	e8 28 f3 ff ff       	call   80103a20 <mycpu>
801046f8:	39 c6                	cmp    %eax,%esi
801046fa:	75 e2                	jne    801046de <release+0xe>
  lk->pcs[0] = 0;
801046fc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104703:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
8010470a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010470f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104715:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104718:	5b                   	pop    %ebx
80104719:	5e                   	pop    %esi
8010471a:	5d                   	pop    %ebp
  popcli();
8010471b:	e9 50 ff ff ff       	jmp    80104670 <popcli>

80104720 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	57                   	push   %edi
80104724:	8b 55 08             	mov    0x8(%ebp),%edx
80104727:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010472a:	53                   	push   %ebx
8010472b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
8010472e:	89 d7                	mov    %edx,%edi
80104730:	09 cf                	or     %ecx,%edi
80104732:	83 e7 03             	and    $0x3,%edi
80104735:	75 29                	jne    80104760 <memset+0x40>
    c &= 0xFF;
80104737:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010473a:	c1 e0 18             	shl    $0x18,%eax
8010473d:	89 fb                	mov    %edi,%ebx
8010473f:	c1 e9 02             	shr    $0x2,%ecx
80104742:	c1 e3 10             	shl    $0x10,%ebx
80104745:	09 d8                	or     %ebx,%eax
80104747:	09 f8                	or     %edi,%eax
80104749:	c1 e7 08             	shl    $0x8,%edi
8010474c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
8010474e:	89 d7                	mov    %edx,%edi
80104750:	fc                   	cld    
80104751:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104753:	5b                   	pop    %ebx
80104754:	89 d0                	mov    %edx,%eax
80104756:	5f                   	pop    %edi
80104757:	5d                   	pop    %ebp
80104758:	c3                   	ret    
80104759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104760:	89 d7                	mov    %edx,%edi
80104762:	fc                   	cld    
80104763:	f3 aa                	rep stos %al,%es:(%edi)
80104765:	5b                   	pop    %ebx
80104766:	89 d0                	mov    %edx,%eax
80104768:	5f                   	pop    %edi
80104769:	5d                   	pop    %ebp
8010476a:	c3                   	ret    
8010476b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010476f:	90                   	nop

80104770 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	56                   	push   %esi
80104774:	8b 75 10             	mov    0x10(%ebp),%esi
80104777:	8b 55 08             	mov    0x8(%ebp),%edx
8010477a:	53                   	push   %ebx
8010477b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010477e:	85 f6                	test   %esi,%esi
80104780:	74 2e                	je     801047b0 <memcmp+0x40>
80104782:	01 c6                	add    %eax,%esi
80104784:	eb 14                	jmp    8010479a <memcmp+0x2a>
80104786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010478d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104790:	83 c0 01             	add    $0x1,%eax
80104793:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104796:	39 f0                	cmp    %esi,%eax
80104798:	74 16                	je     801047b0 <memcmp+0x40>
    if(*s1 != *s2)
8010479a:	0f b6 0a             	movzbl (%edx),%ecx
8010479d:	0f b6 18             	movzbl (%eax),%ebx
801047a0:	38 d9                	cmp    %bl,%cl
801047a2:	74 ec                	je     80104790 <memcmp+0x20>
      return *s1 - *s2;
801047a4:	0f b6 c1             	movzbl %cl,%eax
801047a7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801047a9:	5b                   	pop    %ebx
801047aa:	5e                   	pop    %esi
801047ab:	5d                   	pop    %ebp
801047ac:	c3                   	ret    
801047ad:	8d 76 00             	lea    0x0(%esi),%esi
801047b0:	5b                   	pop    %ebx
  return 0;
801047b1:	31 c0                	xor    %eax,%eax
}
801047b3:	5e                   	pop    %esi
801047b4:	5d                   	pop    %ebp
801047b5:	c3                   	ret    
801047b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047bd:	8d 76 00             	lea    0x0(%esi),%esi

801047c0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	57                   	push   %edi
801047c4:	8b 55 08             	mov    0x8(%ebp),%edx
801047c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047ca:	56                   	push   %esi
801047cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801047ce:	39 d6                	cmp    %edx,%esi
801047d0:	73 26                	jae    801047f8 <memmove+0x38>
801047d2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
801047d5:	39 fa                	cmp    %edi,%edx
801047d7:	73 1f                	jae    801047f8 <memmove+0x38>
801047d9:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
801047dc:	85 c9                	test   %ecx,%ecx
801047de:	74 0f                	je     801047ef <memmove+0x2f>
      *--d = *--s;
801047e0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801047e4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
801047e7:	83 e8 01             	sub    $0x1,%eax
801047ea:	83 f8 ff             	cmp    $0xffffffff,%eax
801047ed:	75 f1                	jne    801047e0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801047ef:	5e                   	pop    %esi
801047f0:	89 d0                	mov    %edx,%eax
801047f2:	5f                   	pop    %edi
801047f3:	5d                   	pop    %ebp
801047f4:	c3                   	ret    
801047f5:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
801047f8:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
801047fb:	89 d7                	mov    %edx,%edi
801047fd:	85 c9                	test   %ecx,%ecx
801047ff:	74 ee                	je     801047ef <memmove+0x2f>
80104801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104808:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104809:	39 f0                	cmp    %esi,%eax
8010480b:	75 fb                	jne    80104808 <memmove+0x48>
}
8010480d:	5e                   	pop    %esi
8010480e:	89 d0                	mov    %edx,%eax
80104810:	5f                   	pop    %edi
80104811:	5d                   	pop    %ebp
80104812:	c3                   	ret    
80104813:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010481a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104820 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104820:	eb 9e                	jmp    801047c0 <memmove>
80104822:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104830 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	56                   	push   %esi
80104834:	8b 75 10             	mov    0x10(%ebp),%esi
80104837:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010483a:	53                   	push   %ebx
8010483b:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
8010483e:	85 f6                	test   %esi,%esi
80104840:	74 36                	je     80104878 <strncmp+0x48>
80104842:	01 c6                	add    %eax,%esi
80104844:	eb 18                	jmp    8010485e <strncmp+0x2e>
80104846:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010484d:	8d 76 00             	lea    0x0(%esi),%esi
80104850:	38 da                	cmp    %bl,%dl
80104852:	75 14                	jne    80104868 <strncmp+0x38>
    n--, p++, q++;
80104854:	83 c0 01             	add    $0x1,%eax
80104857:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010485a:	39 f0                	cmp    %esi,%eax
8010485c:	74 1a                	je     80104878 <strncmp+0x48>
8010485e:	0f b6 11             	movzbl (%ecx),%edx
80104861:	0f b6 18             	movzbl (%eax),%ebx
80104864:	84 d2                	test   %dl,%dl
80104866:	75 e8                	jne    80104850 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104868:	0f b6 c2             	movzbl %dl,%eax
8010486b:	29 d8                	sub    %ebx,%eax
}
8010486d:	5b                   	pop    %ebx
8010486e:	5e                   	pop    %esi
8010486f:	5d                   	pop    %ebp
80104870:	c3                   	ret    
80104871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104878:	5b                   	pop    %ebx
    return 0;
80104879:	31 c0                	xor    %eax,%eax
}
8010487b:	5e                   	pop    %esi
8010487c:	5d                   	pop    %ebp
8010487d:	c3                   	ret    
8010487e:	66 90                	xchg   %ax,%ax

80104880 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	57                   	push   %edi
80104884:	56                   	push   %esi
80104885:	8b 75 08             	mov    0x8(%ebp),%esi
80104888:	53                   	push   %ebx
80104889:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010488c:	89 f2                	mov    %esi,%edx
8010488e:	eb 17                	jmp    801048a7 <strncpy+0x27>
80104890:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104894:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104897:	83 c2 01             	add    $0x1,%edx
8010489a:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
8010489e:	89 f9                	mov    %edi,%ecx
801048a0:	88 4a ff             	mov    %cl,-0x1(%edx)
801048a3:	84 c9                	test   %cl,%cl
801048a5:	74 09                	je     801048b0 <strncpy+0x30>
801048a7:	89 c3                	mov    %eax,%ebx
801048a9:	83 e8 01             	sub    $0x1,%eax
801048ac:	85 db                	test   %ebx,%ebx
801048ae:	7f e0                	jg     80104890 <strncpy+0x10>
    ;
  while(n-- > 0)
801048b0:	89 d1                	mov    %edx,%ecx
801048b2:	85 c0                	test   %eax,%eax
801048b4:	7e 1d                	jle    801048d3 <strncpy+0x53>
801048b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048bd:	8d 76 00             	lea    0x0(%esi),%esi
    *s++ = 0;
801048c0:	83 c1 01             	add    $0x1,%ecx
801048c3:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
801048c7:	89 c8                	mov    %ecx,%eax
801048c9:	f7 d0                	not    %eax
801048cb:	01 d0                	add    %edx,%eax
801048cd:	01 d8                	add    %ebx,%eax
801048cf:	85 c0                	test   %eax,%eax
801048d1:	7f ed                	jg     801048c0 <strncpy+0x40>
  return os;
}
801048d3:	5b                   	pop    %ebx
801048d4:	89 f0                	mov    %esi,%eax
801048d6:	5e                   	pop    %esi
801048d7:	5f                   	pop    %edi
801048d8:	5d                   	pop    %ebp
801048d9:	c3                   	ret    
801048da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801048e0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	56                   	push   %esi
801048e4:	8b 55 10             	mov    0x10(%ebp),%edx
801048e7:	8b 75 08             	mov    0x8(%ebp),%esi
801048ea:	53                   	push   %ebx
801048eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
801048ee:	85 d2                	test   %edx,%edx
801048f0:	7e 25                	jle    80104917 <safestrcpy+0x37>
801048f2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
801048f6:	89 f2                	mov    %esi,%edx
801048f8:	eb 16                	jmp    80104910 <safestrcpy+0x30>
801048fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104900:	0f b6 08             	movzbl (%eax),%ecx
80104903:	83 c0 01             	add    $0x1,%eax
80104906:	83 c2 01             	add    $0x1,%edx
80104909:	88 4a ff             	mov    %cl,-0x1(%edx)
8010490c:	84 c9                	test   %cl,%cl
8010490e:	74 04                	je     80104914 <safestrcpy+0x34>
80104910:	39 d8                	cmp    %ebx,%eax
80104912:	75 ec                	jne    80104900 <safestrcpy+0x20>
    ;
  *s = 0;
80104914:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104917:	89 f0                	mov    %esi,%eax
80104919:	5b                   	pop    %ebx
8010491a:	5e                   	pop    %esi
8010491b:	5d                   	pop    %ebp
8010491c:	c3                   	ret    
8010491d:	8d 76 00             	lea    0x0(%esi),%esi

80104920 <strlen>:

int
strlen(const char *s)
{
80104920:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104921:	31 c0                	xor    %eax,%eax
{
80104923:	89 e5                	mov    %esp,%ebp
80104925:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104928:	80 3a 00             	cmpb   $0x0,(%edx)
8010492b:	74 0c                	je     80104939 <strlen+0x19>
8010492d:	8d 76 00             	lea    0x0(%esi),%esi
80104930:	83 c0 01             	add    $0x1,%eax
80104933:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104937:	75 f7                	jne    80104930 <strlen+0x10>
    ;
  return n;
}
80104939:	5d                   	pop    %ebp
8010493a:	c3                   	ret    

8010493b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010493b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010493f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104943:	55                   	push   %ebp
  pushl %ebx
80104944:	53                   	push   %ebx
  pushl %esi
80104945:	56                   	push   %esi
  pushl %edi
80104946:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104947:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104949:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010494b:	5f                   	pop    %edi
  popl %esi
8010494c:	5e                   	pop    %esi
  popl %ebx
8010494d:	5b                   	pop    %ebx
  popl %ebp
8010494e:	5d                   	pop    %ebp
  ret
8010494f:	c3                   	ret    

80104950 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	53                   	push   %ebx
80104954:	83 ec 04             	sub    $0x4,%esp
80104957:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010495a:	e8 51 f1 ff ff       	call   80103ab0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010495f:	8b 00                	mov    (%eax),%eax
80104961:	39 d8                	cmp    %ebx,%eax
80104963:	76 1b                	jbe    80104980 <fetchint+0x30>
80104965:	8d 53 04             	lea    0x4(%ebx),%edx
80104968:	39 d0                	cmp    %edx,%eax
8010496a:	72 14                	jb     80104980 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010496c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010496f:	8b 13                	mov    (%ebx),%edx
80104971:	89 10                	mov    %edx,(%eax)
  return 0;
80104973:	31 c0                	xor    %eax,%eax
}
80104975:	83 c4 04             	add    $0x4,%esp
80104978:	5b                   	pop    %ebx
80104979:	5d                   	pop    %ebp
8010497a:	c3                   	ret    
8010497b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010497f:	90                   	nop
    return -1;
80104980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104985:	eb ee                	jmp    80104975 <fetchint+0x25>
80104987:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010498e:	66 90                	xchg   %ax,%ax

80104990 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	53                   	push   %ebx
80104994:	83 ec 04             	sub    $0x4,%esp
80104997:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010499a:	e8 11 f1 ff ff       	call   80103ab0 <myproc>

  if(addr >= curproc->sz)
8010499f:	39 18                	cmp    %ebx,(%eax)
801049a1:	76 2d                	jbe    801049d0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
801049a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801049a6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801049a8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801049aa:	39 d3                	cmp    %edx,%ebx
801049ac:	73 22                	jae    801049d0 <fetchstr+0x40>
801049ae:	89 d8                	mov    %ebx,%eax
801049b0:	eb 0d                	jmp    801049bf <fetchstr+0x2f>
801049b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049b8:	83 c0 01             	add    $0x1,%eax
801049bb:	39 c2                	cmp    %eax,%edx
801049bd:	76 11                	jbe    801049d0 <fetchstr+0x40>
    if(*s == 0)
801049bf:	80 38 00             	cmpb   $0x0,(%eax)
801049c2:	75 f4                	jne    801049b8 <fetchstr+0x28>
      return s - *pp;
  }
  return -1;
}
801049c4:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
801049c7:	29 d8                	sub    %ebx,%eax
}
801049c9:	5b                   	pop    %ebx
801049ca:	5d                   	pop    %ebp
801049cb:	c3                   	ret    
801049cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049d0:	83 c4 04             	add    $0x4,%esp
    return -1;
801049d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049d8:	5b                   	pop    %ebx
801049d9:	5d                   	pop    %ebp
801049da:	c3                   	ret    
801049db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049df:	90                   	nop

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
801049e5:	e8 c6 f0 ff ff       	call   80103ab0 <myproc>
801049ea:	8b 55 08             	mov    0x8(%ebp),%edx
801049ed:	8b 40 18             	mov    0x18(%eax),%eax
801049f0:	8b 40 44             	mov    0x44(%eax),%eax
801049f3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801049f6:	e8 b5 f0 ff ff       	call   80103ab0 <myproc>
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
80104a3b:	e8 70 f0 ff ff       	call   80103ab0 <myproc>
 
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
80104ab2:	e8 d9 fe ff ff       	call   80104990 <fetchstr>
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
[SYS_pfs]     sys_pfs,
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
80104ad7:	e8 d4 ef ff ff       	call   80103ab0 <myproc>
80104adc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104ade:	8b 40 18             	mov    0x18(%eax),%eax
80104ae1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104ae4:	8d 50 ff             	lea    -0x1(%eax),%edx
80104ae7:	83 fa 15             	cmp    $0x15,%edx
80104aea:	77 24                	ja     80104b10 <syscall+0x40>
80104aec:	8b 14 85 a0 78 10 80 	mov    -0x7fef8760(,%eax,4),%edx
80104af3:	85 d2                	test   %edx,%edx
80104af5:	74 19                	je     80104b10 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104af7:	ff d2                	call   *%edx
80104af9:	89 c2                	mov    %eax,%edx
80104afb:	8b 43 18             	mov    0x18(%ebx),%eax
80104afe:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104b01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b04:	c9                   	leave  
80104b05:	c3                   	ret    
80104b06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b0d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104b10:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104b11:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104b14:	50                   	push   %eax
80104b15:	ff 73 10             	pushl  0x10(%ebx)
80104b18:	68 7d 78 10 80       	push   $0x8010787d
80104b1d:	e8 7e bb ff ff       	call   801006a0 <cprintf>
    curproc->tf->eax = -1;
80104b22:	8b 43 18             	mov    0x18(%ebx),%eax
80104b25:	83 c4 10             	add    $0x10,%esp
80104b28:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104b2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b32:	c9                   	leave  
80104b33:	c3                   	ret    
80104b34:	66 90                	xchg   %ax,%ax
80104b36:	66 90                	xchg   %ax,%ax
80104b38:	66 90                	xchg   %ax,%ax
80104b3a:	66 90                	xchg   %ax,%ax
80104b3c:	66 90                	xchg   %ax,%ax
80104b3e:	66 90                	xchg   %ax,%ax

80104b40 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	57                   	push   %edi
80104b44:	56                   	push   %esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b45:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104b48:	53                   	push   %ebx
80104b49:	83 ec 44             	sub    $0x44,%esp
80104b4c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104b4f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104b52:	57                   	push   %edi
80104b53:	50                   	push   %eax
{
80104b54:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104b57:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104b5a:	e8 71 d4 ff ff       	call   80101fd0 <nameiparent>
80104b5f:	83 c4 10             	add    $0x10,%esp
80104b62:	85 c0                	test   %eax,%eax
80104b64:	0f 84 46 01 00 00    	je     80104cb0 <create+0x170>
    return 0;
  ilock(dp);
80104b6a:	83 ec 0c             	sub    $0xc,%esp
80104b6d:	89 c3                	mov    %eax,%ebx
80104b6f:	50                   	push   %eax
80104b70:	e8 9b cb ff ff       	call   80101710 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104b75:	83 c4 0c             	add    $0xc,%esp
80104b78:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b7b:	50                   	push   %eax
80104b7c:	57                   	push   %edi
80104b7d:	53                   	push   %ebx
80104b7e:	e8 bd d0 ff ff       	call   80101c40 <dirlookup>
80104b83:	83 c4 10             	add    $0x10,%esp
80104b86:	89 c6                	mov    %eax,%esi
80104b88:	85 c0                	test   %eax,%eax
80104b8a:	74 54                	je     80104be0 <create+0xa0>
    iunlockput(dp);
80104b8c:	83 ec 0c             	sub    $0xc,%esp
80104b8f:	53                   	push   %ebx
80104b90:	e8 0b ce ff ff       	call   801019a0 <iunlockput>
    ilock(ip);
80104b95:	89 34 24             	mov    %esi,(%esp)
80104b98:	e8 73 cb ff ff       	call   80101710 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104b9d:	83 c4 10             	add    $0x10,%esp
80104ba0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104ba5:	75 19                	jne    80104bc0 <create+0x80>
80104ba7:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104bac:	75 12                	jne    80104bc0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104bae:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bb1:	89 f0                	mov    %esi,%eax
80104bb3:	5b                   	pop    %ebx
80104bb4:	5e                   	pop    %esi
80104bb5:	5f                   	pop    %edi
80104bb6:	5d                   	pop    %ebp
80104bb7:	c3                   	ret    
80104bb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bbf:	90                   	nop
    iunlockput(ip);
80104bc0:	83 ec 0c             	sub    $0xc,%esp
80104bc3:	56                   	push   %esi
    return 0;
80104bc4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104bc6:	e8 d5 cd ff ff       	call   801019a0 <iunlockput>
    return 0;
80104bcb:	83 c4 10             	add    $0x10,%esp
}
80104bce:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bd1:	89 f0                	mov    %esi,%eax
80104bd3:	5b                   	pop    %ebx
80104bd4:	5e                   	pop    %esi
80104bd5:	5f                   	pop    %edi
80104bd6:	5d                   	pop    %ebp
80104bd7:	c3                   	ret    
80104bd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bdf:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104be0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104be4:	83 ec 08             	sub    $0x8,%esp
80104be7:	50                   	push   %eax
80104be8:	ff 33                	pushl  (%ebx)
80104bea:	e8 b1 c9 ff ff       	call   801015a0 <ialloc>
80104bef:	83 c4 10             	add    $0x10,%esp
80104bf2:	89 c6                	mov    %eax,%esi
80104bf4:	85 c0                	test   %eax,%eax
80104bf6:	0f 84 cd 00 00 00    	je     80104cc9 <create+0x189>
  ilock(ip);
80104bfc:	83 ec 0c             	sub    $0xc,%esp
80104bff:	50                   	push   %eax
80104c00:	e8 0b cb ff ff       	call   80101710 <ilock>
  ip->major = major;
80104c05:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104c09:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104c0d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104c11:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104c15:	b8 01 00 00 00       	mov    $0x1,%eax
80104c1a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104c1e:	89 34 24             	mov    %esi,(%esp)
80104c21:	e8 3a ca ff ff       	call   80101660 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104c26:	83 c4 10             	add    $0x10,%esp
80104c29:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104c2e:	74 30                	je     80104c60 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104c30:	83 ec 04             	sub    $0x4,%esp
80104c33:	ff 76 04             	pushl  0x4(%esi)
80104c36:	57                   	push   %edi
80104c37:	53                   	push   %ebx
80104c38:	e8 b3 d2 ff ff       	call   80101ef0 <dirlink>
80104c3d:	83 c4 10             	add    $0x10,%esp
80104c40:	85 c0                	test   %eax,%eax
80104c42:	78 78                	js     80104cbc <create+0x17c>
  iunlockput(dp);
80104c44:	83 ec 0c             	sub    $0xc,%esp
80104c47:	53                   	push   %ebx
80104c48:	e8 53 cd ff ff       	call   801019a0 <iunlockput>
  return ip;
80104c4d:	83 c4 10             	add    $0x10,%esp
}
80104c50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c53:	89 f0                	mov    %esi,%eax
80104c55:	5b                   	pop    %ebx
80104c56:	5e                   	pop    %esi
80104c57:	5f                   	pop    %edi
80104c58:	5d                   	pop    %ebp
80104c59:	c3                   	ret    
80104c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104c60:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104c63:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104c68:	53                   	push   %ebx
80104c69:	e8 f2 c9 ff ff       	call   80101660 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104c6e:	83 c4 0c             	add    $0xc,%esp
80104c71:	ff 76 04             	pushl  0x4(%esi)
80104c74:	68 18 79 10 80       	push   $0x80107918
80104c79:	56                   	push   %esi
80104c7a:	e8 71 d2 ff ff       	call   80101ef0 <dirlink>
80104c7f:	83 c4 10             	add    $0x10,%esp
80104c82:	85 c0                	test   %eax,%eax
80104c84:	78 18                	js     80104c9e <create+0x15e>
80104c86:	83 ec 04             	sub    $0x4,%esp
80104c89:	ff 73 04             	pushl  0x4(%ebx)
80104c8c:	68 17 79 10 80       	push   $0x80107917
80104c91:	56                   	push   %esi
80104c92:	e8 59 d2 ff ff       	call   80101ef0 <dirlink>
80104c97:	83 c4 10             	add    $0x10,%esp
80104c9a:	85 c0                	test   %eax,%eax
80104c9c:	79 92                	jns    80104c30 <create+0xf0>
      panic("create dots");
80104c9e:	83 ec 0c             	sub    $0xc,%esp
80104ca1:	68 0b 79 10 80       	push   $0x8010790b
80104ca6:	e8 d5 b6 ff ff       	call   80100380 <panic>
80104cab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104caf:	90                   	nop
}
80104cb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104cb3:	31 f6                	xor    %esi,%esi
}
80104cb5:	5b                   	pop    %ebx
80104cb6:	89 f0                	mov    %esi,%eax
80104cb8:	5e                   	pop    %esi
80104cb9:	5f                   	pop    %edi
80104cba:	5d                   	pop    %ebp
80104cbb:	c3                   	ret    
    panic("create: dirlink");
80104cbc:	83 ec 0c             	sub    $0xc,%esp
80104cbf:	68 1a 79 10 80       	push   $0x8010791a
80104cc4:	e8 b7 b6 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104cc9:	83 ec 0c             	sub    $0xc,%esp
80104ccc:	68 fc 78 10 80       	push   $0x801078fc
80104cd1:	e8 aa b6 ff ff       	call   80100380 <panic>
80104cd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cdd:	8d 76 00             	lea    0x0(%esi),%esi

80104ce0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	56                   	push   %esi
80104ce4:	89 d6                	mov    %edx,%esi
80104ce6:	53                   	push   %ebx
80104ce7:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104ce9:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104cec:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104cef:	50                   	push   %eax
80104cf0:	6a 00                	push   $0x0
80104cf2:	e8 e9 fc ff ff       	call   801049e0 <argint>
80104cf7:	83 c4 10             	add    $0x10,%esp
80104cfa:	85 c0                	test   %eax,%eax
80104cfc:	78 2a                	js     80104d28 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104cfe:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d02:	77 24                	ja     80104d28 <argfd.constprop.0+0x48>
80104d04:	e8 a7 ed ff ff       	call   80103ab0 <myproc>
80104d09:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d0c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104d10:	85 c0                	test   %eax,%eax
80104d12:	74 14                	je     80104d28 <argfd.constprop.0+0x48>
  if(pfd)
80104d14:	85 db                	test   %ebx,%ebx
80104d16:	74 02                	je     80104d1a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104d18:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104d1a:	89 06                	mov    %eax,(%esi)
  return 0;
80104d1c:	31 c0                	xor    %eax,%eax
}
80104d1e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d21:	5b                   	pop    %ebx
80104d22:	5e                   	pop    %esi
80104d23:	5d                   	pop    %ebp
80104d24:	c3                   	ret    
80104d25:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104d28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d2d:	eb ef                	jmp    80104d1e <argfd.constprop.0+0x3e>
80104d2f:	90                   	nop

80104d30 <sys_dup>:
{
80104d30:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104d31:	31 c0                	xor    %eax,%eax
{
80104d33:	89 e5                	mov    %esp,%ebp
80104d35:	56                   	push   %esi
80104d36:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104d37:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104d3a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104d3d:	e8 9e ff ff ff       	call   80104ce0 <argfd.constprop.0>
80104d42:	85 c0                	test   %eax,%eax
80104d44:	78 1a                	js     80104d60 <sys_dup+0x30>
  if((fd=fdalloc(f)) < 0)
80104d46:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104d49:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104d4b:	e8 60 ed ff ff       	call   80103ab0 <myproc>
    if(curproc->ofile[fd] == 0){
80104d50:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104d54:	85 d2                	test   %edx,%edx
80104d56:	74 18                	je     80104d70 <sys_dup+0x40>
  for(fd = 0; fd < NOFILE; fd++){
80104d58:	83 c3 01             	add    $0x1,%ebx
80104d5b:	83 fb 10             	cmp    $0x10,%ebx
80104d5e:	75 f0                	jne    80104d50 <sys_dup+0x20>
}
80104d60:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104d63:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104d68:	89 d8                	mov    %ebx,%eax
80104d6a:	5b                   	pop    %ebx
80104d6b:	5e                   	pop    %esi
80104d6c:	5d                   	pop    %ebp
80104d6d:	c3                   	ret    
80104d6e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80104d70:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104d74:	83 ec 0c             	sub    $0xc,%esp
80104d77:	ff 75 f4             	pushl  -0xc(%ebp)
80104d7a:	e8 e1 c0 ff ff       	call   80100e60 <filedup>
  return fd;
80104d7f:	83 c4 10             	add    $0x10,%esp
}
80104d82:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d85:	89 d8                	mov    %ebx,%eax
80104d87:	5b                   	pop    %ebx
80104d88:	5e                   	pop    %esi
80104d89:	5d                   	pop    %ebp
80104d8a:	c3                   	ret    
80104d8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d8f:	90                   	nop

80104d90 <sys_read>:
{
80104d90:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d91:	31 c0                	xor    %eax,%eax
{
80104d93:	89 e5                	mov    %esp,%ebp
80104d95:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d98:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d9b:	e8 40 ff ff ff       	call   80104ce0 <argfd.constprop.0>
80104da0:	85 c0                	test   %eax,%eax
80104da2:	78 4c                	js     80104df0 <sys_read+0x60>
80104da4:	83 ec 08             	sub    $0x8,%esp
80104da7:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104daa:	50                   	push   %eax
80104dab:	6a 02                	push   $0x2
80104dad:	e8 2e fc ff ff       	call   801049e0 <argint>
80104db2:	83 c4 10             	add    $0x10,%esp
80104db5:	85 c0                	test   %eax,%eax
80104db7:	78 37                	js     80104df0 <sys_read+0x60>
80104db9:	83 ec 04             	sub    $0x4,%esp
80104dbc:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dbf:	ff 75 f0             	pushl  -0x10(%ebp)
80104dc2:	50                   	push   %eax
80104dc3:	6a 01                	push   $0x1
80104dc5:	e8 66 fc ff ff       	call   80104a30 <argptr>
80104dca:	83 c4 10             	add    $0x10,%esp
80104dcd:	85 c0                	test   %eax,%eax
80104dcf:	78 1f                	js     80104df0 <sys_read+0x60>
  return fileread(f, p, n);
80104dd1:	83 ec 04             	sub    $0x4,%esp
80104dd4:	ff 75 f0             	pushl  -0x10(%ebp)
80104dd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dda:	ff 75 ec             	pushl  -0x14(%ebp)
80104ddd:	e8 fe c1 ff ff       	call   80100fe0 <fileread>
80104de2:	83 c4 10             	add    $0x10,%esp
}
80104de5:	c9                   	leave  
80104de6:	c3                   	ret    
80104de7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dee:	66 90                	xchg   %ax,%ax
80104df0:	c9                   	leave  
    return -1;
80104df1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104df6:	c3                   	ret    
80104df7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dfe:	66 90                	xchg   %ax,%ax

80104e00 <sys_write>:
{
80104e00:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e01:	31 c0                	xor    %eax,%eax
{
80104e03:	89 e5                	mov    %esp,%ebp
80104e05:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e08:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104e0b:	e8 d0 fe ff ff       	call   80104ce0 <argfd.constprop.0>
80104e10:	85 c0                	test   %eax,%eax
80104e12:	78 4c                	js     80104e60 <sys_write+0x60>
80104e14:	83 ec 08             	sub    $0x8,%esp
80104e17:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e1a:	50                   	push   %eax
80104e1b:	6a 02                	push   $0x2
80104e1d:	e8 be fb ff ff       	call   801049e0 <argint>
80104e22:	83 c4 10             	add    $0x10,%esp
80104e25:	85 c0                	test   %eax,%eax
80104e27:	78 37                	js     80104e60 <sys_write+0x60>
80104e29:	83 ec 04             	sub    $0x4,%esp
80104e2c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e2f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e32:	50                   	push   %eax
80104e33:	6a 01                	push   $0x1
80104e35:	e8 f6 fb ff ff       	call   80104a30 <argptr>
80104e3a:	83 c4 10             	add    $0x10,%esp
80104e3d:	85 c0                	test   %eax,%eax
80104e3f:	78 1f                	js     80104e60 <sys_write+0x60>
  return filewrite(f, p, n);
80104e41:	83 ec 04             	sub    $0x4,%esp
80104e44:	ff 75 f0             	pushl  -0x10(%ebp)
80104e47:	ff 75 f4             	pushl  -0xc(%ebp)
80104e4a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e4d:	e8 1e c2 ff ff       	call   80101070 <filewrite>
80104e52:	83 c4 10             	add    $0x10,%esp
}
80104e55:	c9                   	leave  
80104e56:	c3                   	ret    
80104e57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e5e:	66 90                	xchg   %ax,%ax
80104e60:	c9                   	leave  
    return -1;
80104e61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e66:	c3                   	ret    
80104e67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e6e:	66 90                	xchg   %ax,%ax

80104e70 <sys_close>:
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104e76:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e79:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e7c:	e8 5f fe ff ff       	call   80104ce0 <argfd.constprop.0>
80104e81:	85 c0                	test   %eax,%eax
80104e83:	78 2b                	js     80104eb0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104e85:	e8 26 ec ff ff       	call   80103ab0 <myproc>
80104e8a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104e8d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104e90:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104e97:	00 
  fileclose(f);
80104e98:	ff 75 f4             	pushl  -0xc(%ebp)
80104e9b:	e8 10 c0 ff ff       	call   80100eb0 <fileclose>
  return 0;
80104ea0:	83 c4 10             	add    $0x10,%esp
80104ea3:	31 c0                	xor    %eax,%eax
}
80104ea5:	c9                   	leave  
80104ea6:	c3                   	ret    
80104ea7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eae:	66 90                	xchg   %ax,%ax
80104eb0:	c9                   	leave  
    return -1;
80104eb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104eb6:	c3                   	ret    
80104eb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ebe:	66 90                	xchg   %ax,%ax

80104ec0 <sys_fstat>:
{
80104ec0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ec1:	31 c0                	xor    %eax,%eax
{
80104ec3:	89 e5                	mov    %esp,%ebp
80104ec5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ec8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104ecb:	e8 10 fe ff ff       	call   80104ce0 <argfd.constprop.0>
80104ed0:	85 c0                	test   %eax,%eax
80104ed2:	78 2c                	js     80104f00 <sys_fstat+0x40>
80104ed4:	83 ec 04             	sub    $0x4,%esp
80104ed7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104eda:	6a 14                	push   $0x14
80104edc:	50                   	push   %eax
80104edd:	6a 01                	push   $0x1
80104edf:	e8 4c fb ff ff       	call   80104a30 <argptr>
80104ee4:	83 c4 10             	add    $0x10,%esp
80104ee7:	85 c0                	test   %eax,%eax
80104ee9:	78 15                	js     80104f00 <sys_fstat+0x40>
  return filestat(f, st);
80104eeb:	83 ec 08             	sub    $0x8,%esp
80104eee:	ff 75 f4             	pushl  -0xc(%ebp)
80104ef1:	ff 75 f0             	pushl  -0x10(%ebp)
80104ef4:	e8 97 c0 ff ff       	call   80100f90 <filestat>
80104ef9:	83 c4 10             	add    $0x10,%esp
}
80104efc:	c9                   	leave  
80104efd:	c3                   	ret    
80104efe:	66 90                	xchg   %ax,%ax
80104f00:	c9                   	leave  
    return -1;
80104f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f06:	c3                   	ret    
80104f07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f0e:	66 90                	xchg   %ax,%ax

80104f10 <sys_link>:
{
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	57                   	push   %edi
80104f14:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f15:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104f18:	53                   	push   %ebx
80104f19:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f1c:	50                   	push   %eax
80104f1d:	6a 00                	push   $0x0
80104f1f:	e8 6c fb ff ff       	call   80104a90 <argstr>
80104f24:	83 c4 10             	add    $0x10,%esp
80104f27:	85 c0                	test   %eax,%eax
80104f29:	0f 88 fb 00 00 00    	js     8010502a <sys_link+0x11a>
80104f2f:	83 ec 08             	sub    $0x8,%esp
80104f32:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f35:	50                   	push   %eax
80104f36:	6a 01                	push   $0x1
80104f38:	e8 53 fb ff ff       	call   80104a90 <argstr>
80104f3d:	83 c4 10             	add    $0x10,%esp
80104f40:	85 c0                	test   %eax,%eax
80104f42:	0f 88 e2 00 00 00    	js     8010502a <sys_link+0x11a>
  begin_op();
80104f48:	e8 73 df ff ff       	call   80102ec0 <begin_op>
  if((ip = namei(old)) == 0){
80104f4d:	83 ec 0c             	sub    $0xc,%esp
80104f50:	ff 75 d4             	pushl  -0x2c(%ebp)
80104f53:	e8 58 d0 ff ff       	call   80101fb0 <namei>
80104f58:	83 c4 10             	add    $0x10,%esp
80104f5b:	89 c3                	mov    %eax,%ebx
80104f5d:	85 c0                	test   %eax,%eax
80104f5f:	0f 84 e4 00 00 00    	je     80105049 <sys_link+0x139>
  ilock(ip);
80104f65:	83 ec 0c             	sub    $0xc,%esp
80104f68:	50                   	push   %eax
80104f69:	e8 a2 c7 ff ff       	call   80101710 <ilock>
  if(ip->type == T_DIR){
80104f6e:	83 c4 10             	add    $0x10,%esp
80104f71:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f76:	0f 84 b5 00 00 00    	je     80105031 <sys_link+0x121>
  iupdate(ip);
80104f7c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80104f7f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80104f84:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104f87:	53                   	push   %ebx
80104f88:	e8 d3 c6 ff ff       	call   80101660 <iupdate>
  iunlock(ip);
80104f8d:	89 1c 24             	mov    %ebx,(%esp)
80104f90:	e8 5b c8 ff ff       	call   801017f0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104f95:	58                   	pop    %eax
80104f96:	5a                   	pop    %edx
80104f97:	57                   	push   %edi
80104f98:	ff 75 d0             	pushl  -0x30(%ebp)
80104f9b:	e8 30 d0 ff ff       	call   80101fd0 <nameiparent>
80104fa0:	83 c4 10             	add    $0x10,%esp
80104fa3:	89 c6                	mov    %eax,%esi
80104fa5:	85 c0                	test   %eax,%eax
80104fa7:	74 5b                	je     80105004 <sys_link+0xf4>
  ilock(dp);
80104fa9:	83 ec 0c             	sub    $0xc,%esp
80104fac:	50                   	push   %eax
80104fad:	e8 5e c7 ff ff       	call   80101710 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104fb2:	8b 03                	mov    (%ebx),%eax
80104fb4:	83 c4 10             	add    $0x10,%esp
80104fb7:	39 06                	cmp    %eax,(%esi)
80104fb9:	75 3d                	jne    80104ff8 <sys_link+0xe8>
80104fbb:	83 ec 04             	sub    $0x4,%esp
80104fbe:	ff 73 04             	pushl  0x4(%ebx)
80104fc1:	57                   	push   %edi
80104fc2:	56                   	push   %esi
80104fc3:	e8 28 cf ff ff       	call   80101ef0 <dirlink>
80104fc8:	83 c4 10             	add    $0x10,%esp
80104fcb:	85 c0                	test   %eax,%eax
80104fcd:	78 29                	js     80104ff8 <sys_link+0xe8>
  iunlockput(dp);
80104fcf:	83 ec 0c             	sub    $0xc,%esp
80104fd2:	56                   	push   %esi
80104fd3:	e8 c8 c9 ff ff       	call   801019a0 <iunlockput>
  iput(ip);
80104fd8:	89 1c 24             	mov    %ebx,(%esp)
80104fdb:	e8 60 c8 ff ff       	call   80101840 <iput>
  end_op();
80104fe0:	e8 4b df ff ff       	call   80102f30 <end_op>
  return 0;
80104fe5:	83 c4 10             	add    $0x10,%esp
80104fe8:	31 c0                	xor    %eax,%eax
}
80104fea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fed:	5b                   	pop    %ebx
80104fee:	5e                   	pop    %esi
80104fef:	5f                   	pop    %edi
80104ff0:	5d                   	pop    %ebp
80104ff1:	c3                   	ret    
80104ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104ff8:	83 ec 0c             	sub    $0xc,%esp
80104ffb:	56                   	push   %esi
80104ffc:	e8 9f c9 ff ff       	call   801019a0 <iunlockput>
    goto bad;
80105001:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105004:	83 ec 0c             	sub    $0xc,%esp
80105007:	53                   	push   %ebx
80105008:	e8 03 c7 ff ff       	call   80101710 <ilock>
  ip->nlink--;
8010500d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105012:	89 1c 24             	mov    %ebx,(%esp)
80105015:	e8 46 c6 ff ff       	call   80101660 <iupdate>
  iunlockput(ip);
8010501a:	89 1c 24             	mov    %ebx,(%esp)
8010501d:	e8 7e c9 ff ff       	call   801019a0 <iunlockput>
  end_op();
80105022:	e8 09 df ff ff       	call   80102f30 <end_op>
  return -1;
80105027:	83 c4 10             	add    $0x10,%esp
8010502a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010502f:	eb b9                	jmp    80104fea <sys_link+0xda>
    iunlockput(ip);
80105031:	83 ec 0c             	sub    $0xc,%esp
80105034:	53                   	push   %ebx
80105035:	e8 66 c9 ff ff       	call   801019a0 <iunlockput>
    end_op();
8010503a:	e8 f1 de ff ff       	call   80102f30 <end_op>
    return -1;
8010503f:	83 c4 10             	add    $0x10,%esp
80105042:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105047:	eb a1                	jmp    80104fea <sys_link+0xda>
    end_op();
80105049:	e8 e2 de ff ff       	call   80102f30 <end_op>
    return -1;
8010504e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105053:	eb 95                	jmp    80104fea <sys_link+0xda>
80105055:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010505c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105060 <sys_unlink>:
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	57                   	push   %edi
80105064:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105065:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105068:	53                   	push   %ebx
80105069:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010506c:	50                   	push   %eax
8010506d:	6a 00                	push   $0x0
8010506f:	e8 1c fa ff ff       	call   80104a90 <argstr>
80105074:	83 c4 10             	add    $0x10,%esp
80105077:	85 c0                	test   %eax,%eax
80105079:	0f 88 91 01 00 00    	js     80105210 <sys_unlink+0x1b0>
  begin_op();
8010507f:	e8 3c de ff ff       	call   80102ec0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105084:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105087:	83 ec 08             	sub    $0x8,%esp
8010508a:	53                   	push   %ebx
8010508b:	ff 75 c0             	pushl  -0x40(%ebp)
8010508e:	e8 3d cf ff ff       	call   80101fd0 <nameiparent>
80105093:	83 c4 10             	add    $0x10,%esp
80105096:	89 c6                	mov    %eax,%esi
80105098:	85 c0                	test   %eax,%eax
8010509a:	0f 84 7a 01 00 00    	je     8010521a <sys_unlink+0x1ba>
  ilock(dp);
801050a0:	83 ec 0c             	sub    $0xc,%esp
801050a3:	50                   	push   %eax
801050a4:	e8 67 c6 ff ff       	call   80101710 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801050a9:	58                   	pop    %eax
801050aa:	5a                   	pop    %edx
801050ab:	68 18 79 10 80       	push   $0x80107918
801050b0:	53                   	push   %ebx
801050b1:	e8 6a cb ff ff       	call   80101c20 <namecmp>
801050b6:	83 c4 10             	add    $0x10,%esp
801050b9:	85 c0                	test   %eax,%eax
801050bb:	0f 84 0f 01 00 00    	je     801051d0 <sys_unlink+0x170>
801050c1:	83 ec 08             	sub    $0x8,%esp
801050c4:	68 17 79 10 80       	push   $0x80107917
801050c9:	53                   	push   %ebx
801050ca:	e8 51 cb ff ff       	call   80101c20 <namecmp>
801050cf:	83 c4 10             	add    $0x10,%esp
801050d2:	85 c0                	test   %eax,%eax
801050d4:	0f 84 f6 00 00 00    	je     801051d0 <sys_unlink+0x170>
  if((ip = dirlookup(dp, name, &off)) == 0)
801050da:	83 ec 04             	sub    $0x4,%esp
801050dd:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801050e0:	50                   	push   %eax
801050e1:	53                   	push   %ebx
801050e2:	56                   	push   %esi
801050e3:	e8 58 cb ff ff       	call   80101c40 <dirlookup>
801050e8:	83 c4 10             	add    $0x10,%esp
801050eb:	89 c3                	mov    %eax,%ebx
801050ed:	85 c0                	test   %eax,%eax
801050ef:	0f 84 db 00 00 00    	je     801051d0 <sys_unlink+0x170>
  ilock(ip);
801050f5:	83 ec 0c             	sub    $0xc,%esp
801050f8:	50                   	push   %eax
801050f9:	e8 12 c6 ff ff       	call   80101710 <ilock>
  if(ip->nlink < 1)
801050fe:	83 c4 10             	add    $0x10,%esp
80105101:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105106:	0f 8e 37 01 00 00    	jle    80105243 <sys_unlink+0x1e3>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010510c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105111:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105114:	74 6a                	je     80105180 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105116:	83 ec 04             	sub    $0x4,%esp
80105119:	6a 10                	push   $0x10
8010511b:	6a 00                	push   $0x0
8010511d:	57                   	push   %edi
8010511e:	e8 fd f5 ff ff       	call   80104720 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105123:	6a 10                	push   $0x10
80105125:	ff 75 c4             	pushl  -0x3c(%ebp)
80105128:	57                   	push   %edi
80105129:	56                   	push   %esi
8010512a:	e8 c1 c9 ff ff       	call   80101af0 <writei>
8010512f:	83 c4 20             	add    $0x20,%esp
80105132:	83 f8 10             	cmp    $0x10,%eax
80105135:	0f 85 fb 00 00 00    	jne    80105236 <sys_unlink+0x1d6>
  if(ip->type == T_DIR){
8010513b:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105140:	0f 84 aa 00 00 00    	je     801051f0 <sys_unlink+0x190>
  iunlockput(dp);
80105146:	83 ec 0c             	sub    $0xc,%esp
80105149:	56                   	push   %esi
8010514a:	e8 51 c8 ff ff       	call   801019a0 <iunlockput>
  ip->nlink--;
8010514f:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105154:	89 1c 24             	mov    %ebx,(%esp)
80105157:	e8 04 c5 ff ff       	call   80101660 <iupdate>
  iunlockput(ip);
8010515c:	89 1c 24             	mov    %ebx,(%esp)
8010515f:	e8 3c c8 ff ff       	call   801019a0 <iunlockput>
  end_op();
80105164:	e8 c7 dd ff ff       	call   80102f30 <end_op>
  return 0;
80105169:	83 c4 10             	add    $0x10,%esp
8010516c:	31 c0                	xor    %eax,%eax
}
8010516e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105171:	5b                   	pop    %ebx
80105172:	5e                   	pop    %esi
80105173:	5f                   	pop    %edi
80105174:	5d                   	pop    %ebp
80105175:	c3                   	ret    
80105176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010517d:	8d 76 00             	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105180:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105184:	76 90                	jbe    80105116 <sys_unlink+0xb6>
80105186:	ba 20 00 00 00       	mov    $0x20,%edx
8010518b:	eb 0f                	jmp    8010519c <sys_unlink+0x13c>
8010518d:	8d 76 00             	lea    0x0(%esi),%esi
80105190:	83 c2 10             	add    $0x10,%edx
80105193:	39 53 58             	cmp    %edx,0x58(%ebx)
80105196:	0f 86 7a ff ff ff    	jbe    80105116 <sys_unlink+0xb6>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010519c:	6a 10                	push   $0x10
8010519e:	52                   	push   %edx
8010519f:	57                   	push   %edi
801051a0:	53                   	push   %ebx
801051a1:	89 55 b4             	mov    %edx,-0x4c(%ebp)
801051a4:	e8 47 c8 ff ff       	call   801019f0 <readi>
801051a9:	83 c4 10             	add    $0x10,%esp
801051ac:	8b 55 b4             	mov    -0x4c(%ebp),%edx
801051af:	83 f8 10             	cmp    $0x10,%eax
801051b2:	75 75                	jne    80105229 <sys_unlink+0x1c9>
    if(de.inum != 0)
801051b4:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801051b9:	74 d5                	je     80105190 <sys_unlink+0x130>
    iunlockput(ip);
801051bb:	83 ec 0c             	sub    $0xc,%esp
801051be:	53                   	push   %ebx
801051bf:	e8 dc c7 ff ff       	call   801019a0 <iunlockput>
    goto bad;
801051c4:	83 c4 10             	add    $0x10,%esp
801051c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ce:	66 90                	xchg   %ax,%ax
  iunlockput(dp);
801051d0:	83 ec 0c             	sub    $0xc,%esp
801051d3:	56                   	push   %esi
801051d4:	e8 c7 c7 ff ff       	call   801019a0 <iunlockput>
  end_op();
801051d9:	e8 52 dd ff ff       	call   80102f30 <end_op>
  return -1;
801051de:	83 c4 10             	add    $0x10,%esp
801051e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051e6:	eb 86                	jmp    8010516e <sys_unlink+0x10e>
801051e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ef:	90                   	nop
    iupdate(dp);
801051f0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801051f3:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801051f8:	56                   	push   %esi
801051f9:	e8 62 c4 ff ff       	call   80101660 <iupdate>
801051fe:	83 c4 10             	add    $0x10,%esp
80105201:	e9 40 ff ff ff       	jmp    80105146 <sys_unlink+0xe6>
80105206:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010520d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105215:	e9 54 ff ff ff       	jmp    8010516e <sys_unlink+0x10e>
    end_op();
8010521a:	e8 11 dd ff ff       	call   80102f30 <end_op>
    return -1;
8010521f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105224:	e9 45 ff ff ff       	jmp    8010516e <sys_unlink+0x10e>
      panic("isdirempty: readi");
80105229:	83 ec 0c             	sub    $0xc,%esp
8010522c:	68 3c 79 10 80       	push   $0x8010793c
80105231:	e8 4a b1 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
80105236:	83 ec 0c             	sub    $0xc,%esp
80105239:	68 4e 79 10 80       	push   $0x8010794e
8010523e:	e8 3d b1 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
80105243:	83 ec 0c             	sub    $0xc,%esp
80105246:	68 2a 79 10 80       	push   $0x8010792a
8010524b:	e8 30 b1 ff ff       	call   80100380 <panic>

80105250 <sys_open>:

int
sys_open(void)
{
80105250:	55                   	push   %ebp
80105251:	89 e5                	mov    %esp,%ebp
80105253:	57                   	push   %edi
80105254:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105255:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105258:	53                   	push   %ebx
80105259:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010525c:	50                   	push   %eax
8010525d:	6a 00                	push   $0x0
8010525f:	e8 2c f8 ff ff       	call   80104a90 <argstr>
80105264:	83 c4 10             	add    $0x10,%esp
80105267:	85 c0                	test   %eax,%eax
80105269:	0f 88 8e 00 00 00    	js     801052fd <sys_open+0xad>
8010526f:	83 ec 08             	sub    $0x8,%esp
80105272:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105275:	50                   	push   %eax
80105276:	6a 01                	push   $0x1
80105278:	e8 63 f7 ff ff       	call   801049e0 <argint>
8010527d:	83 c4 10             	add    $0x10,%esp
80105280:	85 c0                	test   %eax,%eax
80105282:	78 79                	js     801052fd <sys_open+0xad>
    return -1;

  begin_op();
80105284:	e8 37 dc ff ff       	call   80102ec0 <begin_op>

  if(omode & O_CREATE){
80105289:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010528d:	75 79                	jne    80105308 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010528f:	83 ec 0c             	sub    $0xc,%esp
80105292:	ff 75 e0             	pushl  -0x20(%ebp)
80105295:	e8 16 cd ff ff       	call   80101fb0 <namei>
8010529a:	83 c4 10             	add    $0x10,%esp
8010529d:	89 c6                	mov    %eax,%esi
8010529f:	85 c0                	test   %eax,%eax
801052a1:	0f 84 7e 00 00 00    	je     80105325 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
801052a7:	83 ec 0c             	sub    $0xc,%esp
801052aa:	50                   	push   %eax
801052ab:	e8 60 c4 ff ff       	call   80101710 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801052b0:	83 c4 10             	add    $0x10,%esp
801052b3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801052b8:	0f 84 c2 00 00 00    	je     80105380 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801052be:	e8 2d bb ff ff       	call   80100df0 <filealloc>
801052c3:	89 c7                	mov    %eax,%edi
801052c5:	85 c0                	test   %eax,%eax
801052c7:	74 23                	je     801052ec <sys_open+0x9c>
  struct proc *curproc = myproc();
801052c9:	e8 e2 e7 ff ff       	call   80103ab0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801052ce:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801052d0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801052d4:	85 d2                	test   %edx,%edx
801052d6:	74 60                	je     80105338 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
801052d8:	83 c3 01             	add    $0x1,%ebx
801052db:	83 fb 10             	cmp    $0x10,%ebx
801052de:	75 f0                	jne    801052d0 <sys_open+0x80>
    if(f)
      fileclose(f);
801052e0:	83 ec 0c             	sub    $0xc,%esp
801052e3:	57                   	push   %edi
801052e4:	e8 c7 bb ff ff       	call   80100eb0 <fileclose>
801052e9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801052ec:	83 ec 0c             	sub    $0xc,%esp
801052ef:	56                   	push   %esi
801052f0:	e8 ab c6 ff ff       	call   801019a0 <iunlockput>
    end_op();
801052f5:	e8 36 dc ff ff       	call   80102f30 <end_op>
    return -1;
801052fa:	83 c4 10             	add    $0x10,%esp
801052fd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105302:	eb 6d                	jmp    80105371 <sys_open+0x121>
80105304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105308:	83 ec 0c             	sub    $0xc,%esp
8010530b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010530e:	31 c9                	xor    %ecx,%ecx
80105310:	ba 02 00 00 00       	mov    $0x2,%edx
80105315:	6a 00                	push   $0x0
80105317:	e8 24 f8 ff ff       	call   80104b40 <create>
    if(ip == 0){
8010531c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010531f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105321:	85 c0                	test   %eax,%eax
80105323:	75 99                	jne    801052be <sys_open+0x6e>
      end_op();
80105325:	e8 06 dc ff ff       	call   80102f30 <end_op>
      return -1;
8010532a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010532f:	eb 40                	jmp    80105371 <sys_open+0x121>
80105331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105338:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010533b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010533f:	56                   	push   %esi
80105340:	e8 ab c4 ff ff       	call   801017f0 <iunlock>
  end_op();
80105345:	e8 e6 db ff ff       	call   80102f30 <end_op>

  f->type = FD_INODE;
8010534a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105350:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105353:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105356:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105359:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010535b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105362:	f7 d0                	not    %eax
80105364:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105367:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010536a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010536d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105371:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105374:	89 d8                	mov    %ebx,%eax
80105376:	5b                   	pop    %ebx
80105377:	5e                   	pop    %esi
80105378:	5f                   	pop    %edi
80105379:	5d                   	pop    %ebp
8010537a:	c3                   	ret    
8010537b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010537f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105380:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105383:	85 c9                	test   %ecx,%ecx
80105385:	0f 84 33 ff ff ff    	je     801052be <sys_open+0x6e>
8010538b:	e9 5c ff ff ff       	jmp    801052ec <sys_open+0x9c>

80105390 <sys_mkdir>:

int
sys_mkdir(void)
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105396:	e8 25 db ff ff       	call   80102ec0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010539b:	83 ec 08             	sub    $0x8,%esp
8010539e:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053a1:	50                   	push   %eax
801053a2:	6a 00                	push   $0x0
801053a4:	e8 e7 f6 ff ff       	call   80104a90 <argstr>
801053a9:	83 c4 10             	add    $0x10,%esp
801053ac:	85 c0                	test   %eax,%eax
801053ae:	78 30                	js     801053e0 <sys_mkdir+0x50>
801053b0:	83 ec 0c             	sub    $0xc,%esp
801053b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053b6:	31 c9                	xor    %ecx,%ecx
801053b8:	ba 01 00 00 00       	mov    $0x1,%edx
801053bd:	6a 00                	push   $0x0
801053bf:	e8 7c f7 ff ff       	call   80104b40 <create>
801053c4:	83 c4 10             	add    $0x10,%esp
801053c7:	85 c0                	test   %eax,%eax
801053c9:	74 15                	je     801053e0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053cb:	83 ec 0c             	sub    $0xc,%esp
801053ce:	50                   	push   %eax
801053cf:	e8 cc c5 ff ff       	call   801019a0 <iunlockput>
  end_op();
801053d4:	e8 57 db ff ff       	call   80102f30 <end_op>
  return 0;
801053d9:	83 c4 10             	add    $0x10,%esp
801053dc:	31 c0                	xor    %eax,%eax
}
801053de:	c9                   	leave  
801053df:	c3                   	ret    
    end_op();
801053e0:	e8 4b db ff ff       	call   80102f30 <end_op>
    return -1;
801053e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053ea:	c9                   	leave  
801053eb:	c3                   	ret    
801053ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053f0 <sys_mknod>:

int
sys_mknod(void)
{
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801053f6:	e8 c5 da ff ff       	call   80102ec0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801053fb:	83 ec 08             	sub    $0x8,%esp
801053fe:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105401:	50                   	push   %eax
80105402:	6a 00                	push   $0x0
80105404:	e8 87 f6 ff ff       	call   80104a90 <argstr>
80105409:	83 c4 10             	add    $0x10,%esp
8010540c:	85 c0                	test   %eax,%eax
8010540e:	78 60                	js     80105470 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105410:	83 ec 08             	sub    $0x8,%esp
80105413:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105416:	50                   	push   %eax
80105417:	6a 01                	push   $0x1
80105419:	e8 c2 f5 ff ff       	call   801049e0 <argint>
  if((argstr(0, &path)) < 0 ||
8010541e:	83 c4 10             	add    $0x10,%esp
80105421:	85 c0                	test   %eax,%eax
80105423:	78 4b                	js     80105470 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105425:	83 ec 08             	sub    $0x8,%esp
80105428:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010542b:	50                   	push   %eax
8010542c:	6a 02                	push   $0x2
8010542e:	e8 ad f5 ff ff       	call   801049e0 <argint>
     argint(1, &major) < 0 ||
80105433:	83 c4 10             	add    $0x10,%esp
80105436:	85 c0                	test   %eax,%eax
80105438:	78 36                	js     80105470 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010543a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010543e:	83 ec 0c             	sub    $0xc,%esp
80105441:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105445:	ba 03 00 00 00       	mov    $0x3,%edx
8010544a:	50                   	push   %eax
8010544b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010544e:	e8 ed f6 ff ff       	call   80104b40 <create>
     argint(2, &minor) < 0 ||
80105453:	83 c4 10             	add    $0x10,%esp
80105456:	85 c0                	test   %eax,%eax
80105458:	74 16                	je     80105470 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010545a:	83 ec 0c             	sub    $0xc,%esp
8010545d:	50                   	push   %eax
8010545e:	e8 3d c5 ff ff       	call   801019a0 <iunlockput>
  end_op();
80105463:	e8 c8 da ff ff       	call   80102f30 <end_op>
  return 0;
80105468:	83 c4 10             	add    $0x10,%esp
8010546b:	31 c0                	xor    %eax,%eax
}
8010546d:	c9                   	leave  
8010546e:	c3                   	ret    
8010546f:	90                   	nop
    end_op();
80105470:	e8 bb da ff ff       	call   80102f30 <end_op>
    return -1;
80105475:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010547a:	c9                   	leave  
8010547b:	c3                   	ret    
8010547c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105480 <sys_chdir>:

int
sys_chdir(void)
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	56                   	push   %esi
80105484:	53                   	push   %ebx
80105485:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105488:	e8 23 e6 ff ff       	call   80103ab0 <myproc>
8010548d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010548f:	e8 2c da ff ff       	call   80102ec0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105494:	83 ec 08             	sub    $0x8,%esp
80105497:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010549a:	50                   	push   %eax
8010549b:	6a 00                	push   $0x0
8010549d:	e8 ee f5 ff ff       	call   80104a90 <argstr>
801054a2:	83 c4 10             	add    $0x10,%esp
801054a5:	85 c0                	test   %eax,%eax
801054a7:	78 77                	js     80105520 <sys_chdir+0xa0>
801054a9:	83 ec 0c             	sub    $0xc,%esp
801054ac:	ff 75 f4             	pushl  -0xc(%ebp)
801054af:	e8 fc ca ff ff       	call   80101fb0 <namei>
801054b4:	83 c4 10             	add    $0x10,%esp
801054b7:	89 c3                	mov    %eax,%ebx
801054b9:	85 c0                	test   %eax,%eax
801054bb:	74 63                	je     80105520 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801054bd:	83 ec 0c             	sub    $0xc,%esp
801054c0:	50                   	push   %eax
801054c1:	e8 4a c2 ff ff       	call   80101710 <ilock>
  if(ip->type != T_DIR){
801054c6:	83 c4 10             	add    $0x10,%esp
801054c9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054ce:	75 30                	jne    80105500 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054d0:	83 ec 0c             	sub    $0xc,%esp
801054d3:	53                   	push   %ebx
801054d4:	e8 17 c3 ff ff       	call   801017f0 <iunlock>
  iput(curproc->cwd);
801054d9:	58                   	pop    %eax
801054da:	ff 76 68             	pushl  0x68(%esi)
801054dd:	e8 5e c3 ff ff       	call   80101840 <iput>
  end_op();
801054e2:	e8 49 da ff ff       	call   80102f30 <end_op>
  curproc->cwd = ip;
801054e7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801054ea:	83 c4 10             	add    $0x10,%esp
801054ed:	31 c0                	xor    %eax,%eax
}
801054ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054f2:	5b                   	pop    %ebx
801054f3:	5e                   	pop    %esi
801054f4:	5d                   	pop    %ebp
801054f5:	c3                   	ret    
801054f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054fd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105500:	83 ec 0c             	sub    $0xc,%esp
80105503:	53                   	push   %ebx
80105504:	e8 97 c4 ff ff       	call   801019a0 <iunlockput>
    end_op();
80105509:	e8 22 da ff ff       	call   80102f30 <end_op>
    return -1;
8010550e:	83 c4 10             	add    $0x10,%esp
80105511:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105516:	eb d7                	jmp    801054ef <sys_chdir+0x6f>
80105518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010551f:	90                   	nop
    end_op();
80105520:	e8 0b da ff ff       	call   80102f30 <end_op>
    return -1;
80105525:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010552a:	eb c3                	jmp    801054ef <sys_chdir+0x6f>
8010552c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105530 <sys_exec>:

int
sys_exec(void)
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	57                   	push   %edi
80105534:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105535:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010553b:	53                   	push   %ebx
8010553c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105542:	50                   	push   %eax
80105543:	6a 00                	push   $0x0
80105545:	e8 46 f5 ff ff       	call   80104a90 <argstr>
8010554a:	83 c4 10             	add    $0x10,%esp
8010554d:	85 c0                	test   %eax,%eax
8010554f:	0f 88 87 00 00 00    	js     801055dc <sys_exec+0xac>
80105555:	83 ec 08             	sub    $0x8,%esp
80105558:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010555e:	50                   	push   %eax
8010555f:	6a 01                	push   $0x1
80105561:	e8 7a f4 ff ff       	call   801049e0 <argint>
80105566:	83 c4 10             	add    $0x10,%esp
80105569:	85 c0                	test   %eax,%eax
8010556b:	78 6f                	js     801055dc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010556d:	83 ec 04             	sub    $0x4,%esp
80105570:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80105576:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105578:	68 80 00 00 00       	push   $0x80
8010557d:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105583:	6a 00                	push   $0x0
80105585:	50                   	push   %eax
80105586:	e8 95 f1 ff ff       	call   80104720 <memset>
8010558b:	83 c4 10             	add    $0x10,%esp
8010558e:	66 90                	xchg   %ax,%ax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105590:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105596:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
8010559d:	83 ec 08             	sub    $0x8,%esp
801055a0:	57                   	push   %edi
801055a1:	01 f0                	add    %esi,%eax
801055a3:	50                   	push   %eax
801055a4:	e8 a7 f3 ff ff       	call   80104950 <fetchint>
801055a9:	83 c4 10             	add    $0x10,%esp
801055ac:	85 c0                	test   %eax,%eax
801055ae:	78 2c                	js     801055dc <sys_exec+0xac>
      return -1;
    if(uarg == 0){
801055b0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801055b6:	85 c0                	test   %eax,%eax
801055b8:	74 36                	je     801055f0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801055ba:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801055c0:	83 ec 08             	sub    $0x8,%esp
801055c3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801055c6:	52                   	push   %edx
801055c7:	50                   	push   %eax
801055c8:	e8 c3 f3 ff ff       	call   80104990 <fetchstr>
801055cd:	83 c4 10             	add    $0x10,%esp
801055d0:	85 c0                	test   %eax,%eax
801055d2:	78 08                	js     801055dc <sys_exec+0xac>
  for(i=0;; i++){
801055d4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801055d7:	83 fb 20             	cmp    $0x20,%ebx
801055da:	75 b4                	jne    80105590 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801055dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801055df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055e4:	5b                   	pop    %ebx
801055e5:	5e                   	pop    %esi
801055e6:	5f                   	pop    %edi
801055e7:	5d                   	pop    %ebp
801055e8:	c3                   	ret    
801055e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801055f0:	83 ec 08             	sub    $0x8,%esp
801055f3:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
801055f9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105600:	00 00 00 00 
  return exec(path, argv);
80105604:	50                   	push   %eax
80105605:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010560b:	e8 60 b4 ff ff       	call   80100a70 <exec>
80105610:	83 c4 10             	add    $0x10,%esp
}
80105613:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105616:	5b                   	pop    %ebx
80105617:	5e                   	pop    %esi
80105618:	5f                   	pop    %edi
80105619:	5d                   	pop    %ebp
8010561a:	c3                   	ret    
8010561b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010561f:	90                   	nop

80105620 <sys_pipe>:

int
sys_pipe(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	57                   	push   %edi
80105624:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105625:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105628:	53                   	push   %ebx
80105629:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010562c:	6a 08                	push   $0x8
8010562e:	50                   	push   %eax
8010562f:	6a 00                	push   $0x0
80105631:	e8 fa f3 ff ff       	call   80104a30 <argptr>
80105636:	83 c4 10             	add    $0x10,%esp
80105639:	85 c0                	test   %eax,%eax
8010563b:	78 4a                	js     80105687 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010563d:	83 ec 08             	sub    $0x8,%esp
80105640:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105643:	50                   	push   %eax
80105644:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105647:	50                   	push   %eax
80105648:	e8 13 df ff ff       	call   80103560 <pipealloc>
8010564d:	83 c4 10             	add    $0x10,%esp
80105650:	85 c0                	test   %eax,%eax
80105652:	78 33                	js     80105687 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105654:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105657:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105659:	e8 52 e4 ff ff       	call   80103ab0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010565e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105660:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105664:	85 f6                	test   %esi,%esi
80105666:	74 28                	je     80105690 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105668:	83 c3 01             	add    $0x1,%ebx
8010566b:	83 fb 10             	cmp    $0x10,%ebx
8010566e:	75 f0                	jne    80105660 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105670:	83 ec 0c             	sub    $0xc,%esp
80105673:	ff 75 e0             	pushl  -0x20(%ebp)
80105676:	e8 35 b8 ff ff       	call   80100eb0 <fileclose>
    fileclose(wf);
8010567b:	58                   	pop    %eax
8010567c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010567f:	e8 2c b8 ff ff       	call   80100eb0 <fileclose>
    return -1;
80105684:	83 c4 10             	add    $0x10,%esp
80105687:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010568c:	eb 53                	jmp    801056e1 <sys_pipe+0xc1>
8010568e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105690:	8d 73 08             	lea    0x8(%ebx),%esi
80105693:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105697:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010569a:	e8 11 e4 ff ff       	call   80103ab0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010569f:	31 d2                	xor    %edx,%edx
801056a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801056a8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801056ac:	85 c9                	test   %ecx,%ecx
801056ae:	74 20                	je     801056d0 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
801056b0:	83 c2 01             	add    $0x1,%edx
801056b3:	83 fa 10             	cmp    $0x10,%edx
801056b6:	75 f0                	jne    801056a8 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
801056b8:	e8 f3 e3 ff ff       	call   80103ab0 <myproc>
801056bd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801056c4:	00 
801056c5:	eb a9                	jmp    80105670 <sys_pipe+0x50>
801056c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ce:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801056d0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
801056d4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056d7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801056d9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056dc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801056df:	31 c0                	xor    %eax,%eax
}
801056e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056e4:	5b                   	pop    %ebx
801056e5:	5e                   	pop    %esi
801056e6:	5f                   	pop    %edi
801056e7:	5d                   	pop    %ebp
801056e8:	c3                   	ret    
801056e9:	66 90                	xchg   %ax,%ax
801056eb:	66 90                	xchg   %ax,%ax
801056ed:	66 90                	xchg   %ax,%ax
801056ef:	90                   	nop

801056f0 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801056f0:	e9 5b e5 ff ff       	jmp    80103c50 <fork>
801056f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105700 <sys_exit>:
}

int
sys_exit(void)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	83 ec 08             	sub    $0x8,%esp
  exit();
80105706:	e8 c5 e7 ff ff       	call   80103ed0 <exit>
  return 0;  // not reached
}
8010570b:	31 c0                	xor    %eax,%eax
8010570d:	c9                   	leave  
8010570e:	c3                   	ret    
8010570f:	90                   	nop

80105710 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105710:	e9 fb e9 ff ff       	jmp    80104110 <wait>
80105715:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010571c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105720 <sys_kill>:
}

int
sys_kill(void)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105726:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105729:	50                   	push   %eax
8010572a:	6a 00                	push   $0x0
8010572c:	e8 af f2 ff ff       	call   801049e0 <argint>
80105731:	83 c4 10             	add    $0x10,%esp
80105734:	85 c0                	test   %eax,%eax
80105736:	78 18                	js     80105750 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105738:	83 ec 0c             	sub    $0xc,%esp
8010573b:	ff 75 f4             	pushl  -0xc(%ebp)
8010573e:	e8 1d eb ff ff       	call   80104260 <kill>
80105743:	83 c4 10             	add    $0x10,%esp
}
80105746:	c9                   	leave  
80105747:	c3                   	ret    
80105748:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010574f:	90                   	nop
80105750:	c9                   	leave  
    return -1;
80105751:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105756:	c3                   	ret    
80105757:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010575e:	66 90                	xchg   %ax,%ax

80105760 <sys_getpid>:

int
sys_getpid(void)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105766:	e8 45 e3 ff ff       	call   80103ab0 <myproc>
8010576b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010576e:	c9                   	leave  
8010576f:	c3                   	ret    

80105770 <sys_sbrk>:

int
sys_sbrk(void)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105774:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105777:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010577a:	50                   	push   %eax
8010577b:	6a 00                	push   $0x0
8010577d:	e8 5e f2 ff ff       	call   801049e0 <argint>
80105782:	83 c4 10             	add    $0x10,%esp
80105785:	85 c0                	test   %eax,%eax
80105787:	78 27                	js     801057b0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105789:	e8 22 e3 ff ff       	call   80103ab0 <myproc>
  if(growproc(n) < 0)
8010578e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105791:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105793:	ff 75 f4             	pushl  -0xc(%ebp)
80105796:	e8 35 e4 ff ff       	call   80103bd0 <growproc>
8010579b:	83 c4 10             	add    $0x10,%esp
8010579e:	85 c0                	test   %eax,%eax
801057a0:	78 0e                	js     801057b0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801057a2:	89 d8                	mov    %ebx,%eax
801057a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057a7:	c9                   	leave  
801057a8:	c3                   	ret    
801057a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801057b0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801057b5:	eb eb                	jmp    801057a2 <sys_sbrk+0x32>
801057b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057be:	66 90                	xchg   %ax,%ax

801057c0 <sys_sleep>:

int
sys_sleep(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801057c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801057c7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801057ca:	50                   	push   %eax
801057cb:	6a 00                	push   $0x0
801057cd:	e8 0e f2 ff ff       	call   801049e0 <argint>
801057d2:	83 c4 10             	add    $0x10,%esp
801057d5:	85 c0                	test   %eax,%eax
801057d7:	0f 88 8a 00 00 00    	js     80105867 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801057dd:	83 ec 0c             	sub    $0xc,%esp
801057e0:	68 60 4c 11 80       	push   $0x80114c60
801057e5:	e8 c6 ed ff ff       	call   801045b0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801057ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801057ed:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  while(ticks - ticks0 < n){
801057f3:	83 c4 10             	add    $0x10,%esp
801057f6:	85 d2                	test   %edx,%edx
801057f8:	75 27                	jne    80105821 <sys_sleep+0x61>
801057fa:	eb 54                	jmp    80105850 <sys_sleep+0x90>
801057fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105800:	83 ec 08             	sub    $0x8,%esp
80105803:	68 60 4c 11 80       	push   $0x80114c60
80105808:	68 a0 54 11 80       	push   $0x801154a0
8010580d:	e8 3e e8 ff ff       	call   80104050 <sleep>
  while(ticks - ticks0 < n){
80105812:	a1 a0 54 11 80       	mov    0x801154a0,%eax
80105817:	83 c4 10             	add    $0x10,%esp
8010581a:	29 d8                	sub    %ebx,%eax
8010581c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010581f:	73 2f                	jae    80105850 <sys_sleep+0x90>
    if(myproc()->killed){
80105821:	e8 8a e2 ff ff       	call   80103ab0 <myproc>
80105826:	8b 40 24             	mov    0x24(%eax),%eax
80105829:	85 c0                	test   %eax,%eax
8010582b:	74 d3                	je     80105800 <sys_sleep+0x40>
      release(&tickslock);
8010582d:	83 ec 0c             	sub    $0xc,%esp
80105830:	68 60 4c 11 80       	push   $0x80114c60
80105835:	e8 96 ee ff ff       	call   801046d0 <release>
  }
  release(&tickslock);
  return 0;
}
8010583a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010583d:	83 c4 10             	add    $0x10,%esp
80105840:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105845:	c9                   	leave  
80105846:	c3                   	ret    
80105847:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010584e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105850:	83 ec 0c             	sub    $0xc,%esp
80105853:	68 60 4c 11 80       	push   $0x80114c60
80105858:	e8 73 ee ff ff       	call   801046d0 <release>
  return 0;
8010585d:	83 c4 10             	add    $0x10,%esp
80105860:	31 c0                	xor    %eax,%eax
}
80105862:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105865:	c9                   	leave  
80105866:	c3                   	ret    
    return -1;
80105867:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586c:	eb f4                	jmp    80105862 <sys_sleep+0xa2>
8010586e:	66 90                	xchg   %ax,%ax

80105870 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	53                   	push   %ebx
80105874:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105877:	68 60 4c 11 80       	push   $0x80114c60
8010587c:	e8 2f ed ff ff       	call   801045b0 <acquire>
  xticks = ticks;
80105881:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  release(&tickslock);
80105887:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
8010588e:	e8 3d ee ff ff       	call   801046d0 <release>
  return xticks;


}
80105893:	89 d8                	mov    %ebx,%eax
80105895:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105898:	c9                   	leave  
80105899:	c3                   	ret    
8010589a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801058a0 <sys_pfs>:

int
sys_pfs(void)
{
	return pfs();
801058a0:	e9 4b c7 ff ff       	jmp    80101ff0 <pfs>

801058a5 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801058a5:	1e                   	push   %ds
  pushl %es
801058a6:	06                   	push   %es
  pushl %fs
801058a7:	0f a0                	push   %fs
  pushl %gs
801058a9:	0f a8                	push   %gs
  pushal
801058ab:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801058ac:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801058b0:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801058b2:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801058b4:	54                   	push   %esp
  call trap
801058b5:	e8 c6 00 00 00       	call   80105980 <trap>
  addl $4, %esp
801058ba:	83 c4 04             	add    $0x4,%esp

801058bd <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801058bd:	61                   	popa   
  popl %gs
801058be:	0f a9                	pop    %gs
  popl %fs
801058c0:	0f a1                	pop    %fs
  popl %es
801058c2:	07                   	pop    %es
  popl %ds
801058c3:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801058c4:	83 c4 08             	add    $0x8,%esp
  iret
801058c7:	cf                   	iret   
801058c8:	66 90                	xchg   %ax,%ax
801058ca:	66 90                	xchg   %ax,%ax
801058cc:	66 90                	xchg   %ax,%ax
801058ce:	66 90                	xchg   %ax,%ax

801058d0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801058d0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801058d1:	31 c0                	xor    %eax,%eax
{
801058d3:	89 e5                	mov    %esp,%ebp
801058d5:	83 ec 08             	sub    $0x8,%esp
801058d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058df:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801058e0:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
801058e7:	c7 04 c5 a2 4c 11 80 	movl   $0x8e000008,-0x7feeb35e(,%eax,8)
801058ee:	08 00 00 8e 
801058f2:	66 89 14 c5 a0 4c 11 	mov    %dx,-0x7feeb360(,%eax,8)
801058f9:	80 
801058fa:	c1 ea 10             	shr    $0x10,%edx
801058fd:	66 89 14 c5 a6 4c 11 	mov    %dx,-0x7feeb35a(,%eax,8)
80105904:	80 
  for(i = 0; i < 256; i++)
80105905:	83 c0 01             	add    $0x1,%eax
80105908:	3d 00 01 00 00       	cmp    $0x100,%eax
8010590d:	75 d1                	jne    801058e0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010590f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105912:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105917:	c7 05 a2 4e 11 80 08 	movl   $0xef000008,0x80114ea2
8010591e:	00 00 ef 
  initlock(&tickslock, "time");
80105921:	68 5d 79 10 80       	push   $0x8010795d
80105926:	68 60 4c 11 80       	push   $0x80114c60
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010592b:	66 a3 a0 4e 11 80    	mov    %ax,0x80114ea0
80105931:	c1 e8 10             	shr    $0x10,%eax
80105934:	66 a3 a6 4e 11 80    	mov    %ax,0x80114ea6
  initlock(&tickslock, "time");
8010593a:	e8 71 eb ff ff       	call   801044b0 <initlock>
}
8010593f:	83 c4 10             	add    $0x10,%esp
80105942:	c9                   	leave  
80105943:	c3                   	ret    
80105944:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010594b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010594f:	90                   	nop

80105950 <idtinit>:

void
idtinit(void)
{
80105950:	55                   	push   %ebp
  pd[0] = size-1;
80105951:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105956:	89 e5                	mov    %esp,%ebp
80105958:	83 ec 10             	sub    $0x10,%esp
8010595b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010595f:	b8 a0 4c 11 80       	mov    $0x80114ca0,%eax
80105964:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105968:	c1 e8 10             	shr    $0x10,%eax
8010596b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010596f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105972:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105975:	c9                   	leave  
80105976:	c3                   	ret    
80105977:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010597e:	66 90                	xchg   %ax,%ax

80105980 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	57                   	push   %edi
80105984:	56                   	push   %esi
80105985:	53                   	push   %ebx
80105986:	83 ec 1c             	sub    $0x1c,%esp
80105989:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010598c:	8b 43 30             	mov    0x30(%ebx),%eax
8010598f:	83 f8 40             	cmp    $0x40,%eax
80105992:	0f 84 c0 01 00 00    	je     80105b58 <trap+0x1d8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105998:	83 e8 20             	sub    $0x20,%eax
8010599b:	83 f8 1f             	cmp    $0x1f,%eax
8010599e:	77 07                	ja     801059a7 <trap+0x27>
801059a0:	ff 24 85 04 7a 10 80 	jmp    *-0x7fef85fc(,%eax,4)
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801059a7:	e8 04 e1 ff ff       	call   80103ab0 <myproc>
801059ac:	8b 7b 38             	mov    0x38(%ebx),%edi
801059af:	85 c0                	test   %eax,%eax
801059b1:	0f 84 f0 01 00 00    	je     80105ba7 <trap+0x227>
801059b7:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801059bb:	0f 84 e6 01 00 00    	je     80105ba7 <trap+0x227>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801059c1:	0f 20 d1             	mov    %cr2,%ecx
801059c4:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801059c7:	e8 c4 e0 ff ff       	call   80103a90 <cpuid>
801059cc:	8b 73 30             	mov    0x30(%ebx),%esi
801059cf:	89 45 dc             	mov    %eax,-0x24(%ebp)
801059d2:	8b 43 34             	mov    0x34(%ebx),%eax
801059d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801059d8:	e8 d3 e0 ff ff       	call   80103ab0 <myproc>
801059dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
801059e0:	e8 cb e0 ff ff       	call   80103ab0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801059e5:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801059e8:	8b 55 dc             	mov    -0x24(%ebp),%edx
801059eb:	51                   	push   %ecx
801059ec:	57                   	push   %edi
801059ed:	52                   	push   %edx
801059ee:	ff 75 e4             	pushl  -0x1c(%ebp)
801059f1:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801059f2:	8b 75 e0             	mov    -0x20(%ebp),%esi
801059f5:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801059f8:	56                   	push   %esi
801059f9:	ff 70 10             	pushl  0x10(%eax)
801059fc:	68 c0 79 10 80       	push   $0x801079c0
80105a01:	e8 9a ac ff ff       	call   801006a0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105a06:	83 c4 20             	add    $0x20,%esp
80105a09:	e8 a2 e0 ff ff       	call   80103ab0 <myproc>
80105a0e:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a15:	e8 96 e0 ff ff       	call   80103ab0 <myproc>
80105a1a:	85 c0                	test   %eax,%eax
80105a1c:	74 1d                	je     80105a3b <trap+0xbb>
80105a1e:	e8 8d e0 ff ff       	call   80103ab0 <myproc>
80105a23:	8b 50 24             	mov    0x24(%eax),%edx
80105a26:	85 d2                	test   %edx,%edx
80105a28:	74 11                	je     80105a3b <trap+0xbb>
80105a2a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a2e:	83 e0 03             	and    $0x3,%eax
80105a31:	66 83 f8 03          	cmp    $0x3,%ax
80105a35:	0f 84 55 01 00 00    	je     80105b90 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105a3b:	e8 70 e0 ff ff       	call   80103ab0 <myproc>
80105a40:	85 c0                	test   %eax,%eax
80105a42:	74 0f                	je     80105a53 <trap+0xd3>
80105a44:	e8 67 e0 ff ff       	call   80103ab0 <myproc>
80105a49:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a4d:	0f 84 ed 00 00 00    	je     80105b40 <trap+0x1c0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a53:	e8 58 e0 ff ff       	call   80103ab0 <myproc>
80105a58:	85 c0                	test   %eax,%eax
80105a5a:	74 1d                	je     80105a79 <trap+0xf9>
80105a5c:	e8 4f e0 ff ff       	call   80103ab0 <myproc>
80105a61:	8b 40 24             	mov    0x24(%eax),%eax
80105a64:	85 c0                	test   %eax,%eax
80105a66:	74 11                	je     80105a79 <trap+0xf9>
80105a68:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a6c:	83 e0 03             	and    $0x3,%eax
80105a6f:	66 83 f8 03          	cmp    $0x3,%ax
80105a73:	0f 84 08 01 00 00    	je     80105b81 <trap+0x201>
    exit();
}
80105a79:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a7c:	5b                   	pop    %ebx
80105a7d:	5e                   	pop    %esi
80105a7e:	5f                   	pop    %edi
80105a7f:	5d                   	pop    %ebp
80105a80:	c3                   	ret    
    ideintr();
80105a81:	e8 1a c9 ff ff       	call   801023a0 <ideintr>
    lapiceoi();
80105a86:	e8 e5 cf ff ff       	call   80102a70 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a8b:	e8 20 e0 ff ff       	call   80103ab0 <myproc>
80105a90:	85 c0                	test   %eax,%eax
80105a92:	75 8a                	jne    80105a1e <trap+0x9e>
80105a94:	eb a5                	jmp    80105a3b <trap+0xbb>
    if(cpuid() == 0){
80105a96:	e8 f5 df ff ff       	call   80103a90 <cpuid>
80105a9b:	85 c0                	test   %eax,%eax
80105a9d:	75 e7                	jne    80105a86 <trap+0x106>
      acquire(&tickslock);
80105a9f:	83 ec 0c             	sub    $0xc,%esp
80105aa2:	68 60 4c 11 80       	push   $0x80114c60
80105aa7:	e8 04 eb ff ff       	call   801045b0 <acquire>
      wakeup(&ticks);
80105aac:	c7 04 24 a0 54 11 80 	movl   $0x801154a0,(%esp)
      ticks++;
80105ab3:	83 05 a0 54 11 80 01 	addl   $0x1,0x801154a0
      wakeup(&ticks);
80105aba:	e8 41 e7 ff ff       	call   80104200 <wakeup>
      release(&tickslock);
80105abf:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105ac6:	e8 05 ec ff ff       	call   801046d0 <release>
80105acb:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105ace:	eb b6                	jmp    80105a86 <trap+0x106>
    kbdintr();
80105ad0:	e8 5b ce ff ff       	call   80102930 <kbdintr>
    lapiceoi();
80105ad5:	e8 96 cf ff ff       	call   80102a70 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ada:	e8 d1 df ff ff       	call   80103ab0 <myproc>
80105adf:	85 c0                	test   %eax,%eax
80105ae1:	0f 85 37 ff ff ff    	jne    80105a1e <trap+0x9e>
80105ae7:	e9 4f ff ff ff       	jmp    80105a3b <trap+0xbb>
    uartintr();
80105aec:	e8 4f 02 00 00       	call   80105d40 <uartintr>
    lapiceoi();
80105af1:	e8 7a cf ff ff       	call   80102a70 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105af6:	e8 b5 df ff ff       	call   80103ab0 <myproc>
80105afb:	85 c0                	test   %eax,%eax
80105afd:	0f 85 1b ff ff ff    	jne    80105a1e <trap+0x9e>
80105b03:	e9 33 ff ff ff       	jmp    80105a3b <trap+0xbb>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b08:	8b 7b 38             	mov    0x38(%ebx),%edi
80105b0b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105b0f:	e8 7c df ff ff       	call   80103a90 <cpuid>
80105b14:	57                   	push   %edi
80105b15:	56                   	push   %esi
80105b16:	50                   	push   %eax
80105b17:	68 68 79 10 80       	push   $0x80107968
80105b1c:	e8 7f ab ff ff       	call   801006a0 <cprintf>
    lapiceoi();
80105b21:	e8 4a cf ff ff       	call   80102a70 <lapiceoi>
    break;
80105b26:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b29:	e8 82 df ff ff       	call   80103ab0 <myproc>
80105b2e:	85 c0                	test   %eax,%eax
80105b30:	0f 85 e8 fe ff ff    	jne    80105a1e <trap+0x9e>
80105b36:	e9 00 ff ff ff       	jmp    80105a3b <trap+0xbb>
80105b3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b3f:	90                   	nop
  if(myproc() && myproc()->state == RUNNING &&
80105b40:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105b44:	0f 85 09 ff ff ff    	jne    80105a53 <trap+0xd3>
    yield();
80105b4a:	e8 b1 e4 ff ff       	call   80104000 <yield>
80105b4f:	e9 ff fe ff ff       	jmp    80105a53 <trap+0xd3>
80105b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105b58:	e8 53 df ff ff       	call   80103ab0 <myproc>
80105b5d:	8b 70 24             	mov    0x24(%eax),%esi
80105b60:	85 f6                	test   %esi,%esi
80105b62:	75 3c                	jne    80105ba0 <trap+0x220>
    myproc()->tf = tf;
80105b64:	e8 47 df ff ff       	call   80103ab0 <myproc>
80105b69:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105b6c:	e8 5f ef ff ff       	call   80104ad0 <syscall>
    if(myproc()->killed)
80105b71:	e8 3a df ff ff       	call   80103ab0 <myproc>
80105b76:	8b 48 24             	mov    0x24(%eax),%ecx
80105b79:	85 c9                	test   %ecx,%ecx
80105b7b:	0f 84 f8 fe ff ff    	je     80105a79 <trap+0xf9>
}
80105b81:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b84:	5b                   	pop    %ebx
80105b85:	5e                   	pop    %esi
80105b86:	5f                   	pop    %edi
80105b87:	5d                   	pop    %ebp
      exit();
80105b88:	e9 43 e3 ff ff       	jmp    80103ed0 <exit>
80105b8d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80105b90:	e8 3b e3 ff ff       	call   80103ed0 <exit>
80105b95:	e9 a1 fe ff ff       	jmp    80105a3b <trap+0xbb>
80105b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105ba0:	e8 2b e3 ff ff       	call   80103ed0 <exit>
80105ba5:	eb bd                	jmp    80105b64 <trap+0x1e4>
80105ba7:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105baa:	e8 e1 de ff ff       	call   80103a90 <cpuid>
80105baf:	83 ec 0c             	sub    $0xc,%esp
80105bb2:	56                   	push   %esi
80105bb3:	57                   	push   %edi
80105bb4:	50                   	push   %eax
80105bb5:	ff 73 30             	pushl  0x30(%ebx)
80105bb8:	68 8c 79 10 80       	push   $0x8010798c
80105bbd:	e8 de aa ff ff       	call   801006a0 <cprintf>
      panic("trap");
80105bc2:	83 c4 14             	add    $0x14,%esp
80105bc5:	68 62 79 10 80       	push   $0x80107962
80105bca:	e8 b1 a7 ff ff       	call   80100380 <panic>
80105bcf:	90                   	nop

80105bd0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105bd0:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
80105bd5:	85 c0                	test   %eax,%eax
80105bd7:	74 17                	je     80105bf0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105bd9:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105bde:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105bdf:	a8 01                	test   $0x1,%al
80105be1:	74 0d                	je     80105bf0 <uartgetc+0x20>
80105be3:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105be8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105be9:	0f b6 c0             	movzbl %al,%eax
80105bec:	c3                   	ret    
80105bed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105bf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bf5:	c3                   	ret    
80105bf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bfd:	8d 76 00             	lea    0x0(%esi),%esi

80105c00 <uartputc.part.0>:
uartputc(int c)
80105c00:	55                   	push   %ebp
80105c01:	89 e5                	mov    %esp,%ebp
80105c03:	57                   	push   %edi
80105c04:	89 c7                	mov    %eax,%edi
80105c06:	56                   	push   %esi
80105c07:	be fd 03 00 00       	mov    $0x3fd,%esi
80105c0c:	53                   	push   %ebx
80105c0d:	bb 80 00 00 00       	mov    $0x80,%ebx
80105c12:	83 ec 0c             	sub    $0xc,%esp
80105c15:	eb 1b                	jmp    80105c32 <uartputc.part.0+0x32>
80105c17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c1e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80105c20:	83 ec 0c             	sub    $0xc,%esp
80105c23:	6a 0a                	push   $0xa
80105c25:	e8 66 ce ff ff       	call   80102a90 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105c2a:	83 c4 10             	add    $0x10,%esp
80105c2d:	83 eb 01             	sub    $0x1,%ebx
80105c30:	74 07                	je     80105c39 <uartputc.part.0+0x39>
80105c32:	89 f2                	mov    %esi,%edx
80105c34:	ec                   	in     (%dx),%al
80105c35:	a8 20                	test   $0x20,%al
80105c37:	74 e7                	je     80105c20 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105c39:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c3e:	89 f8                	mov    %edi,%eax
80105c40:	ee                   	out    %al,(%dx)
}
80105c41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c44:	5b                   	pop    %ebx
80105c45:	5e                   	pop    %esi
80105c46:	5f                   	pop    %edi
80105c47:	5d                   	pop    %ebp
80105c48:	c3                   	ret    
80105c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105c50 <uartinit>:
{
80105c50:	55                   	push   %ebp
80105c51:	31 c9                	xor    %ecx,%ecx
80105c53:	89 c8                	mov    %ecx,%eax
80105c55:	89 e5                	mov    %esp,%ebp
80105c57:	57                   	push   %edi
80105c58:	56                   	push   %esi
80105c59:	53                   	push   %ebx
80105c5a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105c5f:	89 da                	mov    %ebx,%edx
80105c61:	83 ec 0c             	sub    $0xc,%esp
80105c64:	ee                   	out    %al,(%dx)
80105c65:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105c6a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105c6f:	89 fa                	mov    %edi,%edx
80105c71:	ee                   	out    %al,(%dx)
80105c72:	b8 0c 00 00 00       	mov    $0xc,%eax
80105c77:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c7c:	ee                   	out    %al,(%dx)
80105c7d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105c82:	89 c8                	mov    %ecx,%eax
80105c84:	89 f2                	mov    %esi,%edx
80105c86:	ee                   	out    %al,(%dx)
80105c87:	b8 03 00 00 00       	mov    $0x3,%eax
80105c8c:	89 fa                	mov    %edi,%edx
80105c8e:	ee                   	out    %al,(%dx)
80105c8f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105c94:	89 c8                	mov    %ecx,%eax
80105c96:	ee                   	out    %al,(%dx)
80105c97:	b8 01 00 00 00       	mov    $0x1,%eax
80105c9c:	89 f2                	mov    %esi,%edx
80105c9e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c9f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ca4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105ca5:	3c ff                	cmp    $0xff,%al
80105ca7:	74 56                	je     80105cff <uartinit+0xaf>
  uart = 1;
80105ca9:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105cb0:	00 00 00 
80105cb3:	89 da                	mov    %ebx,%edx
80105cb5:	ec                   	in     (%dx),%al
80105cb6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cbb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105cbc:	83 ec 08             	sub    $0x8,%esp
80105cbf:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80105cc4:	bb 84 7a 10 80       	mov    $0x80107a84,%ebx
  ioapicenable(IRQ_COM1, 0);
80105cc9:	6a 00                	push   $0x0
80105ccb:	6a 04                	push   $0x4
80105ccd:	e8 0e c9 ff ff       	call   801025e0 <ioapicenable>
80105cd2:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105cd5:	b8 78 00 00 00       	mov    $0x78,%eax
80105cda:	eb 08                	jmp    80105ce4 <uartinit+0x94>
80105cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ce0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80105ce4:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105cea:	85 d2                	test   %edx,%edx
80105cec:	74 08                	je     80105cf6 <uartinit+0xa6>
    uartputc(*p);
80105cee:	0f be c0             	movsbl %al,%eax
80105cf1:	e8 0a ff ff ff       	call   80105c00 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80105cf6:	89 f0                	mov    %esi,%eax
80105cf8:	83 c3 01             	add    $0x1,%ebx
80105cfb:	84 c0                	test   %al,%al
80105cfd:	75 e1                	jne    80105ce0 <uartinit+0x90>
}
80105cff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d02:	5b                   	pop    %ebx
80105d03:	5e                   	pop    %esi
80105d04:	5f                   	pop    %edi
80105d05:	5d                   	pop    %ebp
80105d06:	c3                   	ret    
80105d07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d0e:	66 90                	xchg   %ax,%ax

80105d10 <uartputc>:
{
80105d10:	55                   	push   %ebp
  if(!uart)
80105d11:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105d17:	89 e5                	mov    %esp,%ebp
80105d19:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105d1c:	85 d2                	test   %edx,%edx
80105d1e:	74 10                	je     80105d30 <uartputc+0x20>
}
80105d20:	5d                   	pop    %ebp
80105d21:	e9 da fe ff ff       	jmp    80105c00 <uartputc.part.0>
80105d26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d2d:	8d 76 00             	lea    0x0(%esi),%esi
80105d30:	5d                   	pop    %ebp
80105d31:	c3                   	ret    
80105d32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d40 <uartintr>:

void
uartintr(void)
{
80105d40:	55                   	push   %ebp
80105d41:	89 e5                	mov    %esp,%ebp
80105d43:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105d46:	68 d0 5b 10 80       	push   $0x80105bd0
80105d4b:	e8 00 ab ff ff       	call   80100850 <consoleintr>
}
80105d50:	83 c4 10             	add    $0x10,%esp
80105d53:	c9                   	leave  
80105d54:	c3                   	ret    

80105d55 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105d55:	6a 00                	push   $0x0
  pushl $0
80105d57:	6a 00                	push   $0x0
  jmp alltraps
80105d59:	e9 47 fb ff ff       	jmp    801058a5 <alltraps>

80105d5e <vector1>:
.globl vector1
vector1:
  pushl $0
80105d5e:	6a 00                	push   $0x0
  pushl $1
80105d60:	6a 01                	push   $0x1
  jmp alltraps
80105d62:	e9 3e fb ff ff       	jmp    801058a5 <alltraps>

80105d67 <vector2>:
.globl vector2
vector2:
  pushl $0
80105d67:	6a 00                	push   $0x0
  pushl $2
80105d69:	6a 02                	push   $0x2
  jmp alltraps
80105d6b:	e9 35 fb ff ff       	jmp    801058a5 <alltraps>

80105d70 <vector3>:
.globl vector3
vector3:
  pushl $0
80105d70:	6a 00                	push   $0x0
  pushl $3
80105d72:	6a 03                	push   $0x3
  jmp alltraps
80105d74:	e9 2c fb ff ff       	jmp    801058a5 <alltraps>

80105d79 <vector4>:
.globl vector4
vector4:
  pushl $0
80105d79:	6a 00                	push   $0x0
  pushl $4
80105d7b:	6a 04                	push   $0x4
  jmp alltraps
80105d7d:	e9 23 fb ff ff       	jmp    801058a5 <alltraps>

80105d82 <vector5>:
.globl vector5
vector5:
  pushl $0
80105d82:	6a 00                	push   $0x0
  pushl $5
80105d84:	6a 05                	push   $0x5
  jmp alltraps
80105d86:	e9 1a fb ff ff       	jmp    801058a5 <alltraps>

80105d8b <vector6>:
.globl vector6
vector6:
  pushl $0
80105d8b:	6a 00                	push   $0x0
  pushl $6
80105d8d:	6a 06                	push   $0x6
  jmp alltraps
80105d8f:	e9 11 fb ff ff       	jmp    801058a5 <alltraps>

80105d94 <vector7>:
.globl vector7
vector7:
  pushl $0
80105d94:	6a 00                	push   $0x0
  pushl $7
80105d96:	6a 07                	push   $0x7
  jmp alltraps
80105d98:	e9 08 fb ff ff       	jmp    801058a5 <alltraps>

80105d9d <vector8>:
.globl vector8
vector8:
  pushl $8
80105d9d:	6a 08                	push   $0x8
  jmp alltraps
80105d9f:	e9 01 fb ff ff       	jmp    801058a5 <alltraps>

80105da4 <vector9>:
.globl vector9
vector9:
  pushl $0
80105da4:	6a 00                	push   $0x0
  pushl $9
80105da6:	6a 09                	push   $0x9
  jmp alltraps
80105da8:	e9 f8 fa ff ff       	jmp    801058a5 <alltraps>

80105dad <vector10>:
.globl vector10
vector10:
  pushl $10
80105dad:	6a 0a                	push   $0xa
  jmp alltraps
80105daf:	e9 f1 fa ff ff       	jmp    801058a5 <alltraps>

80105db4 <vector11>:
.globl vector11
vector11:
  pushl $11
80105db4:	6a 0b                	push   $0xb
  jmp alltraps
80105db6:	e9 ea fa ff ff       	jmp    801058a5 <alltraps>

80105dbb <vector12>:
.globl vector12
vector12:
  pushl $12
80105dbb:	6a 0c                	push   $0xc
  jmp alltraps
80105dbd:	e9 e3 fa ff ff       	jmp    801058a5 <alltraps>

80105dc2 <vector13>:
.globl vector13
vector13:
  pushl $13
80105dc2:	6a 0d                	push   $0xd
  jmp alltraps
80105dc4:	e9 dc fa ff ff       	jmp    801058a5 <alltraps>

80105dc9 <vector14>:
.globl vector14
vector14:
  pushl $14
80105dc9:	6a 0e                	push   $0xe
  jmp alltraps
80105dcb:	e9 d5 fa ff ff       	jmp    801058a5 <alltraps>

80105dd0 <vector15>:
.globl vector15
vector15:
  pushl $0
80105dd0:	6a 00                	push   $0x0
  pushl $15
80105dd2:	6a 0f                	push   $0xf
  jmp alltraps
80105dd4:	e9 cc fa ff ff       	jmp    801058a5 <alltraps>

80105dd9 <vector16>:
.globl vector16
vector16:
  pushl $0
80105dd9:	6a 00                	push   $0x0
  pushl $16
80105ddb:	6a 10                	push   $0x10
  jmp alltraps
80105ddd:	e9 c3 fa ff ff       	jmp    801058a5 <alltraps>

80105de2 <vector17>:
.globl vector17
vector17:
  pushl $17
80105de2:	6a 11                	push   $0x11
  jmp alltraps
80105de4:	e9 bc fa ff ff       	jmp    801058a5 <alltraps>

80105de9 <vector18>:
.globl vector18
vector18:
  pushl $0
80105de9:	6a 00                	push   $0x0
  pushl $18
80105deb:	6a 12                	push   $0x12
  jmp alltraps
80105ded:	e9 b3 fa ff ff       	jmp    801058a5 <alltraps>

80105df2 <vector19>:
.globl vector19
vector19:
  pushl $0
80105df2:	6a 00                	push   $0x0
  pushl $19
80105df4:	6a 13                	push   $0x13
  jmp alltraps
80105df6:	e9 aa fa ff ff       	jmp    801058a5 <alltraps>

80105dfb <vector20>:
.globl vector20
vector20:
  pushl $0
80105dfb:	6a 00                	push   $0x0
  pushl $20
80105dfd:	6a 14                	push   $0x14
  jmp alltraps
80105dff:	e9 a1 fa ff ff       	jmp    801058a5 <alltraps>

80105e04 <vector21>:
.globl vector21
vector21:
  pushl $0
80105e04:	6a 00                	push   $0x0
  pushl $21
80105e06:	6a 15                	push   $0x15
  jmp alltraps
80105e08:	e9 98 fa ff ff       	jmp    801058a5 <alltraps>

80105e0d <vector22>:
.globl vector22
vector22:
  pushl $0
80105e0d:	6a 00                	push   $0x0
  pushl $22
80105e0f:	6a 16                	push   $0x16
  jmp alltraps
80105e11:	e9 8f fa ff ff       	jmp    801058a5 <alltraps>

80105e16 <vector23>:
.globl vector23
vector23:
  pushl $0
80105e16:	6a 00                	push   $0x0
  pushl $23
80105e18:	6a 17                	push   $0x17
  jmp alltraps
80105e1a:	e9 86 fa ff ff       	jmp    801058a5 <alltraps>

80105e1f <vector24>:
.globl vector24
vector24:
  pushl $0
80105e1f:	6a 00                	push   $0x0
  pushl $24
80105e21:	6a 18                	push   $0x18
  jmp alltraps
80105e23:	e9 7d fa ff ff       	jmp    801058a5 <alltraps>

80105e28 <vector25>:
.globl vector25
vector25:
  pushl $0
80105e28:	6a 00                	push   $0x0
  pushl $25
80105e2a:	6a 19                	push   $0x19
  jmp alltraps
80105e2c:	e9 74 fa ff ff       	jmp    801058a5 <alltraps>

80105e31 <vector26>:
.globl vector26
vector26:
  pushl $0
80105e31:	6a 00                	push   $0x0
  pushl $26
80105e33:	6a 1a                	push   $0x1a
  jmp alltraps
80105e35:	e9 6b fa ff ff       	jmp    801058a5 <alltraps>

80105e3a <vector27>:
.globl vector27
vector27:
  pushl $0
80105e3a:	6a 00                	push   $0x0
  pushl $27
80105e3c:	6a 1b                	push   $0x1b
  jmp alltraps
80105e3e:	e9 62 fa ff ff       	jmp    801058a5 <alltraps>

80105e43 <vector28>:
.globl vector28
vector28:
  pushl $0
80105e43:	6a 00                	push   $0x0
  pushl $28
80105e45:	6a 1c                	push   $0x1c
  jmp alltraps
80105e47:	e9 59 fa ff ff       	jmp    801058a5 <alltraps>

80105e4c <vector29>:
.globl vector29
vector29:
  pushl $0
80105e4c:	6a 00                	push   $0x0
  pushl $29
80105e4e:	6a 1d                	push   $0x1d
  jmp alltraps
80105e50:	e9 50 fa ff ff       	jmp    801058a5 <alltraps>

80105e55 <vector30>:
.globl vector30
vector30:
  pushl $0
80105e55:	6a 00                	push   $0x0
  pushl $30
80105e57:	6a 1e                	push   $0x1e
  jmp alltraps
80105e59:	e9 47 fa ff ff       	jmp    801058a5 <alltraps>

80105e5e <vector31>:
.globl vector31
vector31:
  pushl $0
80105e5e:	6a 00                	push   $0x0
  pushl $31
80105e60:	6a 1f                	push   $0x1f
  jmp alltraps
80105e62:	e9 3e fa ff ff       	jmp    801058a5 <alltraps>

80105e67 <vector32>:
.globl vector32
vector32:
  pushl $0
80105e67:	6a 00                	push   $0x0
  pushl $32
80105e69:	6a 20                	push   $0x20
  jmp alltraps
80105e6b:	e9 35 fa ff ff       	jmp    801058a5 <alltraps>

80105e70 <vector33>:
.globl vector33
vector33:
  pushl $0
80105e70:	6a 00                	push   $0x0
  pushl $33
80105e72:	6a 21                	push   $0x21
  jmp alltraps
80105e74:	e9 2c fa ff ff       	jmp    801058a5 <alltraps>

80105e79 <vector34>:
.globl vector34
vector34:
  pushl $0
80105e79:	6a 00                	push   $0x0
  pushl $34
80105e7b:	6a 22                	push   $0x22
  jmp alltraps
80105e7d:	e9 23 fa ff ff       	jmp    801058a5 <alltraps>

80105e82 <vector35>:
.globl vector35
vector35:
  pushl $0
80105e82:	6a 00                	push   $0x0
  pushl $35
80105e84:	6a 23                	push   $0x23
  jmp alltraps
80105e86:	e9 1a fa ff ff       	jmp    801058a5 <alltraps>

80105e8b <vector36>:
.globl vector36
vector36:
  pushl $0
80105e8b:	6a 00                	push   $0x0
  pushl $36
80105e8d:	6a 24                	push   $0x24
  jmp alltraps
80105e8f:	e9 11 fa ff ff       	jmp    801058a5 <alltraps>

80105e94 <vector37>:
.globl vector37
vector37:
  pushl $0
80105e94:	6a 00                	push   $0x0
  pushl $37
80105e96:	6a 25                	push   $0x25
  jmp alltraps
80105e98:	e9 08 fa ff ff       	jmp    801058a5 <alltraps>

80105e9d <vector38>:
.globl vector38
vector38:
  pushl $0
80105e9d:	6a 00                	push   $0x0
  pushl $38
80105e9f:	6a 26                	push   $0x26
  jmp alltraps
80105ea1:	e9 ff f9 ff ff       	jmp    801058a5 <alltraps>

80105ea6 <vector39>:
.globl vector39
vector39:
  pushl $0
80105ea6:	6a 00                	push   $0x0
  pushl $39
80105ea8:	6a 27                	push   $0x27
  jmp alltraps
80105eaa:	e9 f6 f9 ff ff       	jmp    801058a5 <alltraps>

80105eaf <vector40>:
.globl vector40
vector40:
  pushl $0
80105eaf:	6a 00                	push   $0x0
  pushl $40
80105eb1:	6a 28                	push   $0x28
  jmp alltraps
80105eb3:	e9 ed f9 ff ff       	jmp    801058a5 <alltraps>

80105eb8 <vector41>:
.globl vector41
vector41:
  pushl $0
80105eb8:	6a 00                	push   $0x0
  pushl $41
80105eba:	6a 29                	push   $0x29
  jmp alltraps
80105ebc:	e9 e4 f9 ff ff       	jmp    801058a5 <alltraps>

80105ec1 <vector42>:
.globl vector42
vector42:
  pushl $0
80105ec1:	6a 00                	push   $0x0
  pushl $42
80105ec3:	6a 2a                	push   $0x2a
  jmp alltraps
80105ec5:	e9 db f9 ff ff       	jmp    801058a5 <alltraps>

80105eca <vector43>:
.globl vector43
vector43:
  pushl $0
80105eca:	6a 00                	push   $0x0
  pushl $43
80105ecc:	6a 2b                	push   $0x2b
  jmp alltraps
80105ece:	e9 d2 f9 ff ff       	jmp    801058a5 <alltraps>

80105ed3 <vector44>:
.globl vector44
vector44:
  pushl $0
80105ed3:	6a 00                	push   $0x0
  pushl $44
80105ed5:	6a 2c                	push   $0x2c
  jmp alltraps
80105ed7:	e9 c9 f9 ff ff       	jmp    801058a5 <alltraps>

80105edc <vector45>:
.globl vector45
vector45:
  pushl $0
80105edc:	6a 00                	push   $0x0
  pushl $45
80105ede:	6a 2d                	push   $0x2d
  jmp alltraps
80105ee0:	e9 c0 f9 ff ff       	jmp    801058a5 <alltraps>

80105ee5 <vector46>:
.globl vector46
vector46:
  pushl $0
80105ee5:	6a 00                	push   $0x0
  pushl $46
80105ee7:	6a 2e                	push   $0x2e
  jmp alltraps
80105ee9:	e9 b7 f9 ff ff       	jmp    801058a5 <alltraps>

80105eee <vector47>:
.globl vector47
vector47:
  pushl $0
80105eee:	6a 00                	push   $0x0
  pushl $47
80105ef0:	6a 2f                	push   $0x2f
  jmp alltraps
80105ef2:	e9 ae f9 ff ff       	jmp    801058a5 <alltraps>

80105ef7 <vector48>:
.globl vector48
vector48:
  pushl $0
80105ef7:	6a 00                	push   $0x0
  pushl $48
80105ef9:	6a 30                	push   $0x30
  jmp alltraps
80105efb:	e9 a5 f9 ff ff       	jmp    801058a5 <alltraps>

80105f00 <vector49>:
.globl vector49
vector49:
  pushl $0
80105f00:	6a 00                	push   $0x0
  pushl $49
80105f02:	6a 31                	push   $0x31
  jmp alltraps
80105f04:	e9 9c f9 ff ff       	jmp    801058a5 <alltraps>

80105f09 <vector50>:
.globl vector50
vector50:
  pushl $0
80105f09:	6a 00                	push   $0x0
  pushl $50
80105f0b:	6a 32                	push   $0x32
  jmp alltraps
80105f0d:	e9 93 f9 ff ff       	jmp    801058a5 <alltraps>

80105f12 <vector51>:
.globl vector51
vector51:
  pushl $0
80105f12:	6a 00                	push   $0x0
  pushl $51
80105f14:	6a 33                	push   $0x33
  jmp alltraps
80105f16:	e9 8a f9 ff ff       	jmp    801058a5 <alltraps>

80105f1b <vector52>:
.globl vector52
vector52:
  pushl $0
80105f1b:	6a 00                	push   $0x0
  pushl $52
80105f1d:	6a 34                	push   $0x34
  jmp alltraps
80105f1f:	e9 81 f9 ff ff       	jmp    801058a5 <alltraps>

80105f24 <vector53>:
.globl vector53
vector53:
  pushl $0
80105f24:	6a 00                	push   $0x0
  pushl $53
80105f26:	6a 35                	push   $0x35
  jmp alltraps
80105f28:	e9 78 f9 ff ff       	jmp    801058a5 <alltraps>

80105f2d <vector54>:
.globl vector54
vector54:
  pushl $0
80105f2d:	6a 00                	push   $0x0
  pushl $54
80105f2f:	6a 36                	push   $0x36
  jmp alltraps
80105f31:	e9 6f f9 ff ff       	jmp    801058a5 <alltraps>

80105f36 <vector55>:
.globl vector55
vector55:
  pushl $0
80105f36:	6a 00                	push   $0x0
  pushl $55
80105f38:	6a 37                	push   $0x37
  jmp alltraps
80105f3a:	e9 66 f9 ff ff       	jmp    801058a5 <alltraps>

80105f3f <vector56>:
.globl vector56
vector56:
  pushl $0
80105f3f:	6a 00                	push   $0x0
  pushl $56
80105f41:	6a 38                	push   $0x38
  jmp alltraps
80105f43:	e9 5d f9 ff ff       	jmp    801058a5 <alltraps>

80105f48 <vector57>:
.globl vector57
vector57:
  pushl $0
80105f48:	6a 00                	push   $0x0
  pushl $57
80105f4a:	6a 39                	push   $0x39
  jmp alltraps
80105f4c:	e9 54 f9 ff ff       	jmp    801058a5 <alltraps>

80105f51 <vector58>:
.globl vector58
vector58:
  pushl $0
80105f51:	6a 00                	push   $0x0
  pushl $58
80105f53:	6a 3a                	push   $0x3a
  jmp alltraps
80105f55:	e9 4b f9 ff ff       	jmp    801058a5 <alltraps>

80105f5a <vector59>:
.globl vector59
vector59:
  pushl $0
80105f5a:	6a 00                	push   $0x0
  pushl $59
80105f5c:	6a 3b                	push   $0x3b
  jmp alltraps
80105f5e:	e9 42 f9 ff ff       	jmp    801058a5 <alltraps>

80105f63 <vector60>:
.globl vector60
vector60:
  pushl $0
80105f63:	6a 00                	push   $0x0
  pushl $60
80105f65:	6a 3c                	push   $0x3c
  jmp alltraps
80105f67:	e9 39 f9 ff ff       	jmp    801058a5 <alltraps>

80105f6c <vector61>:
.globl vector61
vector61:
  pushl $0
80105f6c:	6a 00                	push   $0x0
  pushl $61
80105f6e:	6a 3d                	push   $0x3d
  jmp alltraps
80105f70:	e9 30 f9 ff ff       	jmp    801058a5 <alltraps>

80105f75 <vector62>:
.globl vector62
vector62:
  pushl $0
80105f75:	6a 00                	push   $0x0
  pushl $62
80105f77:	6a 3e                	push   $0x3e
  jmp alltraps
80105f79:	e9 27 f9 ff ff       	jmp    801058a5 <alltraps>

80105f7e <vector63>:
.globl vector63
vector63:
  pushl $0
80105f7e:	6a 00                	push   $0x0
  pushl $63
80105f80:	6a 3f                	push   $0x3f
  jmp alltraps
80105f82:	e9 1e f9 ff ff       	jmp    801058a5 <alltraps>

80105f87 <vector64>:
.globl vector64
vector64:
  pushl $0
80105f87:	6a 00                	push   $0x0
  pushl $64
80105f89:	6a 40                	push   $0x40
  jmp alltraps
80105f8b:	e9 15 f9 ff ff       	jmp    801058a5 <alltraps>

80105f90 <vector65>:
.globl vector65
vector65:
  pushl $0
80105f90:	6a 00                	push   $0x0
  pushl $65
80105f92:	6a 41                	push   $0x41
  jmp alltraps
80105f94:	e9 0c f9 ff ff       	jmp    801058a5 <alltraps>

80105f99 <vector66>:
.globl vector66
vector66:
  pushl $0
80105f99:	6a 00                	push   $0x0
  pushl $66
80105f9b:	6a 42                	push   $0x42
  jmp alltraps
80105f9d:	e9 03 f9 ff ff       	jmp    801058a5 <alltraps>

80105fa2 <vector67>:
.globl vector67
vector67:
  pushl $0
80105fa2:	6a 00                	push   $0x0
  pushl $67
80105fa4:	6a 43                	push   $0x43
  jmp alltraps
80105fa6:	e9 fa f8 ff ff       	jmp    801058a5 <alltraps>

80105fab <vector68>:
.globl vector68
vector68:
  pushl $0
80105fab:	6a 00                	push   $0x0
  pushl $68
80105fad:	6a 44                	push   $0x44
  jmp alltraps
80105faf:	e9 f1 f8 ff ff       	jmp    801058a5 <alltraps>

80105fb4 <vector69>:
.globl vector69
vector69:
  pushl $0
80105fb4:	6a 00                	push   $0x0
  pushl $69
80105fb6:	6a 45                	push   $0x45
  jmp alltraps
80105fb8:	e9 e8 f8 ff ff       	jmp    801058a5 <alltraps>

80105fbd <vector70>:
.globl vector70
vector70:
  pushl $0
80105fbd:	6a 00                	push   $0x0
  pushl $70
80105fbf:	6a 46                	push   $0x46
  jmp alltraps
80105fc1:	e9 df f8 ff ff       	jmp    801058a5 <alltraps>

80105fc6 <vector71>:
.globl vector71
vector71:
  pushl $0
80105fc6:	6a 00                	push   $0x0
  pushl $71
80105fc8:	6a 47                	push   $0x47
  jmp alltraps
80105fca:	e9 d6 f8 ff ff       	jmp    801058a5 <alltraps>

80105fcf <vector72>:
.globl vector72
vector72:
  pushl $0
80105fcf:	6a 00                	push   $0x0
  pushl $72
80105fd1:	6a 48                	push   $0x48
  jmp alltraps
80105fd3:	e9 cd f8 ff ff       	jmp    801058a5 <alltraps>

80105fd8 <vector73>:
.globl vector73
vector73:
  pushl $0
80105fd8:	6a 00                	push   $0x0
  pushl $73
80105fda:	6a 49                	push   $0x49
  jmp alltraps
80105fdc:	e9 c4 f8 ff ff       	jmp    801058a5 <alltraps>

80105fe1 <vector74>:
.globl vector74
vector74:
  pushl $0
80105fe1:	6a 00                	push   $0x0
  pushl $74
80105fe3:	6a 4a                	push   $0x4a
  jmp alltraps
80105fe5:	e9 bb f8 ff ff       	jmp    801058a5 <alltraps>

80105fea <vector75>:
.globl vector75
vector75:
  pushl $0
80105fea:	6a 00                	push   $0x0
  pushl $75
80105fec:	6a 4b                	push   $0x4b
  jmp alltraps
80105fee:	e9 b2 f8 ff ff       	jmp    801058a5 <alltraps>

80105ff3 <vector76>:
.globl vector76
vector76:
  pushl $0
80105ff3:	6a 00                	push   $0x0
  pushl $76
80105ff5:	6a 4c                	push   $0x4c
  jmp alltraps
80105ff7:	e9 a9 f8 ff ff       	jmp    801058a5 <alltraps>

80105ffc <vector77>:
.globl vector77
vector77:
  pushl $0
80105ffc:	6a 00                	push   $0x0
  pushl $77
80105ffe:	6a 4d                	push   $0x4d
  jmp alltraps
80106000:	e9 a0 f8 ff ff       	jmp    801058a5 <alltraps>

80106005 <vector78>:
.globl vector78
vector78:
  pushl $0
80106005:	6a 00                	push   $0x0
  pushl $78
80106007:	6a 4e                	push   $0x4e
  jmp alltraps
80106009:	e9 97 f8 ff ff       	jmp    801058a5 <alltraps>

8010600e <vector79>:
.globl vector79
vector79:
  pushl $0
8010600e:	6a 00                	push   $0x0
  pushl $79
80106010:	6a 4f                	push   $0x4f
  jmp alltraps
80106012:	e9 8e f8 ff ff       	jmp    801058a5 <alltraps>

80106017 <vector80>:
.globl vector80
vector80:
  pushl $0
80106017:	6a 00                	push   $0x0
  pushl $80
80106019:	6a 50                	push   $0x50
  jmp alltraps
8010601b:	e9 85 f8 ff ff       	jmp    801058a5 <alltraps>

80106020 <vector81>:
.globl vector81
vector81:
  pushl $0
80106020:	6a 00                	push   $0x0
  pushl $81
80106022:	6a 51                	push   $0x51
  jmp alltraps
80106024:	e9 7c f8 ff ff       	jmp    801058a5 <alltraps>

80106029 <vector82>:
.globl vector82
vector82:
  pushl $0
80106029:	6a 00                	push   $0x0
  pushl $82
8010602b:	6a 52                	push   $0x52
  jmp alltraps
8010602d:	e9 73 f8 ff ff       	jmp    801058a5 <alltraps>

80106032 <vector83>:
.globl vector83
vector83:
  pushl $0
80106032:	6a 00                	push   $0x0
  pushl $83
80106034:	6a 53                	push   $0x53
  jmp alltraps
80106036:	e9 6a f8 ff ff       	jmp    801058a5 <alltraps>

8010603b <vector84>:
.globl vector84
vector84:
  pushl $0
8010603b:	6a 00                	push   $0x0
  pushl $84
8010603d:	6a 54                	push   $0x54
  jmp alltraps
8010603f:	e9 61 f8 ff ff       	jmp    801058a5 <alltraps>

80106044 <vector85>:
.globl vector85
vector85:
  pushl $0
80106044:	6a 00                	push   $0x0
  pushl $85
80106046:	6a 55                	push   $0x55
  jmp alltraps
80106048:	e9 58 f8 ff ff       	jmp    801058a5 <alltraps>

8010604d <vector86>:
.globl vector86
vector86:
  pushl $0
8010604d:	6a 00                	push   $0x0
  pushl $86
8010604f:	6a 56                	push   $0x56
  jmp alltraps
80106051:	e9 4f f8 ff ff       	jmp    801058a5 <alltraps>

80106056 <vector87>:
.globl vector87
vector87:
  pushl $0
80106056:	6a 00                	push   $0x0
  pushl $87
80106058:	6a 57                	push   $0x57
  jmp alltraps
8010605a:	e9 46 f8 ff ff       	jmp    801058a5 <alltraps>

8010605f <vector88>:
.globl vector88
vector88:
  pushl $0
8010605f:	6a 00                	push   $0x0
  pushl $88
80106061:	6a 58                	push   $0x58
  jmp alltraps
80106063:	e9 3d f8 ff ff       	jmp    801058a5 <alltraps>

80106068 <vector89>:
.globl vector89
vector89:
  pushl $0
80106068:	6a 00                	push   $0x0
  pushl $89
8010606a:	6a 59                	push   $0x59
  jmp alltraps
8010606c:	e9 34 f8 ff ff       	jmp    801058a5 <alltraps>

80106071 <vector90>:
.globl vector90
vector90:
  pushl $0
80106071:	6a 00                	push   $0x0
  pushl $90
80106073:	6a 5a                	push   $0x5a
  jmp alltraps
80106075:	e9 2b f8 ff ff       	jmp    801058a5 <alltraps>

8010607a <vector91>:
.globl vector91
vector91:
  pushl $0
8010607a:	6a 00                	push   $0x0
  pushl $91
8010607c:	6a 5b                	push   $0x5b
  jmp alltraps
8010607e:	e9 22 f8 ff ff       	jmp    801058a5 <alltraps>

80106083 <vector92>:
.globl vector92
vector92:
  pushl $0
80106083:	6a 00                	push   $0x0
  pushl $92
80106085:	6a 5c                	push   $0x5c
  jmp alltraps
80106087:	e9 19 f8 ff ff       	jmp    801058a5 <alltraps>

8010608c <vector93>:
.globl vector93
vector93:
  pushl $0
8010608c:	6a 00                	push   $0x0
  pushl $93
8010608e:	6a 5d                	push   $0x5d
  jmp alltraps
80106090:	e9 10 f8 ff ff       	jmp    801058a5 <alltraps>

80106095 <vector94>:
.globl vector94
vector94:
  pushl $0
80106095:	6a 00                	push   $0x0
  pushl $94
80106097:	6a 5e                	push   $0x5e
  jmp alltraps
80106099:	e9 07 f8 ff ff       	jmp    801058a5 <alltraps>

8010609e <vector95>:
.globl vector95
vector95:
  pushl $0
8010609e:	6a 00                	push   $0x0
  pushl $95
801060a0:	6a 5f                	push   $0x5f
  jmp alltraps
801060a2:	e9 fe f7 ff ff       	jmp    801058a5 <alltraps>

801060a7 <vector96>:
.globl vector96
vector96:
  pushl $0
801060a7:	6a 00                	push   $0x0
  pushl $96
801060a9:	6a 60                	push   $0x60
  jmp alltraps
801060ab:	e9 f5 f7 ff ff       	jmp    801058a5 <alltraps>

801060b0 <vector97>:
.globl vector97
vector97:
  pushl $0
801060b0:	6a 00                	push   $0x0
  pushl $97
801060b2:	6a 61                	push   $0x61
  jmp alltraps
801060b4:	e9 ec f7 ff ff       	jmp    801058a5 <alltraps>

801060b9 <vector98>:
.globl vector98
vector98:
  pushl $0
801060b9:	6a 00                	push   $0x0
  pushl $98
801060bb:	6a 62                	push   $0x62
  jmp alltraps
801060bd:	e9 e3 f7 ff ff       	jmp    801058a5 <alltraps>

801060c2 <vector99>:
.globl vector99
vector99:
  pushl $0
801060c2:	6a 00                	push   $0x0
  pushl $99
801060c4:	6a 63                	push   $0x63
  jmp alltraps
801060c6:	e9 da f7 ff ff       	jmp    801058a5 <alltraps>

801060cb <vector100>:
.globl vector100
vector100:
  pushl $0
801060cb:	6a 00                	push   $0x0
  pushl $100
801060cd:	6a 64                	push   $0x64
  jmp alltraps
801060cf:	e9 d1 f7 ff ff       	jmp    801058a5 <alltraps>

801060d4 <vector101>:
.globl vector101
vector101:
  pushl $0
801060d4:	6a 00                	push   $0x0
  pushl $101
801060d6:	6a 65                	push   $0x65
  jmp alltraps
801060d8:	e9 c8 f7 ff ff       	jmp    801058a5 <alltraps>

801060dd <vector102>:
.globl vector102
vector102:
  pushl $0
801060dd:	6a 00                	push   $0x0
  pushl $102
801060df:	6a 66                	push   $0x66
  jmp alltraps
801060e1:	e9 bf f7 ff ff       	jmp    801058a5 <alltraps>

801060e6 <vector103>:
.globl vector103
vector103:
  pushl $0
801060e6:	6a 00                	push   $0x0
  pushl $103
801060e8:	6a 67                	push   $0x67
  jmp alltraps
801060ea:	e9 b6 f7 ff ff       	jmp    801058a5 <alltraps>

801060ef <vector104>:
.globl vector104
vector104:
  pushl $0
801060ef:	6a 00                	push   $0x0
  pushl $104
801060f1:	6a 68                	push   $0x68
  jmp alltraps
801060f3:	e9 ad f7 ff ff       	jmp    801058a5 <alltraps>

801060f8 <vector105>:
.globl vector105
vector105:
  pushl $0
801060f8:	6a 00                	push   $0x0
  pushl $105
801060fa:	6a 69                	push   $0x69
  jmp alltraps
801060fc:	e9 a4 f7 ff ff       	jmp    801058a5 <alltraps>

80106101 <vector106>:
.globl vector106
vector106:
  pushl $0
80106101:	6a 00                	push   $0x0
  pushl $106
80106103:	6a 6a                	push   $0x6a
  jmp alltraps
80106105:	e9 9b f7 ff ff       	jmp    801058a5 <alltraps>

8010610a <vector107>:
.globl vector107
vector107:
  pushl $0
8010610a:	6a 00                	push   $0x0
  pushl $107
8010610c:	6a 6b                	push   $0x6b
  jmp alltraps
8010610e:	e9 92 f7 ff ff       	jmp    801058a5 <alltraps>

80106113 <vector108>:
.globl vector108
vector108:
  pushl $0
80106113:	6a 00                	push   $0x0
  pushl $108
80106115:	6a 6c                	push   $0x6c
  jmp alltraps
80106117:	e9 89 f7 ff ff       	jmp    801058a5 <alltraps>

8010611c <vector109>:
.globl vector109
vector109:
  pushl $0
8010611c:	6a 00                	push   $0x0
  pushl $109
8010611e:	6a 6d                	push   $0x6d
  jmp alltraps
80106120:	e9 80 f7 ff ff       	jmp    801058a5 <alltraps>

80106125 <vector110>:
.globl vector110
vector110:
  pushl $0
80106125:	6a 00                	push   $0x0
  pushl $110
80106127:	6a 6e                	push   $0x6e
  jmp alltraps
80106129:	e9 77 f7 ff ff       	jmp    801058a5 <alltraps>

8010612e <vector111>:
.globl vector111
vector111:
  pushl $0
8010612e:	6a 00                	push   $0x0
  pushl $111
80106130:	6a 6f                	push   $0x6f
  jmp alltraps
80106132:	e9 6e f7 ff ff       	jmp    801058a5 <alltraps>

80106137 <vector112>:
.globl vector112
vector112:
  pushl $0
80106137:	6a 00                	push   $0x0
  pushl $112
80106139:	6a 70                	push   $0x70
  jmp alltraps
8010613b:	e9 65 f7 ff ff       	jmp    801058a5 <alltraps>

80106140 <vector113>:
.globl vector113
vector113:
  pushl $0
80106140:	6a 00                	push   $0x0
  pushl $113
80106142:	6a 71                	push   $0x71
  jmp alltraps
80106144:	e9 5c f7 ff ff       	jmp    801058a5 <alltraps>

80106149 <vector114>:
.globl vector114
vector114:
  pushl $0
80106149:	6a 00                	push   $0x0
  pushl $114
8010614b:	6a 72                	push   $0x72
  jmp alltraps
8010614d:	e9 53 f7 ff ff       	jmp    801058a5 <alltraps>

80106152 <vector115>:
.globl vector115
vector115:
  pushl $0
80106152:	6a 00                	push   $0x0
  pushl $115
80106154:	6a 73                	push   $0x73
  jmp alltraps
80106156:	e9 4a f7 ff ff       	jmp    801058a5 <alltraps>

8010615b <vector116>:
.globl vector116
vector116:
  pushl $0
8010615b:	6a 00                	push   $0x0
  pushl $116
8010615d:	6a 74                	push   $0x74
  jmp alltraps
8010615f:	e9 41 f7 ff ff       	jmp    801058a5 <alltraps>

80106164 <vector117>:
.globl vector117
vector117:
  pushl $0
80106164:	6a 00                	push   $0x0
  pushl $117
80106166:	6a 75                	push   $0x75
  jmp alltraps
80106168:	e9 38 f7 ff ff       	jmp    801058a5 <alltraps>

8010616d <vector118>:
.globl vector118
vector118:
  pushl $0
8010616d:	6a 00                	push   $0x0
  pushl $118
8010616f:	6a 76                	push   $0x76
  jmp alltraps
80106171:	e9 2f f7 ff ff       	jmp    801058a5 <alltraps>

80106176 <vector119>:
.globl vector119
vector119:
  pushl $0
80106176:	6a 00                	push   $0x0
  pushl $119
80106178:	6a 77                	push   $0x77
  jmp alltraps
8010617a:	e9 26 f7 ff ff       	jmp    801058a5 <alltraps>

8010617f <vector120>:
.globl vector120
vector120:
  pushl $0
8010617f:	6a 00                	push   $0x0
  pushl $120
80106181:	6a 78                	push   $0x78
  jmp alltraps
80106183:	e9 1d f7 ff ff       	jmp    801058a5 <alltraps>

80106188 <vector121>:
.globl vector121
vector121:
  pushl $0
80106188:	6a 00                	push   $0x0
  pushl $121
8010618a:	6a 79                	push   $0x79
  jmp alltraps
8010618c:	e9 14 f7 ff ff       	jmp    801058a5 <alltraps>

80106191 <vector122>:
.globl vector122
vector122:
  pushl $0
80106191:	6a 00                	push   $0x0
  pushl $122
80106193:	6a 7a                	push   $0x7a
  jmp alltraps
80106195:	e9 0b f7 ff ff       	jmp    801058a5 <alltraps>

8010619a <vector123>:
.globl vector123
vector123:
  pushl $0
8010619a:	6a 00                	push   $0x0
  pushl $123
8010619c:	6a 7b                	push   $0x7b
  jmp alltraps
8010619e:	e9 02 f7 ff ff       	jmp    801058a5 <alltraps>

801061a3 <vector124>:
.globl vector124
vector124:
  pushl $0
801061a3:	6a 00                	push   $0x0
  pushl $124
801061a5:	6a 7c                	push   $0x7c
  jmp alltraps
801061a7:	e9 f9 f6 ff ff       	jmp    801058a5 <alltraps>

801061ac <vector125>:
.globl vector125
vector125:
  pushl $0
801061ac:	6a 00                	push   $0x0
  pushl $125
801061ae:	6a 7d                	push   $0x7d
  jmp alltraps
801061b0:	e9 f0 f6 ff ff       	jmp    801058a5 <alltraps>

801061b5 <vector126>:
.globl vector126
vector126:
  pushl $0
801061b5:	6a 00                	push   $0x0
  pushl $126
801061b7:	6a 7e                	push   $0x7e
  jmp alltraps
801061b9:	e9 e7 f6 ff ff       	jmp    801058a5 <alltraps>

801061be <vector127>:
.globl vector127
vector127:
  pushl $0
801061be:	6a 00                	push   $0x0
  pushl $127
801061c0:	6a 7f                	push   $0x7f
  jmp alltraps
801061c2:	e9 de f6 ff ff       	jmp    801058a5 <alltraps>

801061c7 <vector128>:
.globl vector128
vector128:
  pushl $0
801061c7:	6a 00                	push   $0x0
  pushl $128
801061c9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801061ce:	e9 d2 f6 ff ff       	jmp    801058a5 <alltraps>

801061d3 <vector129>:
.globl vector129
vector129:
  pushl $0
801061d3:	6a 00                	push   $0x0
  pushl $129
801061d5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801061da:	e9 c6 f6 ff ff       	jmp    801058a5 <alltraps>

801061df <vector130>:
.globl vector130
vector130:
  pushl $0
801061df:	6a 00                	push   $0x0
  pushl $130
801061e1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801061e6:	e9 ba f6 ff ff       	jmp    801058a5 <alltraps>

801061eb <vector131>:
.globl vector131
vector131:
  pushl $0
801061eb:	6a 00                	push   $0x0
  pushl $131
801061ed:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801061f2:	e9 ae f6 ff ff       	jmp    801058a5 <alltraps>

801061f7 <vector132>:
.globl vector132
vector132:
  pushl $0
801061f7:	6a 00                	push   $0x0
  pushl $132
801061f9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801061fe:	e9 a2 f6 ff ff       	jmp    801058a5 <alltraps>

80106203 <vector133>:
.globl vector133
vector133:
  pushl $0
80106203:	6a 00                	push   $0x0
  pushl $133
80106205:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010620a:	e9 96 f6 ff ff       	jmp    801058a5 <alltraps>

8010620f <vector134>:
.globl vector134
vector134:
  pushl $0
8010620f:	6a 00                	push   $0x0
  pushl $134
80106211:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106216:	e9 8a f6 ff ff       	jmp    801058a5 <alltraps>

8010621b <vector135>:
.globl vector135
vector135:
  pushl $0
8010621b:	6a 00                	push   $0x0
  pushl $135
8010621d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106222:	e9 7e f6 ff ff       	jmp    801058a5 <alltraps>

80106227 <vector136>:
.globl vector136
vector136:
  pushl $0
80106227:	6a 00                	push   $0x0
  pushl $136
80106229:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010622e:	e9 72 f6 ff ff       	jmp    801058a5 <alltraps>

80106233 <vector137>:
.globl vector137
vector137:
  pushl $0
80106233:	6a 00                	push   $0x0
  pushl $137
80106235:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010623a:	e9 66 f6 ff ff       	jmp    801058a5 <alltraps>

8010623f <vector138>:
.globl vector138
vector138:
  pushl $0
8010623f:	6a 00                	push   $0x0
  pushl $138
80106241:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106246:	e9 5a f6 ff ff       	jmp    801058a5 <alltraps>

8010624b <vector139>:
.globl vector139
vector139:
  pushl $0
8010624b:	6a 00                	push   $0x0
  pushl $139
8010624d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106252:	e9 4e f6 ff ff       	jmp    801058a5 <alltraps>

80106257 <vector140>:
.globl vector140
vector140:
  pushl $0
80106257:	6a 00                	push   $0x0
  pushl $140
80106259:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010625e:	e9 42 f6 ff ff       	jmp    801058a5 <alltraps>

80106263 <vector141>:
.globl vector141
vector141:
  pushl $0
80106263:	6a 00                	push   $0x0
  pushl $141
80106265:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010626a:	e9 36 f6 ff ff       	jmp    801058a5 <alltraps>

8010626f <vector142>:
.globl vector142
vector142:
  pushl $0
8010626f:	6a 00                	push   $0x0
  pushl $142
80106271:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106276:	e9 2a f6 ff ff       	jmp    801058a5 <alltraps>

8010627b <vector143>:
.globl vector143
vector143:
  pushl $0
8010627b:	6a 00                	push   $0x0
  pushl $143
8010627d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106282:	e9 1e f6 ff ff       	jmp    801058a5 <alltraps>

80106287 <vector144>:
.globl vector144
vector144:
  pushl $0
80106287:	6a 00                	push   $0x0
  pushl $144
80106289:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010628e:	e9 12 f6 ff ff       	jmp    801058a5 <alltraps>

80106293 <vector145>:
.globl vector145
vector145:
  pushl $0
80106293:	6a 00                	push   $0x0
  pushl $145
80106295:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010629a:	e9 06 f6 ff ff       	jmp    801058a5 <alltraps>

8010629f <vector146>:
.globl vector146
vector146:
  pushl $0
8010629f:	6a 00                	push   $0x0
  pushl $146
801062a1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801062a6:	e9 fa f5 ff ff       	jmp    801058a5 <alltraps>

801062ab <vector147>:
.globl vector147
vector147:
  pushl $0
801062ab:	6a 00                	push   $0x0
  pushl $147
801062ad:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801062b2:	e9 ee f5 ff ff       	jmp    801058a5 <alltraps>

801062b7 <vector148>:
.globl vector148
vector148:
  pushl $0
801062b7:	6a 00                	push   $0x0
  pushl $148
801062b9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801062be:	e9 e2 f5 ff ff       	jmp    801058a5 <alltraps>

801062c3 <vector149>:
.globl vector149
vector149:
  pushl $0
801062c3:	6a 00                	push   $0x0
  pushl $149
801062c5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801062ca:	e9 d6 f5 ff ff       	jmp    801058a5 <alltraps>

801062cf <vector150>:
.globl vector150
vector150:
  pushl $0
801062cf:	6a 00                	push   $0x0
  pushl $150
801062d1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801062d6:	e9 ca f5 ff ff       	jmp    801058a5 <alltraps>

801062db <vector151>:
.globl vector151
vector151:
  pushl $0
801062db:	6a 00                	push   $0x0
  pushl $151
801062dd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801062e2:	e9 be f5 ff ff       	jmp    801058a5 <alltraps>

801062e7 <vector152>:
.globl vector152
vector152:
  pushl $0
801062e7:	6a 00                	push   $0x0
  pushl $152
801062e9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801062ee:	e9 b2 f5 ff ff       	jmp    801058a5 <alltraps>

801062f3 <vector153>:
.globl vector153
vector153:
  pushl $0
801062f3:	6a 00                	push   $0x0
  pushl $153
801062f5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801062fa:	e9 a6 f5 ff ff       	jmp    801058a5 <alltraps>

801062ff <vector154>:
.globl vector154
vector154:
  pushl $0
801062ff:	6a 00                	push   $0x0
  pushl $154
80106301:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106306:	e9 9a f5 ff ff       	jmp    801058a5 <alltraps>

8010630b <vector155>:
.globl vector155
vector155:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $155
8010630d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106312:	e9 8e f5 ff ff       	jmp    801058a5 <alltraps>

80106317 <vector156>:
.globl vector156
vector156:
  pushl $0
80106317:	6a 00                	push   $0x0
  pushl $156
80106319:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010631e:	e9 82 f5 ff ff       	jmp    801058a5 <alltraps>

80106323 <vector157>:
.globl vector157
vector157:
  pushl $0
80106323:	6a 00                	push   $0x0
  pushl $157
80106325:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010632a:	e9 76 f5 ff ff       	jmp    801058a5 <alltraps>

8010632f <vector158>:
.globl vector158
vector158:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $158
80106331:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106336:	e9 6a f5 ff ff       	jmp    801058a5 <alltraps>

8010633b <vector159>:
.globl vector159
vector159:
  pushl $0
8010633b:	6a 00                	push   $0x0
  pushl $159
8010633d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106342:	e9 5e f5 ff ff       	jmp    801058a5 <alltraps>

80106347 <vector160>:
.globl vector160
vector160:
  pushl $0
80106347:	6a 00                	push   $0x0
  pushl $160
80106349:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010634e:	e9 52 f5 ff ff       	jmp    801058a5 <alltraps>

80106353 <vector161>:
.globl vector161
vector161:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $161
80106355:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010635a:	e9 46 f5 ff ff       	jmp    801058a5 <alltraps>

8010635f <vector162>:
.globl vector162
vector162:
  pushl $0
8010635f:	6a 00                	push   $0x0
  pushl $162
80106361:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106366:	e9 3a f5 ff ff       	jmp    801058a5 <alltraps>

8010636b <vector163>:
.globl vector163
vector163:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $163
8010636d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106372:	e9 2e f5 ff ff       	jmp    801058a5 <alltraps>

80106377 <vector164>:
.globl vector164
vector164:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $164
80106379:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010637e:	e9 22 f5 ff ff       	jmp    801058a5 <alltraps>

80106383 <vector165>:
.globl vector165
vector165:
  pushl $0
80106383:	6a 00                	push   $0x0
  pushl $165
80106385:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010638a:	e9 16 f5 ff ff       	jmp    801058a5 <alltraps>

8010638f <vector166>:
.globl vector166
vector166:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $166
80106391:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106396:	e9 0a f5 ff ff       	jmp    801058a5 <alltraps>

8010639b <vector167>:
.globl vector167
vector167:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $167
8010639d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801063a2:	e9 fe f4 ff ff       	jmp    801058a5 <alltraps>

801063a7 <vector168>:
.globl vector168
vector168:
  pushl $0
801063a7:	6a 00                	push   $0x0
  pushl $168
801063a9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801063ae:	e9 f2 f4 ff ff       	jmp    801058a5 <alltraps>

801063b3 <vector169>:
.globl vector169
vector169:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $169
801063b5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801063ba:	e9 e6 f4 ff ff       	jmp    801058a5 <alltraps>

801063bf <vector170>:
.globl vector170
vector170:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $170
801063c1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801063c6:	e9 da f4 ff ff       	jmp    801058a5 <alltraps>

801063cb <vector171>:
.globl vector171
vector171:
  pushl $0
801063cb:	6a 00                	push   $0x0
  pushl $171
801063cd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801063d2:	e9 ce f4 ff ff       	jmp    801058a5 <alltraps>

801063d7 <vector172>:
.globl vector172
vector172:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $172
801063d9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801063de:	e9 c2 f4 ff ff       	jmp    801058a5 <alltraps>

801063e3 <vector173>:
.globl vector173
vector173:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $173
801063e5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801063ea:	e9 b6 f4 ff ff       	jmp    801058a5 <alltraps>

801063ef <vector174>:
.globl vector174
vector174:
  pushl $0
801063ef:	6a 00                	push   $0x0
  pushl $174
801063f1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801063f6:	e9 aa f4 ff ff       	jmp    801058a5 <alltraps>

801063fb <vector175>:
.globl vector175
vector175:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $175
801063fd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106402:	e9 9e f4 ff ff       	jmp    801058a5 <alltraps>

80106407 <vector176>:
.globl vector176
vector176:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $176
80106409:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010640e:	e9 92 f4 ff ff       	jmp    801058a5 <alltraps>

80106413 <vector177>:
.globl vector177
vector177:
  pushl $0
80106413:	6a 00                	push   $0x0
  pushl $177
80106415:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010641a:	e9 86 f4 ff ff       	jmp    801058a5 <alltraps>

8010641f <vector178>:
.globl vector178
vector178:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $178
80106421:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106426:	e9 7a f4 ff ff       	jmp    801058a5 <alltraps>

8010642b <vector179>:
.globl vector179
vector179:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $179
8010642d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106432:	e9 6e f4 ff ff       	jmp    801058a5 <alltraps>

80106437 <vector180>:
.globl vector180
vector180:
  pushl $0
80106437:	6a 00                	push   $0x0
  pushl $180
80106439:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010643e:	e9 62 f4 ff ff       	jmp    801058a5 <alltraps>

80106443 <vector181>:
.globl vector181
vector181:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $181
80106445:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010644a:	e9 56 f4 ff ff       	jmp    801058a5 <alltraps>

8010644f <vector182>:
.globl vector182
vector182:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $182
80106451:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106456:	e9 4a f4 ff ff       	jmp    801058a5 <alltraps>

8010645b <vector183>:
.globl vector183
vector183:
  pushl $0
8010645b:	6a 00                	push   $0x0
  pushl $183
8010645d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106462:	e9 3e f4 ff ff       	jmp    801058a5 <alltraps>

80106467 <vector184>:
.globl vector184
vector184:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $184
80106469:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010646e:	e9 32 f4 ff ff       	jmp    801058a5 <alltraps>

80106473 <vector185>:
.globl vector185
vector185:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $185
80106475:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010647a:	e9 26 f4 ff ff       	jmp    801058a5 <alltraps>

8010647f <vector186>:
.globl vector186
vector186:
  pushl $0
8010647f:	6a 00                	push   $0x0
  pushl $186
80106481:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106486:	e9 1a f4 ff ff       	jmp    801058a5 <alltraps>

8010648b <vector187>:
.globl vector187
vector187:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $187
8010648d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106492:	e9 0e f4 ff ff       	jmp    801058a5 <alltraps>

80106497 <vector188>:
.globl vector188
vector188:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $188
80106499:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010649e:	e9 02 f4 ff ff       	jmp    801058a5 <alltraps>

801064a3 <vector189>:
.globl vector189
vector189:
  pushl $0
801064a3:	6a 00                	push   $0x0
  pushl $189
801064a5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801064aa:	e9 f6 f3 ff ff       	jmp    801058a5 <alltraps>

801064af <vector190>:
.globl vector190
vector190:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $190
801064b1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801064b6:	e9 ea f3 ff ff       	jmp    801058a5 <alltraps>

801064bb <vector191>:
.globl vector191
vector191:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $191
801064bd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801064c2:	e9 de f3 ff ff       	jmp    801058a5 <alltraps>

801064c7 <vector192>:
.globl vector192
vector192:
  pushl $0
801064c7:	6a 00                	push   $0x0
  pushl $192
801064c9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801064ce:	e9 d2 f3 ff ff       	jmp    801058a5 <alltraps>

801064d3 <vector193>:
.globl vector193
vector193:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $193
801064d5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801064da:	e9 c6 f3 ff ff       	jmp    801058a5 <alltraps>

801064df <vector194>:
.globl vector194
vector194:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $194
801064e1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801064e6:	e9 ba f3 ff ff       	jmp    801058a5 <alltraps>

801064eb <vector195>:
.globl vector195
vector195:
  pushl $0
801064eb:	6a 00                	push   $0x0
  pushl $195
801064ed:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801064f2:	e9 ae f3 ff ff       	jmp    801058a5 <alltraps>

801064f7 <vector196>:
.globl vector196
vector196:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $196
801064f9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801064fe:	e9 a2 f3 ff ff       	jmp    801058a5 <alltraps>

80106503 <vector197>:
.globl vector197
vector197:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $197
80106505:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010650a:	e9 96 f3 ff ff       	jmp    801058a5 <alltraps>

8010650f <vector198>:
.globl vector198
vector198:
  pushl $0
8010650f:	6a 00                	push   $0x0
  pushl $198
80106511:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106516:	e9 8a f3 ff ff       	jmp    801058a5 <alltraps>

8010651b <vector199>:
.globl vector199
vector199:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $199
8010651d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106522:	e9 7e f3 ff ff       	jmp    801058a5 <alltraps>

80106527 <vector200>:
.globl vector200
vector200:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $200
80106529:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010652e:	e9 72 f3 ff ff       	jmp    801058a5 <alltraps>

80106533 <vector201>:
.globl vector201
vector201:
  pushl $0
80106533:	6a 00                	push   $0x0
  pushl $201
80106535:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010653a:	e9 66 f3 ff ff       	jmp    801058a5 <alltraps>

8010653f <vector202>:
.globl vector202
vector202:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $202
80106541:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106546:	e9 5a f3 ff ff       	jmp    801058a5 <alltraps>

8010654b <vector203>:
.globl vector203
vector203:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $203
8010654d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106552:	e9 4e f3 ff ff       	jmp    801058a5 <alltraps>

80106557 <vector204>:
.globl vector204
vector204:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $204
80106559:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010655e:	e9 42 f3 ff ff       	jmp    801058a5 <alltraps>

80106563 <vector205>:
.globl vector205
vector205:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $205
80106565:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010656a:	e9 36 f3 ff ff       	jmp    801058a5 <alltraps>

8010656f <vector206>:
.globl vector206
vector206:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $206
80106571:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106576:	e9 2a f3 ff ff       	jmp    801058a5 <alltraps>

8010657b <vector207>:
.globl vector207
vector207:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $207
8010657d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106582:	e9 1e f3 ff ff       	jmp    801058a5 <alltraps>

80106587 <vector208>:
.globl vector208
vector208:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $208
80106589:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010658e:	e9 12 f3 ff ff       	jmp    801058a5 <alltraps>

80106593 <vector209>:
.globl vector209
vector209:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $209
80106595:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010659a:	e9 06 f3 ff ff       	jmp    801058a5 <alltraps>

8010659f <vector210>:
.globl vector210
vector210:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $210
801065a1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801065a6:	e9 fa f2 ff ff       	jmp    801058a5 <alltraps>

801065ab <vector211>:
.globl vector211
vector211:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $211
801065ad:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801065b2:	e9 ee f2 ff ff       	jmp    801058a5 <alltraps>

801065b7 <vector212>:
.globl vector212
vector212:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $212
801065b9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801065be:	e9 e2 f2 ff ff       	jmp    801058a5 <alltraps>

801065c3 <vector213>:
.globl vector213
vector213:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $213
801065c5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801065ca:	e9 d6 f2 ff ff       	jmp    801058a5 <alltraps>

801065cf <vector214>:
.globl vector214
vector214:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $214
801065d1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801065d6:	e9 ca f2 ff ff       	jmp    801058a5 <alltraps>

801065db <vector215>:
.globl vector215
vector215:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $215
801065dd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801065e2:	e9 be f2 ff ff       	jmp    801058a5 <alltraps>

801065e7 <vector216>:
.globl vector216
vector216:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $216
801065e9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801065ee:	e9 b2 f2 ff ff       	jmp    801058a5 <alltraps>

801065f3 <vector217>:
.globl vector217
vector217:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $217
801065f5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801065fa:	e9 a6 f2 ff ff       	jmp    801058a5 <alltraps>

801065ff <vector218>:
.globl vector218
vector218:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $218
80106601:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106606:	e9 9a f2 ff ff       	jmp    801058a5 <alltraps>

8010660b <vector219>:
.globl vector219
vector219:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $219
8010660d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106612:	e9 8e f2 ff ff       	jmp    801058a5 <alltraps>

80106617 <vector220>:
.globl vector220
vector220:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $220
80106619:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010661e:	e9 82 f2 ff ff       	jmp    801058a5 <alltraps>

80106623 <vector221>:
.globl vector221
vector221:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $221
80106625:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010662a:	e9 76 f2 ff ff       	jmp    801058a5 <alltraps>

8010662f <vector222>:
.globl vector222
vector222:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $222
80106631:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106636:	e9 6a f2 ff ff       	jmp    801058a5 <alltraps>

8010663b <vector223>:
.globl vector223
vector223:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $223
8010663d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106642:	e9 5e f2 ff ff       	jmp    801058a5 <alltraps>

80106647 <vector224>:
.globl vector224
vector224:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $224
80106649:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010664e:	e9 52 f2 ff ff       	jmp    801058a5 <alltraps>

80106653 <vector225>:
.globl vector225
vector225:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $225
80106655:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010665a:	e9 46 f2 ff ff       	jmp    801058a5 <alltraps>

8010665f <vector226>:
.globl vector226
vector226:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $226
80106661:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106666:	e9 3a f2 ff ff       	jmp    801058a5 <alltraps>

8010666b <vector227>:
.globl vector227
vector227:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $227
8010666d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106672:	e9 2e f2 ff ff       	jmp    801058a5 <alltraps>

80106677 <vector228>:
.globl vector228
vector228:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $228
80106679:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010667e:	e9 22 f2 ff ff       	jmp    801058a5 <alltraps>

80106683 <vector229>:
.globl vector229
vector229:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $229
80106685:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010668a:	e9 16 f2 ff ff       	jmp    801058a5 <alltraps>

8010668f <vector230>:
.globl vector230
vector230:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $230
80106691:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106696:	e9 0a f2 ff ff       	jmp    801058a5 <alltraps>

8010669b <vector231>:
.globl vector231
vector231:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $231
8010669d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801066a2:	e9 fe f1 ff ff       	jmp    801058a5 <alltraps>

801066a7 <vector232>:
.globl vector232
vector232:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $232
801066a9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801066ae:	e9 f2 f1 ff ff       	jmp    801058a5 <alltraps>

801066b3 <vector233>:
.globl vector233
vector233:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $233
801066b5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801066ba:	e9 e6 f1 ff ff       	jmp    801058a5 <alltraps>

801066bf <vector234>:
.globl vector234
vector234:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $234
801066c1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801066c6:	e9 da f1 ff ff       	jmp    801058a5 <alltraps>

801066cb <vector235>:
.globl vector235
vector235:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $235
801066cd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801066d2:	e9 ce f1 ff ff       	jmp    801058a5 <alltraps>

801066d7 <vector236>:
.globl vector236
vector236:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $236
801066d9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801066de:	e9 c2 f1 ff ff       	jmp    801058a5 <alltraps>

801066e3 <vector237>:
.globl vector237
vector237:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $237
801066e5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801066ea:	e9 b6 f1 ff ff       	jmp    801058a5 <alltraps>

801066ef <vector238>:
.globl vector238
vector238:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $238
801066f1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801066f6:	e9 aa f1 ff ff       	jmp    801058a5 <alltraps>

801066fb <vector239>:
.globl vector239
vector239:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $239
801066fd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106702:	e9 9e f1 ff ff       	jmp    801058a5 <alltraps>

80106707 <vector240>:
.globl vector240
vector240:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $240
80106709:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010670e:	e9 92 f1 ff ff       	jmp    801058a5 <alltraps>

80106713 <vector241>:
.globl vector241
vector241:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $241
80106715:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010671a:	e9 86 f1 ff ff       	jmp    801058a5 <alltraps>

8010671f <vector242>:
.globl vector242
vector242:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $242
80106721:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106726:	e9 7a f1 ff ff       	jmp    801058a5 <alltraps>

8010672b <vector243>:
.globl vector243
vector243:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $243
8010672d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106732:	e9 6e f1 ff ff       	jmp    801058a5 <alltraps>

80106737 <vector244>:
.globl vector244
vector244:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $244
80106739:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010673e:	e9 62 f1 ff ff       	jmp    801058a5 <alltraps>

80106743 <vector245>:
.globl vector245
vector245:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $245
80106745:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010674a:	e9 56 f1 ff ff       	jmp    801058a5 <alltraps>

8010674f <vector246>:
.globl vector246
vector246:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $246
80106751:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106756:	e9 4a f1 ff ff       	jmp    801058a5 <alltraps>

8010675b <vector247>:
.globl vector247
vector247:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $247
8010675d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106762:	e9 3e f1 ff ff       	jmp    801058a5 <alltraps>

80106767 <vector248>:
.globl vector248
vector248:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $248
80106769:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010676e:	e9 32 f1 ff ff       	jmp    801058a5 <alltraps>

80106773 <vector249>:
.globl vector249
vector249:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $249
80106775:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010677a:	e9 26 f1 ff ff       	jmp    801058a5 <alltraps>

8010677f <vector250>:
.globl vector250
vector250:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $250
80106781:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106786:	e9 1a f1 ff ff       	jmp    801058a5 <alltraps>

8010678b <vector251>:
.globl vector251
vector251:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $251
8010678d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106792:	e9 0e f1 ff ff       	jmp    801058a5 <alltraps>

80106797 <vector252>:
.globl vector252
vector252:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $252
80106799:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010679e:	e9 02 f1 ff ff       	jmp    801058a5 <alltraps>

801067a3 <vector253>:
.globl vector253
vector253:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $253
801067a5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801067aa:	e9 f6 f0 ff ff       	jmp    801058a5 <alltraps>

801067af <vector254>:
.globl vector254
vector254:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $254
801067b1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801067b6:	e9 ea f0 ff ff       	jmp    801058a5 <alltraps>

801067bb <vector255>:
.globl vector255
vector255:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $255
801067bd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801067c2:	e9 de f0 ff ff       	jmp    801058a5 <alltraps>
801067c7:	66 90                	xchg   %ax,%ax
801067c9:	66 90                	xchg   %ax,%ax
801067cb:	66 90                	xchg   %ax,%ax
801067cd:	66 90                	xchg   %ax,%ax
801067cf:	90                   	nop

801067d0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801067d0:	55                   	push   %ebp
801067d1:	89 e5                	mov    %esp,%ebp
801067d3:	57                   	push   %edi
801067d4:	56                   	push   %esi
801067d5:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801067d7:	c1 ea 16             	shr    $0x16,%edx
{
801067da:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
801067db:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
801067de:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801067e1:	8b 1f                	mov    (%edi),%ebx
801067e3:	f6 c3 01             	test   $0x1,%bl
801067e6:	74 28                	je     80106810 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801067e8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801067ee:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801067f4:	89 f0                	mov    %esi,%eax
}
801067f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801067f9:	c1 e8 0a             	shr    $0xa,%eax
801067fc:	25 fc 0f 00 00       	and    $0xffc,%eax
80106801:	01 d8                	add    %ebx,%eax
}
80106803:	5b                   	pop    %ebx
80106804:	5e                   	pop    %esi
80106805:	5f                   	pop    %edi
80106806:	5d                   	pop    %ebp
80106807:	c3                   	ret    
80106808:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010680f:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106810:	85 c9                	test   %ecx,%ecx
80106812:	74 2c                	je     80106840 <walkpgdir+0x70>
80106814:	e8 c7 bf ff ff       	call   801027e0 <kalloc>
80106819:	89 c3                	mov    %eax,%ebx
8010681b:	85 c0                	test   %eax,%eax
8010681d:	74 21                	je     80106840 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010681f:	83 ec 04             	sub    $0x4,%esp
80106822:	68 00 10 00 00       	push   $0x1000
80106827:	6a 00                	push   $0x0
80106829:	50                   	push   %eax
8010682a:	e8 f1 de ff ff       	call   80104720 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010682f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106835:	83 c4 10             	add    $0x10,%esp
80106838:	83 c8 07             	or     $0x7,%eax
8010683b:	89 07                	mov    %eax,(%edi)
8010683d:	eb b5                	jmp    801067f4 <walkpgdir+0x24>
8010683f:	90                   	nop
}
80106840:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106843:	31 c0                	xor    %eax,%eax
}
80106845:	5b                   	pop    %ebx
80106846:	5e                   	pop    %esi
80106847:	5f                   	pop    %edi
80106848:	5d                   	pop    %ebp
80106849:	c3                   	ret    
8010684a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106850 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106850:	55                   	push   %ebp
80106851:	89 e5                	mov    %esp,%ebp
80106853:	57                   	push   %edi
80106854:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106856:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
8010685a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010685b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80106860:	89 d6                	mov    %edx,%esi
{
80106862:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106863:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80106869:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010686c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010686f:	8b 45 08             	mov    0x8(%ebp),%eax
80106872:	29 f0                	sub    %esi,%eax
80106874:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106877:	eb 1f                	jmp    80106898 <mappages+0x48>
80106879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106880:	f6 00 01             	testb  $0x1,(%eax)
80106883:	75 45                	jne    801068ca <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106885:	0b 5d 0c             	or     0xc(%ebp),%ebx
80106888:	83 cb 01             	or     $0x1,%ebx
8010688b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
8010688d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80106890:	74 2e                	je     801068c0 <mappages+0x70>
      break;
    a += PGSIZE;
80106892:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80106898:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010689b:	b9 01 00 00 00       	mov    $0x1,%ecx
801068a0:	89 f2                	mov    %esi,%edx
801068a2:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
801068a5:	89 f8                	mov    %edi,%eax
801068a7:	e8 24 ff ff ff       	call   801067d0 <walkpgdir>
801068ac:	85 c0                	test   %eax,%eax
801068ae:	75 d0                	jne    80106880 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801068b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801068b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801068b8:	5b                   	pop    %ebx
801068b9:	5e                   	pop    %esi
801068ba:	5f                   	pop    %edi
801068bb:	5d                   	pop    %ebp
801068bc:	c3                   	ret    
801068bd:	8d 76 00             	lea    0x0(%esi),%esi
801068c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801068c3:	31 c0                	xor    %eax,%eax
}
801068c5:	5b                   	pop    %ebx
801068c6:	5e                   	pop    %esi
801068c7:	5f                   	pop    %edi
801068c8:	5d                   	pop    %ebp
801068c9:	c3                   	ret    
      panic("remap");
801068ca:	83 ec 0c             	sub    $0xc,%esp
801068cd:	68 8c 7a 10 80       	push   $0x80107a8c
801068d2:	e8 a9 9a ff ff       	call   80100380 <panic>
801068d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068de:	66 90                	xchg   %ax,%ax

801068e0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801068e0:	55                   	push   %ebp
801068e1:	89 e5                	mov    %esp,%ebp
801068e3:	57                   	push   %edi
801068e4:	56                   	push   %esi
801068e5:	89 c6                	mov    %eax,%esi
801068e7:	53                   	push   %ebx
801068e8:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801068ea:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
801068f0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801068f6:	83 ec 1c             	sub    $0x1c,%esp
801068f9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801068fc:	39 da                	cmp    %ebx,%edx
801068fe:	73 5b                	jae    8010695b <deallocuvm.part.0+0x7b>
80106900:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80106903:	89 d7                	mov    %edx,%edi
80106905:	eb 14                	jmp    8010691b <deallocuvm.part.0+0x3b>
80106907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010690e:	66 90                	xchg   %ax,%ax
80106910:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106916:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80106919:	76 40                	jbe    8010695b <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010691b:	31 c9                	xor    %ecx,%ecx
8010691d:	89 fa                	mov    %edi,%edx
8010691f:	89 f0                	mov    %esi,%eax
80106921:	e8 aa fe ff ff       	call   801067d0 <walkpgdir>
80106926:	89 c3                	mov    %eax,%ebx
    if(!pte)
80106928:	85 c0                	test   %eax,%eax
8010692a:	74 44                	je     80106970 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
8010692c:	8b 00                	mov    (%eax),%eax
8010692e:	a8 01                	test   $0x1,%al
80106930:	74 de                	je     80106910 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106932:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106937:	74 47                	je     80106980 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106939:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010693c:	05 00 00 00 80       	add    $0x80000000,%eax
80106941:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
80106947:	50                   	push   %eax
80106948:	e8 d3 bc ff ff       	call   80102620 <kfree>
      *pte = 0;
8010694d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80106953:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80106956:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80106959:	77 c0                	ja     8010691b <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
8010695b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010695e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106961:	5b                   	pop    %ebx
80106962:	5e                   	pop    %esi
80106963:	5f                   	pop    %edi
80106964:	5d                   	pop    %ebp
80106965:	c3                   	ret    
80106966:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010696d:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106970:	89 fa                	mov    %edi,%edx
80106972:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80106978:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
8010697e:	eb 96                	jmp    80106916 <deallocuvm.part.0+0x36>
        panic("kfree");
80106980:	83 ec 0c             	sub    $0xc,%esp
80106983:	68 36 74 10 80       	push   $0x80107436
80106988:	e8 f3 99 ff ff       	call   80100380 <panic>
8010698d:	8d 76 00             	lea    0x0(%esi),%esi

80106990 <seginit>:
{
80106990:	55                   	push   %ebp
80106991:	89 e5                	mov    %esp,%ebp
80106993:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106996:	e8 f5 d0 ff ff       	call   80103a90 <cpuid>
  pd[0] = size-1;
8010699b:	ba 2f 00 00 00       	mov    $0x2f,%edx
801069a0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801069a6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801069aa:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
801069b1:	ff 00 00 
801069b4:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
801069bb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801069be:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
801069c5:	ff 00 00 
801069c8:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
801069cf:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801069d2:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
801069d9:	ff 00 00 
801069dc:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
801069e3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801069e6:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
801069ed:	ff 00 00 
801069f0:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
801069f7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801069fa:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
801069ff:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106a03:	c1 e8 10             	shr    $0x10,%eax
80106a06:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106a0a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106a0d:	0f 01 10             	lgdtl  (%eax)
}
80106a10:	c9                   	leave  
80106a11:	c3                   	ret    
80106a12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a20 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106a20:	a1 a4 54 11 80       	mov    0x801154a4,%eax
80106a25:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106a2a:	0f 22 d8             	mov    %eax,%cr3
}
80106a2d:	c3                   	ret    
80106a2e:	66 90                	xchg   %ax,%ax

80106a30 <switchuvm>:
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	57                   	push   %edi
80106a34:	56                   	push   %esi
80106a35:	53                   	push   %ebx
80106a36:	83 ec 1c             	sub    $0x1c,%esp
80106a39:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106a3c:	85 f6                	test   %esi,%esi
80106a3e:	0f 84 cb 00 00 00    	je     80106b0f <switchuvm+0xdf>
  if(p->kstack == 0)
80106a44:	8b 46 08             	mov    0x8(%esi),%eax
80106a47:	85 c0                	test   %eax,%eax
80106a49:	0f 84 da 00 00 00    	je     80106b29 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106a4f:	8b 46 04             	mov    0x4(%esi),%eax
80106a52:	85 c0                	test   %eax,%eax
80106a54:	0f 84 c2 00 00 00    	je     80106b1c <switchuvm+0xec>
  pushcli();
80106a5a:	e8 01 db ff ff       	call   80104560 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106a5f:	e8 bc cf ff ff       	call   80103a20 <mycpu>
80106a64:	89 c3                	mov    %eax,%ebx
80106a66:	e8 b5 cf ff ff       	call   80103a20 <mycpu>
80106a6b:	89 c7                	mov    %eax,%edi
80106a6d:	e8 ae cf ff ff       	call   80103a20 <mycpu>
80106a72:	83 c7 08             	add    $0x8,%edi
80106a75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a78:	e8 a3 cf ff ff       	call   80103a20 <mycpu>
80106a7d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106a80:	ba 67 00 00 00       	mov    $0x67,%edx
80106a85:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106a8c:	83 c0 08             	add    $0x8,%eax
80106a8f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a96:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106a9b:	83 c1 08             	add    $0x8,%ecx
80106a9e:	c1 e8 18             	shr    $0x18,%eax
80106aa1:	c1 e9 10             	shr    $0x10,%ecx
80106aa4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106aaa:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106ab0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106ab5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106abc:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106ac1:	e8 5a cf ff ff       	call   80103a20 <mycpu>
80106ac6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106acd:	e8 4e cf ff ff       	call   80103a20 <mycpu>
80106ad2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106ad6:	8b 5e 08             	mov    0x8(%esi),%ebx
80106ad9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106adf:	e8 3c cf ff ff       	call   80103a20 <mycpu>
80106ae4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106ae7:	e8 34 cf ff ff       	call   80103a20 <mycpu>
80106aec:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106af0:	b8 28 00 00 00       	mov    $0x28,%eax
80106af5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106af8:	8b 46 04             	mov    0x4(%esi),%eax
80106afb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b00:	0f 22 d8             	mov    %eax,%cr3
}
80106b03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b06:	5b                   	pop    %ebx
80106b07:	5e                   	pop    %esi
80106b08:	5f                   	pop    %edi
80106b09:	5d                   	pop    %ebp
  popcli();
80106b0a:	e9 61 db ff ff       	jmp    80104670 <popcli>
    panic("switchuvm: no process");
80106b0f:	83 ec 0c             	sub    $0xc,%esp
80106b12:	68 92 7a 10 80       	push   $0x80107a92
80106b17:	e8 64 98 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106b1c:	83 ec 0c             	sub    $0xc,%esp
80106b1f:	68 bd 7a 10 80       	push   $0x80107abd
80106b24:	e8 57 98 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106b29:	83 ec 0c             	sub    $0xc,%esp
80106b2c:	68 a8 7a 10 80       	push   $0x80107aa8
80106b31:	e8 4a 98 ff ff       	call   80100380 <panic>
80106b36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b3d:	8d 76 00             	lea    0x0(%esi),%esi

80106b40 <inituvm>:
{
80106b40:	55                   	push   %ebp
80106b41:	89 e5                	mov    %esp,%ebp
80106b43:	57                   	push   %edi
80106b44:	56                   	push   %esi
80106b45:	53                   	push   %ebx
80106b46:	83 ec 1c             	sub    $0x1c,%esp
80106b49:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b4c:	8b 75 10             	mov    0x10(%ebp),%esi
80106b4f:	8b 7d 08             	mov    0x8(%ebp),%edi
80106b52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106b55:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106b5b:	77 4b                	ja     80106ba8 <inituvm+0x68>
  mem = kalloc();
80106b5d:	e8 7e bc ff ff       	call   801027e0 <kalloc>
  memset(mem, 0, PGSIZE);
80106b62:	83 ec 04             	sub    $0x4,%esp
80106b65:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106b6a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106b6c:	6a 00                	push   $0x0
80106b6e:	50                   	push   %eax
80106b6f:	e8 ac db ff ff       	call   80104720 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106b74:	58                   	pop    %eax
80106b75:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b7b:	5a                   	pop    %edx
80106b7c:	6a 06                	push   $0x6
80106b7e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b83:	31 d2                	xor    %edx,%edx
80106b85:	50                   	push   %eax
80106b86:	89 f8                	mov    %edi,%eax
80106b88:	e8 c3 fc ff ff       	call   80106850 <mappages>
  memmove(mem, init, sz);
80106b8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b90:	89 75 10             	mov    %esi,0x10(%ebp)
80106b93:	83 c4 10             	add    $0x10,%esp
80106b96:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106b99:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80106b9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b9f:	5b                   	pop    %ebx
80106ba0:	5e                   	pop    %esi
80106ba1:	5f                   	pop    %edi
80106ba2:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106ba3:	e9 18 dc ff ff       	jmp    801047c0 <memmove>
    panic("inituvm: more than a page");
80106ba8:	83 ec 0c             	sub    $0xc,%esp
80106bab:	68 d1 7a 10 80       	push   $0x80107ad1
80106bb0:	e8 cb 97 ff ff       	call   80100380 <panic>
80106bb5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106bc0 <loaduvm>:
{
80106bc0:	55                   	push   %ebp
80106bc1:	89 e5                	mov    %esp,%ebp
80106bc3:	57                   	push   %edi
80106bc4:	56                   	push   %esi
80106bc5:	53                   	push   %ebx
80106bc6:	83 ec 1c             	sub    $0x1c,%esp
80106bc9:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bcc:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80106bcf:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106bd4:	0f 85 8d 00 00 00    	jne    80106c67 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106bda:	01 f0                	add    %esi,%eax
80106bdc:	89 f3                	mov    %esi,%ebx
80106bde:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106be1:	8b 45 14             	mov    0x14(%ebp),%eax
80106be4:	01 f0                	add    %esi,%eax
80106be6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80106be9:	85 f6                	test   %esi,%esi
80106beb:	75 11                	jne    80106bfe <loaduvm+0x3e>
80106bed:	eb 61                	jmp    80106c50 <loaduvm+0x90>
80106bef:	90                   	nop
80106bf0:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80106bf6:	89 f0                	mov    %esi,%eax
80106bf8:	29 d8                	sub    %ebx,%eax
80106bfa:	39 c6                	cmp    %eax,%esi
80106bfc:	76 52                	jbe    80106c50 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106bfe:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106c01:	8b 45 08             	mov    0x8(%ebp),%eax
80106c04:	31 c9                	xor    %ecx,%ecx
80106c06:	29 da                	sub    %ebx,%edx
80106c08:	e8 c3 fb ff ff       	call   801067d0 <walkpgdir>
80106c0d:	85 c0                	test   %eax,%eax
80106c0f:	74 49                	je     80106c5a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106c11:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106c13:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80106c16:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106c1b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106c20:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80106c26:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106c29:	29 d9                	sub    %ebx,%ecx
80106c2b:	05 00 00 00 80       	add    $0x80000000,%eax
80106c30:	57                   	push   %edi
80106c31:	51                   	push   %ecx
80106c32:	50                   	push   %eax
80106c33:	ff 75 10             	pushl  0x10(%ebp)
80106c36:	e8 b5 ad ff ff       	call   801019f0 <readi>
80106c3b:	83 c4 10             	add    $0x10,%esp
80106c3e:	39 f8                	cmp    %edi,%eax
80106c40:	74 ae                	je     80106bf0 <loaduvm+0x30>
}
80106c42:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106c45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c4a:	5b                   	pop    %ebx
80106c4b:	5e                   	pop    %esi
80106c4c:	5f                   	pop    %edi
80106c4d:	5d                   	pop    %ebp
80106c4e:	c3                   	ret    
80106c4f:	90                   	nop
80106c50:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106c53:	31 c0                	xor    %eax,%eax
}
80106c55:	5b                   	pop    %ebx
80106c56:	5e                   	pop    %esi
80106c57:	5f                   	pop    %edi
80106c58:	5d                   	pop    %ebp
80106c59:	c3                   	ret    
      panic("loaduvm: address should exist");
80106c5a:	83 ec 0c             	sub    $0xc,%esp
80106c5d:	68 eb 7a 10 80       	push   $0x80107aeb
80106c62:	e8 19 97 ff ff       	call   80100380 <panic>
    panic("loaduvm: addr must be page aligned");
80106c67:	83 ec 0c             	sub    $0xc,%esp
80106c6a:	68 8c 7b 10 80       	push   $0x80107b8c
80106c6f:	e8 0c 97 ff ff       	call   80100380 <panic>
80106c74:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106c7f:	90                   	nop

80106c80 <allocuvm>:
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	57                   	push   %edi
80106c84:	56                   	push   %esi
80106c85:	53                   	push   %ebx
80106c86:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106c89:	8b 45 10             	mov    0x10(%ebp),%eax
{
80106c8c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80106c8f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106c92:	85 c0                	test   %eax,%eax
80106c94:	0f 88 b6 00 00 00    	js     80106d50 <allocuvm+0xd0>
  if(newsz < oldsz)
80106c9a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80106c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80106ca0:	0f 82 9a 00 00 00    	jb     80106d40 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106ca6:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80106cac:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80106cb2:	39 75 10             	cmp    %esi,0x10(%ebp)
80106cb5:	77 44                	ja     80106cfb <allocuvm+0x7b>
80106cb7:	e9 87 00 00 00       	jmp    80106d43 <allocuvm+0xc3>
80106cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80106cc0:	83 ec 04             	sub    $0x4,%esp
80106cc3:	68 00 10 00 00       	push   $0x1000
80106cc8:	6a 00                	push   $0x0
80106cca:	50                   	push   %eax
80106ccb:	e8 50 da ff ff       	call   80104720 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106cd0:	58                   	pop    %eax
80106cd1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106cd7:	5a                   	pop    %edx
80106cd8:	6a 06                	push   $0x6
80106cda:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106cdf:	89 f2                	mov    %esi,%edx
80106ce1:	50                   	push   %eax
80106ce2:	89 f8                	mov    %edi,%eax
80106ce4:	e8 67 fb ff ff       	call   80106850 <mappages>
80106ce9:	83 c4 10             	add    $0x10,%esp
80106cec:	85 c0                	test   %eax,%eax
80106cee:	78 78                	js     80106d68 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80106cf0:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106cf6:	39 75 10             	cmp    %esi,0x10(%ebp)
80106cf9:	76 48                	jbe    80106d43 <allocuvm+0xc3>
    mem = kalloc();
80106cfb:	e8 e0 ba ff ff       	call   801027e0 <kalloc>
80106d00:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106d02:	85 c0                	test   %eax,%eax
80106d04:	75 ba                	jne    80106cc0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106d06:	83 ec 0c             	sub    $0xc,%esp
80106d09:	68 09 7b 10 80       	push   $0x80107b09
80106d0e:	e8 8d 99 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80106d13:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d16:	83 c4 10             	add    $0x10,%esp
80106d19:	39 45 10             	cmp    %eax,0x10(%ebp)
80106d1c:	74 32                	je     80106d50 <allocuvm+0xd0>
80106d1e:	8b 55 10             	mov    0x10(%ebp),%edx
80106d21:	89 c1                	mov    %eax,%ecx
80106d23:	89 f8                	mov    %edi,%eax
80106d25:	e8 b6 fb ff ff       	call   801068e0 <deallocuvm.part.0>
      return 0;
80106d2a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80106d31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d37:	5b                   	pop    %ebx
80106d38:	5e                   	pop    %esi
80106d39:	5f                   	pop    %edi
80106d3a:	5d                   	pop    %ebp
80106d3b:	c3                   	ret    
80106d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80106d40:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80106d43:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d49:	5b                   	pop    %ebx
80106d4a:	5e                   	pop    %esi
80106d4b:	5f                   	pop    %edi
80106d4c:	5d                   	pop    %ebp
80106d4d:	c3                   	ret    
80106d4e:	66 90                	xchg   %ax,%ax
    return 0;
80106d50:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80106d57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d5d:	5b                   	pop    %ebx
80106d5e:	5e                   	pop    %esi
80106d5f:	5f                   	pop    %edi
80106d60:	5d                   	pop    %ebp
80106d61:	c3                   	ret    
80106d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106d68:	83 ec 0c             	sub    $0xc,%esp
80106d6b:	68 21 7b 10 80       	push   $0x80107b21
80106d70:	e8 2b 99 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80106d75:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d78:	83 c4 10             	add    $0x10,%esp
80106d7b:	39 45 10             	cmp    %eax,0x10(%ebp)
80106d7e:	74 0c                	je     80106d8c <allocuvm+0x10c>
80106d80:	8b 55 10             	mov    0x10(%ebp),%edx
80106d83:	89 c1                	mov    %eax,%ecx
80106d85:	89 f8                	mov    %edi,%eax
80106d87:	e8 54 fb ff ff       	call   801068e0 <deallocuvm.part.0>
      kfree(mem);
80106d8c:	83 ec 0c             	sub    $0xc,%esp
80106d8f:	53                   	push   %ebx
80106d90:	e8 8b b8 ff ff       	call   80102620 <kfree>
      return 0;
80106d95:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80106d9c:	83 c4 10             	add    $0x10,%esp
}
80106d9f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106da2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106da5:	5b                   	pop    %ebx
80106da6:	5e                   	pop    %esi
80106da7:	5f                   	pop    %edi
80106da8:	5d                   	pop    %ebp
80106da9:	c3                   	ret    
80106daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106db0 <deallocuvm>:
{
80106db0:	55                   	push   %ebp
80106db1:	89 e5                	mov    %esp,%ebp
80106db3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106db6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106db9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106dbc:	39 d1                	cmp    %edx,%ecx
80106dbe:	73 10                	jae    80106dd0 <deallocuvm+0x20>
}
80106dc0:	5d                   	pop    %ebp
80106dc1:	e9 1a fb ff ff       	jmp    801068e0 <deallocuvm.part.0>
80106dc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dcd:	8d 76 00             	lea    0x0(%esi),%esi
80106dd0:	89 d0                	mov    %edx,%eax
80106dd2:	5d                   	pop    %ebp
80106dd3:	c3                   	ret    
80106dd4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ddb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106ddf:	90                   	nop

80106de0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106de0:	55                   	push   %ebp
80106de1:	89 e5                	mov    %esp,%ebp
80106de3:	57                   	push   %edi
80106de4:	56                   	push   %esi
80106de5:	53                   	push   %ebx
80106de6:	83 ec 0c             	sub    $0xc,%esp
80106de9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106dec:	85 f6                	test   %esi,%esi
80106dee:	74 59                	je     80106e49 <freevm+0x69>
  if(newsz >= oldsz)
80106df0:	31 c9                	xor    %ecx,%ecx
80106df2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106df7:	89 f0                	mov    %esi,%eax
80106df9:	89 f3                	mov    %esi,%ebx
80106dfb:	e8 e0 fa ff ff       	call   801068e0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106e00:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106e06:	eb 0f                	jmp    80106e17 <freevm+0x37>
80106e08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e0f:	90                   	nop
80106e10:	83 c3 04             	add    $0x4,%ebx
80106e13:	39 df                	cmp    %ebx,%edi
80106e15:	74 23                	je     80106e3a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106e17:	8b 03                	mov    (%ebx),%eax
80106e19:	a8 01                	test   $0x1,%al
80106e1b:	74 f3                	je     80106e10 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106e1d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106e22:	83 ec 0c             	sub    $0xc,%esp
80106e25:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106e28:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106e2d:	50                   	push   %eax
80106e2e:	e8 ed b7 ff ff       	call   80102620 <kfree>
80106e33:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106e36:	39 df                	cmp    %ebx,%edi
80106e38:	75 dd                	jne    80106e17 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106e3a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106e3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e40:	5b                   	pop    %ebx
80106e41:	5e                   	pop    %esi
80106e42:	5f                   	pop    %edi
80106e43:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106e44:	e9 d7 b7 ff ff       	jmp    80102620 <kfree>
    panic("freevm: no pgdir");
80106e49:	83 ec 0c             	sub    $0xc,%esp
80106e4c:	68 3d 7b 10 80       	push   $0x80107b3d
80106e51:	e8 2a 95 ff ff       	call   80100380 <panic>
80106e56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e5d:	8d 76 00             	lea    0x0(%esi),%esi

80106e60 <setupkvm>:
{
80106e60:	55                   	push   %ebp
80106e61:	89 e5                	mov    %esp,%ebp
80106e63:	56                   	push   %esi
80106e64:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106e65:	e8 76 b9 ff ff       	call   801027e0 <kalloc>
80106e6a:	89 c6                	mov    %eax,%esi
80106e6c:	85 c0                	test   %eax,%eax
80106e6e:	74 42                	je     80106eb2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106e70:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e73:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106e78:	68 00 10 00 00       	push   $0x1000
80106e7d:	6a 00                	push   $0x0
80106e7f:	50                   	push   %eax
80106e80:	e8 9b d8 ff ff       	call   80104720 <memset>
80106e85:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106e88:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106e8b:	83 ec 08             	sub    $0x8,%esp
80106e8e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106e91:	ff 73 0c             	pushl  0xc(%ebx)
80106e94:	8b 13                	mov    (%ebx),%edx
80106e96:	50                   	push   %eax
80106e97:	29 c1                	sub    %eax,%ecx
80106e99:	89 f0                	mov    %esi,%eax
80106e9b:	e8 b0 f9 ff ff       	call   80106850 <mappages>
80106ea0:	83 c4 10             	add    $0x10,%esp
80106ea3:	85 c0                	test   %eax,%eax
80106ea5:	78 19                	js     80106ec0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ea7:	83 c3 10             	add    $0x10,%ebx
80106eaa:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106eb0:	75 d6                	jne    80106e88 <setupkvm+0x28>
}
80106eb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106eb5:	89 f0                	mov    %esi,%eax
80106eb7:	5b                   	pop    %ebx
80106eb8:	5e                   	pop    %esi
80106eb9:	5d                   	pop    %ebp
80106eba:	c3                   	ret    
80106ebb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106ebf:	90                   	nop
      freevm(pgdir);
80106ec0:	83 ec 0c             	sub    $0xc,%esp
80106ec3:	56                   	push   %esi
      return 0;
80106ec4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106ec6:	e8 15 ff ff ff       	call   80106de0 <freevm>
      return 0;
80106ecb:	83 c4 10             	add    $0x10,%esp
}
80106ece:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106ed1:	89 f0                	mov    %esi,%eax
80106ed3:	5b                   	pop    %ebx
80106ed4:	5e                   	pop    %esi
80106ed5:	5d                   	pop    %ebp
80106ed6:	c3                   	ret    
80106ed7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ede:	66 90                	xchg   %ax,%ax

80106ee0 <kvmalloc>:
{
80106ee0:	55                   	push   %ebp
80106ee1:	89 e5                	mov    %esp,%ebp
80106ee3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106ee6:	e8 75 ff ff ff       	call   80106e60 <setupkvm>
80106eeb:	a3 a4 54 11 80       	mov    %eax,0x801154a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ef0:	05 00 00 00 80       	add    $0x80000000,%eax
80106ef5:	0f 22 d8             	mov    %eax,%cr3
}
80106ef8:	c9                   	leave  
80106ef9:	c3                   	ret    
80106efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f00 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106f00:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106f01:	31 c9                	xor    %ecx,%ecx
{
80106f03:	89 e5                	mov    %esp,%ebp
80106f05:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106f08:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f0b:	8b 45 08             	mov    0x8(%ebp),%eax
80106f0e:	e8 bd f8 ff ff       	call   801067d0 <walkpgdir>
  if(pte == 0)
80106f13:	85 c0                	test   %eax,%eax
80106f15:	74 05                	je     80106f1c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106f17:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106f1a:	c9                   	leave  
80106f1b:	c3                   	ret    
    panic("clearpteu");
80106f1c:	83 ec 0c             	sub    $0xc,%esp
80106f1f:	68 4e 7b 10 80       	push   $0x80107b4e
80106f24:	e8 57 94 ff ff       	call   80100380 <panic>
80106f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f30 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106f30:	55                   	push   %ebp
80106f31:	89 e5                	mov    %esp,%ebp
80106f33:	57                   	push   %edi
80106f34:	56                   	push   %esi
80106f35:	53                   	push   %ebx
80106f36:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106f39:	e8 22 ff ff ff       	call   80106e60 <setupkvm>
80106f3e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106f41:	85 c0                	test   %eax,%eax
80106f43:	0f 84 a0 00 00 00    	je     80106fe9 <copyuvm+0xb9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106f49:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106f4c:	85 c9                	test   %ecx,%ecx
80106f4e:	0f 84 95 00 00 00    	je     80106fe9 <copyuvm+0xb9>
80106f54:	31 f6                	xor    %esi,%esi
80106f56:	eb 4e                	jmp    80106fa6 <copyuvm+0x76>
80106f58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f5f:	90                   	nop
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106f60:	83 ec 04             	sub    $0x4,%esp
80106f63:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106f69:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f6c:	68 00 10 00 00       	push   $0x1000
80106f71:	57                   	push   %edi
80106f72:	50                   	push   %eax
80106f73:	e8 48 d8 ff ff       	call   801047c0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106f78:	58                   	pop    %eax
80106f79:	5a                   	pop    %edx
80106f7a:	53                   	push   %ebx
80106f7b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106f7e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f81:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f86:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106f8c:	52                   	push   %edx
80106f8d:	89 f2                	mov    %esi,%edx
80106f8f:	e8 bc f8 ff ff       	call   80106850 <mappages>
80106f94:	83 c4 10             	add    $0x10,%esp
80106f97:	85 c0                	test   %eax,%eax
80106f99:	78 39                	js     80106fd4 <copyuvm+0xa4>
  for(i = 0; i < sz; i += PGSIZE){
80106f9b:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106fa1:	39 75 0c             	cmp    %esi,0xc(%ebp)
80106fa4:	76 43                	jbe    80106fe9 <copyuvm+0xb9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106fa6:	8b 45 08             	mov    0x8(%ebp),%eax
80106fa9:	31 c9                	xor    %ecx,%ecx
80106fab:	89 f2                	mov    %esi,%edx
80106fad:	e8 1e f8 ff ff       	call   801067d0 <walkpgdir>
80106fb2:	85 c0                	test   %eax,%eax
80106fb4:	74 3e                	je     80106ff4 <copyuvm+0xc4>
    if(!(*pte & PTE_P))
80106fb6:	8b 18                	mov    (%eax),%ebx
80106fb8:	f6 c3 01             	test   $0x1,%bl
80106fbb:	74 44                	je     80107001 <copyuvm+0xd1>
    pa = PTE_ADDR(*pte);
80106fbd:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
80106fbf:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80106fc5:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80106fcb:	e8 10 b8 ff ff       	call   801027e0 <kalloc>
80106fd0:	85 c0                	test   %eax,%eax
80106fd2:	75 8c                	jne    80106f60 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80106fd4:	83 ec 0c             	sub    $0xc,%esp
80106fd7:	ff 75 e0             	pushl  -0x20(%ebp)
80106fda:	e8 01 fe ff ff       	call   80106de0 <freevm>
  return 0;
80106fdf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80106fe6:	83 c4 10             	add    $0x10,%esp
}
80106fe9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106fec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fef:	5b                   	pop    %ebx
80106ff0:	5e                   	pop    %esi
80106ff1:	5f                   	pop    %edi
80106ff2:	5d                   	pop    %ebp
80106ff3:	c3                   	ret    
      panic("copyuvm: pte should exist");
80106ff4:	83 ec 0c             	sub    $0xc,%esp
80106ff7:	68 58 7b 10 80       	push   $0x80107b58
80106ffc:	e8 7f 93 ff ff       	call   80100380 <panic>
      panic("copyuvm: page not present");
80107001:	83 ec 0c             	sub    $0xc,%esp
80107004:	68 72 7b 10 80       	push   $0x80107b72
80107009:	e8 72 93 ff ff       	call   80100380 <panic>
8010700e:	66 90                	xchg   %ax,%ax

80107010 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107010:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107011:	31 c9                	xor    %ecx,%ecx
{
80107013:	89 e5                	mov    %esp,%ebp
80107015:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107018:	8b 55 0c             	mov    0xc(%ebp),%edx
8010701b:	8b 45 08             	mov    0x8(%ebp),%eax
8010701e:	e8 ad f7 ff ff       	call   801067d0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107023:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107025:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107026:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107028:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010702d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107030:	05 00 00 00 80       	add    $0x80000000,%eax
80107035:	83 fa 05             	cmp    $0x5,%edx
80107038:	ba 00 00 00 00       	mov    $0x0,%edx
8010703d:	0f 45 c2             	cmovne %edx,%eax
}
80107040:	c3                   	ret    
80107041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107048:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010704f:	90                   	nop

80107050 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107050:	55                   	push   %ebp
80107051:	89 e5                	mov    %esp,%ebp
80107053:	57                   	push   %edi
80107054:	56                   	push   %esi
80107055:	53                   	push   %ebx
80107056:	83 ec 0c             	sub    $0xc,%esp
80107059:	8b 75 14             	mov    0x14(%ebp),%esi
8010705c:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010705f:	85 f6                	test   %esi,%esi
80107061:	75 38                	jne    8010709b <copyout+0x4b>
80107063:	eb 6b                	jmp    801070d0 <copyout+0x80>
80107065:	8d 76 00             	lea    0x0(%esi),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107068:	8b 55 0c             	mov    0xc(%ebp),%edx
8010706b:	89 fb                	mov    %edi,%ebx
8010706d:	29 d3                	sub    %edx,%ebx
8010706f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107075:	39 f3                	cmp    %esi,%ebx
80107077:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
8010707a:	29 fa                	sub    %edi,%edx
8010707c:	83 ec 04             	sub    $0x4,%esp
8010707f:	01 c2                	add    %eax,%edx
80107081:	53                   	push   %ebx
80107082:	ff 75 10             	pushl  0x10(%ebp)
80107085:	52                   	push   %edx
80107086:	e8 35 d7 ff ff       	call   801047c0 <memmove>
    len -= n;
    buf += n;
8010708b:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
8010708e:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
80107094:	83 c4 10             	add    $0x10,%esp
80107097:	29 de                	sub    %ebx,%esi
80107099:	74 35                	je     801070d0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
8010709b:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
8010709d:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801070a0:	89 55 0c             	mov    %edx,0xc(%ebp)
801070a3:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801070a9:	57                   	push   %edi
801070aa:	ff 75 08             	pushl  0x8(%ebp)
801070ad:	e8 5e ff ff ff       	call   80107010 <uva2ka>
    if(pa0 == 0)
801070b2:	83 c4 10             	add    $0x10,%esp
801070b5:	85 c0                	test   %eax,%eax
801070b7:	75 af                	jne    80107068 <copyout+0x18>
  }
  return 0;
}
801070b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801070bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070c1:	5b                   	pop    %ebx
801070c2:	5e                   	pop    %esi
801070c3:	5f                   	pop    %edi
801070c4:	5d                   	pop    %ebp
801070c5:	c3                   	ret    
801070c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070cd:	8d 76 00             	lea    0x0(%esi),%esi
801070d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801070d3:	31 c0                	xor    %eax,%eax
}
801070d5:	5b                   	pop    %ebx
801070d6:	5e                   	pop    %esi
801070d7:	5f                   	pop    %edi
801070d8:	5d                   	pop    %ebp
801070d9:	c3                   	ret    
