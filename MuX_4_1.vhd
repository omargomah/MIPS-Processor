library ieee;
use ieee.std_logic_1164.all;
entity Mux_4_1 is
    port (
       A: in  std_logic_vector(31 downto 0);
       B: in  std_logic_vector(31 downto 0);
       C: in  std_logic_vector(31 downto 0);
       D: in  std_logic_vector(31 downto 0);
       Sel: in std_logic_vector(1 downto 0);
       Y: out std_logic_vector(31 downto 0));
end  Mux_4_1 ;
architecture behavier of Mux_4_1  is
begin
Y <= A when Sel = "00" else
         B when Sel = "01" else
         C when Sel = "10" else
         D;
end behavier;
