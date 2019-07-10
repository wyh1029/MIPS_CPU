`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:50:38 12/13/2017 
// Design Name: 
// Module Name:    IM 
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
module InstructionMemory(

   input [31:0] IAddr,        // 指令地址输入入口
	output [5:0] op,
   output [4:0] rs,
   output [4:0] rt,
   output [4:0] rd,
   output [15:0] immediate,
	output [5:0] fun,
	output [25:0]instr// 指令代码分时段输出
   );
	 
   reg [31:0] mem[1023:0];
   wire [31:0] instruction;
   initial begin
       $readmemh("code.txt",mem); // 从文件中读取指令二进制代码赋值给mem
  // 指令初始化
   end
   assign instruction = mem[IAddr[11:2]][31:0];

	// 从地址取值，然后输出
	assign op = instruction[31:26];
	assign rs = instruction[25:21];
	assign rt = instruction[20:16];
	assign rd = instruction[15:11];
	assign immediate = instruction[15:0];
	assign fun = instruction[5:0];
	assign instr = instruction[25:0];

endmodule