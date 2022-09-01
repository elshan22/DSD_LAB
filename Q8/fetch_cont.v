`timescale 1ns / 1ps
module fetch_cont #(parameter INS_MEMORY_SIZE = 32, DATA_MEMORY_SIZE = 64, WIDTH = 3*$clog2(DATA_MEMORY_SIZE) + 2)
						 (input [$clog2(INS_MEMORY_SIZE)-1:0] pc, input clk,
						  output reg [1:0] opcode,
						  output reg [$clog2(DATA_MEMORY_SIZE)-1:0] src1, src2, dst,
						  output reg ready = 1'b0,
						  output reg finished);
	 wire[$clog2(INS_MEMORY_SIZE)-1:0] mar;
	 wire[WIDTH-1:0] mir;
	 assign mar = pc;
	 reg counter;
	 instruction_mem #(.INSTRUCTION_WIDTH(WIDTH), .MEMORY_SIZE(INS_MEMORY_SIZE)) im
	 (.addr(mar), .data_in({WIDTH{1'b0}}), .write_en(1'b0), .clk(clk),
	 .reset(reset), .data_out(mir));
	 
	 always @(posedge clk) begin
	 if (!finished) begin
			case (counter)
				1'b1: begin
					ready = 1'b1;
					counter = 1'b0;
					if (opcode == 2'b00) finished = 1'b1;
				end
				1'b0: begin
					src1 = mir[(WIDTH-2)/3 - 1:0];
					src2 = mir[2*(WIDTH-2)/3 - 1: (WIDTH-2)/3];
					dst = mir[WIDTH-3: 2*(WIDTH-2)/3];
					opcode = mir[WIDTH-1: WIDTH-2];
					counter = 1'b1;
					ready = 1'b0;
				end
			endcase
		 end
	 end
endmodule
