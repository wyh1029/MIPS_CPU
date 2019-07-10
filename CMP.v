`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:06:11 12/26/2017 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
    input [31:0] A,
    input [31:0] B,
    output Zero,
	 output BB
    );
	 reg zero,bb;
	always @* begin
		if (A==B)
			zero <= 1;
		if ($signed(A)<=0) 
			bb <= 1;
		else begin
			bb <= 0;
			zero <= 0;
		end
	end 
	assign Zero = zero;
	assign BB = bb;
endmodule
