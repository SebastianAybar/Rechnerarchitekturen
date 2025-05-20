.data
prompt: .asciiz "Geben sie einen Integer ein: "
result_msg: .asciiz "Das Ergebnis lautet: "

# Eingabeaufforderung
li $v0, 4
la $a0, prompt
syscall


# Zahl einlesen
li $v0, 5 # 5 liest Ganzzahl ein
syscall
move $t0, $v0 # wir schieben den eingelesenen Wert in eine temp adresse

# Zaehler initialisieren
li $t1, 0 # counter
li $t2, 0 # fuer die Summe

loop:
bgt $t1, $t0, end_loop

#Berechnung
remu $t3, $t1, 2  # Den Rest von $t1 / 2 in $t3 speichern
bne $t3, $zero, skip

# Wenn die Zahl gerade war addieren wir i auf das Ergebnis
add $t2, $t2, $t1

skip:
addi $t1, $t1, 1  # Wir machen zwar nichts aber wir müssen den Counter erhöhen

j loop


end_loop:
li $v0, 4
la $a0, result_msg
syscall 

li $v0, 1 # syscall: print_int
move $a0, $t2 # muss in a0 schieben, was er printen soll
syscall 
#Porgramm innerhalb der Loop beenden
li $v0, 10
syscall



