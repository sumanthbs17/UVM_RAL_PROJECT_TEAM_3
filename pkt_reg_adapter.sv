class pkt_reg_adapter extends uvm_reg_adapter;
   `uvm_object_utils( pkt_reg_adapter )
   function new( string name = "" );
      super.new( name );
      supports_byte_enable = 0;
      provides_responses   = 0;
   endfunction: new
   virtual function uvm_sequence_item reg2bus( const ref uvm_reg_bus_op rw );
      pkt_transaction p_tx
        = pkt_transaction::type_id::create("p_tx");
      if ( rw.kind == UVM_READ )       p_tx.command = pkt_types::READ;
      else if ( rw.kind == UVM_WRITE ) p_tx.command = pkt_types::WRITE;
      else                             p_tx.command = pkt_types::NO_OP;
      if ( rw.kind == UVM_WRITE )
        { p_tx.chip_enable, p_tx.output_port_enable } = rw.data;
      return p_tx;
   endfunction: reg2bus
   virtual function void bus2reg( uvm_sequence_item bus_item,
                                  ref uvm_reg_bus_op rw );
      pkt_transaction p_tx;
      if ( ! $cast( p_tx, bus_item ) ) begin
         `uvm_fatal( get_name(),
                     "bus_item is not of the pkt_transaction type." )
         return;
      end
      rw.kind = ( p_tx.command == pkt_types::READ ) ? UVM_READ : UVM_WRITE;
      if ( p_tx.command == pkt_types::READ )
        rw.data = p_tx.taste;
      else if ( p_tx.command == pkt_types::WRITE )
        rw.data = { p_tx.chip_enable, p_tx.output_port_enable};
      rw.status = UVM_IS_OK;
   endfunction: bus2reg
endclass: pkt_reg_adapter
