`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:50:49 12/13/2017 
// Design Name: 
// Module Name:    rfg 
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
module RegisterFile(
	input CLK,
	input reset,// 时钟
	input RegWre, 
	input wja,// 写使能信号，为1时，在时钟上升沿写入
   input [4:0] rs,            // rs寄存器地址输入端口
   input [4:0] rt,            // rt寄存器地址输入端口
   input [4:0] WriteReg,      // 将数据写入的寄存器端口，其地址来源rt或rd字段
   input [31:0] WriteData,
	input [31:0] WPC,
	input [31:0] jal,// 写入寄存器的数据输入端口
	output [31:0] ReadData1,   // rs寄存器数据输出端口
   output [31:0] ReadData2    // rt寄存器数据输出端口
   );


	reg [31:0] register[31:0];  // 新建32个寄存器，用于操作
	// 初始时，将32个寄存器全部赋值为0
	integer i;
	initial 
	begin
		for(i = 0; i < 32; i = i + 1)  register[i] <= 0;
	end

	// 读寄存器
	assign ReadData1 = (rs==0)?0:register[rs];
	assign ReadData2 = (rt==0)?0:register[rt];

	// 写寄存器
	always@(posedge CLK)
	begin
		if(reset)
			begin
				for(i = 0; i < 32; i = i + 1)  register[i] <= 0;
			end

		else if (RegWre)	
				if(wja==1)begin
					register[31]=jal;
					$display("@%h: $31 <= %h",WPC,jal);
				end
				else begin
					register[WriteReg]=WriteData;
					$display("@%h: $%d <= %h",WPC, WriteReg,WriteData);
				end
	end 

	

endmodule
