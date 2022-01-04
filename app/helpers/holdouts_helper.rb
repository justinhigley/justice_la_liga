module HoldoutsHelper
	def holdout?(yrs, ytd_score, holdout_score, salary, holdout_salary)
		if yrs.nil?
			false
		elsif (yrs > 1) && (ytd_score > holdout_score) && (salary < holdout_salary)
			true
		else
			false
		end
	end
end
