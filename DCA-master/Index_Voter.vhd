----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2017 12:55:33 AM
-- Design Name: 
-- Module Name: Index_Voter - Behavioral
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
----------------------------------------------------------------------------------
 --- Define input & output for the Index voter. The index voter compares the indices of the Index values and outputs the majority of the 3--
entity Index_Voter is
 Port (clok               : in std_logic;
       Index_Voter_IN_1   : in std_logic_vector(7 downto 0);
       Index_Voter_IN_2   : in std_logic_vector(7 downto 0);
       Index_Voter_IN_3   : in std_logic_vector(7 downto 0);
       Index_Voter_Out    : out std_logic_vector(7 downto 0));
end Index_Voter;

architecture Behavioral of Index_Voter is
signal In2Eq1, In2Eq3, In1Eq3, Inall, InnotAll  : std_logic;
signal FlagIndex                                : std_logic_vector(7 downto 0);
begin

 --========== Creating the Index voter =====================================----
  INDEX_VOTER:process(clok)
     begin
      if rising_edge(clok)then
          if (Index_Voter_IN_1 = Index_Voter_IN_2) then
              In2Eq1 <= '1';
              --FlagIndex <= Index_Voter_IN_1;
              FlagIndex <= Index_Voter_IN_2;
          elsif (Index_Voter_IN_3 = Index_Voter_IN_1) then
              In1Eq3 <= '1';
              FlagIndex <= Index_Voter_IN_1;
              --FlagIndex <= Index_Voter_IN_3;
          elsif (Index_Voter_IN_2 = Index_Voter_IN_3) then
              In2Eq3 <= '1';
              --FlagIndex <= Index_Voter_IN_2;
              FlagIndex <= Index_Voter_IN_3;
          elsif ((Index_Voter_IN_1 = Index_Voter_IN_2) and (Index_Voter_IN_1 = Index_Voter_IN_3)) then
              Inall <= '1';
              FlagIndex <= Index_Voter_IN_1;
          elsif ((Index_Voter_IN_1 /= Index_Voter_IN_2) and (Index_Voter_IN_1 = Index_Voter_IN_3)) then
              In1Eq3 <= '1';
              FlagIndex <= Index_Voter_IN_3;
          elsif ((Index_Voter_IN_1 /= Index_Voter_IN_2) and (Index_Voter_IN_2 = Index_Voter_IN_3)) then
              In2Eq3 <= '1';
              FlagIndex <= Index_Voter_IN_3;
           elsif ((Index_Voter_IN_1 = Index_Voter_IN_2) and (Index_Voter_IN_1 /= Index_Voter_IN_3)) then
              In2Eq1 <= '1';
              FlagIndex <= Index_Voter_IN_1;
           elsif ((Index_Voter_IN_1 /= Index_Voter_IN_2) and (Index_Voter_IN_1 /= Index_Voter_IN_3)) then
              InnotAll <='1';
              FlagIndex <= "ZZZZZZZZ";
           elsif ((Index_Voter_IN_1 /= Index_Voter_IN_2) or (Index_Voter_IN_2 /= Index_Voter_IN_3) or (Index_Voter_IN_1 /= Index_Voter_IN_3))then
              InnotAll <='1';
              FlagIndex <="ZZZZZZZZ";
           else
              In2Eq1 <='0';
              In2Eq3 <='0';
              In1Eq3 <='0';
              Inall <='0';
              InnotAll <='0';
              FlagIndex <= "ZZZZZZZZ";
          end if;
          Index_Voter_Out <= FlagIndex;
     end if;  
   end process;
end Behavioral;