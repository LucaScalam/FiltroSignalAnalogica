library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity contador2 is
	generic(N: integer := 19);
	port(
		clk, reset: in std_logic;
		--M: in unsigned(N-1 downto 0);
		tick : out std_logic
	);
end contador2;

architecture Behavioral of contador2 is
	signal next_state,actual_state: unsigned(N-1 downto 0);
	signal tick_2: std_logic;
begin
	process(clk,reset)
	begin
		if (reset='1') then
			actual_state<=(others=>'0');
		elsif (clk'event and clk='1') then
			actual_state <= next_state;
		end if;
	end process;
	
	next_state <= actual_state + 1 when (tick_2 = '0') else
						(others=>'0');
	tick_2 <= '1' when actual_state = 4999 else
					'0';
	tick <= '1' when actual_state < 8  else
					'0';
end Behavioral;