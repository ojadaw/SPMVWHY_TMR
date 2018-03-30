----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2017 05:16:53 PM
-- Design Name: 
-- Module Name: SPMV_Voter - Behavioral
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

entity Data_Voter is
          Port (clock              : in std_logic;
 --- Define input & output for the Data voter. The data voter compares the values of the data and outputs the majority of the 3--
                Data_Voter_IN_1    : in std_logic_vector(7 downto 0);
                Data_Voter_IN_2    : in std_logic_vector(7 downto 0);
                Data_Voter_IN_3    : in std_logic_vector(7 downto 0);
                Data_Voter_Out     : out std_logic_vector(7 downto 0));
end Data_Voter;
----============ End of Entity Declaration ======================--

architecture Behavioral of Data_Voter is
signal D2Eq1, D2Eq3, D1Eq3, Dall, DnotAll  : std_logic;
signal FlagData                            : std_logic_vector(7 downto 0);
begin
--========== Creating the Data voter =====================================----
    DATA_VOTER:process(clock)
   begin
    if rising_edge(clock)then
        if (Data_Voter_IN_1 = Data_Voter_IN_2) then
            D2Eq1 <= '1';
            --FlagData <= Data_Voter_IN_1;
            FlagData <= Data_Voter_IN_1;
        elsif (Data_Voter_IN_1 = Data_Voter_IN_3) then
            D1Eq3 <= '1';
            FlagData <= Data_Voter_IN_3;
            --FlagData <= Data_Voter_IN_3;
        elsif (Data_Voter_IN_2 = Data_Voter_IN_3) then
            D2Eq3 <= '1';
            --FlagData <= Data_Voter_IN_2;
            FlagData <= Data_Voter_IN_2;
        elsif ((Data_Voter_IN_1 = Data_Voter_IN_2) and (Data_Voter_IN_1 = Data_Voter_IN_3)) then
            Dall <= '1';
            FlagData <= Data_Voter_IN_1;
        elsif ((Data_Voter_IN_1 /= Data_Voter_IN_2) and (Data_Voter_IN_1 = Data_Voter_IN_3)) then
            D1Eq3 <= '1';
            FlagData <= Data_Voter_IN_3;
        elsif ((Data_Voter_IN_1 /= Data_Voter_IN_2) and (Data_Voter_IN_2 = Data_Voter_IN_3)) then
            D2Eq3 <= '1';
            FlagData <= Data_Voter_IN_3;
         elsif ((Data_Voter_IN_1 = Data_Voter_IN_2) and (Data_Voter_IN_1 /= Data_Voter_IN_3)) then
            D2Eq1 <= '1';
            FlagData <= Data_Voter_IN_1;
         elsif ((Data_Voter_IN_1 /= Data_Voter_IN_2) and (Data_Voter_IN_1 /= Data_Voter_IN_3)) then
            DnotAll <='1';
            FlagData <= "ZZZZZZZZ";
         elsif ((Data_Voter_IN_1 /= Data_Voter_IN_2) or (Data_Voter_IN_2 /= Data_Voter_IN_3) or (Data_Voter_IN_1 /= Data_Voter_IN_3))then
            DnotAll <='1';
            FlagData <="ZZZZZZZZ"; 
         else
            D2Eq1 <='0';
            D2Eq3 <='0';
            D1Eq3 <='0';
            Dall <='0';
            DnotAll <='0';
            FlagData <= "ZZZZZZZZ";
        end if;
        Data_Voter_Out <= FlagData;
   end if;          
  end process;
end Behavioral;