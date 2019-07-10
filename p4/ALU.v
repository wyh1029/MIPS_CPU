`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:06:03 12/11/2017 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [1:0] ALUOp,
    output [31:0] ALUOut,
    output Zero
    );
	 reg [31:0] add; 
    reg [31:0] sub;
    reg [31:0] ori;
    reg [31:0] ALUout;
    reg zero;	 
	always @* begin
	add <= $signed(A) + $signed(B);
	sub <= $signed(A) - $signed(B);
	ori <= A | B;
   if (ALUOp == 0)
	    ALUout <= add;
	else if (ALUOp == 1)
	    ALUout <= sub;
   else if (ALUOp == 2)
		ALUout <= ori;
   else if (A == B)
	   zero <= 1;
	else
	   zero <= 0;
	 end
   assign ALUOut = ALUout;
	assign Zero = zero;
endmodule
