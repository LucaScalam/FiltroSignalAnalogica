library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.filtro_paq.all;

entity top is
	generic (
		N: natural :=9;
		N_idx: natural :=25
	);
	port(
		clk,reset: in std_logic;
		to_pc: out std_logic;
		error: out std_logic;
		sdata: in std_logic;
		sclk,ss: out std_logic;
		leds: out std_logic_vector(3 downto 0)
	);
end top;
architecture Behavioral of top is
	signal contador_i,done_i,done_i_2,tick_1,tick_2: std_logic;
	signal x_i:x_t(0 to N_idx);
	signal f_i:cte_t(0 to N_idx);
	signal data_i: std_logic_vector(11 downto 0);
	signal filter_out: std_logic_vector(7 downto 0);
begin

	uart: entity work.uart_tx_unit
		port map(clk=>clk, reset=>reset,wr_uart=>done_i_2, w_data=>filter_out,tx_full=>error,tx=>to_pc);
		
	counter: entity work.contador2
		port map(clk=> clk, reset=>reset, tick=>contador_i);
		
	mic: entity work.PmodMICRefComp
		port map(clk=>clk, rst=>reset,sdata=>sdata, sclk=>sclk, nCS=>ss, data=>data_i, start=>contador_i, done=>done_i);
	
	rising_detector: entity work.rise_detector
		port map(clk=>clk, reset=>reset,done=>done_i, tick_rising=>tick_1);
	
	almacen: entity work.almacen
		port map(clk=>clk, reset=>reset,x_in=>data_i(11 downto 4), tick=>tick_1,x_out=>x_i,f_in=>f_i, tick_out=>tick_2);
	
	filter: entity work.filtro_fsmd
		port map(clk=>clk, reset=>reset,a=>x_i, cte=>f_i,start=>tick_2,result=>filter_out,done=>done_i_2);
	
	 
end Behavioral;