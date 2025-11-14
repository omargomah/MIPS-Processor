library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity Jump_Shift is
    Port ( INPUT : in  STD_LOGIC_VECTOR (25 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (27 downto 0));
end Jump_Shift;

architecture Behavioral of Jump_Shift is

begin
OUTPUT<=INPUT(25 downto 0) & "00";

end Behavioral;
