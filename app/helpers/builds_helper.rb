module BuildsHelper
	def build_pass_fail_json
		return {} unless @builds

		grouped_builds = pass_fail_builds_by_day
		failed_values = grouped_builds.values.map(&:last)
		offset_failed = failed_values.map do |value|
			value > Build::ABNORMAL_FAILED ? 1 : 0
		end

		{
	    'type': 'bar',
	    'title': {
	    	'text': 'Passing and failing builds per day',
  			'offset-y': -12
	    },
	    'labels': [
		    {
		      'text': 'Passed',
		      'x': '90%',
		      'y': '0%',
		      'background-color': '#29A2CC',
		      'font-size': 14,
		      'height': '10%',
		      'width': '10%',
		      'border-radius': '5px'
		    },
		    {
		      'text': 'Failed',
		      'x': '90%',
		      'y': '12%',
		      'background-color': '#D31E1E',
		      'font-size':14,
		      'height': '10%',
		      'width': '10%',
		      'border-radius': '5px'
		    }
		  ],
		  'plotarea': {'adjust-layout': true},
      'plot': {'border-radius': '5px'},
  		'scale-x': {
  			'label': { 'text': "Created at\nAbnormal (more then " \
  				"#{Build::ABNORMAL_FAILED}) failed builds are pushed up"
  			},
  			'labels': grouped_builds.keys
  		},
	    'series': [
	      {'values': grouped_builds.values.map(&:first)},
	      {
	      	'values': failed_values,
	      	'offset-values': offset_failed
	      }
	    ]
	  }
	end

  def build_durn_time_json
		return {} unless @builds
		{
		  'type': 'area',
	    'title': {
	    	'text': 'Build duration vs. time',
  			'offset-y': -12
	    },
	    'plotarea': {'adjust-layout': true},
		  'scale-x': {
		  	'label': {'text': 'Created at',},
		    'labels': @builds.map(&:created_datetime)
		  },
		  'series': [
		  	{'values': @builds.map(&:duration)}
		  ]
		}
  end

  private

	def pass_fail_builds_by_day
    grouped_data = @builds.group_by(&:created_day)
    grouped_data.each do |key, value|
      grouped_data[key] =
        [value.select(&:passed).count, value.select(&:failed).count]
    end
  end
end # BuildsHelper
