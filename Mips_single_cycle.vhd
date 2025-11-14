library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Mips_single_cycle is
port (
	CLK: in std_logic
);
end  Mips_single_cycle;
architecture behavier of Mips_single_cycle  is
Component SIGN_EXTEND is
    Port ( INPUT : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;
Component SHIFT is
    Port ( INPUT : in  STD_LOGIC_VECTOR (31 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;
Component Jump_Shift is
    Port ( INPUT : in  STD_LOGIC_VECTOR (25 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (27 downto 0));
end Component;

Component reg_file is
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
end Component;
Component instruction_momery is 
port(
clk: in std_logic;
address:in std_logic_vector(31 downto 0); 
word_out:out std_logic_vector(31 downto 0)
);
end Component;
Component data_mem is
    port (
        clk : in  std_logic;
        we  : in std_logic;
	re  : in std_logic;                                      
        
        addr     : in std_logic_vector(31 downto 0);                   
        data_in  : in std_logic_vector(31 downto 0);                   
        data_out : out std_logic_vector(31 downto 0)
    );
end Component;
Component Control_Unit is 
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
end Component;
Component ALU_Control_unit is 
port ( 

alu_op: in std_logic_vector (1 downto 0);
funct : in std_logic_vector (5 downto 0);
alu_control: out std_logic_vector (3 downto 0) 
);
end Component;
Component ALU is 
port ( 

alu_control: in std_logic_vector (3 downto 0);
opr1 : in std_logic_vector (31 downto 0);
opr2 : in std_logic_vector (31 downto 0);
result: inout std_logic_vector (31 downto 0) ;
zero_flag: out std_logic
);
end Component;
Component Adder is
    port (  
        A: in  std_logic_vector(31 downto 0);
        B: in  std_logic_vector(31 downto 0);
       Sum: out std_logic_vector(31 downto 0));
end Component;
Component PC is
    Port ( 
	CLK: in  STD_LOGIC;
	LOAD : in  STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
           PC_OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0):=x"00000000");
end Component;
Component Mux is
    port (
       A: in  std_logic_vector(31 downto 0);
       B: in  std_logic_vector(31 downto 0);
       Sel: in  std_logic;
       Y: out std_logic_vector(31 downto 0));
end  Component ;
Component Mux_5 is
    port (
       A_5: in  std_logic_vector(4 downto 0);
       B_5: in  std_logic_vector(4 downto 0);
       Sel_5: in  std_logic;
       Y_5: out std_logic_vector(4 downto 0));
end  Component ;
signal Jump_Address,pc_out,ReadData1,ReadData2,SignExtendOut,MuxAluSrcOut,AluResult,DataMemOut,MuxMemToRegOut,NextInsAdderOut,BranchShiftOut,BranchAdderOut,MuxBranchOut,MuxJumpOut: std_logic_vector(31 downto 0);
signal ins_out: std_logic_vector(31 downto 0);
signal Branch_flag,ZeroFlag,Regdst,Jump ,Branch,Memread,Memtoreg,Memwrite,Alusrc,Regwrite:std_logic;
signal Alu_op:std_logic_vector (1 downto 0) ;
signal Mux_Regdst_out :std_logic_vector (4 downto 0) ;
signal AluControlOut :std_logic_vector (3 downto 0) ;
signal JumpShiftLeftOut: std_logic_vector (27 downto 0);
begin
pc_x: PC port map(CLK,MuxJumpOut,pc_out);
inst_mem_x: instruction_momery port map(CLK,pc_out,ins_out);
control_unit_x: Control_Unit port map(ins_out(31 downto 26),Regdst,Jump ,Branch,Memread,Memtoreg,Alu_op,Memwrite,Alusrc,Regwrite);
Mux_Regdst_x: Mux_5 port map(ins_out(20 downto 16),ins_out(15 downto 11),Regdst,Mux_Regdst_out);
reg_file_x: reg_file port map(CLK,Regwrite,ins_out(25 downto 21),ins_out(20 downto 16),Mux_Regdst_out,MuxMemToRegOut,ReadData1,ReadData2);
sign_Extend_16_x: SIGN_EXTEND port map(ins_out(15 downto 0),SignExtendOut);
Mux_AluSrc_x: Mux port map(ReadData2,SignExtendOut,Alusrc,MuxAluSrcOut);
Alu_Control_x: ALU_Control_unit port map(Alu_op,ins_out(5 downto 0),AluControlOut);
Alu_x: ALU  port map(AluControlOut,ReadData1,MuxAluSrcOut,AluResult,ZeroFlag);
Data_Mem_x: data_mem port map(CLK,Memwrite,Memread,AluResult,ReadData2,DataMemOut);
Mux_MemToReg_x: Mux port map(AluResult,DataMemOut,Memtoreg,MuxMemToRegOut);
next_ins_adder_x: Adder port map(pc_out,"00000000000000000000000000000100",NextInsAdderOut);
Jump_Shift_Left_x:Jump_Shift port map(ins_out(25 downto 0), JumpShiftLeftOut);
branch_Shift_x: SHIFT port map(SignExtendOut,BranchShiftOut);
Branch_adder_x:Adder port map(pc_out,BranchShiftOut,BranchAdderOut);
Branch_flag<=Branch and ZeroFlag;
Mux_Branch_x: Mux port map(NextInsAdderOut,BranchAdderOut,Branch_flag,MuxBranchOut);
Jump_Address <= NextInsAdderOut(31 downto 28) &JumpShiftLeftOut;
Mux_Jump_x: Mux port map(MuxBranchOut,Jump_Address,Jump,MuxJumpOut);
end behavier;

