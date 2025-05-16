.data
prompt:     .asciiz "Geben Sie ein Jahr ein: "
yes_msg:    .asciiz "JA\n"
no_msg:     .asciiz "NEIN\n"

.text
.globl main

main:
# Eingabeaufforderung anzeigen
#
li $v0, 4 # bereitet Systemaufruf zum print einer Zeichenkette vor
la $a0, prompt # läd prompt in die Adresse a0 
syscall

# Jahr einlesen
li $v0, 5 # 5 liest Ganzzahl ein
syscall
move $t0, $v0 # wir schieben den eingelesenen Wert in eine temp adresse

# Prüfe ob durch 4 teilbar
li $t1, 4 # liest den wert 4 in temp1
div $t0, $t1 # eingelesener Wert / 4 
mfhi $t2     # Rest in temp2
bnez $t2, not_leap  # Wenn t2 != 0

# Prüfe ob durch 100 teilbar
li $t1, 100 # überschreibt den wert in temp 1 mit 100
div $t0, $t1 # test ob durch 100 teilbar
mfhi $t2  # Rest in t2
bnez $t2, is_leap # wenn nicht durch 100 teilbar ist es ein Schaltjahr  

# Falls es durch 100 teilbar war, kann es jetzt nur noch 
# ein Schaltjahr sein wenn es durch 400 teilbar ist
li $t1, 400 
div $t0, $t1
mfhi $t2
beqz $t2, is_leap 
j not_leap

# Ausgabe für Schaltjahr
is_leap:
li $v0, 4
la $a0, yes_msg
syscall
j exit

# Ausgabe für kein Schaltjahr
not_leap:
li $v0, 4
la $a0, no_msg # es wird einfach eine Zeichenkette ausgegeben
syscall

exit:
li $v0, 10
syscall
