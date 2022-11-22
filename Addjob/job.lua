

function RecognizedJob(jobname, cb)
    MySQL.ready(function()
        local nzy = MySQL.Sync.fetchScalar('SELECT COUNT(name) FROM jobs WHERE name = @name', {
            ['@name'] = job
        })
        if nzy > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
end
exports('isJobExists',isJobExists)

function NewJob(jobname, label, whitelist)
    RecognizedJob(name,function(check)
        if check then 
            Citizen.Wait(18)
        else
            MySQL.Async.execute('INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES (@name, @label, @whitelisted)',{
                ['@name'] = name,
                ['@label'] = label,
                ['@whitelisted'] = whitelisted
            },function(changed)
                if changed then
                    print('[SUCCES] job created')
                else
                    print('[ERROR]Job cannot be created!')
                end
            end)
        end
    end)
end
exports('NewJob',NewJob)

function RecognizedJobGrade(name, job, cb)
    MySQL.ready(function()
        local nzy = MySQL.Sync.fetchAll('SELECT id,job_name,grade,name,label,salary FROM job_grades WHERE name=@name AND job_name=@job', {
            ['@name'] = name,
            ['@job'] = job_name
        })
        if nzy[1] ~= nil then
            cb(nzy[1])
        else
            cb(false)
        end
    end)
end
exports('isJobGradeExists',isJobGradeExists)

function NewJobGrade()
    RecognizedJobGrade(name, job, function(check)
        if check ~= false then 
            if check.label ~= label or check.grade ~= grade then 
                MySQL.Async.execute('UPDATE `job_grades` SET label=@label, grade=@grade WHERE id=@id',{
                    ['@id'] = is.id,
                    ['@label'] = label,
                    ['@grade'] = grade,
                    ['@salary'] = salary,
                },function(changed)
                    if changed then
                        print('[SUCCES] job grade created')
                    else
                        print('[ERROR] job grade cannot be created!')
                    end
                end)
            else
                print('Job grade alredy exist')
            end
        else
            MySQL.Async.execute('INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@job_name, @grade, @name, @label, @salary, @skin, @skin)',{
                ['@name'] = name,
                ['@label'] = label,
                ['@job_name'] = job_name,
                ['@grade'] = grade,
                ['@salary'] = salary,
                ['@skin'] = json.encode({})
            },function(changed)
                if changed then
                    print('[SUCCES] job grade created')
                else
                    print('[ERROR] job grade cannot be created!')
                end
            end)
        end
    end)
end
exports('NewJobGrade',NewJobGrade)



