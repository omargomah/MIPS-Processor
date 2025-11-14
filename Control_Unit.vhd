library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Control_Unit is 
port ( 

op_code: in std_logic_vector (5 downto 0);
Regdst: out std_logic;
Jump: out std_logic;
Branch: out std_logic;
Memread: out std_logic;
Memtoreg: out std_logic;
Alu_op: out std_logic_vector (1 downto 0) ;
Memwrite: out std_logic;
Alusrc: out std_logic;
Regwrite: out std_logic
);
end Control_Unit;


architecture behavioral of Control_Unit is 
begin
process(op_code)
begin
	if op_code="000000" then Regdst<='1';Alusrc<='0';Memtoreg<='0';Regwrite<='1';Memread<='0';Memwrite<='0';Branch<='0';Jump<='0';Alu_op<="10";
	elsif op_code="100011" then Regdst<='0';Alusrc<='1';Memtoreg<='1';Regwrite<='1';Memread<='1';Memwrite<='0';Branch<='0';Jump<='0';Alu_op<="00";
	elsif  op_code="101011" then Regdst<='X';Alusrc<='1';Memtoreg<='X';Regwrite<='0';Memread<='0';Memwrite<='1';Branch<='0';Jump<='0';Alu_op<="00";
	elsif op_code="000100" then Regdst<='X';Alusrc<='0';Memtoreg<='X';Regwrite<='X';Memread<='0';Memwrite<='0';Branch<='1';Jump<='0';Alu_op<="01";
	elsif op_code="000010" then Regdst<='X';Alusrc<='X';Memtoreg<='X';Regwrite<='0';Memread<='0';Memwrite<='0';Branch<='0';Jump<='1';Alu_op<="XX";
	
	
end if ;
end process;
end behavioral;