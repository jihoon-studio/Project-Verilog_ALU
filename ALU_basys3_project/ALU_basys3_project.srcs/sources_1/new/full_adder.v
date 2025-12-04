`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/14 16:11:19
// Design Name: 
// Module Name: full_adder
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


module full_adder(
    input  A,
    input  B,
    input  Cin,
    output Sum,
    output Carry
);
    wire s1, c1, c2;

    half_adder HA1(.A(A),   .B(B),   .Sum(s1), .Carry(c1));
    half_adder HA2(.A(s1),  .B(Cin), .Sum(Sum), .Carry(c2));

    assign Carry = c1 | c2;
endmodule
