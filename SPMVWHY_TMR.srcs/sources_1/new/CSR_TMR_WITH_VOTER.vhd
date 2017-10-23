--====================================================================================================================
--          / - - - - - - - -                - - - - - - - - -          | |- - - - - - - - -\
--        / /- - - - - - - -\ \           / - - - - - - -  - -\         | |- - - - - - - - \ \
--        | |                \ \         / /                            | |                | |
--        | |                            | |                            | |                | |    
--        | |                            | |                            | |                | |  
--        | |                            \ \                            | |                | |         \
--        | |                             \ \_ _ _ _ _ _ _ _ _          | |- - - - - - - -/ /  --------| \  
--        | |                              \ _ _ _ _ _ _ _ _  \         | | - - - - - - -\ \   --------|  /
--        | |                                                \ \        | |               \ \           /             
--        | |                                                 | |       | |               | |   
--        | |                                                 | |       | |               | |
--         \ \                                                | |       | |               | |
--          \ \_ _ _ _ _ _ _ _/ /            _ _ _ _ _ _ _ __ / /       | |               | |
--           \ _ _ _ _ _ _ _ _ /             _ _ _ _ _ _ _ _  /         | |               | |
-- =========================================================================================================================
-- Engineer: Collins Dawson, Sr.
-- University of Pittsburgh, Pittsburgh, PA
--  SHREC LAB, working under Dr. Alan D. Geroge
-- Create Date: 10/20/2017 01:41:12 AM
-- Design Name: SPMV TMR
-- Module Name: CSR_and_Voters - Behavioral
--==========================================================================================================================
-- The project is meant for dependable computing project. It implements a Tripple Modular Redundancy (TMR) algorithm for 
-- the Sparse Matrix -Vector Multplication. The TMR, replicates the memory array that carries the CSR values. The CSR values are
-- non-zeros (data) values from the sparse matrix (matrix shown below), the index column (lebeled index inthis code) of each non-zero 
-- value from the matrix, and the potiner to the non-zero values. The pointer is calculated based on the CSR format. 
-- Thus, let Ptr =  pointer, then 
--                Ptr = Ptr[i-1] + # of row for that non-zero value. 
-- Example:
-- For a Sparse Matrix
--                       - - - - -     - - - - - -                 
--                      | |- - - -     - - - - -  |    
--                      | | 1 2 0 0 0 10 0 0    | |     
--                      | | 0 0 1 0 0 1 2 0     | |
--                      | | 0 2 0 0 5 0 0 10    | |
--             A =      | | 0 0 6 0 1 0 0 11    | |
--                      | | 0 0 0 8 0 7 0 22    | |
--                      | | 0 2 0 0 5 0 0 1     | |
--                      | | _ _ _ _    _ _ _ _ _| | 
--                      |_ _ _ _ _     _ _ _ _ _ _|
--
--  Data  = [1 2 10 1 1 2 2 5 10 6 1 11 8 7 22 2 5 1]
--  Index = [0 1 5  2 5 6 1 4  7 2 4  7 3 5  7 1 4 7]    
--  Ptr   = [0 3 6  9 12 15 18] 
--==============================================================================================
-- Target Devices: Multiple devices
-- Tool Versions: This implementation was developed using the Vivado 2017.2 tool
-- Dependencies: CSR_Array_1, CSR_Array_2, CSR_Array_3, Data_Voter, Index_Voter, & Ptr_Voter 
-- 
---=============================================================================================
-- Start declaring all applicable libariries-------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;
--========== End of Library declaration=======================================================

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CSR_and_Voters is
  Port (Clock         : in std_logic;
        CLK           : in std_logic;
        TMR_Dat_Addr  : in std_logic_vector(4 downto 0);
        TMR_Ind_Addr  : in std_logic_vector(4 downto 0);
        TMR_Ptr_Addr  : in std_logic_vector(2 downto 0);  
        TMR_Value_Out : out std_logic_vector(7 downto 0);
        TMR_Index_Out : out std_logic_vector(7 downto 0);
        TMR_Ptr_Out   : out std_logic_vector(7 downto 0));
end CSR_and_Voters;

architecture Behavioral of CSR_and_Voters is
signal Dat_Mem_Vot_1, Dat_Mem_Vot_2, Dat_Mem_Vot_3   : std_logic_vector(7 downto 0);
signal Ind_Mem_Vot_1, Ind_Mem_Vot_2, Ind_Mem_Vot_3   : std_logic_vector(7 downto 0);
signal Ptr_Mem_Vot_1, Ptr_Mem_Vot_2, Ptr_Mem_Vot_3   : std_logic_vector(7 downto 0);
signal Dat_Vot_Out, Ind_Vot_Out, Ptr_Vot_Out         : std_logic_vector(7 downto 0);
signal CLock_Delay                                   : std_logic;                                   
--======================== Start Component Declaration ==========================================================================
----------------------------------------- Start Data Voter Component -----------------------------------------------------------------------
component Data_Voter is
    port (clock              : in std_logic;
--- Define input & output for the Data voter. The data voter compares the values of the data and outputs the majority of the 3--
               Data_Voter_IN_1    : in std_logic_vector(7 downto 0);
               Data_Voter_IN_2    : in std_logic_vector(7 downto 0);
               Data_Voter_IN_3    : in std_logic_vector(7 downto 0);
               Data_Voter_Out     : out std_logic_vector(7 downto 0));
end component;
----------------------------------------- Start Index Voter Component -----------------------------------------------------------------------
component Index_Voter is
 Port (clok             : in std_logic;
      Index_Voter_IN_1   : in std_logic_vector(7 downto 0);
      Index_Voter_IN_2   : in std_logic_vector(7 downto 0);
      Index_Voter_IN_3   : in std_logic_vector(7 downto 0);
      Index_Voter_Out    : out std_logic_vector(7 downto 0));
end component;
----------------------------------------- Start Pointer Voter Component ----------------------------------------------------------------------
component Ptr_Voter is
          Port (clock              : std_logic;          
                Ptr_Voter_IN_1     : in std_logic_vector(7 downto 0);
                Ptr_Voter_IN_2     : in std_logic_vector(7 downto 0);
                Ptr_Voter_IN_3     : in std_logic_vector(7 downto 0);
                Ptr_Voter_Out      : out std_logic_vector(7 downto 0));
end component;
------------------------------Start CSR_Array_3 Component-------------------------------------------------------------------------------------
component CSR_Array_1 is
      Port (Clock         : in std_logic;
            Data_Addr     : in std_logic_vector(4 downto 0);
            Index_Addr    : in std_logic_vector(4 downto 0);
            Ptr_Addr      : in std_logic_vector(2 downto 0);
            Read_Data_1   : out std_logic_vector(7 downto 0);
            Read_Index_1  : out std_logic_vector(7 downto 0);
            Read_Ptr_1    : out std_logic_vector(7 downto 0));
end component; 
------------------------------Start CSR_Array_3 Component-----------------------------------------------------------------------------------
component CSR_Array_2 is
      Port (Clock         : in std_logic;
            Data_Addr     : in std_logic_vector(4 downto 0);
            Index_Addr    : in std_logic_vector(4 downto 0);
            Ptr_Addr      : in std_logic_vector(2 downto 0);
            Read_Data_2   : out std_logic_vector(7 downto 0);
            Read_Index_2  : out std_logic_vector(7 downto 0);
            Read_Ptr_2    : out std_logic_vector(7 downto 0));
end component;
---------------------------------Start CSR_Array_3 Component------------------------------------------------------------------------            
component CSR_Array_3 is
      Port (Clock         : in std_logic;
            Data_Addr     : in std_logic_vector(4 downto 0);
            Index_Addr    : in std_logic_vector(4 downto 0);
            Ptr_Addr      : in std_logic_vector(2 downto 0);
            Read_Data_3   : out std_logic_vector(7 downto 0);
            Read_Index_3  : out std_logic_vector(7 downto 0);
            Read_Ptr_3    : out std_logic_vector(7 downto 0));
end component;
--========================= End of Components declaration ===========================================================================
begin
--================================== Component Instantiation =======================================================================
--------------------------- CSR_Array_1 Component Instantiattion -------------------------------------------------------------------
CSR_FORMAT_1:  CSR_Array_1 port map (Clock        => clock,
                                     Data_Addr    => TMR_Dat_Addr,
                                     Index_Addr   => TMR_Ind_Addr,
                                     Ptr_Addr     => TMR_Ptr_Addr,
                                     Read_Data_1  => Dat_Mem_Vot_1,
                                     Read_Index_1 => Ind_Mem_Vot_1,
                                     Read_Ptr_1   => Ptr_Mem_Vot_1);
--------------------------- CSR_Array_2 Component Instantiattion -------------------------------------------------------------------
CSR_FORMAT_2:  CSR_Array_2 port map (Clock        => clock,
                                     Data_Addr    => TMR_Dat_Addr,
                                     Index_Addr   => TMR_Ind_Addr,
                                     Ptr_Addr     => TMR_Ptr_Addr,
                                     Read_Data_2  => Dat_Mem_Vot_2,
                                     Read_Index_2 => Ind_Mem_Vot_2,
                                     Read_Ptr_2   => Ptr_Mem_Vot_2);
--------------------------- CSR_Array_3 Component Instantiattion -------------------------------------------------------------------         
CSR_FORMAT_3:  CSR_Array_3 port map (Clock        => clock,
                                     Data_Addr    => TMR_Dat_Addr,
                                     Index_Addr   => TMR_Ind_Addr,
                                     Ptr_Addr     => TMR_Ptr_Addr,
                                     Read_Data_3  => Dat_Mem_Vot_3,
                                     Read_Index_3 => Ind_Mem_Vot_3,
                                     Read_Ptr_3   => Ptr_Mem_Vot_3);
--------------------------- End CSR_Array Components Instantiattion ------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------                                     
--========= Since the outputs of the CSR_Array goes to the voter to vote for the majority output, 
--========= the clock needs to be delay a clock cycle to prevent incorrect output fetch by the voters.
--========= To delay the clock, the clock is take as input and outputed into the voter as the clock, using a process
--------------------------------------------------------------------------------------------------------------------------------------
--process(Clock)
  --  begin
    --    if rising_edge (Clock) then
      --      Clock_Delay <= Clock;
        --end if;
--end process;        
--------------------------------------------------------------------------------------------------------------------------------------
------------------------ After delaying the clock input for 1- cycle, it is use as the input to the voters --------------------------- 
--============================ Instantiating the Voters===============================================================================
----------------------------- Start instantiating the Data voter --------------------------------------------------------------------        
DAT_VOTER: Data_Voter port map (clock              => CLK,
                                Data_Voter_IN_1    => Dat_Mem_Vot_1,
                                Data_Voter_IN_2    => Dat_Mem_Vot_2,
                                Data_Voter_IN_3    => Dat_Mem_Vot_3,
                                Data_Voter_Out     => Dat_Vot_Out);
----------------------------- Start instantiating the Index voter --------------------------------------------------------------------
IND_VOTER: Index_Voter port map (clok              => CLK,
                                 Index_Voter_IN_1   => Ind_Mem_Vot_1,
                                 Index_Voter_IN_2   => Ind_Mem_Vot_2,
                                 Index_Voter_IN_3   => Ind_Mem_Vot_3,
                                 Index_Voter_Out    => Ind_Vot_Out);
-----------------------------Start instantiating the Pointer voter --------------------------------------------------------------------
PTRS_VOTER: Ptr_Voter port map (clock             => CLK,
                                Ptr_Voter_IN_1    => Ptr_Mem_Vot_1,
                                Ptr_Voter_IN_2    => Ptr_Mem_Vot_2,
                                Ptr_Voter_IN_3    => Ptr_Mem_Vot_3,
                                Ptr_Voter_Out     => Ptr_Vot_Out);
----===============================End of voter instantiation ========================================================================
--================ Start mapping thte output of the voters to the actual TMR outputs==================================================
TMR_Value_Out <= Dat_Vot_Out; -- Map Data Voter as the Non-zero output of the TMR with Voter
TMR_Index_Out <= Ind_Vot_Out; -- Map Index Voter as the Non-zero output of the TMR with Voter
TMR_Ptr_Out <= Ptr_Vot_Out;   -- Map Pointer Voter as the Non-zero output of the TMR with Voter
--======================== End of output mapping. ====================================================================================                              
end Behavioral;
