`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:11 12/13/2017 
// Design Name: 
// Module Name:    mips 
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
`include "lll.v"
`include "pc.v"
`include "IM.v"
`include "rfg.v"
`include "alu.v"
`include "ex.v"
`include "dm.v"
`include "mux5.v"
`include "mux32.v"

module mips(
   input clk,
   input reset

	);

	// 各种临时变量
	wire [2:0] aluop; 
   wire [31:0] B, newAddress;
   wire [31:0] currentAddress_4, extendImmediate, currentAddress_immediate, newAddress1,newAddress2,currentAddress_jal;	  
   wire [4:0] WriteReg,rs,rt,rd; 
   wire zero,regdst,alusrc,regwrite,memwrite,wbeq,memtoreg,ext1,ext2,wja,wjr;
	wire [5:0] fun,op;
	wire [15:0] immediate;
   wire [31:0] ReadData1,ReadData2,WriteData,DataOut,currentAddress,result;
	wire [25:0] instr;
	/*module ControlUnit(
    input [5:0] op,
	 input [5:0] fun,	 
    input zero,           
	 
	 // 一堆控制信号
	 output reg regdst,           
    output reg alusrc,           
    output reg regwrite,         
    output reg memwrite,     
    output reg wbeq,         
    output reg memtoreg,       
    output reg ext1,      
    output reg ext2,         
	 output reg [2:0] aluop,  
	output reg wja,
	output reg wjr
    );*/
	ControlUnit cu(op,fun,zero,regdst,alusrc,regwrite,memwrite,wbeq,memtoreg,ext1,ext2,aluop,wja,wjr);
	
	/*module PC(
   input CLK,                         // 时钟
   input Reset,                       // 重置信号                  
   input [31:0] newAddress,           // 新指令
   output reg[31:0] currentAddress    // 当前指令
   );*/
	PC qpc(clk,reset,newAddress, currentAddress);
	
	/*module InstructionMemory(

   input [31:0] IAddr,        // 指令地址输入入口
	output [5:0] op,
   output [4:0] rs,
   output [4:0] rt,
   output [4:0] rd,
   output [15:0] immediate,
	output [5:0] fun// 指令代码分时段输出
   );*/
	InstructionMemory im(currentAddress,op, rs, rt, rd, immediate,fun,instr);
	
	/*module RegisterFile(
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
   );*/
	RegisterFile rf(clk,reset, regwrite,wja, rs, rt, WriteReg, WriteData,currentAddress,currentAddress_4, ReadData1, ReadData2);
	
	/*module ALU(
	 input [2:0] ALUOp,           // ALU操作控制
    input [31:0] A,              // 输入1
    input [31:0] B,              // 输入2
    output reg zero,             // 运算结果result的标志，result为0输出1，否则输出0
    output reg [31:0] result     // ALU运算结果
    );*/
	ALU alu(aluop,ReadData1,B,zero,result);
	
	/*module SignZeroExtend(
   input ExtSel1, 
	input ExtSel2,	
	input [15:0] immediate,        // 16位立即数
   output reg [31:0] extendImmediate   // 输出的32位立即数
   );*/
	SignZeroExtend sze(ext1,ext2,immediate,extendImmediate);
	
	/*module DataMemory(
    // 根据数据通路图定义输入和输出
	 input clk,
	 input reset,
	 input memwrite,
    input [31:0] DAddr,
    input [31:0] DataIn,
	 input [31:0] pc,
    output reg [31:0] DataOut
    );*/
	DataMemory dm(clk,reset,memwrite,result,ReadData2,currentAddress,DataOut);
	
	assign currentAddress_4 = currentAddress + 4;
	assign currentAddress_immediate = currentAddress_4 + (extendImmediate << 2);
	assign currentAddress_jal ={currentAddress[31:28],instr[25:0],2'b0};

	
	Multiplexer5 m5(regdst, rd, rt, WriteReg);
	Multiplexer32 m321(alusrc, extendImmediate, ReadData2, B);
	Multiplexer32 m322(memtoreg, DataOut, result, WriteData);
	Multiplexer32 m323(wbeq, currentAddress_immediate, currentAddress_4, newAddress1);
	Multiplexer32 m324(wja, currentAddress_jal, newAddress1, newAddress2);
	Multiplexer32 m325(wjr, ReadData1, newAddress2,newAddress);
endmodule