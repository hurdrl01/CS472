
_readonlycode2:     file format elf32-i386


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
    101f:	e8 7e 04 00 00       	call   14a2 <mprotect>
    1024:	83 c4 10             	add    $0x10,%esp
    1027:	83 f8 ff             	cmp    $0xffffffff,%eax
    102a:	0f 84 05 01 00 00    	je     1135 <main+0x135>
  	printf(1, "mprotect call failed\n");
  } else {
  	printf(1, "mprotect call succeeded\n");
    1030:	83 ec 08             	sub    $0x8,%esp
    1033:	68 96 18 00 00       	push   $0x1896
    1038:	6a 01                	push   $0x1
    103a:	e8 21 05 00 00       	call   1560 <printf>
    103f:	83 c4 10             	add    $0x10,%esp
  }

  if (munprotect((void *)p, 1) == -1) {
    1042:	83 ec 08             	sub    $0x8,%esp
    1045:	6a 01                	push   $0x1
    1047:	68 00 10 00 00       	push   $0x1000
    104c:	e8 59 04 00 00       	call   14aa <munprotect>
    1051:	83 c4 10             	add    $0x10,%esp
    1054:	83 f8 ff             	cmp    $0xffffffff,%eax
    1057:	0f 84 40 01 00 00    	je     119d <main+0x19d>
  	printf(1, "munprotect call failed\n");
  } else {
  	printf(1, "munprotect call succeeded\n");
    105d:	83 ec 08             	sub    $0x8,%esp
    1060:	68 c7 18 00 00       	push   $0x18c7
    1065:	6a 01                	push   $0x1
    1067:	e8 f4 04 00 00       	call   1560 <printf>
    106c:	83 c4 10             	add    $0x10,%esp
  }

  *p = value;
  printf(1, "%x\n", *p); 	
    106f:	83 ec 04             	sub    $0x4,%esp
  	printf(1, "munprotect call failed\n");
  } else {
  	printf(1, "munprotect call succeeded\n");
  }

  *p = value;
    1072:	89 1d 00 10 00 00    	mov    %ebx,0x1000
  printf(1, "%x\n", *p); 	
    1078:	53                   	push   %ebx
    1079:	68 e2 18 00 00       	push   $0x18e2
    107e:	6a 01                	push   $0x1
    1080:	e8 db 04 00 00       	call   1560 <printf>

  p = (int *)0x1001;
  if (mprotect((void *)p, 1) == -1) {
    1085:	58                   	pop    %eax
    1086:	5a                   	pop    %edx
    1087:	6a 01                	push   $0x1
    1089:	68 01 10 00 00       	push   $0x1001
    108e:	e8 0f 04 00 00       	call   14a2 <mprotect>
    1093:	83 c4 10             	add    $0x10,%esp
    1096:	83 f8 ff             	cmp    $0xffffffff,%eax
    1099:	0f 84 e8 00 00 00    	je     1187 <main+0x187>
    printf(1, "mprotect call failed: page aligned\n");
  } else {
    printf(1, "mprotect call succeeded\n");
    109f:	83 ec 08             	sub    $0x8,%esp
    10a2:	68 96 18 00 00       	push   $0x1896
    10a7:	6a 01                	push   $0x1
    10a9:	e8 b2 04 00 00       	call   1560 <printf>
    10ae:	83 c4 10             	add    $0x10,%esp
  }

  p = (int *)0x1001;
  if (munprotect((void *)p, 1) == -1) {
    10b1:	83 ec 08             	sub    $0x8,%esp
    10b4:	6a 01                	push   $0x1
    10b6:	68 01 10 00 00       	push   $0x1001
    10bb:	e8 ea 03 00 00       	call   14aa <munprotect>
    10c0:	83 c4 10             	add    $0x10,%esp
    10c3:	83 f8 ff             	cmp    $0xffffffff,%eax
    10c6:	0f 84 a5 00 00 00    	je     1171 <main+0x171>
    printf(1, "munprotect call failed: page aligned\n");
  } else {
    printf(1, "munprotect call succeeded\n");
    10cc:	83 ec 08             	sub    $0x8,%esp
    10cf:	68 c7 18 00 00       	push   $0x18c7
    10d4:	6a 01                	push   $0x1
    10d6:	e8 85 04 00 00       	call   1560 <printf>
    10db:	83 c4 10             	add    $0x10,%esp
  }

  p = (int *)0x1000;
  if (mprotect((void *)p, 4) == -1) {
    10de:	83 ec 08             	sub    $0x8,%esp
    10e1:	6a 04                	push   $0x4
    10e3:	68 00 10 00 00       	push   $0x1000
    10e8:	e8 b5 03 00 00       	call   14a2 <mprotect>
    10ed:	83 c4 10             	add    $0x10,%esp
    10f0:	83 f8 ff             	cmp    $0xffffffff,%eax
    10f3:	74 69                	je     115e <main+0x15e>
    printf(1, "mprotect call failed: page length\n");
  } else {
    printf(1, "mprotect call succeeded\n");
    10f5:	83 ec 08             	sub    $0x8,%esp
    10f8:	68 96 18 00 00       	push   $0x1896
    10fd:	6a 01                	push   $0x1
    10ff:	e8 5c 04 00 00       	call   1560 <printf>
    1104:	83 c4 10             	add    $0x10,%esp
  }

  p = (int *)0x1000;
  if (munprotect((void *)p, 4) == -1) {
    1107:	83 ec 08             	sub    $0x8,%esp
    110a:	6a 04                	push   $0x4
    110c:	68 00 10 00 00       	push   $0x1000
    1111:	e8 94 03 00 00       	call   14aa <munprotect>
    1116:	83 c4 10             	add    $0x10,%esp
    1119:	83 f8 ff             	cmp    $0xffffffff,%eax
    111c:	74 2d                	je     114b <main+0x14b>
    printf(1, "munprotect call failed: page length\n");
  } else {
    printf(1, "munprotect call succeeded\n");
    111e:	83 ec 08             	sub    $0x8,%esp
    1121:	68 c7 18 00 00       	push   $0x18c7
    1126:	6a 01                	push   $0x1
    1128:	e8 33 04 00 00       	call   1560 <printf>
    112d:	83 c4 10             	add    $0x10,%esp
  }

  exit();
    1130:	e8 cd 02 00 00       	call   1402 <exit>
  int value = *p;
  
  *p = value;

  if (mprotect((void *)p, 1) == -1) {
  	printf(1, "mprotect call failed\n");
    1135:	50                   	push   %eax
    1136:	50                   	push   %eax
    1137:	68 80 18 00 00       	push   $0x1880
    113c:	6a 01                	push   $0x1
    113e:	e8 1d 04 00 00       	call   1560 <printf>
    1143:	83 c4 10             	add    $0x10,%esp
    1146:	e9 f7 fe ff ff       	jmp    1042 <main+0x42>
    printf(1, "mprotect call succeeded\n");
  }

  p = (int *)0x1000;
  if (munprotect((void *)p, 4) == -1) {
    printf(1, "munprotect call failed: page length\n");
    114b:	50                   	push   %eax
    114c:	50                   	push   %eax
    114d:	68 58 19 00 00       	push   $0x1958
    1152:	6a 01                	push   $0x1
    1154:	e8 07 04 00 00       	call   1560 <printf>
    1159:	83 c4 10             	add    $0x10,%esp
    115c:	eb d2                	jmp    1130 <main+0x130>
    printf(1, "munprotect call succeeded\n");
  }

  p = (int *)0x1000;
  if (mprotect((void *)p, 4) == -1) {
    printf(1, "mprotect call failed: page length\n");
    115e:	52                   	push   %edx
    115f:	52                   	push   %edx
    1160:	68 34 19 00 00       	push   $0x1934
    1165:	6a 01                	push   $0x1
    1167:	e8 f4 03 00 00       	call   1560 <printf>
    116c:	83 c4 10             	add    $0x10,%esp
    116f:	eb 96                	jmp    1107 <main+0x107>
    printf(1, "mprotect call succeeded\n");
  }

  p = (int *)0x1001;
  if (munprotect((void *)p, 1) == -1) {
    printf(1, "munprotect call failed: page aligned\n");
    1171:	51                   	push   %ecx
    1172:	51                   	push   %ecx
    1173:	68 0c 19 00 00       	push   $0x190c
    1178:	6a 01                	push   $0x1
    117a:	e8 e1 03 00 00       	call   1560 <printf>
    117f:	83 c4 10             	add    $0x10,%esp
    1182:	e9 57 ff ff ff       	jmp    10de <main+0xde>
  *p = value;
  printf(1, "%x\n", *p); 	

  p = (int *)0x1001;
  if (mprotect((void *)p, 1) == -1) {
    printf(1, "mprotect call failed: page aligned\n");
    1187:	53                   	push   %ebx
    1188:	53                   	push   %ebx
    1189:	68 e8 18 00 00       	push   $0x18e8
    118e:	6a 01                	push   $0x1
    1190:	e8 cb 03 00 00       	call   1560 <printf>
    1195:	83 c4 10             	add    $0x10,%esp
    1198:	e9 14 ff ff ff       	jmp    10b1 <main+0xb1>
  } else {
  	printf(1, "mprotect call succeeded\n");
  }

  if (munprotect((void *)p, 1) == -1) {
  	printf(1, "munprotect call failed\n");
    119d:	51                   	push   %ecx
    119e:	51                   	push   %ecx
    119f:	68 af 18 00 00       	push   $0x18af
    11a4:	6a 01                	push   $0x1
    11a6:	e8 b5 03 00 00       	call   1560 <printf>
    11ab:	83 c4 10             	add    $0x10,%esp
    11ae:	e9 bc fe ff ff       	jmp    106f <main+0x6f>
    11b3:	66 90                	xchg   %ax,%ax
    11b5:	66 90                	xchg   %ax,%ax
    11b7:	66 90                	xchg   %ax,%ax
    11b9:	66 90                	xchg   %ax,%ax
    11bb:	66 90                	xchg   %ax,%ax
    11bd:	66 90                	xchg   %ax,%ax
    11bf:	90                   	nop

000011c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	53                   	push   %ebx
    11c4:	8b 45 08             	mov    0x8(%ebp),%eax
    11c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    11ca:	89 c2                	mov    %eax,%edx
    11cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11d0:	83 c1 01             	add    $0x1,%ecx
    11d3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    11d7:	83 c2 01             	add    $0x1,%edx
    11da:	84 db                	test   %bl,%bl
    11dc:	88 5a ff             	mov    %bl,-0x1(%edx)
    11df:	75 ef                	jne    11d0 <strcpy+0x10>
    ;
  return os;
}
    11e1:	5b                   	pop    %ebx
    11e2:	5d                   	pop    %ebp
    11e3:	c3                   	ret    
    11e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000011f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	56                   	push   %esi
    11f4:	53                   	push   %ebx
    11f5:	8b 55 08             	mov    0x8(%ebp),%edx
    11f8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    11fb:	0f b6 02             	movzbl (%edx),%eax
    11fe:	0f b6 19             	movzbl (%ecx),%ebx
    1201:	84 c0                	test   %al,%al
    1203:	75 1e                	jne    1223 <strcmp+0x33>
    1205:	eb 29                	jmp    1230 <strcmp+0x40>
    1207:	89 f6                	mov    %esi,%esi
    1209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1210:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1213:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1216:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1219:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    121d:	84 c0                	test   %al,%al
    121f:	74 0f                	je     1230 <strcmp+0x40>
    p++, q++;
    1221:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1223:	38 d8                	cmp    %bl,%al
    1225:	74 e9                	je     1210 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1227:	29 d8                	sub    %ebx,%eax
}
    1229:	5b                   	pop    %ebx
    122a:	5e                   	pop    %esi
    122b:	5d                   	pop    %ebp
    122c:	c3                   	ret    
    122d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1230:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1232:	29 d8                	sub    %ebx,%eax
}
    1234:	5b                   	pop    %ebx
    1235:	5e                   	pop    %esi
    1236:	5d                   	pop    %ebp
    1237:	c3                   	ret    
    1238:	90                   	nop
    1239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001240 <strlen>:

uint
strlen(const char *s)
{
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1246:	80 39 00             	cmpb   $0x0,(%ecx)
    1249:	74 12                	je     125d <strlen+0x1d>
    124b:	31 d2                	xor    %edx,%edx
    124d:	8d 76 00             	lea    0x0(%esi),%esi
    1250:	83 c2 01             	add    $0x1,%edx
    1253:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1257:	89 d0                	mov    %edx,%eax
    1259:	75 f5                	jne    1250 <strlen+0x10>
    ;
  return n;
}
    125b:	5d                   	pop    %ebp
    125c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    125d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    125f:	5d                   	pop    %ebp
    1260:	c3                   	ret    
    1261:	eb 0d                	jmp    1270 <memset>
    1263:	90                   	nop
    1264:	90                   	nop
    1265:	90                   	nop
    1266:	90                   	nop
    1267:	90                   	nop
    1268:	90                   	nop
    1269:	90                   	nop
    126a:	90                   	nop
    126b:	90                   	nop
    126c:	90                   	nop
    126d:	90                   	nop
    126e:	90                   	nop
    126f:	90                   	nop

00001270 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1270:	55                   	push   %ebp
    1271:	89 e5                	mov    %esp,%ebp
    1273:	57                   	push   %edi
    1274:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1277:	8b 4d 10             	mov    0x10(%ebp),%ecx
    127a:	8b 45 0c             	mov    0xc(%ebp),%eax
    127d:	89 d7                	mov    %edx,%edi
    127f:	fc                   	cld    
    1280:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1282:	89 d0                	mov    %edx,%eax
    1284:	5f                   	pop    %edi
    1285:	5d                   	pop    %ebp
    1286:	c3                   	ret    
    1287:	89 f6                	mov    %esi,%esi
    1289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001290 <strchr>:

char*
strchr(const char *s, char c)
{
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
    1293:	53                   	push   %ebx
    1294:	8b 45 08             	mov    0x8(%ebp),%eax
    1297:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    129a:	0f b6 10             	movzbl (%eax),%edx
    129d:	84 d2                	test   %dl,%dl
    129f:	74 1d                	je     12be <strchr+0x2e>
    if(*s == c)
    12a1:	38 d3                	cmp    %dl,%bl
    12a3:	89 d9                	mov    %ebx,%ecx
    12a5:	75 0d                	jne    12b4 <strchr+0x24>
    12a7:	eb 17                	jmp    12c0 <strchr+0x30>
    12a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12b0:	38 ca                	cmp    %cl,%dl
    12b2:	74 0c                	je     12c0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    12b4:	83 c0 01             	add    $0x1,%eax
    12b7:	0f b6 10             	movzbl (%eax),%edx
    12ba:	84 d2                	test   %dl,%dl
    12bc:	75 f2                	jne    12b0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    12be:	31 c0                	xor    %eax,%eax
}
    12c0:	5b                   	pop    %ebx
    12c1:	5d                   	pop    %ebp
    12c2:	c3                   	ret    
    12c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012d0 <gets>:

char*
gets(char *buf, int max)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	57                   	push   %edi
    12d4:	56                   	push   %esi
    12d5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12d6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    12d8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    12db:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12de:	eb 29                	jmp    1309 <gets+0x39>
    cc = read(0, &c, 1);
    12e0:	83 ec 04             	sub    $0x4,%esp
    12e3:	6a 01                	push   $0x1
    12e5:	57                   	push   %edi
    12e6:	6a 00                	push   $0x0
    12e8:	e8 2d 01 00 00       	call   141a <read>
    if(cc < 1)
    12ed:	83 c4 10             	add    $0x10,%esp
    12f0:	85 c0                	test   %eax,%eax
    12f2:	7e 1d                	jle    1311 <gets+0x41>
      break;
    buf[i++] = c;
    12f4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    12f8:	8b 55 08             	mov    0x8(%ebp),%edx
    12fb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    12fd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    12ff:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    1303:	74 1b                	je     1320 <gets+0x50>
    1305:	3c 0d                	cmp    $0xd,%al
    1307:	74 17                	je     1320 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1309:	8d 5e 01             	lea    0x1(%esi),%ebx
    130c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    130f:	7c cf                	jl     12e0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1311:	8b 45 08             	mov    0x8(%ebp),%eax
    1314:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1318:	8d 65 f4             	lea    -0xc(%ebp),%esp
    131b:	5b                   	pop    %ebx
    131c:	5e                   	pop    %esi
    131d:	5f                   	pop    %edi
    131e:	5d                   	pop    %ebp
    131f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1320:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1323:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1325:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1329:	8d 65 f4             	lea    -0xc(%ebp),%esp
    132c:	5b                   	pop    %ebx
    132d:	5e                   	pop    %esi
    132e:	5f                   	pop    %edi
    132f:	5d                   	pop    %ebp
    1330:	c3                   	ret    
    1331:	eb 0d                	jmp    1340 <stat>
    1333:	90                   	nop
    1334:	90                   	nop
    1335:	90                   	nop
    1336:	90                   	nop
    1337:	90                   	nop
    1338:	90                   	nop
    1339:	90                   	nop
    133a:	90                   	nop
    133b:	90                   	nop
    133c:	90                   	nop
    133d:	90                   	nop
    133e:	90                   	nop
    133f:	90                   	nop

00001340 <stat>:

int
stat(const char *n, struct stat *st)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	56                   	push   %esi
    1344:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1345:	83 ec 08             	sub    $0x8,%esp
    1348:	6a 00                	push   $0x0
    134a:	ff 75 08             	pushl  0x8(%ebp)
    134d:	e8 f0 00 00 00       	call   1442 <open>
  if(fd < 0)
    1352:	83 c4 10             	add    $0x10,%esp
    1355:	85 c0                	test   %eax,%eax
    1357:	78 27                	js     1380 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1359:	83 ec 08             	sub    $0x8,%esp
    135c:	ff 75 0c             	pushl  0xc(%ebp)
    135f:	89 c3                	mov    %eax,%ebx
    1361:	50                   	push   %eax
    1362:	e8 f3 00 00 00       	call   145a <fstat>
    1367:	89 c6                	mov    %eax,%esi
  close(fd);
    1369:	89 1c 24             	mov    %ebx,(%esp)
    136c:	e8 b9 00 00 00       	call   142a <close>
  return r;
    1371:	83 c4 10             	add    $0x10,%esp
    1374:	89 f0                	mov    %esi,%eax
}
    1376:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1379:	5b                   	pop    %ebx
    137a:	5e                   	pop    %esi
    137b:	5d                   	pop    %ebp
    137c:	c3                   	ret    
    137d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    1380:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1385:	eb ef                	jmp    1376 <stat+0x36>
    1387:	89 f6                	mov    %esi,%esi
    1389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001390 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1390:	55                   	push   %ebp
    1391:	89 e5                	mov    %esp,%ebp
    1393:	53                   	push   %ebx
    1394:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1397:	0f be 11             	movsbl (%ecx),%edx
    139a:	8d 42 d0             	lea    -0x30(%edx),%eax
    139d:	3c 09                	cmp    $0x9,%al
    139f:	b8 00 00 00 00       	mov    $0x0,%eax
    13a4:	77 1f                	ja     13c5 <atoi+0x35>
    13a6:	8d 76 00             	lea    0x0(%esi),%esi
    13a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    13b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    13b3:	83 c1 01             	add    $0x1,%ecx
    13b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    13ba:	0f be 11             	movsbl (%ecx),%edx
    13bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    13c0:	80 fb 09             	cmp    $0x9,%bl
    13c3:	76 eb                	jbe    13b0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    13c5:	5b                   	pop    %ebx
    13c6:	5d                   	pop    %ebp
    13c7:	c3                   	ret    
    13c8:	90                   	nop
    13c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000013d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	56                   	push   %esi
    13d4:	53                   	push   %ebx
    13d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13d8:	8b 45 08             	mov    0x8(%ebp),%eax
    13db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    13de:	85 db                	test   %ebx,%ebx
    13e0:	7e 14                	jle    13f6 <memmove+0x26>
    13e2:	31 d2                	xor    %edx,%edx
    13e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    13e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    13ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    13ef:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    13f2:	39 da                	cmp    %ebx,%edx
    13f4:	75 f2                	jne    13e8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    13f6:	5b                   	pop    %ebx
    13f7:	5e                   	pop    %esi
    13f8:	5d                   	pop    %ebp
    13f9:	c3                   	ret    

000013fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13fa:	b8 01 00 00 00       	mov    $0x1,%eax
    13ff:	cd 40                	int    $0x40
    1401:	c3                   	ret    

00001402 <exit>:
SYSCALL(exit)
    1402:	b8 02 00 00 00       	mov    $0x2,%eax
    1407:	cd 40                	int    $0x40
    1409:	c3                   	ret    

0000140a <wait>:
SYSCALL(wait)
    140a:	b8 03 00 00 00       	mov    $0x3,%eax
    140f:	cd 40                	int    $0x40
    1411:	c3                   	ret    

00001412 <pipe>:
SYSCALL(pipe)
    1412:	b8 04 00 00 00       	mov    $0x4,%eax
    1417:	cd 40                	int    $0x40
    1419:	c3                   	ret    

0000141a <read>:
SYSCALL(read)
    141a:	b8 05 00 00 00       	mov    $0x5,%eax
    141f:	cd 40                	int    $0x40
    1421:	c3                   	ret    

00001422 <write>:
SYSCALL(write)
    1422:	b8 10 00 00 00       	mov    $0x10,%eax
    1427:	cd 40                	int    $0x40
    1429:	c3                   	ret    

0000142a <close>:
SYSCALL(close)
    142a:	b8 15 00 00 00       	mov    $0x15,%eax
    142f:	cd 40                	int    $0x40
    1431:	c3                   	ret    

00001432 <kill>:
SYSCALL(kill)
    1432:	b8 06 00 00 00       	mov    $0x6,%eax
    1437:	cd 40                	int    $0x40
    1439:	c3                   	ret    

0000143a <exec>:
SYSCALL(exec)
    143a:	b8 07 00 00 00       	mov    $0x7,%eax
    143f:	cd 40                	int    $0x40
    1441:	c3                   	ret    

00001442 <open>:
SYSCALL(open)
    1442:	b8 0f 00 00 00       	mov    $0xf,%eax
    1447:	cd 40                	int    $0x40
    1449:	c3                   	ret    

0000144a <mknod>:
SYSCALL(mknod)
    144a:	b8 11 00 00 00       	mov    $0x11,%eax
    144f:	cd 40                	int    $0x40
    1451:	c3                   	ret    

00001452 <unlink>:
SYSCALL(unlink)
    1452:	b8 12 00 00 00       	mov    $0x12,%eax
    1457:	cd 40                	int    $0x40
    1459:	c3                   	ret    

0000145a <fstat>:
SYSCALL(fstat)
    145a:	b8 08 00 00 00       	mov    $0x8,%eax
    145f:	cd 40                	int    $0x40
    1461:	c3                   	ret    

00001462 <link>:
SYSCALL(link)
    1462:	b8 13 00 00 00       	mov    $0x13,%eax
    1467:	cd 40                	int    $0x40
    1469:	c3                   	ret    

0000146a <mkdir>:
SYSCALL(mkdir)
    146a:	b8 14 00 00 00       	mov    $0x14,%eax
    146f:	cd 40                	int    $0x40
    1471:	c3                   	ret    

00001472 <chdir>:
SYSCALL(chdir)
    1472:	b8 09 00 00 00       	mov    $0x9,%eax
    1477:	cd 40                	int    $0x40
    1479:	c3                   	ret    

0000147a <dup>:
SYSCALL(dup)
    147a:	b8 0a 00 00 00       	mov    $0xa,%eax
    147f:	cd 40                	int    $0x40
    1481:	c3                   	ret    

00001482 <getpid>:
SYSCALL(getpid)
    1482:	b8 0b 00 00 00       	mov    $0xb,%eax
    1487:	cd 40                	int    $0x40
    1489:	c3                   	ret    

0000148a <sbrk>:
SYSCALL(sbrk)
    148a:	b8 0c 00 00 00       	mov    $0xc,%eax
    148f:	cd 40                	int    $0x40
    1491:	c3                   	ret    

00001492 <sleep>:
SYSCALL(sleep)
    1492:	b8 0d 00 00 00       	mov    $0xd,%eax
    1497:	cd 40                	int    $0x40
    1499:	c3                   	ret    

0000149a <uptime>:
SYSCALL(uptime)
    149a:	b8 0e 00 00 00       	mov    $0xe,%eax
    149f:	cd 40                	int    $0x40
    14a1:	c3                   	ret    

000014a2 <mprotect>:
SYSCALL(mprotect)
    14a2:	b8 16 00 00 00       	mov    $0x16,%eax
    14a7:	cd 40                	int    $0x40
    14a9:	c3                   	ret    

000014aa <munprotect>:
SYSCALL(munprotect)
    14aa:	b8 17 00 00 00       	mov    $0x17,%eax
    14af:	cd 40                	int    $0x40
    14b1:	c3                   	ret    
    14b2:	66 90                	xchg   %ax,%ax
    14b4:	66 90                	xchg   %ax,%ax
    14b6:	66 90                	xchg   %ax,%ax
    14b8:	66 90                	xchg   %ax,%ax
    14ba:	66 90                	xchg   %ax,%ax
    14bc:	66 90                	xchg   %ax,%ax
    14be:	66 90                	xchg   %ax,%ax

000014c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    14c0:	55                   	push   %ebp
    14c1:	89 e5                	mov    %esp,%ebp
    14c3:	57                   	push   %edi
    14c4:	56                   	push   %esi
    14c5:	53                   	push   %ebx
    14c6:	89 c6                	mov    %eax,%esi
    14c8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    14cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    14ce:	85 db                	test   %ebx,%ebx
    14d0:	74 7e                	je     1550 <printint+0x90>
    14d2:	89 d0                	mov    %edx,%eax
    14d4:	c1 e8 1f             	shr    $0x1f,%eax
    14d7:	84 c0                	test   %al,%al
    14d9:	74 75                	je     1550 <printint+0x90>
    neg = 1;
    x = -xx;
    14db:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    14dd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    14e4:	f7 d8                	neg    %eax
    14e6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    14e9:	31 ff                	xor    %edi,%edi
    14eb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    14ee:	89 ce                	mov    %ecx,%esi
    14f0:	eb 08                	jmp    14fa <printint+0x3a>
    14f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    14f8:	89 cf                	mov    %ecx,%edi
    14fa:	31 d2                	xor    %edx,%edx
    14fc:	8d 4f 01             	lea    0x1(%edi),%ecx
    14ff:	f7 f6                	div    %esi
    1501:	0f b6 92 88 19 00 00 	movzbl 0x1988(%edx),%edx
  }while((x /= base) != 0);
    1508:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    150a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    150d:	75 e9                	jne    14f8 <printint+0x38>
  if(neg)
    150f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1512:	8b 75 c0             	mov    -0x40(%ebp),%esi
    1515:	85 c0                	test   %eax,%eax
    1517:	74 08                	je     1521 <printint+0x61>
    buf[i++] = '-';
    1519:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    151e:	8d 4f 02             	lea    0x2(%edi),%ecx
    1521:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    1525:	8d 76 00             	lea    0x0(%esi),%esi
    1528:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    152b:	83 ec 04             	sub    $0x4,%esp
    152e:	83 ef 01             	sub    $0x1,%edi
    1531:	6a 01                	push   $0x1
    1533:	53                   	push   %ebx
    1534:	56                   	push   %esi
    1535:	88 45 d7             	mov    %al,-0x29(%ebp)
    1538:	e8 e5 fe ff ff       	call   1422 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    153d:	83 c4 10             	add    $0x10,%esp
    1540:	39 df                	cmp    %ebx,%edi
    1542:	75 e4                	jne    1528 <printint+0x68>
    putc(fd, buf[i]);
}
    1544:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1547:	5b                   	pop    %ebx
    1548:	5e                   	pop    %esi
    1549:	5f                   	pop    %edi
    154a:	5d                   	pop    %ebp
    154b:	c3                   	ret    
    154c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1550:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1552:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1559:	eb 8b                	jmp    14e6 <printint+0x26>
    155b:	90                   	nop
    155c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001560 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1560:	55                   	push   %ebp
    1561:	89 e5                	mov    %esp,%ebp
    1563:	57                   	push   %edi
    1564:	56                   	push   %esi
    1565:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1566:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1569:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    156c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    156f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1572:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1575:	0f b6 1e             	movzbl (%esi),%ebx
    1578:	83 c6 01             	add    $0x1,%esi
    157b:	84 db                	test   %bl,%bl
    157d:	0f 84 b0 00 00 00    	je     1633 <printf+0xd3>
    1583:	31 d2                	xor    %edx,%edx
    1585:	eb 39                	jmp    15c0 <printf+0x60>
    1587:	89 f6                	mov    %esi,%esi
    1589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1590:	83 f8 25             	cmp    $0x25,%eax
    1593:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    1596:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    159b:	74 18                	je     15b5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    159d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    15a0:	83 ec 04             	sub    $0x4,%esp
    15a3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    15a6:	6a 01                	push   $0x1
    15a8:	50                   	push   %eax
    15a9:	57                   	push   %edi
    15aa:	e8 73 fe ff ff       	call   1422 <write>
    15af:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    15b2:	83 c4 10             	add    $0x10,%esp
    15b5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15b8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    15bc:	84 db                	test   %bl,%bl
    15be:	74 73                	je     1633 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    15c0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    15c2:	0f be cb             	movsbl %bl,%ecx
    15c5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    15c8:	74 c6                	je     1590 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    15ca:	83 fa 25             	cmp    $0x25,%edx
    15cd:	75 e6                	jne    15b5 <printf+0x55>
      if(c == 'd'){
    15cf:	83 f8 64             	cmp    $0x64,%eax
    15d2:	0f 84 f8 00 00 00    	je     16d0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    15d8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    15de:	83 f9 70             	cmp    $0x70,%ecx
    15e1:	74 5d                	je     1640 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    15e3:	83 f8 73             	cmp    $0x73,%eax
    15e6:	0f 84 84 00 00 00    	je     1670 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15ec:	83 f8 63             	cmp    $0x63,%eax
    15ef:	0f 84 ea 00 00 00    	je     16df <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    15f5:	83 f8 25             	cmp    $0x25,%eax
    15f8:	0f 84 c2 00 00 00    	je     16c0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15fe:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1601:	83 ec 04             	sub    $0x4,%esp
    1604:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1608:	6a 01                	push   $0x1
    160a:	50                   	push   %eax
    160b:	57                   	push   %edi
    160c:	e8 11 fe ff ff       	call   1422 <write>
    1611:	83 c4 0c             	add    $0xc,%esp
    1614:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1617:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    161a:	6a 01                	push   $0x1
    161c:	50                   	push   %eax
    161d:	57                   	push   %edi
    161e:	83 c6 01             	add    $0x1,%esi
    1621:	e8 fc fd ff ff       	call   1422 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1626:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    162a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    162d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    162f:	84 db                	test   %bl,%bl
    1631:	75 8d                	jne    15c0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1633:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1636:	5b                   	pop    %ebx
    1637:	5e                   	pop    %esi
    1638:	5f                   	pop    %edi
    1639:	5d                   	pop    %ebp
    163a:	c3                   	ret    
    163b:	90                   	nop
    163c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1640:	83 ec 0c             	sub    $0xc,%esp
    1643:	b9 10 00 00 00       	mov    $0x10,%ecx
    1648:	6a 00                	push   $0x0
    164a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    164d:	89 f8                	mov    %edi,%eax
    164f:	8b 13                	mov    (%ebx),%edx
    1651:	e8 6a fe ff ff       	call   14c0 <printint>
        ap++;
    1656:	89 d8                	mov    %ebx,%eax
    1658:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    165b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    165d:	83 c0 04             	add    $0x4,%eax
    1660:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1663:	e9 4d ff ff ff       	jmp    15b5 <printf+0x55>
    1668:	90                   	nop
    1669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    1670:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1673:	8b 18                	mov    (%eax),%ebx
        ap++;
    1675:	83 c0 04             	add    $0x4,%eax
    1678:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    167b:	b8 80 19 00 00       	mov    $0x1980,%eax
    1680:	85 db                	test   %ebx,%ebx
    1682:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    1685:	0f b6 03             	movzbl (%ebx),%eax
    1688:	84 c0                	test   %al,%al
    168a:	74 23                	je     16af <printf+0x14f>
    168c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1690:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1693:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1696:	83 ec 04             	sub    $0x4,%esp
    1699:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    169b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    169e:	50                   	push   %eax
    169f:	57                   	push   %edi
    16a0:	e8 7d fd ff ff       	call   1422 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    16a5:	0f b6 03             	movzbl (%ebx),%eax
    16a8:	83 c4 10             	add    $0x10,%esp
    16ab:	84 c0                	test   %al,%al
    16ad:	75 e1                	jne    1690 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    16af:	31 d2                	xor    %edx,%edx
    16b1:	e9 ff fe ff ff       	jmp    15b5 <printf+0x55>
    16b6:	8d 76 00             	lea    0x0(%esi),%esi
    16b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16c0:	83 ec 04             	sub    $0x4,%esp
    16c3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    16c6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    16c9:	6a 01                	push   $0x1
    16cb:	e9 4c ff ff ff       	jmp    161c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    16d0:	83 ec 0c             	sub    $0xc,%esp
    16d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    16d8:	6a 01                	push   $0x1
    16da:	e9 6b ff ff ff       	jmp    164a <printf+0xea>
    16df:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16e2:	83 ec 04             	sub    $0x4,%esp
    16e5:	8b 03                	mov    (%ebx),%eax
    16e7:	6a 01                	push   $0x1
    16e9:	88 45 e4             	mov    %al,-0x1c(%ebp)
    16ec:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    16ef:	50                   	push   %eax
    16f0:	57                   	push   %edi
    16f1:	e8 2c fd ff ff       	call   1422 <write>
    16f6:	e9 5b ff ff ff       	jmp    1656 <printf+0xf6>
    16fb:	66 90                	xchg   %ax,%ax
    16fd:	66 90                	xchg   %ax,%ax
    16ff:	90                   	nop

00001700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1701:	a1 24 1c 00 00       	mov    0x1c24,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1706:	89 e5                	mov    %esp,%ebp
    1708:	57                   	push   %edi
    1709:	56                   	push   %esi
    170a:	53                   	push   %ebx
    170b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    170e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1710:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1713:	39 c8                	cmp    %ecx,%eax
    1715:	73 19                	jae    1730 <free+0x30>
    1717:	89 f6                	mov    %esi,%esi
    1719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1720:	39 d1                	cmp    %edx,%ecx
    1722:	72 1c                	jb     1740 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1724:	39 d0                	cmp    %edx,%eax
    1726:	73 18                	jae    1740 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    1728:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    172a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    172c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    172e:	72 f0                	jb     1720 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1730:	39 d0                	cmp    %edx,%eax
    1732:	72 f4                	jb     1728 <free+0x28>
    1734:	39 d1                	cmp    %edx,%ecx
    1736:	73 f0                	jae    1728 <free+0x28>
    1738:	90                   	nop
    1739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    1740:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1743:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1746:	39 d7                	cmp    %edx,%edi
    1748:	74 19                	je     1763 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    174a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    174d:	8b 50 04             	mov    0x4(%eax),%edx
    1750:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1753:	39 f1                	cmp    %esi,%ecx
    1755:	74 23                	je     177a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1757:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1759:	a3 24 1c 00 00       	mov    %eax,0x1c24
}
    175e:	5b                   	pop    %ebx
    175f:	5e                   	pop    %esi
    1760:	5f                   	pop    %edi
    1761:	5d                   	pop    %ebp
    1762:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1763:	03 72 04             	add    0x4(%edx),%esi
    1766:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1769:	8b 10                	mov    (%eax),%edx
    176b:	8b 12                	mov    (%edx),%edx
    176d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1770:	8b 50 04             	mov    0x4(%eax),%edx
    1773:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1776:	39 f1                	cmp    %esi,%ecx
    1778:	75 dd                	jne    1757 <free+0x57>
    p->s.size += bp->s.size;
    177a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    177d:	a3 24 1c 00 00       	mov    %eax,0x1c24
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1782:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1785:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1788:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    178a:	5b                   	pop    %ebx
    178b:	5e                   	pop    %esi
    178c:	5f                   	pop    %edi
    178d:	5d                   	pop    %ebp
    178e:	c3                   	ret    
    178f:	90                   	nop

00001790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1790:	55                   	push   %ebp
    1791:	89 e5                	mov    %esp,%ebp
    1793:	57                   	push   %edi
    1794:	56                   	push   %esi
    1795:	53                   	push   %ebx
    1796:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1799:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    179c:	8b 15 24 1c 00 00    	mov    0x1c24,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17a2:	8d 78 07             	lea    0x7(%eax),%edi
    17a5:	c1 ef 03             	shr    $0x3,%edi
    17a8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    17ab:	85 d2                	test   %edx,%edx
    17ad:	0f 84 a3 00 00 00    	je     1856 <malloc+0xc6>
    17b3:	8b 02                	mov    (%edx),%eax
    17b5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    17b8:	39 cf                	cmp    %ecx,%edi
    17ba:	76 74                	jbe    1830 <malloc+0xa0>
    17bc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    17c2:	be 00 10 00 00       	mov    $0x1000,%esi
    17c7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    17ce:	0f 43 f7             	cmovae %edi,%esi
    17d1:	ba 00 80 00 00       	mov    $0x8000,%edx
    17d6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    17dc:	0f 46 da             	cmovbe %edx,%ebx
    17df:	eb 10                	jmp    17f1 <malloc+0x61>
    17e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    17ea:	8b 48 04             	mov    0x4(%eax),%ecx
    17ed:	39 cf                	cmp    %ecx,%edi
    17ef:	76 3f                	jbe    1830 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    17f1:	39 05 24 1c 00 00    	cmp    %eax,0x1c24
    17f7:	89 c2                	mov    %eax,%edx
    17f9:	75 ed                	jne    17e8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    17fb:	83 ec 0c             	sub    $0xc,%esp
    17fe:	53                   	push   %ebx
    17ff:	e8 86 fc ff ff       	call   148a <sbrk>
  if(p == (char*)-1)
    1804:	83 c4 10             	add    $0x10,%esp
    1807:	83 f8 ff             	cmp    $0xffffffff,%eax
    180a:	74 1c                	je     1828 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    180c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    180f:	83 ec 0c             	sub    $0xc,%esp
    1812:	83 c0 08             	add    $0x8,%eax
    1815:	50                   	push   %eax
    1816:	e8 e5 fe ff ff       	call   1700 <free>
  return freep;
    181b:	8b 15 24 1c 00 00    	mov    0x1c24,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    1821:	83 c4 10             	add    $0x10,%esp
    1824:	85 d2                	test   %edx,%edx
    1826:	75 c0                	jne    17e8 <malloc+0x58>
        return 0;
    1828:	31 c0                	xor    %eax,%eax
    182a:	eb 1c                	jmp    1848 <malloc+0xb8>
    182c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1830:	39 cf                	cmp    %ecx,%edi
    1832:	74 1c                	je     1850 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1834:	29 f9                	sub    %edi,%ecx
    1836:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1839:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    183c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    183f:	89 15 24 1c 00 00    	mov    %edx,0x1c24
      return (void*)(p + 1);
    1845:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1848:	8d 65 f4             	lea    -0xc(%ebp),%esp
    184b:	5b                   	pop    %ebx
    184c:	5e                   	pop    %esi
    184d:	5f                   	pop    %edi
    184e:	5d                   	pop    %ebp
    184f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1850:	8b 08                	mov    (%eax),%ecx
    1852:	89 0a                	mov    %ecx,(%edx)
    1854:	eb e9                	jmp    183f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1856:	c7 05 24 1c 00 00 28 	movl   $0x1c28,0x1c24
    185d:	1c 00 00 
    1860:	c7 05 28 1c 00 00 28 	movl   $0x1c28,0x1c28
    1867:	1c 00 00 
    base.s.size = 0;
    186a:	b8 28 1c 00 00       	mov    $0x1c28,%eax
    186f:	c7 05 2c 1c 00 00 00 	movl   $0x0,0x1c2c
    1876:	00 00 00 
    1879:	e9 3e ff ff ff       	jmp    17bc <malloc+0x2c>
