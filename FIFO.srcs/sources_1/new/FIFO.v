`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2025 12:31:55 AM
// Design Name: 
// Module Name: FIFO
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FIFO
#(parameter DATA_WIDTH = 8 , ADDR_WIDTH = 3)
(
input wr , rd , clk , reset,
input [DATA_WIDTH - 1 : 0] w_data,
output [DATA_WIDTH - 1 : 0] r_data,
output full ,empty
    );
    wire [ADDR_WIDTH - 1 : 0] w_addr , r_addr;
    register_file_unit #(.ADDR_WIDTH(ADDR_WIDTH) , .DATA_WIDTH(DATA_WIDTH))
    r_file_unit(
    .w_addr(w_addr),
    .clk(clk),
    .w_en(wr&(~full)),
    .r_addr(r_addr),
    .w_data(w_data),
    .r_data(r_data)
    );
    FIFO_ctrl #(.ADDR_WIDTH(ADDR_WIDTH)) CTRL_unit
    (
    .clk(clk),
    .reset(reset),
    .wr(wr),
    .rd(rd),
    .full(full),
    .empty(empty),
    .w_addr(w_addr),
    .r_addr(r_addr)
    );
    
endmodule
