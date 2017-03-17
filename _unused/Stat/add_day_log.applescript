on run argv
	
	if script = class of argv then
		set target_date to current date
	else
		set target_date to (item 1 of argv)
	end if
	
	set day_dd to day of target_date
	if day_dd < 10 and day_dd > 0 then
		set day_dd to ("0" & day_dd)
	end if
	
	set month_mm to run script (POSIX file "/Users/IceHe/Documents/AppleScript/Lib/month2mm.scpt") with parameters target_date
	set year_yyyy to year of target_date
	set year_yy to (year_yyyy mod 100)
	
	
	
	############
	# Launch at boot
	############
	
	run script (POSIX file "/Users/IceHe/Documents/AppleScript/Evernote/evernote_launch.scpt")
	
	
	tell application "Evernote"
		
		############
		# Add Notebook
		############
		
		set notebook_name to (year_yyyy & "/" & month_mm) as string
		
		if (notebook named notebook_name) exists then
			log "Notebook Exists {" & notebook_name & "}."
		else
			create notebook notebook_name
			delay 0.2
			log "Created Notebook {" & notebook_name & "}."
		end if
		
		
		
		############
		# Add Time Stat
		############
		
		if (1 = day of target_date) then
			
			run script (POSIX file "/Users/IceHe/Documents/AppleScript/Stat/mv_sp_nt_to_nx_month_nb.scpt") with parameters {target_date - 1 * days}
			
			set stat_note_name to (year_yyyy & "/" & month_mm & " stu spo was") as string
			set target_stat_note_query to ("notebook:\"" & year_yyyy & "/" & month_mm & "\" intitle:\"" & stat_note_name & "\"")
			set target_stat_note to (find notes target_stat_note_query)
			
			if target_stat_note ≠ {} then
				
				log "Target Note Exists {" & target_stat_note_query & "}."
				
			else
				
				set stat_tpl_name to "yyyy/mm stu spo was"
				set stat_tpl_note_query to ("notebook:\"Log\" intitle:\"" & stat_tpl_name & "\"")
				set stat_tpl_note to (find notes stat_tpl_note_query)
				
				if stat_tpl_note = {} then
					log "Note Not Found {" & stat_tpl_note_query & "}!"
					return false
				else if (count of stat_tpl_note) > 1 then
					log (count of stat_tpl_note)
					log "Notes Found > 1 {" & stat_tpl_note_query & "}!"
					return false
				end if
				
				
				
				set stat_tpl_path to "/Users/IceHe/Documents/Enex/time_stat_tpl.enex"
				export stat_tpl_note to (stat_tpl_path as POSIX file)
				
				set (title of item 1 of stat_tpl_note) to "TIME_STAT_TPL"
				import (stat_tpl_path as POSIX file) to notebook_name
				delay 0.5
				# 不知道为什么第二次使用POSIX file stat_tpl_path，就会导致以下类似错误：
				# Result: error "Evernote got an error: Can’t get POSIX file \"/Users/IceHe/Documents/Enex/tpl_day_log.enex\"." number -1728 from file "Macintosh HD:Users:IceHe:Documents:Enex:tpl_day_log.enex"
				# Solve: 好像正确写法是 file_path_str_var as POSIX file
				#		 而非 POSIX file file_path_str_var ！
				
				
				
				set stat_imported_query to ("notebook:\"" & year_yyyy & "/" & month_mm & "\" intitle:\"yyyy/mm stu spo was\"")
				set stat_imported to (find notes stat_imported_query)
				
				if stat_imported = {} then
					log "Note Not Found {" & stat_imported_query & "}!"
					set title of item 1 of stat_tpl_note to stat_tpl_name
					return false
				else if (count of stat_imported) > 1 then
					log "Notes Found > 1 {" & stat_imported_query & "}!"
					set title of item 1 of stat_tpl_note to stat_tpl_name
					return false
				end if
				
				set (title of item 1 of stat_tpl_note) to stat_tpl_name
				set (title of item 1 of stat_imported) to stat_note_name
				
			end if
			
			set stat_note_name to (year_yyyy & "/" & month_mm & " stu spo was") as string
			set target_stat_note_query to ("notebook:\"" & year_yyyy & "/" & month_mm & "\" intitle:\"" & stat_note_name & "\"")
			set target_stat_note to (find notes target_stat_note_query)
			
			if target_stat_note ≠ {} then
				
				log "Target Note Exists {" & target_stat_note_query & "}."
				
			else
				
				set stat_tpl_name to "yyyy/mm stu spo was"
				set stat_tpl_note_query to ("notebook:\"Log\" intitle:\"" & stat_tpl_name & "\"")
				set stat_tpl_note to (find notes stat_tpl_note_query)
				
				if stat_tpl_note = {} then
					log "Note Not Found {" & stat_tpl_note_query & "}!"
					return false
				else if (count of stat_tpl_note) > 1 then
					log (count of stat_tpl_note)
					log "Notes Found > 1 {" & stat_tpl_note_query & "}!"
					return false
				end if
				
				
				
				set stat_tpl_path to "/Users/IceHe/Documents/Enex/time_stat_tpl.enex"
				export stat_tpl_note to (stat_tpl_path as POSIX file)
				
				set (title of item 1 of stat_tpl_note) to "TIME_STAT_TPL"
				import (stat_tpl_path as POSIX file) to notebook_name
				delay 0.5
				# 不知道为什么第二次使用POSIX file stat_tpl_path，就会导致以下类似错误：
				# Result: error "Evernote got an error: Can’t get POSIX file \"/Users/IceHe/Documents/Enex/tpl_day_log.enex\"." number -1728 from file "Macintosh HD:Users:IceHe:Documents:Enex:tpl_day_log.enex"
				# Solve: 好像正确写法是 file_path_str_var as POSIX file
				#		 而非 POSIX file file_path_str_var ！
				
				
				
				set stat_imported_query to ("notebook:\"" & year_yyyy & "/" & month_mm & "\" intitle:\"yyyy/mm stu spo was\"")
				set stat_imported to (find notes stat_imported_query)
				
				if stat_imported = {} then
					log "Note Not Found {" & stat_imported_query & "}!"
					set title of item 1 of stat_tpl_note to stat_tpl_name
					return false
				else if (count of stat_imported) > 1 then
					log "Notes Found > 1 {" & stat_imported_query & "}!"
					set title of item 1 of stat_tpl_note to stat_tpl_name
					return false
				end if
				
				set (title of item 1 of stat_tpl_note) to stat_tpl_name
				set (title of item 1 of stat_imported) to stat_note_name
				
			end if
			
		end if
		
		
		
		############
		# Add Day Log
		############
		
		set note_name to (year_yy & "/" & month_mm & "/" & day_dd & " stu spo") as string
		
		set target_note_query to ("notebook:\"" & year_yyyy & "/" & month_mm & "\" intitle:\"" & note_name & "\"")
		set target_note to find notes target_note_query
		
		if target_note ≠ {} then
			log "Target Note Exists {" & target_note_query & "}."
			return true
		end if
		
		
		
		set tpl_name to "yy/mm/dd stu spo"
		set tpl_note_query to ("intitle:\"" & tpl_name & "\"")
		set tpl_note to (find notes tpl_note_query)
		
		if tpl_note = {} then
			log "Note Not Found {" & tpl_note_query & "}!"
			return false
		else if (count of tpl_note) > 1 then
			log "Notes Found > 1 {" & tpl_note_query & "}!"
			return false
		end if
		
		
		
		set note_tpl_path to "/Users/IceHe/Documents/Enex/tpl_day_log.enex"
		export tpl_note to (note_tpl_path as POSIX file)
		
		set (title of item 1 of tpl_note) to "DAY_LOG_TPL"
		import (note_tpl_path as POSIX file) to notebook_name
		
		
		
		set note_imported to (find notes tpl_note_query)
		
		if note_imported = {} then
			log "Note Not Found {" & tpl_note_query & "}!"
			set title of item 1 of tpl_note to tpl_name
			return false
		else if (count of note_imported) > 1 then
			log "Notes Found > 1 {" & tpl_note_query & "}!"
			set title of item 1 of tpl_note to tpl_name
			return false
		end if
		
		set title of item 1 of tpl_note to tpl_name
		set title of item 1 of note_imported to note_name
		
		synchronize
		delay 0.5
		
	end tell
	
	return true
	
end run