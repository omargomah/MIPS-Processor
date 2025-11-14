library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
entity data_mem is
    port (
        clk : in  std_logic;
        we  : in std_logic;
	re  : in std_logic;                                      
        
        addr     : in std_logic_vector(31 downto 0);                   
        data_in  : in std_logic_vector(31 downto 0);                   
        data_out : out std_logic_vector(31 downto 0)
    );
end entity data_mem;

architecture rtl of data_mem is 
    type t_ram is array (0 to 255) of std_logic_vector(7 downto 0); 
    signal mem_array : t_ram := (others => x"00");
    signal addr_int : integer range 0 to 255;
    
begin  
    addr_int <= to_integer(unsigned(addr));
	-- Big - Endian
    process (clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                mem_array(addr_int) <= data_in(31 downto 24);
		mem_array(addr_int+1) <= data_in(23 downto 16); 
		mem_array(addr_int+2) <= data_in(15 downto 8);
		mem_array(addr_int+3) <= data_in(7 downto 0);  
            end if;
	    if re = '1' then
                data_out(31 downto 24) <= mem_array(addr_int);
		data_out(23 downto 16) <= mem_array(addr_int+1);
		data_out(15 downto 8) <= mem_array(addr_int+2);
		data_out(7 downto 0) <= mem_array(addr_int+3);
            end if;
        end if;
    end process;
end architecture rtl;