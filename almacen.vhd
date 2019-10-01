library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.filtro_paq.all;

entity almacen is
	generic (
		N: natural :=9 ;
		N_idx: natural :=25
	);
	port (
		clk,reset: in std_logic;
		--entrada
		x_in: in std_logic_vector(0 to 7);
		tick: in std_logic;
		--salida
		x_out: out x_t(0 to N_idx);
		f_in: out cte_t(0 to N_idx);
		tick_out: out std_logic
		--start : out std_logic
 
	);
end almacen;

architecture Behavioral of almacen is
	signal x_reg, x_next: x_t(0 to N_idx);
	signal tick_reg,tick_next: std_logic;
begin
	process(clk,reset)
	begin 
		if (reset ='1') then
			x_reg <= (others=>(others=>'0'));
		elsif(clk'event and clk='1') then
			x_reg <= x_next;
			tick_reg <= tick_next;
		end if;
	end process;
	 
	x_next <= x_in & x_reg(0 to N_idx-1) when tick='1' else
				 x_reg;
	tick_next <= '1' when tick = '1' else 
					'0';
	x_out <= x_reg;
	tick_out <= tick_reg;
	
	f_in(0) <= "00000101111111110000";
	f_in(1) <= "00000000100011011011";
	f_in(2) <= "11111001011010011000";
	f_in(3) <= "11111000101110000000";
	f_in(4) <= "00000000101111111011";
	f_in(5) <= "00001001111111100101";
	f_in(6) <= "00001001011111011010";
	f_in(7) <= "11111100100011101000";
	f_in(8) <= "11101110011110000101";
	f_in(9) <= "11110000111100100100";
	
	f_in(10) <= "00001100011010110010";
	f_in(11) <= "00110101111010101111";
	f_in(12) <= "01010100110001110000";
	f_in(13) <= "01010100110001110000";
	f_in(14) <= "00110101111010101111";
	f_in(15) <= "00001100011010110010";
	f_in(16) <= "11110000111100100100";
	f_in(17) <= "11101110011110000101";
	f_in(18) <= "11111100100011101000";
	f_in(19) <= "00001001011111011010";
	
	f_in(20) <= "00001001111111100101";
	f_in(21) <= "00000000101111111011";
	f_in(22) <= "11111000101110000000";
	f_in(23) <= "11111001011010011000";
	f_in(24) <= "00000000100011011011";
	f_in(25) <= "00000101111111110000";
	
end Behavioral;

--	f_in(0) <= "00000101111111110000";
--	f_in(1) <= "";
--	f_in(2) <= "";
--	f_in(3) <= "";
--	f_in(4) <= "";
--	f_in(5) <= "";
--	f_in(6) <= "";
--	f_in(7) <= "";
--	f_in(8) <= "";
--	f_in(9) <= "";
--	
--	f_in(10) <= "";
--	f_in(11) <= "";
--	f_in(12) <= "";
--	f_in(13) <= "";
--	f_in(14) <= "";
--	f_in(15) <= "";
--	f_in(16) <= "";
--	f_in(17) <= "";
--	f_in(18) <= "";
--	f_in(19) <= "";
--	
--	f_in(20) <= "";
--	f_in(21) <= "";
--	f_in(22) <= "";
--	f_in(23) <= "";
--	f_in(24) <= "";
--	f_in(25) <= "";
