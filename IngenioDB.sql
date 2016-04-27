CREATE DATABASE [Ingenio_DB]
USE [Ingenio_DB]



--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [dbo].[Category](
--	[Category] [int] NOT NULL,
--	[ParentCategoryID] [int] NULL,
--	[Name] [nchar](50) NULL,
--	[KeyWords] [nchar](10) NULL,
-- CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
--(
--	[Category] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]

--GO
 
 ----- INSERTED RECORDS AS PER THE DATASET



--Category	ParentCategoryID	Name	KeyWords
--100	-1	Business                                          	Money     
--101	100	Accounting                                        	Taxes     
--102	100	Taxation                                          	NULL
--103	101	Corporate Tax                                     	NULL
--109	101	Small Business Tax                                	NULL
--200	-1	Tutoring                                          	Teaching  
--201	200	Computer                                          	NULL
--202	201	Operating System                                  	NULL



/***usp_GetCategoryInfoByCategoryID SP  return the records of CategoryInfo *******
Recursive CTE is repeatedly executed to return the category of data until the complete result set is obtained  cte terminates if previous keyword is null**/



CREATE PROCEDURE dbo.usp_GetCategoryInfoByCategoryID
(
@CategoryID INT  
)
AS BEGIN
;WITH CTE AS (
		   SELECT CategoryId, ParentCategoryID, Name, Keywords
		   FROM Category
		   WHERE CategoryId = @CategoryID

		   UNION ALL

		   SELECT c1.CategoryId, c1.ParentCategoryId, c1.Name, c1.Keywords
		   FROM Category AS c1
		   INNER JOIN CTE AS c2 ON c1.CategoryId = c2.ParentCategoryId  
		   WHERE c1.Keywords IS NOT NULL 
)
				SELECT *
				FROM CTE
				END
GO

----Input  201

EXEC  dbo.usp_GetCategoryInfoByCategoryID 201


--CategoryId	ParentCategoryID	Name	Keywords
--201	200	Computer                                          	NULL
--200	-1	Tutoring                                          	Teaching  


----Input  202

EXEC  dbo.usp_GetCategoryInfoByCategoryID 202
--Output


--CategoryId	ParentCategoryID	Name	Keywords
--202	201	Operating System                                  	NULL



CREATE PROCEDURE dbo.usp_GetNameoftheCategoryByCategorylevel
(
@catlevel INT  
)
AS BEGIN


;WITH CTE AS ( 
   SELECT CategoryId, ParentCategoryId, Name, Keywords, level = 1
   FROM Category
   WHERE ParentCategoryId = -1
   UNION ALL   
   SELECT c1.CategoryId, c1.ParentCategoryId, 
          c1.Name, c1.Keywords, level = c2.level + 1
   FROM Category AS c1
   INNER JOIN CTE AS c2 ON c1.ParentCategoryId   = c2.CategoryId
   WHERE c2.level < @catlevel 
)
SELECT CategoryId
FROM CTE
WHERE level = @catlevel
END

---Input 2

EXEC dbo.usp_GetNameoftheCategoryByCategorylevel 2

--Output
--CategoryId
--201
--101
--102