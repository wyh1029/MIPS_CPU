`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:34:37 12/13/2017 
// Design Name: 
// Module Name:    MUX_WA 
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
module MUX_WA(
    input [4:0] RT,
    input [4:0] RD,
    input [1:0] WAOp,
    output [4:0] WA
    );
	reg [4:0]wa;
	always @* begin
		case (WAOp)
		2'b00: wa <= RT;
		2'b01: wa <= RD;
		2'b10: wa <= 31;
		endcase
	end
	assign WA = wa;
endmodule

module MUX_WD(
	input [31:0] ALUOut,
	input [31:0] RD,
	input [31:0] PC4,
	input [1:0] WDOp,
	output [31:0] WD
	);
	reg [31:0] wd;
	always @* begin
		case (WDOp)
		2'b00: wd <= ALUOut;
		2'b01: wd <= RD;
		2'b10: wd <= PC4;
		endcase
	end
	assign WD = wd;
endmodule 

module MUX_ALUB(
	input [31:0] EXT,
	input [31:0] DATA,
	input ALUBOp,
	output [31:0]ALUB
	);
	reg [31:0] alub;
	always @* begin
		case (ALUBOp)
		0: alub <= EXT;
		1: alub <= DATA;		
		endcase
	end
	assign ALUB = alub;
endmodule 