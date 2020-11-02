
_readonlycode1:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "user.h"
#include "fs.h"

int
main(int argc, char *argv[])
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	53                   	push   %ebx
    100e:	51                   	push   %ecx
  int *p = (int *)0x1000; 			// 0x1000 is just the address of code
  int value = *p;
    100f:	8b 1d 00 10 00 00    	mov    0x1000,%ebx
  
  *p = value;

  if (mprotect((void *)p, 1) == -1) {
    1015:	83 ec 08             	sub    $0x8,%esp
    1018:	6a 01                	push   $0x1
    101a:	68 00 10 00 00       	push   $0x1000
    101f:	e8 6e 03 00 00       	call   1392 <mprotect>
    1024:	83 c4 10             	add    $0x10,%esp
    1027:	83 f8 ff             	cmp    $0xffffffff,%eax
    102a:	74 5b                	je     1087 <main+0x87>
  	printf(1, "mprotect call failed\n");
  } else {
  	printf(1, "mprotect call succeeded\n");
    102c:	83 ec 08             	sub    $0x8,%esp
    102f:	68 86 17 00 00       	push   $0x1786
    1034:	6a 01                	push   $0x1
    1036:	e8 15 04 00 00       	call   1450 <printf>
    103b:	83 c4 10             	add    $0x10,%esp
  }

  *p = value;

  if (munprotect((void *)p, 1) == -1) {
    103e:	83 ec 08             	sub    $0x8,%esp
  	printf(1, "mprotect call failed\n");
  } else {
  	printf(1, "mprotect call succeeded\n");
  }

  *p = value;
    1041:	89 1d 00 10 00 00    	mov    %ebx,0x1000

  if (munprotect((void *)p, 1) == -1) {
    1047:	6a 01                	push   $0x1
    1049:	68 00 10 00 00       	push   $0x1000
    104e:	e8 47 03 00 00       	call   139a <munprotect>
    1053:	83 c4 10             	add    $0x10,%esp
    1056:	83 f8 ff             	cmp    $0xffffffff,%eax
    1059:	74 3f                	je     109a <main+0x9a>
  	printf(1, "munprotect call failed\n");
  } else {
  	printf(1, "munprotect call succeeded\n");
    105b:	83 ec 08             	sub    $0x8,%esp
    105e:	68 b7 17 00 00       	push   $0x17b7
    1063:	6a 01                	push   $0x1
    1065:	e8 e6 03 00 00       	call   1450 <printf>
    106a:	83 c4 10             	add    $0x10,%esp
  }

  printf(1, "%x\n", *p); 	
    106d:	83 ec 04             	sub    $0x4,%esp
    1070:	ff 35 00 10 00 00    	pushl  0x1000
    1076:	68 d2 17 00 00       	push   $0x17d2
    107b:	6a 01                	push   $0x1
    107d:	e8 ce 03 00 00       	call   1450 <printf>

  exit();
    1082:	e8 6b 02 00 00       	call   12f2 <exit>
  int value = *p;
  
  *p = value;

  if (mprotect((void *)p, 1) == -1) {
  	printf(1, "mprotect call failed\n");
    1087:	52                   	push   %edx
    1088:	52                   	push   %edx
    1089:	68 70 17 00 00       	push   $0x1770
    108e:	6a 01                	push   $0x1
    1090:	e8 bb 03 00 00       	call   1450 <printf>
    1095:	83 c4 10             	add    $0x10,%esp
    1098:	eb a4                	jmp    103e <main+0x3e>
  }

  *p = value;

  if (munprotect((void *)p, 1) == -1) {
  	printf(1, "munprotect call failed\n");
    109a:	50                   	push   %eax
    109b:	50                   	push   %eax
    109c:	68 9f 17 00 00       	push   $0x179f
    10a1:	6a 01                	push   $0x1
    10a3:	e8 a8 03 00 00       	call   1450 <printf>
    10a8:	83 c4 10             	add    $0x10,%esp
    10ab:	eb c0                	jmp    106d <main+0x6d>
    10ad:	66 90                	xchg   %ax,%ax
    10af:	90                   	nop

000010b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	53                   	push   %ebx
    10b4:	8b 45 08             	mov    0x8(%ebp),%eax
    10b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    10ba:	89 c2                	mov    %eax,%edx
    10bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10c0:	83 c1 01             	add    $0x1,%ecx
    10c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    10c7:	83 c2 01             	add    $0x1,%edx
    10ca:	84 db                	test   %bl,%bl
    10cc:	88 5a ff             	mov    %bl,-0x1(%edx)
    10cf:	75 ef                	jne    10c0 <strcpy+0x10>
    ;
  return os;
}
    10d1:	5b                   	pop    %ebx
    10d2:	5d                   	pop    %ebp
    10d3:	c3                   	ret    
    10d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000010e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	56                   	push   %esi
    10e4:	53                   	push   %ebx
    10e5:	8b 55 08             	mov    0x8(%ebp),%edx
    10e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    10eb:	0f b6 02             	movzbl (%edx),%eax
    10ee:	0f b6 19             	movzbl (%ecx),%ebx
    10f1:	84 c0                	test   %al,%al
    10f3:	75 1e                	jne    1113 <strcmp+0x33>
    10f5:	eb 29                	jmp    1120 <strcmp+0x40>
    10f7:	89 f6                	mov    %esi,%esi
    10f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1100:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1103:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1106:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1109:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    110d:	84 c0                	test   %al,%al
    110f:	74 0f                	je     1120 <strcmp+0x40>
    p++, q++;
    1111:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1113:	38 d8                	cmp    %bl,%al
    1115:	74 e9                	je     1100 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1117:	29 d8                	sub    %ebx,%eax
}
    1119:	5b                   	pop    %ebx
    111a:	5e                   	pop    %esi
    111b:	5d                   	pop    %ebp
    111c:	c3                   	ret    
    111d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1120:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1122:	29 d8                	sub    %ebx,%eax
}
    1124:	5b                   	pop    %ebx
    1125:	5e                   	pop    %esi
    1126:	5d                   	pop    %ebp
    1127:	c3                   	ret    
    1128:	90                   	nop
    1129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001130 <strlen>:

uint
strlen(const char *s)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1136:	80 39 00             	cmpb   $0x0,(%ecx)
    1139:	74 12                	je     114d <strlen+0x1d>
    113b:	31 d2                	xor    %edx,%edx
    113d:	8d 76 00             	lea    0x0(%esi),%esi
    1140:	83 c2 01             	add    $0x1,%edx
    1143:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1147:	89 d0                	mov    %edx,%eax
    1149:	75 f5                	jne    1140 <strlen+0x10>
    ;
  return n;
}
    114b:	5d                   	pop    %ebp
    114c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    114d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    114f:	5d                   	pop    %ebp
    1150:	c3                   	ret    
    1151:	eb 0d                	jmp    1160 <memset>
    1153:	90                   	nop
    1154:	90                   	nop
    1155:	90                   	nop
    1156:	90                   	nop
    1157:	90                   	nop
    1158:	90                   	nop
    1159:	90                   	nop
    115a:	90                   	nop
    115b:	90                   	nop
    115c:	90                   	nop
    115d:	90                   	nop
    115e:	90                   	nop
    115f:	90                   	nop

00001160 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1160:	55                   	push   %ebp
    1161:	89 e5                	mov    %esp,%ebp
    1163:	57                   	push   %edi
    1164:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1167:	8b 4d 10             	mov    0x10(%ebp),%ecx
    116a:	8b 45 0c             	mov    0xc(%ebp),%eax
    116d:	89 d7                	mov    %edx,%edi
    116f:	fc                   	cld    
    1170:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1172:	89 d0                	mov    %edx,%eax
    1174:	5f                   	pop    %edi
    1175:	5d                   	pop    %ebp
    1176:	c3                   	ret    
    1177:	89 f6                	mov    %esi,%esi
    1179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001180 <strchr>:

char*
strchr(const char *s, char c)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	53                   	push   %ebx
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    118a:	0f b6 10             	movzbl (%eax),%edx
    118d:	84 d2                	test   %dl,%dl
    118f:	74 1d                	je     11ae <strchr+0x2e>
    if(*s == c)
    1191:	38 d3                	cmp    %dl,%bl
    1193:	89 d9                	mov    %ebx,%ecx
    1195:	75 0d                	jne    11a4 <strchr+0x24>
    1197:	eb 17                	jmp    11b0 <strchr+0x30>
    1199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11a0:	38 ca                	cmp    %cl,%dl
    11a2:	74 0c                	je     11b0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    11a4:	83 c0 01             	add    $0x1,%eax
    11a7:	0f b6 10             	movzbl (%eax),%edx
    11aa:	84 d2                	test   %dl,%dl
    11ac:	75 f2                	jne    11a0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    11ae:	31 c0                	xor    %eax,%eax
}
    11b0:	5b                   	pop    %ebx
    11b1:	5d                   	pop    %ebp
    11b2:	c3                   	ret    
    11b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011c0 <gets>:

char*
gets(char *buf, int max)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	57                   	push   %edi
    11c4:	56                   	push   %esi
    11c5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11c6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    11c8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    11cb:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11ce:	eb 29                	jmp    11f9 <gets+0x39>
    cc = read(0, &c, 1);
    11d0:	83 ec 04             	sub    $0x4,%esp
    11d3:	6a 01                	push   $0x1
    11d5:	57                   	push   %edi
    11d6:	6a 00                	push   $0x0
    11d8:	e8 2d 01 00 00       	call   130a <read>
    if(cc < 1)
    11dd:	83 c4 10             	add    $0x10,%esp
    11e0:	85 c0                	test   %eax,%eax
    11e2:	7e 1d                	jle    1201 <gets+0x41>
      break;
    buf[i++] = c;
    11e4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    11e8:	8b 55 08             	mov    0x8(%ebp),%edx
    11eb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    11ed:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    11ef:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    11f3:	74 1b                	je     1210 <gets+0x50>
    11f5:	3c 0d                	cmp    $0xd,%al
    11f7:	74 17                	je     1210 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11f9:	8d 5e 01             	lea    0x1(%esi),%ebx
    11fc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11ff:	7c cf                	jl     11d0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1201:	8b 45 08             	mov    0x8(%ebp),%eax
    1204:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1208:	8d 65 f4             	lea    -0xc(%ebp),%esp
    120b:	5b                   	pop    %ebx
    120c:	5e                   	pop    %esi
    120d:	5f                   	pop    %edi
    120e:	5d                   	pop    %ebp
    120f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1210:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1213:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1215:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1219:	8d 65 f4             	lea    -0xc(%ebp),%esp
    121c:	5b                   	pop    %ebx
    121d:	5e                   	pop    %esi
    121e:	5f                   	pop    %edi
    121f:	5d                   	pop    %ebp
    1220:	c3                   	ret    
    1221:	eb 0d                	jmp    1230 <stat>
    1223:	90                   	nop
    1224:	90                   	nop
    1225:	90                   	nop
    1226:	90                   	nop
    1227:	90                   	nop
    1228:	90                   	nop
    1229:	90                   	nop
    122a:	90                   	nop
    122b:	90                   	nop
    122c:	90                   	nop
    122d:	90                   	nop
    122e:	90                   	nop
    122f:	90                   	nop

00001230 <stat>:

int
stat(const char *n, struct stat *st)
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	56                   	push   %esi
    1234:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1235:	83 ec 08             	sub    $0x8,%esp
    1238:	6a 00                	push   $0x0
    123a:	ff 75 08             	pushl  0x8(%ebp)
    123d:	e8 f0 00 00 00       	call   1332 <open>
  if(fd < 0)
    1242:	83 c4 10             	add    $0x10,%esp
    1245:	85 c0                	test   %eax,%eax
    1247:	78 27                	js     1270 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1249:	83 ec 08             	sub    $0x8,%esp
    124c:	ff 75 0c             	pushl  0xc(%ebp)
    124f:	89 c3                	mov    %eax,%ebx
    1251:	50                   	push   %eax
    1252:	e8 f3 00 00 00       	call   134a <fstat>
    1257:	89 c6                	mov    %eax,%esi
  close(fd);
    1259:	89 1c 24             	mov    %ebx,(%esp)
    125c:	e8 b9 00 00 00       	call   131a <close>
  return r;
    1261:	83 c4 10             	add    $0x10,%esp
    1264:	89 f0                	mov    %esi,%eax
}
    1266:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1269:	5b                   	pop    %ebx
    126a:	5e                   	pop    %esi
    126b:	5d                   	pop    %ebp
    126c:	c3                   	ret    
    126d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    1270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1275:	eb ef                	jmp    1266 <stat+0x36>
    1277:	89 f6                	mov    %esi,%esi
    1279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001280 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	53                   	push   %ebx
    1284:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1287:	0f be 11             	movsbl (%ecx),%edx
    128a:	8d 42 d0             	lea    -0x30(%edx),%eax
    128d:	3c 09                	cmp    $0x9,%al
    128f:	b8 00 00 00 00       	mov    $0x0,%eax
    1294:	77 1f                	ja     12b5 <atoi+0x35>
    1296:	8d 76 00             	lea    0x0(%esi),%esi
    1299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    12a0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    12a3:	83 c1 01             	add    $0x1,%ecx
    12a6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12aa:	0f be 11             	movsbl (%ecx),%edx
    12ad:	8d 5a d0             	lea    -0x30(%edx),%ebx
    12b0:	80 fb 09             	cmp    $0x9,%bl
    12b3:	76 eb                	jbe    12a0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    12b5:	5b                   	pop    %ebx
    12b6:	5d                   	pop    %ebp
    12b7:	c3                   	ret    
    12b8:	90                   	nop
    12b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000012c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	56                   	push   %esi
    12c4:	53                   	push   %ebx
    12c5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12c8:	8b 45 08             	mov    0x8(%ebp),%eax
    12cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12ce:	85 db                	test   %ebx,%ebx
    12d0:	7e 14                	jle    12e6 <memmove+0x26>
    12d2:	31 d2                	xor    %edx,%edx
    12d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    12d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    12dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    12df:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12e2:	39 da                	cmp    %ebx,%edx
    12e4:	75 f2                	jne    12d8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    12e6:	5b                   	pop    %ebx
    12e7:	5e                   	pop    %esi
    12e8:	5d                   	pop    %ebp
    12e9:	c3                   	ret    

000012ea <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12ea:	b8 01 00 00 00       	mov    $0x1,%eax
    12ef:	cd 40                	int    $0x40
    12f1:	c3                   	ret    

000012f2 <exit>:
SYSCALL(exit)
    12f2:	b8 02 00 00 00       	mov    $0x2,%eax
    12f7:	cd 40                	int    $0x40
    12f9:	c3                   	ret    

000012fa <wait>:
SYSCALL(wait)
    12fa:	b8 03 00 00 00       	mov    $0x3,%eax
    12ff:	cd 40                	int    $0x40
    1301:	c3                   	ret    

00001302 <pipe>:
SYSCALL(pipe)
    1302:	b8 04 00 00 00       	mov    $0x4,%eax
    1307:	cd 40                	int    $0x40
    1309:	c3                   	ret    

0000130a <read>:
SYSCALL(read)
    130a:	b8 05 00 00 00       	mov    $0x5,%eax
    130f:	cd 40                	int    $0x40
    1311:	c3                   	ret    

00001312 <write>:
SYSCALL(write)
    1312:	b8 10 00 00 00       	mov    $0x10,%eax
    1317:	cd 40                	int    $0x40
    1319:	c3                   	ret    

0000131a <close>:
SYSCALL(close)
    131a:	b8 15 00 00 00       	mov    $0x15,%eax
    131f:	cd 40                	int    $0x40
    1321:	c3                   	ret    

00001322 <kill>:
SYSCALL(kill)
    1322:	b8 06 00 00 00       	mov    $0x6,%eax
    1327:	cd 40                	int    $0x40
    1329:	c3                   	ret    

0000132a <exec>:
SYSCALL(exec)
    132a:	b8 07 00 00 00       	mov    $0x7,%eax
    132f:	cd 40                	int    $0x40
    1331:	c3                   	ret    

00001332 <open>:
SYSCALL(open)
    1332:	b8 0f 00 00 00       	mov    $0xf,%eax
    1337:	cd 40                	int    $0x40
    1339:	c3                   	ret    

0000133a <mknod>:
SYSCALL(mknod)
    133a:	b8 11 00 00 00       	mov    $0x11,%eax
    133f:	cd 40                	int    $0x40
    1341:	c3                   	ret    

00001342 <unlink>:
SYSCALL(unlink)
    1342:	b8 12 00 00 00       	mov    $0x12,%eax
    1347:	cd 40                	int    $0x40
    1349:	c3                   	ret    

0000134a <fstat>:
SYSCALL(fstat)
    134a:	b8 08 00 00 00       	mov    $0x8,%eax
    134f:	cd 40                	int    $0x40
    1351:	c3                   	ret    

00001352 <link>:
SYSCALL(link)
    1352:	b8 13 00 00 00       	mov    $0x13,%eax
    1357:	cd 40                	int    $0x40
    1359:	c3                   	ret    

0000135a <mkdir>:
SYSCALL(mkdir)
    135a:	b8 14 00 00 00       	mov    $0x14,%eax
    135f:	cd 40                	int    $0x40
    1361:	c3                   	ret    

00001362 <chdir>:
SYSCALL(chdir)
    1362:	b8 09 00 00 00       	mov    $0x9,%eax
    1367:	cd 40                	int    $0x40
    1369:	c3                   	ret    

0000136a <dup>:
SYSCALL(dup)
    136a:	b8 0a 00 00 00       	mov    $0xa,%eax
    136f:	cd 40                	int    $0x40
    1371:	c3                   	ret    

00001372 <getpid>:
SYSCALL(getpid)
    1372:	b8 0b 00 00 00       	mov    $0xb,%eax
    1377:	cd 40                	int    $0x40
    1379:	c3                   	ret    

0000137a <sbrk>:
SYSCALL(sbrk)
    137a:	b8 0c 00 00 00       	mov    $0xc,%eax
    137f:	cd 40                	int    $0x40
    1381:	c3                   	ret    

00001382 <sleep>:
SYSCALL(sleep)
    1382:	b8 0d 00 00 00       	mov    $0xd,%eax
    1387:	cd 40                	int    $0x40
    1389:	c3                   	ret    

0000138a <uptime>:
SYSCALL(uptime)
    138a:	b8 0e 00 00 00       	mov    $0xe,%eax
    138f:	cd 40                	int    $0x40
    1391:	c3                   	ret    

00001392 <mprotect>:
SYSCALL(mprotect)
    1392:	b8 16 00 00 00       	mov    $0x16,%eax
    1397:	cd 40                	int    $0x40
    1399:	c3                   	ret    

0000139a <munprotect>:
SYSCALL(munprotect)
    139a:	b8 17 00 00 00       	mov    $0x17,%eax
    139f:	cd 40                	int    $0x40
    13a1:	c3                   	ret    
    13a2:	66 90                	xchg   %ax,%ax
    13a4:	66 90                	xchg   %ax,%ax
    13a6:	66 90                	xchg   %ax,%ax
    13a8:	66 90                	xchg   %ax,%ax
    13aa:	66 90                	xchg   %ax,%ax
    13ac:	66 90                	xchg   %ax,%ax
    13ae:	66 90                	xchg   %ax,%ax

000013b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    13b0:	55                   	push   %ebp
    13b1:	89 e5                	mov    %esp,%ebp
    13b3:	57                   	push   %edi
    13b4:	56                   	push   %esi
    13b5:	53                   	push   %ebx
    13b6:	89 c6                	mov    %eax,%esi
    13b8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    13be:	85 db                	test   %ebx,%ebx
    13c0:	74 7e                	je     1440 <printint+0x90>
    13c2:	89 d0                	mov    %edx,%eax
    13c4:	c1 e8 1f             	shr    $0x1f,%eax
    13c7:	84 c0                	test   %al,%al
    13c9:	74 75                	je     1440 <printint+0x90>
    neg = 1;
    x = -xx;
    13cb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    13cd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    13d4:	f7 d8                	neg    %eax
    13d6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    13d9:	31 ff                	xor    %edi,%edi
    13db:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    13de:	89 ce                	mov    %ecx,%esi
    13e0:	eb 08                	jmp    13ea <printint+0x3a>
    13e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    13e8:	89 cf                	mov    %ecx,%edi
    13ea:	31 d2                	xor    %edx,%edx
    13ec:	8d 4f 01             	lea    0x1(%edi),%ecx
    13ef:	f7 f6                	div    %esi
    13f1:	0f b6 92 e0 17 00 00 	movzbl 0x17e0(%edx),%edx
  }while((x /= base) != 0);
    13f8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    13fa:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    13fd:	75 e9                	jne    13e8 <printint+0x38>
  if(neg)
    13ff:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1402:	8b 75 c0             	mov    -0x40(%ebp),%esi
    1405:	85 c0                	test   %eax,%eax
    1407:	74 08                	je     1411 <printint+0x61>
    buf[i++] = '-';
    1409:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    140e:	8d 4f 02             	lea    0x2(%edi),%ecx
    1411:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    1415:	8d 76 00             	lea    0x0(%esi),%esi
    1418:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    141b:	83 ec 04             	sub    $0x4,%esp
    141e:	83 ef 01             	sub    $0x1,%edi
    1421:	6a 01                	push   $0x1
    1423:	53                   	push   %ebx
    1424:	56                   	push   %esi
    1425:	88 45 d7             	mov    %al,-0x29(%ebp)
    1428:	e8 e5 fe ff ff       	call   1312 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    142d:	83 c4 10             	add    $0x10,%esp
    1430:	39 df                	cmp    %ebx,%edi
    1432:	75 e4                	jne    1418 <printint+0x68>
    putc(fd, buf[i]);
}
    1434:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1437:	5b                   	pop    %ebx
    1438:	5e                   	pop    %esi
    1439:	5f                   	pop    %edi
    143a:	5d                   	pop    %ebp
    143b:	c3                   	ret    
    143c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1440:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1442:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1449:	eb 8b                	jmp    13d6 <printint+0x26>
    144b:	90                   	nop
    144c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001450 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	57                   	push   %edi
    1454:	56                   	push   %esi
    1455:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1456:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1459:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    145c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    145f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1462:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1465:	0f b6 1e             	movzbl (%esi),%ebx
    1468:	83 c6 01             	add    $0x1,%esi
    146b:	84 db                	test   %bl,%bl
    146d:	0f 84 b0 00 00 00    	je     1523 <printf+0xd3>
    1473:	31 d2                	xor    %edx,%edx
    1475:	eb 39                	jmp    14b0 <printf+0x60>
    1477:	89 f6                	mov    %esi,%esi
    1479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1480:	83 f8 25             	cmp    $0x25,%eax
    1483:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    1486:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    148b:	74 18                	je     14a5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    148d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1490:	83 ec 04             	sub    $0x4,%esp
    1493:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1496:	6a 01                	push   $0x1
    1498:	50                   	push   %eax
    1499:	57                   	push   %edi
    149a:	e8 73 fe ff ff       	call   1312 <write>
    149f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    14a2:	83 c4 10             	add    $0x10,%esp
    14a5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14a8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    14ac:	84 db                	test   %bl,%bl
    14ae:	74 73                	je     1523 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    14b0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    14b2:	0f be cb             	movsbl %bl,%ecx
    14b5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    14b8:	74 c6                	je     1480 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    14ba:	83 fa 25             	cmp    $0x25,%edx
    14bd:	75 e6                	jne    14a5 <printf+0x55>
      if(c == 'd'){
    14bf:	83 f8 64             	cmp    $0x64,%eax
    14c2:	0f 84 f8 00 00 00    	je     15c0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    14c8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    14ce:	83 f9 70             	cmp    $0x70,%ecx
    14d1:	74 5d                	je     1530 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    14d3:	83 f8 73             	cmp    $0x73,%eax
    14d6:	0f 84 84 00 00 00    	je     1560 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    14dc:	83 f8 63             	cmp    $0x63,%eax
    14df:	0f 84 ea 00 00 00    	je     15cf <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    14e5:	83 f8 25             	cmp    $0x25,%eax
    14e8:	0f 84 c2 00 00 00    	je     15b0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14ee:	8d 45 e7             	lea    -0x19(%ebp),%eax
    14f1:	83 ec 04             	sub    $0x4,%esp
    14f4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    14f8:	6a 01                	push   $0x1
    14fa:	50                   	push   %eax
    14fb:	57                   	push   %edi
    14fc:	e8 11 fe ff ff       	call   1312 <write>
    1501:	83 c4 0c             	add    $0xc,%esp
    1504:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1507:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    150a:	6a 01                	push   $0x1
    150c:	50                   	push   %eax
    150d:	57                   	push   %edi
    150e:	83 c6 01             	add    $0x1,%esi
    1511:	e8 fc fd ff ff       	call   1312 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1516:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    151a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    151d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    151f:	84 db                	test   %bl,%bl
    1521:	75 8d                	jne    14b0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1523:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1526:	5b                   	pop    %ebx
    1527:	5e                   	pop    %esi
    1528:	5f                   	pop    %edi
    1529:	5d                   	pop    %ebp
    152a:	c3                   	ret    
    152b:	90                   	nop
    152c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1530:	83 ec 0c             	sub    $0xc,%esp
    1533:	b9 10 00 00 00       	mov    $0x10,%ecx
    1538:	6a 00                	push   $0x0
    153a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    153d:	89 f8                	mov    %edi,%eax
    153f:	8b 13                	mov    (%ebx),%edx
    1541:	e8 6a fe ff ff       	call   13b0 <printint>
        ap++;
    1546:	89 d8                	mov    %ebx,%eax
    1548:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    154b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    154d:	83 c0 04             	add    $0x4,%eax
    1550:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1553:	e9 4d ff ff ff       	jmp    14a5 <printf+0x55>
    1558:	90                   	nop
    1559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    1560:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1563:	8b 18                	mov    (%eax),%ebx
        ap++;
    1565:	83 c0 04             	add    $0x4,%eax
    1568:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    156b:	b8 d6 17 00 00       	mov    $0x17d6,%eax
    1570:	85 db                	test   %ebx,%ebx
    1572:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    1575:	0f b6 03             	movzbl (%ebx),%eax
    1578:	84 c0                	test   %al,%al
    157a:	74 23                	je     159f <printf+0x14f>
    157c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1580:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1583:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1586:	83 ec 04             	sub    $0x4,%esp
    1589:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    158b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    158e:	50                   	push   %eax
    158f:	57                   	push   %edi
    1590:	e8 7d fd ff ff       	call   1312 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1595:	0f b6 03             	movzbl (%ebx),%eax
    1598:	83 c4 10             	add    $0x10,%esp
    159b:	84 c0                	test   %al,%al
    159d:	75 e1                	jne    1580 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    159f:	31 d2                	xor    %edx,%edx
    15a1:	e9 ff fe ff ff       	jmp    14a5 <printf+0x55>
    15a6:	8d 76 00             	lea    0x0(%esi),%esi
    15a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15b0:	83 ec 04             	sub    $0x4,%esp
    15b3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    15b6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    15b9:	6a 01                	push   $0x1
    15bb:	e9 4c ff ff ff       	jmp    150c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    15c0:	83 ec 0c             	sub    $0xc,%esp
    15c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    15c8:	6a 01                	push   $0x1
    15ca:	e9 6b ff ff ff       	jmp    153a <printf+0xea>
    15cf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15d2:	83 ec 04             	sub    $0x4,%esp
    15d5:	8b 03                	mov    (%ebx),%eax
    15d7:	6a 01                	push   $0x1
    15d9:	88 45 e4             	mov    %al,-0x1c(%ebp)
    15dc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    15df:	50                   	push   %eax
    15e0:	57                   	push   %edi
    15e1:	e8 2c fd ff ff       	call   1312 <write>
    15e6:	e9 5b ff ff ff       	jmp    1546 <printf+0xf6>
    15eb:	66 90                	xchg   %ax,%ax
    15ed:	66 90                	xchg   %ax,%ax
    15ef:	90                   	nop

000015f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15f1:	a1 7c 1a 00 00       	mov    0x1a7c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    15f6:	89 e5                	mov    %esp,%ebp
    15f8:	57                   	push   %edi
    15f9:	56                   	push   %esi
    15fa:	53                   	push   %ebx
    15fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15fe:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1600:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1603:	39 c8                	cmp    %ecx,%eax
    1605:	73 19                	jae    1620 <free+0x30>
    1607:	89 f6                	mov    %esi,%esi
    1609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1610:	39 d1                	cmp    %edx,%ecx
    1612:	72 1c                	jb     1630 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1614:	39 d0                	cmp    %edx,%eax
    1616:	73 18                	jae    1630 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    1618:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    161a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    161c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    161e:	72 f0                	jb     1610 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1620:	39 d0                	cmp    %edx,%eax
    1622:	72 f4                	jb     1618 <free+0x28>
    1624:	39 d1                	cmp    %edx,%ecx
    1626:	73 f0                	jae    1618 <free+0x28>
    1628:	90                   	nop
    1629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    1630:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1633:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1636:	39 d7                	cmp    %edx,%edi
    1638:	74 19                	je     1653 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    163a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    163d:	8b 50 04             	mov    0x4(%eax),%edx
    1640:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1643:	39 f1                	cmp    %esi,%ecx
    1645:	74 23                	je     166a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1647:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1649:	a3 7c 1a 00 00       	mov    %eax,0x1a7c
}
    164e:	5b                   	pop    %ebx
    164f:	5e                   	pop    %esi
    1650:	5f                   	pop    %edi
    1651:	5d                   	pop    %ebp
    1652:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1653:	03 72 04             	add    0x4(%edx),%esi
    1656:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1659:	8b 10                	mov    (%eax),%edx
    165b:	8b 12                	mov    (%edx),%edx
    165d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1660:	8b 50 04             	mov    0x4(%eax),%edx
    1663:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1666:	39 f1                	cmp    %esi,%ecx
    1668:	75 dd                	jne    1647 <free+0x57>
    p->s.size += bp->s.size;
    166a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    166d:	a3 7c 1a 00 00       	mov    %eax,0x1a7c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1672:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1675:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1678:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    167a:	5b                   	pop    %ebx
    167b:	5e                   	pop    %esi
    167c:	5f                   	pop    %edi
    167d:	5d                   	pop    %ebp
    167e:	c3                   	ret    
    167f:	90                   	nop

00001680 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1680:	55                   	push   %ebp
    1681:	89 e5                	mov    %esp,%ebp
    1683:	57                   	push   %edi
    1684:	56                   	push   %esi
    1685:	53                   	push   %ebx
    1686:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1689:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    168c:	8b 15 7c 1a 00 00    	mov    0x1a7c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1692:	8d 78 07             	lea    0x7(%eax),%edi
    1695:	c1 ef 03             	shr    $0x3,%edi
    1698:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    169b:	85 d2                	test   %edx,%edx
    169d:	0f 84 a3 00 00 00    	je     1746 <malloc+0xc6>
    16a3:	8b 02                	mov    (%edx),%eax
    16a5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    16a8:	39 cf                	cmp    %ecx,%edi
    16aa:	76 74                	jbe    1720 <malloc+0xa0>
    16ac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    16b2:	be 00 10 00 00       	mov    $0x1000,%esi
    16b7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    16be:	0f 43 f7             	cmovae %edi,%esi
    16c1:	ba 00 80 00 00       	mov    $0x8000,%edx
    16c6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    16cc:	0f 46 da             	cmovbe %edx,%ebx
    16cf:	eb 10                	jmp    16e1 <malloc+0x61>
    16d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    16da:	8b 48 04             	mov    0x4(%eax),%ecx
    16dd:	39 cf                	cmp    %ecx,%edi
    16df:	76 3f                	jbe    1720 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    16e1:	39 05 7c 1a 00 00    	cmp    %eax,0x1a7c
    16e7:	89 c2                	mov    %eax,%edx
    16e9:	75 ed                	jne    16d8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    16eb:	83 ec 0c             	sub    $0xc,%esp
    16ee:	53                   	push   %ebx
    16ef:	e8 86 fc ff ff       	call   137a <sbrk>
  if(p == (char*)-1)
    16f4:	83 c4 10             	add    $0x10,%esp
    16f7:	83 f8 ff             	cmp    $0xffffffff,%eax
    16fa:	74 1c                	je     1718 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    16fc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    16ff:	83 ec 0c             	sub    $0xc,%esp
    1702:	83 c0 08             	add    $0x8,%eax
    1705:	50                   	push   %eax
    1706:	e8 e5 fe ff ff       	call   15f0 <free>
  return freep;
    170b:	8b 15 7c 1a 00 00    	mov    0x1a7c,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    1711:	83 c4 10             	add    $0x10,%esp
    1714:	85 d2                	test   %edx,%edx
    1716:	75 c0                	jne    16d8 <malloc+0x58>
        return 0;
    1718:	31 c0                	xor    %eax,%eax
    171a:	eb 1c                	jmp    1738 <malloc+0xb8>
    171c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1720:	39 cf                	cmp    %ecx,%edi
    1722:	74 1c                	je     1740 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1724:	29 f9                	sub    %edi,%ecx
    1726:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1729:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    172c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    172f:	89 15 7c 1a 00 00    	mov    %edx,0x1a7c
      return (void*)(p + 1);
    1735:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1738:	8d 65 f4             	lea    -0xc(%ebp),%esp
    173b:	5b                   	pop    %ebx
    173c:	5e                   	pop    %esi
    173d:	5f                   	pop    %edi
    173e:	5d                   	pop    %ebp
    173f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1740:	8b 08                	mov    (%eax),%ecx
    1742:	89 0a                	mov    %ecx,(%edx)
    1744:	eb e9                	jmp    172f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1746:	c7 05 7c 1a 00 00 80 	movl   $0x1a80,0x1a7c
    174d:	1a 00 00 
    1750:	c7 05 80 1a 00 00 80 	movl   $0x1a80,0x1a80
    1757:	1a 00 00 
    base.s.size = 0;
    175a:	b8 80 1a 00 00       	mov    $0x1a80,%eax
    175f:	c7 05 84 1a 00 00 00 	movl   $0x0,0x1a84
    1766:	00 00 00 
    1769:	e9 3e ff ff ff       	jmp    16ac <malloc+0x2c>
