
`timescale 1ns/1ps

module async_fifo_tb ();

    parameter DATA_WIDTH = 16;
    parameter synchronizer_stages = 2;   
    parameter WRITE_PERIOD = 10; // 100 MHz = 10ns period
    parameter READ_PERIOD = 25; // 40 MHz = 25ns period

    // Testbench signals
    reg w_clk_tb;
    reg w_rst_tb;
    reg w_inc_tb;
    reg [DATA_WIDTH-1:0] wr_data_tb;
    
    reg r_clk_tb;
    reg r_rst_tb;
    reg r_inc_tb;
    wire [DATA_WIDTH-1:0] rd_data_tb;
    
    wire full_tb;
    wire empty_tb;

    integer i;

    // Clock generation
    always #(WRITE_PERIOD/2) w_clk_tb = ~w_clk_tb;
    always #(READ_PERIOD/2) r_clk_tb = ~r_clk_tb;
    
    // VCD dump
    initial begin
        $dumpfile("async_fifo.vcd");
        $dumpvars(0, async_fifo_tb);
    end

    // Async FIFO instance
    async_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .synchronizer_stages(synchronizer_stages)
    ) dut (
        .w_clk(w_clk_tb),
        .w_rst(w_rst_tb),
        .w_inc(w_inc_tb),
        .wr_data(wr_data_tb),
        .r_clk(r_clk_tb),
        .r_rst(r_rst_tb),
        .r_inc(r_inc_tb),
        .rd_data(rd_data_tb),
        .full(full_tb),
        .empty(empty_tb)
    );

    // Task to check flags
    task check_flags;
        input expected_full;
        input expected_empty;
        begin
            $display("  Flags - FULL: %b (exp: %b), EMPTY: %b (exp: %b)", 
                     full_tb, expected_full, empty_tb, expected_empty);
            
            if (full_tb && empty_tb) begin
              $error("ILLEGAL STATE: FIFO cannot be both FULL and EMPTY!");
            end
            
            if (full_tb !== expected_full) begin
                $error("FULL flag mismatch: Expected %b, Got %b", expected_full, full_tb);
            end
            
            if (empty_tb !== expected_empty) begin
                $error("EMPTY flag mismatch: Expected %b, Got %b", expected_empty, empty_tb);
            end
        end
    endtask

    // Task to check data
    task check_data;
        input [DATA_WIDTH-1:0] expected_data;
        begin
            $display("  Data - Read: %h, Expected: %h", rd_data_tb, expected_data);
            
            if (rd_data_tb !== expected_data) begin
                $error("DATA MISMATCH: Expected %h, Got %h", expected_data, rd_data_tb);
            end
        end
    endtask

    // MAIN INITIAL BLOCK: Contains first two tests
    initial begin
        // Initialize signals
        w_clk_tb = 0;
        r_clk_tb = 0;
        w_rst_tb = 0;
        r_rst_tb = 0;
        w_inc_tb = 0;
        r_inc_tb = 0;
        wr_data_tb = 0;

        $display("=== Starting FIFO Test Suite ===");
        
        // Reset
        @(negedge w_clk_tb);
        @(negedge r_clk_tb);
        w_rst_tb = 0;
        r_rst_tb = 0;
        
        @(negedge w_clk_tb);
        @(negedge r_clk_tb);
        w_rst_tb = 1;
        r_rst_tb = 1;
        
        @(negedge w_clk_tb);
        @(negedge r_clk_tb);

        // TEST CASE 1: Write 0 to 15 to fill FIFO
        $display("=== TEST 1: Write 0 to 15 to fill FIFO ===");
        
        for (i = 0; i < 16; i = i + 1) begin
            @(negedge w_clk_tb);
            wr_data_tb = i;
            w_inc_tb = 1;
            $display("Written: %h", wr_data_tb);
        end
        
        @(negedge w_clk_tb);
        w_inc_tb = 0;
        
        // Wait for flags to update
        #50;
        check_flags(1, 0); // Should be full
        $display("=== TEST 1 PASSED ===\n");

        // TEST CASE 2: Read all data from FIFO
        $display("=== TEST 2: Read all data from FIFO ===");
        
        for (i = 0; i < 16; i = i + 1) begin
            @(negedge r_clk_tb);
            r_inc_tb = 1;
            @(posedge r_clk_tb);
            check_data(i); // Check data matches what was written (0-15)
        end
        
        @(negedge r_clk_tb);
        r_inc_tb = 0;
        
        // Wait for flags to update
        #50;
        check_flags(0, 1); // Should be empty
        $display("=== TEST 2 PASSED ===\n");
    end

    // SEPARATE INITIAL BLOCK FOR TEST 3 WRITE
    initial begin
        // Wait for first two tests to complete
        #1000;
        
        $display("=== TEST 3: Simultaneous Write (Starting) ===");
        
        // Start writing
        @(negedge w_clk_tb);
        w_inc_tb = 1;
        
        // Write 10 values
        for (i = 0; i < 10; i = i + 1) begin
            @(negedge w_clk_tb);
            wr_data_tb = i + 100; // Write values 100-109
            @(posedge w_clk_tb);
            $display("TEST 3 - Written: %h", wr_data_tb);
        end
        
        @(negedge w_clk_tb);
        w_inc_tb = 0;
        
        $display("=== TEST 3 Write Completed ===");
    end

    // SEPARATE INITIAL BLOCK FOR TEST 3 READ
    initial begin
        // Wait for first two tests to complete
        #1000;
        
        $display("=== TEST 3: Simultaneous Read (Starting) ===");
        
        // Start reading
        @(negedge r_clk_tb);
        r_inc_tb = 1;
        
        // Read 10 values
        for (i = 0; i < 10; i = i + 1) begin
            @(posedge r_clk_tb);
            check_data(i + 100); // Should read same data that was written (100-109)
            check_flags(0, 0); // Should not be full or empty
        end
        
       // @(negedge r_clk_tb);
       // r_inc_tb = 0;
        
        // Wait for flags to update
        #50;
        check_flags(0, 1); // Should be empty after simultaneous ops
        $display("=== TEST 3 Read Completed ===");
        
        $display("=== All test cases passed! ===");
        $stop();
    end

endmodule
