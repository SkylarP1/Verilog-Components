# Verilog-Components
*As of October 2026, this repository now uses SystemVerilog instead of Verilog* 

---

## Highlights
* Diverse selection of Verilog and SystemVerilog components
* Niche components (i.e. asynchronous logic)
* Parameterized Components

---

## Overview
I made this library of verilog components because I commonly would fall into the trap when working on different projects where I would have to go through different projects to get the components I wanted, or just remake them. I figured that I would make a library that contians all of the non-project-specific components that I use.

## Current Components
All modules are parameterized unless stated otherwise. See documentation for more information
### ALU Components
* Logical Unit
    * `lu_param`
### Asynchronous
* Asynchronous Register
    * `async_reg`
* Duel-Wire -> Single-Wire converter
    * `ds_wire`
* Single-Wire -> Duel-Wire converter
    * `sd_wire`
* Muller C-Elements
    * `c_param`
### Counters & Shift Registers
* Bidirectional Counter with loading
    * `cnt_param`
* Parallel-In Serial-Out shift register
    * `piso_param`
* Serial-In Parallel-Out shift register
    * `sipo_param`
* Universal Shift Register
    * `uni_sr_param`
### Plexors
* Multiplexor
    * `mux`
### Registers
* Register
    * `reg_param`
### Misc