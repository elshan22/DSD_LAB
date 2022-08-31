`timescale 1ns / 1ps

module save_handler #(parameter DATA_WIDTH = 8, DATA_MEMORY_SIZE = 64,
										  INSTRUCTION_WIDTH = 3 * $clog2(DATA_MEMORY_SIZE) + 2)
							(input [$clog2(DATA_MEMORY_SIZE)-1:0] dst_addr,
							 input [DATA_WIDTH-1:0] data_in,
							 input enable, clk,
							 output reg [$clog2(DATA_MEMORY_SIZE)-1:0] addr_out,
							 output reg [DATA_WIDTH-1:0] data_out,
							 output reg ready);
		
	reg counter;
	
	always @(posedge clk) begin
	
		if (enable) begin
			case (counter)
				1'b1: begin
					ready = 1'b1;
					counter = 1'b0;
				end
				1'b0: begin
					addr_out = dst_addr;
					data_out = data_in;
					ready = 1'b0;
					counter = 1'b1;
				end
			endcase
		end else begin
			ready = 1'b0;
			counter = 1'b0;
		end
	
	end

endmodule
