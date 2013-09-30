class ParesPdf
  include CarrierWave::RMagick

  def initialize(pdf_url)
    @pdf_url = pdf_url
    @file_tmp = "#{Rails.root}/tmp/pdf_pares"
  end

  def get_cover
    image_path = File.join(@file_tmp, @pdf_url.split("/").last.sub(/.pdf/, "_1.png"))
    Docsplit.extract_images(@pdf_url, pages: "1", format: [:png], output: @file_tmp)
    File.open image_path
  ensure
    File.delete image_path
  end
end