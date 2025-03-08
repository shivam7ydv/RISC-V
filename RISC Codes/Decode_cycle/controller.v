module controller (
    input [6:0]  op,
    input [2:0]  funct3,
    input        funct7b5,
    output [1:0] ResultSrc,
    output       MemWrite,
    output       Jalr, ALUSrc,
    output       RegWrite, Op5,
    output [1:0] ImmSrc, Store,
    output [2:0] Load,
    output [3:0] ALUControl,
	 output 		  Jump, Branch
);

wire [1:0] ALUOp;
//wire       Branch, Jump, Take_Branch;

main_decoder   md(op, funct3, ResultSrc, MemWrite, Branch,
                    ALUSrc, RegWrite, Jump, Jalr,
                    ImmSrc, ALUOp, Store, Load);

alu_decoder    ad(op[5], funct3, funct7b5, ALUOp, ALUControl);

// for jump and branch
//assign PCSrc = (Branch & Take_Branch) | Jump;
assign Op5 = op[5];

endmodule