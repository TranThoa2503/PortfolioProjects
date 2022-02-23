USE portfolio;

SELECT *
FROM vgsales
ORDER BY 1,2


-- 1. 
-- doanh thu qua các năm
SELECT year, 
		ROUND(SUM(global_sales),2) AS global_sales,
		ROUND(SUM(NA_Sales),2) AS NA_Sales,
		ROUND(SUM(EU_Sales),2) AS EU_Sales,
        ROUND(SUM(JP_Sales),2) AS JP_Sales,
        ROUND(SUM(Other_Sales),2) AS Other_Sales
FROM vgsales
GROUP BY year
ORDER BY year
-- --> từ năm 1980 -> 2009 sale tăng liên tục, từ năm 2010 có xu hướng giảm mạnh

-- 2.
-- doanh thu của từng loại theo từng khu vực
SELECT genre,
		ROUND(SUM(global_sales),2) AS global_sales_by_genre,
        ROUND(SUM(EU_Sales),2) AS EU_sales_by_genre,
        ROUND(SUM(NA_Sales),2) AS NA_sales_by_genre,
        ROUND(SUM(JP_Sales),2) AS JP_sales_by_genre
FROM vgsales
GROUP BY genre
ORDER BY global_sales_by_genre DESC


-- 3. 
-- top 5 platform phổ biến nhất
WITH global_sales_by_flatform AS 
(
	SELECT platform, ROUND(SUM(global_sales),2) AS platform_global_sales
	FROM vgsales
	GROUP BY platform
)

SELECT 	platform, 
		platform_global_sales, 
		(platform_global_sales/(SELECT SUM(platform_global_sales) FROM global_sales_by_flatform)) * 100 AS percentage
FROM global_sales_by_flatform
ORDER BY platform_global_sales DESC
LIMIT 5 
-- --> top 5 gồm: PS2, X360, PS3, Wii, DS chiếm hơn 50% tổng doanh thu trên thế giới

                                
-- 4. 
-- top 10 publisher có doanh thu cao nhất
SELECT publisher, ROUND(SUM(global_sales),2) AS global_sales
FROM vgsales
GROUP BY publisher
ORDER BY SUM(global_sales) DESC
LIMIT 10 -- -> 3 publisher đứng đầu là Nintendo, Electronic Arts, Activision

-- top 10 game phổ biến nhất
SELECT name, publisher, ROUND(SUM(global_sales),2) AS global_sales
FROM vgsales
GROUP BY name
ORDER BY SUM(global_sales) DESC
LIMIT 10 
/* top 10 game nổi tiếng nhất thuộc Nintendo, Take_Two Interactive, Activision
--> không có của Electronic Arts
*/

SELECT name, ROUND(SUM(global_sales),2) AS Electronic_global_sales
FROM vgsales
WHERE publisher = "Electronic Arts"
GROUP BY name
ORDER BY Electronic_global_sales DESC
-- -> do series FIFA qua các năm

SELECT name, ROUND(SUM(global_sales),2) AS FIFA_global_sales
FROM vgsales
WHERE publisher = "Electronic Arts" AND
		name REGEXP 'FIFA'
GROUP BY name WITH ROLLUP
ORDER BY FIFA_global_sales DESC
-- -> series game FIFA: 171.36











