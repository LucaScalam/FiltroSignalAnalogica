--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:19:33 09/12/2019
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Solchu/Desktop/LABOIII/Uart/tb_rising.vhd
-- Project Name:  Uart
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: rise_detector
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_rising IS
END tb_rising;
 
ARCHITECTURE behavior OF tb_rising IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT rise_detector
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         done : IN  std_logic;
         tick_rising : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal done : std_logic := '0';

 	--Outputs
   signal tick_rising : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: rise_detector PORT MAP (
          clk => clk,
          reset => reset,
          done => done,
          tick_rising => tick_rising
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
		done <= '0';
		-- Trabajando
		wait for 100 ns;
		-- Termino
		done <= '1';
		wait for 10 ns;
		assert tick_rising = '1' report "Error en primer rising" severity failure;
		
		--esperando
		wait for 100 ns;
		done <= '0';
		-- Trabajando
		wait for 100 ns;
		done <= '1';
		wait for 10 ns;
		assert tick_rising = '1' report "Error en 2do rising" severity failure;
		
		--esperando
		wait for 300 ns;
		done <= '0';
		-- Trabajando
		wait for 100 ns;
		done <= '1';
		wait for 10 ns;
		assert tick_rising = '1' report "Error en 3er rising" severity failure;
		
		
      wait for clk_period*10;

      -- insert stimulus here 
		assert false report "todo OK" severity failure;
   end process;

END;
