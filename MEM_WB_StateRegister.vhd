library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEM_WB_StateRegister is
    Port ( 
	CLK: in  STD_LOGIC;
	LOAD : in  STD_LOGIC_VECTOR (69 downto 0):= (others => '0');
    OUTPUT : out  STD_LOGIC_VECTOR (69 downto 0):= (others => '0')
    );
end MEM_WB_StateRegister ;
architecture Behavioural of MEM_WB_StateRegister is
begin
  process(CLK)
  begin
    if rising_edge(CLK) then 
        OUTPUT <= LOAD; 
    end if;
  end process;
end Behavioural;

