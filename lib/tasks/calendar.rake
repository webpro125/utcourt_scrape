namespace :calendar do
  desc "Update Court Calendar table"

  task download: :environment do
    dir_path = Rails.root.join('public', 'pdf')
    puts 'remove existing files'
    Pdf.delete_all
    Dir.foreach(dir_path) {|f| fn = File.join(dir_path, f); File.delete(fn) if f != '.' && f != '..'}
    puts 'remove is done'
    puts 'start downloading'
    @response = Nokogiri::HTML(open('https://www.utcourts.gov/cal/index.html'))
    @response.search('div#origcontent div.col-xs-12.col-sm-4').each do |data|
      data.search('ul li a').each do |a_link|
        download_link = ENV['SCRAPE_DOMAIN'] + a_link['href']
        Pdf.find_or_create_by(download_link: download_link)
      end
    end

    @response.search('div#origcontent div.col-xs-12 div.col-xs-12.col-sm-3').each do |data|
      data.search('ul li a').each do |a_link|
        download_link = ENV['SCRAPE_DOMAIN'] + a_link['href']
        Pdf.find_or_create_by(download_link: download_link)
      end
    end
    Pdf.all.each do |pdf|
      download = open(pdf.download_link)
      IO.copy_stream(download, Rails.root.join('public', 'pdf', File.basename(pdf.download_link) ))
    end

    puts 'downloading pdf is finished'
  end

  task update_calendar: :environment do
    CourtCalendar.delete_all
    AttorneyUser.delete_all
    Pdf.find_each do |pdf_data|
      file_path = Rails.root.join('public', 'pdf', File.basename(pdf_data.download_link))
      # file_path = Rails.root.join('public', 'pdf', 'SLC_Calendar.pdf')
      puts 'path: ' + file_path.to_s
      next unless File.exist?(file_path)

      puts 'File Existing: ' + File.exist?(file_path).to_s

      @reader = PDF::Inspector::Page.analyze(Rails.root.join('public', 'pdf', file_path ))

      title = ''
      court_date = ''
      court_time = ''
      judge = ''

      @reader.pages.each_with_index do |page, index|
        # puts 'Page Number: ' + (index + 1).to_s
        vs_array = page[:strings].each_index.select{|i| page[:strings][i].match(/VS\./)}
        split_string_array = page[:strings].each_index.select{|i| page[:strings][i].match(/-------*/)}
        atty_array = []
        second_atty_array = []
        vs_skip = 0

        hearing_type = ''
        case_number = nil

        # get all vs attorneys and below attorneys(named secondary) array in one page
        vs_array.each_with_index do |vs, vindex|
          atty_array << page[:strings][vs + 1].match(/ATTY:*.+/).to_s.gsub(/ATTY:/, '')
          second_atty_array[vindex] = []
          n = vs + 2
          loop do
            break if page[:strings][n].nil? or page[:strings][n].gsub(/\s+/m, " ").strip.to_s == '' or page[:strings][n].match(/OTN:*./)
            second_atty_array[vindex] << page[:strings][vs + 2] unless page[:strings][vs + 2].match(/AKA */)
            n += 1
          end
        end

        # this might not be needed
        page[:strings].join(" ").split(/-------*/).each_with_index do|dot_block, index1|
          dot_block1 = dot_block

          if index1 == 0
            judge = ''
            title = page[:strings][0].gsub(/\s+/m, " ").strip
            court_date_array = page[:strings][2].gsub(/\s+/m, '  ').strip.split("  ")
            court_date = court_date_array[court_date_array.count - 3].to_s + ' ' + court_date_array[court_date_array.count-2].to_s + ' ' + court_date_array[court_date_array.count-1].to_s
            court_date_array.each_with_index do |data, index|
              break if index == court_date_array.count - 3
              judge = judge + ' ' + data
            end

            hearing_type = page[:strings][6].to_s.sub(/^2[0-3]|[01][0-9]:?[0-5][0-9]\s[AP]M/, '').gsub(/-|\d\s?/, "") unless page[:strings][6].nil?
            case_number = page[:strings][7].to_s.gsub(/[^0-9 ]/i, '')
          else
            hearing_type = page[:strings][split_string_array[index1 - 1] + 2].to_s.sub(/^2[0-3]|[01][0-9]:?[0-5][0-9]\s[AP]M/, '').gsub(/-|\d\s?/, "") unless split_string_array[index1 - 1].nil?
            case_number = page[:strings][split_string_array[index1 - 1] + 3].to_s.gsub(/[^0-9 ]/i, '') unless split_string_array[index1 - 1].nil?
          end
          case_number_array = case_number.split(' ')
          case_number = case_number_array[case_number_array.length - 1]

          court_time1 = dot_block.scan(/^2[0-3]|[01][0-9]:?[0-5][0-9]\s[AP]M/)[0].to_s
          court_time = court_time1 unless court_time1 == ''

          vs_match = dot_block.scan(/VS\./)[0].to_s
          if vs_match.nil?
            vs_match = ''
          else
            vs_match = vs_match.gsub(/\s+/m, " ").strip
          end

          if vs_match == ''
            vs_skip += 1
          end

          # atty_tmp = dot_block[/ATTY:(.*?)OTN:/m, 1].to_s
          # atty_tmp = dot_block[/ATTY:(.*)/m, 1] if atty_tmp == '' && dot_block.scan(/ATTY:*.+/)[1] != 'ATTY:'
          #
          # atty = ''
          #
          # if !atty_tmp.nil? && atty_tmp.split('ATTY:')[1].nil?
          #   atty_tmp = dot_block.scan(/ATTY:*.+/)[1]
          #   atty = atty_tmp.gsub(/ATTY:/, '') unless atty_tmp.nil?
          # else
          #   atty = atty_tmp.split('ATTY:')[1].gsub(/\s+/m, " ").strip unless atty_tmp.nil?
          # end
          #
          # atty = atty_tmp.split('ATTY:')[1].gsub(/\s+/m, " ").strip unless atty_tmp.nil? || atty_tmp == ""
          defendant_name = dot_block[/VS.(.*?)ATTY:/m, 1].to_s

          # court_date_time = DateTime.parse(court_date + ' ' + court_time)

          # atty_array = atty.split(',')
          #
          # atty_array.each do |attorney|

          if vs_match != ''
            attorney = atty_array[index1 - vs_skip].to_s.gsub(/\s+/m, " ").strip unless atty_array[index1 - vs_skip].nil?
          else attorney = '' end

          if !attorney.nil? and attorney.match(/MB - FAIL TO OBTAIN A BUSINESS LICENSE/)
            attorney = ''
          end

          # Check block only includes page of string
          next if dot_block1.gsub(/\s+/m, " ").match(/Page(\s)(\d+)(\s)of/) && case_number.to_s.gsub(/\s+/m, " ").strip == '' && attorney == ''

          # if index > 4 and index < 8
          # puts 'Dot Block: ' + index1.to_s
          # puts 'Case Number: ' + case_number.to_s
          # puts 'Attorney: ' + attorney.to_s
          # end

          court_location = CourtLocation.find_or_create_by!(name: title)

          if !attorney.nil? && attorney != '' && court_time != ''
            atty_full_name_array = attorney.split(',')
            attorney_last_name = atty_full_name_array[0].gsub(/\s+/m, " ").strip

            if atty_full_name_array[1].nil?
              attorney_first_name = ''
            else
              attorney_first_name = atty_full_name_array[1].gsub(/\s+/m, " ").strip
            end

            court_calendar = court_location.court_calendars.build(
                start_time: court_time,
                start_date: Date.parse(court_date),
                atty_last_name: attorney_last_name.downcase,
                atty_first_name: attorney_first_name.downcase,
                defendant_name: defendant_name,
                judge: judge,
                hearing_type: hearing_type,
                case_number: case_number
            )

            court_calendar.save!

            attorney_user = AttorneyUser.find_or_initialize_by(first_name: attorney_first_name.downcase.capitalize, last_name: attorney_last_name.downcase.capitalize)
            attorney_user.save
          end

          if !second_atty_array[index1 - vs_skip].nil?  && court_time != ''
            second_atty_array[index1 - vs_skip] = second_atty_array[index1 - vs_skip].uniq
            second_atty_array[index1 - vs_skip].each do |ssa|
              ssa = ssa.gsub(/\s+/m, " ").strip.to_s
              ssa = ssa.gsub(/ATTY:/, '').gsub(/\s+/m, " ").strip.to_s unless ssa.nil?

              if !ssa.nil? && ssa != ""
                atty_full_name_array = ssa.split(',')
                attorney_last_name = atty_full_name_array[0].gsub(/\s+/m, " ").strip

                if atty_full_name_array[1].nil?
                  attorney_first_name = ''
                else
                  attorney_first_name = atty_full_name_array[1].gsub(/\s+/m, " ").strip
                end

                court_calendar = court_location.court_calendars.build(
                    start_time: court_time,
                    start_date: Date.parse(court_date),
                    atty_last_name: attorney_last_name.downcase,
                    atty_first_name: attorney_first_name.downcase,
                    defendant_name: defendant_name,
                    judge: judge,
                    hearing_type: hearing_type,
                    case_number: case_number
                )
                court_calendar.save!

                attorney_user = AttorneyUser.find_or_initialize_by(first_name: attorney_first_name.downcase.capitalize, last_name: attorney_last_name.downcase.capitalize)
                attorney_user.save
              end
            end

          end
        end
      end
    end

  end

  Rake::Task["calendar:download"].enhance do
    Rake::Task["calendar:update_calendar"].invoke
  end

  task notify_today_court: :environment do
    ['edward@stonelawfirm.net', 'sokomheng89@gmail.com'].each do |email|
      UserMailer.notify_today_court(email).deliver_later
    end
  end
end
