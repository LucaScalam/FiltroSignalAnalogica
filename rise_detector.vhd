library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity rise_detector is
	port(
		clk,reset,done: in std_logic;
		tick_rising: out std_logic
	);
end rise_detector;

architecture Behavioral of rise_detector is
	signal next_state,actual_state: std_logic;
begin
	process(clk,reset)
	begin
		if (reset='1') then
			actual_state<='1';
			tick_rising <= '0';
		elsif (clk'event and clk='1') then
			if (actual_state = '0' and next_state = '1') then
				tick_rising <= '1';
			else
				tick_rising <= '0';
			end if;
			actual_state <= next_state;
		end if;
	end process;
	
	next_state <= done;
end Behavioral;
