module memory_cycle(
    
    // Declaration of I/Os
    input clk, reset, RegWriteM, MemWriteM,
    input [4:0] RD_M,
    input [1:0] StoreM,ResultSrcM,
    input [31:0] PCPlus4M, WriteDataM, ALU_ResultM,
    input [31:0] luipacM,
    input[2:0] LoadM,

    output RegWriteW,
    output [1:0] ResultSrcW,
    output[2:0] LoadW, 
    output [31:0] luipacW,
    output [4:0] RD_W,
    output [31:0] PCPlus4W, ALU_ResultW, ReadDataW
    );

    // Declaration of Interim Wires
    wire [31:0] ReadDataM,Store_DataM;

    // Declaration of Interim Registers
    reg RegWriteM_r;
    reg [1:0] ResultSrcM_r;
    reg [4:0] RD_M_r;
    reg [2:0] LoadM_r;
    reg [31:0] PCPlus4M_r, ALU_ResultM_r, ReadDataM_r;
    reg[31:0] luipacM_r;

    // Declaration of Module Initiation
    data_mem dmem (clk,MemWriteM,ALU_ResultM,Store_DataM,ReadDataM );
    store_extend stre(WriteDataM,StoreM,Store_DataM);

    // Memory Stage Register Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            RegWriteM_r <= 1'b0; 
            ResultSrcM_r <= 2'b00;
            RD_M_r <= 5'b00000;
            PCPlus4M_r <= 32'h00000000; 
            ALU_ResultM_r <= 32'h00000000; 
            ReadDataM_r <= 32'h00000000;
            luipacM_r <= 12'b000000000000;
            LoadM_r<=3'b000;
        end
        else begin
            RegWriteM_r <= RegWriteM; 
            ResultSrcM_r <= ResultSrcM;
            RD_M_r <= RD_M;
            PCPlus4M_r <= PCPlus4M; 
            ALU_ResultM_r <= ALU_ResultM; 
            ReadDataM_r <= ReadDataM;
            luipacM_r <= luipacM ;
            LoadM_r<=LoadM;
        end
    end 

    // Declaration of output assignments
    assign RegWriteW = RegWriteM_r;
    assign ResultSrcW = ResultSrcM_r;
    assign RD_W = RD_M_r;
    assign PCPlus4W = PCPlus4M_r;
    assign ALU_ResultW = ALU_ResultM_r;
    assign ReadDataW = ReadDataM_r;
    assign luipacW = luipacM_r;
    assign LoadW=LoadM_r;

endmodule