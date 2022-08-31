`timescale 1ns / 1ps
module Comparator #(parameter WORD_WIDTH = 8)
						 (input [2*WORD_WIDTH-1: 0] A, B,
						 input enable,
						  output reg equal);
	
	integer i;
	
	always @(posedge enable) begin
			equal = 1'b1;
			for (i = 0; i < WORD_WIDTH; i=i+1)
				equal = equal & (!A[WORD_WIDTH + i] || !B[WORD_WIDTH + i] || A[i] == B[i]);
	end

endmodule
