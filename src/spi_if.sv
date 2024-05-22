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

interface spi_if ();
    logic csn;
    logic sclk;
    logic sdi;   // Serial Data Out From Controller (formerly MOSI)
    logic sdo;   // Serial Data Out From Responder  (formerly MISO)

    modport RESPONDER(
        input  csn,
        input  sclk,
        input  sdi,
        output sdo
    );

    modport CONTROLLER(
        output csn,
        output sclk,
        output sdi,
        input  sdo
    );
endinterface