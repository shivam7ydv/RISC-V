module RiscV_Pipe(clk, reset);

    // Declaration of I/O
    input clk, reset;

    // Declaration of Interim Wires
    wire       PCSrcE , JalrE,RegWriteW,MemWriteE,ALUSrcE,RegWriteE,Op5E,JumpE,BranchE,RegWriteM,MemWriteM; 
    wire[31:0] PCTargetE,Jalr_aluresultE,InstrD,PCD,PCPlus4D,ResultW,PCPlus4E,ImmExtE,PCE,RD2E,RD1E,upimmE,ALUResultM,WriteDataM,luipacM, PCPlus4M,luipacW,PCPlus4W,ALUResultW,ReadDataW;
                        
    wire[4:0]  RDW,RDE, RDM, RS1E, RS2E;
    wire[1:0]  StoreE,ResultSrcE,StoreM,ResultSrcM,ResultSrcW, ForwardAE, ForwardBE;
    wire[2:0]  LoadE,funct3E,LoadM,LoadW;
    wire[3:0]  ALUControlE;
    //wire [1:0] ForwardBE, ForwardAE;
    

    // Module Initiation
    // Fetch Stage
    fetch_cycle fetch(
                        clk, reset,
	                   PCSrcE, JalrE,
	                   PCTargetE, Jalr_aluresultE,
	                   InstrD, PCD, PCPlus4D
                    );

    // Decode Stage
    dec Decode (
                       clk, reset, RegWriteW,
	                   RDW,
	                   InstrD, PCD, PCPlus4D, ResultW,
	                   MemWriteE,
                       JalrE, ALUSrcE,
                       RegWriteE, Op5E,
                       StoreE, ResultSrcE,
                       LoadE, funct3E,
                       ALUControlE,
                       JumpE, BranchE,
	                   RDE, RS1E, RS2E,
	                   PCPlus4E, ImmExtE, PCE, RD2E, RD1E, upimmE
                    );

    // Execute Stage
    Execute_Cycle Execute (
                        clk, reset,
                        Op5E,RegWriteE,MemWriteE, JumpE, BranchE,ALUSrcE,
                        StoreE,ResultSrcE,ForwardAE, ForwardBE,
                        LoadE,funct3E,
                        ALUControlE,
                        RD1E, RD2E, PCE,ImmExtE, upimmE, PCPlus4E,ResultW,
                        RDE,
                        PCSrcE,RegWriteM, MemWriteM,
                        StoreM,ResultSrcM,
                        LoadM,
                        ALUResultM, WriteDataM,luipacM, PCPlus4M, PCTargetE,Jalr_aluresultE,
                        RDM
                    );
    
    // Memory Stage
    memory_cycle Memory (
                        clk, reset, RegWriteM, MemWriteM, 
                        RDM,
                        StoreM, 
                        ResultSrcM,
                        PCPlus4M, WriteDataM, ALUResultM,
                        luipacM,
                        LoadM,

                        RegWriteW, ResultSrcW,
                        LoadW, 
                        luipacW,
                        RDW,
                        PCPlus4W, ALUResultW, ReadDataW
                    );

    // Write Back Stage
    Write_Back_cycle WriteBack (
                        ResultSrcW,
                        luipacW,
                        PCPlus4W, ALUResultW, ReadDataW,
                        LoadW,

                        ResultW
                    );

    // Hazard Unit
    hazard_unit hzu(reset, RegWriteM, RegWriteW,RS1E, RS2E, RDM, RDW,ForwardAE, ForwardBE);
endmodule