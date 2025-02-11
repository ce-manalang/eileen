class BlogsController < ApplicationController
  def index
    google_sheets_service = GoogleSheetsService.new
    spreadsheet_id = Rails.application.credentials.spreadsheet_id
    blog_data = google_sheets_service.get_articles(spreadsheet_id)

    if params[:page].nil? && params[:page].nil?
      render json: {
        posts: blog_data
      }
    else
      paginated_articles = Kaminari.paginate_array(blog_data)
        .page(params[:page])
        .per(params[:per_page] || 10)

      render json: {
        posts: paginated_articles,
        pagination: {
          current_page: paginated_articles.current_page,
          next_page: paginated_articles.next_page,
          prev_page: paginated_articles.prev_page,
          total_pages: paginated_articles.total_pages,
          total_count: paginated_articles.total_count,
        }
      }
    end
  end

  def show
    google_sheets_service = GoogleSheetsService.new
    spreadsheet_id = Rails.application.credentials.spreadsheet_id
    blog_data = google_sheets_service.get_article(spreadsheet_id, params[:slug])

    render json: blog_data
  end
end
