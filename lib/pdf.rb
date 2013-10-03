class Pdf
  def self.from_markdown(cv)
    binding.pry
    output_pdf_file = "tmp/#{cv.user.username}.pdf"
    tmp_markdown_file = "tmp/#{cv.user.username}.md"
    File.open tmp_markdown_file, 'w' do |md_file|
      md_file.puts cv.markdown
    end
    `pandoc "#{tmp_markdown_file}" -o "#{output_pdf_file}"`
    output_pdf_file
  end
end
