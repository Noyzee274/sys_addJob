# sys_addJob
Simple Job system, so you dont have to import any sql files

Add to any server file:

`NewJob('police','Police',true)`

`NewJobGrade('police',0,'recruit','Recruit', 1000)`

I recommend using an export:

`exports.Addjob:NewJob('police','Police',true)`
