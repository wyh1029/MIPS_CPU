`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:50:02 12/13/2017 
// Design Name: 
// Module Name:    mux32 
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
module Multiplexer32(
	 input control,
    input [31:0] in1,
    input [31:0] in0,
    output [31:0] out
    );

	// 32???¨¤?¡¤?????¡Â
	assign out = control ? in1 : in0;

endmodule