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

entity Test_IndexVoter_tb is 
    --port();
end entity;

architecture Test_This of Test_IndexVoter_tb is
--- Define input & output for the Data voter. The data voter compares the values of the data and outputs the majority of the 3--
component Index_Voter is
 Port (clok    : in std_logic;
       Index_Voter_IN_1   : in std_logic_vector(7 downto 0);
       Index_Voter_IN_2   : in std_logic_vector(7 downto 0);
       Index_Voter_IN_3   : in std_logic_vector(7 downto 0);
       Index_Voter_Out    : out std_logic_vector(7 downto 0));
end component;
signal Index1, Index2, Index3,Index_OutV   : std_logic_vector(7 downto 0);--:= "00000000";
signal CLK                            : std_logic :='0'; --time := 10ns;

--constant CLK: time  := 10 ns
begin
UUT: Index_Voter port map(clok           => CLK,
                         Index_Voter_IN_1   => Index1,
                         Index_Voter_IN_2   => Index2,
                         Index_Voter_IN_3   => Index3,
                         Index_Voter_Out  => Index_OutV);

process
    begin
        CLK <= '0';
        wait for 5ns;
        CLK <='1';
        wait for 5ns;
end process;

process
    begin
       -- wait for 2ns;
        Index1 <= "00001010";
        Index2 <= "00001010";
        Index3 <= "00001010";  
      wait for 10ns;
        Index1 <= "00011010";
        Index2 <= "00001010";
        Index3 <= "00011010";
     wait for 10ns;  
        Index1 <= "01001010";
        Index2 <= "01001010";
        Index3 <= "00001110";  
     wait for 10ns; 
        Index1 <= "00001010";
        Index2 <= "00011100";
        Index3 <= "00011100";  
     wait for 10ns; 
        Index1 <= "00001010";
        Index2 <= "00010100";
        Index3 <= "00011010";  
     wait;  
end process;
end Test_This;