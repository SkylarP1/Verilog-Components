# Combined Definitions for the Counters and Shift Registers section
## Counter
### Description
The Counter is a parameterized module that allows for synchronous controlled bi-directional counting and loading of data.

---

### Using the Module

#### Parameters
| Parameter | Description |
| :--- | :--- |
| `WIDTH` | Defines bitwidth of counting |

#### Inputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `clk` | `1` | Clock signal, triggers a count |
| `rst` | `1` | Resets value in counter |
| `en` | `1` | Enables the counter, enabled when `HIGH` |
| `dir`| `1` | When `HIGH`, count up, when `LOW`, count down |
| `load` | `1` | When `HIGH`, load `data_in` value on next count trigger |
| `data_in` | `WIDTH` | Data in lines for loading |

#### Outputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `q` | `WIDTH` | Counter output line |
| `max` | `1` | Triggers HIGH when counter is at it's maximum value |
| `min` | `1` | Triggers HIGH when counter is at it's minimum value | 

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
