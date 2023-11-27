module param_reg #(
parameter N = 20
)(
input  logic             clk,
input  logic             rst,
input  logic             en,
input  logic [N - 1 : 0] D,

output logic [N - 1 : 0] Q
);

always_ff @(posedge clk) begin
    if (rst) 
        Q <= 'b0;
    else if (en)
        Q <= D;
end

endmodule 



module shift_reg #(
parameter N = 20
)(
input  logic             clk,
input  logic             rst,
input  logic             en,

input  logic             D,

output logic             Q
);

logic [N - 1] shift_reg;

always_ff @(posedge clk) begin
    if (rst)
        shift_reg <= 'b0;
    else if (en)
        shift_reg <= {D, shift_reg[N - 1 : 1]};
end

assign Q = shift_reg[0];

endmodule



module shift_reg_with_parellel_load #(
parameter N = 20
)(
input  logic             clk,
input  logic             rst,
input  logic             we,
input  logic             en,

input  logic [N - 1 : 0] D,

output logic             Q
);

logic [N - 1] shift_reg;

always_ff @(posedge clk) begin
    if (rst)
        shift_reg <= 'b0;
    else if (we) 
        shift_reg <= D;
    else if (en)
        shift_reg <= {D[N -1], shift_reg[N - 1 : 1]};
end

assign Q = shift_reg[0];

endmodule
