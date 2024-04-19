----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2024 06:27:12 PM
-- Design Name: 
-- Module Name: time2cm - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity time2cm is
    Port ( en_m : in STD_LOGIC;
           en_time :in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           count_s : out STD_LOGIC_VECTOR (7 downto 0));
end time2cm;

architecture Behavioral of time2cm is

    component clock_enable is
        generic(
            PERIOD:integer
        );
        port( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in std_logic;
           pulse : out STD_LOGIC;
           sig_c : out std_logic_vector (3 downto 0));
    end component;
    
signal sig_final : std_logic_vector (7 downto 0);
signal sig_clk_ten : std_logic;
signal sig_en : std_logic;
 
begin

    sig_en <= (en_time and en_m) and not sig_final(7);
    
    jednotky: clock_enable
    generic map(
        PERIOD => 10
    )
    port map (
      clk => clk,
      en => sig_en,
      rst => rst, 
      sig_c => sig_final (3 downto 0),
      pulse => sig_clk_ten
    );
    
    desitky: clock_enable
    generic map(
        PERIOD => 10
    )
    port map (
      clk => clk,
      en => sig_clk_ten,
      rst => rst, 
      sig_c => sig_final (7 downto 4),
      pulse => open
    );

    count_s <= sig_final;
    
end Behavioral;
