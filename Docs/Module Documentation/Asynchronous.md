# Asynchronous

## c_param

### Description
`c_param` is a parameterized module used in asynchronous computing, commonly known as the Muller C-Element. When all inputs are `0`, it outputs `0`. When all inputs are `1`, it outputs `1`. Otherwise the output is it's held from it's previous state.

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

---

## ds_wire

### Description
`ds_wire` is a parameterized module for asynchronous computing that allows for converting from duel-wire communication to single-wire. Duel-wire allows for better reliability in communication, less prone to instable connection errors and external interferance.

---

### Using the Module

#### Truth Table
| x_1 | x_2 | y | y_hat | no | invalid |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `0` | `0` | `0` | `0` | `1` | `0` |
| `0` | `1` | `0` | `1` | `0` | `0` |
| `1` | `0` | `1` | `0` | `0` | `0` |
| `1` | `1` | `0` | `0` | `0` | `1` |

#### Parameters
| Parameter | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `4` | Defines how many duel-wire pairs there are and how many single-wire outputs there are |

#### Inputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `x` | `WIDTH * 2` | Input Duel-Wire lines |

#### Outputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `y` | `WIDTH` | Single-wire `HIGH` output |
| `y_hat` | `WIDTH` | Single-wire `LOW` output |
| `no` | `WIDTH` | No input, line pairs are `00` |
| `invalid` | `WIDTH` | Invalid input, line pairs are `11` |

#### Notes

---

### Instantiation Example
```SystemVerilog
ds_wire #(
    .WIDTH  (2)
)uut(
    .x      (x),
    .y      (y),
    .y_hat  (y_hat),
    .no   (no),
    .invalid(invalid)
);
```

### Timing Diagram
![ds_wire Timing Diagram](/Docs/Timing%20Graphs/DS%20Wire%20Timing%20Graph.png)

*Figure 1: `ds_wire` (`WIDTH` = `2`) each bit getting tested for each state `00`, `01`, `10`, `11`*

---

## sd_wire

### Description
`sd_wire` is a parameterized module for asynchronous computing that allows for converting from single-wire communication to duel-wire. See ds_wire for more information on duel wire

---

### Using the Module

#### Truth Table
| x | y_1 | y_2 |
| :--- | :--- | :--- |
| `0` | `0` | `1` |
| `1` | `1` | `0` |

#### Parameters
| Parameter | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `4` | Defines how many single-wire pairs there are and how many duel-wire outputs there are |

#### Inputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `x` | `WIDTH` | Input Single-Wire lines |

#### Outputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `y` | `WIDTH * 2` | Duel-wire output |

#### Notes
*since `00` and `11` are only parity states meant for duel-wire native to duel-wire communication, they do not need to be accounted for here

---

### Instantiation Example
```SystemVerilog
sd_wire #(
    .WIDTH  (4)
)uut(
    .x      (x),
    .y      (y),
);
```

### Timing Diagram
![sd_wire Timing Diagram](/Docs/Timing%20Graphs/SD%20Wire%20Timing%20Graph.png)

*Figure 1: `sd_wire` (`WIDTH` = `4`) testing to see if each single-wire bit properly gets swapped to either `01` or `10`*

---

## async_reg

### Description
`async_reg` is a parameterized register that operates asynchronously using duel-wire for the control lines. 
---

### Using the Module

#### Parameters
| Parameter | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `4` | How many duel-wire bit pairs there are, in other words how many true bits there are |

#### Inputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `data_in` | `WIDTH*2` | Data to load, in duel-wire |
| `w_en` | `2` | Load `data_in` when `TRUE HIGH`, uses duel-wire |
| `r_en` | `2` | Enables `data_out` when `TRUE HIGH`, uses duel-wire, `data_out` `0` when not enabled |
| `rst` | `2` | Reset when `TRUE HIGH` |

#### Outputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `data_in` | `WIDTH*2` | Data output in duel-wire |
| `written` | `2` | `TRUE HIGH` when internal register has no `null` duel-wire bits |

#### Notes
* `w_en` resets internal register when enabled to prevent issues with `written`
* For a reminder, `TRUE HIGH` refers to `10`, `TRUE LOW` refers to `01`. When labeled true, it refers to the single-wire equivalent
*Each control line must be set to `TRUE LOW` before it can be used and set `TRUE HIGH`, this is to help prevent interferance causing unwanted line enables
*`rst`, `w_en`, `r_en` can all be done at once, `rst` comes first, then `w_en`, then finally `r_en`

---

### Instantiation Example
```SystemVerilog
async_reg #(
    .WIDTH      (4)
)uut(
    .data_in    (data_in),
    .w_en       (w_en),
    .rst        (rst),
    .r_en       (r_en),
    .data_out   (data_out),
    .written    (written)
);
```

### Timing Diagram
![Async reg Timing Diagram](/Docs/Timing%20Graphs/Asynchronous%20Register%20Timing%20Graph.png)

*Figure 1: `async_reg` (`WIDTH` = `4`) being written with, in single-wire `0011` to test internal latches, then `1100` to test `w_en`'s reset.*

---