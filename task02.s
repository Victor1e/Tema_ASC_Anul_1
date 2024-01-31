.data
matrice_initiala: .space  1800
matrice_finala: .space 1800

n: .space 4
m: .space 4
p: .space 4
k: .space 4
var: .space 4

index: .space 4

line: .space 4
column: .space 4

lineindex: .space 4
columnindex: .space 4
indexk: .space 4

sum: .space 4

formatScanf: .asciz "%ld"
formatPrintf: .asciz "%ld "
newline: .asciz "\n"

read: .asciz "r"
write: .asciz "w"
fin: .asciz "in.txt"
fout: .asciz "out.txt"



.text
.global main
main:
/*
pushl stdin
pushl $read
pushl $fin
call freopen
popl %ebx
popl %ebx
popl %ebx


pushl stdout
pushl $write
pushl $fout
call freopen
popl %ebx
popl %ebx
popl %ebx
*/


pushl $m
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

pushl $n
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

pushl $p
pushl $formatScanf
call scanf
popl %ebx
popl %ebx
// am citit m, n, p

movl n, %eax
addl $2, %eax
movl %eax, var
xor %eax, %eax
incl n
incl m

movl $0, index
for_cel_vii:

movl index, %ecx
cmp %ecx, p
je gen_urm

pushl $line
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

pushl $column
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

addl $1, line
addl $1, column
movl line, %eax
xor %edx, %edx
mull var
addl column, %eax

lea matrice_initiala, %edi
movl $1, (%edi, %eax, 4)


incl index
jmp for_cel_vii




gen_urm:

pushl $k
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

movl k, %eax
cmp $0, %eax
je et_afis_mat
incl k
xor %eax, %eax

movl $1, indexk
for_k:
movl indexk, %ecx
cmp %ecx, k
je et_afis_mat

// facem matricea finala din pasul urmator

movl $1, lineindex
for_line:
movl lineindex, %ecx
cmp %ecx, m
je copiere_matrice

movl $1, columnindex
for_column:
movl columnindex, %ecx
cmp %ecx, n
je continuare_linia_urm


// facem suma vecinilor lui matrice_initiala[lineindex][columnindex]
movl $0, sum
xor %eax, %eax

// lineindex-1, columnindex-1
movl lineindex, %eax
subl $1, %eax
xor %edx, %edx
mull var
addl columnindex, %eax
subl $1, %eax
lea matrice_initiala, %edi
movl (%edi, %eax, 4),  %ebx
addl %ebx, sum


//lineindex-1, columnindex
addl $1, %eax
lea matrice_initiala, %edi
movl (%edi, %eax, 4), %ebx
addl %ebx, sum

//lineindex-1, columnindex+1
addl $1, %eax
lea matrice_initiala, %edi
movl (%edi, %eax, 4), %ebx
addl %ebx, sum

//lineindex, columnindex+1
addl var, %eax
lea matrice_initiala, %edi
movl (%edi, %eax, 4), %ebx
addl %ebx, sum

//lineindex, columnindex-1
subl $2, %eax
lea matrice_initiala, %edi
movl (%edi, %eax, 4), %ebx
addl %ebx, sum

//lineindex+1, columnindex-1
addl var, %eax
lea matrice_initiala, %edi
movl (%edi, %eax, 4), %ebx
addl %ebx, sum

//lineindex+1, columnindex
addl $1, %eax
lea matrice_initiala, %edi
movl (%edi, %eax, 4), %ebx
addl %ebx, sum

//lineindex+1, columnindex+1
addl $1, %eax
lea matrice_initiala, %edi
movl (%edi, %eax, 4), %ebx
addl %ebx, sum

subl $1, %eax
subl var, %eax

//acum suntem cu %eax pe pozitia lui matrice_initiala[lineindex][columnindex]

//verificam daca e vie sau nu
lea matrice_initiala, %edi
movl (%edi,%eax,4), %ebx
cmp $0, %ebx
je cel_moarta

cel_vie:

movl sum, %ebx
cmp $2, %ebx
je traieste
cmp $3, %ebx
je traieste
jmp continuare_coloana

cel_moarta:

movl sum, %ebx
cmp $3, %ebx
je traieste
jmp continuare_coloana

traieste:

lea matrice_finala, %esi
movl $1, (%esi, %eax, 4)



continuare_coloana:
incl columnindex
jmp for_column




continuare_linia_urm:

incl lineindex
jmp for_line



// copiem matricea finala in matricea initiala si trecem la pasul urmator din cei k pasi
copiere_matrice:

movl $1, lineindex
for_lines:
movl lineindex, %ecx
cmp %ecx, m
je continuare_k_urm

movl $1, columnindex
for_columns:
movl columnindex, %ecx
cmp %ecx,n
je cont_line

xor %eax, %eax
movl lineindex, %eax
xor %edx, %edx
mull var
addl columnindex, %eax
lea matrice_finala , %esi
movl (%esi, %eax, 4), %ebx
lea matrice_initiala, %edi
movl %ebx, (%edi, %eax, 4)
lea matrice_finala , %esi
movl $0, (%esi, %eax, 4) 


incl columnindex
jmp for_columns


cont_line:
incl lineindex
jmp for_lines





continuare_k_urm:
incl indexk
jmp for_k



// raspuns:

et_afis_mat:


movl $1, lineindex

for_lines1:

movl lineindex, %ecx
cmp %ecx,m
je et_exit
movl $1, columnindex

for_columns1:
movl columnindex,%ecx
cmp %ecx,n
je contin



movl lineindex, %eax
xor %edx, %edx
mull var
addl columnindex, %eax

lea matrice_initiala, %edi
movl (%edi,%eax,4), %ebx


pushl %ebx
pushl $formatPrintf
call printf
popl %ebx
popl %ebx

pushl $0
call fflush
popl %ebx


incl columnindex
jmp for_columns1


contin:
push $newline
call printf
pop %ebx

pushl $0
call fflush
popl %ebx


incl lineindex
jmp for_lines1



et_exit:

movl $1, %eax
movl $0, %ebx
int $0x80
