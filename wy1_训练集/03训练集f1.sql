DROP TABLE IF EXISTS wy1_f1_t1;
CREATE TABLE wy1_f1_t1 AS 
SELECT user_id , 
SUM(doview) AS user_totaldays_view_total ,SUM(dofavor) AS user_totaldays_favor_total, SUM(doaddcar) AS user_totaldays_addcar_total , SUM(dobuy) AS user_totaldays_buy_total
FROM user_item_detail 
WHERE dodate>=to_date("2014-11-18","yyyy-mm-dd") AND dodate<=to_date("2014-12-17","yyyy-mm-dd")
GROUP BY user_id;

DROP TABLE IF EXISTS wy1_f1_t2;
CREATE TABLE wy1_f1_t2 AS 
SELECT user_id , 
SUM(doview) AS user_last1week_view_total ,SUM(dofavor) AS user_last1week_favor_total, SUM(doaddcar) AS user_last1week_addcar_total , SUM(dobuy) AS user_last1week_buy_total
FROM user_item_detail 
WHERE datediff(to_date("2014-12-17","yyyy-mm-dd"),dodate,"dd")<=7
GROUP BY user_id;

DROP TABLE IF EXISTS wy1_f1_t3;
CREATE TABLE wy1_f1_t3 AS 
SELECT user_id , 
SUM(doview) AS user_last3days_view_total ,SUM(dofavor) AS user_last3days_favor_total, SUM(doaddcar) AS user_last3days_addcar_total , SUM(dobuy) AS user_last3days_buy_total
FROM user_item_detail 
WHERE datediff(to_date("2014-12-17","yyyy-mm-dd"),dodate,"dd")<=3
GROUP BY user_id;

DROP TABLE IF EXISTS wy1_f1_t4_1;
CREATE TABLE wy1_f1_t4_1 AS 
SELECT user_id , 
SUM(doview) AS user_last_1_day_view_count ,SUM(dofavor) AS user_last_1_day_favor_count, SUM(doaddcar) AS user_last_1_day_addcar_count , SUM(dobuy) AS user_last_1_day_buy_count
FROM user_item_detail 
WHERE dodate=to_date("2014-12-17","yyyy-mm-dd")
GROUP BY user_id;

DROP TABLE IF EXISTS wy1_f1_t4_2;
CREATE TABLE wy1_f1_t4_2 AS 
SELECT user_id , 
SUM(doview) AS user_last_2_day_view_count ,SUM(dofavor) AS user_last_2_day_favor_count, SUM(doaddcar) AS user_last_2_day_addcar_count , SUM(dobuy) AS user_last_2_day_buy_count
FROM user_item_detail 
WHERE datediff(to_date("2014-12-18","yyyy-mm-dd"),dodate,"dd")=2
GROUP BY user_id;

DROP TABLE IF EXISTS wy1_f1_t4_3;
CREATE TABLE wy1_f1_t4_3 AS 
SELECT user_id , 
SUM(doview) AS user_last_3_day_view_count ,SUM(dofavor) AS user_last_3_day_favor_count, SUM(doaddcar) AS user_last_3_day_addcar_count , SUM(dobuy) AS user_last_3_day_buy_count
FROM user_item_detail 
WHERE datediff(to_date("2014-12-18","yyyy-mm-dd"),dodate,"dd")=3
GROUP BY user_id;

DROP TABLE IF EXISTS wy1_f1_t5;
CREATE TABLE wy1_f1_t5 AS 
SELECT t.user_id,SUM(t.dawnact) AS user_totaldays_dawn_total,SUM(t.amact) AS user_totaldays_am_total,SUM(t.pmact) AS user_totaldays_pm_total FROM
(SELECT user_id ,CASE WHEN dohour_type=1 THEN 1 ELSE 0 END AS dawnact,CASE WHEN dohour_type=2 THEN 1 ELSE 0 END AS amact,CASE WHEN dohour_type=3 THEN 1 ELSE 0 END AS pmact
FROM user_item_detail WHERE dodate<=to_date("2014-12-17","yyyy-mm-dd") AND dodate>=to_date("2014-11-18","yyyy-mm-dd") )t
GROUP BY t.user_id;

DROP TABLE IF EXISTS wy1_f1_t6;
CREATE TABLE wy1_f1_t6 AS 
SELECT t.user_id,SUM(t.dawnact) AS user_last1week_dawn_total,SUM(t.amact) AS user_last1week_am_total,SUM(t.pmact) AS user_last1week_pm_total FROM
(SELECT user_id ,CASE WHEN dohour_type=1 THEN 1 ELSE 0 END AS dawnact,CASE WHEN dohour_type=2 THEN 1 ELSE 0 END AS amact,CASE WHEN dohour_type=3 THEN 1 ELSE 0 END AS pmact
FROM user_item_detail WHERE datediff(to_date("2014-12-17","yyyy-mm-dd"),dodate,"dd")<=7 )t
GROUP BY t.user_id;

DROP TABLE IF EXISTS wy1_f1_t7;
CREATE TABLE wy1_f1_t7 AS 
SELECT t.user_id,SUM(t.dawnact) AS user_last3days_dawn_total,SUM(t.amact) AS user_last3days_am_total,SUM(t.pmact) AS user_last3days_pm_total FROM
(SELECT user_id ,CASE WHEN dohour_type=1 THEN 1 ELSE 0 END AS dawnact,CASE WHEN dohour_type=2 THEN 1 ELSE 0 END AS amact,CASE WHEN dohour_type=3 THEN 1 ELSE 0 END AS pmact
FROM user_item_detail WHERE datediff(to_date("2014-12-17","yyyy-mm-dd"),dodate,"dd")<=3 )t
GROUP BY t.user_id;

DROP TABLE IF EXISTS wy1_f1_t8_1;
CREATE TABLE wy1_f1_t8_1 AS
SELECT t.user_id , SUM(t.cnt) AS user_last_1day_totalhour FROM 
(SELECT DISTINCT user_id,dohour,1 AS cnt FROM user_item_detail WHERE dodate=to_date("2014-12-17","yyyy-mm-dd") )t
GROUP BY t.user_id;

DROP TABLE IF EXISTS wy1_f1_t8_2;
CREATE TABLE wy1_f1_t8_2 AS
SELECT t.user_id , SUM(t.cnt) AS user_last_2day_totalhour FROM 
(SELECT DISTINCT user_id,dohour,1 AS cnt FROM user_item_detail WHERE datediff(to_date("2014-12-18","yyyy-mm-dd"),dodate,"dd")=2 )t
GROUP BY t.user_id;

DROP TABLE IF EXISTS wy1_f1_t8_3;
CREATE TABLE wy1_f1_t8_3 AS
SELECT t.user_id , SUM(t.cnt) AS user_last_3day_totalhour FROM 
(SELECT DISTINCT user_id,dohour,1 AS cnt FROM user_item_detail WHERE datediff(to_date("2014-12-18","yyyy-mm-dd"),dodate,"dd")=3 )t
GROUP BY t.user_id;

DROP TABLE IF EXISTS wy1_f1_t9_1;
CREATE TABLE wy1_f1_t9_1 AS 
SELECT t.user_id,SUM(t.dawnbuy) AS user_last1week_dawn_buy,SUM(t.ambuy) AS user_last1week_am_buy,SUM(t.pmbuy) AS user_last1week_pm_buy FROM
(SELECT user_id,item_id,CASE WHEN dohour_type=1 THEN 1 ELSE 0 END AS dawnbuy,CASE WHEN dohour_type=2 THEN 1 ELSE 0 END AS ambuy,CASE WHEN dohour_type=3 THEN 1 ELSE 0 END AS pmbuy 
FROM user_item_detail WHERE dobuy=1 AND datediff(to_date("2014-12-17","yyyy-mm-dd"),dodate,"dd")<=7 )t
GROUP BY t.user_id;

DROP TABLE IF EXISTS wy1_f1_t9;
CREATE TABLE wy1_f1_t9 AS
SELECT a.*,
a.user_last1week_dawn_buy/b.user_last1week_buy_total AS user_last1week_dawn_buyrate,
a.user_last1week_am_buy/b.user_last1week_buy_total AS user_last1week_am_buyrate,
a.user_last1week_pm_buy/b.user_last1week_buy_total AS user_last1week_pm_buyrate 
FROM wy1_f1_t9_1 a 
LEFT OUTER JOIN 
(SELECT user_id,SUM(dobuy) AS user_last1week_buy_total FROM user_item_detail WHERE dobuy=1 AND datediff(to_date("2014-12-17","yyyy-mm-dd"),dodate,"dd")<=7 GROUP BY user_id)b
ON a.user_id=b.user_id;

DROP TABLE IF EXISTS wy1_f1_t9_1_E1;
CREATE TABLE wy1_f1_t9_1_E1 AS 
SELECT t.user_id,SUM(t.dawnbuy) AS user_last3days_dawn_buy,SUM(t.ambuy) AS user_last3days_am_buy,SUM(t.pmbuy) AS user_last3days_pm_buy FROM
(SELECT user_id,item_id,CASE WHEN dohour_type=1 THEN 1 ELSE 0 END AS dawnbuy,CASE WHEN dohour_type=2 THEN 1 ELSE 0 END AS ambuy,CASE WHEN dohour_type=3 THEN 1 ELSE 0 END AS pmbuy 
FROM user_item_detail WHERE dobuy=1 AND datediff(to_date("2014-12-17","yyyy-mm-dd"),dodate,"dd")<=3 )t
GROUP BY t.user_id;

DROP TABLE IF EXISTS wy1_f1_t9_E1;
CREATE TABLE wy1_f1_t9_E1 AS
SELECT a.*,
a.user_last3days_dawn_buy/b.user_last3days_buy_total AS user_last3days_dawn_buyrate,
a.user_last3days_am_buy/b.user_last3days_buy_total AS user_last3days_am_buyrate,
a.user_last3days_pm_buy/b.user_last3days_buy_total AS user_last3days_pm_buyrate 
FROM wy1_f1_t9_1_E1 a 
LEFT OUTER JOIN 
(SELECT user_id,SUM(dobuy) AS user_last3days_buy_total FROM user_item_detail WHERE dobuy=1 AND datediff(to_date("2014-12-17","yyyy-mm-dd"),dodate,"dd")<=3 GROUP BY user_id)b
ON a.user_id=b.user_id;

DROP TABLE IF EXISTS wy1_f1_t10;
CREATE TABLE wy1_f1_t10 AS 
SELECT t.user_id,datediff(to_date("2014-12-18","yyyy-mm-dd"),t.dodate,"dd") AS user_lastbuy_diffdays FROM 
(SELECT user_id,dodate,row_number() over (partition by user_id order by dodate DESC) AS order_date 
FROM user_item_detail WHERE dobuy=1 AND dodate<=to_date("2014-12-17","yyyy-mm-dd") AND dodate>=to_date("2014-11-18","yyyy-mm-dd") )t
WHERE t.order_date=1;

DROP TABLE IF EXISTS wy1_f1_t11;
CREATE TABLE wy1_f1_t11 AS 
SELECT t.user_id,datediff(to_date("2014-12-18","yyyy-mm-dd"),t.dodate,"dd") AS user_lastact_diffdays FROM 
(SELECT user_id,dodate,row_number() over (partition by user_id order by dodate DESC) AS order_date 
FROM user_item_detail WHERE dodate>=to_date("2014-11-18","yyyy-mm-dd") AND dodate<=to_date("2014-12-17","yyyy-mm-dd") )t
WHERE t.order_date=1;

DROP TABLE IF EXISTS wy1_f1_t12_1;
CREATE TABLE wy1_f1_t12_1 AS
SELECT user_id,item_id,SUM(doview) AS doview,SUM(dofavor) AS dofavor,SUM(doaddcar) AS doaddcar,SUM(dobuy) AS dobuy 
FROM user_item_detail 
WHERE datediff(to_date("2014-12-17","yyyy-mm-dd"),dodate,"dd")<=7
GROUP BY user_id,item_id;

DROP TABLE IF EXISTS wy1_f1_t12;
CREATE TABLE wy1_f1_t12 AS 
SELECT g.*,
CASE WHEN g.user_last1week_favor_count=0 THEN 0 ELSE g.user_last1week_favorandbuy_count/g.user_last1week_favor_count END AS user_last1week_favorandbuy_rate,
CASE WHEN g.user_last1week_addcar_count=0 THEN 0 ELSE g.user_last1week_addcarandbuy_count/g.user_last1week_addcar_count END AS user_last1week_addcarandbuy_rate FROM
(
  SELECT d.*,
  CASE WHEN e.user_last1week_favorandbuy_count IS NULL THEN 0 ELSE e.user_last1week_favorandbuy_count END AS user_last1week_favorandbuy_count,
  CASE WHEN f.user_last1week_addcarandbuy_count IS NULL THEN 0 ELSE f.user_last1week_addcarandbuy_count END AS user_last1week_addcarandbuy_count FROM 
  (
	SELECT DISTINCT a.user_id,
	CASE WHEN b.user_last1week_favor_count IS NULL THEN 0 ELSE b.user_last1week_favor_count END AS user_last1week_favor_count,
	CASE WHEN c.user_last1week_addcar_count IS NULL THEN 0 ELSE c.user_last1week_addcar_count END AS user_last1week_addcar_count
	FROM wy1_f1_t12_1 a 
	LEFT OUTER JOIN
	(SELECT user_id,COUNT(item_id) AS user_last1week_favor_count FROM wy1_f1_t12_1 WHERE dofavor>0 GROUP BY user_id ) b
	ON a.user_id=b.user_id
	LEFT OUTER JOIN
	(SELECT user_id,COUNT(item_id) AS user_last1week_addcar_count FROM wy1_f1_t12_1 WHERE doaddcar>0 GROUP BY user_id ) c
	ON a.user_id=c.user_id
  ) d
  LEFT OUTER JOIN
	  (SELECT user_id,COUNT(item_id) AS user_last1week_favorandbuy_count FROM wy1_f1_t12_1 WHERE dofavor>0 AND dobuy>0 GROUP BY user_id) e
  ON d.user_id=e.user_id
  LEFT OUTER JOIN
	  (SELECT user_id,COUNT(item_id) AS user_last1week_addcarandbuy_count FROM wy1_f1_t12_1 WHERE doaddcar>0 AND dobuy>0 GROUP BY user_id) f
  ON d.user_id=f.user_id
)g;

DROP TABLE IF EXISTS wy1_f1_t13_1;
CREATE TABLE wy1_f1_t13_1 AS
SELECT user_id,item_id,SUM(doview) AS doview,SUM(dofavor) AS dofavor,SUM(doaddcar) AS doaddcar,SUM(dobuy) AS dobuy 
FROM user_item_detail 
WHERE datediff(to_date("2014-12-17","yyyy-mm-dd"),dodate,"dd")<=3
GROUP BY user_id,item_id;

DROP TABLE IF EXISTS wy1_f1_t13;
CREATE TABLE wy1_f1_t13 AS 
SELECT g.*,
CASE WHEN g.user_last3days_favor_count=0 THEN 0 ELSE g.user_last3days_favorandbuy_count/g.user_last3days_favor_count END AS user_last3days_favorandbuy_rate,
CASE WHEN g.user_last3days_addcar_count=0 THEN 0 ELSE g.user_last3days_addcarandbuy_count/g.user_last3days_addcar_count END AS user_last3days_addcarandbuy_rate FROM 
(
  SELECT d.*,
  CASE WHEN e.user_last3days_favorandbuy_count IS NULL THEN 0 ELSE e.user_last3days_favorandbuy_count END AS user_last3days_favorandbuy_count,
  CASE WHEN f.user_last3days_addcarandbuy_count IS NULL THEN 0 ELSE f.user_last3days_addcarandbuy_count END AS user_last3days_addcarandbuy_count FROM 
  (
	SELECT DISTINCT a.user_id,
	CASE WHEN b.user_last3days_favor_count IS NULL THEN 0 ELSE b.user_last3days_favor_count END AS user_last3days_favor_count,
	CASE WHEN c.user_last3days_addcar_count IS NULL THEN 0 ELSE c.user_last3days_addcar_count END AS user_last3days_addcar_count
	FROM wy1_f1_t12_1 a 
	LEFT OUTER JOIN
	(SELECT user_id,COUNT(item_id) AS user_last3days_favor_count FROM wy1_f1_t12_1 WHERE dofavor>0 GROUP BY user_id ) b
	ON a.user_id=b.user_id
	LEFT OUTER JOIN
	(SELECT user_id,COUNT(item_id) AS user_last3days_addcar_count FROM wy1_f1_t12_1 WHERE doaddcar>0 GROUP BY user_id ) c
	ON a.user_id=c.user_id
	)d
	LEFT OUTER JOIN
	(SELECT user_id,COUNT(item_id) AS user_last3days_favorandbuy_count FROM wy1_f1_t12_1 WHERE dofavor>0 AND dobuy>0 GROUP BY user_id) e
	ON d.user_id=e.user_id
	LEFT OUTER JOIN
	(SELECT user_id,COUNT(item_id) AS user_last3days_addcarandbuy_count FROM wy1_f1_t12_1 WHERE doaddcar>0 AND dobuy>0 GROUP BY user_id) f
	ON d.user_id=f.user_id
)g;

DROP TABLE IF EXISTS wy1_f1_t14;
CREATE TABLE wy1_f1_t14 AS 
SELECT p.user_id,
CASE WHEN q.user_totaldays_rebuy_itemcount IS NULL THEN 0 ELSE q.user_totaldays_rebuy_itemcount END AS user_totaldays_rebuy_itemcount,
CASE WHEN q.user_totaldays_rebuy_itemcount IS NULL THEN 0
	 WHEN q.user_totaldays_rebuy_itemcount=0 THEN 0 
	 ELSE q.user_totaldays_rebuy_itemcount/p.user_totaldays_buy_itemcount END AS user_totaldays_rebuy_itemrate FROM
  (SELECT a.user_id,COUNT(a.item_id)AS user_totaldays_buy_itemcount FROM
	(SELECT DISTINCT user_id,item_id FROM user_item_detail WHERE dobuy>0 AND dodate>=to_date("2014-11-18","yyyy-mm-dd") AND dodate<=to_date("2014-12-17","yyyy-mm-dd") ) a
	GROUP BY a.user_id) p
  LEFT OUTER JOIN
  (SELECT c.user_id,COUNT(c.item_id) AS user_totaldays_rebuy_itemcount FROM
	(SELECT b.user_id,b.item_id,SUM(cnt) AS cnt FROM
	  (SELECT user_id,item_id,dodate,1 AS cnt FROM user_item_detail WHERE dobuy>0 AND dodate>=to_date("2014-11-18","yyyy-mm-dd") AND dodate<=to_date("2014-12-17","yyyy-mm-dd") 
	  GROUP BY user_id,item_id,dodate) b
	GROUP BY b.user_id,b.item_id) c
  WHERE c.cnt>1
  GROUP BY c.user_id) q
ON p.user_id=q.user_id;

DROP TABLE IF EXISTS wy1_f1;
CREATE TABLE wy1_f1 AS 
SELECT ii.*,jj.user_totaldays_rebuy_itemcount,jj.user_totaldays_rebuy_itemrate FROM 
(
  SELECT gg.*,hh.user_last3days_favor_count,hh.user_last3days_addcar_count,hh.user_last3days_favorandbuy_count,hh.user_last3days_addcarandbuy_count,hh.user_last3days_favorandbuy_rate,hh.user_last3days_addcarandbuy_rate FROM
  (
	SELECT ee.*,ff.user_last1week_favor_count,ff.user_last1week_addcar_count,ff.user_last1week_favorandbuy_count,ff.user_last1week_addcarandbuy_count,ff.user_last1week_favorandbuy_rate,ff.user_last1week_addcarandbuy_rate FROM
	(
	  SELECT cc.*,dd.user_lastact_diffdays FROM
	  (
		SELECT aa.*,bb.user_lastbuy_diffdays FROM
		(
		  SELECT y.*,z.user_last3days_dawn_buy,z.user_last3days_am_buy,z.user_last3days_pm_buy,z.user_last3days_dawn_buyrate,z.user_last3days_am_buyrate,z.user_last3days_pm_buyrate FROM
		  (
			SELECT w.*,x.user_last1week_dawn_buy,x.user_last1week_am_buy,x.user_last1week_pm_buy,x.user_last1week_dawn_buyrate,x.user_last1week_am_buyrate,x.user_last1week_pm_buyrate FROM
			(
			  SELECT u.*,v.user_last_3day_totalhour FROM
			  (
				SELECT s.*,t.user_last_2day_totalhour FROM
				(
				  SELECT q.*,r.user_last_1day_totalhour FROM
				  (
					SELECT o.*,p.user_last3days_dawn_total,p.user_last3days_am_total,p.user_last3days_pm_total FROM
					(
					  SELECT m.*,n.user_last1week_dawn_total,n.user_last1week_am_total,n.user_last1week_pm_total FROM
					  (
						SELECT k.*,l.user_totaldays_dawn_total,l.user_totaldays_am_total,l.user_totaldays_pm_total FROM
						(
						  SELECT i.*,j.user_last_3_day_view_count,j.user_last_3_day_favor_count,j.user_last_3_day_addcar_count,j.user_last_3_day_buy_count FROM
						  (
							SELECT g.*,h.user_last_2_day_view_count,h.user_last_2_day_favor_count,h.user_last_2_day_addcar_count,h.user_last_2_day_buy_count FROM 
							(
							  SELECT e.*,f.user_last_1_day_view_count,f.user_last_1_day_favor_count,f.user_last_1_day_addcar_count,f.user_last_1_day_buy_count FROM
							  (
								SELECT c.*,d.user_last3days_view_total,d.user_last3days_favor_total,d.user_last3days_addcar_total,d.user_last3days_buy_total FROM
								(
								  SELECT a.*,b.user_last1week_view_total,b.user_last1week_favor_total,b.user_last1week_addcar_total FROM
								  wy1_f1_t1 a LEFT OUTER JOIN wy1_f1_t2 b
								  ON a.user_id=b.user_id
								) c
								LEFT OUTER JOIN wy1_f1_t3 d
								ON c.user_id=d.user_id
							  ) e
							  LEFT OUTER JOIN wy1_f1_t4_1 f
							  ON e.user_id=f.user_id
							) g
							LEFT OUTER JOIN wy1_f1_t4_2 h
							ON g.user_id=h.user_id
						  ) i
						  LEFT OUTER JOIN wy1_f1_t4_3 j
						  ON i.user_id=j.user_id
						) k
						LEFT OUTER JOIN wy1_f1_t5 l
						ON k.user_id=l.user_id 
					  ) m
					  LEFT OUTER JOIN wy1_f1_t6 n
					  ON m.user_id=n.user_id
					) o
					LEFT OUTER JOIN wy1_f1_t7 p
					ON o.user_id=p.user_id 
				  ) q
				  LEFT OUTER JOIN wy1_f1_t8_1 r
				  ON q.user_id=r.user_id
				) s
				LEFT OUTER JOIN wy1_f1_t8_2 t
				ON s.user_id=t.user_id
			  ) u
			  LEFT OUTER JOIN wy1_f1_t8_3 v
			  ON u.user_id=v.user_id
			) w
			LEFT OUTER JOIN wy1_f1_t9 x
			ON w.user_id=x.user_id 
		  ) y
		  LEFT OUTER JOIN wy1_f1_t9_e1 z
		  ON y.user_id=z.user_id 
		) aa
		LEFT OUTER JOIN wy1_f1_t10 bb
		ON aa.user_id=bb.user_id 
	  ) cc
	  LEFT OUTER JOIN wy1_f1_t11 dd
	  ON cc.user_id=dd.user_id
	) ee
	LEFT OUTER JOIN wy1_f1_t12 ff
	ON ee.user_id=ff.user_id
  ) gg
  LEFT OUTER JOIN wy1_f1_t13 hh
  ON gg.user_id=hh.user_id
) ii
LEFT OUTER JOIN wy1_f1_t14 jj
ON ii.user_id=jj.user_id;