.data
	
	emptyErrorMessage: .asciiz "Input is empty."
	lengthErrorMessage: .asciiz "Input is too long."
	baseErrorMessage: .asciiz "Invalid base-29 number."
	userInput: .space 60

.text

	main:
		li $v0, 8
		la $a0, userInput
		li $a1, 60
		syscall

		removeLeadingSpace:
		li $t8, 32
		lb $t9, 0($a0)
		beq $t8, $t9, removeFirst
		move $t9, $a0
		j checkLength

		checkLength:
		addi $t0, $t0, 0
		addi $t1, $t1, 10
		add $t4, $t4, $a0

		lengthLoop:
		lb $t2, 0($a0)
		beqz $t2, done
		addi $a0, $a0, 1
		addi $t0, $t0, 1
		j lengthLoop

		done:
		beqz $t0, nullError
		slti $t3, $t0, 5
		beqz $t3, lengthError
		move $a0, $t4
		j checkString

		emptyError:
		li $v0, 4
		la $a0, emptyErrorMessage
		syscall
		j exit

		lengthError:
		li $v0, 4
		la $a0, lengthErrorMessage
		syscall
		j exit 

		checkString:
		lb $t5, 0($a0)
		beqz $t5, conversionInitializations
		beq $t5, $t1, conversionInitializations
		slti $t6, $t5, 48
		bne $t6, $zero, baseError
		slti $t6, $t5, 58
		bne $t6, $zero, Increment
		slti $t6, $t5, 65
		bne $t6, $zero, baseError
		slti, $t6, $t5, 89
		bne $t6, $zero, Increment
		slti $t6, $t5,97
		bne $t6, $zero, baseError
		slti $t6, $t5,121
		bne $t6, $zero, Increment
		bgt $t5, 120, baseError

		Increment:
		addi $a0, $a0, 1
		j checkString

		baseError:
		li $v0, 4
		la $a0, baseErrorMessage
		syscall
		j exit

		conversionInitializations:
		move $a0, $t4
		addi $t7, $t7, 0
		add $s0, $s0, $t0
		addi $s0, $s0, -1
		li $s3, 3
		li $s2, 2
		li $s1, 1
		li $s5, 0

		comvertString:
		lb $s4, 0($a0)
		beqz $s4, displaySum
		beq $s4, $t1, displaySum
		slti $t6, $s4, 58
		bne $t6, $zero, zeroToNine
		slti $t6, $s4, 89
		bne $t6, $zero, AToX
		slti $t6, $s4, 121
		bne $t6, $zero, aTox

		zeroToNine:
		addi $s4, $s4, -48
		j nextStep

		AToX:
		addi $s4, $s4, -55
		j nextStep

		aTox:
		addi $s4, $s4, -87

		nextStep:
		beq $s0, $s3, threePower
		beq $s0, $s2, twoPower
		beq $s0, $s1, onePower
		beq $s0, $s5, zeroPower

		threePower:
		li $s6, 24389
		mult $s4, $s6
		mflo $s7
		add $t7, $t7, $s7
		addi $s0, $s0, -1
		addi $a0, $a0, 1
		j convertString

		twoPower:
		li $s6, 841
		mult $s4, $s6
		mflo $s7
		add $t7, $t7, $s7
		addi $s0, $s0, -1
		addi $a0, $a0, 1
		j convertString

		onePower:
		li $s6, 29
		mult $s4, $s6
		mflo $s7
		add $t7, $t7, $s7
		addi $s0, $s0, -1
		addi $a0, $a0, 1
		j convertString

		zeroPower:
		li $s6, 1
		mult $s4, $s6
		mflo $s7
		add $t7, $t7, $t7

		displaySum:
		li $v0, 1
		move $a0, $t7
		syscall

		exit:
		li $v0, 10
		syscall















