class PagesController < ApplicationController
  before_action :authenticate_admin!

  def index

    if params[:name].present? && !params[:name].nil?
      file_path = Rails.root.join('public', 'pdf', params[:name])
      @reader = PDF::Reader.new(file_path ) if File.exist?(file_path)
    end
    @wrong_sort = 0
    # @response = Nokogiri::HTML(open('https://www.utcourts.gov/cal/index.html'))
    # @response.search('div#origcontent div.col-xs-12.col-sm-4').each do |data|
    #   data.search('ul li a').each do |a_link|
    #     download_link = ENV['SCRAPE_DOMAIN'] + a_link['href']
    #     Pdf.find_or_create_by(download_link: download_link)
    #   end
    # end
    #
    # @response.search('div#origcontent div.col-xs-12.col-sm-6 div.col-xs-12.col-sm-6').each do |data|
    #   data.search('ul li a').each do |a_link|
    #     download_link = ENV['SCRAPE_DOMAIN'] + a_link['href']
    #     Pdf.find_or_create_by(download_link: download_link)
    #   end
    # end
    # Pdf.all.each do |pdf|
    #   download = open(pdf.download_link)
    #   IO.copy_stream(download, Rails.root.join('public', 'pdf', File.basename(pdf.download_link) ))
    # end


    @reader = PDF::Reader.new(Rails.root.join('public', 'pdf', 'BRIGHAM_CITY_Calendar.pdf' ))
    #
    # title = ''
    # court_date = ''
    # court_time = ''
    # @reader.pages.each_with_index do |page, index|
    #   page.text.split(/-------*/).each_with_index do|dot_block, index1|
    #     lines = dot_block.scan(/^.+/)
    #     if index1 == 0
    #       title = lines[0].gsub(/\s+/m, " ").strip
    #       court_date_array = lines[1].gsub(/\s+/m, '  ').strip.split("  ")
    #       court_date = court_date_array[court_date_array.count - 3].to_s + ' ' + court_date_array[court_date_array.count-2].to_s + ' ' + court_date_array[court_date_array.count-1].to_s
    #     end
    #     court_time1 = dot_block.scan(/^2[0-3]|[01][0-9]:?[0-5][0-9]\s[AP]M/)[0].to_s
    #     court_time = court_time1 unless court_time1 == ''
    #     atty_tmp = dot_block[/ATTY:(.*?)OTN:/m, 1].to_s
    #     atty_tmp = dot_block[/ATTY:(.*)/m, 1] if atty_tmp == '' && dot_block.scan(/ATTY:*.+/)[1] != 'ATTY:'
    #
    #     atty = ''
    #     if !atty_tmp.nil? && atty_tmp.split('ATTY:')[1].nil?
    #       atty_tmp = dot_block.scan(/ATTY:*.+/)[1]
    #       atty = atty_tmp.gsub(/ATTY:/, '') unless atty_tmp.nil?
    #     else
    #       atty = atty_tmp.split('ATTY:')[1].gsub(/\s+/m, " ").strip unless atty_tmp.nil?
    #     end
    #
    #     court_date_time = DateTime.parse(court_date + ' ' + court_time)
    #
    #     atty_array = atty.split(',')
    #
    #     atty_array.each do |attorney|
    #       attorney = attorney.gsub(/\s+/m, " ").strip
    #       CourtCalendar.create!(
    #            start_time: court_time,
    #            start_date: Date.parse(court_date),
    #            title: title,
    #            atty_name: attorney
    #       )
    #     end
    #   end
    # end

    # @reader = []
    # Pdf.all.each_with_index do |pdf, index|
    #   @reader[index] = PDF::Reader.new(Rails.root.join('public', 'pdf', File.basename(pdf.download_link) ))
    # end
  end
end


