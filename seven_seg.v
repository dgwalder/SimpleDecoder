`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Worcester Polytechnic Institute
// Engineer: Damani Walder 
//
// Create Date:    14:45:50 01/15/2015 
// Module Name:    seven_seg 
// Project Name:    Decoder 
// Target Devices: Nexys 3 Spartan-6 Board
//
// Description: 
//
// Determines which anode of the seven segment display should display 
// the acurate digit between 0 and F. As well as which digit
// should be displayed, given a specific button press.
//////////////////////////////////////////////////////////////////////////////////

module seven_seg(
    input [15:0] value,
    input [1:0] mux,
    output [6:0] cathode,
    output [0:0] anode1,
    output [0:0] anode2,
    output [0:0] anode3,
    output [0:0] anode4
    );

	//temp stores the 4 bits from value that should be dislayed
	wire [3:0] temp; 
	
	assign temp = (mux == 2'b00) ? value[3:0] : //lower 4 bits of slider swicthes
 	              (mux == 2'b01) ? value[7:4] : //upper 4 bits of slider switches
	              (mux == 2'b10) ? value[15:12] : //sum of upper and lower 4bits of slider switches
	              value[11:8]; //xor operation of upper and lower 4bits of slider switches
	
	//the following assign statements determines which anode of the 7 seg display should turn on	
	
	//off off (00) - display the value of the lower 4-bits of 
	//the slider switches on seven-segment display #1
	assign anode1 = (mux == 2'b00) ? 1'b0: 1'b1;
		
	//off on (01) - display the value of the upper 4-bits of 
	//the slider switches on seven-segment display #2
	assign anode2 = (mux == 2'b01) ? 1'b0: 1'b1;
	
	//on off (10) - display the value of the addition 
	//of the upper and lower 4-bits of the slider 
	//switches on seven-segment display #3
	assign anode3 = (mux == 2'b10) ? 1'b0: 1'b1;
	
	
	//on on (11) - display the value of the xor operation of the
	//upper and lower 4-bits of the slider switches 
	//on seven-segment display #4
	assign anode4 = (mux == 2'b11) ? 1'b0: 1'b1;
	
	//Determines what should be displayed based on the 4 bits which it is given
	assign cathode = 	(temp == 4'b0000) ? 7'b00000001 : //0
	                  (temp == 4'b0001) ? 7'b1001111 : //1
	                  (temp == 4'b0010) ? 7'b0010010 : //2
	                  (temp == 4'b0011) ? 7'b0000110 : //3
                  	(temp == 4'b0100) ? 7'b1001100 : //4
                  	(temp == 4'b0101) ? 7'b0100100 : //5
                  	(temp == 4'b0110) ? 7'b1100000 : //6
                  	(temp == 4'b0111) ? 7'b0001111 : //7
                  	(temp == 4'b1000) ? 7'b0000000 : //8
                  	(temp == 4'b1001) ? 7'b0001100 : //9
                  	(temp == 4'b1010) ? 7'b0001000 : //A
                  	(temp == 4'b1011) ? 7'b0000000 : //B
                  	(temp == 4'b1100) ? 7'b0110001 : //C
                  	(temp == 4'b1101) ? 7'b0000001 : //D
                  	(temp == 4'b1110) ? 7'b0110000 : //E
                  	7'b0111000; //F	
	
endmodule
