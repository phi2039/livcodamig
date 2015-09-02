drop table hfm.gl_data_period;
create table hfm.gl_data_period (yr integer, period integer, cmpcode varchar(12), el1 varchar(12), el3 varchar(12), full_value decimal) as
select yr, period, cmpcode, el1, el3, sum(full_value) as full_value from staging.mapped_balances group by yr, period, cmpcode, el1, el3;
CREATE INDEX idx_gl_data_period_lookup ON hfm.gl_data_period(yr, period, cmpcode, el1, el3);

drop table hfm.gl_data_ytd;
create table hfm.gl_data_ytd (yr integer, period integer, cmpcode varchar(12), el1 varchar(12), el3 varchar(12), full_value decimal) as
select p.yr, p.period, net.cmpcode, net.el1, net.el3, sum(net.full_value) as full_value
from ( select distinct yr, period from hfm.gl_data_period ) p
join hfm.gl_data_period net on net.yr=p.yr and net.period<=p.period
group by p.yr, p.period, net.cmpcode, net.el1, net.el3;
CREATE INDEX idx_gl_data_ytd_lookup ON hfm.gl_data_ytd(yr, period, cmpcode, el1, el3);

select
	y.yr,
	y.period,
	y.cmpcode as entity,
	y.el1 as account,
	case when y.el3 like '84I%' or y.el3 like '9%' then '[None]'
	else y.el3 end as dept,
	case when y.el3 not like '84I%' then '[ICP None]'
	else substr(y.el3,4,8) end as icp,
  case when y.el3 not like '9%' then '[None]'
  else y.el3 end as project,
	case when y.el1 < 400000 then y.full_value
	else p.full_value end as amount
from hfm.gl_data_ytd y 
left join hfm.gl_data_period p on p.yr=y.yr and p.period=y.period and p.cmpcode=y.cmpcode and p.el1=y.el1 and p.el3=y.el3
;
