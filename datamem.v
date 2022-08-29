`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:00:06 08/29/2022 
// Design Name: 
// Module Name:    datamem 
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
module datamem(
    input clk,
    input [5:0] read_adr1, read_adr2,
	 input [5:0] write_adr,
    input [7:0] write_data,
    input write_en,
    input read,
    output [7:0] read_data1, read_data2
    );
	 reg [7:0] mem [63:0];
	 integer i;
	 initial begin
	 for(i=0; i< 64; i=i+1)
	 if(i<4)
	 mem[i] <= i+1;
	 else
	 mem[i] <= 8'd0;
	 end
	 always @(posedge clk) begin
	 if(write_en)
	 mem[write_adr] <= write_data;
	 end
	 assign read_data1 = (read == 1'b1)?mem[read_adr1]:8'd0;
	 assign read_data2 = (read == 1'b1)?mem[read_adr2]:8'd0;
endmodule
