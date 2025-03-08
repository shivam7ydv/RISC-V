`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.08.2024 22:59:56
// Design Name: 
// Module Name: Execute_Cycle
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


module Execute_Cycle(
    input clk, reset,
    input Op5E,RegWriteE,MemWriteE, JumpE, BranchE,ALUSrcE,
    input [1:0] StoreE,ResultSrcE, ForwardAE, ForwardBE,
    input [2:0] LoadE,funct3E,
    input [3:0] ALUControlE,
    input [31:0] RD1E, RD2E, PCE,ImmExtE, upimmE, PCPlus4E, ResultW,
    input [4:0] RDE,
    output PCSrcE,RegWriteM, MemWriteM,
    output [1:0] StoreM,ResultSrcM,
    output [2:0] LoadM,
    output [31:0] ALUResultM, WriteDataM,luipacM, PCPlus4M, PCTargetE,Jalr_aluresultE,
    output [4:0] RDM
);

reg RegWriteE_r, MemWriteE_r;
reg [1:0] StoreE_r,ResultSrcE_r;
reg [2:0] LoadE_r;
reg [31:0] ALUResultE_r, WriteDataE_r,luipacE_r, PCPlus4E_r;
reg [4:0] RDE_r;

wire [31:0] SrcAE, SrcBE, SrcBE_fwd, ALUResultE, AUIPcE, luipacE;

mux3 #(32)     fwda(RD1E, ResultW, ALUResultM, ForwardAE, SrcAE);
mux3 #(32)     fwdb(RD2E, ResultW, ALUResultM, ForwardBE, SrcBE_fwd);

mux2 #(32)     srcbmux (SrcBE_fwd, ImmExtE, ALUSrcE, SrcBE);
alu   alu(SrcAE, SrcBE, ALUControlE, ALUResultE, ZeroE);
adder           pcaddbranch (PCE, ImmExtE, PCTargetE);

adder       auipcadd  (PCE, upimmE, AUIPcE);
mux2 #(32)  luipcmux  (AUIPcE, upimmE, Op5E, luipacE);

PC_Src_logic pcsrclogic(JumpE, BranchE, ALUResultE[31], ZeroE, funct3E, PCSrcE);
always @(posedge clk or posedge reset) begin
        if(reset) begin
            StoreE_r<=2'b00;
            LoadE_r<=3'b000;
            RegWriteE_r <= 1'b0; 
            MemWriteE_r <= 1'b0; 
            ResultSrcE_r <= 2'b00;
            ALUResultE_r <= 32'h00000000;
            WriteDataE_r <= 32'h00000000;
            RDE_r <= 5'b00000;
            luipacE_r<=32'b00000000;
            PCPlus4E_r<=32'b00000000;
        end
        else begin
            StoreE_r<=StoreE;
            LoadE_r<=LoadE;
            RegWriteE_r <=RegWriteE; 
            MemWriteE_r <=MemWriteE; 
            ResultSrcE_r <=ResultSrcE;
            ALUResultE_r <= ALUResultE;
            WriteDataE_r <= RD2E;
            RDE_r <= RDE;
            luipacE_r <= luipacE;
            PCPlus4E_r<=PCPlus4E;
        end
    end

assign StoreM=StoreE_r;
assign LoadM=LoadE_r;
assign RegWriteM=RegWriteE_r; 
assign MemWriteM=MemWriteE_r; 
assign ResultSrcM=ResultSrcE_r;
assign ALUResultM= ALUResultE_r;
assign WriteDataM= WriteDataE_r;
assign RDM= RDE_r;
assign luipacM=luipacE_r;
assign PCPlus4M=PCPlus4E_r;
assign Jalr_aluresultE=ALUResultE;
endmodule
