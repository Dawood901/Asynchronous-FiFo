onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /async_fifo_tb/DATA_WIDTH
add wave -noupdate /async_fifo_tb/synchronizer_stages
add wave -noupdate /async_fifo_tb/WRITE_PERIOD
add wave -noupdate /async_fifo_tb/READ_PERIOD
add wave -noupdate /async_fifo_tb/r_clk_tb
add wave -noupdate /async_fifo_tb/w_clk_tb
add wave -noupdate /async_fifo_tb/w_rst_tb
add wave -noupdate /async_fifo_tb/r_rst_tb
add wave -noupdate /async_fifo_tb/w_inc_tb
add wave -noupdate /async_fifo_tb/r_inc_tb
add wave -noupdate -radix unsigned /async_fifo_tb/wr_data_tb
add wave -noupdate -radix unsigned /async_fifo_tb/rd_data_tb
add wave -noupdate /async_fifo_tb/full_tb
add wave -noupdate /async_fifo_tb/empty_tb
add wave -noupdate -radix unsigned /async_fifo_tb/i
add wave -noupdate /async_fifo_tb/dut/mem_dut/wclk
add wave -noupdate /async_fifo_tb/dut/mem_dut/w_data
add wave -noupdate -radix unsigned -childformat {{{/async_fifo_tb/dut/mem_dut/reg_file[15]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[14]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[13]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[12]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[11]} -radix decimal} {{/async_fifo_tb/dut/mem_dut/reg_file[10]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[9]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[8]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[7]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[6]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[5]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[4]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[3]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[2]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[1]} -radix unsigned} {{/async_fifo_tb/dut/mem_dut/reg_file[0]} -radix unsigned}} -expand -subitemconfig {{/async_fifo_tb/dut/mem_dut/reg_file[15]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[14]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[13]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[12]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[11]} {-height 15 -radix decimal} {/async_fifo_tb/dut/mem_dut/reg_file[10]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[9]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[8]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[7]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[6]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[5]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[4]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[3]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[2]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[1]} {-height 15 -radix unsigned} {/async_fifo_tb/dut/mem_dut/reg_file[0]} {-height 15 -radix unsigned}} /async_fifo_tb/dut/mem_dut/reg_file
add wave -noupdate /async_fifo_tb/dut/write_dut/wq2_rptr
add wave -noupdate /async_fifo_tb/dut/write_dut/w_full
add wave -noupdate -radix binary /async_fifo_tb/dut/write_dut/w_ptr_binary
add wave -noupdate -color Magenta -radix unsigned /async_fifo_tb/dut/write_dut/w_ptr
add wave -noupdate /async_fifo_tb/dut/read_dut/rptr
add wave -noupdate -expand -group out_of_sync_to_read -radix unsigned /async_fifo_tb/dut/sync_w2r/SYNC
add wave -noupdate -radix unsigned /async_fifo_tb/dut/read_dut/rq2_wptr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {808576 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {252 ns}
