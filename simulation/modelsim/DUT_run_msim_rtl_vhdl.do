transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/IITB-RISC-23/zero_appender_Imm.vhd}
vcom -93 -work work {D:/IITB-RISC-23/zero_appender_Carry.vhd}
vcom -93 -work work {D:/IITB-RISC-23/XOR_16.vhd}
vcom -93 -work work {D:/IITB-RISC-23/SUBTRACT.vhd}
vcom -93 -work work {D:/IITB-RISC-23/Stage6.vhd}
vcom -93 -work work {D:/IITB-RISC-23/Stage5.vhd}
vcom -93 -work work {D:/IITB-RISC-23/Stage4.vhd}
vcom -93 -work work {D:/IITB-RISC-23/stage3.vhd}
vcom -93 -work work {D:/IITB-RISC-23/Stage2.vhd}
vcom -93 -work work {D:/IITB-RISC-23/Stage1.vhd}
vcom -93 -work work {D:/IITB-RISC-23/SE9.vhd}
vcom -93 -work work {D:/IITB-RISC-23/SE6.vhd}
vcom -93 -work work {D:/IITB-RISC-23/Register_file.vhd}
vcom -93 -work work {D:/IITB-RISC-23/reg_with_reset.vhd}
vcom -93 -work work {D:/IITB-RISC-23/Processor.vhd}
vcom -93 -work work {D:/IITB-RISC-23/Priority_encoder.vhd}
vcom -93 -work work {D:/IITB-RISC-23/pipelineReg5.vhd}
vcom -93 -work work {D:/IITB-RISC-23/pipelineReg4.vhd}
vcom -93 -work work {D:/IITB-RISC-23/pipelineReg3.vhd}
vcom -93 -work work {D:/IITB-RISC-23/pipelineReg2.vhd}
vcom -93 -work work {D:/IITB-RISC-23/pipelineReg1.vhd}
vcom -93 -work work {D:/IITB-RISC-23/PC_Incrementer.vhd}
vcom -93 -work work {D:/IITB-RISC-23/NOR_ZBIT.vhd}
vcom -93 -work work {D:/IITB-RISC-23/NAND_16.vhd}
vcom -93 -work work {D:/IITB-RISC-23/mux16to1.vhd}
vcom -93 -work work {D:/IITB-RISC-23/mux4to1_for_BLE.vhd}
vcom -93 -work work {D:/IITB-RISC-23/mux4to1_3bits.vhd}
vcom -93 -work work {D:/IITB-RISC-23/mux4to1.vhd}
vcom -93 -work work {D:/IITB-RISC-23/mux2x1_16.vhd}
vcom -93 -work work {D:/IITB-RISC-23/mux2to1_16bits.vhd}
vcom -93 -work work {D:/IITB-RISC-23/mux2to1_3bits.vhd}
vcom -93 -work work {D:/IITB-RISC-23/MUX_8To1.vhd}
vcom -93 -work work {D:/IITB-RISC-23/mux_2to1_8.vhd}
vcom -93 -work work {D:/IITB-RISC-23/InstructionMemory.vhd}
vcom -93 -work work {D:/IITB-RISC-23/hazard_unit.vhd}
vcom -93 -work work {D:/IITB-RISC-23/Gates.vhd}
vcom -93 -work work {D:/IITB-RISC-23/DUT.vhd}
vcom -93 -work work {D:/IITB-RISC-23/data_memory.vhd}
vcom -93 -work work {D:/IITB-RISC-23/controller.vhd}
vcom -93 -work work {D:/IITB-RISC-23/complementer.vhd}
vcom -93 -work work {D:/IITB-RISC-23/bitRegister.vhd}
vcom -93 -work work {D:/IITB-RISC-23/ALU.vhd}
vcom -93 -work work {D:/IITB-RISC-23/ADD.vhd}
vcom -93 -work work {D:/IITB-RISC-23/ADD_4BIT.vhd}

vcom -93 -work work {D:/IITB-RISC-23/Testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
