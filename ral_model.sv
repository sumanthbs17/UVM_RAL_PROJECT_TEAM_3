class ral_chip_en_reg extends uvm_reg;
	rand uvm_reg_field chip_enable;      // chip enable signal

 
	`uvm_object_utils(ral_chip_en_reg)
 
	function new(string name = "ral_chip_en_reg");
		super.new(name, 1, build_coverage(UVM_NO_COVERAGE));
	endfunction: new
 
  // Build all register field objects
  virtual function void build();
    this.chip_enable     = uvm_reg_field::type_id::create("chip_enable",,   get_full_name());
 
 
    // configure(parent, size, lsb_pos, access, volatile, reset, has_reset, is_rand, individually_accessible); 
    this.chip_enable.configure(this, 1, 0, "RW", 0, 1'h0, 1, 1, 1);
  endfunction
endclass

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ral_chip_id extends uvm_reg;
	rand uvm_reg_field chip_id;      // chip enable signal

 
	`uvm_object_utils(ral_chip_en_reg)
 
	function new(string name = "ral_chip_en_reg");
      super.new(name, 8, build_coverage(UVM_NO_COVERAGE));
	endfunction: new
 
  // Build all register field objects
  virtual function void build();
    this.chip_id = uvm_reg_field::type_id::create("chip_id",,   get_full_name());
 
 
    // configure(parent, size, lsb_pos, access, volatile, reset, has_reset, is_rand, individually_accessible); 
    this.chip_id.configure(this, 8, 0, "RO", 0, 1'hAA, 1, 0, 1);
  endfunction
endclass

//////////////////////////////////////////////////////////////////////////////////////////////////////////////


  class ral_output_port_enable extends uvm_reg;
	rand uvm_reg_field output_port_enable;      // chip enable signal

 
	`uvm_object_utils(ral_output_port_enable)
 
	function new(string name = "ral_output_port_enable");
      super.new(name, 4, build_coverage(UVM_NO_COVERAGE));
	endfunction: new
 
  // Build all register field objects
  virtual function void build();
    this.output_port_enable = uvm_reg_field::type_id::create("output_port_enable",,   get_full_name());
 
 
    // configure(parent, size, lsb_pos, access, volatile, reset, has_reset, is_rand, individually_accessible); 
    this.output_port_enable.configure(this, 4, 0, "RW", 0, 1'h01, 1, 1, 1);
  endfunction
endclass

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  class model_reg extends uvm_reg_block;
	rand ral_chip_en_reg chip_en_reg_h   ;       // RW
  ral_chip_id  chip_id_h;   // RO
    rand  ral_output_port_enable   output_port_enable_h;       // RW
 
	`uvm_object_utils(model_reg)
 
	function new(string name = "model_reg");
		super.new(name, build_coverage(UVM_NO_COVERAGE));
	endfunction
 
  virtual function void build();
    this.default_map = create_map("", 0, 3, UVM_LITTLE_ENDIAN, 0);
    this.chip_en_reg_h =ral_chip_en_reg::type_id::create("chip_en_reg_h",,get_full_name());
    this.chip_en_reg_h.configure(this, null, "");
    this.chip_en_reg_h.build();
    this.default_map.add_reg(this.chip_en_reg_h, `UVM_REG_ADDR_WIDTH'h0, "RW", 0);
 
     
    this.chip_id_h = ral_chip_id::type_id::create("chip_id_h",,get_full_name());
    this.chip_id_h.configure(this, null, "");
    this.chip_id_h.build();
    this.default_map.add_reg(this.chip_id_h, `UVM_REG_ADDR_WIDTH'h4, "RO", 0);
 
    this.output_port_enable_h = ral_output_port_enable::type_id::create("output_port_enable_h",,get_full_name());
    this.output_port_enable_h.configure(this, null, "");
    this.output_port_enable_h.build();
    this.default_map.add_reg(this.output_port_enable_h, `UVM_REG_ADDR_WIDTH'h8, "RW", 0);
 
 
  endfunction 
endclass

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  class ral_sys_reg extends uvm_reg_block;
  rand model_reg md_reg;
 
	`uvm_object_utils(ral_sys_reg)
	function new(string name = "ral_sys_reg");
		super.new(name);
	endfunction
 
	function void build();
      this.default_map = create_map("", 0, 3, UVM_LITTLE_ENDIAN, 0);
      this.md_reg = model_reg::type_id::create("md_reg",,get_full_name());
      this.md_reg.configure(this, "tb_top.pB0");
      this.md_reg.build();
      this.default_map.add_submap(this.md_reg.default_map, `UVM_REG_ADDR_WIDTH'h0);
	endfunction
  endclass
