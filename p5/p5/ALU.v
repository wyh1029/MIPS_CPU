`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:08:44 12/21/2017 
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
    output [31:0] ALUOut
    );
	wire [31:0] add,sub,ori;
	reg [31:0] aluout;
	assign add = $signed(A) + $signed(B);
	assign sub = $signed(A) - $signed(B);
	assign ori = A | B;
	always @* begin
		case (ALUOp)
		0: aluout <= add;
		1: aluout <= sub;
		2: aluout <= ori;
		endcase
	end
	assign ALUOut = aluout;
endmodule
