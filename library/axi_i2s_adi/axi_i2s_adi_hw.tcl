

package require qsys

source ../scripts/adi_env.tcl
source ../scripts/adi_ip_intel.tcl

set_module_property NAME axi_i2s_adi
set_module_property DESCRIPTION "AXI i2s Interface"
set_module_property VERSION 1.0
set_module_property GROUP "Analog Devices"
set_module_property DISPLAY_NAME axi_i2s_adi

# files

ad_ip_files axi_i2s_adi [list \
  $ad_hdl_dir/library/common/axi_ctrlif.vhd \
  $ad_hdl_dir/library/common/axi_streaming_dma_tx_fifo.vhd \
  $ad_hdl_dir/library/common/axi_streaming_dma_rx_fifo.vhd \
  $ad_hdl_dir/library/common/pl330_dma_fifo.vhd \
  $ad_hdl_dir/library/common/dma_fifo.vhd \
  i2s_controller.vhd \
  i2s_rx.vhd \
  i2s_tx.vhd \
  i2s_clkgen.vhd \
  fifo_synchronizer.vhd \
  axi_i2s_adi.vhd \
  axi_i2s_adi_constr.sdc \
]

# parameters

add_parameter SLOT_WIDTH INTEGER 24
set_parameter_property SLOT_WIDTH DEFAULT_VALUE 24
set_parameter_property SLOT_WIDTH DISPLAY_NAME SLOT_WIDTH
set_parameter_property SLOT_WIDTH UNITS None
set_parameter_property SLOT_WIDTH HDL_PARAMETER true

add_parameter LRCLK_POL INTEGER 0
set_parameter_property LRCLK_POL DEFAULT_VALUE 0
set_parameter_property LRCLK_POL DISPLAY_NAME "LRCLK Polarity"
set_parameter_property LRCLK_POL UNITS None
set_parameter_property LRCLK_POL HDL_PARAMETER true

add_parameter BCLK_POL INTEGER 0
set_parameter_property BCLK_POL DEFAULT_VALUE 0
set_parameter_property BCLK_POL DISPLAY_NAME "BCLK Polarity"
set_parameter_property BCLK_POL UNITS None
set_parameter_property BCLK_POL HDL_PARAMETER true

add_parameter S_AXI_DATA_WIDTH INTEGER 32
set_parameter_property S_AXI_DATA_WIDTH DEFAULT_VALUE 32
set_parameter_property S_AXI_DATA_WIDTH DISPLAY_NAME S_AXI_DATA_WIDTH
set_parameter_property S_AXI_DATA_WIDTH UNITS None
set_parameter_property S_AXI_DATA_WIDTH HDL_PARAMETER true

add_parameter S_AXI_ADDRESS_WIDTH INTEGER 32
set_parameter_property S_AXI_ADDRESS_WIDTH DEFAULT_VALUE 32
set_parameter_property S_AXI_ADDRESS_WIDTH DISPLAY_NAME S_AXI_ADDRESS_WIDTH
set_parameter_property S_AXI_ADDRESS_WIDTH UNITS None
set_parameter_property S_AXI_ADDRESS_WIDTH HDL_PARAMETER true

add_parameter NUM_OF_CHANNEL INTEGER 1
set_parameter_property NUM_OF_CHANNEL DEFAULT_VALUE 1
set_parameter_property NUM_OF_CHANNEL DISPLAY_NAME NUM_OF_CHANNEL
set_parameter_property NUM_OF_CHANNEL UNITS None
set_parameter_property NUM_OF_CHANNEL HDL_PARAMETER true

add_parameter HAS_TX INTEGER 1
set_parameter_property HAS_TX DEFAULT_VALUE 1
set_parameter_property HAS_TX DISPLAY_NAME "Enable TX"
set_parameter_property HAS_TX UNITS None
set_parameter_property HAS_TX HDL_PARAMETER true

add_parameter HAS_RX INTEGER 0
set_parameter_property HAS_RX DEFAULT_VALUE 0
set_parameter_property HAS_RX DISPLAY_NAME "Enable RX"
set_parameter_property HAS_RX UNITS None
set_parameter_property HAS_RX HDL_PARAMETER true

# axi4 slave

ad_ip_intf_s_axi s_axi_aclk s_axi_aresetn

# serial data interface

add_interface data_clk_i clock end
add_interface_port data_clk_i data_clk_i clk Input 1

add_interface serial_data conduit end
set_interface_property serial_data associatedClock data_clk_i

# fix me !! signal width dependent of number of channels (default 1)
# ##################################################################
add_interface_port serial_data bclk_o   bclk_o  Output 1
add_interface_port serial_data lrclk_o  lrclk_o Output 1
add_interface_port serial_data sdata_o  sdata_o Output 1
add_interface_port serial_data sdata_i  sdata_i Input 1

# AXI Streaming DMA TX interface

add_interface s_axis_aclk clock end
add_interface_port s_axis_aclk s_axis_aclk clk Input 1
add_interface s_axis_aresetn reset end
set_interface_property s_axis_aresetn associatedClock s_axis_aclk

add_interface tx_dma_if axi4stream end
set_interface_property tx_dma_if associatedClock s_axis_aclk
add_interface_port tx_dma_if s_axis_tready tready Output 1
add_interface_port tx_dma_if s_axis_tdata  tdata  Input 32
add_interface_port tx_dma_if s_axis_tlast  tlast  Input 1
add_interface_port tx_dma_if s_axis_tvalid tvalid Input 1

## AXI Streaming DMA RX interface

#add_interface m_axis_aclk clock end
#add_interface_port m_axis_aclk m_axis_aclk clk Input 1

#add_interface rx_dma_if axi4stream end
#set_interface_property rx_dma_if associatedClock m_axis_aclk
#add_interface_port rx_dma_if dma_ready tready Input 1
#add_interface_port rx_dma_if dma_valid tvalid Output 1
#add_interface_port rx_dma_if dma_data  tdata  Output 32
#add_interface_port rx_dma_if dma_last  tlast  Output 1
#add_interface_port rx_dma_if dma_keep  tkeep  Output 4

