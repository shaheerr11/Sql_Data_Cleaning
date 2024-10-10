select *
from layoff_stagging10
order by 1;

create table layoff_stagging10
select *
from layoffs;

select*,
row_number() 
over(partition by company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions) as row_num
from layoff_stagging10;

with duplicate_row as
(
select*,
row_number() 
over(partition by company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions) as row_num
from layoff_stagging10
)
select *
from duplicate_row
where row_num>1;

CREATE TABLE `layoff_stagging11` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoff_stagging11
select*,
row_number() 
over(partition by company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions) as row_num
from layoff_stagging10;

delete
from layoff_stagging11
where row_num>1;

select  company,trim(company)
from layoff_stagging11;

update layoff_stagging11
set company=trim(company);

select  distinct industry
from layoff_stagging11;

update layoff_stagging11
set industry='crypto'
where industry like 'crypto%';

select distinct country,trim(trailing '.' from country)
from layoff_stagging11;

update layoff_stagging11
set country=trim(trailing '.' from country);

select distinct country
from layoff_stagging11;

select `date`,str_to_date(`date`,' %m/%d/%Y')
from layoff_stagging11;

update layoff_stagging11
set `date`=str_to_date(`date`,' %m/%d/%Y');

select*
from layoff_stagging11;

alter table layoff_stagging11
modify column `date` date;

select*
from layoff_stagging11
where industry is null or industry='';

select *
from layoff_stagging11 t1
join layoff_stagging11 t2
on t1.company=t2.company
where t1.industry is null
and t2.industry is not null;


update layoff_stagging11
set industry=null
where industry='';

update layoff_stagging11 t1
join layoff_stagging11 t2
on t1.company=t2.company
set t1.industry=t2.industry
where t1.industry is null
and t2.industry is not null;

select *
from layoff_stagging11
where company='airbnb';

delete
from layoff_stagging11
where total_laid_off is null
and percentage_laid_off is null;

alter table layoff_stagging11
drop column row_num;

select*
from layoff_stagging11




























