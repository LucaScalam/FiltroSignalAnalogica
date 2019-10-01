--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:32:30 09/12/2019
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Solchu/Desktop/LABOIII/Uart/tb_counter.vhd
-- Project Name:  Uart
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: contador2
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_counter IS
END tb_counter;
 
ARCHITECTURE behavior OF tb_counter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT contador2
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
--         M : IN  unsigned(18 downto 0);
         tick : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   --signal M : unsigned(18 downto 0) := (others => '0');

 	--Outputs
   signal tick : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: contador2 PORT MAP (
          clk => clk,
          reset => reset,
     --     M => M,
          tick => tick
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
      wait until tick='1';
		wait for 8.5*clk_period;
		assert tick= '0' report "Error 1" severity failure;
		
		wait for 4992*clk_period;
		assert tick= '1' report "Error 2" severity failure;
      wait for 8.5*clk_period;
		assert tick= '0' report "Error 3" severity failure;
		
		assert false report "Todo ok" severity failure;
      wait;
   end process;

END;
