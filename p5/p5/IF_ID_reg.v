`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:25:19 12/25/2017 
// Design Name: 
// Module Name:    IF_ID_reg 
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
module IF_ID_reg(
	input clk,
	input reset,
	input enable,
	input [31:0] pc,
	input [31:0] pc4,
	input [31:0] pc8,
	input [31:0] instr,
	output reg [31:0] PC,
	output reg [31:0] PC4,
	output reg [31:0] PC8,
	output reg [31:0] INSTR	
    );
	always @(posedge clk) begin
		if (reset) begin
			PC <= 32'b11000000000000;
			PC4 <= 32'b1100000000100;
			PC8 <= 32'b1100000001000;
			INSTR <= 0;
		end
		else if (!enable) begin
			PC <= pc;
			PC4 <= pc4;
			PC8 <= pc8;
			INSTR <= instr;
		end
	end
endmodule
