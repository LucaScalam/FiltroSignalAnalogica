LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.filtro_paq.all; 
 
ENTITY tb_filtro IS
END tb_filtro;
 
ARCHITECTURE behavior OF tb_filtro IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT filtro_fsmd
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         a : IN  x_t(0 to 25);
         cte : IN  cte_t(0 to 25);
         start : IN  std_logic;
         result : OUT  std_logic_vector(7 downto 0);
         done : OUT  std_logic
--         ready : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal a : x_t(0 to 25):= (others=>(others=>'0'));
   signal cte : cte_t(0 to 25):= (others=>(others=>'0'));
   signal start : std_logic := '0';
   
 	--Outputs
   signal result : std_logic_vector(7 downto 0);
   signal done : std_logic;
--   signal ready : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: filtro_fsmd PORT MAP (
          clk => clk,
          reset => reset,
          a => a,
          cte => cte,
          start => start,
          result => result,
          done => done
 --         ready => ready
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
		
		cte(0) <= "11101110010101101100";
		cte(1) <= "11110000011101010000";
		cte(2) <= "00001101000011101100";
		cte(3) <= "00111001011000011001";
		cte(4) <= "01011010110000111111";
		cte(5) <= "01011010110000111111";
		cte(6) <= "00111001011000011001";
		cte(7) <= "00001101000011101100";
		cte(8) <= "11110000011101010000";
		cte(9) <= "11101110010101101100";
 
		a(0) <= "00000001";
		a(1) <= "00000001";
		a(2) <= "00000001";
		a(3) <= "00000001";
		a(4) <= "00000001";
		a(5) <= "00000001";
		a(6) <= "00000001";
		a(7) <= "00000001";
		a(8) <= "00000001";
		a(9) <= "00000001";
      wait for clk_period*10;
		start <= '1';
		wait until done = '1';
		assert result = "00000001" report "Error 1" severity failure;
		
		start <= '0';
		wait for clk_period*10;
		start <= '1';
		wait until done = '1';
		assert result = "00000001" report "Error 2" severity failure;
		start <= '0';
		
		assert false report "Todo ok" severity failure;
      wait;
   end process;

END;
