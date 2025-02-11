# 📝 Blog API (Google Sheets-powered)

This is a lightweight Ruby on Rails API that serves blog articles from a **Google Sheets** spreadsheet. It supports listing articles with optional pagination and fetching a single article by `slug`.

## ✨ Features

- 🗂 List blog articles from a Google Sheet
- 🔍 Show a single article by slug
- 📄 Supports optional pagination (via [Kaminari](https://github.com/kaminari/kaminari))
- 🔐 Reads data using a Google Service Account

## 🔧 Setup

1. Clone the repo

```bash
git clone git@github.com:ce-manalang/eileen.git
cd eileen
bundle install
```

2. Set your credentials

Store your Google Service Account JSON in an environment variable, for example:

```bash
export GOOGLE_SHEETS_CREDENTIALS='{"type": "service_account", ...}'
```

Then store your Google Sheets spreadsheet_id in Rails credentials:

```bash
EDITOR="code --wait" bin/rails credentials:edit
```

Add:

```bash
spreadsheet_id: your_google_sheet_id_here
```

3. Start the Rails server

```bash
bin/rails server
```

## 📚 API Endpoints

`GET /comics`
Returns all blog articles from the sheet.

**Query Parameters (optional)**

| Param	| Description |
|-------|-------------|
| `page` | Page number for pagination |
| `per_page` |	Number of items per page (default: 10) |

**Example**

```bash
curl http://localhost:3000/comics
```

**Paginated Response**

```json
{
  "posts": [ ... ],
  "pagination": {
    "current_page": 1,
    "next_page": 2,
    "prev_page": null,
    "total_pages": 5,
    "total_count": 45
  }
}
```

`GET /comics/:slug`

Fetches a single article by its slug.

**Example**

```bash
curl http://localhost:3001/comics/my-comic-slug
```

**Response**

```json
{
  "id": "1",
  "slug": "my-article-slug",
  "title": "My Article",
  "date": "2024-11-01",
  "blurb": "Short summary...",
  "body": "<p>Full HTML content here</p>",
  "image_urls": ["https://example.com/img1.jpg", "https://example.com/img2.jpg"],
  "prev_comic_slug": "previous-slug",
  "next_comic_slug": "next-slug"
}
```

## 🧠 How It Works

- `BlogsController` handles the API requests.
- `GoogleSheetsService` reads data from the "Articles" tab of the connected spreadsheet `(Articles!A2:I)`.
- Each row represents one article with the following structure:

| Column | Field |
|--------|-------|
| A	| ID |
| B	| Slug |
| C	| Title |
| D	| Date |
| E	| Blurb |
| F	| Body (HTML) |
| G	| Image URLs (CSV) |
| H	| Prev Slug |
| I	| Next Slug |

## 🛠 Built With

- [Ruby on Rails](https://rubyonrails.org/)
- Google Sheets API
- [Kaminari](https://github.com/kaminari/kaminari) for pagination

## 📩 Contact
If you have questions or suggestions, feel free to open an issue or reach out via [cecillemanalang@gmail.com].