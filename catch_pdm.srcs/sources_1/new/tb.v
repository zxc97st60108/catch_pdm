`timescale 1ns/1ps
`include "input_pdm.v"
module tb();

reg clock;
reg pdm_data;
wire  pdm;
wire [31:0] pdm_receive;
reg [23:0] count;
reg rst;
// reg rst;

input_pdm foo(pdm_data,clock,rst,pdm);

initial begin
	clock = 1'b0;
	pdm_data = 1'b1;
    count = 0;
    rst=1;
    #1
    rst=0;
        // $monitor("%4dns  count = %d , pdm_array = %b \n\n" , $stime, count  , pdm);
     $dumpfile("tb");
     $dumpvars;
end

always @(posedge clock)begin
    count <= count + 1;
    // $display("counter = %d \n", count);
    // $display("%4dns  pdm = %b , pdm_data = %b \n\n", $stime, pdm, pdm_data);
    // if(count == 33)
    //     $finish;
end
// assign pdm =pdm_receive;
always #2 clock<=~clock;
always #4 pdm_data<=~pdm_data;

endmodule