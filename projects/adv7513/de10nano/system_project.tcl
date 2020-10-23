
source ../../scripts/adi_env.tcl
source ../../scripts/adi_project_intel.tcl

adi_project adv7513_de10nano

exec -ignorestderr $quartus(quartus_rootpath)/sopc_builder/bin/qsys-generate \
      system_bd.qsys --synthesis=VHDL --family=$family --part=$device \

source $ad_hdl_dir/projects/common/de10nano/de10nano_system_assign.tcl

execute_flow -compile
