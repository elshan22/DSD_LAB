`timescale 1ns / 1ps
module Comparator #(parameter WORD_WIDTH = 8)
						 (input [WORD_WIDTH-1: 0] A, B,
						  output reg equal);
	
	integer i;
	
	always @(A or B) begin
		equal = 1'b1;
		for (i = 0; i < WORD_WIDTH; i=i+1)
			equal = equal & (A[i] === 1'bx || B[i] === 1'bx || A[i] == B[i]);
	end

endmodule
