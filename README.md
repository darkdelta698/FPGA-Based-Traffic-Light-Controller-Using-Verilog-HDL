# FPGA-Based-Traffic-Light-Controller-Using-Verilog-HDL
This project implements a Traffic Light Controller using Verilog HDL based on a Finite State Machine (FSM) architecture. The controller manages traffic signals for a four-way intersection consisting of North, South, East, and West directions.
The design coordinates the traffic flow by allowing the North-South and East-West directions to operate alternately. A counter is used to control the duration of the GREEN and YELLOW signal states before transitioning to the next state.

The design was implemented and simulated using Verilog HDL
Features
Finite State Machine (FSM)-based traffic light control
Four traffic directions:
North
South
East
West
Three traffic light states:
RED
YELLOW
GREEN
Clock-driven synchronous operation
Reset functionality
Counter-based timing control
Separate Verilog testbench for functional verification
Suitable for FPGA implementation
FSM Architecture

The Traffic Light Controller uses a 4-state Finite State Machine.

State	North	South	East	West	Function
S0	GREEN	GREEN	RED	RED	North-South traffic moves
S1	YELLOW	YELLOW	RED	RED	North-South prepares to stop
S2	RED	RED	GREEN	GREEN	East-West traffic moves
S3	RED	RED	YELLOW	YELLOW	East-West prepares to stop

The FSM continuously follows the sequence:

S0 → S1 → S2 → S3 → S0

State Operation
State S0 — North-South GREEN
North = GREEN
South = GREEN
East  = RED
West  = RED

The North-South direction is allowed to move while the East-West direction remains stopped.

After the counter reaches the specified GREEN duration, the FSM transitions to S1.

State S1 — North-South YELLOW
North = YELLOW
South = YELLOW
East  = RED
West  = RED

The North-South traffic receives a YELLOW signal indicating that the signal is about to change.

After the YELLOW duration, the FSM transitions to S2.

State S2 — East-West GREEN
North = RED
South = RED
East  = GREEN
West  = GREEN

The East-West direction is allowed to move while the North-South direction remains stopped.

After the GREEN duration, the FSM transitions to S3.

State S3 — East-West YELLOW
North = RED
South = RED
East  = YELLOW
West  = YELLOW

The East-West traffic receives a YELLOW signal indicating that the signal is about to change.

After the YELLOW duration, the FSM returns to S0.

Counter-Based Timing

A 4-bit counter is used to determine how long the controller remains in each FSM state.

The counter increments on every positive edge of the clock:

count <= count + 1;

Whenever the FSM transitions to a new state, the counter is reset:

if (pst != nst)
    count <= 0;

The state transitions occur when the counter reaches the specified threshold.

GREEN state  : count >= 9
YELLOW state : count >= 2

These values represent clock-cycle counts, not fixed nanosecond delays. The actual duration depends on the frequency of the input clock.

Author

Rohan Pydipalli
B.Tech Electronics and Communication Engineering
Specialization in VLSI Design
VIT-AP University

Conclusion

This project demonstrates the design and verification of a Finite State Machine-based Traffic Light Controller using Verilog HDL. The FSM controls four traffic directions while ensuring that conflicting traffic directions do not receive GREEN signals simultaneously.

The project demonstrates fundamental digital design concepts including FSM design, sequential logic, combinational logic, counters, state encoding, Verilog HDL simulation, and FPGA-oriented RTL design.
