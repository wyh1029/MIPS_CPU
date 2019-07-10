`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:45:07 01/04/2018 
// Design Name: 
// Module Name:    FORWARD 
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
`define op 31:26
`define func 5:0
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define beq 6'b000100
`define jr 6'b001000
module FORWARD(
	input [31:0] IR_D,
	input [31:0] IR_E,
	input [31:0] IR_M,
	input [31:0] IR_W,
	output [2:0] RSDOP,
	output [2:0] RTDOP,
	output [1:0] RSEOP,
	output [1:0] RTEOP,
	output RTMOP
    );
	
	wire jr_D;
	wire bb_D,bb_E,bb_M,bb_W;
	wire cal_r_D,cal_r_E,cal_r_M,cal_r_W;
	wire cal_i_D,cal_i_E,cal_i_M,cal_i_W;
	wire ld_D,ld_E,ld_W;
	wire st_D,st_E,st_M;
	wire jal_E,jal_M,jal_W;
	
	assign jr_D = (IR_D[`op]==0 & IR_D[`func]==`jr);
	assign cal_r_D = (IR_D[`op]==0)&(IR_D[`func]!= 0) & (IR_D[`func]!= `jr);
	assign cal_r_E = (IR_E[`op]==0)&(IR_E[`func]!= 0) & (IR_E[`func]!= `jr);
	assign cal_r_M = (IR_M[`op]==0)&(IR_M[`func]!= 0) & (IR_M[`func]!= `jr);
	assign cal_r_W = (IR_W[`op]==0)&(IR_W[`func]!= 0) & (IR_W[`func]!= `jr);
	assign cal_i_D = (IR_D[`op]==6'b001101)|(IR_D[`op]==6'b001111); 
	assign cal_i_E = (IR_E[`op]==6'b001101)|(IR_E[`op]==6'b001111); 
	assign cal_i_M = (IR_M[`op]==6'b001101)|(IR_M[`op]==6'b001111);
	assign cal_i_W = (IR_W[`op]==6'b001101)|(IR_W[`op]==6'b001111);
	assign ld_D = IR_D[`op] == 6'b100011;
	assign ld_E = IR_E[`op] == 6'b100011;
	assign ld_W = IR_W[`op] == 6'b100011;
	assign st_D = IR_D[`op] == 6'b101011;
	assign st_E = IR_E[`op] == 6'b101011;
	assign st_M = IR_M[`op] == 6'b101011;
	assign jal_E = IR_E[`op] == 6'b000011;
	assign jal_M = IR_M[`op] == 6'b000011;
	assign jal_W = IR_W[`op] == 6'b000011;
	assign bb_D = IR_D[`op] == 6'b111111;
	assign bb_E = IR_E[`op] == 6'b111111;
	assign bb_M = IR_M[`op] == 6'b111111;
	assign bb_W = IR_W[`op] == 6'b111111;

	assign RSDOP = 
		(IR_D[`op]==`beq|jr_D|bb_D) & jal_E & IR_D[`rs] == 31 ? 1 :
//		(IR_D[`op]==`beq|jr_D|bb_D) & bb_E & IR_D[`rs] == 31 ? 1 :	
//		(IR_D[`op]==`beq|jr_D|bb_D) & bb_E & IR_D[`rs] == IR_E[`rd] & IR_E[`rd]!=0 ? 1 :	
		(IR_D[`op]==`beq|jr_D|bb_D) & cal_r_M & IR_D[`rs]==IR_M[`rd] & IR_M[`rd]!=0 ? 2 :
		(IR_D[`op]==`beq|jr_D|bb_D) & cal_i_M & IR_D[`rs]==IR_M[`rt] & IR_M[`rt]!=0 ? 2 :
		(IR_D[`op]==`beq|jr_D|bb_D) & (jal_M) & IR_D[`rs] == 31 ? 3 :
//		(IR_D[`op]==`beq|jr_D|bb_D) & bb_M & IR_D[`rs] == 31 ? 1 :	
//		(IR_D[`op]==`beq|jr_D|bb_D) & bb_M & IR_D[`rs] == IR_M[`rd] & IR_M[`rd]!=0 ? 1 :	
		(IR_D[`op]==`beq|cal_r_D|cal_i_D|ld_D|st_D|jr_D|bb_D) & cal_r_W & IR_D[`rs]==IR_W[`rd] & IR_W[`rd]!=0 ? 4 :
		(IR_D[`op]==`beq|cal_r_D|cal_i_D|ld_D|st_D|jr_D|bb_D) & cal_i_W & IR_D[`rs]==IR_W[`rt] & IR_W[`rt]!=0 ? 4 :
		(IR_D[`op]==`beq|cal_r_D|cal_i_D|ld_D|st_D|jr_D|bb_D) & ld_W    & IR_D[`rs]==IR_W[`rt] & IR_W[`rt]!=0 ? 4 :
		(IR_D[`op]==`beq|cal_r_D|cal_i_D|ld_D|st_D|jr_D|bb_D) & (jal_W) & IR_D[`rs] == 31 ? 4 :
//		(IR_D[`op]==`beq|cal_r_D|cal_i_D|ld_D|st_D|jr_D|bb_D) & bb_M & IR_D[`rs] == 31 ? 1 :	
//		(IR_D[`op]==`beq|cal_r_D|cal_i_D|ld_D|st_D|jr_D|bb_D) & bb_M & IR_D[`rs] == IR_M[`rd] & IR_M[`rd]!=0 ? 1 :	
		 0 ;
	
	assign RTDOP =
		(IR_D[`op]==`beq) & (jal_E) & IR_D[`rt] == 31 ? 1 :
//		(IR_D[`op]==`beq|bb_D) & bb_E & IR_D[`rt] == 31 ? 1 :	
//		(IR_D[`op]==`beq|bb_D) & bb_E & IR_D[`rt] == IR_E[`rd] & IR_E[`rd]!=0 ? 1 :			
		(IR_D[`op]==`beq) & cal_r_M & IR_D[`rt]==IR_M[`rd] & IR_M[`rd]!=0 ? 2 :
		(IR_D[`op]==`beq) & cal_i_M & IR_D[`rt]==IR_M[`rt] & IR_M[`rt]!=0 ? 2 :
		(IR_D[`op]==`beq) & (jal_M) & IR_D[`rt] == 31 ? 3 :
//		(IR_D[`op]==`beq|bb_D) & bb_M & IR_D[`rt] == 31 ? 1 :	
//		(IR_D[`op]==`beq|bb_D) & bb_M & IR_D[`rt] == IR_M[`rd] & IR_M[`rd]!=0 ? 1 :			
		(IR_D[`op]==`beq|cal_r_D|cal_i_D|ld_D|st_D|bb_D) & cal_r_W & IR_D[`rt]==IR_W[`rd] & IR_W[`rd]!=0 ? 4 :
		(IR_D[`op]==`beq|cal_r_D|cal_i_D|ld_D|st_D|bb_D) & cal_i_W & IR_D[`rt]==IR_W[`rt] & IR_W[`rt]!=0 ? 4 :
		(IR_D[`op]==`beq|cal_r_D|cal_i_D|ld_D|st_D|bb_D) & ld_W    & IR_D[`rt]==IR_W[`rt] & IR_W[`rt]!=0 ? 4 :
		(IR_D[`op]==`beq|cal_r_D|cal_i_D|ld_D|st_D|bb_D) & (jal_W|bb_W) & IR_D[`rt] == 31 ? 4 :
//		(IR_D[`op]==`beq|cal_r_D|cal_i_D|ld_D|st_D|bb_D) & bb_W & IR_D[`rt] == 31 ? 1 :	
//		(IR_D[`op]==`beq|cal_r_D|cal_i_D|ld_D|st_D|bb_D) & bb_W & IR_D[`rt] == IR_W[`rd] & IR_W[`rd]!=0 ? 1 :			
		 0 ;
	
	assign RSEOP =
		(cal_r_E|cal_i_E|ld_E|st_E) & cal_r_M & IR_E[`rs]==IR_M[`rd] & IR_M[`rd]!=0 ? 1 :
		(cal_r_E|cal_i_E|ld_E|st_E) & cal_i_M & IR_E[`rs]==IR_M[`rt] & IR_M[`rt]!=0 ? 1 :
		(cal_r_E|cal_i_E|ld_E|st_E) & (jal_M) & IR_E[`rs] == 31 ? 2 :
//		(cal_r_E|cal_i_E|ld_E|st_E) & (bb_M) & IR_E[`rs] == 31 ? 2 :
//		(cal_r_E|cal_i_E|ld_E|st_E) & (bb_M) & IR_E[`rs] == IR_M[`rd] & IR_M[`rd]!=0 ? 2 :
		(cal_r_E|cal_i_E|ld_E|st_E) & cal_r_W & IR_E[`rs]==IR_W[`rd] &IR_W[`rd]!=0 ? 3 :
		(cal_r_E|cal_i_E|ld_E|st_E) & cal_i_W & IR_E[`rs]==IR_W[`rt] &IR_W[`rt]!=0 ? 3 :
		(cal_r_E|cal_i_E|ld_E|st_E) & ld_W    & IR_E[`rs]==IR_W[`rt] &IR_W[`rt]!=0 ? 3 :
		(cal_r_E|cal_i_E|ld_E|st_E) & (jal_W) & (IR_E[`rs]==31) ? 3 : 
//		(cal_r_E|cal_i_E|ld_E|st_E) & (bb_W) & IR_E[`rs] == 31 ? 2 :
//		(cal_r_E|cal_i_E|ld_E|st_E) & (bb_W) & IR_E[`rs] == IR_W[`rd] & IR_W[`rd]!=0 ? 2 :
		 0 ;
	
	assign RTEOP =
		(cal_r_E|st_E) & cal_r_M & IR_E[`rt]==IR_M[`rd]&IR_M[`rd]!=0 ? 1 :
		(cal_r_E|st_E) & cal_i_M & IR_E[`rt]==IR_M[`rt]&IR_M[`rt]!=0 ? 1 :
		(cal_r_E|st_E) & (jal_M) & IR_E[`rt]==31 ? 2 :
//		(cal_r_E|st_E) & IR_E[`rt] == IR_M[`rd] & IR_M[`rd]!=0 ? 3 :	
		(cal_r_E|st_E) & cal_r_W & IR_E[`rt]==IR_W[`rd]&IR_W[`rd]!=0 ? 3 :
		(cal_r_E|st_E) & cal_i_W & IR_E[`rt]==IR_W[`rt]&IR_W[`rt]!=0 ? 3 :
		(cal_r_E|st_E) & ld_W    & IR_E[`rt]==IR_W[`rt]&IR_W[`rt]!=0 ? 3 :
		(cal_r_E|st_E) & (jal_W) & IR_E[`rt]==31 ? 3 :
//		(cal_r_E|st_E) & IR_E[`rt] == IR_W[`rd] & IR_W[`rd]!=0 ? 3 :	
		 0 ;
	
	assign RTMOP = 
		st_M & cal_r_W & IR_M[`rt]==IR_W[`rd]&IR_W[`rd]!=0 ? 1 :
		st_M & cal_i_W & IR_M[`rt]==IR_W[`rt]&IR_W[`rt]!=0 ? 1 :
		st_M & ld_W	& IR_M[`rt]==IR_W[`rt]&IR_W[`rt]!=0 ? 1 :
		st_M & (jal_W) & IR_M[`rt]==31 ? 1 :
//		st_M & (bb_W) & IR_M[`rt] == IR_W[`rd] & IR_W[`rd]!=0 ? 1 :	
		0 ;
	
endmodule
