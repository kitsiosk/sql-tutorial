.read ../datamod/create_work_job.sql
.read ../datamod/populate_work_job.sql

-- [keep]
select *
from work inner join job
    on work.job = job.name;
-- [/keep]
