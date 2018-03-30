library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.all;


entity SpMV_tb is
end SpMV_tb;

architecture Behavioral of SpMV_tb is

signal Row :   std_logic_vector(7 downto 0) := (OTHERS => '0');
signal Col :   std_logic_vector(7 downto 0) := (OTHERS => '0');
signal Val :   std_logic_vector(7 downto 0) := (OTHERS => '0');
signal Valid   :   std_logic    :=  '0';
signal Output  :   std_logic_vector(7 downto 0);
signal Ready  :   std_logic;
signal RowOut  :   std_logic_vector(7 downto 0);
signal clk, rst    :   std_logic    :=  '0';

signal end_of_simulation    :   boolean :=  false;

constant numRows    :   integer :=  3;
constant NNZ    :   integer :=  6;

type CSR_ColVal is array(NNZ - 1 downto 0) of std_logic_vector(15 downto 0);
signal ColData  :   CSR_ColVal;

type CSR_Row is array(numRows - 1 downto 0) of std_logic_vector(7 downto 0);
signal RowData  :   CSR_Row;

begin

clk <=  not clk after 5 ns;

UUT: entity work.SpMV
    Port Map(
            Row =>  Row,
            Col => Col,
            Val => Val,
            Valid   => Valid,
            Output  => Output,
            Ready  => Ready,
            RowOut  => RowOut,
            
            clk =>  clk, 
            rst    => rst
    );
    
Process

procedure randMat is 

variable RowCount   :   integer := 0;
variable NZCount    :   integer := 0;
variable NZ :   real := 0.0;
variable Sparse  :   real :=  0.0; --RNG for NZ or 0
variable seed1, seed2: positive;

begin
    
    for i in 0 to numRows*NumRows-1 loop
        uniform(seed1, seed2, NZ);
        uniform(seed1, seed2, Sparse);
        
        if (i mod numRows) = 0 then
--            report  "Start of Rows";
            RowData(RowCount)  <=  std_logic_vector(to_unsigned(NZCount,8));
            RowCount    :=  RowCount + 1;
        end if;
        
        if Sparse < 0.6 and NZCount < NNZ then
            ColData(NZCount)(7 downto 0) <= std_logic_vector(to_unsigned(integer(NZ * 10) + 1,8));
            ColData(NZCount)(15 downto 8) <=  std_logic_vector(to_unsigned(integer(i mod NumRows), 8));
            NZCount := NZCount + 1;
--            report INTEGER'IMAGE(NZCount) & ": Nonzero Value";
--        else
--            report "Zero Value";
        end if;

    end loop;
    
end procedure;

Variable RowCount   :   integer := 1;

Begin
    
    randMat;
    
    rst <=  '1';
    wait for 10 ns;
    rst <= '0';
    wait for 10 ns;
    
    for i in 0 to NNZ - 1 loop
        report "Row = " & INTEGER'IMAGE(RowCount);  
        Col <=  ColData(i)(15 downto 8);
        Val <=  ColData(i)(7 downto 0); 
        Row <= RowData(RowCount);
        Valid   <=  '1';
        wait until rising_edge(clk);
        if Ready = '1' and RowCount /= numRows - 1 then
            RowCount := RowCount + 1;
        end if;
 
    end loop;
    Valid <= '0';
    end_of_simulation   <=  true;
    wait;
    
End Process;    

end Behavioral;
