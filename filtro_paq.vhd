library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package filtro_paq is
	
	constant Bits_cte_t : integer := 20;
	constant Bits_x_t : integer := 8;
	
	type x_t is array(integer range <>) of std_logic_vector(Bits_x_t -1 downto 0);
	type cte_t is array(integer range <>) of std_logic_vector(Bits_cte_t -1 downto 0);
	
end filtro_paq;
