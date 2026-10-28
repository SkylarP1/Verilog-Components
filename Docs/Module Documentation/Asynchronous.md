# Asynchronous

## c_param

### Description
`c_param` is a parameterized module used in asynchronous computing, commonly known as the Muller  when all inputs are `0`, it outputs `0`. When all inputs are `1`, it outputs `1`. Otherwise the output is it's held from it's previous state.

---

### Using the Module

#### Truth Table
For a C-element with a FAN_IN of 2:
| x_1 | x_2 | y |
| :--- | :--- | :--- |
| `0` | `0` | `0` |
| `0` | `1` | `y_prev` |
| `1` | `0` | `y_prev` |
| `1` | `1` | `1` |

#### Parameters
| Parameter | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `4` | Defines how many c elements there are |
| `FAN_IN` | `2` | Defines how many inputs each c element has |

#### Inputs
| Port | Bitwidth | Depth | Description |
| :--- | :---: | :--- | :--- |
| `x` | `FAN_IN` | `WIDTH` | Inputs for each c-element. `WIDTH` determines how many elements the module has, and `FAN_IN` determines how many inputs each element has. When flat, `x` would have slices of `FAN_IN` width. |

#### Outputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `y` | `WIDTH` | Combinational output of `X`, each bit of `y` is the output of each C-element |

#### Notes
* For higher `FAN_IN`, there are still only two input configurations where the state of `y` will change, other combinations will continue to hold the previous state.
* `x` is a 2d input, columns are defined by `FAN_IN`, rows are defined by `WIDTH`

---

### Instantiation Example
```SystemVerilog
c_param #(
    .WIDTH(2),
    .FAN_IN(2)
)uut(
    .x  (x),
    .y  (y)
);
```

### Timing Diagram
![C Element Timing Diagram](/Docs/Timing%20Graphs/C%20Element%20Param%20Timing%20Graph.png)

*Figure 1: `c_param` (`WIDTH` = `2`, `FAN_IN` = `2`) output for each combination, both counting up and down*