library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instruction_momery is 
port(
address:in std_logic_vector(31 downto 0); 
word_out:out std_logic_vector(31 downto 0)
);
end instruction_momery;

architecture Behavioral of instruction_momery is

type ins_memory is array (0 to 255) of std_logic_vector(7 downto 0);
signal my_memory : ins_memory :=
(   --Big-Endian
    -- Instruction 0: "00000001001010000101000000100100" (and $t2, $t1, $t0)
    0 => "00000001", -- Byte 0 (bits 31-24)
    1 => "00101000", -- Byte 1 (bits 23-16)
    2 => "01010000", -- Byte 2 (bits 15-8)
    3 => "00100100", -- Byte 3 (bits 7-0)

    -- Instruction 1: "00000001010010110110100000100101" (or $t5, $t2, $t3)
    4 => "00000001", -- Byte 4
    5 => "01001011", -- Byte 5
    6 => "01101000", -- Byte 6
    7 => "00100101", -- Byte 7

    -- Instruction 2: "00000001101010000101000000100000" (add $t2, $t3, $t0)
    8 => "00000001", -- Byte 8
    9 => "10101000", -- Byte 9
    10 => "01010000", -- Byte 10
    11 => "00100000", -- Byte 11

    -- Instruction 3: "00000001001010000101000000100010" (sub $t2, $t1, $t0)
    12 => "00000001", -- Byte 12
    13 => "00101000", -- Byte 13
    14 => "01010000", -- Byte 14
    15 => "00100010", -- Byte 15

    -- Instruction 4: "00010010000100011111111111111101" (beq $s0, $s1, L1)
    16 => "00010010", -- Byte 16
    17 => "00010001", -- Byte 17
    18 => "11111111", -- Byte 18
    19 => "11111101", -- Byte 19

    -- Instruction 5: "00000001001010000100000000100100" (and $t0, $t1, $t0)
    20 => "00000001", -- Byte 20
    21 => "00101000", -- Byte 21
    22 => "01000000", -- Byte 22
    23 => "00100100", -- Byte 23

    -- Instruction 6: "00000001001010000101000000100000" (add $t2, $t1, $t0)
    24 => "00000001", -- Byte 24
    25 => "00101000", -- Byte 25
    26 => "01010000", -- Byte 26
    27 => "00100000", -- Byte 27

    -- Instruction 7: "00000001001010000101000000100010" (sub $t2, $t1, $t0)
    28 => "00000001", -- Byte 28
    29 => "00101000", -- Byte 29
    30 => "01010000", -- Byte 30
    31 => "00100010", -- Byte 31

    -- Instruction 8: "00000001001010010100000000101010" (slt $t0, $t2, $t1)
    32 => "00000001", -- Byte 32
    33 => "00101001", -- Byte 33
    34 => "01000000", -- Byte 34
    35 => "00101010", -- Byte 35

    -- Instruction 9: "00001000000100000000000000000000" (j 0x00400000)
    36 => "00001000", -- Byte 36
    37 => "00010000", -- Byte 37
    38 => "00000000", -- Byte 38
    39 => "00000000", -- Byte 39

    -- Instruction 10: "00000000010000000011100000100000" (add $5, $2, $7)
    40 => "00000000", -- Byte 40
    41 => "01000000", -- Byte 41
    42 => "00111000", -- Byte 42
    43 => "00100000", -- Byte 43

    -- Instruction 11: "10001100011000110000000000000100" (lw $3, 4($5))
    44 => "10001100", -- Byte 44
    45 => "01100011", -- Byte 45
    46 => "00000000", -- Byte 46
    47 => "00000100", -- Byte 47

    -- Instruction 12: "00000000101000110001100000100101" (or $3, $5, $3)
    48 => "00000000", -- Byte 48
    49 => "10100011", -- Byte 49
    50 => "00011000", -- Byte 50
    51 => "00100101", -- Byte 51

    -- Instruction 13: "10101100010001100000000000000000" (sw $6, 0($2))
    52 => "10101100", -- Byte 52
    53 => "01000110", -- Byte 53
    54 => "00000000", -- Byte 54
    55 => "00000000", -- Byte 55

    -- Instruction 14: "10001100010000100000000000000000" (lw $2, 0($2))
    56 => "10001100", -- Byte 56
    57 => "01000010", -- Byte 57
    58 => "00000000", -- Byte 58
    59 => "00000000", -- Byte 59

    -- Instruction 15: "10101100101000110000000000000000" (sw $3, 0($5))
    60 => "10101100", -- Byte 60
    61 => "10100011", -- Byte 61
    62 => "00000000", -- Byte 62
    63 => "00000000",  -- Byte 63
    
    others=>x"00"
);


begin
word_out(31 downto 24)<=my_memory(to_integer(unsigned(address)));
word_out(23 downto 16)<=my_memory(to_integer(unsigned(address)+1));
word_out(15 downto 8)<=my_memory(to_integer(unsigned(address)+2));
word_out(7 downto 0)<=my_memory(to_integer(unsigned(address)+3));


end Behavioral;