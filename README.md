# Introduction to Encoders and Decoders

## Overview

Encoders and decoders are fundamental **combinational logic circuits** used in digital systems to convert data between different forms.

An **encoder** takes multiple input lines and produces a smaller number of output lines that represent the active input in binary form. A **decoder** performs the reverse operation, taking a binary input and activating the corresponding output line.

In simple terms, if a valid input is passed into an encoder and then through its corresponding decoder, the original input can be reconstructed.

---

## What is an Encoder?

An encoder is a combinational circuit with:

- **n input lines**
- **m output lines**

The purpose of an encoder is to reduce the number of data lines needed to represent information. Instead of sending a signal across many separate input lines, the encoder converts the active input into a binary code on fewer output lines.

This works under the assumption that **only one input line is active at a time**.

### Example Concept

For a 4-to-2 encoder:

- There are **4 input lines**
- There are **2 output lines**

The 2-bit output represents the number of the input line that is high.

For example:

| Active Input | Output |
|--------------|--------|
| D0           | 00     |
| D1           | 01     |
| D2           | 10     |
| D3           | 11     |

This demonstrates how the encoder minimizes the number of lines required to communicate which input is active.

![Encoder](imageAssets/Encoder.png)

---

## What is a Decoder?

A decoder is the reverse of an encoder.

It takes a binary input and activates one corresponding output line. In other words, a decoder expands encoded information back into its original form.

For a 2-to-4 decoder:

- There are **2 input lines**
- There are **4 output lines**

Each binary input value selects exactly one output line.

| Input | Active Output |
|-------|---------------|
| 00    | D0            |
| 01    | D1            |
| 10    | D2            |
| 11    | D3            |

Because of this reverse relationship, encoders and decoders are often introduced together.

![Encoder->Decoder](imageAssets/Encoder-Decoder.png)

---

## Relationship Between Encoders and Decoders

Encoders and decoders are complementary circuits:

- An **encoder** compresses multiple input lines into a binary code
- A **decoder** expands that binary code back into a single active output

When used together correctly, they allow a system to convert signals into a more compact form and then recover the original selection later.

---

## Types of Encoders

There are several common types of encoders used in digital electronics:

### 1. Priority Encoder
A priority encoder is designed to handle cases where **more than one input may be active at the same time**. It assigns priority to one input over the others and outputs the binary code of the highest-priority active input.

### 2. Decimal to BCD Encoder
This encoder converts a **decimal input** into its corresponding **Binary-Coded Decimal (BCD)** representation.

### 3. Octal to Binary Encoder
An octal-to-binary encoder converts one of **8 input lines** into a **3-bit binary output**.

### 4. Hexadecimal to Binary Encoder
A hexadecimal-to-binary encoder converts one of **16 input lines** into a **4-bit binary output**.

---

## Applications

Encoders are commonly used in digital systems for:

- Reducing the number of data lines
- Data compression in logic circuits
- Keyboard input encoding
- Interrupt handling
- Digital communication systems

Decoders are used for:

- Output selection
- Memory address decoding
- Display systems
- Device control

---

## Conclusion

Encoders and decoders are essential building blocks in digital logic design. An encoder reduces multiple inputs into a compact binary form, while a decoder restores that binary information into a specific output line. Understanding how these circuits work is important for studying more advanced digital systems and computer engineering concepts.

---
# 4:2 Priority Encoder | Verilog

![Language](https://img.shields.io/badge/Language-Verilog-blue)
![Tool](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red)
![Type](https://img.shields.io/badge/Type-Combinational%20Logic-green)
![Status](https://img.shields.io/badge/Simulation-Passing-brightgreen)

A Verilog implementation of a 4:2 priority encoder, designed and simulated in **Xilinx Vivado**.

This document explains:
- What a priority encoder is
- How priority affects the output
- How the Boolean expressions are derived using K-maps
- The truth table, implementation details, and simulation results

The project includes the RTL design, testbench, simulation waveform, and console-style output verifying correct behavior.

---

## Table of Contents

1. [What Is a Priority Encoder?](#what-is-a-priority-encoder)
2. [How the 4:2 Priority Encoder Works](#how-the-42-priority-encoder-works)
3. [Priority Rule](#priority-rule)
4. [Truth Table](#truth-table)
5. [K-Map Simplification](#k-map-simplification)
6. [Boolean Expressions](#boolean-expressions)
7. [Verilog Implementation](#verilog-implementation)
8. [Testbench](#testbench)
9. [Testbench Output](#testbench-output)
10. [Running the Project in Vivado](#running-the-project-in-vivado)
11. [Project Files](#project-files)

---

## What Is a Priority Encoder?

A **4:2 priority encoder** is a combinational logic circuit that takes **four inputs** (`I3`, `I2`, `I1`, `I0`) and produces **two outputs** (`Y1`, `Y0`) representing the binary index of the highest-priority active input.

Unlike a regular encoder, a priority encoder handles cases where **multiple inputs are high simultaneously**. Instead of producing an ambiguous output, it selects the input with the **highest priority** and encodes only that one.

> **Priority order for this project:**
> `I3` (highest) > `I2` > `I1` > `I0` (lowest)

---

## How the 4:2 Priority Encoder Works

A 4:2 priority encoder reduces **4 input lines** to **2 output lines**.

The number of output bits is determined by:

```
N = 2^m  →  4 = 2^m  →  m = 2
```

So 4 inputs require **2 output bits**.

The outputs encode the highest-priority asserted input as follows:

| Highest Active Input | Y1 | Y0 |
|----------------------|----|----|
| I0                   | 0  | 0  |
| I1                   | 0  | 1  |
| I2                   | 1  | 0  |
| I3                   | 1  | 1  |

**Examples:**
- If `I3 = 1` → output is always `11`, regardless of other inputs
- If `I3 = 0`, `I2 = 1` → output is `10`
- If `I3 = 0`, `I2 = 0`, `I1 = 1` → output is `01`
- If only `I0 = 1` → output is `00`

---

## Priority Rule

| Priority | Input | Condition to be Selected                        |
|----------|-------|-------------------------------------------------|
| 1st      | I3    | Always selected when asserted                   |
| 2nd      | I2    | Selected when `I3 = 0`                          |
| 3rd      | I1    | Selected when `I3 = 0` and `I2 = 0`            |
| 4th      | I0    | Selected when `I3 = 0`, `I2 = 0`, `I1 = 0`    |

---

## Truth Table

> **Note:** `X` denotes a don't-care condition.

| I3 | I2 | I1 | I0 | Y1 | Y0 |
|----|----|----|-----|----|----|
| 0  | 0  | 0  | 0   | X  | X  |
| 0  | 0  | 0  | 1   | 0  | 0  |
| 0  | 0  | 1  | X   | 0  | 1  |
| 0  | 1  | X  | X   | 1  | 0  |
| 1  | X  | X  | X   | 1  | 1  |

Only the **highest-priority active input** determines the output; all lower-priority inputs are treated as don't-cares.

---

## K-Map Simplification

Two 4-variable K-maps are constructed — one for `Y1` and one for `Y0`.

### K-Map for Y1

Grouping the cells where `Y1 = 1` yields two groups of 8, producing:

```
Y1 = I2 | I3
```

### K-Map for Y0

Grouping the cells where `Y0 = 1` yields:
- One group of 8 ones (covering all `I3 = 1` cases)
- One group of 4 ones (covering `I3 = 0`, `I2 = 0`, `I1 = 1`)

Combined:

```
Y0 = I3 | (~I2 & I1)
```

---

## Boolean Expressions

The final simplified Boolean expressions for the encoder outputs are:

```
Y1 = I2 | I3
Y0 = I3 | (~I2 & I1)
```

These equations correctly implement the required priority behavior:
- `I3` forces output to `11`
- `I2` forces output to `10` when `I3 = 0`
- `I1` forces output to `01` when `I3 = 0` and `I2 = 0`
- `I0` maps to `00` when it is the only active input

---

## Testbench Output

Console output confirming correct priority-encoder behavior:

```
I3 = 0, I2 = 0, I1 = 0, I0 = 0,  Y1 = 0, Y0 = 0
I3 = 0, I2 = 0, I1 = 0, I0 = 1,  Y1 = 0, Y0 = 0
I3 = 0, I2 = 0, I1 = 1, I0 = 0,  Y1 = 0, Y0 = 1
I3 = 0, I2 = 0, I1 = 1, I0 = 1,  Y1 = 0, Y0 = 1
I3 = 0, I2 = 1, I1 = 0, I0 = 0,  Y1 = 1, Y0 = 0
I3 = 0, I2 = 1, I1 = 0, I0 = 1,  Y1 = 1, Y0 = 0
I3 = 0, I2 = 1, I1 = 1, I0 = 0,  Y1 = 1, Y0 = 0
I3 = 0, I2 = 1, I1 = 1, I0 = 1,  Y1 = 1, Y0 = 0
I3 = 1, I2 = 0, I1 = 0, I0 = 0,  Y1 = 1, Y0 = 1
I3 = 1, I2 = 0, I1 = 0, I0 = 1,  Y1 = 1, Y0 = 1
I3 = 1, I2 = 0, I1 = 1, I0 = 0,  Y1 = 1, Y0 = 1
I3 = 1, I2 = 0, I1 = 1, I0 = 1,  Y1 = 1, Y0 = 1
I3 = 1, I2 = 1, I1 = 0, I0 = 0,  Y1 = 1, Y0 = 1
I3 = 1, I2 = 1, I1 = 0, I0 = 1,  Y1 = 1, Y0 = 1
I3 = 1, I2 = 1, I1 = 1, I0 = 0,  Y1 = 1, Y0 = 1
I3 = 1, I2 = 1, I1 = 1, I0 = 1,  Y1 = 1, Y0 = 1
```

**Verification summary:**
- `I3 = 1` → output is always `11`
- `I2 = 1`, `I3 = 0` → output is always `10`
- `I1 = 1`, `I2 = 0`, `I3 = 0` → output is `01`
- Only `I0 = 1` → output is `00`

---

## Running the Project in Vivado

### 1. Launch Vivado

Open **Xilinx Vivado**.

### 2. Create a New RTL Project

1. Click **Create Project**
2. Select **RTL Project**
3. Optionally enable *Do not specify sources at this time*, or add them directly

### 3. Add Source Files

| Role               | File                   |
|--------------------|------------------------|
| Design Source      | `priorityEncoder.v`    |
| Simulation Source  | `priorityEncoder_tb.v` |

> Set `priorityEncoder_tb.v` as the **simulation top module**.

### 4. Run Behavioral Simulation

Navigate to:

```
Flow → Run Simulation → Run Behavioral Simulation
```

Observe the signals in the waveform viewer:

```
Inputs : I3, I2, I1, I0
Outputs: Y1, Y0
```

Verify that the waveform output matches the truth table and the console output listed above.

---

## Project Files

| File                   | Description                                              |
|------------------------|----------------------------------------------------------|
| `priorityEncoder.v`    | 4:2 priority encoder RTL module                          |
| `priorityEncoder_tb.v` | Testbench — applies all 16 input combinations and displays results |

---

## Author

**Kadhir Ponnambalam**

---

*Designed and simulated using Xilinx Vivado.*
