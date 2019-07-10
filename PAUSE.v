`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:16:42 01/02/2018 
// Design Name: 
// Module Name:    PAUSE 
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
module PAUSE(
	input [31:0] IR_D,
	input [31:0] IR_E,
	input [31:0] IR_M,
	output stall
    );
	wire stall_b,stall_cal_r,stall_cal_i,stall_ld,stall_st,stall_j;
	wire stall_b_cal_r,stall_b_cal_i,stall_b_ld1,stall_b_ld2;
	wire stall_j_cal_r,stall_j_cal_i,stall_j_ld1,stall_j_ld2;
	
	wire beq_D;
	wire bb_D;
	wire jr_D;
	wire cal_r_D,cal_r_E;
	wire cal_i_D,cal_i_E;
	wire ld_D,ld_E,ld_M;
	wire st_D,st_E;
	
	assign beq_D = IR_D[`op] == 6'b000100;
	assign bb_D = IR_D[`op] == 6'b111111;
	assign jr_D = (IR_D[`op] == 0)&(IR_D[`func]==`jr);	
	assign cal_r_D = (IR_D[`op]==0)&(IR_D[`func]!= 0) & (IR_D[`func]!= `jr);
	assign cal_r_E = (IR_E[`op]==0)&(IR_E[`func]!= 0) & (IR_E[`func]!= `jr);
	assign cal_i_D = (IR_D[`op]==6'b001101)|(IR_D[`op]==6'b001111); 
	assign cal_i_E = (IR_E[`op]==6'b001101)|(IR_E[`op]==6'b001111); 
	assign ld_D = IR_D[`op] == 6'b100011;
	assign ld_E = IR_E[`op] == 6'b100011;
	assign ld_M = IR_M[`op] == 6'b100011;
	assign st_D = IR_D[`op] == 6'b101011;
	
	assign stall_b_cal_r = beq_D & cal_r_E & ((IR_D[`rs] == IR_E[`rd]) | (IR_D[`rt] == IR_E[`rd]));
	assign stall_b_cal_i = beq_D & cal_i_E & ((IR_D[`rs] == IR_E[`rt]) | (IR_D[`rt] == IR_E[`rt]));
	assign stall_b_ld2 = beq_D & ld_M & ((IR_D[`rs] == IR_M[`rt]) | (IR_D[`rt] == IR_M[`rt]));
	assign stall_b_ld1 = beq_D & ld_E & ((IR_D[`rs] == IR_E[`rt]) | (IR_D[`rt] == IR_E[`rt]));
	
	assign stall_j_cal_r = (jr_D | bb_D) & cal_r_E & (IR_D[`rs] == IR_E[`rd]);
	assign stall_j_cal_i = (jr_D | bb_D) & cal_i_E & (IR_D[`rs] == IR_E[`rt]);
	assign stall_j_ld2 = (jr_D | bb_D) & ld_M & (IR_D[`rs] == IR_M[`rt]);
	assign stall_j_ld1 = (jr_D | bb_D) & ld_E & (IR_D[`rs] == IR_E[`rt]);
	
	assign stall_cal_r = cal_r_D & ld_E & ((IR_D[`rs] == IR_E[`rt]) | (IR_D[`rt] == IR_E[`rt]));
	assign stall_cal_i = cal_i_D & ld_E & (IR_D[`rs] == IR_E[`rt]);
	assign stall_ld = ld_D & ld_E & (IR_D[`rs] == IR_E[`rt]);
	assign stall_st = st_D & ld_E & (IR_D[`rs] == IR_E[`rt]);
	
	assign stall_b = stall_b_cal_r | stall_b_cal_i | stall_b_ld1 | stall_b_ld2;
	
	assign stall_j = stall_j_cal_r | stall_j_cal_i | stall_j_ld1 | stall_j_ld2;

	assign stall = stall_b | stall_cal_r | stall_cal_i | stall_ld | stall_st | stall_j;
endmodule
