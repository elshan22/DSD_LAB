`timescale 1ns / 1ps

module adder #(parameter DATA_WIDTH = 8)
				  (input [DATA_WIDTH-1:0] A, B,
				   output reg [DATA_WIDTH-1:0] result);

	always @(A or B) begin
		result = A + B;
	end

endmodule
