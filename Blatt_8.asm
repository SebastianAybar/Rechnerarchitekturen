.data

# Eingabeaufforderung
prompt:	.asciiz "Gib eine Zahl zwischen 1 und 3999 ein: "


# Roemische Zahlentabelle als Integerwerte
values: .word 1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1
symbols: .word M,CM, D, CD, C, XC, L, XL, X, IX, V, IV, I

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


# Eingabeaufforderung ausgeben
li $v0, 4
la $a0, prompt
syscall	


# String als Integer einlesen
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
beq $t5, $t4, done      # Wenn i == 13 sind wir fertig
lw $t6, 0($t1)          # Aktuellen Wert laden
lw $t7, 0($t2)          # Aktuelle String-Adresse laden
    
repeat:
blt $t0, $t6, next      # Wenn zahl < wert, zum nächsten
sub $t0, $t0, $t6       # zahl -= wert
li $v0, 4
move $a0, $t7
syscall
j repeat
    
next:
addiu $t1, $t1, 4       # Zum nächsten Wert
addiu $t2, $t2, 4       # Zur nächsten String-Adresse  
addiu $t5, $t5, 1       # Index erhöhen!
j loop                  # Zurück zum Loop-Anfang

done:
# Programm beenden

