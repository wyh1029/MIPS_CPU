`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:42 12/25/2017 
// Design Name: 
// Module Name:    EX_MEM_reg 
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
module EX_MEM_reg(
	input clk,
	input reset,
	input enable,
	input [31:0] pc,
	input [31:0] pc4,
	input [31:0] pc8,
	input [31:0] aluout,
	input [31:0] rd2,
	input [31:0] instr,
	output reg [31:0] PC,
	output reg [31:0] PC4,
	output reg [31:0] PC8,
	output reg [31:0] ALUOUT,
	output reg [31:0] RD2,
	output reg [31:0] INSTR
    );
	 reg [31:0] Pc,Pc4,Pc8,Aluout,Rd2,Instr;
	 always @(posedge clk) begin
		if (reset) begin
			PC <= 0;
			PC4 <= 0;
			PC8 <= 0;
			ALUOUT <= 0;
			RD2 <= 0;
			INSTR <= 0;
		end
		else if (!enable) begin
			PC <= pc;
			PC4 <= pc4;
			PC8 <= pc8;
			ALUOUT <= aluout;
			RD2 <= rd2;
			INSTR <= instr;
		end
	 end
endmodule
