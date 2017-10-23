----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2017 08:24:01 PM
-- Design Name: 
-- Module Name: Ptr_Voter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2017 01:02:42 AM
-- Design Name: 
-- Module Name: Ptr_Voter - Behavioral
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
use IEEE.Numeric_std;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ptr_Voter is
          Port (clock   : std_logic;
 --- Define input & output for the Pointer voter. The pointer voter compares the pointers of the values of the data and outputs the majority of the 3--              
                Ptr_Voter_IN_1     : in std_logic_vector(7 downto 0);
                Ptr_Voter_IN_2     : in std_logic_vector(7 downto 0);
                Ptr_Voter_IN_3     : in std_logic_vector(7 downto 0);
                Ptr_Voter_Out      : out std_logic_vector(7 downto 0));
end Ptr_Voter;

architecture Behavioral of Ptr_Voter is
signal Ptr2Eq1, Ptr2Eq3, Ptr1Eq3, Ptrall, PtrnotAll   : std_logic;
signal FlagPtr                                        : std_logic_vector(7 downto 0);
begin
 --========== Creating the Pointer voter =====================================----
 PTR_VOTER:process(clock)
       begin
        if rising_edge(clock)then
            if (Ptr_Voter_IN_1 = Ptr_Voter_IN_2) then
                Ptr2Eq1 <= '1';
                --FlagData <= Data_Voter_IN_1;
                FlagPtr <= Ptr_Voter_IN_2;
            elsif (Ptr_Voter_IN_3 = Ptr_Voter_IN_1) then
                Ptr1Eq3 <= '1';
                FlagPtr <= Ptr_Voter_IN_1;  
                --FlagData <= Data_Voter_IN_3;
            elsif (Ptr_Voter_IN_2 = Ptr_Voter_IN_3) then
                Ptr2Eq3 <= '1';
                --FlagData <= Data_Voter_IN_2;
                FlagPtr <= Ptr_Voter_IN_3;
            elsif ((Ptr_Voter_IN_1 = Ptr_Voter_IN_2) and (Ptr_Voter_IN_1 = Ptr_Voter_IN_3)) then
                Ptrall <= '1';
                FlagPtr <= Ptr_Voter_IN_1;
            elsif ((Ptr_Voter_IN_1 /= Ptr_Voter_IN_2) and (Ptr_Voter_IN_1 = Ptr_Voter_IN_3)) then
                Ptr1Eq3 <= '1';
                FlagPtr <= Ptr_Voter_IN_3;
            elsif ((Ptr_Voter_IN_1 /= Ptr_Voter_IN_2) and (Ptr_Voter_IN_2 = Ptr_Voter_IN_3)) then
                Ptr2Eq3 <= '1';
                FlagPtr <= Ptr_Voter_IN_3;
             elsif ((Ptr_Voter_IN_1 = Ptr_Voter_IN_2) and (Ptr_Voter_IN_1 /= Ptr_Voter_IN_3)) then
                Ptr2Eq1 <= '1';
                FlagPtr <= Ptr_Voter_IN_1;
             elsif ((Ptr_Voter_IN_1 /= Ptr_Voter_IN_2) and (Ptr_Voter_IN_1 /= Ptr_Voter_IN_3)) then
                PtrnotAll <='1';
                FlagPtr <= "ZZZZZZZZ";
             elsif ((Ptr_Voter_IN_1 /= Ptr_Voter_IN_2) or (Ptr_Voter_IN_2 /= Ptr_Voter_IN_3) or (Ptr_Voter_IN_1 /= Ptr_Voter_IN_3))then
                PtrnotAll <='1';
                FlagPtr <="ZZZZZZZZ";
             else
                Ptr2Eq1 <='0';
                Ptr2Eq3 <='0';
                Ptr1Eq3 <='0';
                Ptrall <='0';
                PtrnotAll <='0';
                FlagPtr <= "ZZZZZZZZ";
            end if;
       Ptr_Voter_Out <= FlagPtr;
       end if;  
     end process;
end Behavioral;