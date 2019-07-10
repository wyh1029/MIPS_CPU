`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:50:21 12/13/2017 
// Design Name: 
// Module Name:    alu 
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
module ALU(
	 input [2:0] ALUOp,           // ALU操作控制
    input [31:0] A,              // 输入1
    input [31:0] B,              // 输入2
    output reg zero,             // 运算结果result的标志，result为0输出1，否则输出0
    output reg [31:0] result     // ALU运算结果
    );

	// 进行ALU计算
	always@(*)
	 begin
		// 进行运算
		case (ALUOp)
			3'b000 : result = A + B;  // 加法
			3'b001 : result = A - B;  // 减法
			3'b010 : result = B | A;  // 减法

		endcase
		// 设置zero
		if (A==B)  zero = 1;
		else  zero = 0;
	 end

endmodule