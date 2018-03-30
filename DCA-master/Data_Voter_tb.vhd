----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2017 08:09:27 PM
-- Design Name: 
-- Module Name: Data_Voter_tb - Behavioral
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
use IEEE.std_logic_textio.all;

entity Test_DataVoter_tb is 
    --port();
end entity;

architecture Test_This of Test_DataVoter_tb is

component Data_Voter is
  Port (clock              : in std_logic;
  --- Define input & output for the Data voter. The data voter compares the values of the data and outputs the majority of the 3--
       Data_Voter_IN_1    : in std_logic_vector(7 downto 0);
       Data_Voter_IN_2    : in std_logic_vector(7 downto 0);
       Data_Voter_IN_3    : in std_logic_vector(7 downto 0);
       Data_Voter_Out     : out std_logic_vector(7 downto 0));
end component;
signal Data1, Data2, Data3,Data_OutV   : std_logic_vector(7 downto 0);--:= "00000000";
signal CLK                            : std_logic :='0'; --time := 10ns;
--constant CLK: time  := 10 ns
begin
UUT: Data_Voter port map(clock           => CLK, 
                         Data_Voter_IN_1 => Data1,
                         Data_Voter_IN_2 => Data2,
                         Data_Voter_IN_3 => Data3,
                         Data_Voter_Out  => Data_OutV);

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
        Data1 <= "00001010";
        Data2 <= "00001010";
        Data3 <= "00001010";  
      wait for 10ns;
        Data1 <= "00011010";
        Data2 <= "00001010";
        Data3 <= "00011010";
     wait for 10ns;  
        Data1 <= "01001010";
        Data2 <= "01001010";
        Data3 <= "00001110";  
     wait for 10ns; 
        Data1 <= "00001010";
        Data2 <= "00011100";
        Data3 <= "00011100";  
     wait for 10ns; 
        Data1 <= "00001010";
        Data2 <= "00010100";
        Data3 <= "00011010";  
     wait;  
end process;
end Test_This;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Data_Voter_tb is
--  Port ( );
end Data_Voter_tb;

architecture Behavioral of Data_Voter_tb is

begin


end Behavioral;
