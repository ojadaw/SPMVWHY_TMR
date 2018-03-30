library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SpMV is
    Port (
        Row :   in std_logic_vector(7 downto 0);
        Col :   in std_logic_vector(7 downto 0);
        Val :   in std_logic_vector(7 downto 0);
        Valid   :   in std_logic;
        Output  :   out std_logic_vector(7 downto 0);
        Ready  :   out std_logic;
        RowOut  :   out std_logic_vector(7 downto 0);
        
        clk, rst    :   in std_logic
    );
end SpMV;

architecture Behavioral of SpMV is

COMPONENT xbip_multadd_0
  PORT (
--    CLK : IN STD_LOGIC;
--    CE : IN STD_LOGIC;
--    SCLR : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    C : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    SUBTRACT : IN STD_LOGIC;
    P : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    PCOUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END COMPONENT;

COMPONENT RowCounter
  PORT (
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

COMPONENT ValCounter
  PORT (
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

constant N  :   integer := 3;

type Dense is array (N - 1 downto 0) of std_logic_vector(7 downto 0);
signal DenseArray : Dense;

signal RowEnd   :   std_logic   := '0';
signal Dense_In :   std_logic_vector(7 downto 0);
signal MultAdd_Out  :   std_logic_vector(7 downto 0);
signal MultAdd_Last, NextMult :   std_logic_vector(7 downto 0);
signal ValCount_Out, RowCount_Out   :   std_logic_vector(15 downto 0);

begin

Ready   <=  RowEnd;
Output  <=  MultAdd_Out;
RowOut  <=  RowCount_Out(7 downto 0);

process(clk, rst)
begin

    if rst = '1' then
        MultAdd_Last <= (OTHERS => '0');
        DenseArray <= ((others=> (others=>'0')));
    elsif rising_edge(clk) then
        MultAdd_Last    <=  NextMult;
        for i in 0 to N - 1 loop
            DenseArray(i)    <= std_logic_vector(to_unsigned(i + 1,8));
        end loop;
    end if;  

end process;

process(RowEnd, Valid, MultAdd_Out)
begin
    NextMult <= MultAdd_Last;
    if RowEnd = '1' then
        NextMult <= (OTHERS => '0');
    elsif Valid = '1' then  
        NextMult <= MultAdd_Out;
    end if;
end process;

MultAdd: xbip_multadd_0
  PORT MAP (
--    CLK => clk,
--    CE => Valid,
--    SCLR => '0',
    A => Val,
    B => Dense_In,
    C => MultAdd_Last,
    SUBTRACT => '0',
    P => MultAdd_Out,
    PCOUT => open
  );

process(col, DenseArray)
begin

    Dense_In    <=  DenseArray(to_integer(unsigned(col)));

end process;

ROWCOUNT: RowCounter
  PORT MAP (
    CLK => clk,
    CE => RowEnd,
    SCLR => rst,
    Q => RowCount_Out
  );

VALCOUNT: ValCounter
  PORT MAP (
    CLK => clk,
    CE => Valid,
    SCLR => rst,
    Q => ValCount_Out
  );
  
process(row, ValCount_Out)
begin

    RowEnd  <=  '0';

    if (unsigned(ValCount_Out) + 1) >= unsigned(row) then
        RowEnd  <=  '1';
    end if; 

end process;

end Behavioral;
