module dec(
	input clk, reset, RegWriteW,
	input  [4:0]  RDW,
	input  [31:0] InstrD, PCD, PCPlus4D, ResultW,
	output       MemWriteE,
    output       JalrE, ALUSrcE,
    output       RegWriteE, Op5E,
    output [1:0] StoreE, ResultSrcE,
    output [2:0] LoadE, funct3E,
    output [3:0] ALUControlE,
    output       JumpE, BranchE,
	output [4:0] RDE, /*RS1E, RS2E,*/
	output [31:0] PCPlus4E, ImmExtE, PCE, RD2E, RD1E, upimmE
);

wire RegWriteD,ALUSrcD,MemWriteD,BranchD,JalrD,Op5D,JumpD;
wire [1:0] ImmSrcD, StoreD,ResultSrcD;
wire [2:0] LoadD;
wire [3:0] ALUControlD;
wire [31:0] RD1D, RD2D, ImmExtD;


reg RegWriteD_r,ALUSrcD_r,MemWriteD_r,BranchD_r,JalrD_r,Op5D_r,JumpD_r;
reg [1:0] StoreD_r,ResultSrcD_r;
reg [2:0] LoadD_r, funct3D_r;
reg [3:0] ALUControlD_r;
reg [31:0] RD1D_r, RD2D_r, ImmExtD_r, upimmD_r;
reg [4:0] RD_r; /*RS1_r, RS2_r*/
reg [31:0] PCD_r, PCPlus4D_r;

//module initialisation
controller c(InstrD[6:0], InstrD[14:12], InstrD[30],
             ResultSrcD, MemWriteD, JalrD, ALUSrcD, RegWriteD,
             Op5D, ImmSrcD, StoreD, LoadD, ALUControlD, JumpD, BranchD);


reg_file rf(clk, RegWriteW, InstrD[19:15], InstrD[24:20], RDW, ResultW, RD1D, RD2D);

imm_extend    ext (InstrD[31:7], ImmSrcD, ImmExtD);

always @(posedge clk or posedge reset)begin
	if(reset)begin
		RegWriteD_r<=1'b0;
		ALUSrcD_r<=1'b0;
		MemWriteD_r<=1'b0;
		BranchD_r<=1'b0;
		JalrD_r<=1'b0;
		Op5D_r<=1'b0;
		JumpD_r<=1'b0;
		StoreD_r<=2'b00;
		ResultSrcD_r<=2'b00;
		LoadD_r<=3'b000;
		funct3D_r<=3'b000;
		ALUControlD_r<=4'b0000;
		RD1D_r<=32'h00000000;
		RD2D_r<=32'h00000000;
		ImmExtD_r<=32'h00000000;
		upimmD_r<=32'h00000000;
		RD_r<=5'b00000;
//		RS1_r<=5'b00000;
//		RS2_r<=5'b00000;
		PCD_r<=32'h00000000;
		PCPlus4D_r<=32'h00000000;
	end
	else begin
		RegWriteD_r<=RegWriteD;
		ALUSrcD_r<=ALUSrcD;
		MemWriteD_r<=MemWriteD;
		BranchD_r<=BranchD;
		JalrD_r<=JalrD;
		Op5D_r<=Op5D;
		JumpD_r<=JumpD;
		StoreD_r<=StoreD;
		ResultSrcD_r<=ResultSrcD;
		LoadD_r<=LoadD;
		funct3D_r<=InstrD[14:12];
		ALUControlD_r<=ALUControlD;
		RD1D_r<=RD1D;
		RD2D_r<=RD2D;
		ImmExtD_r<=ImmExtD;
		upimmD_r<={InstrD[31:12], 12'h000};
		RD_r<=InstrD[11:7];
//		RS1_r<=InstrD[19:15];
//		RS2_r<=InstrD[24:20];
		PCD_r<=PCD;
		PCPlus4D_r<=PCPlus4D;
	end
end
	
assign MemWriteE=MemWriteD_r;
assign JalrE=JalrD_r;
assign ALUSrcE=ALUSrcD_r;
assign RegWriteE=RegWriteD_r;
assign Op5E=Op5D_r;
assign StoreE=StoreD_r;
assign ResultSrcE=ResultSrcD_r;
assign LoadE=LoadD_r;
assign funct3E=funct3D_r;
assign ALUControlE=ALUControlD_r;
assign JumpE=JumpD_r;
assign BranchE=BranchD_r;
assign RDE=RD_r;
assign upimmE=upimmD_r;
//assign RS1E=RS1_r;
//assign RS2E=RS2_r;
assign PCPlus4E=PCPlus4D_r;
assign ImmExtE=ImmExtD_r;
assign PCE=PCD_r;
assign RD2E=RD2D_r;
assign RD1E=RD1D_r;
	 
endmodule