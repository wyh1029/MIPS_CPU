`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:50:05 12/21/2017 
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
	 
	wire enable_PC=0,enable_FD=0,enable_DE=0,enable_EM=0,enable_MW=0;       //使能端变量
	
	//IF阶段
	wire [31:0] NPC,PC_IF,PC4_IF,PC8_IF,INSTR_IF;   //进d级寄存器之前的变量
	
	wire [31:0] PC_D_OUT,PC4_D_OUT,PC8_D_OUT,INSTR_D_OUT;   //出d级寄存器的变量
	
	//ID阶段
	wire [31:0] RD1_ID,RD2_ID,EXT_ID,NPC_ID;	//进e级寄存器之前的变量
	wire [2:0] PCOP;
	wire [1:0] EXTOP;
	wire BEQ,BB,Npc,reset_DE;
	
	wire [31:0] PC_E_OUT,PC4_E_OUT,PC8_E_OUT,RD1_E_OUT,RD2_E_OUT,EXT_E_OUT,INSTR_E_OUT;		//出e级寄存器的变量
	
	//EX阶段
	wire [31:0] ALUB_EX,AO_EX;			//进m级寄存器之前的变量
	wire [1:0] ALUOP;
	wire ALUBOP;
	
	wire [31:0] PC_M_OUT,PC4_M_OUT,PC8_M_OUT,AO_M_OUT,RD2_M_OUT,INSTR_M_OUT; 			//出m级寄存器的变量
	
	//MEM阶段
	wire [31:0] RD_MEM,WD_MEM;		//进w级寄存器之前的变量
	wire [4:0] WA_MEM;
	wire [1:0] WAOP,WDOP;
	wire DWE,DRE;

	wire [31:0] PC_W_OUT,WD_W_OUT,INSTR_W_OUT;			//出w级寄存器的变量
	wire [4:0] WA_W_OUT;
	
	//WB阶段
	wire RWE;
	
	//暂停控制信号
	wire STALL;
	
	//转发 控制信号
	wire [31:0] RSD,RTD,RSE,RTE,RTM;
	wire [2:0] RSDOP,RTDOP;
	wire [1:0] RSEOP,RTEOP;
	wire RTMOP;

	///////////////////////      IF             /////////////////////////////////////////
	
	IFU PC(clk,reset,STALL,Npc,NPC_ID,PC_IF,PC4_IF,PC8_IF,INSTR_IF);
	
	//写入流水线寄存器IF_ID
	IF_ID_reg D(clk,reset,STALL,PC_IF,PC4_IF,PC8_IF,INSTR_IF,PC_D_OUT,PC4_D_OUT,PC8_D_OUT,INSTR_D_OUT);
	
	//////////////////////         ID                ////////////////////////////

	CTRL_D ctrl_d(INSTR_D_OUT,PCOP,EXTOP,Npc);
	
	PAUSE stall(INSTR_D_OUT,INSTR_E_OUT,INSTR_M_OUT,STALL);		//暂停机制
	
	FORWARD forward (
    .IR_D(INSTR_D_OUT), 
    .IR_E(INSTR_E_OUT), 
    .IR_M(INSTR_M_OUT), 
    .IR_W(INSTR_W_OUT), 
    .RSDOP(RSDOP), 										//转发机制
    .RTDOP(RTDOP), 
    .RSEOP(RSEOP), 
    .RTEOP(RTEOP), 
    .RTMOP(RTMOP)
    );

	GRF grf (
    .RA1(INSTR_D_OUT[25:21]), 
    .RA2(INSTR_D_OUT[20:16]), 
    .WA(WA_W_OUT), 
    .WD(WD_W_OUT), 
    .Reset(reset), 
    .clk(clk), 
    .RWE(RWE), 
    .PC(PC_W_OUT), 
    .D1(RD1_ID), 
    .D2(RD2_ID)
    );

	EXT ext(INSTR_D_OUT[15:0],EXTOP,EXT_ID);
		
	MFRSD rsd (
	 .PC8_E(PC8_E_OUT), 		//RSD转发
    .AO_M(AO_M_OUT), 
    .PC8_M(PC8_M_OUT), 
    .WD_W(WD_W_OUT), 
    .RD1(RD1_ID), 
    .RSDOP(RSDOP), 
    .RSD(RSD)
    );
	 
	 MFRTD rtd (					//RTD转发
    .PC8_E(PC8_E_OUT), 
    .AO_M(AO_M_OUT), 
    .PC8_M(PC8_M_OUT), 
    .WD_W(WD_W_OUT), 
    .RD2(RD2_ID), 
    .RTDOP(RTDOP), 
    .RTD(RTD)
    );
	 
 	CMP cmp(RSD,RTD,BEQ,BB);

 	NPC npc(INSTR_D_OUT[25:0],PC4_D_OUT,RSD,PCOP,BEQ,BB,NPC_ID);
	
	 //写入流水线寄存器ID_EX
	
	ID_EX_reg E(clk,reset,STALL,PC_D_OUT,PC4_D_OUT,PC8_D_OUT,RSD,RTD,EXT_ID,INSTR_D_OUT,PC_E_OUT,PC4_E_OUT,PC8_E_OUT,RD1_E_OUT,RD2_E_OUT,EXT_E_OUT,INSTR_E_OUT);
	
	///////////////////////////             EX             /////////////////////////

	CTRL_E ctrl_e(INSTR_E_OUT,ALUOP,ALUBOP);
	
	MFRTE rte (
    .AO_M(AO_M_OUT), 
    .PC8_M(PC8_M_OUT), 
    .WD_W(WD_W_OUT), 
    .RD2(RD2_E_OUT), 
    .RTEOP(RTEOP), 
    .RTE(RTE)
    );

	MUX_ALUB alub(EXT_E_OUT,RTE,ALUBOP,ALUB_EX);
	
	MFRSE rse (
    .AO_M(AO_M_OUT), 
    .PC8_M(PC8_M_OUT), 
    .WD_W(WD_W_OUT), 
    .RD1(RD1_E_OUT), 
    .RSEOP(RSEOP), 
    .RSE(RSE)
    );

	ALU alu(RSE,ALUB_EX,ALUOP,AO_EX);
	
	//写入流水线寄存器EX_MEM

	EX_MEM_reg M(clk,reset,enable_EM,PC_E_OUT,PC4_E_OUT,PC8_E_OUT,AO_EX,RTE,INSTR_E_OUT,PC_M_OUT,PC4_M_OUT,PC8_M_OUT,AO_M_OUT,RD2_M_OUT,INSTR_M_OUT);

	//////////////////////////////////        MEM          ////////////////////////////////
	
	CTRL_M ctrl_m(INSTR_M_OUT,WAOP,WDOP,DRE,DWE);
	
	MFRTM rtm (
    .WD_W(WD_W_OUT), 
    .RD2(RD2_M_OUT), 
    .RTMOP(RTMOP), 
    .RTM(RTM)
    );
	
	DM mem(AO_M_OUT,RTM,reset,clk,DWE,DRE,PC_M_OUT,RD_MEM);
	
	MUX_WA wa(INSTR_M_OUT[20:16],INSTR_M_OUT[15:11],WAOP,WA_MEM);
	
	MUX_WD wd(AO_M_OUT,RD_MEM,PC8_M_OUT,WDOP,WD_MEM);
	
	//写入流水线寄存器MEM_WB
	
	MEM_WB_reg W (
    .reset(reset), 
    .clk(clk), 
    .pc(PC_M_OUT), 
    .wa(WA_MEM), 
    .wd(WD_MEM), 
    .instr(INSTR_M_OUT), 
    .enable(enable_MW), 
    .PC(PC_W_OUT), 
    .WA(WA_W_OUT), 
    .WD(WD_W_OUT), 
    .INSTR(INSTR_W_OUT)
    );


	///////////////////////            WB         /////////////////////////////////////
	CTRL_W ctrl_w(INSTR_W_OUT,RWE);
	 
endmodule
