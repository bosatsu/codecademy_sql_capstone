/*
First- and Last-Touch Attribution with CoolTShirts.com
*/
/*
Task 1:
*/
SELECT COUNT(DISTINCT utm_campaign) as campaigns
FROM page_visits;

SELECT COUNT(DISTINCT utm_source) as sources
FROM page_visits;

SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;
/*
Task 2:
*/
SELECT DISTINCT page_name as 'Page Name'
FROM page_visits;
/*
Task 3:
*/
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign as 'Campaign',
  COUNT(ft.first_touch_at) as 'Count'
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY COUNT(ft.first_touch_at) DESC;
/*
Task 4:
*/
WITH last_touch AS (
    SELECT user_id,
       MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign as 'Campaign',
COUNT(lt.last_touch_at) as 'Count'
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY COUNT(lt.last_touch_at) DESC;
/*
Task 5:
*/
SELECT COUNT(DISTINCT user_id) as 'Vistors who make a purchase'
FROM page_visits
WHERE page_name = '4 - purchase';
/*
Task 6:
*/
WITH last_touch AS (
    SELECT user_id,
       MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign as 'Campaign',
COUNT(lt.last_touch_at) as 'Count'
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
WHERE pv.page_name = '4 - purchase'
GROUP BY pv.utm_campaign;
