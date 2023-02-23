class ErrorSerializer
  def self.not_found(message)
    {
      "message": "No record found",
      "errors": message
    }
  end
end