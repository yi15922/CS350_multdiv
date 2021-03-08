# README

The multdiv unit uses the modified Booth algorithm for the multiplier and the non-restoring division circuits. 

## Multiplier: 
* This uses a modified register that holds 65 bits, including the extra multiplier bit at the end that always starts with 0. 
* The multiplier checks for overflow by checking if the upper 32 bits of the raw product are equal. 
* The multiplier also checks for unary overflow by checking the result. 

## Divider: 
* The divider uses the non-restoring algorithm, and the value that comes out of the register is shifted at the beginning of each clock cycle rather than the end. 
* The divider raises exception when dividing by zero 
* The divider makes sign corrections by using XOR to check if the answer should be negative, then it complements any negative inputs to positive to do the calculation. When the result is ready, it complements the result as necessary. The complement circuit was made using an adder. 

## Control Circuit
* The control circuits for mult and div are quite similar, and could probably be refactored into a single one given more time. They originally use ALUs to increment and detect when the correct number of cycles has been reached, however that approach was not idea performance wise. Therefore, I updated them so that they only use one adder and check for reaching a certain value using logic gates, which is more efficient. 

## multdiv Module
* The module simply holds instances of the mult module and div module, taking both their answers and using the control inputs to determine which output to use. Since the control inputs are only asserted for 1 clock cycle, a DFF is used to remember whether mult or div is needed. The write enable of of the DFF is set to the OR of the mult and div control signals, which means that if either of them changes, the output value of the DFF will change, signalling an interrupt. 