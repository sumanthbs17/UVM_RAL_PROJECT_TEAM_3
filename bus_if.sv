interface bus_if (input pclk);
  // This interface holds signals related to APB bus protocol
   logic [31:0]   paddr;
   logic [31:0]   pwdata;
   logic [31:0]   prdata;
   logic          pwrite;
   logic          psel;
   logic          penable;
   logic          presetn;
endinterface
