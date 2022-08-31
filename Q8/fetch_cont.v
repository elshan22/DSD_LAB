`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:00:24 09/01/2022 
// Design Name: 
// Module Name:    fetch_cont 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fetch_cont #(parameter SIZE = 32, WIDTH = 20)
						 (input[$clog2(SIZE)-1:0] pc, input clk, reset,
						  output reg[WIDTH-1:0] ir);
	 wire[$clog2(SIZE)-1:0] mar;
	 wire[WIDTH-1:0] mir;
	 assign mar = pc;
	 instruction_mem #(.INSTRUCTION_WIDTH(WIDTH), .MEMORY_SIZE(SIZE)) im
	 (.addr(mar), .data_in({WIDTH{1'b0}}), .write_en(1'b0), .clk(clk),
	 .reset(reset), .data_out(mir));
	 always @(posedge clk) begin
	 if(!reset) begin
	 ir = 0;
	 end else begin
	 ir = mir;
	 //pc <= pc+1;
	 end
	 end
endmodule
