`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:01:14 12/27/2017 
// Design Name: 
// Module Name:    CTRL 
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
//D级控制信号
module CTRL_D(
	input [31:0] instr,
	output [2:0] PCOp,
	output [1:0] EXTOp,
	output NPC
    );
	reg addu,subu,ori,lui,lw,sw,beq,j,jal,jr,bb; 
	wire [5:0]OPCode,FUNCode;
	assign OPCode = instr[31:26];
	assign FUNCode = instr[5:0];
	always @* begin
	addu<=0;subu<=0;ori<=0;lui<=0;lw<=0;sw<=0;beq<=0;j<=0;jal<=0;jr<=0;bb<=0;
		if (OPCode == 6'b000000) begin
			case (FUNCode)
				6'b100001: addu <= 1;
				6'b100011: subu <= 1;
				6'b001000: jr <= 1;
			endcase
		end
		else if (OPCode == 6'b001101) ori <= 1;
		else if (OPCode == 6'b001111) lui <= 1;
		else if (OPCode == 6'b100011) lw <= 1;
		else if (OPCode == 6'b101011) sw <= 1;
		else if (OPCode == 6'b000100) beq <= 1;
		else if (OPCode == 6'b000010) j <= 1;
		else if (OPCode == 6'b000011) jal <= 1;
		else if (OPCode == 6'b111111) bb <= 1;
	end
	assign PCOp[0] = j | jal | beq;
	assign PCOp[1] = jr | beq;
	assign PCOp[2] = bb;
	assign EXTOp[0] = lw | sw;
	assign EXTOp[1] = lui;
	assign NPC = j | jal | jr | beq;
endmodule

//E级控制信号
module CTRL_E(
	input [31:0] instr,
	output [1:0] ALUOp,
	output ALUBOp
	);
	reg addu,subu,ori,lui,lw,sw,beq,j,jal,jr,bb; 
	wire [5:0]OPCode,FUNCode;
	assign OPCode = instr[31:26];
	assign FUNCode = instr[5:0];
	always @* begin
	addu<=0;subu<=0;ori<=0;lui<=0;lw<=0;sw<=0;beq<=0;j<=0;jal<=0;jr<=0;bb<=0;
		if (OPCode == 6'b000000) begin
			case (FUNCode)
				6'b100001: addu <= 1;
				6'b100011: subu <= 1;
				6'b001000: jr <= 1;
			endcase
		end
		else if (OPCode == 6'b001101) ori <= 1;
		else if (OPCode == 6'b001111) lui <= 1;
		else if (OPCode == 6'b100011) lw <= 1;
		else if (OPCode == 6'b101011) sw <= 1;
		else if (OPCode == 6'b000100) beq <= 1;
		else if (OPCode == 6'b000010) j <= 1;
		else if (OPCode == 6'b000011) jal <= 1;
		else if (OPCode == 6'b111111) bb <= 1;
	end
	
	assign ALUBOp = addu | subu;
	assign ALUOp[0] =  subu;
	assign ALUOp[1] = ori;
endmodule 

//M级控制信号
module CTRL_M(
	input [31:0] instr,
	output [1:0]WAOp,
	output [1:0]WDOp,
	output DRE,
	output DWE
	);
	reg addu,subu,ori,lui,lw,sw,beq,j,jal,jr,bb; 
	wire [5:0]OPCode,FUNCode;
	assign OPCode = instr[31:26];
	assign FUNCode = instr[5:0];
	always @* begin
	addu<=0;subu<=0;ori<=0;lui<=0;lw<=0;sw<=0;beq<=0;j<=0;jal<=0;jr<=0;bb<=0;
		if (OPCode == 6'b000000) begin
			case (FUNCode)
				6'b100001: addu <= 1;
				6'b100011: subu <= 1;
				6'b001000: jr <= 1;
			endcase
		end
		else if (OPCode == 6'b001101) ori <= 1;
		else if (OPCode == 6'b001111) lui <= 1;
		else if (OPCode == 6'b100011) lw <= 1;
		else if (OPCode == 6'b101011) sw <= 1;
		else if (OPCode == 6'b000100) beq <= 1;
		else if (OPCode == 6'b000010) j <= 1;
		else if (OPCode == 6'b000011) jal <= 1;
		else if (OPCode == 6'b111111) bb <= 1;
	end
	assign WDOp[0] = lw;
	assign WDOp[1] = jal;
	assign WAOp[0] = addu | subu;
	assign WAOp[1] = jal | bb;
	assign DWE = sw;
	assign DRE = lw;	
endmodule

//W级控制信号
module CTRL_W(
	input [31:0] instr,
	output RWE
	);
	reg addu,subu,ori,lui,lw,sw,beq,j,jal,jr,bb; 
	wire [5:0]OPCode,FUNCode;
	assign OPCode = instr[31:26];
	assign FUNCode = instr[5:0];
	always @* begin
	addu<=0;subu<=0;ori<=0;lui<=0;lw<=0;sw<=0;beq<=0;j<=0;jal<=0;jr<=0;bb<=0;
		if (OPCode == 6'b000000) begin
			case (FUNCode)
				6'b100001: addu <= 1;
				6'b100011: subu <= 1;
				6'b001000: jr <= 1;
			endcase
		end
		else if (OPCode == 6'b001101) ori <= 1;
		else if (OPCode == 6'b001111) lui <= 1;
		else if (OPCode == 6'b100011) lw <= 1;
		else if (OPCode == 6'b101011) sw <= 1;
		else if (OPCode == 6'b000100) beq <= 1;
		else if (OPCode == 6'b000010) j <= 1;
		else if (OPCode == 6'b000011) jal <= 1;
		else if (OPCode == 6'b111111) bb <= 1;
	end

	assign RWE = addu | subu | ori | lui | jal | lw | bb;	
endmodule
