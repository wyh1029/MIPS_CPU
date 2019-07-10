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
	 input [2:0] ALUOp,           // ALU��������
    input [31:0] A,              // ����1
    input [31:0] B,              // ����2
    output reg zero,             // ������result�ı�־��resultΪ0���1���������0
    output reg [31:0] result     // ALU������
    );

	// ����ALU����
	always@(*)
	 begin
		// ��������
		case (ALUOp)
			3'b000 : result = A + B;  // �ӷ�
			3'b001 : result = A - B;  // ����
			3'b010 : result = B | A;  // ����

		endcase
		// ����zero
		if (A==B)  zero = 1;
		else  zero = 0;
	 end

endmodule