module BuildsHelper
  def build_pass_fail_json
    return {} unless @builds

    @grouped_builds = pass_fail_builds_by_day
    @failed_values = @grouped_builds.values.map(&:last)
    abnormal_coef = calc_abnormal
    offset = calc_offset

    offset_failed = @grouped_builds.values.map do |value|
      abnormal(value.first, value.last, abnormal_coef) ? offset : 0
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
        'label': { 'text': "Created at\nAbnormal failed builds are pushed up"
        },
        'labels': @grouped_builds.keys
      },
      'series': [
        {'values': @grouped_builds.values.map(&:first)},
        {
          'values': @failed_values,
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
      grouped_data[key] = [
        value.select(&:passed).count,
        value.select(&:failed).count
      ]
    end
  end

  # Abnormal calculation:
  # Calculate coefficient as avarage failed / passed for each day
  # If passed == 0 it is abnormal
  # If failed presents, passed presents and faield / passed for that
  # day higher than coeficient more then for 10 % it is also abnormal

  def abnormal(passed_count, failed_count, abnormal_coef)
    return false if abnormal_coef.zero? || failed_count.zero?
    return true if passed_count.zero?
    coefficient = failed_count.to_f / passed_count
    return false if coefficient < abnormal_coef
    true
  end

  def calc_abnormal
    return 0 if @grouped_builds.empty?
    coefficients = @grouped_builds.values.map do |build_values|
      build_values.first.zero? ? 0 : build_values.last.to_f / build_values.first
    end
    coefficients = coefficients.select { |coef| coef > 0 }
    abnormal = coefficients.inject { |sum, elem| sum + elem } / coefficients.size
    (abnormal + abnormal * 0.1).round(8)
  end

  def calc_offset
    [(@failed_values.max.to_f / 10).round, 1].max
  end
end
