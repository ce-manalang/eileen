class GoogleSheetsService
  def initialize
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: StringIO.new(GOOGLE_SHEETS_CREDENTIALS.to_json),
      scope: SCOPES
    )
  end

  def get_articles(spreadsheet_id, range = 'Articles!A2:G')
    response = @service.get_spreadsheet_values(spreadsheet_id, range)
    response.values.map do |v|
      {
        id: v[0],
        href: v[1],
        image_alt: v[2],
        image_src: v[3],
        date: v[4],
        title: v[5],
        short_desc: v[6]
      }
    end
  end

  def get_article(spreadsheet_id, slug, range = 'Articles!A2:H')
    response = @service.get_spreadsheet_values(spreadsheet_id, range)
    v = response.values.find { |z| z[1] == slug }

    {
      id: v[0],
      href: v[1],
      image_alt: v[2],
      image_src: v[3],
      date: v[4],
      title: v[5],
      short_desc: v[6],
      desc: v[7],
    }
  end
end