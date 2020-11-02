
_readonlycode2:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "fs.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int *p = (int *)0x1000; 			// 0x1000 is just the address of code
  int value = *p;
   f:	8b 1d 00 10 00 00    	mov    0x1000,%ebx
  
  *p = value;

  if (mprotect((void *)p, 1) == -1) {
  15:	83 ec 08             	sub    $0x8,%esp
  18:	6a 01                	push   $0x1
  1a:	68 00 10 00 00       	push   $0x1000
  1f:	e8 7e 04 00 00       	call   4a2 <mprotect>
  24:	83 c4 10             	add    $0x10,%esp
  27:	83 f8 ff             	cmp    $0xffffffff,%eax
  2a:	0f 84 05 01 00 00    	je     135 <main+0x135>
  	printf(1, "mprotect call failed\n");
  } else {
  	printf(1, "mprotect call succeeded\n");
  30:	83 ec 08             	sub    $0x8,%esp
  33:	68 96 08 00 00       	push   $0x896
  38:	6a 01                	push   $0x1
  3a:	e8 21 05 00 00       	call   560 <printf>
  3f:	83 c4 10             	add    $0x10,%esp
  }
  
  if (munprotect((void *)p, 1) == -1) {
  42:	83 ec 08             	sub    $0x8,%esp
  45:	6a 01                	push   $0x1
  47:	68 00 10 00 00       	push   $0x1000
  4c:	e8 59 04 00 00       	call   4aa <munprotect>
  51:	83 c4 10             	add    $0x10,%esp
  54:	83 f8 ff             	cmp    $0xffffffff,%eax
  57:	0f 84 40 01 00 00    	je     19d <main+0x19d>
  	printf(1, "munprotect call failed\n");
  } else {
  	printf(1, "munprotect call succeeded\n");
  5d:	83 ec 08             	sub    $0x8,%esp
  60:	68 c7 08 00 00       	push   $0x8c7
  65:	6a 01                	push   $0x1
  67:	e8 f4 04 00 00       	call   560 <printf>
  6c:	83 c4 10             	add    $0x10,%esp
  }

  *p = value;
  printf(1, "%x\n", *p); 	
  6f:	83 ec 04             	sub    $0x4,%esp
  	printf(1, "munprotect call failed\n");
  } else {
  	printf(1, "munprotect call succeeded\n");
  }

  *p = value;
  72:	89 1d 00 10 00 00    	mov    %ebx,0x1000
  printf(1, "%x\n", *p); 	
  78:	53                   	push   %ebx
  79:	68 e2 08 00 00       	push   $0x8e2
  7e:	6a 01                	push   $0x1
  80:	e8 db 04 00 00       	call   560 <printf>

  p = (int *)0x1001;
  if (mprotect((void *)p, 1) == -1) {
  85:	58                   	pop    %eax
  86:	5a                   	pop    %edx
  87:	6a 01                	push   $0x1
  89:	68 01 10 00 00       	push   $0x1001
  8e:	e8 0f 04 00 00       	call   4a2 <mprotect>
  93:	83 c4 10             	add    $0x10,%esp
  96:	83 f8 ff             	cmp    $0xffffffff,%eax
  99:	0f 84 e8 00 00 00    	je     187 <main+0x187>
    printf(1, "mprotect call failed: page aligned\n");
  } else {
    printf(1, "mprotect call succeeded\n");
  9f:	83 ec 08             	sub    $0x8,%esp
  a2:	68 96 08 00 00       	push   $0x896
  a7:	6a 01                	push   $0x1
  a9:	e8 b2 04 00 00       	call   560 <printf>
  ae:	83 c4 10             	add    $0x10,%esp
  }

  p = (int *)0x1001;
  if (munprotect((void *)p, 1) == -1) {
  b1:	83 ec 08             	sub    $0x8,%esp
  b4:	6a 01                	push   $0x1
  b6:	68 01 10 00 00       	push   $0x1001
  bb:	e8 ea 03 00 00       	call   4aa <munprotect>
  c0:	83 c4 10             	add    $0x10,%esp
  c3:	83 f8 ff             	cmp    $0xffffffff,%eax
  c6:	0f 84 a5 00 00 00    	je     171 <main+0x171>
    printf(1, "munprotect call failed: page aligned\n");
  } else {
    printf(1, "munprotect call succeeded\n");
  cc:	83 ec 08             	sub    $0x8,%esp
  cf:	68 c7 08 00 00       	push   $0x8c7
  d4:	6a 01                	push   $0x1
  d6:	e8 85 04 00 00       	call   560 <printf>
  db:	83 c4 10             	add    $0x10,%esp
  }

  p = (int *)0x1000;
  if (mprotect((void *)p, 4) == -1) {
  de:	83 ec 08             	sub    $0x8,%esp
  e1:	6a 04                	push   $0x4
  e3:	68 00 10 00 00       	push   $0x1000
  e8:	e8 b5 03 00 00       	call   4a2 <mprotect>
  ed:	83 c4 10             	add    $0x10,%esp
  f0:	83 f8 ff             	cmp    $0xffffffff,%eax
  f3:	74 69                	je     15e <main+0x15e>
    printf(1, "mprotect call failed: page length\n");
  } else {
    printf(1, "mprotect call succeeded\n");
  f5:	83 ec 08             	sub    $0x8,%esp
  f8:	68 96 08 00 00       	push   $0x896
  fd:	6a 01                	push   $0x1
  ff:	e8 5c 04 00 00       	call   560 <printf>
 104:	83 c4 10             	add    $0x10,%esp
  }

  p = (int *)0x1000;
  if (munprotect((void *)p, 4) == -1) {
 107:	83 ec 08             	sub    $0x8,%esp
 10a:	6a 04                	push   $0x4
 10c:	68 00 10 00 00       	push   $0x1000
 111:	e8 94 03 00 00       	call   4aa <munprotect>
 116:	83 c4 10             	add    $0x10,%esp
 119:	83 f8 ff             	cmp    $0xffffffff,%eax
 11c:	74 2d                	je     14b <main+0x14b>
    printf(1, "munprotect call failed: page length\n");
  } else {
    printf(1, "munprotect call succeeded\n");
 11e:	83 ec 08             	sub    $0x8,%esp
 121:	68 c7 08 00 00       	push   $0x8c7
 126:	6a 01                	push   $0x1
 128:	e8 33 04 00 00       	call   560 <printf>
 12d:	83 c4 10             	add    $0x10,%esp
  }

  exit();
 130:	e8 cd 02 00 00       	call   402 <exit>
  int value = *p;
  
  *p = value;

  if (mprotect((void *)p, 1) == -1) {
  	printf(1, "mprotect call failed\n");
 135:	50                   	push   %eax
 136:	50                   	push   %eax
 137:	68 80 08 00 00       	push   $0x880
 13c:	6a 01                	push   $0x1
 13e:	e8 1d 04 00 00       	call   560 <printf>
 143:	83 c4 10             	add    $0x10,%esp
 146:	e9 f7 fe ff ff       	jmp    42 <main+0x42>
    printf(1, "mprotect call succeeded\n");
  }

  p = (int *)0x1000;
  if (munprotect((void *)p, 4) == -1) {
    printf(1, "munprotect call failed: page length\n");
 14b:	50                   	push   %eax
 14c:	50                   	push   %eax
 14d:	68 58 09 00 00       	push   $0x958
 152:	6a 01                	push   $0x1
 154:	e8 07 04 00 00       	call   560 <printf>
 159:	83 c4 10             	add    $0x10,%esp
 15c:	eb d2                	jmp    130 <main+0x130>
    printf(1, "munprotect call succeeded\n");
  }

  p = (int *)0x1000;
  if (mprotect((void *)p, 4) == -1) {
    printf(1, "mprotect call failed: page length\n");
 15e:	52                   	push   %edx
 15f:	52                   	push   %edx
 160:	68 34 09 00 00       	push   $0x934
 165:	6a 01                	push   $0x1
 167:	e8 f4 03 00 00       	call   560 <printf>
 16c:	83 c4 10             	add    $0x10,%esp
 16f:	eb 96                	jmp    107 <main+0x107>
    printf(1, "mprotect call succeeded\n");
  }

  p = (int *)0x1001;
  if (munprotect((void *)p, 1) == -1) {
    printf(1, "munprotect call failed: page aligned\n");
 171:	51                   	push   %ecx
 172:	51                   	push   %ecx
 173:	68 0c 09 00 00       	push   $0x90c
 178:	6a 01                	push   $0x1
 17a:	e8 e1 03 00 00       	call   560 <printf>
 17f:	83 c4 10             	add    $0x10,%esp
 182:	e9 57 ff ff ff       	jmp    de <main+0xde>
  *p = value;
  printf(1, "%x\n", *p); 	

  p = (int *)0x1001;
  if (mprotect((void *)p, 1) == -1) {
    printf(1, "mprotect call failed: page aligned\n");
 187:	53                   	push   %ebx
 188:	53                   	push   %ebx
 189:	68 e8 08 00 00       	push   $0x8e8
 18e:	6a 01                	push   $0x1
 190:	e8 cb 03 00 00       	call   560 <printf>
 195:	83 c4 10             	add    $0x10,%esp
 198:	e9 14 ff ff ff       	jmp    b1 <main+0xb1>
  } else {
  	printf(1, "mprotect call succeeded\n");
  }
  
  if (munprotect((void *)p, 1) == -1) {
  	printf(1, "munprotect call failed\n");
 19d:	51                   	push   %ecx
 19e:	51                   	push   %ecx
 19f:	68 af 08 00 00       	push   $0x8af
 1a4:	6a 01                	push   $0x1
 1a6:	e8 b5 03 00 00       	call   560 <printf>
 1ab:	83 c4 10             	add    $0x10,%esp
 1ae:	e9 bc fe ff ff       	jmp    6f <main+0x6f>
 1b3:	66 90                	xchg   %ax,%ax
 1b5:	66 90                	xchg   %ax,%ax
 1b7:	66 90                	xchg   %ax,%ax
 1b9:	66 90                	xchg   %ax,%ax
 1bb:	66 90                	xchg   %ax,%ax
 1bd:	66 90                	xchg   %ax,%ax
 1bf:	90                   	nop

000001c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 45 08             	mov    0x8(%ebp),%eax
 1c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ca:	89 c2                	mov    %eax,%edx
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d0:	83 c1 01             	add    $0x1,%ecx
 1d3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1d7:	83 c2 01             	add    $0x1,%edx
 1da:	84 db                	test   %bl,%bl
 1dc:	88 5a ff             	mov    %bl,-0x1(%edx)
 1df:	75 ef                	jne    1d0 <strcpy+0x10>
    ;
  return os;
}
 1e1:	5b                   	pop    %ebx
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
 1f5:	8b 55 08             	mov    0x8(%ebp),%edx
 1f8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1fb:	0f b6 02             	movzbl (%edx),%eax
 1fe:	0f b6 19             	movzbl (%ecx),%ebx
 201:	84 c0                	test   %al,%al
 203:	75 1e                	jne    223 <strcmp+0x33>
 205:	eb 29                	jmp    230 <strcmp+0x40>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 210:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 213:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 216:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 219:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 21d:	84 c0                	test   %al,%al
 21f:	74 0f                	je     230 <strcmp+0x40>
    p++, q++;
 221:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 223:	38 d8                	cmp    %bl,%al
 225:	74 e9                	je     210 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 227:	29 d8                	sub    %ebx,%eax
}
 229:	5b                   	pop    %ebx
 22a:	5e                   	pop    %esi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
 22d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 230:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 232:	29 d8                	sub    %ebx,%eax
}
 234:	5b                   	pop    %ebx
 235:	5e                   	pop    %esi
 236:	5d                   	pop    %ebp
 237:	c3                   	ret    
 238:	90                   	nop
 239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000240 <strlen>:

uint
strlen(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 246:	80 39 00             	cmpb   $0x0,(%ecx)
 249:	74 12                	je     25d <strlen+0x1d>
 24b:	31 d2                	xor    %edx,%edx
 24d:	8d 76 00             	lea    0x0(%esi),%esi
 250:	83 c2 01             	add    $0x1,%edx
 253:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 257:	89 d0                	mov    %edx,%eax
 259:	75 f5                	jne    250 <strlen+0x10>
    ;
  return n;
}
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 25d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret    
 261:	eb 0d                	jmp    270 <memset>
 263:	90                   	nop
 264:	90                   	nop
 265:	90                   	nop
 266:	90                   	nop
 267:	90                   	nop
 268:	90                   	nop
 269:	90                   	nop
 26a:	90                   	nop
 26b:	90                   	nop
 26c:	90                   	nop
 26d:	90                   	nop
 26e:	90                   	nop
 26f:	90                   	nop

00000270 <memset>:

void*
memset(void *dst, int c, uint n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 277:	8b 4d 10             	mov    0x10(%ebp),%ecx
 27a:	8b 45 0c             	mov    0xc(%ebp),%eax
 27d:	89 d7                	mov    %edx,%edi
 27f:	fc                   	cld    
 280:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 282:	89 d0                	mov    %edx,%eax
 284:	5f                   	pop    %edi
 285:	5d                   	pop    %ebp
 286:	c3                   	ret    
 287:	89 f6                	mov    %esi,%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <strchr>:

char*
strchr(const char *s, char c)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	53                   	push   %ebx
 294:	8b 45 08             	mov    0x8(%ebp),%eax
 297:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 29a:	0f b6 10             	movzbl (%eax),%edx
 29d:	84 d2                	test   %dl,%dl
 29f:	74 1d                	je     2be <strchr+0x2e>
    if(*s == c)
 2a1:	38 d3                	cmp    %dl,%bl
 2a3:	89 d9                	mov    %ebx,%ecx
 2a5:	75 0d                	jne    2b4 <strchr+0x24>
 2a7:	eb 17                	jmp    2c0 <strchr+0x30>
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2b0:	38 ca                	cmp    %cl,%dl
 2b2:	74 0c                	je     2c0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2b4:	83 c0 01             	add    $0x1,%eax
 2b7:	0f b6 10             	movzbl (%eax),%edx
 2ba:	84 d2                	test   %dl,%dl
 2bc:	75 f2                	jne    2b0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 2be:	31 c0                	xor    %eax,%eax
}
 2c0:	5b                   	pop    %ebx
 2c1:	5d                   	pop    %ebp
 2c2:	c3                   	ret    
 2c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <gets>:

char*
gets(char *buf, int max)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	57                   	push   %edi
 2d4:	56                   	push   %esi
 2d5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 2d8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 2db:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2de:	eb 29                	jmp    309 <gets+0x39>
    cc = read(0, &c, 1);
 2e0:	83 ec 04             	sub    $0x4,%esp
 2e3:	6a 01                	push   $0x1
 2e5:	57                   	push   %edi
 2e6:	6a 00                	push   $0x0
 2e8:	e8 2d 01 00 00       	call   41a <read>
    if(cc < 1)
 2ed:	83 c4 10             	add    $0x10,%esp
 2f0:	85 c0                	test   %eax,%eax
 2f2:	7e 1d                	jle    311 <gets+0x41>
      break;
    buf[i++] = c;
 2f4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2f8:	8b 55 08             	mov    0x8(%ebp),%edx
 2fb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 2fd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2ff:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 303:	74 1b                	je     320 <gets+0x50>
 305:	3c 0d                	cmp    $0xd,%al
 307:	74 17                	je     320 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 309:	8d 5e 01             	lea    0x1(%esi),%ebx
 30c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 30f:	7c cf                	jl     2e0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 311:	8b 45 08             	mov    0x8(%ebp),%eax
 314:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 318:	8d 65 f4             	lea    -0xc(%ebp),%esp
 31b:	5b                   	pop    %ebx
 31c:	5e                   	pop    %esi
 31d:	5f                   	pop    %edi
 31e:	5d                   	pop    %ebp
 31f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 320:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 323:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 325:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 329:	8d 65 f4             	lea    -0xc(%ebp),%esp
 32c:	5b                   	pop    %ebx
 32d:	5e                   	pop    %esi
 32e:	5f                   	pop    %edi
 32f:	5d                   	pop    %ebp
 330:	c3                   	ret    
 331:	eb 0d                	jmp    340 <stat>
 333:	90                   	nop
 334:	90                   	nop
 335:	90                   	nop
 336:	90                   	nop
 337:	90                   	nop
 338:	90                   	nop
 339:	90                   	nop
 33a:	90                   	nop
 33b:	90                   	nop
 33c:	90                   	nop
 33d:	90                   	nop
 33e:	90                   	nop
 33f:	90                   	nop

00000340 <stat>:

int
stat(const char *n, struct stat *st)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	56                   	push   %esi
 344:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 345:	83 ec 08             	sub    $0x8,%esp
 348:	6a 00                	push   $0x0
 34a:	ff 75 08             	pushl  0x8(%ebp)
 34d:	e8 f0 00 00 00       	call   442 <open>
  if(fd < 0)
 352:	83 c4 10             	add    $0x10,%esp
 355:	85 c0                	test   %eax,%eax
 357:	78 27                	js     380 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 359:	83 ec 08             	sub    $0x8,%esp
 35c:	ff 75 0c             	pushl  0xc(%ebp)
 35f:	89 c3                	mov    %eax,%ebx
 361:	50                   	push   %eax
 362:	e8 f3 00 00 00       	call   45a <fstat>
 367:	89 c6                	mov    %eax,%esi
  close(fd);
 369:	89 1c 24             	mov    %ebx,(%esp)
 36c:	e8 b9 00 00 00       	call   42a <close>
  return r;
 371:	83 c4 10             	add    $0x10,%esp
 374:	89 f0                	mov    %esi,%eax
}
 376:	8d 65 f8             	lea    -0x8(%ebp),%esp
 379:	5b                   	pop    %ebx
 37a:	5e                   	pop    %esi
 37b:	5d                   	pop    %ebp
 37c:	c3                   	ret    
 37d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 380:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 385:	eb ef                	jmp    376 <stat+0x36>
 387:	89 f6                	mov    %esi,%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000390 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	53                   	push   %ebx
 394:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 397:	0f be 11             	movsbl (%ecx),%edx
 39a:	8d 42 d0             	lea    -0x30(%edx),%eax
 39d:	3c 09                	cmp    $0x9,%al
 39f:	b8 00 00 00 00       	mov    $0x0,%eax
 3a4:	77 1f                	ja     3c5 <atoi+0x35>
 3a6:	8d 76 00             	lea    0x0(%esi),%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 3b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3b3:	83 c1 01             	add    $0x1,%ecx
 3b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3ba:	0f be 11             	movsbl (%ecx),%edx
 3bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3c0:	80 fb 09             	cmp    $0x9,%bl
 3c3:	76 eb                	jbe    3b0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 3c5:	5b                   	pop    %ebx
 3c6:	5d                   	pop    %ebp
 3c7:	c3                   	ret    
 3c8:	90                   	nop
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	56                   	push   %esi
 3d4:	53                   	push   %ebx
 3d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3d8:	8b 45 08             	mov    0x8(%ebp),%eax
 3db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3de:	85 db                	test   %ebx,%ebx
 3e0:	7e 14                	jle    3f6 <memmove+0x26>
 3e2:	31 d2                	xor    %edx,%edx
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3ef:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3f2:	39 da                	cmp    %ebx,%edx
 3f4:	75 f2                	jne    3e8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 3f6:	5b                   	pop    %ebx
 3f7:	5e                   	pop    %esi
 3f8:	5d                   	pop    %ebp
 3f9:	c3                   	ret    

000003fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3fa:	b8 01 00 00 00       	mov    $0x1,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <exit>:
SYSCALL(exit)
 402:	b8 02 00 00 00       	mov    $0x2,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <wait>:
SYSCALL(wait)
 40a:	b8 03 00 00 00       	mov    $0x3,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <pipe>:
SYSCALL(pipe)
 412:	b8 04 00 00 00       	mov    $0x4,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <read>:
SYSCALL(read)
 41a:	b8 05 00 00 00       	mov    $0x5,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <write>:
SYSCALL(write)
 422:	b8 10 00 00 00       	mov    $0x10,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <close>:
SYSCALL(close)
 42a:	b8 15 00 00 00       	mov    $0x15,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <kill>:
SYSCALL(kill)
 432:	b8 06 00 00 00       	mov    $0x6,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <exec>:
SYSCALL(exec)
 43a:	b8 07 00 00 00       	mov    $0x7,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <open>:
SYSCALL(open)
 442:	b8 0f 00 00 00       	mov    $0xf,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <mknod>:
SYSCALL(mknod)
 44a:	b8 11 00 00 00       	mov    $0x11,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <unlink>:
SYSCALL(unlink)
 452:	b8 12 00 00 00       	mov    $0x12,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <fstat>:
SYSCALL(fstat)
 45a:	b8 08 00 00 00       	mov    $0x8,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <link>:
SYSCALL(link)
 462:	b8 13 00 00 00       	mov    $0x13,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <mkdir>:
SYSCALL(mkdir)
 46a:	b8 14 00 00 00       	mov    $0x14,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <chdir>:
SYSCALL(chdir)
 472:	b8 09 00 00 00       	mov    $0x9,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <dup>:
SYSCALL(dup)
 47a:	b8 0a 00 00 00       	mov    $0xa,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <getpid>:
SYSCALL(getpid)
 482:	b8 0b 00 00 00       	mov    $0xb,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <sbrk>:
SYSCALL(sbrk)
 48a:	b8 0c 00 00 00       	mov    $0xc,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <sleep>:
SYSCALL(sleep)
 492:	b8 0d 00 00 00       	mov    $0xd,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <uptime>:
SYSCALL(uptime)
 49a:	b8 0e 00 00 00       	mov    $0xe,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <mprotect>:
SYSCALL(mprotect)
 4a2:	b8 16 00 00 00       	mov    $0x16,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <munprotect>:
SYSCALL(munprotect)
 4aa:	b8 17 00 00 00       	mov    $0x17,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    
 4b2:	66 90                	xchg   %ax,%ax
 4b4:	66 90                	xchg   %ax,%ax
 4b6:	66 90                	xchg   %ax,%ax
 4b8:	66 90                	xchg   %ax,%ax
 4ba:	66 90                	xchg   %ax,%ax
 4bc:	66 90                	xchg   %ax,%ax
 4be:	66 90                	xchg   %ax,%ax

000004c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	89 c6                	mov    %eax,%esi
 4c8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4ce:	85 db                	test   %ebx,%ebx
 4d0:	74 7e                	je     550 <printint+0x90>
 4d2:	89 d0                	mov    %edx,%eax
 4d4:	c1 e8 1f             	shr    $0x1f,%eax
 4d7:	84 c0                	test   %al,%al
 4d9:	74 75                	je     550 <printint+0x90>
    neg = 1;
    x = -xx;
 4db:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 4dd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 4e4:	f7 d8                	neg    %eax
 4e6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 4e9:	31 ff                	xor    %edi,%edi
 4eb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4ee:	89 ce                	mov    %ecx,%esi
 4f0:	eb 08                	jmp    4fa <printint+0x3a>
 4f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4f8:	89 cf                	mov    %ecx,%edi
 4fa:	31 d2                	xor    %edx,%edx
 4fc:	8d 4f 01             	lea    0x1(%edi),%ecx
 4ff:	f7 f6                	div    %esi
 501:	0f b6 92 88 09 00 00 	movzbl 0x988(%edx),%edx
  }while((x /= base) != 0);
 508:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 50a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 50d:	75 e9                	jne    4f8 <printint+0x38>
  if(neg)
 50f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 512:	8b 75 c0             	mov    -0x40(%ebp),%esi
 515:	85 c0                	test   %eax,%eax
 517:	74 08                	je     521 <printint+0x61>
    buf[i++] = '-';
 519:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 51e:	8d 4f 02             	lea    0x2(%edi),%ecx
 521:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 525:	8d 76 00             	lea    0x0(%esi),%esi
 528:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 52b:	83 ec 04             	sub    $0x4,%esp
 52e:	83 ef 01             	sub    $0x1,%edi
 531:	6a 01                	push   $0x1
 533:	53                   	push   %ebx
 534:	56                   	push   %esi
 535:	88 45 d7             	mov    %al,-0x29(%ebp)
 538:	e8 e5 fe ff ff       	call   422 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 53d:	83 c4 10             	add    $0x10,%esp
 540:	39 df                	cmp    %ebx,%edi
 542:	75 e4                	jne    528 <printint+0x68>
    putc(fd, buf[i]);
}
 544:	8d 65 f4             	lea    -0xc(%ebp),%esp
 547:	5b                   	pop    %ebx
 548:	5e                   	pop    %esi
 549:	5f                   	pop    %edi
 54a:	5d                   	pop    %ebp
 54b:	c3                   	ret    
 54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 550:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 552:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 559:	eb 8b                	jmp    4e6 <printint+0x26>
 55b:	90                   	nop
 55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000560 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 566:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 569:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 56c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 56f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 572:	89 45 d0             	mov    %eax,-0x30(%ebp)
 575:	0f b6 1e             	movzbl (%esi),%ebx
 578:	83 c6 01             	add    $0x1,%esi
 57b:	84 db                	test   %bl,%bl
 57d:	0f 84 b0 00 00 00    	je     633 <printf+0xd3>
 583:	31 d2                	xor    %edx,%edx
 585:	eb 39                	jmp    5c0 <printf+0x60>
 587:	89 f6                	mov    %esi,%esi
 589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 590:	83 f8 25             	cmp    $0x25,%eax
 593:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 596:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 59b:	74 18                	je     5b5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 59d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5a0:	83 ec 04             	sub    $0x4,%esp
 5a3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 5a6:	6a 01                	push   $0x1
 5a8:	50                   	push   %eax
 5a9:	57                   	push   %edi
 5aa:	e8 73 fe ff ff       	call   422 <write>
 5af:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5b2:	83 c4 10             	add    $0x10,%esp
 5b5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5bc:	84 db                	test   %bl,%bl
 5be:	74 73                	je     633 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 5c0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 5c2:	0f be cb             	movsbl %bl,%ecx
 5c5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5c8:	74 c6                	je     590 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ca:	83 fa 25             	cmp    $0x25,%edx
 5cd:	75 e6                	jne    5b5 <printf+0x55>
      if(c == 'd'){
 5cf:	83 f8 64             	cmp    $0x64,%eax
 5d2:	0f 84 f8 00 00 00    	je     6d0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5d8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5de:	83 f9 70             	cmp    $0x70,%ecx
 5e1:	74 5d                	je     640 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5e3:	83 f8 73             	cmp    $0x73,%eax
 5e6:	0f 84 84 00 00 00    	je     670 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ec:	83 f8 63             	cmp    $0x63,%eax
 5ef:	0f 84 ea 00 00 00    	je     6df <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5f5:	83 f8 25             	cmp    $0x25,%eax
 5f8:	0f 84 c2 00 00 00    	je     6c0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5fe:	8d 45 e7             	lea    -0x19(%ebp),%eax
 601:	83 ec 04             	sub    $0x4,%esp
 604:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 608:	6a 01                	push   $0x1
 60a:	50                   	push   %eax
 60b:	57                   	push   %edi
 60c:	e8 11 fe ff ff       	call   422 <write>
 611:	83 c4 0c             	add    $0xc,%esp
 614:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 617:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 61a:	6a 01                	push   $0x1
 61c:	50                   	push   %eax
 61d:	57                   	push   %edi
 61e:	83 c6 01             	add    $0x1,%esi
 621:	e8 fc fd ff ff       	call   422 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 626:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 62a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 62d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 62f:	84 db                	test   %bl,%bl
 631:	75 8d                	jne    5c0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 633:	8d 65 f4             	lea    -0xc(%ebp),%esp
 636:	5b                   	pop    %ebx
 637:	5e                   	pop    %esi
 638:	5f                   	pop    %edi
 639:	5d                   	pop    %ebp
 63a:	c3                   	ret    
 63b:	90                   	nop
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 640:	83 ec 0c             	sub    $0xc,%esp
 643:	b9 10 00 00 00       	mov    $0x10,%ecx
 648:	6a 00                	push   $0x0
 64a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 64d:	89 f8                	mov    %edi,%eax
 64f:	8b 13                	mov    (%ebx),%edx
 651:	e8 6a fe ff ff       	call   4c0 <printint>
        ap++;
 656:	89 d8                	mov    %ebx,%eax
 658:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 65b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 65d:	83 c0 04             	add    $0x4,%eax
 660:	89 45 d0             	mov    %eax,-0x30(%ebp)
 663:	e9 4d ff ff ff       	jmp    5b5 <printf+0x55>
 668:	90                   	nop
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 670:	8b 45 d0             	mov    -0x30(%ebp),%eax
 673:	8b 18                	mov    (%eax),%ebx
        ap++;
 675:	83 c0 04             	add    $0x4,%eax
 678:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 67b:	b8 80 09 00 00       	mov    $0x980,%eax
 680:	85 db                	test   %ebx,%ebx
 682:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 685:	0f b6 03             	movzbl (%ebx),%eax
 688:	84 c0                	test   %al,%al
 68a:	74 23                	je     6af <printf+0x14f>
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 690:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 693:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 696:	83 ec 04             	sub    $0x4,%esp
 699:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 69b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 69e:	50                   	push   %eax
 69f:	57                   	push   %edi
 6a0:	e8 7d fd ff ff       	call   422 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6a5:	0f b6 03             	movzbl (%ebx),%eax
 6a8:	83 c4 10             	add    $0x10,%esp
 6ab:	84 c0                	test   %al,%al
 6ad:	75 e1                	jne    690 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6af:	31 d2                	xor    %edx,%edx
 6b1:	e9 ff fe ff ff       	jmp    5b5 <printf+0x55>
 6b6:	8d 76 00             	lea    0x0(%esi),%esi
 6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6c0:	83 ec 04             	sub    $0x4,%esp
 6c3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 6c6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6c9:	6a 01                	push   $0x1
 6cb:	e9 4c ff ff ff       	jmp    61c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6d0:	83 ec 0c             	sub    $0xc,%esp
 6d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6d8:	6a 01                	push   $0x1
 6da:	e9 6b ff ff ff       	jmp    64a <printf+0xea>
 6df:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6e2:	83 ec 04             	sub    $0x4,%esp
 6e5:	8b 03                	mov    (%ebx),%eax
 6e7:	6a 01                	push   $0x1
 6e9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 6ec:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6ef:	50                   	push   %eax
 6f0:	57                   	push   %edi
 6f1:	e8 2c fd ff ff       	call   422 <write>
 6f6:	e9 5b ff ff ff       	jmp    656 <printf+0xf6>
 6fb:	66 90                	xchg   %ax,%ax
 6fd:	66 90                	xchg   %ax,%ax
 6ff:	90                   	nop

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	a1 24 0c 00 00       	mov    0xc24,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 706:	89 e5                	mov    %esp,%ebp
 708:	57                   	push   %edi
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 710:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 713:	39 c8                	cmp    %ecx,%eax
 715:	73 19                	jae    730 <free+0x30>
 717:	89 f6                	mov    %esi,%esi
 719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 720:	39 d1                	cmp    %edx,%ecx
 722:	72 1c                	jb     740 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 724:	39 d0                	cmp    %edx,%eax
 726:	73 18                	jae    740 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 728:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 72a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 72e:	72 f0                	jb     720 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 730:	39 d0                	cmp    %edx,%eax
 732:	72 f4                	jb     728 <free+0x28>
 734:	39 d1                	cmp    %edx,%ecx
 736:	73 f0                	jae    728 <free+0x28>
 738:	90                   	nop
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 740:	8b 73 fc             	mov    -0x4(%ebx),%esi
 743:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 746:	39 d7                	cmp    %edx,%edi
 748:	74 19                	je     763 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 74a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 74d:	8b 50 04             	mov    0x4(%eax),%edx
 750:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 753:	39 f1                	cmp    %esi,%ecx
 755:	74 23                	je     77a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 757:	89 08                	mov    %ecx,(%eax)
  freep = p;
 759:	a3 24 0c 00 00       	mov    %eax,0xc24
}
 75e:	5b                   	pop    %ebx
 75f:	5e                   	pop    %esi
 760:	5f                   	pop    %edi
 761:	5d                   	pop    %ebp
 762:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 763:	03 72 04             	add    0x4(%edx),%esi
 766:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 769:	8b 10                	mov    (%eax),%edx
 76b:	8b 12                	mov    (%edx),%edx
 76d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 770:	8b 50 04             	mov    0x4(%eax),%edx
 773:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 776:	39 f1                	cmp    %esi,%ecx
 778:	75 dd                	jne    757 <free+0x57>
    p->s.size += bp->s.size;
 77a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 77d:	a3 24 0c 00 00       	mov    %eax,0xc24
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 782:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 785:	8b 53 f8             	mov    -0x8(%ebx),%edx
 788:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 78a:	5b                   	pop    %ebx
 78b:	5e                   	pop    %esi
 78c:	5f                   	pop    %edi
 78d:	5d                   	pop    %ebp
 78e:	c3                   	ret    
 78f:	90                   	nop

00000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 799:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 79c:	8b 15 24 0c 00 00    	mov    0xc24,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a2:	8d 78 07             	lea    0x7(%eax),%edi
 7a5:	c1 ef 03             	shr    $0x3,%edi
 7a8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7ab:	85 d2                	test   %edx,%edx
 7ad:	0f 84 a3 00 00 00    	je     856 <malloc+0xc6>
 7b3:	8b 02                	mov    (%edx),%eax
 7b5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7b8:	39 cf                	cmp    %ecx,%edi
 7ba:	76 74                	jbe    830 <malloc+0xa0>
 7bc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7c2:	be 00 10 00 00       	mov    $0x1000,%esi
 7c7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 7ce:	0f 43 f7             	cmovae %edi,%esi
 7d1:	ba 00 80 00 00       	mov    $0x8000,%edx
 7d6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 7dc:	0f 46 da             	cmovbe %edx,%ebx
 7df:	eb 10                	jmp    7f1 <malloc+0x61>
 7e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7ea:	8b 48 04             	mov    0x4(%eax),%ecx
 7ed:	39 cf                	cmp    %ecx,%edi
 7ef:	76 3f                	jbe    830 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7f1:	39 05 24 0c 00 00    	cmp    %eax,0xc24
 7f7:	89 c2                	mov    %eax,%edx
 7f9:	75 ed                	jne    7e8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7fb:	83 ec 0c             	sub    $0xc,%esp
 7fe:	53                   	push   %ebx
 7ff:	e8 86 fc ff ff       	call   48a <sbrk>
  if(p == (char*)-1)
 804:	83 c4 10             	add    $0x10,%esp
 807:	83 f8 ff             	cmp    $0xffffffff,%eax
 80a:	74 1c                	je     828 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 80c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 80f:	83 ec 0c             	sub    $0xc,%esp
 812:	83 c0 08             	add    $0x8,%eax
 815:	50                   	push   %eax
 816:	e8 e5 fe ff ff       	call   700 <free>
  return freep;
 81b:	8b 15 24 0c 00 00    	mov    0xc24,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 821:	83 c4 10             	add    $0x10,%esp
 824:	85 d2                	test   %edx,%edx
 826:	75 c0                	jne    7e8 <malloc+0x58>
        return 0;
 828:	31 c0                	xor    %eax,%eax
 82a:	eb 1c                	jmp    848 <malloc+0xb8>
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 830:	39 cf                	cmp    %ecx,%edi
 832:	74 1c                	je     850 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 834:	29 f9                	sub    %edi,%ecx
 836:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 839:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 83c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 83f:	89 15 24 0c 00 00    	mov    %edx,0xc24
      return (void*)(p + 1);
 845:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 848:	8d 65 f4             	lea    -0xc(%ebp),%esp
 84b:	5b                   	pop    %ebx
 84c:	5e                   	pop    %esi
 84d:	5f                   	pop    %edi
 84e:	5d                   	pop    %ebp
 84f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 850:	8b 08                	mov    (%eax),%ecx
 852:	89 0a                	mov    %ecx,(%edx)
 854:	eb e9                	jmp    83f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 856:	c7 05 24 0c 00 00 28 	movl   $0xc28,0xc24
 85d:	0c 00 00 
 860:	c7 05 28 0c 00 00 28 	movl   $0xc28,0xc28
 867:	0c 00 00 
    base.s.size = 0;
 86a:	b8 28 0c 00 00       	mov    $0xc28,%eax
 86f:	c7 05 2c 0c 00 00 00 	movl   $0x0,0xc2c
 876:	00 00 00 
 879:	e9 3e ff ff ff       	jmp    7bc <malloc+0x2c>
