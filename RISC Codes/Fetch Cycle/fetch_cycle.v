module fetch_cycle(
	input clk, reset,
	input PCSrcE, JalrE,
	input [31:0] PCTargetE, ALUResultE,
	output [31:0] InstrD, PCD, PCPlus4D
);

wire [31:0] PCNextF, PCNextJalrF, PCF, PCPlus4F;
wire [31:0] InstrF;

//pipelined reg modules
reg [31:0] InstrF_reg, PCF_reg, PCPlus4F_reg;
 
//initiating modules

mux2 #(32)      pcjalrmux(PCNextF, ALUResultE, JalrE, PCNextJalrF);
mux2 #(32)      pcmux (PCPlus4F, PCTargetE, PCSrcE, PCNextF);
reset_ff #(32)  pcreg (clk, reset, PCNextJalrF, PCF);
instr_mem instrmem (PCF, InstrF);
adder           pcadd4 (PCF, 32'd4, PCPlus4F);

always @(posedge clk or posedge reset) begin
	if(reset)begin
		InstrF_reg<=32'h00000000;
		PCF_reg<=32'h00000000;
		PCPlus4F_reg<=32'h00000000;
	end
	else begin
		InstrF_reg<=InstrF;
		PCF_reg<=PCF;
		PCPlus4F_reg<=PCPlus4F;
	end
		
end

assign InstrD = (reset==1'b1)?32'h00000000:InstrF_reg;
assign PCD = (reset==1'b1)?32'h00000000:PCF_reg;
assign PCPlus4D = (reset==1'b1)?32'h00000000:PCPlus4F_reg;

endmodule