# Combined Definitions for the ALU Components Section
## Logical Unit
### Description
The Logical Unit is a parameterized module that acts as the logical unit in an ALU, allowing for the following functions:
* A and B
* A or B
* A xor B
* A nand B
* A nor B
* A xnor B
* not A
* not B
### Using the module
Its parameters and I/O are defined as follows:
#### Parameters
* BITS
    * Defines bitwidth of A along with B
#### Inputs
* a, 
    * Input A, bitwidth defined by parameter BITS
* b
    * Input B, bitwidth defined by parameter BITS
* opcode
    * Selects the operation for the unit to complete, bitwidth of 3
    | Opcode | Operation |
    |--------|-----------|
    | 000    | AND       |
    | 001    | OR        |
    | 010    | XOR       |
    | 011    | NAND      |
    | 100    | NOR       |
    | 101    | XNOR      |
    | 110    | NOT A     |
    | 111    | NOT B     |

#### Outputs
* out
    * Output of selected operation, bitwidth defined by parameter BITS

### Instantiation Example
```verilog
logical_unit #(
    .BITS(16)
) u_alu_logic (
    .a     (data_a),
    .b     (data_b),
    .opcode(ctrl_op),
    .out   (logic_res)
);
```