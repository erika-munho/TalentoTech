USE chinook;

-- 1.	Ejecutar y revisar el resultado de las siguientes consultas: 

SELECT * FROM Invoice;

SELECT * FROM Employee;

SELECT BILLINGCOUNTRY,
  	COUNT(INVOICEID)
  FROM INVOICE
  GROUP BY 1  ORDER BY 2 DESC;
  
  -- 2.	¿Qué país tiene más facturas?   Estados Unidos 91
  
  -- 3. punto  3.	Se quiere promocionar un nuevo festival musical, para ello es necesario saber 
  -- en qué ciudad  hay mas facturas (invoices) . determinar en qué ciudad la suma de facturas es la mayor. 
  
SELECT BILLINGCITY,
  	SUM(TOTAL) AS SUMATOTALFACTURAS
  FROM INVOICE
  GROUP BY 1  ORDER BY 2 DESC;
  
  
-- 4. Arroja el id y nombre del cliente q mas ha gastado

SELECT c.CustomerId, c.FirstName, c.LastName, SUM(i.Total) AS TotalGastado
FROM invoice i
INNER JOIN customer c ON i.CustomerId = c.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName
ORDER BY TotalGastado DESC
LIMIT 1;

-- 5. Obtener una tabla con el correo, nombre y apellido 
-- de todos las personas que escuchan Rock. Retornar la lista por orden alfabético

USE chinook;

SELECT DISTINCT c.Email AS Correo, c.FirstName AS Nombre, c.LastName AS Apellido FROM customer c
INNER JOIN invoice i ON c.CustomerId = i.CustomerId
INNER JOIN invoiceline il ON i.InvoiceId = il.InvoiceId
INNER JOIN track t ON il.TrackId = t.TrackId
INNER JOIN genre g ON t.GenreId = g.GenreId
WHERE g.Name = "Rock"
ORDER BY c.FirstName ASC;

-- 6. Sacar una lista con todos los artistas que generan música rock

SELECT DISTINCT a.Name FROM artist a
INNER JOIN album al ON a.ArtistId = al.ArtistId
INNER JOIN track t ON al.AlbumId = t.AlbumId
INNER JOIN genre g ON t.GenreId = g.GenreId
WHERE g.Name = "rock";

-- 7.	Encontrar cual es el artista que más ha ganado de acuerdo al campo invoiceLines.

SELECT * FROM invoiceline;

SELECT a.Name, SUM(il.UnitPrice) AS TotalGanado from invoiceline il 
INNER JOIN track t ON il.trackId = t.trackId
INNER JOIN album al ON t.albumId = al.albumId
INNER JOIN artist a ON al.artistId = a.artistId
GROUP BY a.Name
ORDER BY TotalGanado DESC
LIMIT 1;

-- 8.	Encontrar cuanto gastaron en total en estados unidos en compras

SELECT * FROM invoice;

SELECT i.BillingCountry, SUM(i.Total) AS TotalGAstado FROM invoice i
WHERE i.BillingCountry = "USA";

-- 9.	Encontrar cuánto gastaron los usuarios por género.

SELECT g.Name, SUM(i.Total) as TotalGastado FROM invoice i
INNER JOIN invoiceline il ON i.invoiceId = il.invoiceId
INNER JOIN track t ON il.trackId = t.trackId
INNER JOIN genre g ON t.genreId = g.genreId
GROUP BY g.Name
ORDER BY TotalGastado DESC;

-- 10.	Generar una tabla con el conteo de usuarios por cada país.

SELECT c.Country, COUNT(c.CustomerId) AS ConteodUsuarios FROM customer c
GROUP BY c.Country
ORDER BY ConteodUsuarios DESC;


-- 11.	Encontrar cuantas canciones hay por cada género.

SELECT * FROM genre;

SELECT g.Name, COUNT(t.TrackId) AS NumerodeCanciones FROM track t
INNER JOIN genre g ON t.genreId = g.genreId
GROUP BY g.Name
ORDER BY NumerodeCanciones DESC;

-- canciones por genero
SELECT t.Name, g.Name FROM track t
INNER JOIN genre g ON t.genreId = g.genreId 
WHERE g.Name = "metal";
