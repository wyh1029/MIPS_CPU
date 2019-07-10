`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:50:49 12/13/2017 
// Design Name: 
// Module Name:    rfg 
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
module RegisterFile(
	input CLK,
	input reset,// ʱ��
	input RegWre, 
	input wja,// дʹ���źţ�Ϊ1ʱ����ʱ��������д��
   input [4:0] rs,            // rs�Ĵ�����ַ����˿�
   input [4:0] rt,            // rt�Ĵ�����ַ����˿�
   input [4:0] WriteReg,      // ������д��ļĴ����˿ڣ����ַ��Դrt��rd�ֶ�
   input [31:0] WriteData,
	input [31:0] WPC,
	input [31:0] jal,// д��Ĵ�������������˿�
	output [31:0] ReadData1,   // rs�Ĵ�����������˿�
   output [31:0] ReadData2    // rt�Ĵ�����������˿�
   );


	reg [31:0] register[31:0];  // �½�32���Ĵ��������ڲ���
	// ��ʼʱ����32���Ĵ���ȫ����ֵΪ0
	integer i;
	initial 
	begin
		for(i = 0; i < 32; i = i + 1)  register[i] <= 0;
	end

	// ���Ĵ���
	assign ReadData1 = (rs==0)?0:register[rs];
	assign ReadData2 = (rt==0)?0:register[rt];

	// д�Ĵ���
	always@(posedge CLK)
	begin
		if(reset)
			begin
				for(i = 0; i < 32; i = i + 1)  register[i] <= 0;
			end

		else if (RegWre)	
				if(wja==1)begin
					register[31]=jal;
					$display("@%h: $31 <= %h",WPC,jal);
				end
				else begin
					register[WriteReg]=WriteData;
					$display("@%h: $%d <= %h",WPC, WriteReg,WriteData);
				end
	end 

	

endmodule
