`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:14 08/29/2022 
// Design Name: 
// Module Name:    controller 
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
module controller(input[1:0] opcode, input reset, input[6:0] src1, src2, dst, output reg read, write, output reg [5:0] write_adr,
read_adr1, read_adr2, output reg [2:0] aluop
    );
	 always @(*)
	 begin
	 if(reset == 1'b1) begin
	 read = 1'b0;
	 write = 1'b0;
	 write_adr = 6'd0;
	 read_adr1 = 6'd0;
	 read_adr2 = 6'd0;
	 aluop = 2'b00;
	 end
	 else begin
	 case(opcode)
	 2'b00: begin //add
	 read = 1'b1;
	 write = 1'b1;
	 write_adr = dst;
	 read_adr1 = src1;
	 read_adr2 = src2;
	 aluop = 2'b00;
	 end
	 2'b01: begin //sub
	 read = 1'b1;
	 write = 1'b1;
	 write_adr = dst;
	 read_adr1 = src1;
	 read_adr2 = src2;
	 aluop = 2'b01;
	 end
	 2'b10: begin //mul
	 read = 1'b1;
	 write = 1'b1;
	 write_adr = dst;
	 read_adr1 = src1;
	 read_adr2 = src2;
	 aluop = 2'b10;
	 end
	 endcase
	 end
	 end
endmodule
