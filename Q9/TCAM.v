`timescale 1ns / 1ps
module TCAM #(parameter WORD_WIDTH = 8, parameter MEMORY_SIZE = 20)
				 (input [WORD_WIDTH-1: 0] A, K,
				  input [$clog2(MEMORY_SIZE)-1: 0] write_addr,
				  input read, write, reset, clk,
				  output [MEMORY_SIZE-1: 0] matched);
	
	reg [2*WORD_WIDTH-1: 0] memory [MEMORY_SIZE-1: 0];
	
	reg [2*WORD_WIDTH-1: 0] search_reg;
	
	reg enable;
	
	genvar i;
	
	integer j;
	
	generate
		for (i = 0 ; i < MEMORY_SIZE; i=i+1)
			Comparator #(.WORD_WIDTH(WORD_WIDTH)) comparator (memory[i], {K, A}, enable, matched[i]);
	endgenerate
	
	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			enable = 1'b0;
			search_reg = 0;
			for (j = 0; j < MEMORY_SIZE; j=j+1)
				memory[j] = {{WORD_WIDTH{1'b1}}, {WORD_WIDTH{1'b0}}};
		end else if (read)	enable = 1'b1;
			 else if (write)	begin
				memory[write_addr] = {K, A};
				enable = 1'b0;
			 end
	end
	
endmodule
