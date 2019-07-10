`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:50:32 12/13/2017 
// Design Name: 
// Module Name:    pc 
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
module PC(
   input CLK,                         // ʱ��
   input Reset,                       // �����ź�                  
   input [31:0] newAddress,           // ��ָ��
   output reg[31:0] currentAddress    // ��ǰָ��
   );

	initial begin
		currentAddress <= 32'h00003000;  // ��������ֵ
	end
	
	always@(posedge CLK)
	begin
		if (Reset) 
		currentAddress <= 32'h00003000;  // ������ã���ֵΪ0
		else 
		begin
		currentAddress <= newAddress;
		end
	end

endmodule
