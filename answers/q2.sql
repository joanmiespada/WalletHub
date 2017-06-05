
DROP TABLE IF EXISTS capitalize;
create table capitalize(ID int, textIn varchar(100));
INSERT into capitalize VALUES
(1,'WE KNOW wHaT we ARE, but know NOT wHAT We May Be.'), 
(2,'A foOL thinks HIMSELF tO BE WIse. A WiSe MAN knoWS Himself to be A Fool.'), 
(3,'when a father gives to his-son, both lAUgh; WHEN a son gives to his FAther, both CRY'), 
(4,'  If music be the FOod of love, pLAy on.'), 
(5,'tHEre is nothing EIther GOOD! or BAD! but tHInking makes it so.'), 
(6,'tO be, or not to be, IS that tHE QuEsTiOn? ... then not to be');


/*
I've created a simple state machine with 3 states. Also, I've used a simple function ChangeState to 
clarify the code. 
States: 
 0= starting word
 1= BeginWord found! then capitalize
 2= MiddleWord = ignore
 */

DROP FUNCTION IF EXISTS changeState;
DELIMITER $$
CREATE FUNCTION `changeState`(_s CHAR, _currentstate INT) RETURNS INT 
BEGIN
  
  CASE _currentstate
    WHEN  0 THEN   
        BEGIN 
            IF _s REGEXP '[a-zA-Z]' THEN 
                return 1;
            ELSE /*IF _s = ' ' THEN */
                return 0;
            END IF;
        END;
    WHEN 2 THEN
        BEGIN
            IF _s = ' ' THEN 
                return 0;
            ELSE 
                return 2;
            END IF;
        END;
    ELSE
        return -1;
  END CASE;

END$$

DELIMITER ;

/*SELECT changeState('a',0); */



DROP FUNCTION IF EXISTS initcap;
DELIMITER $$
CREATE FUNCTION `initcap`(s varchar(255)) RETURNS varchar(255) 
BEGIN
  
  DECLARE _leng,_currIndex INT;
  DECLARE _currentSymbol CHAR;
  DECLARE _resultString varchar(255);
  DECLARE _stateMachine INT;

  SET _leng = CHAR_LENGTH(s);
  SET _resultString = '';
  SET _stateMachine = 0;

  SET _currIndex = 1;
  WHILE(_currIndex <= _leng) DO
    SET _currentSymbol = SUBSTRING(s,_currIndex,1); 
    SET _stateMachine = changeState(_currentSymbol, _stateMachine);

    IF (_stateMachine = 1 ) THEN
        SET _currentSymbol =  UPPER(_currentSymbol); 
        SET _stateMachine = 2;
    ELSE
        SET _currentSymbol =  LOWER(_currentSymbol);
    END IF;

    IF (_currentSymbol = ' ') THEN
        SET _resultString =  CONCAT(_resultString,' '); /*it's necessary to keep empty spaces*/
    ELSE
        SET _resultString =  CONCAT(_resultString, _currentSymbol);

    END IF;
    SET _currIndex = _currIndex + 1;
  END WHILE;

  return _resultString;

END$$

DELIMITER ;

SELECT  initcap(textIn) FROM capitalize;

 