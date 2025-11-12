library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instruction_momery is 
port(
pc:in std_logic_vector(3 downto 0); --for 16 instructions 
instruction:out std_logic_vector(31 downto 0)
);
end instruction_momery;

architecture Behavioral of instruction_momery is

type rom1 is array (0 to 15) of std_logic_vector(31 downto 0);
signal memory1 : rom1:=
(
"00000001001010000101000000100100", -- and $t2, $t1, $t0  
"00000001010010110110100000100101", -- or  $t5, $t2, $t3  
"00000001101010000101000000100000", -- add $t2, $t3, $t0  
"00000001001010000101000000100010", -- sub $t2, $t1, $t0  
"00010010000100011111111111111101", -- beq $s0, $s1, L1 (branch -3)  
"00000001001010000100000000100100", -- and $t0, $t1, $t0  
"00000001001010000101000000100000", -- add $t2, $t1, $t0  
"00000001001010000101000000100010", -- sub $t2, $t1, $t0  
"00000001001010010100000000101010", -- slt $t0, $t2, $t1  
"00001000000100000000000000000000", -- j 0x00400000  
"00000000010000000011100000100000", -- add $5, $2, $7  
"10001100011000110000000000000100", -- lw $3, 4($5)  
"00000000101000110001100000100101", -- or  $3, $5, $3  
"10101100010001100000000000000000", -- sw $6, 0($2)  
"10001100010000100000000000000000", -- lw $2, 0($2)  
"10101100101000110000000000000000"  -- sw $3, 0($5)
);

begin
process(pc)
begin
instruction<=memory1(to_integer(unsigned(pc)));
end process;

end Behavioral;