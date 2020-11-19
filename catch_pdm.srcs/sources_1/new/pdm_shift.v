`timescale 1ns / 1ps


module pdm_shift(pdm_inputArray, pdm_data, shifted_pdm_array);
// input [31:0] index;
input [31:0] pdm_inputArray ;
input pdm_data;
reg [31:0] pdm_array;
output [31:0] shifted_pdm_array;

// always @(*) begin
//     // pdm_array <=pdm_inputArray;
//      shifted_pdm_array <= ((pdm_inputArray << 1)  + pdm_data);
// end
assign shifted_pdm_array = ((pdm_inputArray << 1)  + pdm_data);

endmodule