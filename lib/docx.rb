class Docx
  def self.from_markdown(cv)
    output_docx_file = "tmp/#{cv.user.username}.docx"
    tmp_markdown_file = "tmp/#{cv.user.username}.md"
    File.open tmp_markdown_file, 'w' do |md_file|
      md_file.puts cv.markdown
    end
    `pandoc "#{tmp_markdown_file} -o "#{output_docx_file}"`
    output_docx_file
  end
end
