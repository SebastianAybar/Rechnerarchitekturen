.data
# Eingabeaufforderung
prompt:	.asciiz "Gib eine Zahl zwischen 1 und 3999 ein: "


# Römische Zahlentabelle – Integerwerte
values: .word 1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1
symbols: M,CM, D, CD, C, XC, L, XL, X, IX, V, IV, I

# Römische Symboltabelle – Null-terminierte Strings

            M:.asciiz "M"
            CM:.asciiz "CM"
            D:.asciiz "D"
            CD:.asciiz "CD"
            C:.asciiz "C"
            XC:.asciiz "XC"
            L:.asciiz "L"
            XL:.asciiz "XL"
            X:.asciiz "X"
            IX:.asciiz "IX"
            V:.asciiz "V"
            IV:.asciiz "IV"
            I:.asciiz "I"
            

.text
.globl main

main:
# Eingabeaufforderung ausgeben
li $v0, 4
la $a0, prompt
syscall


# String in Integer umwandeln
li $v0, 5
syscall
move $t0, $v0

# Zeiger vorbereiten
la $t1, values
la $t2, symbols


li $t4, 13 # sizeOf(Values)
li $t5, 0  # der aktuelle Index i

# Hier beginnt der Kern
loop:
beq $t5, $t4, done # Wenn i == 13 sind wir fertig
lw $t6, 0($t1) # Ansonsten Speichern wir den aktuellen Value in temp6
lw $t7, 0($t2)

repeat:
blt $t6, $t0, next
sub $t0, $t0, $t6

li $v0, 4
move $a0, $t7
syscall

j repeat


next:
addiu $t1, $t1, 4
addiu $t2, $t2, 4

done:
li $v0, 10
syscall


























