`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/13 17:51:16
// Design Name: 
// Module Name: alu_4bit
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


module alu_4bit(
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] Sel,
    output reg [3:0] Result,
    output reg CarryOut,
    output Zero
);

    wire [3:0] add_sum;
    wire add_cout;
    wire [3:0] sub_sum;
    wire sub_cout;

    adder_4bit ADD (
        .A(A),
        .B(B),
        .Cin(1'b0),
        .Sum(add_sum),
        .Cout(add_cout)
    );

    adder_4bit SUB (
        .A(A),
        .B(~B),
        .Cin(1'b1),
        .Sum(sub_sum),
        .Cout(sub_cout)
    );

    always @(*) begin
        case (Sel)
            3'b000: begin Result = add_sum; CarryOut = add_cout; end 
            3'b001: begin Result = sub_sum; CarryOut = ~sub_cout; end 
            3'b010: begin Result = A & B;   CarryOut = 0; end
            3'b011: begin Result = A | B;   CarryOut = 0; end
            3'b100: begin Result = A ^ B;   CarryOut = 0; end
            3'b101: begin Result = ~(A | B); CarryOut = 0; end
            3'b110: begin Result = A << 1;  CarryOut = A[3]; end
            3'b111: begin Result = A >> 1;  CarryOut = A[0]; end
        endcase
    end

    assign Zero = (Result == 4'b0000);

endmodule
