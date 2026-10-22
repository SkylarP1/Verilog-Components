# Combined Definitions for the ALU Components Section
## Logical Unit
### Description
The Logical Unit is a paramatarized module that acts as the logical unit in an ALU, allowing for the following functions:
* A and B
* A or B
* A xor B
* A nand B
* A nor B
* A xnor B
* not A
* not B
### Using the module
It's paramaters and I/O are defined as follows:
#### Paramaters
* BITS
    * Defines bitwidth of A along with B
#### Inputs
* a, 
    * Input A, bitwidth defined by paramater BITS
* b
    * Input B, bitwidth defined by paramater BITS
* opcode
    * Selects the operation for the unit to complete, bitwidth of 3
    * Selections
        * **000:** AND,
        * **001:** OR,
        * **010:** XOR,
        * **011:** NAND,
        * **100:** NOR,
        * **101:** XNOR,
        * **110:** NOT A,
        * **111:** NOT B
        * **DEFAULT:** AND

#### Outputs
* out
    * Output of selected operation, bitwidth defined by parameter BITS

