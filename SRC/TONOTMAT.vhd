library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity TONOMAT_BILETE_V4 is 
	
	port(
		CLK:in STD_LOGIC;
		OK: in STD_LOGIC; 	
		NOK: in STD_LOGIC;
		INC: in STD_LOGIC;
		DEC: in STD_LOGIC;	 
		SHUT_DOWN: in STD_LOGIC;
		SEL: in STD_LOGIC_VECTOR(4 downto 0);	
		
		ERR_T: out STD_LOGIC;
		ERR_R: out STD_LOGIC; 
		
		INT_M: out STD_LOGIC;
		INT_T: out STD_LOGIC; 
		INT_D: out STD_LOGIC;  	   
		
		UTILIZ: out STD_LOGIC;	
		ADMIN: out STD_LOGIC;
		ELIB_REST: out STD_LOGIC;
		ELIB_BIL: out STD_LOGIC;
								 				   
		CATOD: out STD_LOGIC_VECTOR(0 to 6);
		ANOD : out STD_LOGIC_VECTOR(0 to 3)
	);
	
end entity;	

architecture FINAL_COMPONENT of TONOMAT_BILETE_V4 is

component DEBOUNCER
	generic(
	    CLK_FREQ    : INTEGER := 450000000;---freq placa BASYS3 
	    ST : INTEGER := 10
	);	
	
	port(	
	    CLK     : in  STD_LOGIC;
	    RST 	: in  STD_LOGIC;  
	    BT  	: in STD_LOGIC;  
	    REZ  	: out STD_LOGIC
	);
end component;

component UC_TONOMAT_BILETE_V1 
	 port(
		SEL: in STD_LOGIC_VECTOR(4 downto 0);
		OK:  in STD_LOGIC;
		NOK: in STD_LOGIC;
		INC: in STD_LOGIC;
		DEC: in STD_LOGIC;	 
		SHUT_DOWN: in STD_LOGIC;
		CLK: in STD_LOGIC;
		
		REST_POS: in STD_LOGIC;
		OK_6: in STD_LOGIC;
		OK_4: in STD_LOGIC;
		
		CLK_O: out STD_LOGIC;
		INC_O: out STD_LOGIC;
		DEC_O: out STD_LOGIC; 
		ERR_T: out STD_LOGIC;
		ERR_R: out STD_LOGIC; 
		
		INT_M: out STD_LOGIC;
		INT_T: out STD_LOGIC; 
		INT_D: out STD_LOGIC;	
		
		UTILIZ: out STD_LOGIC;	
		ADMIN: out STD_LOGIC;
		ELIB_REST: out STD_LOGIC;
		ELIB_BIL: out STD_LOGIC;
		
		EN_2, EN_4, EN_6, EN_7, SEL_8, EN_9, EN_10, SEL_12:out STD_LOGIC_VECTOR(1 downto 0);
		SEL_2, SEL_9:out STD_LOGIC_VECTOR(4 downto 0) 
	);
end component;	 

component UE_TONOMAT_BILETE_V1	   
	
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
	
end component;

signal REST_POS, OK_6, OK_4: STD_LOGIC;
signal CLK_O, INC_O, DEC_O: STD_LOGIC;	  
signal EN_2, EN_4, EN_6, EN_7, SEL_8, EN_9, EN_10, SEL_12: STD_LOGIC_VECTOR(1 downto 0); 
signal SEL_2, SEL_9: STD_LOGIC_VECTOR(4 downto 0);
signal OK_D, NOK_D, INC_D, DEC_D, SHUT_DOWN_D :STD_LOGIC;

begin  
	
C_OK	   : DEBOUNCER port map(CLK, '1', OK, OK_D);
C_NOK      : DEBOUNCER port map(CLK, '1', NOK, NOK_D);
C_SHUT_DOWN: DEBOUNCER port map(CLK, '1', SHUT_DOWN, SHUT_DOWN_D);
C_INC	   : DEBOUNCER port map(CLK, '1', INC, INC_D);
C_DEC	   : DEBOUNCER port map(CLK, '1', DEC, DEC_D);
	
C1: UC_TONOMAT_BILETE_V1 port map( 
	---intrare
	SEL, OK_D, NOK_D, INC_D, DEC_D, SHUT_DOWN_D, CLK,
	REST_POS, OK_6, OK_4,		 
	
	---conectivitate
	CLK_O, INC_O, DEC_O,
	
	--iesire
	ERR_T, ERR_R,
	INT_M, INT_T, INT_D,   
	UTILIZ, ADMIN, ELIB_REST, ELIB_BIL,
	
	---conectivitate
	EN_2, EN_4, EN_6, EN_7, SEL_8, EN_9, EN_10, SEL_12, SEL_2, SEL_9
);


C2: UE_TONOMAT_BILETE_V1 port map(
	CLK_O, INC_O, DEC_O,
	EN_2, SEL_2,
	EN_4,
	EN_6,
	EN_7,
	SEL_8,
	EN_9,
	SEL_9,
	EN_10,
	SEL_12,
	CATOD, ANOD,
	OK_4, REST_POS, OK_6
);

end architecture;


