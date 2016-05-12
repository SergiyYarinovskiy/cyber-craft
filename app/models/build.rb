class Build < ActiveRecord::Base
	ABNORMAL_FAILED = 2
	FAILED 	= 'failed'
	ERROR 	= 'error'
	PASSED 	= 'passed'

	def created_day
		build_created_at.to_date.to_s(:db)
	end

	def created_datetime
		build_created_at.strftime("%FT%H:%M") 
	end

	def passed
		summary_status == PASSED
	end

	def failed
		[FAILED, ERROR].include? summary_status
	end
end
