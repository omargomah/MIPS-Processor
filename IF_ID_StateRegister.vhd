library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IF_ID_StateRegister is
    Port ( 
	CLK: in  STD_LOGIC;
	IF_Flush: in  STD_LOGIC;
	IF_ID_Write: in  STD_LOGIC;
	LOAD : in  STD_LOGIC_VECTOR (63 downto 0):= (others => '0');
    OUTPUT : out  STD_LOGIC_VECTOR (63 downto 0):= (others => '0')
    );
end IF_ID_StateRegister ;

architecture Behavioural of IF_ID_StateRegister is
begin
  process(CLK)
  begin
    if rising_edge(CLK) then 
      if (not IF_Flush) = '1' and IF_ID_Write = '1' then
        OUTPUT <= LOAD;
      elsif IF_Flush = '1' then
        OUTPUT <= (others => '0');
      end if;
    end if;
  end process;
end Behavioural;
