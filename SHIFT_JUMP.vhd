library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity SHIFT is
    Port ( INPUT : in  STD_LOGIC_VECTOR (25 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (27 downto 0));
end SHIFT;

architecture Behavioral of SHIFT is

begin
OUTPUT<=INPUT & "00";

end Behavioral;
