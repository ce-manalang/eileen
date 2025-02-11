class BlogsController < ApplicationController
  def index
    google_sheets_service = GoogleSheetsService.new
    spreadsheet_id = Rails.application.credentials.spreadsheet_id
    blog_data = google_sheets_service.get_articles(spreadsheet_id)

    render json: blog_data
  end

  def show
    google_sheets_service = GoogleSheetsService.new
    spreadsheet_id = Rails.application.credentials.spreadsheet_id
    blog_data = google_sheets_service.get_article(spreadsheet_id, params[:slug])

    render json: blog_data
  end
end
