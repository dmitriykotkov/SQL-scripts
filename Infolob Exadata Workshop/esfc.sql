clear scre

COL NAME FOR A30

SET HEAD ON

SELECT n.name
      ,v.value as "1 MEG Flash Cache Hits"
FROM   v$mystat v
      ,v$statname n
WHERE n.statistic# = v.statistic#
AND   n.statistic# = 1133
/

