DROP TABLE IF EXISTS wy2_f2_t1;
CREATE TABLE wy2_f2_t1 AS
SELECT item_id , 
SUM(doview) AS item_totaldays_view_total ,SUM(dofavor) AS item_totaldays_dofavor_total, SUM(doaddcar) AS item_totaldays_addcar_total , SUM(dobuy) AS item_totaldays_dobuy_total
FROM user_item_detail 
WHERE dodate>=to_date("2014-11-19","yyyy-mm-dd") AND dodate<=to_date("2014-12-18","yyyy-mm-dd") 
GROUP BY item_id;

DROP TABLE IF EXISTS wy2_f2_t2;
CREATE TABLE wy2_f2_t2 AS 
SELECT item_id , 
SUM(doview) AS item_last1week_view_total ,SUM(dofavor) AS item_last1week_favor_total, SUM(doaddcar) AS item_last1week_addcar_total , SUM(dobuy) AS item_last1week_buy_total
FROM user_item_detail 
WHERE datediff(to_date("2014-12-18","yyyy-mm-dd"),dodate,"dd")<=7
GROUP BY item_id;

DROP TABLE IF EXISTS wy2_f2_t3;
CREATE TABLE wy2_f2_t3 AS 
SELECT item_id , 
SUM(doview) AS item_last3days_view_total ,SUM(dofavor) AS item_last3days_favor_total, SUM(doaddcar) AS item_last3days_addcar_total , SUM(dobuy) AS item_last3days_buy_total
FROM user_item_detail 
WHERE datediff(to_date("2014-12-18","yyyy-mm-dd"),dodate,"dd")<=3
GROUP BY item_id;

DROP TABLE IF EXISTS wy2_f2_t4_1;
CREATE TABLE wy2_f2_t4_1 AS 
SELECT item_id ,
SUM(doview) AS item_last_1_day_view_count ,SUM(dofavor) AS item_last_1_day_favor_count, SUM(doaddcar) AS item_last_1_day_addcar_count , SUM(dobuy) AS item_last_1_day_buy_count
FROM user_item_detail 
WHERE dodate=to_date("2014-12-18","yyyy-mm-dd")
GROUP BY item_id;

DROP TABLE IF EXISTS wy2_f2_t4_2;
CREATE TABLE wy2_f2_t4_2 AS 
SELECT item_id , 
SUM(doview) AS item_last_2_day_view_count ,SUM(dofavor) AS item_last_2_day_favor_count, SUM(doaddcar) AS item_last_2_day_addcar_count , SUM(dobuy) AS item_last_2_day_buy_count
FROM user_item_detail 
WHERE datediff(to_date("2014-12-18","yyyy-mm-dd"),dodate,"dd")=2
GROUP BY item_id;

DROP TABLE IF EXISTS wy2_f2_t4_3;
CREATE TABLE wy2_f2_t4_3 AS 
SELECT item_id , 
SUM(doview) AS item_last_3_day_view_count ,SUM(dofavor) AS item_last_3_day_favor_count, SUM(doaddcar) AS item_last_3_day_addcar_count , SUM(dobuy) AS item_last_3_day_buy_count
FROM user_item_detail 
WHERE datediff(to_date("2014-12-18","yyyy-mm-dd"),dodate,"dd")=3
GROUP BY item_id;

DROP TABLE IF EXISTS wy2_f2_t5;
CREATE TABLE wy2_f2_t5 AS 
SELECT t.item_id,SUM(t.dawnact) AS item_totaldays_dawn_total,SUM(t.amact) AS item_totaldays_am_total,SUM(t.pmact) AS item_totaldays_pm_total FROM
(SELECT item_id ,CASE WHEN dohour_type=1 THEN 1 ELSE 0 END AS dawnact,CASE WHEN dohour_type=2 THEN 1 ELSE 0 END AS amact,CASE WHEN dohour_type=3 THEN 1 ELSE 0 END AS pmact
FROM user_item_detail WHERE dodate>=to_date("2014-11-19","yyyy-mm-dd") AND dodate<=to_date("2014-12-18","yyyy-mm-dd")  )t
GROUP BY t.item_id;

DROP TABLE IF EXISTS wy2_f2_t6;
CREATE TABLE wy2_f2_t6 AS 
SELECT g.*,
CASE WHEN g.item_last1week_favor_count=0 THEN 0 ELSE g.item_last1week_favorandbuy_count/g.item_last1week_favor_count END AS item_last1week_favorandbuy_rate,
CASE WHEN g.item_last1week_addcar_count=0 THEN 0 ELSE g.item_last1week_addcarandbuy_count/g.item_last1week_addcar_count END AS item_last1week_addcarandbuy_rate FROM
(
  SELECT d.*,
  CASE WHEN e.item_last1week_favorandbuy_count IS NULL THEN 0 ELSE e.item_last1week_favorandbuy_count END AS item_last1week_favorandbuy_count,
  CASE WHEN f.item_last1week_addcarandbuy_count IS NULL THEN 0 ELSE f.item_last1week_addcarandbuy_count END AS item_last1week_addcarandbuy_count FROM 
  (
	SELECT DISTINCT a.item_id,
	CASE WHEN b.item_last1week_favor_count IS NULL THEN 0 ELSE b.item_last1week_favor_count END AS item_last1week_favor_count,
	CASE WHEN c.item_last1week_addcar_count IS NULL THEN 0 ELSE c.item_last1week_addcar_count END AS item_last1week_addcar_count
	FROM wy2_f1_t12_1 a 
	LEFT OUTER JOIN
	(SELECT item_id,COUNT(user_id) AS item_last1week_favor_count FROM wy2_f1_t12_1 WHERE dofavor>0 GROUP BY item_id ) b
	ON a.item_id=b.item_id
	LEFT OUTER JOIN
	(SELECT item_id,COUNT(user_id) AS item_last1week_addcar_count FROM wy2_f1_t12_1 WHERE doaddcar>0 GROUP BY item_id ) c
	ON a.item_id=c.item_id
  ) d
  LEFT OUTER JOIN
	  (SELECT item_id,COUNT(user_id) AS item_last1week_favorandbuy_count FROM wy2_f1_t12_1 WHERE dofavor>0 AND dobuy>0 GROUP BY item_id) e
  ON d.item_id=e.item_id
  LEFT OUTER JOIN
	  (SELECT item_id,COUNT(user_id) AS item_last1week_addcarandbuy_count FROM wy2_f1_t12_1 WHERE doaddcar>0 AND dobuy>0 GROUP BY item_id) f
  ON d.item_id=f.item_id
)g;

DROP TABLE IF EXISTS wy2_f2_t7;
CREATE TABLE wy2_f2_t7 AS 
SELECT p.item_id,
CASE WHEN q.item_totaldays_rebuy_usercount IS NULL THEN 0 ELSE q.item_totaldays_rebuy_usercount END AS item_totaldays_rebuy_usercount,
CASE WHEN q.item_totaldays_rebuy_usercount IS NULL THEN 0
	 WHEN q.item_totaldays_rebuy_usercount=0 THEN 0 
	 ELSE q.item_totaldays_rebuy_usercount/p.item_totaldays_buy_usercount END AS user_totaldays_rebuy_userrate FROM
  (SELECT a.item_id,COUNT(user_id) AS item_totaldays_buy_usercount FROM
	  (SELECT DISTINCT item_id,user_id FROM user_item_detail WHERE dobuy>0 AND dodate>=to_date("2014-11-19","yyyy-mm-dd") AND dodate<=to_date("2014-12-18","yyyy-mm-dd") ) a
  GROUP BY a.item_id) p
  LEFT OUTER JOIN
  (SELECT c.item_id,COUNT(c.user_id) AS item_totaldays_rebuy_usercount FROM
	(SELECT b.item_id,b.user_id,SUM(b.cnt) AS cnt FROM
	  (SELECT item_id,user_id,dodate,1 AS cnt FROM user_item_detail WHERE dobuy>0 AND dodate>=to_date("2014-11-19","yyyy-mm-dd") AND dodate<=to_date("2014-12-18","yyyy-mm-dd")  
	  GROUP BY item_id,user_id,dodate) b
	GROUP BY b.item_id,b.user_id) c
  WHERE c.cnt>1
  GROUP BY c.item_id) q
ON p.item_id=q.item_id;

DROP TABLE IF EXISTS wy2_f2;
CREATE TABLE wy2_f2 AS 
SELECT o.*,p.item_totaldays_rebuy_usercount,p.user_totaldays_rebuy_userrate FROM
(
  SELECT m.*,n.item_last1week_favor_count,n.item_last1week_addcar_count,n.item_last1week_favorandbuy_count,n.item_last1week_addcarandbuy_count,n.item_last1week_favorandbuy_rate,n.item_last1week_addcarandbuy_rate FROM
  (
	SELECT k.*,l.item_totaldays_dawn_total,l.item_totaldays_am_total,l.item_totaldays_pm_total FROM
	(
	  SELECT i.*,j.item_last_3_day_view_count,j.item_last_3_day_favor_count,j.item_last_3_day_addcar_count,j.item_last_3_day_buy_count FROM
	  (
		SELECT g.*,h.item_last_2_day_view_count,h.item_last_2_day_favor_count,h.item_last_2_day_addcar_count,h.item_last_2_day_buy_count FROM
		(
		  SELECT e.*,f.item_last_1_day_view_count,f.item_last_1_day_favor_count,f.item_last_1_day_addcar_count,f.item_last_1_day_buy_count FROM
		  (
			SELECT c.*,d.item_last3days_view_total,d.item_last3days_favor_total,d.item_last3days_addcar_total,d.item_last3days_buy_total FROM
			(
			  SELECT a.*,b.item_last1week_view_total,b.item_last1week_favor_total,b.item_last1week_addcar_total,b.item_last1week_buy_total FROM
			  wy2_f2_t1 a LEFT OUTER JOIN wy2_f2_t2 b
			  ON a.item_id=b.item_id
			) c
			LEFT OUTER JOIN wy2_f2_t3 d
			ON c.item_id=d.item_id
		  ) e
		  LEFT OUTER JOIN wy2_f2_t4_1 f
		  ON e.item_id=f.item_id
		) g
		LEFT OUTER JOIN wy2_f2_t4_2 h
		ON g.item_id=h.item_id
	  ) i
	  LEFT OUTER JOIN wy2_f2_t4_3 j
	  ON i.item_id=j.item_id
	) k
	LEFT OUTER JOIN wy2_f2_t5 l
	ON k.item_id=l.item_id
  ) m
  LEFT OUTER JOIN wy2_f2_t6 n
  ON m.item_id=n.item_id
) o
LEFT OUTER JOIN wy2_f2_t7 p
ON o.item_id=p.item_id;