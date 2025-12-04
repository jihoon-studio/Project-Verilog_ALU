`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KCCI STC
// Engineer: 하진 이
// 
// Design Name: ALU 4bit on Basys3
// Description: 
//   - A[3:0] ← SW[3:0]
//   - B[3:0] ← SW[7:4]
//   - Sel[2:0] ← SW[10:8]
//   - Result[3:0] → LED[3:0]
//   - CarryOut → LED[4]
//////////////////////////////////////////////////////////////////////////////////

module top_ALU_basys3(
    input  [15:0] SW,    
    output [15:0] LED   
    );

    wire [3:0] A, B, Result;
    wire [2:0] Sel;
    wire CarryOut;

    assign A   = SW[3:0];    
    assign B   = SW[7:4];   
    assign Sel = SW[10:8];   


    alu_4bit U1 (
        .A(A),
        .B(B),
        .Sel(Sel),
        .Result(Result),
        .CarryOut(CarryOut),
        .Zero()
    );


    assign LED[3:0] = Result;
    assign LED[4]   = CarryOut;

endmodule
