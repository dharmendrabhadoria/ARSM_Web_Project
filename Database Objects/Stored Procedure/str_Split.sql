  
CREATE FUNCTION [dbo].[str_Split](@String nvarchar(4000), @Delimiter char(1))  
RETURNS @Results TABLE (Items nvarchar(4000))  
AS  
BEGIN  
 DECLARE @INDEX INT=1  
 DECLARE @SLICE nvarchar(4000)  
 WHILE @INDEX !=0  
 BEGIN  
  SELECT @INDEX = CHARINDEX(@Delimiter,@STRING)  
  IF @INDEX !=0  
  SELECT @SLICE = LEFT(@STRING,@INDEX - 1)  
  ELSE  
  SELECT @SLICE = @STRING  
  INSERT INTO @Results(Items) VALUES(@SLICE)  
  SELECT @STRING = RIGHT(@STRING,LEN(@STRING) - @INDEX)  
 IF LEN(@STRING) = 0  
 BREAK  
END  
RETURN  
END  
  
---select * from [dbo].[str_Split]('1,2,3',',')  