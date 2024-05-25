/**************************************************************************************************
 * RISCY-Lib System Verilog Interfaces Library
 * Copyright (C) 2024 RISCY-Lib Contributors
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; If not, see <https://www.gnu.org/licenses/>.
 **************************************************************************************************/

 interface axistream_if #(
    parameter int TDATA_WIDTH = 32,
    parameter int TID_WIDTH   = 4,
    parameter int TDEST_WIDTH = 4,

    parameter int REVISION = 5
) (
    input logic aclk,
    input logic aresetn
);

    localparam int TSTRB_WIDTH = TDATA_WIDTH / 8;

    logic tvalid;
    logic tready;
    logic [TDATA_WIDTH-1:0] tdata;
    logic [TSTRB_WIDTH-1:0] tstrb;
    logic [TSTRB_WIDTH-1:0] tkeep;
    logic                   tlast;
    logic [  TID_WIDTH-1:0] tid;
    logic [TDEST_WIDTH-1:0] tdest;
    logic                   twakeup;

    generate
        if (TDATA_WIDTH % 8 != 0) begin: tdata_width_check
            $error("%m: TDATA Width must be multiple of 8");
        end
    endgenerate

    generate
        if (REVISION == 4) begin : revision_4_generate
            assign twakeup = 1'b1;
        end
        else if (REVISION != 5) begin : revision_invalid_generate
            $error("%m: AXI-Stream Inteface Revision is invalid (%01d)", REVISION);
        end
    endgenerate

    modport TRANSMITTER (
        output tvalid,
        input  tready,
        output tdata,
        output tstrb,
        output tkeep,
        output tlast,
        output tid,
        output tdest,
        output twakeup
    );
generate
    modport RECEIVER (
        input  tvalid,
        output tready,
        input  tdata,
        input  tstrb,
        input  tkeep,
        input  tlast,
        input  tid,
        input  tdest,
        input  twakeup
    );
endgenerate

endinterface
