//////////////////////////////////////////////////////////////////////////////////
// 作者:lerogo
// 模块名: reg_latches
// 这个文件是寄存器,用于缓存一些数据,解决exe和mem冲突时的问题
// 这个文件是寄存器,缓存了一些数据
//////////////////////////////////////////////////////////////////////////////////

`ifndef _reg_latches
`define _reg_latches
module reg_latches(
    input clk,        // 时钟信号
    input clear,      // 清除信号
    input hold,       // 保持信号
    input in,         // 输入数据
    output out        // 输出数据
    );
    // 数据位宽 
    parameter N = 1;
    
    wire [N-1:0] in;
    reg [N-1:0] out;
    
    always @(posedge clk) begin
        if(clear)
            out <= {N{1'b0}};  // 清除时,输出全0
        else if (hold)
            out <= out;        // 保持时,输出保持不变
        else
            out <= in;         // 否则,输出等于输入
    end
    
endmodule

`endif
