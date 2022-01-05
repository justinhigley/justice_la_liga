module HoldoutsHelper
	def holdout?(yrs, ytd_score, holdout_score, salary, holdout_salary)
		if yrs.nil?
			'<div class="p-1 shadow-sm bg-green-500 text-semibold text-white text-center rounded-full">Clear</div>'.html_safe
		elsif (yrs > 1) && (ytd_score > holdout_score) && (salary < holdout_salary)
			'<div class="p-1 shadow-sm bg-red-500 text-semibold text-white text-center rounded-full">Holdout</div>'.html_safe
		else
			'<div class="p-1 shadow-sm bg-green-500 text-semibold text-white text-center rounded-full">Clear</div>'.html_safe
		end
	end
end
