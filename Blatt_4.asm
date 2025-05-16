.data
prompt: .asciiz "Geben sie einen Integer ein: "
result_msg: .asciiz "Das Ergebnis lautet: "

# Eingabeaufforderung
li $v0, 4
la $a0, prompt
syscall

# Zahl einlesen
li $v0, 5
syscall 
move $t0, $v0

# Zähler initialisieren
li $t1, 0 # counter
li $t2, 0 # für die Summe

loop:
bgt $t1, $t0, end_loop
# Summe = Summe + i
add $t2, $t2, $t1
# Counter = Counter +1
addi $t1, $t1, 1
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


