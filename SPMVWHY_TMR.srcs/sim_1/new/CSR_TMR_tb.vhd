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

entity CSR_TMR_tb is 
    --port();
end entity;

architecture Test_This of CSR_TMR_tb is
--- Define input & output for the Data voter. The data voter compares the values of the data and outputs the majority of the 3--
component CSR_and_Voters is
  Port (Clock         : in std_logic;
        CLK           : in std_logic;
        TMR_Dat_Addr  : in std_logic_vector(4 downto 0);
        TMR_Ind_Addr  : in std_logic_vector(4 downto 0);
        TMR_Ptr_Addr  : in std_logic_vector(2 downto 0);  
        TMR_Value_Out : out std_logic_vector(7 downto 0);
        TMR_Index_Out : out std_logic_vector(7 downto 0);
        TMR_Ptr_Out   : out std_logic_vector(7 downto 0));
end component;
------===================================================================================
signal TMR_Data_Addr, TMR_Index_Addr   : std_logic_vector(4 downto 0);--:= "00000000";
signal TMR_Ptr_Addr                  : std_logic_vector (2 downto 0);
signal TMR_Value, TMR_Index, TMR_Ptr : std_logic_Vector (7 downto 0); 
signal CLK,CKL                           : std_logic; --time := 10ns;
--======================================================================================
begin
--========== Start instantiating the unit under test (UUT)-=============================
UUT: CSR_and_Voters port map(Clock           => CLK,
                             CLK             => CKL,
                             TMR_Dat_Addr    => TMR_Data_Addr, 
                             TMR_Ind_Addr    => TMR_Index_Addr,  
                             TMR_Ptr_Addr    => TMR_Ptr_Addr,  
                             TMR_Value_Out   => TMR_Value,
                             TMR_Index_Out   => TMR_Index,
                             TMR_Ptr_Out     => TMR_Ptr); 
--================ UUT Instantiation completed =================================================================
---======================== Begin generating the clock via a process call=======================================
process
    begin
        CLK <= '1';
        wait for 5ns;
        CLK <='0';
        wait for 5ns;
end process;

process
    begin
        wait for 5ns;       
        CKL <= '1';
        wait for 5ns;
        CKL <='0';
        wait for 5ns;
end process;

--================================Complete CLOCK generation =====================================================
--============== Start input signal assignment for the UUT to generate the required output=======================
process
    begin
        wait for 1ns;
        TMR_Data_Addr  <= "00000";
        TMR_Index_Addr <= "00000";
        TMR_Ptr_Addr   <= "000";  
      wait for 10ns;
        TMR_Data_Addr  <= "00001";
        TMR_Index_Addr <= "00001";
        TMR_Ptr_Addr   <= "001";  
     wait for 10ns;  
        TMR_Data_Addr  <= "00010";
        TMR_Index_Addr <= "00010";
        TMR_Ptr_Addr   <= "010";  
     wait for 10ns; 
        TMR_Data_Addr  <= "00011";
        TMR_Index_Addr <= "00011";
        TMR_Ptr_Addr   <= "011";  
     wait for 10ns; 
        TMR_Data_Addr  <= "00100";
        TMR_Index_Addr <= "00100";
        TMR_Ptr_Addr   <= "100";  
   wait for 10ns;
        TMR_Data_Addr  <= "00101";
        TMR_Index_Addr <= "00101";
        TMR_Ptr_Addr   <= "101";  
  wait for 10ns;  
        TMR_Data_Addr  <= "00110";
        TMR_Index_Addr <= "00110";
        TMR_Ptr_Addr   <= "110"; 
  wait for 10ns;  
        TMR_Data_Addr  <= "00111";
        TMR_Index_Addr <= "00111";
        TMR_Ptr_Addr   <= "111"; 
  wait for 10ns;  
        TMR_Data_Addr  <= "01000";
        TMR_Index_Addr <= "01000";
        TMR_Ptr_Addr   <= "111"; 
  wait for 10ns;  
        TMR_Data_Addr  <= "01001";
        TMR_Index_Addr <= "01001";
        TMR_Ptr_Addr   <= "111"; 
  wait for 10ns;  
        TMR_Data_Addr  <= "01010";
        TMR_Index_Addr <= "01010";
        TMR_Ptr_Addr   <= "111"; 
  wait for 10ns;  
        TMR_Data_Addr  <= "01011";
        TMR_Index_Addr <= "01011";
        TMR_Ptr_Addr   <= "111"; 
  wait for 10ns;  
        TMR_Data_Addr  <= "01100";
        TMR_Index_Addr <= "01100";
        TMR_Ptr_Addr   <= "111"; 
  wait for 10ns;  
        TMR_Data_Addr  <= "01101";
        TMR_Index_Addr <= "01101";
        TMR_Ptr_Addr   <= "111"; 
  wait for 10ns;  
        TMR_Data_Addr  <= "01110";
        TMR_Index_Addr <= "01110";
        TMR_Ptr_Addr   <= "111"; 

  wait for 10ns;  
        TMR_Data_Addr  <= "01111";
        TMR_Index_Addr <= "01111";
        TMR_Ptr_Addr   <= "111"; 
  wait for 10ns;  
        TMR_Data_Addr  <= "10000";
        TMR_Index_Addr <= "10000";
        TMR_Ptr_Addr   <= "111"; 
  wait for 10ns;  
         TMR_Data_Addr  <= "10001";
         TMR_Index_Addr <= "10001";
         TMR_Ptr_Addr   <= "111"; 
        
   wait;  
end process;
end Test_This;