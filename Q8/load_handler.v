`timescale 1ns / 1ps

module load_handler #(parameter DATA_WIDTH = 8, DATA_MEMORY_SIZE = 64)
							(input [1:0] opcode_in,
							 input [$clog2(DATA_MEMORY_SIZE)-1:0] src1_addr, src2_addr, dst_addr,
							 input [DATA_WIDTH-1:0] data_in,
							 input enable, clk,
							 output reg [1:0] opcode_out,
							 output reg [DATA_WIDTH-1:0] src1, src2,
							 output reg [$clog2(DATA_MEMORY_SIZE)-1:0] addr_out, dst_out,
							 output reg ready = 1'b0);
		
	reg [1:0] counter;
	
	reg [$clog2(DATA_MEMORY_SIZE)-1:0] src1_adr, src2_adr, dst_adr;
	
	always @(posedge clk) begin
	
		if (enable) begin
			case (counter)
				2'd2: begin
					src2 = data_in;
					opcode_out = opcode;
					dst_out = dst_adr;
					ready = 1'b1;
					counter = 2'd0;
				end
				2'd1: begin
					src1 = data_in;
					addr_out = src2_adr;
					counter = 2'd2;
				end
				2'd0: begin
					src1_adr = src1_addr;
					src2_adr = src2_addr;
					dst_adr = dst_addr;
					addr_out = src1_adr;
					ready = 1'b0;
					counter = 2'd1;
				end
			endcase
		end else begin
			counter = 2'd0;
		end
	
	end

endmodule
