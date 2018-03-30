----------------------------------------------------------------------------------
-- Author: Collins Dawson
-- Design Name: Sparse Matrix Memory
-- Module Name: Sparse_Matrix_Mem - Behavioral
-- Project Name: SPMV in RTL for Tripple Modular Redundancy (TMR) module in Dependable Computing
-- Target Devices: Xilinx Zynq
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_textio.all;
--use IEEE.std_logic_arith.all;
--use IEEE.numeric_bit.all;
--use IEEE.numeric_std.all;
--use IEEE.std_logic_signed.all;
--use IEEE.std_logic_unsigned.all;
--use IEEE.math_real.all;
--use IEEE.math_complex.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
--==========================This is the entity declaration=======================================
entity CSR_Array_1 is
      Port (Clock       : in std_logic;
            Data_Addr   : in std_logic_vector(4 downto 0);
            Index_Addr  : in std_logic_vector(4 downto 0);
            Ptr_Addr    : in std_logic_vector(2 downto 0);
            Read_Data_1   : out std_logic_vector(7 downto 0);
            Read_Index_1  : out std_logic_vector(7 downto 0);
            Read_Ptr_1    : out std_logic_vector(7 downto 0)
            );
end CSR_Array_1;
--======================= End of Entity Declaration ============================================
architecture Behavioral of CSR_Array_1 is
    -- This section of the code defines the memory types for the CSR arrays------------
    type CSR_Data_mem_array is array(17 downto 0 )of std_logic_vector(7 downto 0); -- Define the non-zero values for CSR array
    type CSR_Index_mem_array is array(17 downto 0 )of std_logic_vector(7 downto 0);-- Define the index for the CSR array
    type CSR_Ptr_mem_array is array(6 downto 0)of std_logic_vector(7 downto 0);-- Define the pointer for the CSR array
    ------------ This section initializes each memory array with the actual calculated CSR values.
    ------------ The calculation is perform in the spreadsheet, attached to the project files. ---------
    signal Data_RAM : CSR_Data_mem_array :=(  -- This is the non-zero values from the sparse matrix that will be in the CSR array
                    "00000001",
                    "00000101",
                    "00000010",
                    "00010110",
                    "00000111",
                    "00001000",
                    "00001011",
                    "00000001",
                    "00000110",
                    "00001010",
                    "00000101",
                    "00000010",
                    "00000010",
                    "00000001",
                    "00000001",
                    "00001010",
                    "00000010",
                    "00000001");
                   
    signal Index_RAM : CSR_Index_mem_array :=( ---- This is the index column of the non-zero values from the sparse matrix that will be in the CSR array
                     "00000111",
                     "00000100",
                     "00000001",
                     "00000111",
                     "00000101",
                     "00000011",
                     "00000111",
                     "00000100",
                     "00000010",
                     "00000111",
                     "00000100",
                     "00000001",
                     "00000110",
                     "00000101",
                     "00000010",
                     "00000101",
                     "00000001",
                     "00000000"); 
                     
    signal Ptr_RAM : CSR_Ptr_mem_array :=(
                    "00010010",
                    "00001111",
                    "00001100",
                    "00001001",
                    "00000110",
                    "00000011",
                    "00000000");    
begin
    CSR_PROCESS: process(Clock, Data_Addr, Index_Addr, Ptr_Addr)
    begin
         if rising_edge(Clock) then
           Read_Data_1 <= Data_RAM(to_integer(unsigned(Data_Addr)));
           Read_Index_1 <= Index_RAM(to_integer(unsigned(Index_Addr)));
           Read_Ptr_1 <= Ptr_RAM(to_integer(unsigned(Ptr_Addr)));
         end if;
  end process;
end Behavioral;