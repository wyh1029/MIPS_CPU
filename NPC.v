`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:09:10 12/26/2017 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
	input [25:0] Imm26,
	input [31:0] PC4,
	input [31:0] JRPC,
	input [2:0] PCOp,
	input Zero,
	input BB,
	output reg [31:0] NPC
    );
	 reg [31:0] beq;
	 reg [31:0] j;
	always @* begin
		beq[1:0] <= 0;
		beq[17:2] <= Imm26[15:0];
		beq[31:18] <= {14{Imm26[15]}};
		j[1:0] <= 0;
		j[27:2] <= 	Imm26[25:0];
		j[31:28] <= PC4[31:28];
	end
	always @* begin
		case (PCOp)
			0: NPC <= PC4 + 4;
			1: NPC <= j;
			2: NPC <= JRPC;
			3: begin
				if (Zero == 1) NPC <= beq + PC4;
				else NPC <= PC4 + 4;
			end
			4: begin
				if (BB == 1) NPC <= beq + PC4 - 4;
				else NPC <= PC4 + 4;
			end
		endcase
	end
endmodule
