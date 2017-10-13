global main
extern printf
extern scanf

section .data
first: db "Enter the first number in binary format:", 0xA, 0
second: db "Enter the second number in binary format:", 0xA, 0

fmtScanf: db "%s", 0
fmtPrintf: db "%s",0xA,0

fmtStr: db "output %d", 0xA, 0
badinput: db "Calculation entered is not one of the choices", 0xA, 0

calc: db "Enter the calculation to perform (add, sub, mul, div):", 0xA, 0
add: db "The result for %d + %d is:",0xA, 0
sub: db "The result for %d - %d is:",0xA, 0
mul: db "The result for %d * %d is:",0xA, 0
div: db "The result for %d / %d is:",0xA, 0
bin: db "binary = %d", 0xA, 0


section .bss
input: resb 33
input2: resb 33
output: resb 33
operation: resb 3

section .text
main:
push first
call printf
add esp, 4

sub esp, 4
mov [esp], dword  input
push fmtScanf
call scanf
add esp, 8


mov ecx, 32
mov esi, 0
xor ebx, ebx

mov al, byte [input+0]
cmp al, 48
je L1

dec ecx
inc esi


L1:
add ebx, ebx
mov al, byte [input + esi]
cmp al, 48

push ecx
push esi

je p0
jmp p1

p0:
jmp posend

p1:
mov eax, 1
add ebx, eax
jmp posend

posend:
pop esi
pop ecx

inc esi
loop L1

mov al, byte[input+0]
cmp al, 48
je pos


neg ebx
mov dword[input], dword 0
mov dword[input], dword ebx

jmp main2

pos:
mov dword[input], dword 0
mov dword[input], dword ebx

jmp main2

main2:
push second
call printf
add esp, 4

sub esp, 4
mov [esp], dword  input2
push fmtScanf
call scanf
add esp, 8

xor ecx, ecx
xor esi, esi
xor ebx, ebx
mov ecx, 32
mov esi, 0

mov al, byte [input2+0]
cmp al, 48
je L1.2

dec ecx
inc esi

L1.2:
add ebx, ebx
mov al, byte [input2 + esi]
cmp al, 48

push ecx
push esi

je p0.2
jmp p1.2

p0.2:
jmp posend.2

p1.2:
add ebx, 1
jmp posend.2

posend.2:
pop esi
pop ecx

inc esi
loop L1.2

mov al, byte[input2+0]
cmp al, 48
je pos.2

neg ebx
mov dword[input2], dword 0
mov dword[input2], ebx

jmp final

pos.2:
mov dword[input2], dword 0
mov dword[input2], ebx

jmp final

final:
push calc
call printf
add esp, 4

sub esp, 4
mov [esp], dword operation
push fmtScanf
call scanf
add esp, 8

cmp dword[operation], 'add'
je addres

cmp dword[operation], 'sub'
je subres

cmp dword[operation], 'mul'
je mulres

cmp dword[operation], 'div'
je divres

push badinput
call printf
add esp, 4
jmp exit

addres:
push dword[input2]
push dword[input]
push add
call printf
add esp, 12

xor ebx, ebx
mov ebx, dword[input]
add ebx, dword[input2]

push ebx
push bin
call printf
add esp, 8

ret

subres:
push dword[input2]
push dword[input]
push sub
call printf
add esp, 12

xor ebx, ebx
mov ebx, dword[input]
sub ebx, dword[input2]

mov esi, 0
mov ecx, 32

push ebx
push bin
call printf
add esp, 8

ret


mulres:
push dword[input2]
push dword[input]
push mul
call printf
add esp, 12

xor ebx, ebx
mov ebx, dword[input]
imul ebx, dword[input2]

push ebx
push bin
call printf
add esp, 8

ret

divres:
push dword[input2]
push dword[input]
push div
call printf
add esp, 12

xor ebx, ebx
xor eax, eax
xor edx, edx

mov ebx, dword[input]
mov eax, dword[input2]
idiv eax

push eax
push bin
call printf
add esp, 8

ret


exit:
ret
