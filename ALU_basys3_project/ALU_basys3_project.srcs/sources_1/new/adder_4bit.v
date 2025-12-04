`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/14 16:15:53
// Design Name: 
// Module Name: adder_4bit
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


module adder_4bit(
    input  [3:0] A,
    input  [3:0] B,
    input        Cin,
    output [3:0] Sum,
    output       Cout
);
    wire c1, c2, c3;

    full_adder FA0(A[0], B[0], Cin,  Sum[0], c1);
    full_adder FA1(A[1], B[1], c1,   Sum[1], c2);
    full_adder FA2(A[2], B[2], c2,   Sum[2], c3);
    full_adder FA3(A[3], B[3], c3,   Sum[3], Cout);
endmodule

