`timescale 1ns / 1ps
// `include "pdm_shift.v"
`include "uart_tx.v"
`include "uart_rx.v"

`define bound 46874

module input_pdm(
    input pdm_data,
    input clock,
    input rst,
    output reg pdm
);

parameter c_CLOCK_PERIOD_NS = 666;  
parameter c_CLKS_PER_BIT    = 156;  // 1.5M/9600 = 156
parameter c_BIT_PERIOD      = 102896;

integer i;
integer a = 0;


reg r_Clock = 0;
reg r_Tx_DV = 0;
wire w_Tx_Done;
reg [7:0] r_Tx_Byte = 0;
reg r_Rx_Serial = 1;
wire [7:0] w_Rx_Byte;

// wire [31:0] pdmreceive;

reg [2:0] count = 0;
// reg [31:0] pdm_array [0:`bound];
reg [7:0] pdm_array [0:`bound];


  uart_rx #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_RX_INST
    (.i_Clock(r_Clock),
     .i_Rx_Serial(r_Rx_Serial),
     .o_Rx_DV(),
     .o_Rx_Byte(w_Rx_Byte)
     );
   
  uart_tx #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_TX_INST
    (.i_Clock(r_Clock),
     .i_Tx_DV(r_Tx_DV),
     .i_Tx_Byte(r_Tx_Byte),
     .o_Tx_Active(),
     .o_Tx_Serial(),
     .o_Tx_Done(w_Tx_Done)
     );
 
always @(posedge clock or posedge rst  ) 
begin
    if(rst) 
    begin
        // pdm_array <= 0;
        count <= 0;
        pdm <= 0;
        for(i=0;i<=`bound;i=i+1)
        begin
            pdm_array[i] <= 8'b0;
            
            // $display(" i = %d , pdm_array = %b \n\n" , i , pdm_array[i]);
        end
    end 
    else 
    begin
        count <= count + 1;
        // pdm <= pdm_array[a];
        // pdm_array[a] <=pdmreceive;
        if(count == 7) begin
            a <= a + 1;
            $display("%4dns  count = %d , pdm_array[%d] = %b \n\n" , $stime, count ,a , pdm_array[a]);
        end
        else 
            pdm<=0;
            
        if(a > 20000)begin
//            pdm = 1;
            $finish;

        end
        // pdm_array[a] <= pdmshift(pdm_array[a], pdm_data);
        // pdm_array[a] = ((pdm_array[a] << 1)  + pdm_data);
        // $display("counter = %d \n", count);
        // $display("%4dns  count = %d , pdm_data = %b , pdm_array[%d] = %b \n\n" , $stime, count , pdm_data ,a , pdm_array[a]);
    end

end 
always @(pdm_data) begin
    // pdm_array[a] <= pdmshift(pdm_array[a], pdm_data);
    pdm_array[a] <= ((pdm_array[a] << 1)  + pdm_data);
end
    
// function [31:0] pdmshift ;
//     input [31:0] array;
//     input data;
//     array = ((array << 1)  + data);
// endfunction

endmodule
