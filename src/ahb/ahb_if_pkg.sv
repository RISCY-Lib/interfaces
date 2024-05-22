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

package ahb_if_pkg;

    typedef enum logic [2:0] {
        SINGLE = 3'b000,  // Single Transfer Burst
        INCR   = 3'b001,  // Incrementing burst of undefined length
        WRAP4  = 3'b010,  // 4-beat wrapping burst
        INCR4  = 3'b011,  // 4-beat incrementing burst
        WRAP8  = 3'b100,  // 8-beat wrapping burst
        INCR8  = 3'b101,  // 8-beat incrementing burst
        WRAP16 = 3'b110,  // 16-beat wrapping burst
        INCR16 = 3'b111   // 16-beat incrementing burst
    } burst_e;

    typedef struct packed {
        logic data;
        logic privileged;
        logic bufferable;
        logic modifiable;
    } memory_type_t;

    typedef struct packed {
        logic data;
        logic privileged;
        logic bufferable;
        logic modifiable;
        logic lookup;
        logic allocate;
        logic shareable;
    } extended_memory_type_t;

    typedef enum logic [2:0] {
        BYTE         = 3'b000, // 8-bits
        HALFWORD     = 3'b001, // 16-bits
        WORD         = 3'b010, // 32-bits
        DOUBLEWORD   = 3'b011, // 64-bits
        LINE_4WORDS  = 3'b100, // 128-bits
        LINE_8WORDS  = 3'b101, // 256-bits
        LINE_16WORDS = 3'b110, // 512-bits
        LINE_32WORDS = 3'b111  // 1024-bits
    } size_e;

    typedef enum logic {
        OKAY = 1'b0,
        ERROR = 1'b1
    } resp_e;

endpackage