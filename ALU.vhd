library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is 
port ( 

alu_control: in std_logic_vector (3 downto 0);
opr1 : in std_logic_vector (31 downto 0);
opr2 : in std_logic_vector (31 downto 0);
result: out std_logic_vector (31 downto 0) ;
zero_flag: out std_logic
);
end ALU;

architecture behavioral of ALU is 
signal CheckZeroFlag :std_logic_vector (31 downto 0) ;
begin
process(alu_control,opr1,opr2)
begin
	if alu_control="0010" then result<= opr1 + opr2 ;
	elsif alu_control="0110" then 
	CheckZeroFlag<= opr1 - opr2;  
result<=CheckZeroFlag;
	if CheckZeroFlag = "00000000000000000000000000000000" then zero_flag<= '1' ;
	else zero_flag<= '0';
	end if;
	elsif  alu_control="0000" then result<= opr1 and opr2 ;
	elsif alu_control="0001" then result<= opr1 or opr2 ;
	elsif alu_control="0111" then if opr1<opr2 then result <="00000000000000000000000000000001";
	else result <="00000000000000000000000000000000";
			end if ;
	
end if ;
end process;
end behavioral;

	
