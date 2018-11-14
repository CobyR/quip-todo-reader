def populate_actions document
  document.actions = populate_section document, @action_headers
end

def populate_nexts document
  document.nexts =  populate_section document, @next_headers
end

def populate_section document, headers
  items = false
  values = Array.new
  
  html = Nokogiri::HTML(document.body)
  
  nodes = html.search("*")

  nodes.each_with_index do |node,index|
    #puts "\t\t#{index} - #{node.name} #{node.inner_text}"
    if items == true
      if node.name == "h2"
        items = false
      # No more items
        #puts "End of Items"
      else
        if node.name == "span" && (!node.children.first.nil? && node.children.first.name != "del")
          values << node.inner_text
        end
      end
    else
      #puts "#{headers} #{node.inner_text}"
      if node.name == "h2" and headers.include?(node.inner_text)
        items = true
        # Found Items section
        #puts "Start of Items"
      end
    end
  end

  return values
end
