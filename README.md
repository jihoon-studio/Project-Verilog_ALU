# Project-Verilog_ALU
Verilog HDL과 Basys3 FPGA 보드를 이용한 4비트 ALU 설계 및 구현 프로젝트

-------------

간단한 4비트 ALU를 Verilog HDL로 설계 → Vivado로 합성·구현 → Basys3 FPGA에 다운로드까지 진행한 프로젝트입니다.
큰 규모의 프로젝트는 아니지만, **FPGA 개발 전체 흐름(HDL 작성 → 시뮬 → Synthesis → P&R → Bitstream → 실동작)**을 온전히 경험하며
“나는 Verilog를 직접 사용해봤다”는 것을 증명하기 위한 목적의 학습형 프로젝트입니다.

-------------

✨ 1. 프로젝트 개요

목표: Verilog HDL 학습 및 FPGA 전체 개발 플로우 경험

구성 요소:

Half Adder → Full Adder → 4-bit Ripple Carry Adder → 4-bit ALU

Basys3 FPGA에서 스위치 입력 → LED 출력

메인 기능:

덧셈, 뺄셈, AND, OR, XOR, NOR, Shift 등 연산 수행

핵심 포인트:

구조적 설계(Structural Design)

Vivado XSIM 시뮬레이션

Synthesis / Implementation / XDC 핀매핑

FPGA 실기 동작까지 성공

📸 Basys3 보드 사진

<!-- Basys3 사진 넣기 -->

-------------

🔧 2. 설계 구조 (Block Diagram)

본 ALU는 아래 계층 구조로 설계되었습니다.

half_adder
   ▼
full_adder (2개의 half_adder 사용)
   ▼
adder_4bit (4개의 full_adder 사용)
   ▼
alu_4bit (연산 선택)
   ▼
top_ALU_basys3 (Basys3 연결)


📸 구조도 이미지 (블록 다이어그램)

<!-- 구조도 이미지 넣기 -->

Vivado RTL Viewer로 생성한 회로도:

<!-- RTL Viewer 스크린샷 넣기 -->

-------------

🧪 3. Simulation (Vivado XSIM)

테스트벤치를 작성하여 모든 연산을 시뮬레이션했습니다.

📄 샘플 출력 로그

T=0ns   A=0101 B=0011 Sel=000 → ADD = 1000 Carry=0 Zero=0
T=10ns  A=0101 B=0011 Sel=001 → SUB = 0010 Carry=0 Zero=0
T=20ns  A=0101 B=0011 Sel=010 → AND = 0001 Zero=0
T=30ns  A=0101 B=0011 Sel=011 → OR  = 0111 Zero=0
...


📸 Waveform 파형 캡쳐 이미지

<!-- 시뮬레이션 파형 이미지 넣기 -->

-------------

🗜 4. Synthesis / Implementation

Vivado에서 Synthesis와 Implementation(Place & Route)를 진행하였으며 모두 정상 완료되었습니다.

📸 Synthesis 성공 화면

<!-- synthesis 성공 캡쳐 -->

📸 Implementation 성공 화면

<!-- implementation 성공 캡쳐 -->
📌 5. Basys3 핀 매핑 (XDC)

스위치 입력, LED 출력 핀을 XDC를 통해 명시적으로 매핑했습니다.

📸 Pin Planner 화면

<!-- 핀매핑 화면 첨부 -->
⚡ 6. FPGA 실기 동작

Basys3 보드에서 실제로 동작하는 모습입니다.

📸 FPGA 동작 사진

<!-- 사진 -->

🎞 FPGA 작동 영상(GIF/MP4)

<!-- 영상 -->

-------------

📄 7. 핵심 Verilog 코드
▶ half_adder
module half_adder(
    input  A,
    input  B,
    output Sum,
    output Carry
);
    assign Sum   = A ^ B;
    assign Carry = A & B;
endmodule

▶ full_adder
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

▶ 4-bit Adder
module adder_4bit(
    input  [3:0] A,
    input  [3:0] B,
    input        Cin,
    output [3:0] Sum,
    output       Carry
);
    wire c1, c2, c3;

    full_adder FA0(A[0], B[0], Cin,  Sum[0], c1);
    full_adder FA1(A[1], B[1], c1,   Sum[1], c2);
    full_adder FA2(A[2], B[2], c2,   Sum[2], c3);
    full_adder FA3(A[3], B[3], c3,   Sum[3], Carry);
endmodule

▶ ALU
module alu_4bit(
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] Sel,
    output reg [3:0] Result,
    output reg CarryOut,
    output Zero
);
    ...
endmodule

-------------

📚 8. 개발 과정에서 배운 점

Verilog 구조적 설계를 직접 경험

조합논리/순차논리 차이 이해

Vivado의 Simulation, Synthesis, Implementation 전체 흐름 체득

XDC 핀 매핑을 통한 실제 FPGA 동작 경험

FPGA 개발의 기본 개념을 실제로 수행해보며 확실히 익힘
