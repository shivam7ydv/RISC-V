`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.08.2024 23:32:02
// Design Name: 
// Module Name: PC_Src_logic
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


module PC_Src_logic(
    input Jump, Branch, ALUR31, Zero,
    input [2:0] funct3,
    output PCSrc
    );
    
    reg Take_Branch;
always @(*) begin
    Take_Branch=0;
    if (Branch) begin
        case (funct3)
            3'b000:  Take_Branch = Zero;
            3'b001:  Take_Branch = ~Zero;
            3'b100:  Take_Branch = ALUR31;
            3'b101:  Take_Branch = !ALUR31;
            default: Take_Branch = 0;
        endcase
    end
 end
 
 assign PCSrc=(Take_Branch & Branch)|Jump;
    
endmodule
