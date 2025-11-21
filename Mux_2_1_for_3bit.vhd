
library ieee;
use ieee.std_logic_1164.all;
entity Mux_2_1_3bits is
    port (
       A: in  std_logic_vector(2 downto 0);
       B: in  std_logic_vector(2 downto 0):= (others => '0');
       Sel: in  std_logic;
       Y: out std_logic_vector(2 downto 0));
end  Mux_2_1_3bits ;
architecture behavier of Mux_2_1_3bits is
begin
    Y<= B when Sel = '1' else A;
end behavier;
