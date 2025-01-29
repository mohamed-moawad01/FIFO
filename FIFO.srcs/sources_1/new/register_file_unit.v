`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2025 11:28:19 PM
// Design Name: 
// Module Name: register_file_unit
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


module register_file_unit
#(parameter ADDR_WIDTH = 3 , DATA_WIDTH = 8)
(
input clk , w_en,
input [ADDR_WIDTH - 1 : 0] r_addr , //read address  
input [ADDR_WIDTH - 1 : 0] w_addr , //write address
input [DATA_WIDTH - 1 : 0] w_data ,  
output [DATA_WIDTH - 1 : 0] r_data   
    );
    
    reg [DATA_WIDTH - 1 : 0] memory [0 : 2**ADDR_WIDTH - 1];
    always @(posedge clk)
    begin
    if(w_en)
    memory[w_addr] <= w_data; 
    end
    
    assign r_data = memory[r_addr];
endmodule
