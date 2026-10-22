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