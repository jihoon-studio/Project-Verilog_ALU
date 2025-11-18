## Project-Verilog_ALU

간단한 4비트 ALU를 Verilog HDL로 설계한 뒤 Vivado를 이용해 합성·구현하고, Basys3 FPGA 보드에 Bitstream을 다운로드하여 실제 동작까지 확인한 프로젝트.
대규모 프로젝트는 아니지만, **FPGA 개발 전 과정(HDL 작성 → 시뮬레이션 → Synthesis → P&R → Bitstream 생성 → 하드웨어 동작 검증)**을 모두 수행하는 것을 목표로 한다.

### ✨ 1. 프로젝트 개요

---

프로젝트 목표

- Verilog HDL 학습

- FPGA 개발 플로우 전체 경험

- 구조적 설계(Structural Design) 방식 이해 및 적용

구성 요소

- Half Adder

- Full Adder

- 4-bit Ripple Carry Adder

- 4-bit ALU

입·출력 구조

- Basys3 스위치 입력

- LED 출력 결과 확인

- 구현된 연산 기능

- Add, Subtract

- AND, OR, XOR, NOR

- Shift Left, Shift Right

핵심 구현 포인트

- 모듈 기반 구조적 설계

- Vivado XSIM 시뮬레이션

- Synthesis 및 Implementation

- XDC 기반 핀 매핑

- FPGA 실기 동작 검증

📸 Basys3 보드 사진

<img width="253" height="200" alt="image" src="https://github.com/user-attachments/assets/64987549-9db2-431b-9210-282ece7a5daa" />




---

### 🔧 2. 설계 구조 (Block Diagram)

본 ALU는 아래 계층 구조로 설계되었습니다.

```scss
half_adder
  ▼
full_adder (2개의 half_adder 사용)
  ▼
adder_4bit (4개의 full_adder 사용)
  ▼
alu_4bit (연산 선택)
  ▼
top_ALU_basys3
```


📸 구조도 이미지 (블록 다이어그램)

<img width="976" height="303" alt="image" src="https://github.com/user-attachments/assets/b3f1f9c9-cfa6-486c-9ed6-bba5f3a5188e" />


Vivado RTL Viewer로 생성한 회로도:

<img width="1176" height="567" alt="image" src="https://github.com/user-attachments/assets/3b32f2d5-1f11-453d-b948-031a0f48a2e9" />

---

### 🧪 3. Simulation (Vivado XSIM)

테스트벤치를 작성하여 모든 연산을 시뮬레이션했습니다.

📄 샘플 출력 로그
```scss
# run 1000ns
T=0 | A=0101 B=0011 Sel=000 | Result=xxx0 Carry=z Zero=x
T=10000 | A=0101 B=0011 Sel=001 | Result=xxx0 Carry=x Zero=x
T=20000 | A=0101 B=0011 Sel=010 | Result=0001 Carry=0 Zero=0
T=30000 | A=0101 B=0011 Sel=011 | Result=0111 Carry=0 Zero=0
T=40000 | A=0101 B=0011 Sel=100 | Result=0110 Carry=0 Zero=0
T=50000 | A=0101 B=0011 Sel=101 | Result=1000 Carry=0 Zero=0
T=60000 | A=0101 B=0011 Sel=110 | Result=1010 Carry=0 Zero=0
T=70000 | A=0101 B=0011 Sel=111 | Result=0010 Carry=1 Zero=0
```

#### ✔ 테스트벤치 실행 결과
📊 Simulation Waveform (Vivado XSIM)

아래 파형은 4-bit ALU의 각 연산(ADD, SUB, AND, OR, XOR, NOR, Shift)을
10ns 간격으로 테스트한 결과입니다.

첫 출력은 초기 reg 상태(X)로 인해 정의되지 않은 값으로 시작함

이후 Sel 값에 따라 연산 결과가 정상적으로 출력됨

ADD/Sub는 adder_4bit 모듈, 나머지는 RTL 게이트 연산으로 구현됨

📸 Waveform 파형 캡쳐 이미지

<img width="1018" height="226" alt="image" src="https://github.com/user-attachments/assets/8fd0fb65-a348-441f-a6d8-88d31ae8881e" />


---

### 🗜 4. Synthesis / Implementation

Vivado에서 Synthesis와 Implementation(Place & Route)를 진행하였으며 모두 정상 완료되었습니다.

📸 Synthesis 성공 화면

<img width="312" height="480" alt="image" src="https://github.com/user-attachments/assets/abbc5f90-b31c-43f3-96a5-4adb49f09b20" />

📸 Implementation 성공 화면

<img width="317" height="480" alt="image" src="https://github.com/user-attachments/assets/76855600-3fb3-491d-8eb4-5f3ffb5765b6" />


---

### 📌 5. Basys3 핀 매핑 (XDC)

스위치 입력, LED 출력 핀을 XDC를 통해 명시적으로 매핑했습니다.

<details>
<summary> 📸 Pin Planner(펼치기) </summary>

```scss
## ============================
## Basys3 Switch (SW) Mapping
## ============================
set_property PACKAGE_PIN V17 [get_ports {SW[0]}]
set_property PACKAGE_PIN V16 [get_ports {SW[1]}]
set_property PACKAGE_PIN W16 [get_ports {SW[2]}]
set_property PACKAGE_PIN W17 [get_ports {SW[3]}]
set_property PACKAGE_PIN W15 [get_ports {SW[4]}]
set_property PACKAGE_PIN V15 [get_ports {SW[5]}]
set_property PACKAGE_PIN W14 [get_ports {SW[6]}]
set_property PACKAGE_PIN W13 [get_ports {SW[7]}]
set_property PACKAGE_PIN V2  [get_ports {SW[8]}]
set_property PACKAGE_PIN T3  [get_ports {SW[9]}]
set_property PACKAGE_PIN T2  [get_ports {SW[10]}]
set_property PACKAGE_PIN R3  [get_ports {SW[11]}]
set_property PACKAGE_PIN W2  [get_ports {SW[12]}]
set_property PACKAGE_PIN U1  [get_ports {SW[13]}]
set_property PACKAGE_PIN T1  [get_ports {SW[14]}]
set_property PACKAGE_PIN R2  [get_ports {SW[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[*]}]

## ============================
## Basys3 LED Mapping
## ============================
set_property PACKAGE_PIN U16 [get_ports {LED[0]}]
set_property PACKAGE_PIN E19 [get_ports {LED[1]}]
set_property PACKAGE_PIN U19 [get_ports {LED[2]}]
set_property PACKAGE_PIN V19 [get_ports {LED[3]}]
set_property PACKAGE_PIN W18 [get_ports {LED[4]}]
set_property PACKAGE_PIN U15 [get_ports {LED[5]}]
set_property PACKAGE_PIN U14 [get_ports {LED[6]}]
set_property PACKAGE_PIN V14 [get_ports {LED[7]}]
set_property PACKAGE_PIN V13 [get_ports {LED[8]}]
set_property PACKAGE_PIN V3  [get_ports {LED[9]}]
set_property PACKAGE_PIN W3  [get_ports {LED[10]}]
set_property PACKAGE_PIN U3  [get_ports {LED[11]}]
set_property PACKAGE_PIN P3  [get_ports {LED[12]}]
set_property PACKAGE_PIN N3  [get_ports {LED[13]}]
set_property PACKAGE_PIN P1  [get_ports {LED[14]}]
set_property PACKAGE_PIN L1  [get_ports {LED[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[*]}]
```

</details>

---

### ⚡ 6. FPGA 실기 동작

Basys3 보드에서 실제로 동작하는 모습입니다.

📸 FPGA 동작 사진

<!-- 사진 -->

🎞 FPGA 작동 영상(GIF/MP4)

<!-- 영상 -->

---

### 📄 7. 핵심 Verilog 코드

<details>
<summary> half_adder(펼치기) </summary>

```verilog
module half_adder(
    input  A,
    input  B,
    output Sum,
    output Carry
);
    assign Sum   = A ^ B;
    assign Carry = A & B;
endmodule
```

</details>

<details>
<summary> full_adder(펼치기) </summary>

```verilog
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
```

</details>

<details>
<summary> 4-bit Adder(펼치기) </summary>

```verilog
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
```

</details>

<details>
<summary> ALU(펼치기) </summary>

```verilog
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
```

</details>

---

### 📚 8. 개발 과정에서 배운 점

Verilog 구조적 설계를 직접 경험

조합논리/순차논리 차이 이해

Vivado의 Simulation, Synthesis, Implementation 전체 흐름 체득

XDC 핀 매핑을 통한 실제 FPGA 동작 경험

FPGA 개발의 기본 개념을 실제로 수행해보며 확실히 익힘
