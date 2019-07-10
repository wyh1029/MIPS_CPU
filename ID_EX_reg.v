`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:42:23 12/25/2017 
// Design Name: 
// Module Name:    ID_EX_reg 
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
module ID_EX_reg(
	input clk,
	input reset,
	input enable,
	input [31:0] pc,
	input [31:0] pc4,
	input [31:0] pc8,
	input [31:0] rd1,
	input [31:0] rd2,
	input [31:0] ext,
	input [31:0] instr,
	output reg [31:0] PC,
	output reg [31:0] PC4,
	output reg [31:0] PC8,
	output reg [31:0] RD1,
	output reg [31:0] RD2,	
	output reg [31:0] EXT,
	output reg [31:0] INSTR
    );
	always @(posedge clk) begin
		if (reset || enable) begin
			PC <= 0;
			PC4 <= 0;
			PC8 <= 0;
			RD1 <= 0;
			RD2 <= 0;
			EXT <= 0;
			INSTR <= 0;
		end
		else if (!enable) begin
			PC <= pc;
			PC4 <= pc4;
			PC8 <= pc8;
			RD1 <= rd1;
			RD2 <= rd2;
			EXT <= ext;
			INSTR <= instr;
		end
	end

endmodule
