----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2017 08:36:10 PM
-- Design Name: 
-- Module Name: NNZ_FIFO - Behavioral
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity Index_FIFO is
  generic (
    FIFO_WIDTH : natural := 8;
    FIFO_DEPTH : integer := 17
    );
  port (
    RST    : in std_logic;
    clock  : in std_logic;
  --Rd_clk : in std_logic;
 
    -- FIFO Write Interface
    wr_en   : in  std_logic;
    wr_data : in  std_logic_vector(FIFO_WIDTH-1 downto 0);
    full    : out std_logic;
 
    -- FIFO Read Interface
    rd_en   : in  std_logic;
    rd_data : out std_logic_vector(FIFO_WIDTH-1 downto 0);
    empty   : out std_logic
    );
end Index_FIFO;
 
architecture CSR_FIFO of Index_FIFO is
 
  type Index_FIFO_Value is array (0 to FIFO_DEPTH-1) of std_logic_vector(FIFO_WIDTH-1 downto 0);
  signal Index_FIFO : Index_FIFO_Value := (others => (others => '0'));
 
  signal WR_INDEX   : integer range 0 to FIFO_DEPTH-1 := 0;
  signal RD_INDEX   : integer range 0 to FIFO_DEPTH-1 := 0;
 
  -- # Words in FIFO, has extra range to allow for assert conditions
  signal FIFO_COUNT : integer range -1 to FIFO_DEPTH+1 := 0;
 
  signal WORD_FULL  : std_logic;
  signal WORD_EMPTY : std_logic;
   
begin
 
  p_CONTROL : process (Clock) is
  begin
    if rising_edge(Clock) then
      if RST = '1' then
        FIFO_COUNT <= 0;
        WR_INDEX   <= 0;
        RD_INDEX   <= 0;
      else
 
        -- Keeps track of the total number of words in the FIFO
        if (wr_en = '1' and rd_en = '0') then
            FIFO_COUNT <= FIFO_COUNT + 1;
        elsif (wr_en = '0' and rd_en = '1') then
          FIFO_COUNT <= FIFO_COUNT - 1;
        end if;
 
        -- Keeps track of the write index (and controls roll-over)
        if (wr_en = '1' and WORD_FULL = '0') then
            if (WR_INDEX = FIFO_DEPTH-1) then
               WR_INDEX <= 0;
          else
            WR_INDEX <= WR_INDEX + 1;
          end if;
        end if;
 
        -- Keeps track of the read index (and controls roll-over)        
        if (rd_en = '1' and WORD_EMPTY = '0') then
            if (RD_INDEX = FIFO_DEPTH-1) then
                RD_INDEX <= 0;
            else
                RD_INDEX <= RD_INDEX + 1;
            end if;
        end if;
 
        -- Registers the input data when there is a write
        if wr_en = '1' then
           Index_FIFO(WR_INDEX) <= wr_data;
        end if;
      end if;                           -- sync reset
    end if;                             -- rising_edge(i_clk)
  end process p_CONTROL;
   
  Rd_data <= Index_FIFO(RD_INDEX);
 
  WORD_FULL  <= '1' when FIFO_COUNT = FIFO_DEPTH else '0';
  WORD_EMPTY <= '1' when FIFO_COUNT = 0  else '0';
 
  full  <= WORD_FULL;
  empty <= WORD_EMPTY;
   
  -- ASSERTION LOGIC - Not synthesized
  -- synthesis translate_off
 
  p_ASSERT : process (clock) is
  begin
    if rising_edge(clock) then
      if ((wr_en = '1') and (WORD_FULL = '1')) then
        report "ASSERT FAILURE - MODULE_REGISTER_FIFO: FIFO IS FULL AND BEING WRITTEN " severity failure;
      end if;
 
      if ((rd_en = '1') and (WORD_EMPTY = '1')) then
        report "ASSERT FAILURE - MODULE_REGISTER_FIFO: FIFO IS EMPTY AND BEING READ " severity failure;
      end if;
    end if;
  end process p_ASSERT;
 
  -- synthesis translate_on
end CSR_FIFO;