`timescale 1ns / 1ps

module data_mem #(parameter DATA_WIDTH = 8, MEMORY_SIZE = 64)
					  (input clk,
						input [$clog2(MEMORY_SIZE)-1:0] addr,
						input [DATA_WIDTH-1:0] write_data,
						input write_en,
						input reset,
						output [DATA_WIDTH-1:0] read_data);
						
	 reg [DATA_WIDTH-1:0] mem [MEMORY_SIZE-1:0];
	 integer i;
	 
	 always @(posedge clk or negedge reset) begin
		if (!reset) begin
			for (i = 0 ; i < MEMORY_SIZE; i=i+1)
				mem[i] = 0;
		end else if(write_en) mem[addr] = write_data;
		else read_data = mem[addr];
	 end
endmodule
