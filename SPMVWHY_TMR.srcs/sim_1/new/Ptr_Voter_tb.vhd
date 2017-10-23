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

entity Test_PtrVoter_tb is 
    --port();
end entity;

architecture Test_This of Test_PtrVoter_tb is
--- Define input & output for the Data voter. The data voter compares the values of the data and outputs the majority of the 3--
component Ptr_Voter is
 Port (clock    : in std_logic;
       Ptr_Voter_IN_1   : in std_logic_vector(7 downto 0);
       Ptr_Voter_IN_2   : in std_logic_vector(7 downto 0);
       Ptr_Voter_IN_3   : in std_logic_vector(7 downto 0);
       Ptr_Voter_Out    : out std_logic_vector(7 downto 0));
end component;
signal Ptr1, Ptr2, Ptr3,Ptr_OutV   : std_logic_vector(7 downto 0);--:= "00000000";
signal CLK                            : std_logic :='0'; --time := 10ns;

--constant CLK: time  := 10 ns
begin
UUT: Ptr_Voter port map(clock           => CLK,
                         Ptr_Voter_IN_1   => Ptr1,
                         Ptr_Voter_IN_2   => Ptr2,
                         Ptr_Voter_IN_3   => Ptr3,
                         Ptr_Voter_Out  => Ptr_OutV);

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
        Ptr1 <= "00001010";
        Ptr2 <= "00001010";
        Ptr3 <= "00001010";  
      wait for 10ns;
        Ptr1 <= "00011010";
        Ptr2 <= "00001010";
        Ptr3 <= "00011010";
     wait for 10ns;  
        Ptr1 <= "01001010";
        Ptr2 <= "01001010";
        Ptr3 <= "00001110";  
     wait for 10ns; 
        Ptr1 <= "00001010";
        Ptr2 <= "00011100";
        Ptr3 <= "00011100";  
     wait for 10ns; 
        Ptr1 <= "00001010";
        Ptr2 <= "00010100";
        Ptr3 <= "00011010";  
     wait;  
end process;
end Test_This;