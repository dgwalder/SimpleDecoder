`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Worcester Polytechnic Institute
// Engineer: Damani Walder
// 
// Create Date:    14:42:37 01/15/2015 
// Module Name:    lab1 
// Project Name: Decoder
// Target Devices: Nexys 3 Spartan-6 Board 
// Tool versions: Xilinx ISE 
//
// Description: 
//
// Lab 1
// Instantiates the lower module (seven_seg) into this one
// using named association. Connects the mux input to two 
// push buttons as well as connects the 8 slider switches
// to the value port of the seven_seg module. This file also 
// determines the specific digit for the value.
//////////////////////////////////////////////////////////////////////////////////
module lab1(
	 input [7:0] sw,
    input [1:0] buttons,
    output [6:0] cathode,
    output [0:0] anode1,
    output [0:0] anode2,
    output [0:0] anode3,
    output [0:0] anode4
    );
	 
	 wire [15:0] value;
	 
	 // Instantiate the seven_seg module
	 seven_seg ss1 (
    .value(value), 
    .mux(buttons), //connect the 'mux' input to two push-button switches
    .cathode(cathode), 
    .anode1(anode1), 
    .anode2(anode2), 
    .anode3(anode3), 
    .anode4(anode4)
    );
	 
	//connect 8 slider switches to the bottom 8 bits
	//of the value port of the seven_seg  module
	
	assign value [7:0] = sw;
	assign value [11:8] = sw[3:0] ^ sw[7:4];
	assign value [15:12] = sw[3:0] + sw[7:4];

endmodule
