
library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity CIRC_UC_REST_PLUS_UE is
	
	port(
	
		EN, CLK: in STD_LOGIC;
		X: in STD_LOGIC_VECTOR (7 downto 0);	
		BD1, BD2, BD3, BD4, BD5: in STD_LOGIC_VECTOR(7 downto 0); 				 
		
		W:out STD_LOGIC_VECTOR (7 downto 0);
		POS1, POS2, POS3, POS4, POS5: out STD_LOGIC_VECTOR (7 downto 0);  			 
		
		OPERATION_ENDED:out STD_LOGIC
	
	);
	
end entity;	   									

architecture MIXT of CIRC_UC_REST_PLUS_UE is

component CIRC_UE_REST_CALC
	port(
	
		EN, CLK: in STD_LOGIC;
		X: in STD_LOGIC_VECTOR (7 downto 0);					  
		BD1, BD2, BD3, BD4, BD5: in STD_LOGIC_VECTOR(7 downto 0); 
		SEL1, SEL2, SEL3, SEL4, SEL5: in STD_LOGIC;
		
		W:out STD_LOGIC_VECTOR (7 downto 0);
		POS1, POS2, POS3, POS4, POS5: out STD_LOGIC_VECTOR (7 downto 0);  
		CF1, CF2, CF3, CF4, CF5: out STD_LOGIC;
		
		OK:out STD_LOGIC
	
	);
end component;

signal STARE, NXSTARE: STD_LOGIC_VECTOR(4 downto 0); 
signal ST1, ST2, ST3, ST4, ST5: STD_LOGIC;
signal CF1, CF2, CF3, CF4, CF5: STD_LOGIC;	   
begin
	
	C1: CIRC_UE_REST_CALC port map('0', CLK, X, BD1, BD2, BD3, BD4, BD5, ST1, ST2, ST3, ST4, ST5, W, POS1, POS2, POS3, POS4, POS5, CF1, CF2, CF3, CF4, CF5); 
	
	ACTUALIZARE_STARE: process(EN, CLK)
	begin	   
		if(EN='1')then
			STARE<="00000";	 
		elsif CLK'EVENT and CLK	='1'then
			STARE<=NXSTARE;
		end if;
		
	end process; 
	
	IDENTIFICARE_STARE: process(STARE, CF1, CF2, CF3, CF4, CF5)
	begin
		case STARE is		
			---RESTUL LA 50EURO
			when "00000" =>--0	
				NXSTARE<="00001"; 
				ST1<='1';
			when "00001" =>--1	
				ST1<='0';
				if(CF1='1')then
					NXSTARE<="00011";
				else		
					NXSTARE<="00010";	   
				end if;
			when "00010" =>--2	 
				NXSTARE<="00001";
			when "00011" =>--3		 
				NXSTARE<="00100"; 
			
			
			---RESTUL LA 10EURO
			when "00100" =>--4	
				NXSTARE<="00101";
				ST2<='1';
			when "00101" =>--5	 
				ST2<='0';
				if(CF2='1')then
					NXSTARE<="00111";
				else
					NXSTARE<="00110";
				end if;
			when "00110" =>--6 	   
				NXSTARE<="00101";
			when "00111" =>--7	
				NXSTARE<="01000";
								
			---RESTUL LA 5EURO
			when "01000" =>--8	 
				NXSTARE<="01001";  
				ST3<='1';		   
			when "01001" =>--9	
				ST3<='0';
				if(CF3='1')then
					NXSTARE<="01011";
				else
					NXSTARE<="01010";
				end if;
			when "01010" =>--10	   
				NXSTARE<="01001";
			when "01011" =>--11
				NXSTARE<="01100";
			
			---RESTUL LA 2EURO
			when "01100" =>--12	 
				NXSTARE<="01101";	
				ST4<='1';
			when "01101" =>--13	 
				ST4<='0';
				if(CF4='1')then
					NXSTARE<="01111";
				else
					NXSTARE<="01110";
				end if;
			when "01110" =>--14		 
				NXSTARE<="01101";
			when "01111" =>--15
				NXSTARE<="10000";
			
			---RESTUL LA 1EURO
			when "10000" =>--16  
				NXSTARE<="10001";
				ST5<='1';
			when "10001" =>--17
				ST5<='0';
				if(CF5='1')then
					NXSTARE<="10011";
				else
					NXSTARE<="10010";
				end if;
			when "10010" =>--18	   
				NXSTARE<="10001";
			when "10011" =>--19	 
				NXSTARE<="10100";
				
			--FINAL
			when "10100" =>--20	  
			when others =>	  
			
		end case;
	end process;  
	OPERATION_ENDED<=CF5;
end architecture;