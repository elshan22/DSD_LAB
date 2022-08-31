`timescale 1ns / 1ps

module cmult #(parameter WIDTH = 8)(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
	 input clk, 
	 input enable,
	 output reg ready,
    output reg[WIDTH-1: 0] mult
    );
	 
	 reg [2:0] counter;
	 
	 reg [WIDTH/2 - 1:0] adder_src1;
	 reg [WIDTH/2 - 1:0] adder_src2;
	 wire [WIDTH/2 - 1:0] adder_dst;
	 
	 reg add_en;
	 
	 reg [WIDTH/2 - 1:0] mult_src1;
	 reg [WIDTH/2 - 1:0] mult_src2;
	 wire [WIDTH/2 - 1:0] mult_dst;
	 
	 reg [WIDTH/2 - 1:0] temp1;
	 reg [WIDTH/2 - 1:0] temp2;
	 
	 adder #(WIDTH/2) adder (adder_src1, adder_src2, add_en, adder_dst);
	 multiplier #(WIDTH/2) multer (mult_src1, mult_src2, mult_dst);
	 
	 always @(posedge clk) begin
		 if(enable) begin
			 case (counter)
				3'd5:	begin
					mult[WIDTH/2 - 1:0] = adder_dst;
					ready = 1'b1;
					counter = 3'd0;
				end
				3'd4: begin
					temp2 = mult_dst;
					adder_src1 = temp1;
					adder_src2 = temp2;
					add_en = 1'b1;
					counter = 3'd5;
				end
				3'd3: begin
					mult[WIDTH-1: WIDTH/2] = adder_dst;
					temp1 = mult_dst;
					mult_src1 = A[WIDTH/2 - 1:0];
					mult_src2 = B[WIDTH-1: WIDTH/2];
					counter = 3'd4;
				end
				3'd2: begin
					temp2 = mult_dst;
					mult_src1 = A[WIDTH-1: WIDTH/2];
					mult_src2 = B[WIDTH/2 - 1:0];
					adder_src1 = temp1;
					adder_src2 = temp2;
					add_en = 1'b0;
					counter = 3'd3;
				end
				3'd1: begin
					temp1 = mult_dst;
					mult_src1 = A[WIDTH/2 - 1:0];
					mult_src2 = B[WIDTH/2 - 1:0];
					counter = 3'd2;
				end
				3'd0: begin
					mult_src1 = A[WIDTH-1: WIDTH/2];
					mult_src2 = B[WIDTH-1: WIDTH/2];
					ready = 1'b0;
					counter = 3'd1;
				end
			 endcase
		 end else counter = 3'd0;
	 end
endmodule