library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ultrasonic is
port(
	
	clk:			in std_logic;
	trig: 	out std_logic;
	echo: 		in std_logic;
	in1, in2, in3, in4: out std_logic;
--	en1, en2: out std_logic
	hex0, hex1: out std_logic_vector(6 downto 0);
	usisava_out: out std_logic
);
end ultrasonic;	

architecture ultrasonic_arch of ultrasonic is

component display7segment is
port(
   number : in std_logic_vector(3 downto 0);
   segments : out std_logic_vector(6 downto 0)
        );
end component;

component movement is
port(

	--sw0, sw1, sw2: in std_logic; --sw0 idi naprijed | sw1 idi lijevo | sw2 idi desno
	in1, in2, in3, in4: out std_logic; --in1 i in2 su za motor1 | in2 i in3 za motor2
	distance: in std_logic_vector(5 downto 0)
--	en1, en2: out std_logic --en1 enable za motor1 | en2 enable za motor2
	
);
end component;

signal echo_time: integer;
signal dist: unsigned(5 downto 0);
signal ones: unsigned(3 downto 0);
signal tens: unsigned(3 downto 0);
signal one: unsigned(5 downto 0);
signal ten: unsigned(5 downto 0);
constant usisava: std_logic := '1';
begin
  process(clk, echo)
    variable c1,c2: integer := 0;
    variable y :std_logic:='1';
  begin
    if rising_edge(clk) then

        if(c1=0) then
            trig<='1';
        elsif(c1=500) then--100us
            trig<='0';
            y:='1';
        elsif(c1=5000000) then-- 100 ms
            c1:= 0;
            trig<='1';
        end if;
        c1:=c1+1;

        if(echo = '1') then
            c2:=c2+1;
        elsif(echo = '0' and y='1' ) then-- I change the y to not get echo_time =0;
            echo_time<= c2;
            c2:=0;
            y:='0';
        end if;
	end if;
	end process;
	
	--constant sound_time: unsigned := 0.00034;
	dist <= to_unsigned(((echo_time * 340/1000000)/2),6);
	one <= dist mod 10;
	ten <= dist/10;
	
	ones <= unsigned(one)(3 downto 0);
	tens <= unsigned(ten)(3 downto 0);
	
	usisava_out <= usisava;
	
	cell_1: movement port map(in1,in2,in3,in4,std_logic_vector(dist));
	cell_2: display7segment port map(std_logic_vector(ones), hex0);
	cell_3: display7segment port map(std_logic_vector(tens), hex1);
end ultrasonic_arch;