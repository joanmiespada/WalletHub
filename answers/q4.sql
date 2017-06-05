DROP TABLE IF EXISTS bugsystems;
CREATE TABLE bugsystems (   ID int NOT NULL, 
                            name_bug varchar(50) NOT NULL,
                            open_date datetime NOT NULL DEFAULT NOW(), 
                            close_date datetime ,
                            severity int,  
                            PRIMARY KEY (ID) );

DELIMITER $$

CREATE TRIGGER beforeinsertBugsystems BEFORE INSERT ON bugsystems
FOR EACH ROW
BEGIN
    If NEW.close_date IS NOT NULL THEN
        If NEW.close_date < NEW.open_date THEN       
            signal sqlstate '45000';           
        END IF;
    END IF;
END;

CREATE TRIGGER beforeupdateBugsystems BEFORE UPDATE ON bugsystems
FOR EACH ROW
BEGIN
    If NEW.close_date IS NOT NULL THEN
        If NEW.close_date < NEW.open_date THEN       
            signal sqlstate '45000';           
        END IF;
    END IF;
END;$$

DELIMITER ;

INSERT INTO bugsystems VALUES
(1,'error1', '2017/11/01', '2017/11/02', 10 ),
(2,'error2', '2017/11/01', '2017/11/02', 10 ),
(3,'error3', '2017/11/01', '2017/11/02', 10 ),
(4,'error4', '2017/11/01', '2017/11/03', 10 ),
(5,'error5', '2017/11/01', '2017/11/03', 10 ),
(6,'error6', '2017/11/01', '2017/11/04', 10 ),
(7,'error7', '2017/11/01', '2017/11/05', 10 ),
(8,'error8', '2017/11/02', NULL, 9),
(9,'error9', '2017/11/02', NULL, 9),
(10,'error10', '2017/11/02','2017/11/02' , 9),
(11,'error11', '2017/11/02','2017/11/02', 9),
(12,'error12', '2017/11/03','2017/11/04' , 9),
(13,'error13', '2017/11/03','2017/11/05', 9);

SELECT COUNT(ID) as num, open_date ,close_date
FROM bugsystems
GROUP BY open_date,close_date;


                            

//



