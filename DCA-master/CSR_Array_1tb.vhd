----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2017 09:14:32 AM
-- Design Name: 
-- Module Name: Test_DataVoter_tb - Behavioral
-- Project Name: 
-- Target Devices: 
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
--use IEEE.std_logic_textio.all;

entity CSR_Array_1tb is 
    --port();
end entity;

architecture Test_This of CSR_Array_1tb is
--- Define input & output for the Data voter. The data voter compares the values of the data and outputs the majority of the 3--
component CSR_Array_1 is
       Port (Clock       : in std_logic;
      Data_Addr   : in std_logic_vector(4 downto 0);
      Index_Addr  : in std_logic_vector(4 downto 0);
      Ptr_Addr    : in std_logic_vector(2 downto 0);
      Read_Data_1   : out std_logic_vector(7 downto 0);
      Read_Index_1  : out std_logic_vector(7 downto 0);
      Read_Ptr_1    : out std_logic_vector(7 downto 0));
end component;
signal Data_Addr_1, Index_Addr_1                 : std_logic_vector(4 downto 0);--:= "00000000";
signal Ptr_Addr_1                              : std_logic_vector (2 downto 0);
signal Read_Data_1, Read_Index_1, Read_Ptr_1 : std_logic_Vector (7 downto 0); 
signal CLK                                   : std_logic :='0'; --time := 10ns;

--constant CLK: time  := 10 ns
begin
UUT: CSR_Array_1 port map(Clock           => CLK,
                          Data_Addr       => Data_Addr_1,
                          Index_Addr      => Index_Addr_1,
                          Ptr_Addr        => Ptr_Addr_1,
                          Read_Data_1     => Read_Data_1,
                          Read_Index_1    => Read_Index_1,
                          Read_Ptr_1      => Read_Ptr_1);

process
    begin
        CLK <= '1';
        wait for 5ns;
        CLK <='0';
        wait for 5ns;
end process;

process
    begin
        wait for 1ns;
        Data_Addr_1  <= "00000";
        Index_Addr_1 <= "00000";
        Ptr_Addr_1   <= "000";  
      wait for 10ns;
        Data_Addr_1  <= "00001";
        Index_Addr_1 <= "00001";
        Ptr_Addr_1   <= "001";  
     wait for 10ns;  
        Data_Addr_1  <= "00010";
        Index_Addr_1 <= "00010";
        Ptr_Addr_1   <= "010";  
     wait for 10ns; 
        Data_Addr_1  <= "00011";
        Index_Addr_1 <= "00011";
        Ptr_Addr_1   <= "011";  
     wait for 10ns; 
        Data_Addr_1  <= "00100";
        Index_Addr_1 <= "00100";
        Ptr_Addr_1   <= "100";  
   wait for 10ns;
        Data_Addr_1  <= "00101";
        Index_Addr_1 <= "00101";
        Ptr_Addr_1   <= "101";  
  wait for 10ns;  
        Data_Addr_1  <= "00110";
        Index_Addr_1 <= "00110";
        Ptr_Addr_1   <= "110"; 
  wait for 10ns;  
        Data_Addr_1  <= "00111";
        Index_Addr_1 <= "00111";
        Ptr_Addr_1   <= "111"; 
  wait for 10ns;  
        Data_Addr_1  <= "01000";
        Index_Addr_1 <= "01000";
        Ptr_Addr_1   <= "111"; 
  wait for 10ns;  
        Data_Addr_1  <= "01001";
        Index_Addr_1 <= "01001";
        Ptr_Addr_1   <= "111"; 
  wait for 10ns;  
        Data_Addr_1  <= "01010";
        Index_Addr_1 <= "01010";
        Ptr_Addr_1   <= "111"; 
  wait for 10ns;  
        Data_Addr_1  <= "01011";
        Index_Addr_1 <= "01011";
        Ptr_Addr_1   <= "111"; 
  wait for 10ns;  
        Data_Addr_1  <= "01100";
        Index_Addr_1 <= "01100";
        Ptr_Addr_1   <= "111"; 
  wait for 10ns;  
        Data_Addr_1  <= "01101";
        Index_Addr_1 <= "01101";
        Ptr_Addr_1   <= "111"; 
  wait for 10ns;  
        Data_Addr_1  <= "01110";
        Index_Addr_1 <= "01110";
        Ptr_Addr_1   <= "111"; 

  wait for 10ns;  
        Data_Addr_1  <= "01111";
        Index_Addr_1 <= "01111";
        Ptr_Addr_1   <= "111"; 
  wait for 10ns;  
        Data_Addr_1  <= "10000";
        Index_Addr_1 <= "10000";
        Ptr_Addr_1   <= "111"; 
  wait for 10ns;  
         Data_Addr_1  <= "10001";
         Index_Addr_1 <= "10001";
         Ptr_Addr_1   <= "111"; 
        
   wait;  
end process;
end Test_This;