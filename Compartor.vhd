library ieee;
use ieee.std_logic_1164.all;

entity Equality_Comparator is
    Port (
        A : in  std_logic_vector(31 downto 0);
        B : in  std_logic_vector(31 downto 0);
        EqualFlag : out std_logic          
    );
end Equality_Comparator;

architecture Behavioral of Equality_Comparator is
begin
    EqualFlag <= '1' when A = B else '0';   
end Behavioral;
