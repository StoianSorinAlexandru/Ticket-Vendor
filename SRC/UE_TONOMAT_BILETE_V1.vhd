library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity UE_TONOMAT_BILETE_V1 is
	
	port(
	
		CLK: in STD_LOGIC;	
		INC: in STD_LOGIC;
		DEC: in STD_LOGIC;
		
		--C2
		EN_2 : in STD_LOGIC_VECTOR(1 downto 0);
		SEL_2: in STD_LOGIC_VECTOR(4 downto 0);
			
		--C4	
		EN_4 : in STD_LOGIC_VECTOR(1 downto 0);
		
		--C6   
		EN_6 : in STD_LOGIC_VECTOR(1 downto 0); 
		
		--C7
		EN_7 : in STD_LOGIC_VECTOR(1 downto 0);	
		
		--C8
		SEL_8: in STD_LOGIC_VECTOR(1 downto 0);
		
		--C9
		EN_9 : in STD_LOGIC_VECTOR(1 downto 0);
		SEL_9: in STD_LOGIC_VECTOR(4 downto 0);
		
		--C10	
		EN_10: in STD_LOGIC_VECTOR(1 downto 0);
		
		--C12
		SEL_12: in STD_LOGIC_VECTOR(1 downto 0);
		
		
		--CATODUL SI ANODUL AFISORULUI
		CATOD: out STD_LOGIC_VECTOR(0 to 6);
		ANOD : out STD_LOGIC_VECTOR(0 to 3);
		
		--C4_CONDITIONS									  
		OK_4    : out STD_LOGIC;
		REST_POS: out STD_LOGIC;
		--C6_CONDITIONS
		OK_6    : out STD_LOGIC
	);
	
end entity;	

architecture UE_TONOMAT_MIXT_V1 of UE_TONOMAT_BILETE_V1 is

component C1_AFIS
	
	port
	(	
		EN1, CLK1: in STD_LOGIC;
		DATA_IN: in STD_LOGIC_VECTOR(0 to 11);
		CATOD1: out STD_LOGIC_VECTOR(0 to 6);
		ANOD1: out STD_LOGIC_VECTOR(0 to 3)
	);
	
end component;

component C2_FINAL is
	
	port
	(
		INC1, DEC1: in STD_LOGIC;		  
		SEL: in STD_LOGIC_VECTOR(4 downto 0);
			  
		PL1:in STD_LOGIC_VECTOR(7 downto 0); 
		PL2:in STD_LOGIC_VECTOR(7 downto 0); 
		PL3:in STD_LOGIC_VECTOR(7 downto 0); 
		PL4:in STD_LOGIC_VECTOR(7 downto 0); 
		PL5:in STD_LOGIC_VECTOR(7 downto 0);
		
		Q1:inout STD_LOGIC_VECTOR(7 downto 0); 
		Q2:inout STD_LOGIC_VECTOR(7 downto 0);
		Q3:inout STD_LOGIC_VECTOR(7 downto 0);
		Q4:inout STD_LOGIC_VECTOR(7 downto 0);
		Q5:inout STD_LOGIC_VECTOR(7 downto 0)
	
	);
	
end component;	

component C3_DIST_CALC
	
	port(					
		DIST:IN STD_LOGIC_VECTOR (7 downto 0);
		Q1: out STD_LOGIC_VECTOR (15 downto 0)		  
	);
	
end component;	

component C4_FINAL
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
end component;

component C6_FINAL
	port(  	 
		INC, DEC: in STD_LOGIC;		  
		EN: in STD_LOGIC_VECTOR(1 downto 0);	   
		
		Q:inout STD_LOGIC_VECTOR(7 downto 0);
		MISSING_TICKETS: out STD_LOGIC
	);
end component;
					 
component C7_FINAL
	port(  	 
		INC, DEC: in STD_LOGIC;		  
		EN: in STD_LOGIC_VECTOR(1 downto 0);	   
		
		Q:inout STD_LOGIC_VECTOR(7 downto 0)
	);
end component;	 

component C8_FINAL
	
	port(
		SEL: in STD_LOGIC_VECTOR(1 downto 0);	
		W	: in STD_LOGIC_VECTOR(11 downto 0);-- SEL = 00 AFISAM DIN MEMORIA DE BANI
		DIST: in STD_LOGIC_VECTOR(15 downto 0);-- SEL = 01 AFISAM DIN C3	
		TK  : in STD_LOGIC_VECTOR(7  downto 0);-- SEL = 10 AFISAM DIN C6	 
		
		X  : out STD_LOGIC_VECTOR(11 downto 0)
	);
	
end component;

component C9_FINAL
	port(  	 
		INC1, DEC1: in STD_LOGIC;		  
		SEL: in STD_LOGIC_VECTOR(4 downto 0);	   
		
		Q1:inout STD_LOGIC_VECTOR(7 downto 0); 
		Q2:inout STD_LOGIC_VECTOR(7 downto 0);
		Q3:inout STD_LOGIC_VECTOR(7 downto 0);
		Q4:inout STD_LOGIC_VECTOR(7 downto 0);
		Q5:inout STD_LOGIC_VECTOR(7 downto 0)
	);
end component;

component C10_FINAL
	port(
		SEL: in STD_LOGIC_VECTOR(1 downto 0);
		A1, A2, A3, A4, A5:in STD_LOGIC_VECTOR (7 downto 0);---BANI DE BAGAT IN MEMORIE
		B1, B2, B3, B4, B5:in STD_LOGIC_VECTOR (7 downto 0);---BANI DE SCOS DIN MEMORIE
		C1, C2, C3, C4, C5:in STD_LOGIC_VECTOR (7 downto 0);---BANI DEJA IN MEMORIE  
		Q1, Q2, Q3, Q4, Q5: out STD_LOGIC_VECTOR(7 downto 0)
	);
end component;

component C11_ALU_SUM
	port(
		EN: in STD_LOGIC;
		A1, A2, A3, A4, A5:in STD_LOGIC_VECTOR (7 downto 0);  	 
		Q:out STD_LOGIC_VECTOR(11 downto 0)
	);
end component; 

component C12_FINAL
  	port(
		SEL:in STD_LOGIC_VECTOR(1 downto 0);	 	  
		A1, A2, A3, A4, A5:in STD_LOGIC_VECTOR (7 downto 0);--BB 
		B1, B2, B3, B4, B5:in STD_LOGIC_VECTOR (7 downto 0);--REST
		D1, D2, D3, D4, D5:in STD_LOGIC_VECTOR (7 downto 0);--BD	 								  
		Q1, Q2, Q3, Q4, Q5:out STD_LOGIC_VECTOR(7 downto 0)
	);
end component;	

component C13_FINAL
	port(		 
		X  : in STD_LOGIC_VECTOR(11 downto 0);
		Y  : out STD_LOGIC_VECTOR(11 downto 0)
	);
end component;



signal X: STD_LOGIC_VECTOR(7 downto 0);--SUMA INTRODUSA IN C4  
signal REST1, REST2, REST3, REST4, REST5: STD_LOGIC_VECTOR(7 downto 0);	 
signal BANI_M1, BANI_M2, BANI_M3, BANI_M4, BANI_M5: STD_LOGIC_VECTOR(7 downto 0);
signal BD1, BD2, BD3, BD4, BD5: STD_LOGIC_VECTOR(7 downto 0);--BANI MEMORIE
signal BB1, BB2, BB3, BB4, BB5: STD_LOGIC_VECTOR(7 downto 0);--BANI INTRODUSI	  	 

signal A1, A2, A3, A4, A5: STD_LOGIC_VECTOR(7 downto 0);--IESIRE C12 (spre selector)	 

signal REZ1, REZ2, REZ3, REZ4, REZ5: STD_LOGIC_VECTOR(7 downto 0);--IESIRE C10 (intrare PL C2)

												   
signal TK: STD_LOGIC_VECTOR(7 downto 0);--IESIRE C6
signal W: STD_LOGIC_VECTOR(11 downto 0);--IESIRE C11
signal DIST: STD_LOGIC_VECTOR(15 downto 0);---IESIRE C3	 
signal AFIS1, AFIS2: STD_LOGIC_VECTOR(11 downto 0);

begin	
	
	C1: C1_AFIS port map(
		'1',CLK,
		AFIS2,
		CATOD,
		ANOD
	
	);
	
	C2 : C2_FINAL port map(
		INC, DEC,
		SEL_2,
		REZ1, REZ2, REZ3, REZ4, REZ5,
		BD1, BD2, BD3, BD4, BD5
	);
	
	C3 : C3_DIST_CALC port map(
		X,
		DIST   
	);
	
	C4 : C4_FINAL port map(
		EN_4(0), CLK,
		X,
		BD1, BD2, BD3, BD4, BD5,
		BB1, BB2, BB3, BB4, BB5,
		OK_4, REST_POS,
		REST1, REST2, REST3, REST4, REST5,
		BANI_M1, BANI_M2, BANI_M3, BANI_M4, BANI_M5
	);   
	
	C6: C6_FINAL port map(
		INC, DEC,
		EN_6, 
		TK,
		OK_6
		
	);	   
	
	C7: C7_FINAL port map(
		INC, DEC,
		EN_7,
		X
	);
	
	C8: C8_FINAL port map(
		SEL_8,
		W,
		DIST,
		Tk,
		AFIS1
	);
	
	C9: C9_FINAL port map(
		INC, DEC,
		SEL_9,	  
		BB1, BB2, BB3, BB4, BB5
	);
	
	C10: C10_FINAL port map(
		EN_10,
		BANI_M1, BANI_M2, BANI_M3, BANI_M4, BANI_M5,
		REST1, REST2, REST3, REST4, REST5,	   	
		BD1, BD2, BD3, BD4, BD5
	);
	
	C11: C11_ALU_SUM port map(
		'1',
		A1, A2, A3, A4, A5,
		W
	);
	
	C12: C12_FINAL port map(
		SEL_12,
		BD1, BD2, BD3, BD4, BD5,
		REST1, REST2, REST3, REST4, REST5,
		BB1, BB2, BB3, BB4, BB5,
		A1, A2, A3, A4, A5
	);
	
	C13: C13_FINAL port map(
		AFIS1,
		AFIS2
	);

end architecture;