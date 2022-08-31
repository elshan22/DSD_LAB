`timescale 1ns / 1ps

module adder #(parameter DATA_WIDTH = 8)
				  (input [DATA_WIDTH-1:0] A, B,
				   input add_en,
				   output reg [DATA_WIDTH-1:0] result);

	always @(A or B) begin
		result = (add_en)? (A+B): (A-B);
	end

endmodule
