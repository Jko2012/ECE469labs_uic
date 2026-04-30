onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/reset
add wave -noupdate -radix hexadecimal /testbench/dut/mips/dp/pc
add wave -noupdate -radix hexadecimal /testbench/dut/mips/dp/instr
add wave -noupdate -radix hexadecimal /testbench/dut/mips/c/md/state
add wave -noupdate -radix hexadecimal /testbench/dut/mips/dp/srca
add wave -noupdate -radix hexadecimal /testbench/dut/mips/dp/srcb
add wave -noupdate -radix hexadecimal /testbench/dut/mips/dp/aluresult
add wave -noupdate -radix hexadecimal /testbench/dut/mips/dp/zero
add wave -noupdate -radix hexadecimal /testbench/dut/mips/c/md/controls
add wave -noupdate -radix decimal /testbench/clockcycle
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {637 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 205
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {966 ps}
