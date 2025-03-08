`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2024 17:17:39
// Design Name: 
// Module Name: mux3
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


module mux3 #(parameter WIDTH = 8) (
    input       [WIDTH-1:0] d0, d1, d2,
    input       [1:0] sel,
    output      [WIDTH-1:0] y
);

assign y = (sel == 2'b00) ? d0 : (sel == 2'b01) ? d1 : (sel == 2'b10) ? d2 : 8'h00;

endmodule
