module Write_Back_cycle(

// Declaration of IOs
input [1:0] ResultSrcW,
input [31:0] luipacW,
input [31:0] PCPlus4W, ALU_ResultW, ReadDataW,
input[2:0] LoadSelect,

output [31:0] ResultW);

wire[31:0] ReadDataL;
// Declaration of Module

                
                
load_extend le(ReadDataW,LoadSelect,ReadDataL); 
mux4 #(32) result_mux (ALU_ResultW ,ReadDataL,PCPlus4W,luipacW,ResultSrcW,ResultW);            
endmodule