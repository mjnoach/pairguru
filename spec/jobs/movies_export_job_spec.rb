require "rails_helper"

describe MoviesExportJob, type: :job do
  include ActiveJob::TestHelper
  let!(:current_user) { create(:user) }

  it 'queues movies export job' do
    file_path = "tmp/movies.csv"
    have_enqueued_job 0
    MoviesExportJob.perform_later(current_user, file_path)
    have_enqueued_job 1
  end
end
