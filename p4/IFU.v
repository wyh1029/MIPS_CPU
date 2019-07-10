`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:09:13 12/12/2017 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
    input clk,
    input Reset,
    input [31:0] EXT,
    input BEQOp,
    input BEQZero,
    input JALOp,
    input JROp,
    input [31:0] JRAdd,
	 output [31:0]PC,
    output [31:0] PC4,
    output [31:0] Instr
    );
	reg [31:0]IFROM[1023:0];
	reg [31:0] pc;
	wire [31:0]JALAdd;
	integer i = 0;
	assign JALAdd[1:0] = 0;
	assign JALAdd[27:2] = Instr[25:0];
   assign JALAdd[31:28] = PC[31:28];	
	
	initial begin
		$readmemh("code.txt",IFROM);
	end
	initial begin
		pc = 32'b11000000000000;
	end

	//改变pc，下一条指令输入
	always @(posedge clk) begin
		if (Reset)
			pc <= 32'b11000000000000;
		else if ((BEQOp) && (BEQZero))
			pc <= EXT + PC + 4;
		else if (JALOp)
			pc <= JALAdd;
		else if (JROp)
			pc <= JRAdd;
		else 
			pc <= PC + 4;
	end
	assign PC = pc;
	assign Instr = IFROM[PC[31:2]-32'b110000000000];
	assign PC4 = PC + 4;
endmodule
