class base_test extends uvm_test;
   `uvm_component_utils (base_test)

   my_env         m_env;
   base_sequence    m_seq;
   reset_seq      m_reset_seq;
   uvm_status_e   status;

   function new (string name = "base_test", uvm_component parent);
      super.new (name, parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      m_env = my_env::type_id::create ("m_env", this);
      m_seq = base_sequence::type_id::create ("m_seq", this);
      m_reset_seq = reset_seq::type_id::create ("m_reset_seq", this);


   virtual task reset_phase (uvm_phase phase);
      super.reset_phase (phase);
      phase.raise_objection (this);
      m_reset_seq.start (m_env.m_agent.m_seqr);
      phase.drop_objection (this);
   endtask

   virtual task main_phase (uvm_phase phase);
      phase.raise_objection (this);
      m_seq.start (m_env.m_agent.m_seqr);
      phase.drop_objection (this);
   endtask
endclass
