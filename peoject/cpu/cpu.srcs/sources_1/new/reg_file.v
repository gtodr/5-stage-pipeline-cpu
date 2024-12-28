//////////////////////////////////////////////////////////////////////////////////
// Module Name: reg_file
// Author:lerogo
//////////////////////////////////////////////////////////////////////////////////

`ifndef _reg_file
`define _reg_file

module reg_file(
    input clk,reset,
    input write_back_s5,
    input [4:0] rs_s2,
    input [4:0] rt_s2,
    input [4:0] rd_s5,
    input [31:0] wdata,
    output [31:0] rs_data_s2,
    output [31:0] rt_data_s2
 );
    // 32位寄存器文件,共32个寄存器
    reg [31:0] mem [0:31];
    reg [31:0] _data1, _data2;
    integer i = 0;
    
    // 复位时将所有寄存器清零
    always @(negedge reset) begin
        for (i = 0; i < 32; i = i + 1) begin
            mem[i] <= 32'b0;
        end
    end
    
    // 读取rs寄存器的值
    always @(*) begin
        if (rs_s2 == 5'd0)
            _data1 = 32'd0;  // 0号寄存器始终为0
        // 处理数据冒险:如果正在写入的寄存器就是要读取的寄存器,直接使用写入的值
        else if ((rs_s2 == rd_s5) && write_back_s5)
            _data1 = wdata;
        else
            _data1 = mem[rs_s2][31:0];
    end
    
    // 读取rt寄存器的值(逻辑同上)
    always @(*) begin
        if (rt_s2 == 5'd0)
            _data2 = 32'd0;
        else if ((rt_s2 == rd_s5) && write_back_s5)
            _data2 = wdata;
        else
            _data2 = mem[rt_s2][31:0];
    end
    
    // 输出读取的寄存器值
    assign rs_data_s2 = _data1;
    assign rt_data_s2 = _data2;
    
    // 在时钟上升沿写入寄存器
    always @(posedge clk) begin
        if (write_back_s5 && rd_s5 != 5'd0) begin
            mem[rd_s5] <= wdata;
        end
    end
    
endmodule

`endif







