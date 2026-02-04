# Single-Cycle RISC-V Processor
## Project Overview

This project implements a Single-Cycle RISC-V Processor based on the RV32I instruction set architecture.
The processor executes each instruction in a single clock cycle, making it an ideal design for understanding the fundamentals of RISC-V datapath, control logic, and instruction execution flow.

The design is suitable for academic learning, RTL design practice, and FPGA/ASIC fundamentals.

## Objectives

Understand RISC-V instruction execution

Design a complete single-cycle datapath

Implement control and ALU logic

Verify correct instruction behavior through simulation

## Supported Instructions (RV32I – Basic)

The processor supports core instruction types such as:

R-type: add, sub, and, or, slt

I-type: addi, andi, ori, lw

S-type: sw

B-type: beq

U/J-type (if implemented): lui, jal

(Instruction support may be extended depending on implementation)

## Processor Architecture

The processor follows a classic single-cycle datapath, consisting of:

## Major Blocks

Program Counter (PC)

Instruction Memory

Register File

Immediate Generator

ALU

Control Unit

Data Memory

MUXes for datapath control

Each instruction completes:

Fetch → Decode → Execute → Memory → Writeback
within one clock cycle

## Tools & Technologies

Language: Verilog

ISA: RISC-V RV32I

Simulation: QuestaSim

Design Style: RTL, Modular Datapath

## How to Run the Simulation

Open ModelSim / QuestaSim

Compile all RTL files:

vlog src/*.v tb/*.v


Start simulation:

vsim processor_tb


Run simulation:

run -all


Observe waveforms and register/memory outputs

## Verification Highlights

Correct instruction fetch and decode

Proper ALU operation based on control signals

Accurate register write-back

Correct branching and memory access behavior

## Learning Outcomes

Deep understanding of RISC-V single-cycle datapath

Hands-on RTL design experience

Control unit and ALU design concepts

Foundation for pipelined and multi-cycle processors

Strong base for FPGA/ASIC CPU projects

## Future Enhancements

Multi-cycle or pipelined RISC-V processor

Hazard detection and forwarding

Instruction cache and data cache

CSR and interrupt support

FPGA implementation and synthesis

## Author

Syed Ali Raza Zaidi
Digital Design & Computer Architecture Enthusiast
RISC-V | RTL Design | Verilog
