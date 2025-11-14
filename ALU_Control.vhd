library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity ALU_Control_unit is 
port ( 

alu_op: in std_logic_vector (1 downto 0);
funct : in std_logic_vector (5 downto 0);
alu_control: out std_logic_vector (3 downto 0) 
);
end ALU_Control_unit;


architecture behavioral of ALU_Control_unit is 
begin
process(alu_op,funct)
begin
	if alu_op="00" then alu_control<="0010" ;
	elsif alu_op="01" then alu_control<="0110" ;
	elsif  alu_op="10" then if funct="100000" then alu_control<="0010"  ;
				elsif funct="100010" then alu_control<="0110";
				elsif funct="100100" then alu_control<="0000";
				elsif funct="100101" then alu_control<="0001";
				elsif funct="101010" then alu_control<="0111";	
				end if;
end if ;
end process;
end behavioral;