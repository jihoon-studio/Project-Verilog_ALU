`timescale 1ns/1ps
module tb_alu_4bit;
    reg [3:0] A, B;
    reg [2:0] Sel;
    wire [3:0] Result;
    wire CarryOut, Zero;

    alu_4bit uut (
        .A(A), .B(B), .Sel(Sel),
        .Result(Result), .CarryOut(CarryOut), .Zero(Zero)
    );

    initial begin
        $monitor("T=%0t | A=%b B=%b Sel=%b | Result=%b Carry=%b Zero=%b",
                 $time, A, B, Sel, Result, CarryOut, Zero);
        A = 4'h5; B = 4'h3; Sel = 3'b000; #10;
        Sel = 3'b001; #10;
        Sel = 3'b010; #10;
        Sel = 3'b011; #10;
        Sel = 3'b100; #10;
        Sel = 3'b101; #10;
        Sel = 3'b110; #10;
        Sel = 3'b111; #10;
        $finish;
    end
endmodule
