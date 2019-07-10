`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:17:31 12/21/2017 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
	 input [15:0] A,
    input [1:0] EXTOp,
    output [31:0] EXTOut
    );
	 reg [31:0] zero;
	 reg [31:0] sign;
	 reg [31:0] sign16;
	 reg [31:0] extout;
	 always @* begin
	 zero[15:0] <= A;
	 zero[31:16] <= 0;
	 
	 sign[15:0] <= A[15:0];
	 sign[31:16] <= {16{A[15]}};
	
	 sign16[15:0] <= 0;
	 sign16[31:16] <= A[15:0];
	 
	 if (EXTOp == 0)
		extout <= zero;
	else if (EXTOp == 1)
		extout <= sign;
	else if (EXTOp == 2)
		extout <= sign16;
	 end
	 assign EXTOut = extout;

endmodule
