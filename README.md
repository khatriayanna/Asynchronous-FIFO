**# Asynchronous-FIFO**
**📌 Overview**

This project implements an Asynchronous FIFO (First-In First-Out) memory buffer using Verilog HDL. It is designed to safely transfer data between two different clock domains, making it a critical component in modern digital systems where multiple clocks are used.
The design uses Gray code pointers and synchronizers to prevent metastability and ensure reliable data transfer.

**Features**
Supports independent read and write clocks
Safe clock domain crossing (CDC)
Uses Gray code counters for pointer synchronization
Generates Full and Empty flags
Parameterizable data width and depth
Synthesizable and FPGA-friendly design

**Theory**
What is FIFO?
A FIFO stores data in a queue-like structure:
First data written → first data read
Why Asynchronous FIFO?
In real systems:
Write side and read side often run on different clocks
Direct transfer can cause metastability

**Technologies Used**
Verilog HDL
Simulation tools (Vivado)
FPGA platforms

**Project Structure**
Async-FIFO/
│── src/
│   ├── async_fifo.v
│   ├── fifo_memory.v
│   ├── gray_counter.v
│   ├── synchronizer.v
│
│── tb/
│   ├── async_fifo_tb.v
│
│── docs/
│   ├── design_notes.md
│
│── README.md

**Applications**
Clock domain crossing (CDC)
Data buffering in communication systems
Video/audio streaming systems
Network routers
FPGA-based high-speed designs
