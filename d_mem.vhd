library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
entity data_mem is
    port (
        clk : in  std_logic;
        we  : in std_logic;
	re  : in std_logic;                                      
        
        addr     : in std_logic_vector(32 downto 0);                   
        data_in  : in std_logic_vector(32 downto 0);                   
        data_out : out std_logic_vector(32 downto 0)
    );
end entity data_mem;

architecture rtl of data_mem is 
    type t_ram is array (0 to 95) of std_logic_vector(32 downto 0); 
    signal mem_array : t_ram := (others =>(others => '0'));
    signal addr_int : integer range 0 to 95;
    
begin  
    addr_int <= to_integer(unsigned(addr));

    process (clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                mem_array(addr_int) <= data_in; 
            end if;
	    if re = '1' then
                data_out <= mem_array(addr_int);
            end if;
        end if;
    end process;
end architecture rtl;