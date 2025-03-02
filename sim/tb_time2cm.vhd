-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 28.3.2024 17:42:09 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_time2cm is
end tb_time2cm;

architecture tb of tb_time2cm is

    component time2cm
        port (en      : in std_logic;
              clk     : in std_logic;
              rst     : in std_logic;
              count_s : out std_logic_vector (7 downto 0));
    end component;

    signal en      : std_logic;
    signal clk     : std_logic;
    signal rst     : std_logic;
    signal count_s : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 20 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : time2cm
    port map (en      => en,
              clk     => clk,
              rst     => rst,
              count_s => count_s);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        en <= '0';

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        en <= '1';
        wait for 100 ns;
        
        rst <= '0';
        
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_time2cm of tb_time2cm is
    for tb
    end for;
end cfg_tb_time2cm;