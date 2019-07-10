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

	// ������ʱ����
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
	 
	 // һ�ѿ����ź�
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
   input CLK,                         // ʱ��
   input Reset,                       // �����ź�                  
   input [31:0] newAddress,           // ��ָ��
   output reg[31:0] currentAddress    // ��ǰָ��
   );*/
	PC qpc(clk,reset,newAddress, currentAddress);
	
	/*module InstructionMemory(

   input [31:0] IAddr,        // ָ���ַ�������
	output [5:0] op,
   output [4:0] rs,
   output [4:0] rt,
   output [4:0] rd,
   output [15:0] immediate,
	output [5:0] fun// ָ������ʱ�����
   );*/
	InstructionMemory im(currentAddress,op, rs, rt, rd, immediate,fun,instr);
	
	/*module RegisterFile(
	input CLK,
	input reset,// ʱ��
	input RegWre, 
	input wja,// дʹ���źţ�Ϊ1ʱ����ʱ��������д��
   input [4:0] rs,            // rs�Ĵ�����ַ����˿�
   input [4:0] rt,            // rt�Ĵ�����ַ����˿�
   input [4:0] WriteReg,      // ������д��ļĴ����˿ڣ����ַ��Դrt��rd�ֶ�
   input [31:0] WriteData,
	input [31:0] WPC,
	input [31:0] jal,// д��Ĵ�������������˿�
	output [31:0] ReadData1,   // rs�Ĵ�����������˿�
   output [31:0] ReadData2    // rt�Ĵ�����������˿�
   );*/
	RegisterFile rf(clk,reset, regwrite,wja, rs, rt, WriteReg, WriteData,currentAddress,currentAddress_4, ReadData1, ReadData2);
	
	/*module ALU(
	 input [2:0] ALUOp,           // ALU��������
    input [31:0] A,              // ����1
    input [31:0] B,              // ����2
    output reg zero,             // ������result�ı�־��resultΪ0���1���������0
    output reg [31:0] result     // ALU������
    );*/
	ALU alu(aluop,ReadData1,B,zero,result);
	
	/*module SignZeroExtend(
   input ExtSel1, 
	input ExtSel2,	
	input [15:0] immediate,        // 16λ������
   output reg [31:0] extendImmediate   // �����32λ������
   );*/
	SignZeroExtend sze(ext1,ext2,immediate,extendImmediate);
	
	/*module DataMemory(
    // ��������ͨ·ͼ������������
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