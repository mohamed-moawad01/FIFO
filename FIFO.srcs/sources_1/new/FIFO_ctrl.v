`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2025 11:41:26 PM
// Design Name: 
// Module Name: FIFO_ctrl
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


module FIFO_ctrl
#(parameter ADDR_WIDTH = 3)
(
input clk , reset , wr , rd,
output reg full , empty ,
output [ADDR_WIDTH - 1 : 0] w_addr , r_addr
    );
      reg [ADDR_WIDTH - 1 : 0] wr_ptr , wr_ptr_next; 
      reg [ADDR_WIDTH - 1 : 0] rd_ptr , rd_ptr_next;
      reg full_next , empty_next ;
      
      always @(posedge clk , posedge reset)
      begin
      
      if(reset)
      begin
      full <= 1'b0;
      empty <= 1'b1;
      wr_ptr <= 0;
      rd_ptr <= 0;
      end
      
      else
      begin
      full <= full_next;
      empty <= empty_next;
      wr_ptr <= wr_ptr_next;
      rd_ptr <= rd_ptr_next;
      end
      end
      
      always @(*)
      begin
      full_next = full ;
      empty_next = empty ;
      wr_ptr_next = wr_ptr ; 
      rd_ptr_next = rd_ptr ;
      case({wr , rd}) 
      2'b01 : //read
             begin
             if(~empty)
             begin
               rd_ptr_next = rd_ptr + 1;
               full_next = 1'b0;
               if(rd_ptr_next == wr_ptr)
                 empty_next = 1'b1;
             end
             end
      2'b10 : // write 
              begin
              if(~full)
              begin
              wr_ptr_next = wr_ptr + 1;
              empty_next = 1'b0;
              if(wr_ptr_next == rd_ptr)
              full_next = 1'b1;
              end
              end
      2'b11 : // read and write 
              begin
              if(empty)
              begin
              wr_ptr_next = wr_ptr  ;
              rd_ptr_next = rd_ptr  ;
              end
              else
              begin
              wr_ptr_next = wr_ptr + 1 ;
              rd_ptr_next = rd_ptr + 1 ;
              end
              end
              
      default : begin
                full_next = full ;
                empty_next = empty ;
                wr_ptr_next = wr_ptr ; 
                rd_ptr_next = rd_ptr ;
                end
      endcase
      end
      //outputs
      assign w_addr = wr_ptr;
      assign r_addr = rd_ptr;
      
endmodule
