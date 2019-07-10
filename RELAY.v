`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:42:27 01/02/2018 
// Design Name: 
// Module Name:    RELAY 
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
`define rs [25:21]
`define rt [20:16]
`define rd [15:11]
`define op [31:26]
`define func [5:0] 

module MFRSD(
	input [31:0] PC8_E,
	input [31:0] AO_M,
	input [31:0] PC8_M,
	input [31:0] WD_W,
	input [31:0] RD1,
	input [2:0] RSDOP,
	output reg [31:0] RSD
    );
	always @* begin
		case (RSDOP)
		0: RSD <= RD1;
		1: RSD <= PC8_E;
		2: RSD <= AO_M;
		3: RSD <= PC8_M;
		4: RSD <= WD_W;
		endcase
	end
endmodule

module MFRTD(
	input [31:0] PC8_E,
	input [31:0] AO_M,
	input [31:0] PC8_M,
	input [31:0] WD_W,
	input [31:0] RD2,
	input [2:0] RTDOP,
	output reg [31:0] RTD
    );
	always @* begin
		case (RTDOP)
		0: RTD <= RD2;
		1: RTD <= PC8_E;
		2: RTD <= AO_M;
		3: RTD <= PC8_M;
		4: RTD <= WD_W;
		endcase
	end
endmodule


module MFRSE(
	input [31:0] AO_M,
	input [31:0] PC8_M,
	input [31:0] WD_W,
	input [31:0] RD1,
	input [1:0] RSEOP,
	output reg [31:0] RSE
	);
	always @* begin
		case (RSEOP)
			0: RSE <= RD1;
			1: RSE <= AO_M;
			2: RSE <= PC8_M;
			3: RSE <= WD_W;
		endcase	
	end
endmodule

module MFRTE(
	input [31:0] AO_M,
	input [31:0] PC8_M,
	input [31:0] WD_W,
	input [31:0] RD2,
	input [1:0] RTEOP,
	output reg [31:0] RTE
	);
	always @* begin
		case (RTEOP)
			0: RTE <= RD2;
			1: RTE <= AO_M;
			2: RTE <= PC8_M;
			3: RTE <= WD_W;
		endcase	
	end	
endmodule

module MFRTM(
	input [31:0] WD_W,
	input [31:0] RD2,
	input RTMOP,
	output reg [31:0] RTM
	);
	always @* begin
		case (RTMOP)
			0: RTM <= RD2;
			1: RTM <= WD_W;
		endcase
	end
endmodule






