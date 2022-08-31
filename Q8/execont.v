`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:48:35 09/01/2022 
// Design Name: 
// Module Name:    execont 
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
module execont #(parameter WIDTH = 8)
					 (input [WIDTH-1:0] src1, src2, input[1:0] opcode, input clk,
					  output add_ready, mul_ready, 
					  output [WIDTH-1:0] dst
    );
	 reg add_en, mul_en, add_sub;
	 cadder cadd(.A(src1), .B(src2), .result(dst), .clk(clk), .enable(add_en),
	 .add_en(add_sub), .ready(add_ready));
	 cmult cmult(.A(src1), .B(src2), .mult(dst), .clk(clk), .enable(mul_en),
	 .ready(mul_ready));
	 always @(posedge clk) begin
	 case(opcode)
	 2'b00: begin //add
	 add_en = 1;
	 mul_en = 0;
	 add_sub = 1;
	 end
	 2'b01: begin //sub
	 add_en = 1;
	 mul_en = 0;
	 add_sub = 0;
	 end
	 2'b10: begin //mul
	 add_en = 0;
	 mul_en = 1;
	 add_sub = 0;
	 end
	 endcase
	 end

endmodule
