//////////////////////////////////////////////////////////////////////////////////
// Module Name: if_pc
// Author:lerogo
//////////////////////////////////////////////////////////////////////////////////

`ifndef _if_pc
`define _if_pc

module if_pc(
    input wire clk,reset,
    input wire [1:0] pcsource_s1,
    input wire [31:0] baddr_s1,
    input wire [31:0] jaddr_s1,
    input wire [31:0] pc_s1,
    output reg[31:0] npc_s1
);
    // 复位时将PC设为0
    always @(negedge reset) begin
        npc_s1 <= 32'b0;
    end
    
    // 在时钟上升沿更新PC
    always @(posedge clk) begin
          case (pcsource_s1)
              2'b01:npc_s1<=pc_s1+4;      // 顺序执行,PC+4
              2'b10:npc_s1<=baddr_s1;     // 分支跳转
              2'b11:npc_s1<=jaddr_s1;     // 无条件跳转
              default:npc_s1<=pc_s1;      // 保持不变
          endcase        
    end
endmodule

`endif




