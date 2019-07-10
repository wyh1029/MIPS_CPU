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
    // ��������ͨ·ͼ������������
	 input clk,
	 input reset,
	 input memwrite,
    input [31:0] DAddr,
    input [31:0] DataIn,
	 input [31:0] pc,
    output  [31:0] DataOut
    );
    // ģ���ڴ棬��8λΪһ�ֽڴ洢����64�ֽ�
    reg [31:0] memory[1023:0];

    // ��ʼ��ֵ
    integer i;


    // ��д�ڴ�
	assign DataOut = memory[DAddr[11:2]];
    always@(posedge clk)
     begin
			if(reset) begin
				for (i = 0; i < 1024; i = i + 1) 
				memory[i] <= 0;
			end
        // д�ڴ�
        else begin
		  if (memwrite)
         begin
				memory[DAddr[11:2]] <= DataIn;
				$display("@%h: *%h <= %h",pc,DAddr,DataIn);
			end
        // ���ڴ�
 
			end
     end
endmodule