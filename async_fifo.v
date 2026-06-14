
module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter synchronizer_stages =2 
) (
    input w_clk,
    input w_rst,
    input w_inc,
    input [DATA_WIDTH-1:0] wr_data,
    
    input r_clk,
    input r_rst,
    input r_inc,
    output [DATA_WIDTH-1:0] rd_data,
    
    output full,
    output empty
);

    // Internal wires
    wire [4:0] w_ptr;          // write pointer (gray)
    wire [4:0] r_ptr;          // read pointer (gray)
    wire [3:0] w_addr;         // write address
    wire [3:0] raddr;          // read address
    wire w_full;               // full flag from write block
    wire r_empty;              // empty flag from read block
    
    // Synchronized pointers
    wire [4:0] wq2_rptr;       // synchronized read pointer in write domain
    wire [4:0] rq2_wptr;       // synchronized write pointer in read domain
    
    // Write block instance
    write_block write_dut (
        .winc(w_inc),
        .w_clk(w_clk),
        .wrst_n(w_rst),
        .wq2_rptr(wq2_rptr),     // synchronized read pointer
        .w_full(w_full),         // full flag
        .w_addr(w_addr),         // write address
        .w_ptr(w_ptr)            // write pointer (gray)
    );
    
    // Read block instance
    read_block read_dut (
        .r_clk(r_clk),
        .rrst_n(r_rst),
        .rinc(r_inc),
        .rq2_wptr(rq2_wptr),     // synchronized write pointer
        .rptr(r_ptr),            // read pointer (gray)
        .raddr(raddr),           // read address
        .rempty(r_empty)         // empty flag
    );
    
    // FIFO memory instance
    fifo_mem #(
        .DATA_WIDTH(DATA_WIDTH)
    ) mem_dut (
        .wclk(w_clk),
        .w_addr(w_addr),
        .raddr(raddr),
        .wclken(w_inc && !w_full),  // write only when not full
        .w_data(wr_data),
        .rdata(rd_data)
    );
    
    
   
    // CDC synchronizers
    BIT_SYNC #(
    .NUM_STAGES(synchronizer_stages),
    .BUS_WIDTH(5)
) sync_r2w (
    .CLK(w_clk),
    .RST(w_rst),
    .ASYNC(r_ptr),
    .SYNC(wq2_rptr)
);

BIT_SYNC #(
    .NUM_STAGES(synchronizer_stages),
    .BUS_WIDTH(5)
) sync_w2r (
    .CLK(r_clk),
    .RST(r_rst),
    .ASYNC(w_ptr),
    .SYNC(rq2_wptr)
);


    // Output assignments
    assign full = w_full;
    assign empty = r_empty;





    
endmodule
