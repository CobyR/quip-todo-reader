require 'dotenv'
require 'quip'
require 'date'
require 'colorize'
require 'nokogiri'
require File.join(File.dirname(__FILE__), 'lib/quip.rb')

# Load .env file
Dotenv.load File.join(File.dirname(__FILE__),".env")

# populate values from .env variables
selves = ENV['SELF'].split(",")
@action_headers = ENV['ACTIONS'].split(",")
@next_headers = ENV['NEXT'].split(",")

client = Quip::QuipClient.new(access_token: ENV['QUIP_TOKEN'])
user = client.get_authenticated_user()
folder = client.get_folder(ENV['FOLDER_ID'])

if folder['error_code']
  puts "#{folder['error_description']}"
else

  puts "There are #{folder['children'].length} items in your '#{folder['folder']['title'].yellow}' Folder."

  x = 0

  documents = []

  Struct.new("Document",
             :title,
             :updated_at,
             :type,
             :id,
             :who,
             :body,
             :actions,
             :nexts,
             :link)

  folder['children'].each do |child|
    x += 1

    doc = client.get_thread(child['thread_id'])

    if doc['thread']

      document = Struct::Document.new
      document.nexts = Array.new
      document.actions = Array.new
      document.title = doc['thread']['title']
      document.id = doc['thread']['id']
      document.updated_at = Time.at(doc['thread']['updated_usec']/1_000_000).to_datetime
      document.type = doc['thread']['type']
      document.body = doc['html']
      document.link = doc['thread']['link']

      document.who = document.title.
                       gsub("Level","").
                       gsub("level","").
                       gsub("Notes","").
                       gsub("1:1","").
                       gsub("/","").
                       gsub("Skip","").
                       gsub("-","").
                       chomp

      ENV['SELF'].split(",").each do |self_name|
        self_name.rstrip!
        self_name.lstrip!
        document.who.gsub!(self_name,"")
      end

      document.who.lstrip!
      document.who.rstrip!

      # Actions
      populate_actions document

      populate_nexts document

      #print "#{document.id.yellow} - #{document.type.red} - "
      if document.actions.count > 0 || document.nexts.count > 0
        print document.title.green
        print " - "
        print document.updated_at.strftime("%B %-d, %Y @ %H:%M %z").white
        print " - "
        print document.who.magenta
        print " - "
        print "#{document.actions.count}, #{document.nexts.count}"
        print " - "
        print document.link.blue
        print "\n"
        if document.actions.count > 0  && document.actions.first.length > 0
           print "\tCommitments\n".red
          document.actions.each do |action|
            print "\t\t#{action.red}\n"
          end
        end
        if document.nexts.count > 0
          print "\tNext Time\n".light_blue
          document.nexts.each do |item|
            print "\t\t#{item.light_blue}\n"
          end
        end
      end

      documents << document
      if x == 2
        # puts doc
      end
    else
      #puts doc['error_code']
    end
  end
end
