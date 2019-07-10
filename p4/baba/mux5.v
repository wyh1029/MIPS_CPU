`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:54 12/13/2017 
// Design Name: 
// Module Name:    mux5 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Multiplexer5(
	 input control,
    input [4:0] in1,
    input [4:0] in0,
    output [4:0] out
    );

	// 5???¨¤?¡¤?????¡Â
	assign out = control ? in1 : in0;
	
endmodule