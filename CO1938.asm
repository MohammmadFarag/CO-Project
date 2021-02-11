.data

#mma part1
Paragraph: .space 100 #array of 100 bytes
searchfield: .space 10 #array of 10 bytes
Message1: .asciiz "Enter a Paragraph MAX 100 characters(End it with ENTER):\n"
Message2: .asciiz "\nChoose an operation\n(1)Search on a specific word/character\n(2)Extract a substring from a word\n(3)Join strings\n(4)Capitalize first letter in each word\n(5)Convert all characters in the paragraph to Lower/Upper case\n"
Message3: .asciiz "enter search field: "
Message4: .asciiz "found at index: "
newline: .asciiz "\n"

#ali part3
msg1: .asciiz "Type string 1: \n"
msg2: .asciiz "Type string 2: \n"
Paragraph2: .space 100

#mmh part 2
string: .space 10
substring: .space 10
start: .word 2
end: .word 2

subsmsg1: .asciiz "\nenter a string:"
subsmsg4: .asciiz "\nthe sub string is:"
subsmsg5: .asciiz "\nenter sub string start:"
subsmsg6: .asciiz "\nenter sub string end:"


#Hossam Part 5
M1: .asciiz "Select 1 For LowerCase OR 2 For UpperCase  :"
M2: .asciiz "\nONLY 1 OR 2 Available selection \nSelect 1 For LowerCase OR 2 For UpperCase "


.text
.globl main
main:

#print "enter paragraph" to screen
li $v0, 4
la $a0, Message1
syscall

#take text from keyboard
li $v0, 8
la $a0, Paragraph
li $a1, 100
syscall

#print "choose an operation" to screen
li $v0, 4
la $a0, Message2
syscall

#put values in temporary registers
li $t1, 1
li $t2, 2
li $t3, 3
li $t4, 4
li $t5, 5

#take choice from user
li $v0, 5
syscall
#move choice to temporary register
move $t0, $v0

#comparing choice with values
beq $t0, $t1, search
beq $t0, $t2, substringf
beq $t0, $t3, join
beq $t0, $t4, capitaliz
beq $t0, $t5, lowerupper

#end of main
li $v0, 10
syscall

search:

#print "enter searchfield"
li $v0, 4
la $a0, Message3
syscall

#take searchfield from user
li $v0, 8
la $a0, searchfield
li $a1, 10
syscall

#getting length of paragraph
la $a0, Paragraph
jal strlen
#print length of paragraph
#addi $a0 , $v0 ,0
#li $v0,1
#syscall
move $s0, $v0 #move paragraph length to temporary register

#getting length of searchfield
la $a0, searchfield
jal strlen
#print length of searchfield
#addi $a0 , $v0 ,0
#li $v0,1
#syscall
move $s1, $v0 #move searchfield length to temporary register

sub $s2, $s0 , $s1 #value in s2 = pglen - sflen

#print s2
#move $a0, $s2
#li $v0,1
#syscall

addi $s3, $0 , 0 # initialize i= 0
addi $s4, $0 , 0 # initialize j= 0

L1:
   beq $s3, $s2, exit1 # if i= pglen - sflens exit1
   addi $s5, $0 , 1 # initialize found= 1
   L2:
      beq $s4, $s1, exit2 #if j=sflen exit2
      add $s6, $s3, $s4 # i + j
      lbu $t0, Paragraph($s6)
      lbu $t1, searchfield($s4)
      beq $t0, $t1, exit2#(paragraph[i + j] != searchfield[j])
      move $s5, $0 #found = 0
      jal exit2
      
      addi $s4, $s4 , 1 # j++
   j L2

   
   
   exit2:
   beq $s5, $0,exit3 #if found ==0
   #print %s, searchfield
   li $v0, 4
   la $a0, searchfield 
   syscall
   #print message 4
   li $v0, 4
   la $a0, Message4
   syscall
   #print %d, i
   move $a0, $s3
   li $v0, 1
   syscall
   #print newline
   li $v0, 4
   la $a0, newline
   syscall
   
   exit3:
   addi $s3, $s3 , 1 # i++
j L1
 
exit1:
#exit program
li $v0,10
syscall




strlen: #int strlen (char * string)
addi $t0, $0 , 0 # int length=0
loop:
lbu $t2, 0($a0) #load first byte of string in temporary register
beq $t2, $0 , finish #if byte = 0 then finish, otherwise continue loop
addi $a0, $a0,1 # next byte
addi $t0, $t0,1 # length++
j loop

finish:
add $v0, $t0 , $0 #return length
jr $ra #jump back









substringf:
#first message
li $v0,4
la $a0,subsmsg1
syscall
#scanning the string
li $v0,8
la $a0,string
la $a1,10
syscall

#print enter substring start
li $v0,4
la $a0,subsmsg5
syscall

#scan substring start from user
li $v0,5
syscall
sw $v0, start 


#print enter substring end
li $v0,4
la $a0,subsmsg6
syscall

#scan substring end from user
li $v0,5
syscall
sw $v0, end

#clearing the $v0
li $v0,0
#substring counter
li $t3,0

subsloop:
lw $t0,start#get the start value to $t0
la $a0,string#load the string start address at $a0
add $a0,$a0,$t0#move the string pointer to a specific position
la $a1,substring#load the substring start address
add $a1,$a1,$t3#move the sub string pointer to a specific position
lb $t1,0($a0)#get the current character from the string
sb $t1,0($a1)#store that current character in the sub string current position
addi $t0,$t0,1#increase the start value with 1
sw $t0,start#store the increased start value at the start address
addi $t3,$t3,1#increase the substring pointer with 1
lw $t2,end#get the end variable value for compairing
beq $t0,$t2,subsexit#compaire the start and end values and if they are with same values then get out of the loop
j subsloop#restart the loop

subsexit:
#fourth message
li $v0,4
la $a0,subsmsg4
syscall
#print the substring
li $v0,4
la $a0,substring
syscall
#exit program
li $v0,10
syscall







join:
li $v0 , 4
la $a0 , msg1
syscall

li $v0 , 8
la $a0 , Paragraph2
la $a1 , 100
syscall

li $v0 , 4
la $a0 , msg2
syscall

li $t0 , 0
la $a0 , Paragraph2
loop2:
lb $t1, 0($a0) # load the next character into t1
beqz $t1, exit # check for the null character
addi $a0, $a0, 1 # increment the string pointer
addi $t0, $t0, 1 # increment the count
j loop2 # return to the top of the loop
exit:
li $v0 , 8
la $a0 , Paragraph2($t0)
la $a1 , 100
syscall

li $v0 , 4
la $a0 , Paragraph2($zero)
syscall


li $v0, 10		#Terminate Execution
syscall
########################################################
#part 4
capitaliz:

addi $s0,$s0,0 #t0=0 index of paragraph

checker: #begin of word

lb $t2, Paragraph($s0) # t2 =paragraph[t0] 
beq $t2,' ',afterspace
bge $t2,'a', conv # if small
blt $t2,'a', cont # if capital 


l00p: #enter only when t0 >1

lb $t2, Paragraph($s0)

beq $t2,0,Endit  #[end of paragraph]
bne $t2,' ',cont # char != space (space value in ascii = 32)
beq $t2,' ',afterspace #char == space (space value in ascii = 32)

cont: #next char
addi $s0, $s0, 1 #t0++
    j l00p
    
    
conv: #convert from lower to upper 
sub $t2, $t2, 32 # ascii code -32 from char to transform it to upper 
sb  $t2, Paragraph($s0) 
    j checker

afterspace:
addi $s0, $s0, 1 #t0++
j checker

Endit: #terminator
 li $v0, 4
    la $a0, Paragraph
    syscall
li $v0, 10
    syscall

############################################################################

lowerupper: #case 5
addi $s0,$s0,1 #s0 = 1
addi $s1,$s1,2 #s1 = 2
#print "Select 1 For LowerCase OR 2 For UpperCase"
li $v0, 4
la $a0, M1
syscall

input2:
#take 1 or 2 from user
li $v0, 5
syscall

#Store value in $t0
move $t0,$v0

# n>2 || n<1
addi $s2,$0 ,0
bgt $t0,$s1,Loop1 #n>2
blt $t0,$s0,Loop1 #n>1
beq $t0,$s0,tolower ## exist if user enter 1
beq $t0,$s1,toupper ## exist if user enter 2

Loop1:
#print "\nONLY 1 OR 2 Available selection \nSelect 1 For LowerCase OR 2 For UpperCase "
li $v0, 4
la $a0, M2
syscall
jal input2

#take 1 or 2 from user
li $v0, 5
syscall

tolower: # if t0 = 1
lp0: #loop to every char in paragraph
    lbu $t1, Paragraph($s2) #load pargraph into t1
    beq $t1, $0, END0
    blt $t1, 'A', CASE0
    bgt $t1, 'Z', CASE0 #all char > Z is in Lower
    add $t1, $t1, 32 # ascii code +32 from char to transform it to lower from upper
    sb $t1, Paragraph($s2)

CASE0:  # no change move to next char 
    addi $s2, $s2, 1
    j lp0

END0: # end
    li $v0, 4
    la $a0, Paragraph
    syscall

    li $v0, 10
    syscall

toupper: # if t0 = 2 
lp: #loop to every char in paragraph
    lb $t1, Paragraph($s2)
    beq $t1, 0, EnD #if reached end of paragraph
    blt $t1, 'a', CasE # all char < a is in UPPER 
    bgt $t1, 'z', CasE 
    sub $t1, $t1, 32 # ascii code -32 from char to transform it to upper lower
    sb $t1, Paragraph($s2) 

CasE:  #move to next char
    addi $s2, $s2, 1 #s2++
    j lp 

EnD:
    li $v0, 4
    la $a0, Paragraph
    syscall

    li $v0, 10
    syscall

#part 4 





