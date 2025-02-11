class GoogleSheetsService
  def initialize
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: StringIO.new(GOOGLE_SHEETS_CREDENTIALS.to_json),
      scope: SCOPES
    )
  end

  def get_articles(spreadsheet_id, range = 'Articles!A2:I')
    response = @service.get_spreadsheet_values(spreadsheet_id, range)
    response.values.map do |v|
      {
        id: v[0],
        slug: v[1],
        title: v[2],
        date: v[3],
        blurb: v[4],
        body: ActionController::Base.helpers.raw(v[5]),
        image_urls: v[6].split(","),
        prev_comic_slug: v[7],
        next_comic_slug: v[8],
      }
    end
  end

  def get_article(spreadsheet_id, slug, range = 'Articles!A2:I')
    response = @service.get_spreadsheet_values(spreadsheet_id, range)
    v = response.values.find { |z| z[1] == slug }

    {
      id: v[0],
      slug: v[1],
      title: v[2],
      date: v[3],
      blurb: v[4],
      body: v[5],
      image_urls: v[6].split(","),
      prev_comic_slug: v[7],
      next_comic_slug: v[8],
    }
  end
end