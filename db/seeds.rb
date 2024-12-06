# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'aws-sdk-s3'

# AWS Configuration
region = "us-east-2"
bucket_name = "eileen-db"
file_key = "#{Rails.env.downcase}.sqlite3"

# Local File Path
local_file_path = File.join(Dir.pwd, "db", "#{Rails.env.downcase}.sqlite3")

# Initialize S3 Client
s3_client = Aws::S3::Client.new(
  region: region,
  access_key_id: Rails.application.credentials.dig(:aws, :access_key_id), # Set this as an environment variable
  secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key) # Set this as an environment variable
)

begin
  # List all files in the S3 bucket
  response = s3_client.list_objects_v2(bucket: bucket_name)

  # Filter and sort files based on the timestamp in their filenames
  sorted_files = response.contents
                         .map { |obj| obj.key if obj.key.include?("#{Rails.env.downcase}_") }
                         .compact
                         .sort_by { |file| file.match(/_(\d{14})\.sqlite3$/)[1] }
                         .reverse

  # The latest file
  latest_file_key = sorted_files.first
  puts "Latest file found: #{latest_file_key}"

  # Get File
  File.open(local_file_path, 'wb') do |file|
    s3_client.get_object({ bucket: bucket_name, key: latest_file_key }, target: file)
  end
  puts "File downloaded successfully to #{latest_file_key}"
rescue Exception => e
  puts "Failed to download file: #{e.message}"
end

User.create_with(
  password: "password",
  password_confirmation: "password",
).find_or_create_by(email: "user@example.com")

# Generate a file name with a timestamp
timestamp = Time.now.strftime('%Y%m%d%H%M%S')
file_key = "#{Rails.env.downcase}_#{timestamp}.sqlite3"

begin
  # Upload File
  s3_client.put_object(
    bucket: bucket_name,
    key: file_key,
    body: File.open(local_file_path, 'rb')
  )
  puts "File uploaded successfully to S3://#{bucket_name}/#{file_key}"
rescue Aws::S3::Errors::ServiceError => e
  puts "Failed to upload file: #{e.message}"
end