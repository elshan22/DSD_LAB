`timescale 1ns / 1ps

module testbench;

	// Inputs
	reg [7:0] A;
	reg [7:0] K;
	reg [4:0] write_addr;
	reg read;
	reg write;
	reg reset;
	reg clk = 0;

	// Outputs
	wire [19:0] matched;

	// Instantiate the Unit Under Test (UUT)
	TCAM uut (
		.A(A), 
		.K(K), 
		.write_addr(write_addr), 
		.read(read), 
		.write(write), 
		.reset(reset), 
		.clk(clk), 
		.matched(matched)
	);
	
	always #5 clk = ~clk;

	initial begin
		A = 0;
		K = 0;
		write_addr = 0;
		read = 0;
		write = 0;
		reset = 0;
		
		#18
		reset = 1;
		write_addr = 4;
		write = 1;
		A = 8'b11010011;
		K = 8'b01111001;
		#10
		write_addr = 5;
		A = 8'b01101001;
		K = 8'b11000001;
		#10
		write_addr = 6;
		A = 8'b11110111;
		K = 8'b11111110;
		#10
		read = 1;
		A = 8'b11001010;
		K = 8'b10000000;
		#10
		read = 0;
		A = 8'b01010101;
		K = 8'b11111111;
		#10
		read = 1;
		A = 8'b10000101;
		K = 8'b10000000;
		#10
		$finish;
	end
      
endmodule

