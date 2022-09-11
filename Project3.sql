/* Reading the top 10 rows*/
select top 10 * from BSE500


/*To compare the median of column Enterprise Value(Cr) across different Sectors.*/

select distinct Sector , 
PERCENTILE_CONT(0.5) within group (order by enterprise_value_cr) over(partition by sector) as Median
from BSE500



/*To find the no. of Companies in each industry to have positive and negative three year return.*/

select count(distinct industry) from BSE500 where _3_Year_Return is not null 

select a.industry,neg_ret_comp,pos_ret_comp
from 
(select industry ,COUNT(Company) as neg_ret_comp from BSE500    /*making negative return column*/
where _3_Year_Return < 0 
group by Industry)a
inner join 
(select industry ,COUNT(Company) as pos_ret_comp from BSE500    /*making positive return column*/
where _3_Year_Return > 0 
group by Industry)b on a.Industry = b.Industry
order by pos_ret_comp desc
