`timescale 1ns / 1ps

module cadder #(parameter DATA_WIDTH = 8)
					(input [DATA_WIDTH-1:0] A, B,
					 input add_en,
					 input enable, clk,
					 output reg [DATA_WIDTH-1:0] result);
	 
	 reg counter;
	 
	 reg [DATA_WIDTH/2 - 1: 0] src1;
	 reg [DATA_WIDTH/2 - 1: 0] src2;
	 wire [DATA_WIDTH/2 - 1: 0] dst;
	 
	 adder adder(src1, src2, dst);
	 

	always @(posedge clk) begin
		if (enable) begin
			if (counter) begin
				src1 = A[DATA_WIDTH/2 - 1:0];
				src2 = add_en? B[DATA_WIDTH/2 - 1:0]: -B[DATA_WIDTH/2 - 1:0];
				result[DATA_WIDTH/2 - 1:0] = dst;
			end else begin
				src1 = A[DATA_WIDTH-1: DATA_WIDTH/2];
				src2 = add_en? B[DATA_WIDTH-1: DATA_WIDTH/2]: -B[DATA_WIDTH-1: DATA_WIDTH/2];
				result[DATA_WIDTH-1: DATA_WIDTH/2] = dst;
			end
		end
	end

endmodule
