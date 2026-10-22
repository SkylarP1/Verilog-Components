# Combined Definitions for the Counters and Shift Registers section
## cnt_param
### Description
The Counter is a parameterized module that allows for synchronous controlled bi-directional counting and loading of data. 

---

### Using the Module

#### Parameters
| Parameter | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `4` | Defines bitwidth of counting |

#### Inputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `clk` | `1` | Clock signal, triggers a count |
| `rst` | `1` | Resets value to 0 in counter, triggers posedge asynchronously |
| `en` | `1` | Enables the counter, enabled when `HIGH` |
| `dir`| `1` | When `HIGH`, count up, when `LOW`, count down |
| `load` | `1` | When `HIGH`, load `data_in` value on the next posedge from `clk` when `en` is HIGH |
| `data_in` | `WIDTH` | Parallel data loaded into the counter when `load` is high |

#### Outputs
| Port | Bitwidth | Description |
| :--- | :---: | :--- |
| `q` | `WIDTH` | Current counter value |
| `max` | `1` | Set `HIGH` when `q` is at its maximum value |
| `min` | `1` | Set `HIGH` when `q` is at its minimum value | 

#### Notes
* rst operations get priority in sequence, meaning if load is also active, it will reset instead
* when underflow or overflow occur it wraps (ex. 1111 -> 0000 on count)
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