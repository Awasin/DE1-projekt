library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_registr is
    Port (echo : in std_logic;
          input : in std_logic_vector (7 downto 0);
          led : out std_logic;
          clk : in std_logic;
          CLK100MHZ : in std_logic;
          rst : in std_logic;
          count : out std_logic_vector (7 downto 0));
end top_registr;

architecture Behavioral of top_registr is

component debounce is
    port (
        clk      : in    std_logic;
        rst      : in    std_logic;
        en       : in    std_logic;
        bouncey  : in    std_logic;
        clean    : out   std_logic;
        pos_edge : out   std_logic;
        neg_edge : out   std_logic
        );
end component;
    
component time2cm is
    port ( en : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : in STD_LOGIC;
           count_s : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component registr is
    port ( input : in STD_LOGIC_VECTOR (7 downto 0);
           naber : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component comparator is
    port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           B_greater : out STD_LOGIC);
end component;

signal sig_done : std_logic;
signal sig_counter : std_logic_vector (7 downto 0);
signal sig_count : std_logic_vector ( 7 downto 0);

begin
    top_debounce : debounce
    port map (
       clk => CLK100MHZ,
       rst => rst,
       en => clk,
       bouncey => echo,
       clean => open,
       pos_edge => open,
       neg_edge => sig_done
    );
    
    prevod : time2cm
    port map (
       en_m => echo,
       en_time => clk,
       clk => CLK100MHZ,
       rst => rst,
       count_s => sig_counter 
    );
    
    
    t_registr : registr
    port map (
        input => sig_counter,
        naber => sig_done,
        output => sig_count 
    );
    
    
    t_comparator : comparator
    port map (
        A => sig_count,
        B => input,
        B_greater => led
    );
    count <= sig_count;
end Behavioral;
