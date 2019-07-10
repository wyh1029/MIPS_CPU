`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:40 12/13/2017 
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
module mips(
    input clk,
    input reset
    );
	//IFU �����ʱ����
	wire [31:0] Instr,PC,PC4,EXT,JRAdd;

	//IFU-GRF ��ʱ����
	wire [5:0] OPCode,FUNCode;
	wire [4:0] Rs,Rt,Rd;
	wire [15:0] Imm;
	
	//�����źű���
	wire [1:0]WAOp,WDOp,EXTOp,ALUOp;
	wire BEQOp,ALUBOp,DWE,DRE,RWE,JALOp,JROp;
	
	//GRF ��ʱ����
	wire [4:0] WA;
	wire [31:0] WD,D1,D2;
	
	//ALU ��ʱ����
	wire [31:0] ALUB,ALUOut;
	wire BEQZero;
	
	//DM ��ʱ����
	wire [31:0] RD;
	
	//IFU ���� clk,reset
	//IFU ��� PC4,Instr
	IFU ifu(clk,reset,EXT,BEQOp,BEQZero,JALOp,JROp,D1,PC,PC4,Instr);
	
	//����
	assign OPCode = Instr[31:26];
	assign Rs = Instr[25:21];
	assign Rt = Instr[20:16];
	assign Rd = Instr[15:11];
	assign Imm = Instr[15:0];
	assign FUNCode = Instr[5:0];
	
	//control ���� opcode functioncode
	//��������źż�
	CONTROL ctrl(OPCode,FUNCode,WAOp,WDOp,BEQOp,ALUBOp,EXTOp,ALUOp,DWE,DRE,RWE,JALOp,JROp);
	
	//MUX WA
	MUX_WA wa(Rt,Rd,WAOp,WA);
	
	//MUX_WD
	MUX_WD wd(ALUOut,RD,PC4,WDOp,WD);
	
	
	//GRF ���� RA1,RA2,WA,WD,reset,clk,RWE
	//GRF ��� D1,D2
	GRF file(Rs,Rt,WA,WD,reset,clk,RWE,PC,D1,D2);
	
	//EXT ���� Imm,EXTOp
	//EXT ��� EXT
	EXT ext(Imm,EXTOp,EXT);
	
	//MUX ALUB
	MUX_ALUB alub(EXT,D2,ALUBOp,ALUB);
	
	//ALU ���� ALU1,ALU2,ALUOp
	//ALU ��� ALUOut, zero
	ALU alu(D1,ALUB,ALUOp,ALUOut,BEQZero);
	
	//DM ���� add,wata,reset,clk,dwe,re;
	//DM ��� RD;
	DM data(ALUOut,D2,reset,clk,DWE,DRE,PC,RD);
	
endmodule
