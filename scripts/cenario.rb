require 'squib'

$source = '../source/'
$artwork = $source + 'artwork/'
$iconography = $artwork + 'icons/'
$output_dir = '../output/'

input_filenames = ['cenario_basic_set.xlsx']
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
    png file: data['artwork'], layout: 'artwork_short', width: :scale
    #svg file: data['artwork'], layout: 'artwork', width: :scale
    # card name
    text str: data['name'], layout: 'name'
    # card icon, uses iconography to make the xmlx easier
    rect layout: 'type_icon'
    # FIXME : mudar a localização do ícone de tipo para todas as cartas??
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
      embed.svg key: 'location', file: $iconography+'castle.svg', layout: 'type_icon'
      embed.svg key: 'event', file: $iconography+'flying-flag.svg', layout: 'type_icon'
      embed.svg key: 'treasure', file: $iconography+'cash.svg', layout: 'type_icon'
      embed.svg key: 'encounter', file: $iconography+'cement-shoes.svg', layout: 'type_icon'
    end

    # set icon
    rect layout: 'set_icon'
    # FIXME: change the way sets are named in .xlsx
    # data['set'].map! {|i| "#{$iconography}/sets/#{i}.svg"}
    data['set'].map! {|i| "#{$iconography}/sets/#{i}"}
    svg file: data['set'], layout: 'set_icon'
    #rect layout: 'additional_icons_right_1'

    # type and subtype
    # building descriptor using type -- subtype
    descriptor = data['type'].map.with_index {|t, idx| "#{t} - #{data['subtype'][idx]}"}
    text str: descriptor, layout: 'descriptor_long_text'
    # joining key and rules
    # FIXME: maybe it is convenient to use an index like the card count in the info instead of a row in the .xlms
    # data['text'].map!.with_index {|t, idx| if data['key'] <=> "" then "<b>[Cenário L#{data['key'][idx]}]</b> – #{t}"  else "LALILULELO"  end }
    #data['text'].map!.with_index {|t, idx| "<b>[Cenário L#{data['key'][idx]}]</b> – #{t}"}
    data['text'].map!.with_index {|t, idx| "<b>[Cenário C#{idx+1}]</b> – #{t}" }
    # joining flavor text and rules
    data['text'].map!.with_index {|t, idx| "#{t}\n\n<i>#{data['flavor'][idx]}</i>"}

    # description text with embedded icons
    text(str: data['text'], layout: 'text_long', markup: true) do |embed|
      #embed.svg key: ':ataque:', file: $iconography+'sabers-choc.svg', layout: 'icon_text'
      embed.svg key: ':damage:', file: $iconography+'spinning-sword.svg', layout: 'icon_text'
      embed.svg key: ':damage_magic:', file: $iconography+'lightning-helix-tiny.svg', layout: 'icon_text'
      embed.svg key: ':defense:', file: $iconography+'checked-shield.svg', layout: 'icon_text'
      # embed.svg key: ':ward:', file: $iconography+'rosa-shield.svg', layout: 'icon_text'
      embed.svg key: ':ward:', file: $iconography+'magic-shield.svg', layout: 'icon_text'
      embed.svg key: ':piercing:', file: $iconography+'shield-impact.svg', layout: 'icon_text'
      embed.svg key: ':accuracy:', file: $iconography+'bullseye.svg', layout: 'icon_text'
      embed.svg key: ':dodge:', file: $iconography+'sprint.svg', layout: 'icon_text'
      embed.svg key: ':encumbrance:', file: $iconography+'swap-bag.svg', layout: 'icon_text'
      embed.svg key: ':range:', file: $iconography+'thrust-bend.svg', layout: 'icon_text'
      embed.svg key: ':tap:', file: $iconography+'rapidshare-arrow.svg', layout: 'icon_text'
      embed.svg key: ':threshold:', file: $iconography+'drop.svg', layout: 'icon_text'
      embed.svg key: ':finesse_large:', file: $iconography+'card-play.svg', layout: 'type_icon'
      embed.svg key: ':intellect_large:', file: $iconography+'book-cover.svg', layout: 'type_icon'
      embed.svg key: ':spirit_large:', file: $iconography+'holy-grail.svg', layout: 'type_icon'
      embed.svg key: ':might_large:', file: $iconography+'death-juice.svg', layout: 'type_icon'
      embed.svg key: ':finesse:', file: $iconography+'card-play-tiny.svg', layout: 'icon_text'
      embed.svg key: ':intellect:', file: $iconography+'book-cover-tiny.svg', layout: 'icon_text'
      embed.svg key: ':spirit:', file: $iconography+'holy-grail.svg', layout: 'icon_text'
      embed.svg key: ':might:', file: $iconography+'death-juice.svg', layout: 'icon_text'
      embed.svg key: ':combat_large:', file: $iconography+'sabers-choc.svg', layout: 'icon_text_large'
      embed.svg key: ':sorcery_large:', file: $iconography+'heraldic-sun.svg', layout: 'icon_text_large'
      embed.svg key: ':tactics_large:', file: $iconography+'black-flag.svg', layout: 'icon_text_large'
      embed.svg key: ':combat:', file: $iconography+'sabers-choc-tiny.svg', layout: 'icon_text'
      embed.svg key: ':sorcery:', file: $iconography+'heraldic-sun-tiny.svg', layout: 'icon_text'
      embed.svg key: ':tactics:', file: $iconography+'black-flag-tiny.svg', layout: 'icon_text'
      embed.svg key: ':time:', file: $iconography+'sands-of-time.svg', layout: 'icon_text'

      embed.svg key: ':[:', file: $iconography+'key_frame_left.svg', layout: 'icon_text_large', width: :scale
      embed.svg key: ':]:', file: $iconography+'key_frame_right.svg', layout: 'icon_text_large', width: :scale
      embed.svg key: ':1:', file: $iconography+'key_frame_middle_1.svg', layout: 'icon_text_large', width: :scale
    end
    # extra info
    # appending card count
    data['info'].map!.with_index {|i, idx| "#{i} ##{curr_card_count + idx+1}/#{total_card_count}" }
    text str: data['info'], layout: 'info'
    curr_card_count += data['info'].size

    #exporting
    #save_png prefix: File.basename(filename, 'xlsx'), dir: $output_dir
    #save_sheet prefix: File.basename(filename, 'xlsx'), dir: $output_dir
    save_pdf file: "#{File.basename(filename, '.xlsx')}.pdf", dir: $output_dir, width: '210mm', height: '297mm'

    # exporting the keys to <filename>_location_keys.md
    # formatting text
    data['text_hidden'].map!.with_index {|t, idx| "----------\n[CENARIO C#{idx+1}] #{data['name'][idx]} –\n#{t}" }
    # TODO: this might be prettier. Consider doing this later?
    #d = data['name'].zip data['text_hidden']
    # actually writing. Will overwrite!
    # FIXME: THIS WILL PRODUCE A NEW KEYS FILE FOR EVERY INPUT FILE. IS THIS WHAT I WANT?
    open($output_dir + "#{File.basename(filename, '.xlsx')}_KEYS.txt", 'w') do |file|
      data['text_hidden'].each { |t| file << "#{t}\n"}
    end
  end

end

