
module write_block (
  input         winc,
  input         w_clk,
  input         wrst_n,
  input  [4:0]  wq2_rptr, // synchronized read pointer in the write domain (gray)
  output reg    w_full,   // full flag (registered)
  output [3:0]  w_addr,   // actual write address
  output [4:0]  w_ptr     // write pointer gray encoded to send to read blk (wire)
);

  reg [4:0] w_ptr_binary;
  wire [4:0] wptr_w;

  assign wptr_w = w_ptr_binary ^ (w_ptr_binary >> 1);
  assign w_ptr = wptr_w;
  assign w_addr = w_ptr_binary[3:0];

  always @(posedge w_clk or negedge wrst_n) begin
    if (!wrst_n) begin
      w_ptr_binary <= 5'b0;
      w_full <= 1'b0;
    end else begin
      if (winc && !w_full) begin
        w_ptr_binary <= w_ptr_binary + 1'b1;
      end

      // update full flag synchronously
      // full condition: next write pointer equals synchronized read pointer with MSB inverted
      // common technique: compare gray-coded pointers
      if (wptr_w[4] != wq2_rptr[4] && wptr_w[3] != wq2_rptr[3]  && wptr_w[2:0] == wq2_rptr[2:0])
        w_full <= 1'b1;
      else
        w_full <= 1'b0;
    end
  end

endmodule
