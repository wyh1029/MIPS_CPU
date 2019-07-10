`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:20:22 12/21/2017 
// Design Name: 
// Module Name:    IFU 
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

module IFU(
    input clk,
    input Reset,
	 input enable,
	 input Npc,
    input [31:0] NPC,
	 output [31:0] PC,
    output [31:0] PC4,
	 output [31:0] PC8,
    output [31:0] Instr
    );
	 
	reg [31:0]IFROM[1023:0];
	reg [31:0] pc;
	integer i = 0;
	
	initial begin
		$readmemh("code.txt",IFROM);
	end
	initial begin
		pc = 32'b11000000000000;
	end

	//改变pc，下一条指令输入
	always @(posedge clk) begin
		if (Reset)
			pc <= 32'b11000000000000;
		else if (!enable) begin
			if (Npc)  pc <= NPC;
			else pc <= pc+ 4;
		end
		else pc <= pc;
	end
	assign PC = pc;
	assign PC4 = pc + 4;
	assign PC8 = pc + 8;
	assign Instr = IFROM[PC[31:2]-32'b110000000000];
endmodule

