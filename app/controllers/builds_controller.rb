class BuildsController < ApplicationController
  include BuildsHelper

  # GET /builds
  def index
    @builds = Build.order(:build_created_at)
    @chart_pass_fail = {
      json: build_pass_fail_json,
      width: 600,
      height: 350
    }
    @chart_durn_time = {
      json: build_durn_time_json,
      width: 600,
      height: 350
    }
  end

  # POST /import
  def import
    message = if Importer.import_csv_to_build params[:file]
      'Import finished successfully'
    else
      'Import failed'
    end

    redirect_to root_url, notice: message
  end

  # DELETE /destroy_all
  def destroy_all
    Build.delete_all
    redirect_to root_url, notice: 'All builds was destroyed'
  end
end
