create schema hfm;

drop table if exists hfm.gl_data_period;
create table hfm.gl_data_period (yr integer, period integer, cmpcode varchar(12), el1 varchar(12), el3 varchar(12), full_value decimal) as
select yr, period, cmpcode, el1, el3, sum(full_value) as full_value from staging.mapped_balances group by yr, period, cmpcode, el1, el3;
CREATE INDEX idx_gl_data_period_lookup ON hfm.gl_data_period(yr, period, cmpcode, el1, el3);

-- Roll retained earnings movement accounts at year end
update hfm.gl_data_period set el1='321111' where el1 like '32111%' and period=0;
-- Shift retained earnings movement during fiscal periods to movement account
update hfm.gl_data_period set el1='321119' where el1='321111' and period>0;

drop table if exists hfm.gl_data_ytd;
create table hfm.gl_data_ytd (yr integer, period integer, cmpcode varchar(12), el1 varchar(12), el3 varchar(12), full_value decimal) as
select p.yr, p.period, net.cmpcode, net.el1, net.el3, sum(net.full_value) as full_value
from ( select distinct yr, period from hfm.gl_data_period ) p
join hfm.gl_data_period net on net.yr=p.yr and net.period<=p.period
group by p.yr, p.period, net.cmpcode, net.el1, net.el3;
CREATE INDEX idx_gl_data_ytd_lookup ON hfm.gl_data_ytd(yr, period, cmpcode, el1, el3);

-- LOCAL SELECT
select
	y.yr,
	y.period,
	y.cmpcode as entity,
	y.el1 as account,
	case when y.el3 like '84I%' then '[None]'
	else y.el3 end as dept,
	case when y.el3 not like '84I%' then '[ICP None]'
	else substr(y.el3,4,8) end as icp,
	'[None]' as project,
	y.full_value as amount
from hfm.gl_data_ytd y
where 
y.cmpcode not like 'E%'
and y.cmpcode not in (
'C100',
'VLUXELIM',
'VELM',
'VCH',
'VEB',
'VEF',
'VEG',
'VEHK',
'VEI',
'VEK',
'VEN',
'VES',
'VIN',
'VMX',
'VNBV',
'VPL')
;

-- CAD SELECT
select
	y.yr,
	y.period,
	y.cmpcode as entity,
	y.el1 as account,
	case when y.el3 like '84I%' then '[None]'
	else y.el3 end as dept,
	case when y.el3 not like '84I%' then '[ICP None]'
	else substr(y.el3,4,8) end as icp,
	'[None]' as project,
	y.full_value as amount
from hfm.gl_data_ytd y
where 
y.cmpcode not like 'E%'
and y.cmpcode not in (
'C100',
'VLUXELIM',
'VELM')
;
