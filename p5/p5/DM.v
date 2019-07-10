`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:19:13 12/21/2017 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [31:0] Add,
    input [31:0] WData,
    input Reset,
    input clk,
    input DWE,
    input DRE,
	 input [31:0] PC,
    output [31:0] RD
    );
	reg [31:0]DMRAM[1023:0];
	integer i = 0;
	initial begin
		for (i=0;i<1024;i=i+1)
				DMRAM[i] <= 0;
	end
	//¶Á²Ù×÷
	assign RD = DMRAM[Add[11:2]];
	//Ð´²Ù×÷
	always @(posedge clk) begin
		if (Reset)
			for (i=0;i<1024;i=i+1)
				DMRAM[i] <= 0;
		else if (DWE) begin
			DMRAM[Add[11:2]] <= WData;
			//$display("%d@%h: *%h <= %h", $time, PC-4,WA,WD);
			$display("%d@%h: *%h <= %h", $time, PC,Add,WData);
		end
	end
endmodule
