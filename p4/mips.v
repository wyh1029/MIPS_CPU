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
	//IFU 相关临时变量
	wire [31:0] Instr,PC,PC4,EXT,JRAdd;

	//IFU-GRF 临时变量
	wire [5:0] OPCode,FUNCode;
	wire [4:0] Rs,Rt,Rd;
	wire [15:0] Imm;
	
	//控制信号变量
	wire [1:0]WAOp,WDOp,EXTOp,ALUOp;
	wire BEQOp,ALUBOp,DWE,DRE,RWE,JALOp,JROp;
	
	//GRF 临时变量
	wire [4:0] WA;
	wire [31:0] WD,D1,D2;
	
	//ALU 临时变量
	wire [31:0] ALUB,ALUOut;
	wire BEQZero;
	
	//DM 临时变量
	wire [31:0] RD;
	
	//IFU 输入 clk,reset
	//IFU 输出 PC4,Instr
	IFU ifu(clk,reset,EXT,BEQOp,BEQZero,JALOp,JROp,D1,PC,PC4,Instr);
	
	//连线
	assign OPCode = Instr[31:26];
	assign Rs = Instr[25:21];
	assign Rt = Instr[20:16];
	assign Rd = Instr[15:11];
	assign Imm = Instr[15:0];
	assign FUNCode = Instr[5:0];
	
	//control 输入 opcode functioncode
	//输出控制信号集
	CONTROL ctrl(OPCode,FUNCode,WAOp,WDOp,BEQOp,ALUBOp,EXTOp,ALUOp,DWE,DRE,RWE,JALOp,JROp);
	
	//MUX WA
	MUX_WA wa(Rt,Rd,WAOp,WA);
	
	//MUX_WD
	MUX_WD wd(ALUOut,RD,PC4,WDOp,WD);
	
	
	//GRF 输入 RA1,RA2,WA,WD,reset,clk,RWE
	//GRF 输出 D1,D2
	GRF file(Rs,Rt,WA,WD,reset,clk,RWE,PC,D1,D2);
	
	//EXT 输入 Imm,EXTOp
	//EXT 输出 EXT
	EXT ext(Imm,EXTOp,EXT);
	
	//MUX ALUB
	MUX_ALUB alub(EXT,D2,ALUBOp,ALUB);
	
	//ALU 输入 ALU1,ALU2,ALUOp
	//ALU 输出 ALUOut, zero
	ALU alu(D1,ALUB,ALUOp,ALUOut,BEQZero);
	
	//DM 输入 add,wata,reset,clk,dwe,re;
	//DM 输出 RD;
	DM data(ALUOut,D2,reset,clk,DWE,DRE,PC,RD);
	
endmodule
