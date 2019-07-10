`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:30 12/13/2017 
// Design Name: 
// Module Name:    dm 
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
module DataMemory(
    // 根据数据通路图定义输入和输出
	 input clk,
	 input reset,
	 input memwrite,
    input [31:0] DAddr,
    input [31:0] DataIn,
	 input [31:0] pc,
    output  [31:0] DataOut
    );
    // 模拟内存，以8位为一字节存储，共64字节
    reg [31:0] memory[1023:0];

    // 初始赋值
    integer i;


    // 读写内存
	assign DataOut = memory[DAddr[11:2]];
    always@(posedge clk)
     begin
			if(reset) begin
				for (i = 0; i < 1024; i = i + 1) 
				memory[i] <= 0;
			end
        // 写内存
        else begin
		  if (memwrite)
         begin
				memory[DAddr[11:2]] <= DataIn;
				$display("@%h: *%h <= %h",pc,DAddr,DataIn);
			end
        // 读内存
 
			end
     end
endmodule