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
module cmult #(parameter WIDTH = 8)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
	 input clk, 
	 input enable,
    output reg[WIDTH-1:0] mulr,
	 output reg[WIDTH-1:0] muli
    );
	 reg [WIDTH/2-1:0] m1, m2, m4, m5, m7, m8, m10, m11;
	 wire [WIDTH-1:0] m3, m6, m9, m12;
	 reg [WIDTH-1:0] a1, a2, a4, a5;
	 wire [WIDTH-1:0] a3, a6;
	 mul mul0(m1, m2, m3);
	 mul mul1(m4, m5, m6);
	 mul mul2(m7, m8, m9);
	 mul mul3(m10, m11, m12);
	 adder add0(a1, a2, a3);
	 adder add1(a4, a5, a6);
	 always @(posedge clk) begin
	 if(enable) begin
	 m1 = a[WIDTH-1:WIDTH/2];
	 m2 = b[WIDTH-1:WIDTH/2];
	 a1 = m3;
	 m4 = a[WIDTH/2-1:0];
	 m5 = b[WIDTH/2-1:0];
	 a2 = -m6;
	 mulr = a3;
	 m7 = a[WIDTH-1:WIDTH/2];
	 m8 = b[WIDTH/2-1:0];
	 a4 = m9;
	 m10 = a[WIDTH/2-1:0];
	 m11 = b[WIDTH-1:WIDTH/2];
	 a5 = m12;
	 muli = a6;
	 end
	 end
endmodule
