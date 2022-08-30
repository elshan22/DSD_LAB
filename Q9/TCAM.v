`timescale 1ns / 1ps
module TCAM #(parameter WORD_WIDTH = 8, parameter MEMORY_SIZE = 20)
				 (input [WORD_WIDTH-1: 0] A, K,
				  input [$clog2(MEMORY_SIZE)-1: 0] write_addr,
				  input read, write, reset, clk,
				  output [MEMORY_SIZE-1: 0] matched);
	
	reg [WORD_WIDTH-1: 0] memory [MEMORY_SIZE-1: 0];
	
	reg [WORD_WIDTH-1: 0] result_reg;
	reg [WORD_WIDTH-1: 0] search_reg;
	
	genvar i;
	
	integer j;
	
	generate
		for (i = 0 ; i < MEMORY_SIZE; i=i+1)
			Comparator #(.WORD_WIDTH(WORD_WIDTH)) comparator (memory[i], search_reg, matched[i]);
	endgenerate
	
	always @(posedge clk or negedge reset) begin
	
		if (!reset) begin
			result_reg = 0;
			for (j = 0; j < MEMORY_SIZE; j=j+1)
				memory[j] = 0;
		end else begin
			for (j = 0; j < WORD_WIDTH; j=j+1)
				result_reg[j] = (K[j])? A[j]: 1'bx;
			search_reg = (read)? result_reg: search_reg;
			memory[write_addr] = (!read & write)? result_reg: memory[write_addr];
		end
	
	end
	
endmodule
