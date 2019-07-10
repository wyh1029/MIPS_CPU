`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:00:37 12/26/2017 
// Design Name: 
// Module Name:    MEM_WB_reg 
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
module MEM_WB_reg(    
    input reset,
	 input clk,
	 input [31:0] pc,
	 input [4:0] wa,
	 input [31:0] wd,
	 input [31:0] instr,
    input enable,
    output reg [31:0] PC,
	 output reg [4:0] WA,
	 output reg [31:0] WD,
	 output reg [31:0] INSTR
    );
	always @(posedge clk) begin
		if (reset) begin
			WA <= 0;
			WD <= 0;
			PC <= 0;
			INSTR <= 0;
		end
		else if (!enable) begin
			PC <= pc;
			WA <= wa;
			WD <= wd;
			INSTR <= instr;
		end
	end

endmodule
