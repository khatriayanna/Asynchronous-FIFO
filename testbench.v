module tb_async_fifo; 
    reg wr_clk, rd_clk; 
    reg wr_rst, rd_rst; 
    reg wr_en, rd_en; 
    reg [7:0] data_in; 
    wire [7:0] data_out; 
    wire full, empty; 
    wire [4:0] count; 
    async_fifo_min #( 
        .DATA_WIDTH(8), 
        .DEPTH(16), 
        .ADDR_WIDTH(4) 
    ) dut ( 
        .wr_clk(wr_clk), 
        .rd_clk(rd_clk), 
        .wr_rst(wr_rst), 
        .rd_rst(rd_rst), 
        .wr_en(wr_en), 
        .rd_en(rd_en), 
        .data_in(data_in), 
        .data_out(data_out), 
        .full(full), 
        .empty(empty), 
        .count(count)  ); 
    // Write clock = 100 MHz 
    always #5 wr_clk = ~wr_clk; 
    // Read clock = ~71 MHz 
    always #7 rd_clk = ~rd_clk; 
    initial begin 
        // init 
        wr_clk = 0; 
        rd_clk = 0; 
        wr_rst = 1; 
        rd_rst = 1; 
        wr_en  = 0; 
        rd_en  = 0; 
        data_in = 0; 
        // reset time 
        #20; 
        wr_rst = 0; 
        rd_rst = 0; 
        // WRITE 12 DATA VALUES 
        repeat(12) begin 
            @(posedge wr_clk); 
            wr_en = 1; 
            data_in = data_in + 8'h01; 
        end 
        @(posedge wr_clk); 
        wr_en = 0; 
        #50; 
        // READ 8 VALUES 
        repeat(8) begin 
            @(posedge rd_clk); 
            rd_en = 1; 
        end 
        @(posedge rd_clk); 
        rd_en = 0; 
        #50; 
        // WRITE 6 MORE VALUES 
        repeat(6) begin 
            @(posedge wr_clk); 
            wr_en = 1; 
            data_in = data_in + 8'h01; 
        end 
        @(posedge wr_clk); 
        wr_en = 0; 
        #50; 
        // READ ALL UNTIL EMPTY 
        while (!empty) begin 
            @(posedge rd_clk); 
            rd_en = 1; 
        end 
        @(posedge rd_clk); 
        rd_en = 0; 
        #100; 
        $finish; 
    end 
endmodule
