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

interface ahb5_if #(
    parameter int ADDR_WIDTH    = 32,
    parameter int HMASTER_WIDTH = 8,
    parameter int DATA_WIDTH    = 32,

    parameter logic  BURST_ENABLED = 1'b0, 
    parameter string PROT_MODE     = "NONE"  // Options are "NONE", "NORMAL", "EXTENDED"
) (
    input logic hclk,
    input logic hreset_n
);

    // Local Definitions
    //==============================================================================================
    localparam int STRB_WIDTH = DATA_WIDTH / 8;

    // Signals
    //==============================================================================================
    logic [ ADDR_WIDTH-1:0]   haddr;
    ahb_if_pkg::burst_e          hburst;
    logic                     hmastlock;
    ahb_if_pkg::size_e           hsize;
    logic                     hnonsec;
    logic                     hexcl;
    logic [HMASTER_WIDTH-1:0] hmaster;
    ahb_if_pkg::transfer_type_e  htrans;
    logic [DATA_WIDTH-1:0]    hwdata;
    logic [STRB_WIDTH-1:0]    hwstrb;
    logic                     hwrite;

    logic [DATA_WIDTH-1:0] hrdata;
    logic                  hready;
    ahb_if_pkg::resp_e        hresp;
    logic                  hexokay;

    generate
        if (!BURST_ENABLED) begin
            assign hburst = ahb_if_pkg::SINGLE;
        end
    endgenerate

    generate
        if (PROT_MODE == "NONE") begin
            ahb_if_pkg::memory_type_t hprot = 4'h1;
        end
        else if (PROT_MODE == "NORMAL") begin
            ahb_if_pkg::memory_type_t hprot;
        end
        else if (PROT_MODE == "EXTENDED") begin
            ahb_if_pkg::extended_memory_type_t hprot;
        end
        else begin
            $error("%m ** ahb5_if: Invalid PROT_MODE = %s", PROT_MODE);
        end
    endgenerate

    modport MANAGER(
        output haddr,
        output hburst,
        output hmastlock,
        output hprot,
        output hsize,
        output hnonsec,
        output hexcl,
        output hmaster,
        output htrans,
        output hwdata,
        output hwstrb,
        output hwrite,

        input hrdata,
        input hready,
        input hresp,
        input hexokay
    );

    modport SUBORDINATE(
        input haddr,
        input hburst,
        input hmastlock,
        input hprot,
        input hsize,
        input hnonsec,
        input hexcl,
        input hmaster,
        input htrans,
        input hwdata,
        input hwstrb,
        input hwrite,

        output hrdata,
        output hready,
        output hresp,
        output hexokay
    );

endinterface