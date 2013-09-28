class ParesPdf

  def initialize(pdf_url)
    @pdf_url = pdf_url
    @file_tmp = "#{Rails.root}/tmp/pdf_pares"
  end

  def get_cover
    Docsplit.extract_images(@pdf_url, pages: "1", size: '1000x', format: [:png], output: @file_tmp)
    File.open(File.join(@file_tmp, @pdf_url.split("/").last.sub(/.pdf/, "_1.png")))
  end
end