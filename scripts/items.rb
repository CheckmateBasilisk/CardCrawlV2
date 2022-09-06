require 'squib'

$source = '../source/'
$artwork = $source + 'artwork/'
$iconography = $artwork + 'icons/'
$output_dir = '../output/'

input_filenames = ['weapons_basic_set.xlsx', 'armour_basic_set.xlsx', 'misc_basic_set.xlsx']
#input_filenames = ['blank_test_cards.xlsx']
input_filenames.map! {|file| "#{$source}cards/#{file}"}
print '>>>',input_filenames
#
# this stinks... opening every file just to count sounds so weird
# getting total card count
total_card_count = 0
input_filenames.each do |filename|
  data = Squib.xlsx file: filename 
  total_card_count += data['name'].size
end
puts "total card count #{total_card_count}"
curr_card_count = 0

input_filenames.each do |filename|
  data = Squib.xlsx file: filename 
  Squib::Deck.new cards: data['name'].size, layout: 'card_layout.yml', width: 750, height: 1050 do

    rect layout: 'border', fill_color: 'black'
    rect layout: 'border_inner', fill_color: 'white'

    # artwork
    # preppending file locations to each entry
    data['artwork'].map! {|i| "#{$artwork}#{i}"} 
    svg file: data['artwork'], layout: 'artwork_square_center', height: :scale
    #svg file: data['artwork'], layout: 'artwork', width: :scale
    # card name
    text str: data['name'], layout: 'name'
    # card icon, uses iconography to make the xmlx easier
    rect layout: 'type_icon'
    text(str: data['type_icon'], layout: 'type_icon') do |embed|
      embed.svg key: 'head', file: $iconography+'pointy-hat.svg', layout: 'type_icon'
      embed.svg key: 'hand1', file: $iconography+'gloves(1).svg', layout: 'type_icon'
      embed.svg key: 'hand2', file: $iconography+'gloves.svg', layout: 'type_icon'
      embed.svg key: 'body', file: $iconography+'shirt.svg', layout: 'type_icon'
      embed.svg key: 'robe', file: $iconography+'robe.svg', layout: 'type_icon'
      embed.svg key: 'feet', file: $iconography+'leather-boot.svg', layout: 'type_icon'
      embed.svg key: 'amulet', file: $iconography+'rune-stone.svg', layout: 'type_icon' # TODO: vai ter amuleto separado de acessório?
      embed.svg key: 'accessory', file: $iconography+'power-ring.svg', layout: 'type_icon'
      embed.svg key: 'necklace', file: $iconography+'trinket.svg', layout: 'type_icon'
      embed.svg key: 'treasure', file: $iconography+'swap-bag.svg', layout: 'type_icon'
      embed.svg key: 'misc', file: $iconography+'jeweled-chalice.svg', layout: 'type_icon'
      embed.svg key: 'blank', file: $iconography+'blank.svg', layout: 'type_icon'
      embed.svg key: 'finesse', file: $iconography+'card-play.svg', layout: 'type_icon'
      embed.svg key: 'intellect', file: $iconography+'book-cover.svg', layout: 'type_icon'
      embed.svg key: 'spirit', file: $iconography+'holy-grail.svg', layout: 'type_icon'
      embed.svg key: 'might', file: $iconography+'death-juice.svg', layout: 'type_icon'
      embed.svg key: 'combat', file: $iconography+'sabers-choc.svg', layout: 'icon_text_large'
      embed.svg key: 'sorcery', file: $iconography+'heraldic-sun.svg', layout: 'icon_text_large'
      embed.svg key: 'dm', file: $iconography+'rule-book.svg', layout: 'type_icon'
      embed.svg key: 'player', file: $iconography+'rolling-dices.svg', layout: 'type_icon'

    end
    # type and subtype
    # building descriptor using type -- subtype
    descriptor = data['type'].map.with_index {|t, idx| "#{t} - #{data['subtype'][idx]}"}
    text str: descriptor, layout: 'descriptor'
    # description text with embedded icons
    # joining flavor text with rules
    data['text'].map!.with_index {|t, idx| "#{t}\n\n<i>#{data['flavor'][idx]}</i>"}
    text(str: data['text'], layout: 'text', markup: true) do |embed|
      #embed.svg key: ':ataque:', file: $iconography+'sabers-choc.svg', layout: 'icon_text'
      embed.svg key: ':damage:', file: $iconography+'spinning-sword.svg', layout: 'icon_text'
      embed.svg key: ':defense:', file: $iconography+'checked-shield.svg', layout: 'icon_text'
      embed.svg key: ':piercing:', file: $iconography+'shield-impact.svg', layout: 'icon_text'
      embed.svg key: ':accuracy:', file: $iconography+'bullseye.svg', layout: 'icon_text'
      embed.svg key: ':dodge:', file: $iconography+'sprint.svg', layout: 'icon_text'
      embed.svg key: ':encumbrance:', file: $iconography+'swap-bag.svg', layout: 'icon_text'
      embed.svg key: ':range:', file: $iconography+'thrust-bend.svg', layout: 'icon_text'
      embed.svg key: ':tap:', file: $iconography+'rapidshare-arrow.svg', layout: 'icon_text'
      embed.svg key: ':threshold:', file: $iconography+'drop.svg', layout: 'icon_text'
      embed.svg key: ':finesse:', file: $iconography+'card-play.svg', layout: 'type_icon'
      embed.svg key: ':intellect:', file: $iconography+'book-cover.svg', layout: 'type_icon'
      embed.svg key: ':spirit:', file: $iconography+'holy-grail.svg', layout: 'type_icon'
       embed.svg key: ':might:', file: $iconography+'death-juice.svg', layout: 'type_icon'
      # embed.svg key: ':combat:', file: $iconography+'sabers-choc.svg', layout: 'icon_text_large'
      # embed.svg key: ':sorcery:', file: $iconography+'heraldic-sun.svg', layout: 'icon_text_large'
      embed.svg key: ':combat:', file: $iconography+'sabers-choc.svg', layout: 'icon_text'
      embed.svg key: ':sorcery:', file: $iconography+'heraldic-sun.svg', layout: 'icon_text'
    end
    # extra info
    # appending card count
    data['info'].map!.with_index {|i, idx| "#{i} ##{curr_card_count + idx+1}/#{total_card_count}" }
    text str: data['info'], layout: 'info'
    curr_card_count += data['info'].size

    #exporting
    #save_png prefix: File.basename(filename, 'xlsx'), dir: $output_dir
    #save_sheet prefix: File.basename(filename, 'xlsx'), dir: $output_dir 
    save_pdf file: "#{File.basename(filename, '.xlsx')}.pdf", dir: $output_dir
  end

end
