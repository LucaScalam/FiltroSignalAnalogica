LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.filtro_paq.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_almacen2 IS
END tb_almacen2;
 
ARCHITECTURE behavior OF tb_almacen2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT almacen
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         x_in : IN  std_logic_vector(0 to 7);
         tick : IN  std_logic;
         x_out : OUT  x_t(0 to 25);
         f_in : OUT  cte_t(0 to 25);
         tick_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal x_in : std_logic_vector(0 to 7) := (others => '0');
   signal tick : std_logic := '0';
 
 	--Outputs
   signal x_out : x_t(0 to 25);
   signal f_in : cte_t(0 to 25);
   signal tick_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: almacen PORT MAP (
          clk => clk,
          reset => reset,
          x_in => x_in,
          tick => tick,
          x_out => x_out,
          f_in => f_in,
          tick_out => tick_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
      reset <= '1';
      wait for 10 ns;		
		reset <= '0';
		wait for 10 ns;
		tick <= '0';
		wait for 10 ns;
		tick <= '1';
      x_in <= "00001000";
		wait for clk_period;
		tick <= '0';
		  
		wait for clk_period*5;
		
		tick <= '1';
      x_in <= "00001100";
		wait for clk_period;
		tick <= '0';

      wait;
   end process;

END;
