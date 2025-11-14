library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity reg_file is
    port (
        clk : in  std_logic;
        we  : in std_logic; --wrtie enable                                     
        
        read1_addr     : in std_logic_vector(4 downto 0);
	read2_addr     : in std_logic_vector(4 downto 0);
	write_addr     : in std_logic_vector(4 downto 0);
        data_in    : in  std_logic_vector(31 downto 0);
        data_out_1 : out std_logic_vector(31 downto 0);
	data_out_2 : out std_logic_vector(31 downto 0)
    );
end entity reg_file;

architecture rtl of reg_file is 
  type register_array is array (0 to 31) of std_logic_vector(31 downto 0);

-- Initialize the memory array with only positive (MSB=0) values
signal mem_array : register_array := (
    -- Register Index => Initial Value (Hex, MSB is always 0) => MIPS Name and Comment
    0   => X"00000000", -- $zero: Constant value 0.
    1   => X"0000000F", -- $at:   Assembler Temporary.
    
    -- Function Return Values
    2   => X"00000002", -- $v0:   Function return value 1.
    3   => X"00000003", -- $v1:   Function return value 2.

    -- Function Arguments
    4   => X"0000000A", -- $a0:   Function argument 1 (Value: 10).
    5   => X"0000000B", -- $a1:   Function argument 2 (Value: 11).
    6   => X"0000000C", -- $a2:   Function argument 3 (Value: 12).
    7   => X"0000000D", -- $a3:   Function argument 4 (Value: 13).
    
    -- Temporaries (Caller-Saved)
    8   => X"00000100", -- $t0:   Temporary (Value: 256).
    9   => X"00000101", -- $t1:   Temporary (Value: 257).
    10  => X"00000102", -- $t2:   Temporary.
    11  => X"00000103", -- $t3:   Temporary.
    12  => X"00000104", -- $t4:   Temporary.
    13  => X"00000105", -- $t5:   Temporary.
    14  => X"00000106", -- $t6:   Temporary.
    15  => X"00000107", -- $t7:   Temporary.
    
    -- Saved Temporaries (Callee-Saved)
    16  => X"00002000", -- $s0:   Saved temporary (Value: 8192).
    17  => X"00002001", -- $s1:   Saved temporary.
    18  => X"00002002", -- $s2:   Saved temporary.
    19  => X"00002003", -- $s3:   Saved temporary.
    20  => X"00002004", -- $s4:   Saved temporary.
    21  => X"00002005", -- $s5:   Saved temporary.
    22  => X"00002006", -- $s6:   Saved temporary.
    23  => X"00002007", -- $s7:   Saved temporary.

    -- More Temporaries (Caller-Saved)
    24  => X"00000018", -- $t8:   Temporary (Value: 24).
    25  => X"00000019", -- $t9:   Temporary (Value: 25).
    
    -- Reserved for OS/Kernel
    26  => X"0000001A", -- $k0:   Kernel reserved 1.
    27  => X"0000001B", -- $k1:   Kernel reserved 2.
    
    -- Special Pointers (All are positive addresses)
    28  => X"10008000", -- $gp:   Global Pointer (retained).
    29  => X"7FFFEE00", -- $sp:   Stack Pointer (retained).
    30  => X"0000001E", -- $fp:   Frame Pointer.
    
    -- Return Address
    31  => X"00400004"  -- $ra:   Return Address (retained).
);
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