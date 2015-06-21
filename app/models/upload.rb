class Upload < ActiveRecord::Base

  has_attached_file :upload

  validates_presence_of :upload
  validates_attachment :upload, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment_file_name :upload, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE"
    }
  end
end
