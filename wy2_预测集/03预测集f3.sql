DROP TABLE IF EXISTS wy2_f3_t1;
CREATE TABLE wy2_f3_t1 AS 
SELECT user_id ,item_id,
SUM(doview) AS user_item_totaldays_view_total ,SUM(dofavor) AS user_item_totaldays_favor_total, SUM(doaddcar) AS user_item_totaldays_addcar_total , SUM(dobuy) AS user_item_totaldays_buy_total
FROM user_item_detail 
WHERE dodate>=to_date("2014-11-19","yyyy-mm-dd") AND dodate<=to_date("2014-12-18","yyyy-mm-dd") 
GROUP BY user_id,item_id;

DROP TABLE IF EXISTS wy2_f3_t2;
CREATE TABLE wy2_f3_t2 AS 
SELECT user_id ,item_id,
SUM(doview) AS user_item_last1week_view_total ,SUM(dofavor) AS user_item_last1week_favor_total, SUM(doaddcar) AS user_item_last1week_addcar_total , SUM(dobuy) AS user_item_last1week_buy_total
FROM user_item_detail 
WHERE datediff(to_date("2014-12-18","yyyy-mm-dd"),dodate,"dd")<=7
GROUP BY user_id,item_id;

DROP TABLE IF EXISTS wy2_f3_t3;
CREATE TABLE wy2_f3_t3 AS 
SELECT user_id ,item_id,
SUM(doview) AS user_item_last3days_view_total ,SUM(dofavor) AS user_item_last3days_favor_total, SUM(doaddcar) AS user_item_last3days_addcar_total , SUM(dobuy) AS user_item_last3days_buy_total
FROM user_item_detail 
WHERE datediff(to_date("2014-12-18","yyyy-mm-dd"),dodate,"dd")<=3
GROUP BY user_id,item_id;

DROP TABLE IF EXISTS wy2_f3_t4_1;
CREATE TABLE wy2_f3_t4_1 AS 
SELECT user_id , item_id ,
SUM(doview) AS user_item_last_1_day_view_count ,SUM(dofavor) AS user_item_last_1_day_favor_count, SUM(doaddcar) AS user_item_last_1_day_addcar_count , SUM(dobuy) AS user_item_last_1_day_buy_count
FROM user_item_detail 
WHERE dodate=to_date("2014-12-18","yyyy-mm-dd")
GROUP BY user_id,item_id;

DROP TABLE IF EXISTS wy2_f3_t4_2;
CREATE TABLE wy2_f3_t4_2 AS 
SELECT user_id , item_id,
SUM(doview) AS user_item_last_2_day_view_count ,SUM(dofavor) AS user_item_last_2_day_favor_count, SUM(doaddcar) AS user_item_last_2_day_addcar_count , SUM(dobuy) AS user_item_last_2_day_buy_count
FROM user_item_detail 
WHERE datediff(to_date("2014-12-18","yyyy-mm-dd"),dodate,"dd")=2
GROUP BY user_id,item_id;

DROP TABLE IF EXISTS wy2_f3_t4_3;
CREATE TABLE wy2_f3_t4_3 AS 
SELECT user_id , item_id,
SUM(doview) AS user_item_last_3_day_view_count ,SUM(dofavor) AS user_item_last_3_day_favor_count, SUM(doaddcar) AS user_item_last_3_day_addcar_count , SUM(dobuy) AS user_item_last_3_day_buy_count
FROM user_item_detail 
WHERE datediff(to_date("2014-12-18","yyyy-mm-dd"),dodate,"dd")=3
GROUP BY user_id,item_id;

DROP TABLE IF EXISTS wy2_f3_t5;
CREATE TABLE wy2_f3_t5 AS 
SELECT t.user_id,t.item_id,SUM(t.dawnact) AS user_item_totaldays_dawn_total,SUM(t.amact) AS user_item_totaldays_am_total,SUM(t.pmact) AS user_item_totaldays_pm_total FROM
(SELECT user_id ,item_id, CASE WHEN dohour_type=1 THEN 1 ELSE 0 END AS dawnact,CASE WHEN dohour_type=2 THEN 1 ELSE 0 END AS amact,CASE WHEN dohour_type=3 THEN 1 ELSE 0 END AS pmact
FROM user_item_detail WHERE dodate>=to_date("2014-11-19","yyyy-mm-dd") AND dodate<=to_date("2014-12-18","yyyy-mm-dd") )t
GROUP BY t.user_id , t.item_id;

DROP TABLE IF EXISTS wy2_f3_t6;
CREATE TABLE wy2_f3_t6 AS 
SELECT a.user_id,a.item_id,datediff(to_date("2014-12-19","yyyy-mm-dd"),a.dodate,"dd") AS user_item_firstact_diffdays FROM
(SELECT user_id,item_id,dodate, ROW_NUMBER() OVER (PARTITION BY user_id,item_id ORDER BY dodate) AS num 
FROM user_item_detail WHERE dodate>=to_date("2014-11-19","yyyy-mm-dd") AND dodate<=to_date("2014-12-18","yyyy-mm-dd") ) a
WHERE a.num=1;

DROP TABLE IF EXISTS wy2_f3_t7;
CREATE TABLE wy2_f3_t7 AS 
SELECT a.user_id,a.item_id,datediff(to_date("2014-12-19","yyyy-mm-dd"),a.dodate,"dd") AS user_item_recently_view_diffdays FROM
(SELECT user_id,item_id,dodate, ROW_NUMBER() over (PARTITION BY user_id,item_id ORDER BY dodate DESC) AS num 
FROM user_item_detail WHERE doview=1 AND dodate>=to_date("2014-11-19","yyyy-mm-dd") AND dodate<=to_date("2014-12-18","yyyy-mm-dd") ) a
WHERE a.num=1;

DROP TABLE IF EXISTS wy2_f3_t8;
CREATE TABLE wy2_f3_t8 AS 
SELECT a.user_id,a.item_id,datediff(to_date("2014-12-19","yyyy-mm-dd"),a.dodate,"dd") AS user_item_recently_favor_diffdays FROM
(SELECT user_id,item_id,dodate, ROW_NUMBER() over (PARTITION BY user_id,item_id ORDER BY dodate DESC) AS num 
FROM user_item_detail WHERE dofavor=1 AND dodate>=to_date("2014-11-19","yyyy-mm-dd") AND dodate<=to_date("2014-12-18","yyyy-mm-dd") ) a
WHERE a.num=1;

DROP TABLE IF EXISTS wy2_f3_t9;
CREATE TABLE wy2_f3_t9 AS 
SELECT a.user_id,a.item_id,datediff(to_date("2014-12-19","yyyy-mm-dd"),a.dodate,"dd") AS user_item_recently_addcar_diffdays FROM
(SELECT user_id,item_id,dodate, ROW_NUMBER() over (PARTITION BY user_id,item_id ORDER BY dodate DESC) AS num 
FROM user_item_detail WHERE doaddcar=1 AND dodate>=to_date("2014-11-19","yyyy-mm-dd") AND dodate<=to_date("2014-12-18","yyyy-mm-dd") ) a
WHERE a.num=1;

DROP TABLE IF EXISTS wy2_f3_t10;
CREATE TABLE wy2_f3_t10 AS 
SELECT a.user_id,a.item_id,datediff(to_date("2014-12-19","yyyy-mm-dd"),a.dodate,"dd") AS user_item_recently_buy_diffdays FROM
(SELECT user_id,item_id,dodate, ROW_NUMBER() over (PARTITION BY user_id,item_id ORDER BY dodate DESC) AS num 
FROM user_item_detail WHERE dobuy=1 AND dodate>=to_date("2014-11-19","yyyy-mm-dd") AND dodate<=to_date("2014-12-18","yyyy-mm-dd") ) a
WHERE a.num=1;

DROP TABLE IF EXISTS wy2_f3;
CREATE TABLE wy2_f3 AS 
SELECT u.*,v.user_item_recently_buy_diffdays FROM
(
  SELECT s.*,t.user_item_recently_addcar_diffdays FROM
  (
	SELECT q.*,r.user_item_recently_favor_diffdays FROM
	(
	  SELECT o.*,p.user_item_recently_view_diffdays FROM
	  (
		SELECT m.*,n.user_item_firstact_diffdays FROM
		(
		  SELECT k.*,l.user_item_totaldays_dawn_total,l.user_item_totaldays_am_total,l.user_item_totaldays_pm_total FROM
		  (
			SELECT i.*,j.user_item_last_3_day_view_count,j.user_item_last_3_day_favor_count,j.user_item_last_3_day_addcar_count,j.user_item_last_3_day_buy_count FROM
			(
			  SELECT g.*,h.user_item_last_2_day_view_count,h.user_item_last_2_day_favor_count,h.user_item_last_2_day_addcar_count,h.user_item_last_2_day_buy_count FROM
			  (
				SELECT e.*,f.user_item_last_1_day_view_count,f.user_item_last_1_day_favor_count,f.user_item_last_1_day_addcar_count,f.user_item_last_1_day_buy_count FROM
				(
				  SELECT c.*,d.user_item_last3days_view_total,d.user_item_last3days_favor_total,d.user_item_last3days_addcar_total,d.user_item_last3days_buy_total FROM
				  (
					SELECT a.*,b.user_item_last1week_view_total,b.user_item_last1week_favor_total,b.user_item_last1week_addcar_total,b.user_item_last1week_buy_total FROM
					wy2_f3_t1 a LEFT OUTER JOIN wy2_f3_t2 b
					ON a.user_id=b.user_id AND a.item_id=b.item_id
				  ) c
				  LEFT OUTER JOIN wy2_f3_t3 d
				  ON c.user_id=d.user_id AND c.item_id=d.item_id
				) e
				LEFT OUTER JOIN wy2_f3_t4_1 f
				ON e.user_id=f.user_id AND e.item_id=f.item_id
			  ) g
			  LEFT OUTER JOIN wy2_f3_t4_2 h
			  ON g.user_id=h.user_id AND g.item_id=h.item_id
			) i
			LEFT OUTER JOIN wy2_f3_t4_3 j
			ON i.user_id=j.user_id AND i.item_id=j.item_id
		  ) k
		  LEFT OUTER JOIN wy2_f3_t5 l
		  ON k.user_id=l.user_id AND k.item_id=l.item_id
		) m
		LEFT OUTER JOIN wy2_f3_t6 n
		ON m.user_id=n.user_id AND m.item_id=n.item_id
	  ) o
	  LEFT OUTER JOIN wy2_f3_t7 p
	  ON o.user_id=p.user_id AND o.item_id=p.item_id
	) q
	LEFT OUTER JOIN wy2_f3_t8 r
	ON q.user_id=r.user_id AND q.item_id=r.item_id
  ) s
  LEFT OUTER JOIN wy2_f3_t9 t
  ON s.user_id=t.user_id AND s.item_id=t.item_id
) u
LEFT OUTER JOIN wy2_f3_t10 v
ON u.user_id=v.user_id AND u.item_id=v.item_id;