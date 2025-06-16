.data
    prompt: .asciiz "Eingabe einer positiven Zahl n: "
    result: .asciiz "Fakultaet ist: "

.text
.globl main

main:
    # Eingabeaufforderung ausgeben
    li $v0, 4
    la $a0, prompt
    syscall

    # Zahl n einlesen (syscall 5)
    li $v0, 5
    syscall
    move $a0, $v0 # n in $a0 speichern (Argument fuer Fakultaet)

    # Fakultaet berechnen (rekursiv)
    jal fakulty # Jump to Fakultaet, save return address in $ra

    # Ergebnis ausgeben
    move $t0, $v0 # Ergebnis in $t0 sichern
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 1
    move $a0, $t0 # Fakultaet ausgeben
    syscall

    # Programm beenden
    li $v0, 10
    syscall

fakulty:
    # Prolog: Stack anpassen ($ra und $a0 sichern)
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)

    li $t0, 1
    ble $a0, $t0, base_case

    addi $a0, $a0, -1
    jal fakulty
    lw $a0, 0($sp)     # n wiederherstellen
    mul $v0, $a0, $v0  # n * fakulty(n - 1)

    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra

base_case:
    li $v0, 1
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra

    
    
    
    
