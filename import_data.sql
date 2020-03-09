declare @fname varchar(20);
set @fname = '';
while 1=1 begin
  select top 1 @fname=fname from dbo.flist where fname>@fname order by fname;
  if @@rowcount <> 1 break;
  --declare @userid int;
  --select @userid = convert(int, SUBSTRING(@fname, 3, 6));

  declare @sql varchar(8000);
  set @sql = '  INSERT INTO trades(userid, dt, ticker, amount, price)
  select
	' + SUBSTRING(@fname, 3, 6) + ',
	convert(datetime, dt, 121) as dt,
	ticker,
	convert(int, amount) as amount,
	convert(numeric(16,5), price) as price
  from openrowset(bulk ''d:\work\moex\unpacked\'+@fname+''', formatfile = ''d:\work\moex\fmt.txt'') qq';
  exec(@sql);
end;

/*
select
  convert(datetime, dt, 121) as dt,
  ticker,
  convert(int, amount) as amount,
  convert(numeric(16,5), price) as price
from openrowset(bulk 'd:\work\moex\unpacked\1_210707.csv', formatfile = 'd:\work\moex\fmt.txt') qq
*/
