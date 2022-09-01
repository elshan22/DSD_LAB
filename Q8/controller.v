`timescale 1ns / 1ps

module controller #(parameter DATA_WIDTH = 8, INS_MEM_SIZE = 32, DATA_MEM_SIZE = 64)
						 (input clk, reset, output executed);

	reg [DATA_MEM_SIZE-1:0] changing;
	reg finished;
	integer i;
	
	assign executed = finished & (!(|changing));
	
	data_mem #(.DATA_WIDTH(DATA_WIDTH), .MEMORY_SIZE(DATA_MEM_SIZE)) data_memory
	(.clk(clk), .write_addr(save_addr), .read_addr(load_addr), .write_data(data_write),
	 .write(load_enable), .read(save_enable), .reset(reset), .read_data(data_read));
	
	fetch_cont #(.INS_MEMORY_SIZE(INS_MEM_SIZE), .DATA_MEMORY_SIZE(DATA_MEM_SIZE)) fetch_handle
	(.enable(fetch_enable), .clk(clk), .opcode(op), .src1(src1_adr), .src2(src2_adr), .dst(dst_adr),
	 .ready(fetch_ready), .finished(finished));
	
	load_handler #(.DATA_WIDTH(DATA_WIDTH), .DATA_MEMORY_SIZE(DATA_MEM_SIZE)) load_handle
	(.opcode_in(op), .src1_addr(src1_adr), .src2_addr(src2_adr), .dst_addr(dst_adr),
	 .data_in(data_read), .enable(load_enable), .clk(clk), .opcode_out(opc),
	 .src1(source1), .src2(source2), .addr_out(load_addr), .dst_out(dst_out), .ready(load_ready));
	
	execont #(.WIDTH(DATA_WIDTH), .SIZE(DATA_MEM_SIZE)) execution_handle
	(.dst_addr(dst_out), .src1(source1), .src2(source2), .opcode(opc), .enable(execution_enable),
	 .clk(clk), .ready(execution_ready), .dst(res), .dst_out(dst_address));
	
	save_handler #(.DATA_WIDTH(DATA_WIDTH), .DATA_MEMORY_SIZE(DATA_MEM_SIZE)) save_handle
	(.dst_addr(dst_address), .data_in(res), .enable(save_enable), .clk(clk), .addr_out(save_addr),
	 .data_out(data_write), .ready(save_ready));
	
	always @(posedge clk) begin
	
		
	
	end

endmodule
