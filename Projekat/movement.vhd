library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity movement is
port(

	--sw0, sw1, sw2: in std_logic; --sw0 idi naprijed | sw1 idi lijevo | sw2 idi desno
	in1, in2, in3, in4: out std_logic; --in1 i in2 su za motor1 | in2 i in3 za motor2
	distance: in std_logic_vector(5 downto 0)
	--en1, en2: out std_logic --en1 enable za motor1 | en2 enable za motor2
	
);
end movement;

architecture movement_arch of movement is
signal turn: std_logic := '0';
signal dist: unsigned(5 downto 0);
begin 
	process(distance)
	begin
		dist <= unsigned(distance);
		if(dist < 5) then
			turn <= '1';
		else
			turn <= '0';
		end if;
	end process;
--	en1 <= '1' when sw0 = '1' and sw1 = '0' and sw2 = '0' else
--			 '1' when sw0 = '0' and sw1 = '1' and sw2 = '0' else 
--			 '1' when sw0 = '0' and sw1 = '0' and sw2 = '1' else
--			 '0';
--			 
--	
--	en2 <= '1' when sw0 = '1' and sw1 = '0' and sw2 = '0' else
--			 '1' when sw0 = '0' and sw1 = '1' and sw2 = '0' else 
--			 '1' when sw0 = '0' and sw1 = '0' and sw2 = '1' else
--			 '0';
--	en1 <= '1' when turn = '0' else
--			 '1' when turn = '1' else
--			 '0';
--	en2 <= '1' when turn = '0' else
--			 '1' when turn = '1' else
--			 '0';
			 
	in1 <= --'1' when turn = '0' else
			 '0' when turn = '0' else 
			 '0' when turn = '1';
	
	in2 <= --'1' when turn = '0' else
			 '1' when turn = '0' else 
			 '1' when turn = '1';
			 
	
	in3 <= --'1' when turn = '0' else
			 '0' when turn = '0' else 
			 '0' when turn = '1';
	
	in4 <= --'1' when turn = '0' else
			 '1' when turn = '0' else 
			 '0' when turn = '1';
			 
end movement_arch;