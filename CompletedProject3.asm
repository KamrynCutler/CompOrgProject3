.data
	
	#messages for user if input is invalid
	emptyErrorMessage: .asciiz "Input is empty."
	lengthErrorMessage: .asciiz "Input is too long."
	baseErrorMessage: .asciiz "Invalid base-29 number."
	userInput: .space 1000

.text

	main:
		li $v0, 8	#reads the string
		la $a0, userInput	#stores address of the string
		li $a1, 1000 #ceates space
		syscall
		add $t0, $zero, 0 #initializes register
		add $t1, $zero, 0 #initializes register

		la $t2, userInput #loads string address into register
		lb $t0, 0($t2)
		beq $t0, 10, isEmpty #sees if the string is empty
		beq $t0, 0 isEmpty

		addi $s0, $zero, 29 #stores base-n
		addi $t3, $0, 1 #initializes new registers
		addi $t5, $zero, 0

		