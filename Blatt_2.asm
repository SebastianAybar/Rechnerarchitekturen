.data
prompt_a: asciiz "Seite a des Dreiecks: "
prompt_b: asciiz "Seite b des Dreiecks: "
prompt_ergebnis: asciiz "Hypothenuse^2: "

.text
.globl main

main:
# ----- Eingabe für a --------
li $v0, 4 # v0 ist das Register welches angibt welcher syscall aufgerufen werden soll (4 = String)
la $a0, prompt_a # a0 ist die Adresse des Strings welcher ausgegeben werden soll
syscall

# Einlesen der Eingabe
li $v0, 5 # 5 steht für Ganzzahl einlesen
syscall
move $t0, $v0 # Eingelesenen Wert in ein temporäres Register speichern

# ----- Eingabe für b --------
li $v0, 4
la $a0, prompt_b
syscall

# Einlesen der Eingabe
li $v0, 5
syscall
move $t1, $v0

# "syscall schaut in a0 (a1, a2, ...) und in v0 was zu tun ist"

# Rechnen
# a^2
mul $t2, $t0, $t0
# b^2
mul $t2, $t0, $t0
# c^2 = a^2 + b^2
add $t4, $t2, $t3

# Ausgabe des Ergebnisses
li $v0, 4
la $a0, result_msg
syscall

li $v0, 1
move $a0, $t4
syscall

# Programm beenden
li $v0, 10
syscall











