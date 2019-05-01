
select res.* from (
SELECT ﻿code FROM compare_icd.result) res;

select res1.﻿code,res1.label,res1.description,res1.distance, concat_ws('\n',res2.new1,res1.result_error) as result_error from (
select r.﻿code,r.label,r.description,r.distance, group_concat(r.values separator '\n') as result_error
from compare_icd.result r where r.specific != 0 group by r.﻿code ) res1
left join
(select r.﻿code,r.label,r.description,r.distance,r.values, concat(replace(r.values," ","[Blank]"),
replace(r.values,'\r',"[new line]"))  as new1
from compare_icd.result r where r.specific != 0 and r.values = "" or r.values = '\r' group by r.﻿code) res2
 on res1.﻿code = res2.﻿code;
