module fifo_mem #(
    parameter DATA_WIDTH=8
) (
    
input wclk,
input [3:0] w_addr,
input [3:0] raddr,
input wclken,
input [DATA_WIDTH-1:0] w_data,
output reg [DATA_WIDTH-1:0] rdata


);

reg [DATA_WIDTH-1:0] reg_file [15:0];

always @(posedge wclk) begin
    
    if (wclken) begin
        reg_file[w_addr]<=w_data;
        
    end


end

always @(*) begin //asyncrouns read
    rdata=reg_file[raddr];
end
    
endmodule
