library ieee;
use ieee.std_logic_1164.all;
entity Mux_5 is
    port (
       A_5: in  std_logic_vector(4 downto 0);
       B_5: in  std_logic_vector(4 downto 0);
       Sel_5: in  std_logic;
       Y_5: out std_logic_vector(4 downto 0));
end  Mux_5 ;
architecture behavier of Mux_5  is
begin
    Y_5<= B_5 when Sel_5 = '1' else A_5;
end behavier;
