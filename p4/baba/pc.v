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
   input CLK,                         // 时钟
   input Reset,                       // 重置信号                  
   input [31:0] newAddress,           // 新指令
   output reg[31:0] currentAddress    // 当前指令
   );

	initial begin
		currentAddress <= 32'h00003000;  // 非阻塞赋值
	end
	
	always@(posedge CLK)
	begin
		if (Reset) 
		currentAddress <= 32'h00003000;  // 如果重置，赋值为0
		else 
		begin
		currentAddress <= newAddress;
		end
	end

endmodule
