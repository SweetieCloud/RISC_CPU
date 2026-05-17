# RISC_CPU

Bài tập lớn Thiết kế Luận lý: Hiện thực một bộ vi xử lý RISC (Reduced Instruction Set Computer) cơ bản kiến trúc 32-bit bằng ngôn ngữ đặc tả phần cứng Verilog HDL.

## Tính năng nổi bật

* **Tập lệnh thu gọn (8 lệnh):** Hỗ trợ các lệnh số học, logic và điều khiển luồng cơ bản bao gồm `HLT`, `SKZ`, `ADD`, `AND`, `XOR`, `LDA`, `STO`, và `JMP`.
* **Kiến trúc xử lý:** * Đường dữ liệu (Datapath) 32-bit.
  * Không gian địa chỉ bộ nhớ 32 words với cấu trúc cổng dữ liệu hai chiều (Bidirectional data port).
  * Bộ đếm chương trình (Program Counter) và thanh ghi tích lũy (Accumulator) đồng bộ.
* **Đơn vị điều khiển (Control Unit):** Vận hành dựa trên Máy trạng thái hữu hạn (FSM) 8 bước khép kín (Fetch - Decode - Execute - Store).
* **Tối ưu hóa phần cứng:** Logic kiểm tra điều kiện rẽ nhánh (lệnh `SKZ`) được thiết kế tính toán trực tiếp tại tầng Execute thông qua cờ `is_zero` của ALU, giúp tăng tốc độ phản hồi của CPU.

## Cấu trúc thư mục

* 📁 **`sources/`**: Chứa toàn bộ mã nguồn RTL (Verilog HDL) của hệ thống bao gồm Top module (`risc_cpu.v`) và các khối chức năng con (ALU, Controller, PC, Memory, Registers, MUX).
* 📁 **`simulation/`**: Chứa các file Testbench (`_tb.v`) dùng để kiểm thử độc lập từng thành phần (Unit Test) và kiểm thử toàn hệ thống (System-Level Test) với kịch bản mã máy tích hợp sẵn.
* 📁 **`constraints/`**: Chứa file cấu hình ràng buộc phần cứng `.xdc` dùng để ánh xạ chân tín hiệu (I/O mapping) khi nạp xuống board FPGA Arty Z7.

## Công cụ sử dụng

* **Ngôn ngữ:** Verilog HDL
* **Phần mềm:** Xilinx Vivado Design Suite (Mô phỏng, Tổng hợp mạch, Đo đạc hiệu năng và Năng lượng).
* **Phần cứng mục tiêu:** Digilent Arty Z7 20 (Zynq-7000 SoC).
