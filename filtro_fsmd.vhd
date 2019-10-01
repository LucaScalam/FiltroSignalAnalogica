library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.filtro_paq.all;


entity filtro_fsmd is
	generic (
		N: natural :=9 ;
		N_idx: natural :=25
	);
	port (
		clk,reset: in std_logic;
		-- entradas del filtro: a son datos, cte son las ctes del filtro
		a: in x_t(0 to N_idx);
		cte: in cte_t(0 to N_idx);
		start: in std_logic;
		-- salida
		result : out std_logic_vector(Bits_x_t -1 downto 0);
		done : out std_logic
	);
	
end filtro_fsmd;

architecture Behavioral of filtro_fsmd is

	type state_type is (idle,op,done_state);
	signal state_reg, state_next: state_type;
	signal i_reg,i_next: unsigned(6 downto 0);
	signal ac_reg,ac_next: signed(28 downto 0);
	--signal ready :  std_logic;
begin
	process(clk,reset)
	begin
		if reset = '1' then
			state_reg <= idle;
			ac_reg <= (others=>'0');
			i_reg <= (others=>'0');
		elsif (clk'event and clk='1') then
			state_reg <= state_next;
			i_reg <= i_next;
			ac_reg <= ac_next;
		end if;
	end process;
	 
	process(i_reg,state_reg,ac_reg,start,a,cte)
	begin
		state_next <= state_reg;
		i_next <= i_reg;
		ac_next <= ac_reg;
		case state_reg is
			when idle =>
				if start = '1' then
					i_next <= (others=>'0');
					ac_next <= (others=>'0'); 
					state_next<=op;
				end if;
			when op =>
				if (i_reg = 26) then
					state_next <= done_state;
				else
					ac_next <= ac_reg + ( signed('0' & a(to_integer(i_reg))) * signed(cte(to_integer(i_reg))) );
					i_next <= i_reg +1; 
				end if;
			when done_state =>
					state_next <= idle;
		end case; 
 	end process;
	
	process(state_reg,ac_reg)
	begin
		done <= '0';
		case state_reg is
			when idle =>
				result <= std_logic_vector(ac_reg(27 downto 20));
			when op =>
				result <= (others=>'0');
			when done_state =>
				done <= '1';
				result <= std_logic_vector(ac_reg(27 downto 20));
		end case;
	end process;
	 		
end Behavioral;
