//////////////////////////////////////////////////////////////////////////////////
// 模块名: id_decode
// 作者:lerogo
//////////////////////////////////////////////////////////////////////////////////

`ifndef _id_decode
`define _id_decode

module id_decode(
    input [31:0] npc_s2,
    input [31:0] im_data_s2,
    output [5:0] opcode_s2,
    output [4:0] rs_s2,
    output [4:0] rt_s2,
    output [4:0] rd_s2,
    output [15:0] imm_s2,
    output [31:0] jaddr_s2
    );
    // 从指令中提取各个字段
    assign opcode_s2  = im_data_s2[31:26];  // 操作码
    assign rd_s2 = im_data_s2[25:21];       // 目标寄存器
    assign rs_s2 = im_data_s2[20:16];       // 源寄存器1
    assign rt_s2 = im_data_s2[15:11];       // 源寄存器2
    assign imm_s2 = im_data_s2[15:0];       // 立即数
    // 计算跳转地址:使用当前PC的高4位和指令中的26位地址,左移2位
    assign jaddr_s2 = {npc_s2[31:28], im_data_s2[25:0], {2{1'b0}}};
    
endmodule

`endif
