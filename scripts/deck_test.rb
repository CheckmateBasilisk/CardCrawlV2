require 'squib'

$source = '../source/'
$artwork = $source + 'artwork/'
$iconography = $artwork + 'icons/'
$output_dir = '../output/'


input_filename = $source+'cards/input_test.xlsx'
data = Squib.xlsx file: input_filename

Squib::Deck.new cards: data['name'].size, layout: 'card_layout.yml', width: 750, height: 1050 do

  #background color: 'white'
  #rect layout: 'label'
  #rect layout: 'artwork'
  #rect layout: 'name'
  #rect layout: 'descriptor'
  #rect layout: 'text'
  #rect layout: 'info'

  
  rect layout: 'border', fill_color: 'black'
  rect layout: 'border_inner', fill_color: 'white'

  # artwork
  # preppending file locations to each entry
  data['artwork'].map! {|i| "#{$artwork}#{i}"} 
  svg file: data['artwork'], layout: 'artwork'
  # card name
  text str: data['name'], layout: 'name'
  # card icon
  # preppending file locations to each entry
  rect layout: 'type_icon'
  data['type_icon'].map! {|i| "#{$iconography}#{i}"} 
  svg file: data['type_icon'], layout: 'type_icon'
  # type and subtype
  text str: data['descriptor'], layout: 'descriptor'
  # description text with embedded icons
  # joining flavor text with rules
  #data['text'].map!.with_index {|t, idx| "#{t}\n\n<span foreground=\"red\">#{data['flavor'][idx]}</span>"}
  data['text'].map!.with_index {|t, idx| "#{t}\n\n<i>#{data['flavor'][idx]}</i>"}
  text(str: data['text'], layout: 'text', markup: true) do |embed|
    embed.svg key: ':test_icon_hello:', file: $iconography+'/hand.svg',layout: 'icon_text'
    embed.svg key: ':test_icon_world:', file: $iconography+'/earth-america.svg',layout: 'icon_text'
  end
  # extra info
  # appending card count
  data['info'].map!.with_index {|i, idx| "#{i} #{idx+1}/#{data['name'].size}" }
  text str: data['info'], layout: 'info'

  #exporting
  save_png prefix: 'hello_', dir: $output_dir
  #save_sheet prefix: 'sheet_hello_', dir: $output_dir
  save_pdf file: 'pdf_hello_', dir: $output_dir
  
end

