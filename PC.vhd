library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity PC is
    Port ( 
	CLK: in  STD_LOGIC;
	LOAD : in  STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
           PC_OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0):=x"00000000");
end PC;

architecture Behavioural of PC is


begin
process(CLK)
begin
  if rising_edge(CLK) then
     PC_OUTPUT<= LOAD;
   end if;
end process;
  



end Behavioural;
