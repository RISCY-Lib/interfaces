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

interface i2c_if #(
    parameter int ADDRESS_PINS = 0;
)();

    logic sda;
    logic scl;
    logic [ADDRESS_PINS-1:0] addr;

    modport RECEIVER (
        inout sda,
        input scl,
        input addr
    );

    modport DRIVER (
        inout sda,
        output scl,
        output addr
    );
endinterface