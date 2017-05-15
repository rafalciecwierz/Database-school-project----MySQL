--OD TERAZ SĄ TYLKO WIDOKI
--PIERWSZY WIDOK: Z kim najczęsciej współpracujemy
create view TOP_KONTRAHENT as
SELECT TOP(5) k.ID,k.Nazwa,k.nr_kontakt, count(k.ID) as "Ile razy podjelismy wspolprace" FROM Kontrahent as k
LEFT JOIN Zamowienie as z
ON  k.ID=z.ID_kontrahenta
GROUP BY k.Nazwa,k.ID,k.nr_kontakt
ORDER BY 4 DESC
--------------wersja krzysztofa-------
CREATE VIEW rap_top_kontr as
	select top(5) count(k.id) as 'ilość zleceń od firmy',k.Nazwa  from zamowienie z right join kontrahent k on z.ID_kontrahenta = k.ID 
	group by k.Nazwa
	order by 1 desc

  
  
  --DRUGIE ZAPYTANIE: Z JAKICH PORTÓW NAJCZĘŚCIEJ KORZYSTAMY
CREATE VIEW TOP_PORTY as 
	SELECT top(5) count(z.ID_portkoniec) as "Ile razy wystąpił port w zamówieniu", p.Nazwa FROM Port as p
	LEFT JOIN Zamowienie as z
	ON  p.ID=z.ID_portkoniec OR p.ID=z.ID_portpoczat
	GROUP BY P.Nazwa
	ORDER BY 1 DESC

--TRZECIE ZAPYTANIE: JAKI TOWAR WAZY NAJWIECEJ BIORĄC POD UWAGĘ ŻE BARKA MA ZAWSZE OBJĘTOŚĆ 300M3
CREATE VIEW TOP	 as 
  SELECT TOP(5) CAST(count(t.ID)*t.WagaNaM3*300 as INT)  as "Waga towaru w tonach",t.Nazwa FROM Towar as t
	LEFT JOIN Zamowienie as z 
	ON t.ID=z.ID_barki
	GROUP BY t.Nazwa,t.WagaNaM3 
	ORDER BY 1 DESC

--CZWARTE ZAPYTANIE: Lista 5 kontrahentów, na których zarobiliśmy najwięcej
CREATE view rap_top_zarobki_kontr as
	Select top(5) SUM(z.cena) as 'Zyski z kontrahentów w szeklach', k.nazwa from Kontrahent k left join Zamowienie z 
	on k.ID=z.ID_kontrahenta
	group by k.Nazwa
	order by 1 DESC


--PIĄTE ZAPYTANIE: NAJAKTYWNIEJSI PRACOWNICY
CREATE VIEW rap_top_aktyw_prac as
SELECT TOP(5) count(p.ID) as "Ile razy brał udział w zamówieniu", p.Imie,p.Nazwisko,p.Stanowisko FROM Pracownik as p
JOIN Udzial as u
ON  p.ID=u.ID_prac
JOIN Zamowienie as z
ON z.ID=u.ID_zam
GROUP BY p.ID,p.Imie,p.Nazwisko,p.Stanowisko
ORDER BY 1 DESC
