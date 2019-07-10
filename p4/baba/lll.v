`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:46 12/13/2017 
// Design Name: 
// Module Name:    lll 
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
module ControlUnit(
    input [5:0] op,
	 input [5:0] fun,	 
    input zero,           
	 
	 // 一堆控制信号
	 output reg regdst,           
    output reg alusrc,           
    output reg regwrite,         
    output reg memwrite,     
    output reg wbeq,         
    output reg memtoreg,       
    output reg ext1,      
    output reg ext2,         
	 output reg [2:0] aluop,  
	output reg wja,
	output reg wjr
    );

	// 进行各种赋值


	always@(op or zero or fun)
   begin  
		case(op) 
			6'b000000:
         begin   
				if(fun == 6'b100001||fun == 6'b100000)begin
				regdst = 1;
				alusrc = 0;
				regwrite = 1;
				memwrite = 0;
				wbeq = 0;
				memtoreg = 0;
				ext1 = 0;
				ext2 = 0;
				aluop = 3'b000;
				wja = 0;
				wjr = 0;
			end
			else if (fun == 6'b100011||fun == 6'b100010)begin
				regdst = 1;
				alusrc = 0;
				regwrite = 1;
				memwrite = 0;
				wbeq = 0;
				memtoreg = 0;
				ext1 = 0;
				ext2 = 0;
				aluop = 3'b001;
				wja = 0;
				wjr = 0;
			end
			else if (fun == 6'b001000)begin
				regdst = 0;
				alusrc = 0;
				regwrite = 0;
				memwrite = 0;
				wbeq = 0;
				memtoreg = 0;
				ext1 = 0;
				ext2 = 0;
				aluop = 3'b000;
				wja = 0;
				wjr = 1;
			end
			else if (fun == 6'b000000)begin
				regdst = 0;
				alusrc = 0;
				regwrite = 0;
				memwrite = 0;
				wbeq = 0;
				memtoreg = 0;
				ext1 = 0;
				ext2 = 0;
				aluop = 3'b000;
				wja = 0;
				wjr = 0;
			end
			end
	
			6'b001101:
         begin   //以下都是控制单元产生的控制信号
				regdst = 0;
				alusrc = 1;
				regwrite = 1;
				memwrite = 0;
				wbeq = 0;
				memtoreg = 0;
				ext1 = 1;
				ext2 = 0;
				aluop = 3'b010;
				wja = 0;
				wjr = 0;
			end
		
			6'b100011:
         begin   //以下都是控制单元产生的控制信号
				regdst = 0;
				alusrc = 1;
				regwrite = 1;
				memwrite = 0;
				wbeq = 0;
				memtoreg = 1;
				ext1 = 0;
				ext2 = 1;
				aluop = 3'b000;
				wja = 0;
				wjr = 0;				
			end
		
			6'b101011:
			begin   //以下都是控制单元产生的控制信号
				regdst = 0;
				alusrc = 1;
				regwrite = 0;
				memwrite = 1;
				wbeq = 0;
				memtoreg = 0;
				ext1 = 0;
				ext2 = 1;
				aluop = 3'b000;
				wja = 0;
				wjr = 0;
         end
	
         6'b000100:
         begin   //以下都是控制单元产生的控制信号
				regdst = 0;
				alusrc = 0;
				regwrite = 0;
				memwrite = 0;
				if(zero)
					wbeq=1;
				else 
					wbeq=0;
				memtoreg = 0;
				ext1 = 0;
				ext2 = 1;
				aluop = 3'b000;
				wja = 0;
				wjr = 0;
         end

			6'b001111:
         begin   //以下都是控制单元产生的控制信号
				regdst = 0;
				alusrc = 1;
				regwrite = 1;
				memwrite = 0;
				wbeq = 0;
				memtoreg = 0;
				ext1 = 0;
				ext2 = 0;
				aluop = 3'b000;
				wja = 0;
				wjr = 0;
			end
			
			6'b000011:
         begin   //以下都是控制单元产生的控制信号
				regdst = 0;
				alusrc = 0;
				regwrite = 1;
				memwrite = 0;
				wbeq = 0;
				memtoreg = 0;
				ext1 = 0;
				ext2 = 0;
				aluop = 3'b000;
				wja = 1;
				wjr = 0;
			end


		endcase
	end

endmodule