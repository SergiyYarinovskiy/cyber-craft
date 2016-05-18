require 'spec_helper'

describe Build do
  describe '#created_day' do
    it 'returns builds grouped by day' do
      create(:build, { build_created_at: Date.today.beginning_of_day + 1.hours })
      create(:build, { build_created_at: Date.today.beginning_of_day + 3.hours })
      builds_for_today = Build.all.group_by(&:created_day)[Date.today.to_s(:db)]
      expect(builds_for_today.size).to eql 2
    end
  end

  describe '#created_datetime' do
    it 'retuns build creation date in specific format' do
      build = create(:build, { build_created_at: Date.today.beginning_of_day })
      expect(build.created_datetime)
        .to eql build.build_created_at.strftime('%FT%H:%M')
    end
  end

  describe '#passed' do
    it 'retuns true for passed build' do
      build = create(:build, { summary_status: 'passed' })
      expect(build.passed).to eql true
    end
  end

  describe '#failed' do
    it 'retuns true for failed build' do
      build = create(:build, { summary_status: 'failed' })
      expect(build.failed).to eql true
    end

    it 'retuns true for build with error' do
      build = create(:build, { summary_status: 'error' })
      expect(build.failed).to eql true
    end
  end
end # describe Build
