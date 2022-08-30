`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:34:46 08/29/2022 
// Design Name: 
// Module Name:    cmult 
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
module cmult(
    input [7:0] a,
    input [7:0] b,
    output [15:0] mul
    );
	 wire [7:0] c1, c2;
	 always @(a or b) begin
	 assign c1 = ((a[7:4]*b[7:4])-(a[3:0]*b[3:0]));
	 assign c2 = ((a[7:4]*b[3:0])+(a[3:0]*b[7:4]));
	 assign mul = {c1,c2};
	 end


endmodule
