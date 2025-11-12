library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity reg_file is
    port (
        clk : in  std_logic;
        we  : in std_logic; --wrtie enable                                     
        
        read1_addr     : in std_logic_vector(5 downto 0);
	read2_addr     : in std_logic_vector(5 downto 0);
	write_addr     : in std_logic_vector(5 downto 0);
        data_in    : in  std_logic_vector(32 downto 0);
        data_out_1 : out std_logic_vector(32 downto 0);
	data_out_2 : out std_logic_vector(32 downto 0)
    );
end entity reg_file;

architecture rtl of reg_file is 
   	type register_array is array (0 to 32) of std_logic_vector(32 downto 0); 
   	signal mem_array : register_array := (others =>(others => '0'));
   	signal read1_addr_int : integer range 0 to 31;
	signal read2_addr_int : integer range 0 to 31;
	signal write_addr_int : integer range 0 to 31;
    
begin  
    	read1_addr_int <= to_integer(unsigned(read1_addr));
	read2_addr_int <= to_integer(unsigned(read2_addr));
	write_addr_int <= to_integer(unsigned(write_addr));
    process (clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                mem_array(write_addr_int) <= data_in; 
            end if;
	    data_out_1 <= mem_array(read1_addr_int);
	    data_out_2 <= mem_array(read2_addr_int);
        end if;
    end process;
end architecture rtl;