`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:40:22 12/12/2017 
// Design Name: 
// Module Name:    CONTROL 
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
module CONTROL(
    input [5:0] OPCode,
    input [5:0] FUNCode,
    output [1:0] WAOp,
    output [1:0] WDOp,
    output BEQOp,
    output ALUBOp,
    output [1:0] EXTOp,
    output [1:0] ALUOp,
    output DWE,
    output DRE,
    output RWE,
    output JALOp,
    output JROp
    );
	reg addu=0,subu=0,jr=0,ori=0,lw=0,sw=0,beq=0,lui=0,jal=0;
	always @* begin
		addu<=0;subu<=0;jr<=0;ori<=0;lw<=0;sw<=0;beq<=0;lui<=0;jal=0;
		case (OPCode)
			6'b000000: begin
				if (FUNCode == 6'b100001)
					addu <= 1;
				else if (FUNCode == 6'b100011)
					subu <= 1;
				else if (FUNCode == 6'b001000)
					jr <= 1;
			end
			6'b001101: ori <= 1;
			6'b100011: lw <= 1;
			6'b101011: sw <= 1;
			6'b000100: beq <= 1;
			6'b001111: lui <= 1;
			6'b000011: jal <= 1;
		endcase
	end
	assign WAOp[0] = addu | subu;
	assign WAOp[1] = jal;
	assign WDOp[0] = lw;
	assign WDOp[1] = jal;
	assign BEQOp = beq;
	assign ALUBOp = addu | subu | beq;
	assign EXTOp[0] = lw | sw | lui;
	assign EXTOp[1] = beq | lui;
	assign ALUOp[0] = subu | beq;
	assign ALUOp[1] = ori | beq;
	assign DWE = sw;
	assign DRE = lw;
	assign RWE = jal | addu | subu | ori | lw | lui;
	assign JALOp = jal;
	assign JROp = jr;
endmodule
