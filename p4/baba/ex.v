`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:50:13 12/13/2017 
// Design Name: 
// Module Name:    ex 
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
module SignZeroExtend(
   input ExtSel1, 
	input ExtSel2,	
	input [15:0] immediate,        // 16位立即数
   output reg [31:0] extendImmediate   // 输出的32位立即数
   );
	wire [31:0]a;	//zero
	wire [31:0]b;	//sign
	wire [31:0]c;	//gaowei
	// 进行扩展
	
	assign a[15:0] = immediate;
	assign b[15:0] = immediate;
	assign c[31:16] = immediate;
	assign a[31:16] = 16'h0000;
	assign b[31:16] = immediate[15] ? 16'hffff : 16'h0000;
	assign c[15:0] =16'h0000;
	always @* begin
	if(ExtSel1 == 0 && ExtSel2 == 0)begin
	extendImmediate = c;
	end
	if(ExtSel1 == 0 && ExtSel2 == 1)begin
	extendImmediate = b;
	end
	if(ExtSel1 == 1 && ExtSel2 == 0)begin
	extendImmediate = a;
	end
	if(ExtSel1 == 1 && ExtSel2 == 1)begin
	extendImmediate = b;
	end
	end
	
endmodule