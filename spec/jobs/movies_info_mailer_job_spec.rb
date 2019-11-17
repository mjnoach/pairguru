require "rails_helper"

describe "MoviesInfoMailerJob", type: :job do
  include ActiveJob::TestHelper
  let(:current_user) { create(:user) }
  let(:movie) { create(:movie) }

  it 'queues movies info mailer job' do
    file_path = "tmp/movies.csv"
    have_enqueued_job 0
    MovieInfoMailer.send_info(current_user, movie).deliver_later
    have_enqueued_job 1
  end
end
