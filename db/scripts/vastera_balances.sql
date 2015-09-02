-- Vastera balances to CAD/Local
select
b.cmpcode,
b.el1,b.el2,b.el3,b.el4,b.el5,b.el6,
b.curcode,
b.amount as input_amt,
rc.rate as rate_cad,
b.amount * (rc.rate / 10000000) as cad_amt,
c.curlocal,
(rc.rate/rl.rate) * 10000000 as rate_local,
b.amount * (rc.rate/rl.rate) as local_amt
from 
vastera.source_partial_balances b
left join staging_templates.cmpcode_map cm on cm.cmpcode_from=b.cmpcode
left join staging_templates.cmp_master c on c.cmpcode=cm.cmpcode_to
left join staging_templates.rate_master rc on rc.rate_type='ME_RATE' and rc.base=b.curcode and rc.parent='CAD'
left join staging_templates.rate_master rl on rl.rate_type='ME_RATE' and rl.base=c.curlocal and rl.parent='CAD'
;

-- Aggregate Vastera balances in CAD
select
cm.cmpcode_to as cmpcode,
b.el1,b.el2,b.el3,b.el4,b.el5,b.el6,
sum(b.amount * (rc.rate / 10000000)) as cad_amt
from 
vastera.source_partial_balances b
left join staging_templates.cmpcode_map cm on cm.cmpcode_from=b.cmpcode
left join staging_templates.cmp_master c on c.cmpcode=cm.cmpcode_to
left join staging_templates.rate_master rc on rc.rate_type='ME_RATE' and rc.base=b.curcode and rc.parent='CAD'
group by
cm.cmpcode_to,
b.el1,b.el2,b.el3,b.el4,b.el5,b.el6
;

-- Aggregate Vastera balances in Local currency
select
cm.cmpcode_to as cmpcode,
b.el1,b.el2,b.el3,b.el4,b.el5,b.el6,
sum(b.amount * (rc.rate/rl.rate)) as local_amt
from 
vastera.source_partial_balances b
left join staging_templates.cmpcode_map cm on cm.cmpcode_from=b.cmpcode
left join staging_templates.cmp_master c on c.cmpcode=cm.cmpcode_to
left join staging_templates.rate_master rc on rc.rate_type='ME_RATE' and rc.base=b.curcode and rc.parent='CAD'
left join staging_templates.rate_master rl on rl.rate_type='ME_RATE' and rl.base=c.curlocal and rl.parent='CAD'
group by
cm.cmpcode_to,
b.el1,b.el2,b.el3,b.el4,b.el5,b.el6
;

-- Aggregate Vastera balance differences in CAD (post-mapping)
select ab.cmpcode, 
ab.el1,ab.el2,ab.el3,ab.el4,ab.el5,ab.el6,ab.accode,
ab.full_value as audit_bal,
pb.cad_amt as rec_bal,
nvl(ab.full_value,0) - nvl(pb.cad_amt,0) as delta
from 
(select distinct cmpcode,accode from staging.mapped_balances union select distinct cmpcode,accode from vastera.staged_partial_balances) a
left join (select cmpcode,el1,el2,el3,el4,el5,el6,accode,sum(full_value) as full_value from staging.mapped_balances group by cmpcode,el1,el2,el3,el4,el5,el6,accode) ab on ab.cmpcode=a.cmpcode and ab.accode=a.accode
left join (select cmpcode,el1,el2,el3,el4,el5,el6,accode,sum(cad_amt) as cad_amt from vastera.staged_partial_balances group by cmpcode,el1,el2,el3,el4,el5,el6,accode) pb on pb.cmpcode=a.cmpcode and pb.accode=a.accode
where
ab.cmpcode in (select distinct bc.cmpcode from vastera.staged_partial_balances bc join staging_templates.cmp_master cm on cm.cmpcode=bc.cmpcode where cm.curlocal not in ('CAD','USD') or cm.curfunc not in ('CAD','USD'))
;

-- Aggregate Vastera balance differences in CAD (post-mapping, Element 1)
select ab.cmpcode,
ab.el1,
ab.full_value as audit_bal,
pb.cad_amt as rec_bal
from (select cmpcode,el1,sum(full_value) as full_value from staging.mapped_balances group by cmpcode,el1) ab
left join (select cmpcode,el1,sum(cad_amt) as cad_amt from vastera.staged_partial_balances group by cmpcode,el1) pb on pb.cmpcode=ab.cmpcode and pb.el1=ab.el1
where
ab.cmpcode in (select distinct bc.cmpcode from vastera.staged_partial_balances bc join staging_templates.cmp_master cm on cm.cmpcode=bc.cmpcode where cm.curlocal not in ('CAD','USD') or cm.curfunc not in ('CAD','USD'))
;

-- Missing Vastera balances
select ab.cmpcode, 
ab.el1,ab.el2,ab.el3,ab.el4,ab.el5,ab.el6,ab.accode,
pb.el1,pb.el2,pb.el3,pb.el4,pb.el5,pb.el6,pb.accode,
ab.full_value as audit_bal,
pb.cad_amt as rec_bal
from staging.mapped_balances ab
--left join vastera.staged_partial_balances pb on pb.cmpcode=ab.cmpcode and pb.el1=ab.el1 and pb.el2=ab.el2 and pb.el3=ab.el3 and pb.el4=ab.el4 and pb.el5=ab.el5 and pb.el6=ab.el6
left join (select cmpcode,el1,el2,el3,el4,el5,el6,accode,sum(cad_amt) as cad_amt from vastera.staged_partial_balances group by cmpcode,el1,el2,el3,el4,el5,el6,accode) pb on pb.cmpcode=ab.cmpcode and pb.accode=ab.accode
where
ab.cmpcode in (select distinct bc.cmpcode from vastera.staged_partial_balances bc join staging_templates.cmp_master cm on cm.cmpcode=bc.cmpcode where cm.curlocal not in ('CAD','USD') or cm.curfunc not in ('CAD','USD'))
and pb.el1 is null
;

-- Missing Audit balances
select pb.cmpcode, 
pb.el1,pb.el2,pb.el3,pb.el4,pb.el5,pb.el6,pb.accode,
0 as audit_bal,
pb.cad_amt as rec_bal,
-1 * pb.cad_amt as delta
from (select cmpcode,el1,el2,el3,el4,el5,el6,accode,sum(cad_amt) as cad_amt from vastera.staged_partial_balances group by cmpcode,el1,el2,el3,el4,el5,el6,accode) pb
--left join vastera.staged_partial_balances pb on pb.cmpcode=ab.cmpcode and pb.el1=ab.el1 and pb.el2=ab.el2 and pb.el3=ab.el3 and pb.el4=ab.el4 and pb.el5=ab.el5 and pb.el6=ab.el6
left join staging.mapped_balances ab on pb.cmpcode=ab.cmpcode and pb.accode=ab.accode
where
pb.cmpcode in (select distinct bc.cmpcode from vastera.staged_partial_balances bc join staging_templates.cmp_master cm on cm.cmpcode=bc.cmpcode where cm.curlocal not in ('CAD','USD') or cm.curfunc not in ('CAD','USD'))
and ab.el1 is null
and pb.cad_amt is not null
and pb.cad_amt != 0
and pb.el1 < 300000
;

-- Duplicate entries
select cmpcode,b.el1,b.el2,b.el3,b.el4,b.el5,b.el6,curcode,sum(amount),count(1) from vastera.source_partial_balances b group by cmpcode,b.el1,b.el2,b.el3,b.el4,b.el5,b.el6,curcode having count(1) > 1 and sum(amount) != 0;

select * from staging.mapped_balances where cmpcode in (select distinct bc.cmpcode from vastera.staged_partial_balances bc join staging_templates.cmp_master cm on cm.cmpcode=bc.cmpcode where cm.curlocal not in ('CAD','USD') or cm.curfunc not in ('CAD','USD'))
;

select * from staging.mapped_balances where el5='CER' and el6 is null;
