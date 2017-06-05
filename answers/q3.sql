/* https://blog.fedecarg.com/2009/02/22/mysql-split-string-function/ */
DROP FUNCTION IF EXISTS SPLIT_STR;
CREATE FUNCTION SPLIT_STR(
  x VARCHAR(255),
  delim VARCHAR(12),
  pos INT
)
RETURNS VARCHAR(255)
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, '');

DROP TABLE IF EXISTS result;
CREATE TABLE result ( ID INT, NAME VARCHAR(50) );

DELIMITER $$

DROP FUNCTION IF EXISTS func;
CREATE FUNCTION func () RETURNS INT
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE _id1 INT;
    DECLARE _name1 varchar(50);
    DECLARE _aux varchar(50);
    DECLARE _counter INT;

    DECLARE CURSOR_sometbl CURSOR FOR 
        SELECT ID, NAME 
        FROM sometbl;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE; 

    OPEN CURSOR_sometbl;

    read_loop: LOOP
        FETCH CURSOR_sometbl into _id1, _name1;
        IF done THEN  LEAVE read_loop; END IF;
 
        SET _counter=1;


        SET _aux= SPLIT_STR(_name1, '|', _counter); 
        WHILE CHAR_LENGTH(_aux) >0 DO
            INSERT INTO result VALUES (_id1, _aux);
            SET _counter = _counter +1;
            SET _aux= SPLIT_STR(_name1, '|', _counter); 
        END WHILE;
        
    END LOOP;
    CLOSE CURSOR_sometbl;
    RETURN 1;
END$$

DELIMITER ;

SELECT func();
SELECT * FROM result;




