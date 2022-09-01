`timescale 1ns / 1ps
module execont #(parameter WIDTH = 8, SIZE = 64)
					 (input [$clog2(SIZE)-1:0] dst_addr, input [WIDTH-1:0] src1, src2,
					  input[1:0] opcode, input enable, clk,
					  output ready, 
					  output [WIDTH-1:0] dst,
					  output [$clog2(SIZE)-1:0] dst_out
    );
	 reg add_en, mul_en, add_sub;
	 assign ready = mul_ready | add_ready;
	 cadder cadd(.A(src1), .B(src2), .result(dst), .clk(clk), .enable(add_en),
	 .add_en(add_sub), .ready(add_ready));
	 cmult cmult(.A(src1), .B(src2), .mult(dst), .clk(clk), .enable(mul_en),
	 .ready(mul_ready));
	 always @(posedge clk) begin
		if (enable) begin
			case(opcode)
				 2'b10: begin //add
				 add_en = 1;
				 mul_en = 0;
				 add_sub = 1;
				 end
				 2'b11: begin //sub
				 add_en = 1;
				 mul_en = 0;
				 add_sub = 0;
				 end
				 2'b01: begin //mul
				 add_en = 0;
				 mul_en = 1;
				 add_sub = 0;
				 end
			endcase
		end else begin
			add_en = 0;
			mul_en = 0;
		end
	 
	 end

endmodule
