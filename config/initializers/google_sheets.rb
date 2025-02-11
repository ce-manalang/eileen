require 'google/apis/sheets_v4'
require 'googleauth'

GOOGLE_SHEETS_CREDENTIALS = Rails.application.credentials.google_sheets

SCOPES = ['https://www.googleapis.com/auth/spreadsheets']