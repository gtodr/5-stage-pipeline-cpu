//////////////////////////////////////////////////////////////////////////////////
// Module Name: if_im
// Author:lerogo
//////////////////////////////////////////////////////////////////////////////////

`ifndef _if_im
`define _if_im

module if_im(
    input clk,
    input  npc_s1,
    output im_data_s1
    );
    wire[31:0] npc_s1;
    reg[31:0] im_data_s1;
    
    // 指令数量
    parameter MEM_NUM = 0;
    parameter IM_DATA_FILENAME = "";
    // 32位指令存储器
    reg [31:0] mem [0:MEM_NUM];
    
    // 从文件中读取指令
    initial begin
        $readmemh(IM_DATA_FILENAME, mem,0, MEM_NUM-1);
    end
    
    // 根据PC读取指令
    always @(*) begin
       if(npc_s1[8:2] > MEM_NUM) im_data_s1 <= 32'b0;
       // PC每次增加4,所以使用npc_s1[8:2]而不是npc_s1[8:0]
       else im_data_s1 <= mem[npc_s1[8:2]][31:0];   
    end
    
endmodule

`endif




