# ALU Components

## lu_param

### Description
`lu_param` is a parameterized module that allows for bitwise logic operations between inputs `a` and `b`, selected by `opcode`.

---

### Using the Module

#### Parameters
| Parameter | Default | Description |
| :--- | :--- | :--- |
| `BITS` | `8` | Defines bitwidth for `a`, `b`, and `out` |

#### Inputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `a` | `BITS` | Input `a` |
| `b` | `BITS` | Input `b` |
| `opcode` | `3` | Selects the operation for the unit to complete |

##### Opcode Mapping
| Opcode | Operation |
| :---: | :--- |
| `000` | AND |
| `001` | OR |
| `010` | XOR |
| `011` | NAND |
| `100` | NOR |
| `101` | XNOR |
| `110` | NOT `a` (`b` ignored) |
| `111` | NOT `b` (`a` ignored) |

#### Outputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `out` | `BITS` | Output of selected operation |

#### Notes
* All operations are bitwise: each bit of `out` depends only on the matching bits of `a` and `b`
* The module is combinational: `out` updates whenever `a`, `b`, or `opcode` changes
* All eight `opcode` values are defined

---

### Instantiation Example
```verilog
lu_param #(
    .BITS(16)
) u_alu_logic (
    .a      (data_a),
    .b      (data_b),
    .opcode (ctrl_op),
    .out    (logic_res)
);
```

### Timing Diagram
![Logical Unit Timing Diagram](/Docs/Timing%20Graphs/Logical%20Unit%20Param%20Timing%20Graph.png)

*Figure 1: `lu_param` (BITS = 16) output for each of the eight `opcode` values.*