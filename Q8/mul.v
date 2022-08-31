`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:29:24 08/31/2022 
// Design Name: 
// Module Name:    mul 
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
module mul #(parameter WIDTH = 8)(
    input [WIDTH/2-1:0] a,
    input [WIDTH/2-1:0] b,
    output reg[WIDTH-1:0] p
    );
	 always @(a or b) begin
	 p = a*b;
	 end
	 
endmodule
