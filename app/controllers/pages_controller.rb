class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
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


    @reader = PDF::Reader.new(Rails.root.join('public', 'pdf', 'AMERICAN_FORK_Calendar.pdf' ))


    # @reader = []
    # Pdf.all.each_with_index do |pdf, index|
    #   @reader[index] = PDF::Reader.new(Rails.root.join('public', 'pdf', File.basename(pdf.download_link) ))
    # end
  end
end
