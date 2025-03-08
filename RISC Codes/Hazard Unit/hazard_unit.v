`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2024 17:00:10
// Design Name: 
// Module Name: hazard_unit
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


module hazard_unit(
input reset, RegWriteM, RegWriteW,
input [4:0] RS1E, RS2E, RDM, RDW,
output [1:0]  ForwardAE, ForwardBE
);

assign ForwardAE = (reset == 1'b1) ? 2'b00 : 
                       ((RegWriteM == 1'b1) & (RDM != 5'b00000) & (RDM == RS1E)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RDW != 5'b00000) & (RDW == RS1E)) ? 2'b01 : 2'b00;
                       
assign ForwardBE = (reset == 1'b1) ? 2'b00 : 
                       ((RegWriteM == 1'b1) & (RDM != 5'b00000) & (RDM == RS2E)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RDW != 5'b00000) & (RDW == RS2E)) ? 2'b01 : 2'b00;
endmodule
