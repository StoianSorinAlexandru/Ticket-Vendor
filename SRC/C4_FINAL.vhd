
library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity C4_FINAL is
	
	port
	(
	
		EN, CLK:in STD_LOGIC;
		X: in STD_LOGIC_VECTOR(7 downto 0);
		BD1, BD2, BD3, BD4, BD5: in STD_LOGIC_VECTOR(7 downto 0);--BANI MEMORIE
		BB1, BB2, BB3, BB4, BB5: in STD_LOGIC_VECTOR(7 downto 0);--BANI INTRODUSI
		
		OK:out STD_LOGIC; 
		REST_POS: out STD_LOGIC;
		REST1, REST2, REST3, REST4, REST5: out STD_LOGIC_VECTOR(7 downto 0);
		BANI_M1, BANI_M2, BANI_M3, BANI_M4, BANI_M5: out STD_LOGIC_VECTOR(7 downto 0)
	);	
end entity;

architecture MIXT of C4_FINAL is

component CIRC_UC_REST_PLUS_UE
	port(
	
		EN, CLK: in STD_LOGIC;
		X: in STD_LOGIC_VECTOR (7 downto 0);	
		BD1, BD2, BD3, BD4, BD5: in STD_LOGIC_VECTOR(7 downto 0); 				 
		
		W:out STD_LOGIC_VECTOR (7 downto 0);
		POS1, POS2, POS3, POS4, POS5: out STD_LOGIC_VECTOR (7 downto 0);  			 
		
		OPERATION_ENDED:out STD_LOGIC
	
	);
end component;	

component TEST_CIRC_SUM_FROM_MEM
	
	port
	(
	
		A1, A2, A3, A4, A5: in STD_LOGIC_VECTOR(7 downto 0);
	
		SUM: out STD_LOGIC_VECTOR(7 downto 0)
	
	);
	
end component;	

component TEST_CMP 
	
	port
	(
	
	A, B:in STD_LOGIC_VECTOR(7 downto 0);
	
	QL, QE, QG: out STD_LOGIC
	
	);
	
end component;	 

component TEST_CIRC_DIFF
	port(
		X2: in STD_LOGIC_VECTOR(7 downto 0);
		Y2: in STD_LOGIC_VECTOR(7 downto 0);
		W2: out STD_LOGIC_VECTOR(7 downto 0)		
	);
end component;

signal SUM_INT: STD_LOGIC_VECTOR(7 downto 0);
signal QE, QG, QL: STD_LOGIC;	  
signal REST_DE_PLATIT: STD_LOGIC_VECTOR(7 downto 0);	  
signal STARE, NXSTARE: STD_LOGIC_VECTOR(1 downto 0);   
signal ENR, OE: STD_LOGIC;	
signal W, R1, R2, R3, R4, R5:STD_LOGIC_VECTOR(7 downto 0);	 
signal STTT1, STTT2, STTT3: STD_LOGIC;

begin											   
	
	C1: TEST_CIRC_SUM_FROM_MEM port map(BB1, BB2, BB3, BB4, BB5, SUM_INT);
	C2: TEST_CMP port map(SUM_INT, X, QL, QE, QG);	 
	C3: TEST_CIRC_DIFF port map(SUM_INT, X, REST_DE_PLATIT); 
	C4: CIRC_UC_REST_PLUS_UE port map(ENR, CLK, REST_DE_PLATIT, BD1, BD2, BD3, BD4, BD5, W, R1, R2, R3, R4, R5, OE);
	
	ACTUALIZARE_STARE: process(EN, CLK, QG)
	begin	   
		if(EN='1' and QG='1')then
			STARE<="00";
		elsif CLK'EVENT and CLK	='1'then
			STARE<=NXSTARE;
		end if;
		
	end process;	 
	
	IDENTIFICARE_STARE: process(STARE)
	begin
		case STARE is
			
			when"00"=>	  
				ENR<='1';
				NXSTARE<="01";
			when"01"=>	
				ENR<='0';
				if(OE='1')then
					NXSTARE<="11";
				else
					NXSTARE<="10";
				end if;
			when"10"=>	
				NXSTARE<="01";
			when"11"=>	  	   
				REST1<=R1; 
				REST2<=R2; 
				REST3<=R3; 
				REST4<=R4; 
				REST5<=R5; 
				BANI_M1<=BB1;
				BANI_M2<=BB2;
				BANI_M3<=BB3;
				BANI_M4<=BB4;
				BANI_M5<=BB5; 
				
				NXSTARE<="11";
			when others=>
			
		end case;
	end process;
	
	
	COMPARAM_SUMELE_INTRODUSE :process(QL, QE, QG, EN, OE, STARE)
	begin		  
		
		if(EN='1')then
			
			if(QL='1')then	   	
				
			elsif QE='1' then
				
				REST1<="00000000"; 
				REST2<="00000000";
				REST3<="00000000";
				REST4<="00000000";	
				REST5<="00000000";	  
				
				BANI_M1<=BB1;	  
				BANI_M2<=BB2;
				BANI_M3<=BB3;
				BANI_M4<=BB4;
				BANI_M5<=BB5;  	   
				
			elsif QG='1' then		  
							    
				if(OE='1')then
					
					if(W="00000000")then
						REST_POS<='1';		
						
					else
						REST_POS<='0';
					end if;	  
					
				end if;
				
			else
					
			end if;
			
		else
			
			REST1<="ZZZZZZZZ"; 
			REST2<="ZZZZZZZZ";
			REST3<="ZZZZZZZZ";
			REST4<="ZZZZZZZZ";	
			REST5<="ZZZZZZZZ"; 
			BANI_M1<="ZZZZZZZZ";	  
			BANI_M2<="ZZZZZZZZ";
			BANI_M3<="ZZZZZZZZ";
			BANI_M4<="ZZZZZZZZ";
			BANI_M5<="ZZZZZZZZ"; 	 
			REST_POS<='Z';			   			
			
		end if;
		OK<=QL or QE or OE;				   
		STTT1<=QE;
		STTT2<=NOT(QL);
		if(OE='1' and W="00000000")then
			STTT3<='1';
		else STTT3<='0';
		end if;
		REST_POS<=STTT1 or STTT3; 
		
	end process;
	
	--C1:CIRC_UC_REST_PLUS_UE port map();
	
end architecture;