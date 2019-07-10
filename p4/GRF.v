`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:13 12/12/2017 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input [4:0] RA1,
    input [4:0] RA2,
    input [4:0] WA,
    input [31:0] WD,
    input Reset,
    input clk,
    input RWE,
	 input [31:0]PC,
    output [31:0] D1,
    output [31:0] D2
    );
	reg [31:0] REG [31:0];
	reg [31:0]d1 = 0;
	reg [31:0]d2 = 0;
	reg [31:0]wd = 0;
	integer i = 0;
	initial begin
		for (i=0;i<32;i=i+1)
			REG[i] = 0;
	end
	always @* begin
		begin
			d1[31:0] <= (RA1 == 0 ? 0 : REG[RA1]);
			d2[31:0] <= (RA2 == 0 ? 0 : REG[RA2]);
		end
	end
	always @(posedge clk) begin
		if (Reset) begin
			for (i=0;i<32;i=i+1)
				REG[i] <= 0;
		end
		else if (RWE) begin
			REG[WA] <= WD;
			$display("@%h: $%d <= %h", PC, WA,WD);
		end
	end
	assign D1 = d1;
	assign D2 = d2;
endmodule
