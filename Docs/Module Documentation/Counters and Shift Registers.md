# Counters and Shift Registers
## cnt_param
### Description
`cnt_param` is a parameterized up/down counter with parallel loading. Counting and loading happen synchronously while `rst` is asynchronous.

---

### Using the Module

#### Parameters
| Parameter | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `4` | Defines bitwidth of counting |

#### Inputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `clk` | `1` | Clock signal, rising edge |
| `rst` | `1` | Active-`HIGH` asynchronous reset. Sets `q` to 0 immediately, independent of `clk` |
| `en` | `1` | Enables the counter, enabled when `HIGH`, holds value in `q` when `LOW` |
| `dir`| `1` | When `HIGH`, count up, when `LOW`, count down |
| `load` | `1` | When `HIGH`, load `data_in` value on the next posedge from `clk` when `en` is `HIGH` |
| `data_in` | `WIDTH` | Parallel data loaded into the counter when `load` is `HIGH` |

#### Outputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `q` | `WIDTH` | Current counter value |
| `max` | `1` | Is `HIGH` when `q` is all ones |
| `min` | `1` | Is `HIGH` when `q` is all zeros | 

#### Notes
* `rst` takes priority over counting and loading
* Counting wraps on overflow and underflow (ex. `1111` -> `0000` counting up, `0000` -> `1111` counting down)
* `min`/`max` are combinational

---

### Instantiation Example
```verilog
cnt_param #(
    .WIDTH  (4)
) counter (
    .clk    (clk),
    .rst    (rst),
    .en     (en),
    .dir    (dir),
    .load   (load),
    .data_in(data_in),
    .q      (q),
    .max    (max),
    .min    (min)
);
```

### Timing Diagram
![Counter Timing Diagram](/Docs/Timing%20Graphs/Counter%20Param%20Timing%20Graph.png)

*Figure 1: `cnt_param` (WIDTH = 4) counting up, counting down, loading, and resetting.*


---


## sipo_param
### Description
`sipo_param` is a parameterized Serial-In Parallel-Out shift register. It takes in a serial input to combine it into one parallel output.

---

### Using the Module

#### Parameters
| Parameter | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `4` | Defines bitwidth for `q` |

#### Inputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `serial_in` | `1` | Serial data in |
| `clk` | `1` | Clock signal, rising edge |
| `en` | `1` | Enables writing and shifting, allowing the shift register to take in `serial_in` |
| `rst`| `1` | Active-`HIGH` asynchronous reset. Sets `q` and the internal counter to 0. |

#### Outputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `q` | `WIDTH` | Current parallel `q` value |
| `valid` | `1` | Is only `HIGH` when the internal counter is at the Most-Significant bit |

#### Notes
* Least-Significant Bit(LSB) First. `serial_in` enters at q[0] and shifts left towards q[WIDTH-1] on each active clock edge
* `valid` is a synchronous pulse, not a held value, asserting that it has reached the most-significant bit
* If `en` remains `HIGH` continuously past WIDTH cycles, the internal counter resets to `0` and the module immediately begins capturing the next word without pausing. 

---

### Instantiation Example
```verilog
sipo_param #(
    .WIDTH(WIDTH)
)uut(
    .serial_in(serial_in),
    .clk(clk),
    .en(en),
    .rst(rst),
    .q(q),
    .valid(valid)
);
```

### Timing Diagram
![SIPO Shift Register Timing Diagram](/Docs/Timing%20Graphs/SIPO%20Shift%20Register%20Timing%20Graph.png)

*Figure 1: `sipo_param` (WIDTH = 4) taking in serial data `1010` and then an interrupted serial data in of `0110`*

---

## piso_param
### Description
`piso_param` is a parameterized Parallel-in Serial-out shift register. It takes in a full parallel input, and outputs it one bit at a time as a serial output.

---

### Using the Module

#### Parameters
| Parameter | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `4` | Defines bitwidth for `parallel_in` |

#### Inputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `parallel_in` | `WIDTH` | parallel data to load |
| `clk` | `1` | Clock signal, rising edge |
| `en` | `1` | Enables `clk` |
| `load` | `1` | Flag to trigger loading on the next `clk` tick |
| `rst`| `1` | Active-`HIGH` asynchronous reset. Sets `q`, internal register `data`, and the internal counter to 0. |

#### Outputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `q` | `1` | Current serial output of internal register `data`'s LSB |
| `finish` | `1` | Is only `HIGH` when the register has output the entirety of the loaded data|

#### Notes
* Outputs right to left. Starts with the least significant bit first, ends with the most significant bit
* `finish` is a synchronous pulse, not a held value, asserting that it has output the entirety of the data
* `rst` inputs will take priority over `load`, `load` takes priority over shifting

---

### Instantiation Example
```verilog
piso_param #(
    .WIDTH(4)
)uut(
    .parallel_in(parallel_in),
    .clk(clk),
    .en(en),
    .load(load),
    .rst(rst),
    .q(q),
    .finish(finish)
);
```

### Timing Diagram
![PISO Shift Register Timing Diagram](/Docs/Timing%20Graphs/PISO%20Shift%20Register%20Timing%20Graph.png)

*Figure 1: `piso_param` (WIDTH = 4) taking in parallel data `1010`, outputing it in serial, and then loads `0110`, output interrupted*