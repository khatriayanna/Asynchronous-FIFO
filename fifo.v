module async_fifo_min #( 
    parameter DATA_WIDTH = 8, 
    parameter DEPTH      = 16, 
    parameter ADDR_WIDTH = 4   // log2(DEPTH) 
)( 
    input  wire                  wr_clk, 
    input  wire                  rd_clk, 
    input  wire                  wr_rst, 
    input  wire                  rd_rst, 
    input  wire                  wr_en, 
    input  wire                  rd_en, 
    input  wire [DATA_WIDTH-1:0] data_in, 
    output reg  [DATA_WIDTH-1:0] data_out, 
    output reg                   full, 
    output reg                   empty, 
    output reg  [ADDR_WIDTH:0]   count ); 
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1]; 
    reg [ADDR_WIDTH-1:0] wr_ptr; 
    reg [ADDR_WIDTH-1:0] rd_ptr; 
    // WRITE operation 
    always @(posedge wr_clk or posedge wr_rst) begin 
        if (wr_rst) begin 
            wr_ptr <= 0; 
        end 
        else if (wr_en && !full) begin 
            mem[wr_ptr] <= data_in; 
            wr_ptr <= wr_ptr + 1; 
        end 
    end 
    // READ operation 
    always @(posedge rd_clk or posedge rd_rst) begin 
        if (rd_rst) begin 
            rd_ptr   <= 0; 
            data_out <= 0; 
        end 
        else if (rd_en && !empty) begin 
            data_out <= mem[rd_ptr]; 
            rd_ptr <= rd_ptr + 1; 
        end 
    end 
    // FULL/EMPTY + COUNT 
    always @(*) begin 
        empty = (wr_ptr == rd_ptr); 
        full  = ((wr_ptr + 1'b1) == rd_ptr); 
        // count calculation 
        if (wr_ptr >= rd_ptr) 
            count = wr_ptr - rd_ptr; 
        else 
            count = DEPTH + wr_ptr - rd_ptr; 
    end 
endmodule
