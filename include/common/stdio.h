#ifndef STDIO_H
#define STDIO_H

char getc(void);
void putc(char c);

void puts(const char * s);
void gets(char * buf, int buflen);

#endif