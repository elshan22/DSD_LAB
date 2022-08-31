`timescale 1ns / 1ps
module instruction_mem #(parameter INSTRUCTION_WIDTH = 20, MEMORY_SIZE = 32)
								(input [$clog2(MEMORY_SIZE)-1:0] addr,
								 input [INSTRUCTION_WIDTH-1:0] data_in,
								 input write_en, reset, clk,
								 output reg [INSTRUCTION_WIDTH-1:0] data_out);

	reg [INSTRUCTION_WIDTH-1:0] memory [MEMORY_SIZE-1:0];

	integer i;

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			for (i = 0 ; i < MEMORY_SIZE; i=i+1)
				memory[i] = 0;
		end else if (write_en) memory[addr] = data_in;
		else data_out = memory[addr];
	
	end

endmodule
