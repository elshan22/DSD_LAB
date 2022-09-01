`timescale 1ns / 1ps

module cadder #(parameter DATA_WIDTH = 8)
					(input [DATA_WIDTH-1:0] A, B,
					 input add_en,
					 input enable, clk,
					 output reg ready,
					 output reg [DATA_WIDTH-1:0] result);
	 
	 reg [1:0] counter;
	 
	 reg [DATA_WIDTH/2 - 1: 0] src1;
	 reg [DATA_WIDTH/2 - 1: 0] src2;
	 wire [DATA_WIDTH/2 - 1: 0] dst;
	 
	 adder #(DATA_WIDTH/2) adder (src1, src2, add_en, dst);

	always @(posedge clk) begin
		if (enable) begin
			case (counter)
				2'd2: begin
					result[DATA_WIDTH/2 - 1:0] = dst;
					counter = 2'd0;
					ready = 1'b1;
				end
				2'd1: begin
					result[DATA_WIDTH-1: DATA_WIDTH/2] = dst;
					src1 = A[DATA_WIDTH/2 - 1:0];
					src2 = B[DATA_WIDTH/2 - 1:0];
					counter = 2'd2;
				end
				2'd0: begin
					src1 = A[DATA_WIDTH-1: DATA_WIDTH/2];
					src2 = B[DATA_WIDTH-1: DATA_WIDTH/2];
					ready = 1'b0;
					counter = 2'd1;
				end
			endcase
		end else begin
			counter = 2'd0;
			ready = 1'b0;
		end
	end

endmodule
