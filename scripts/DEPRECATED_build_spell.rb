require 'Squib'
require 'tk'

#gets the input file
data = Squib.xlsx file: Tk.getOpenFile
Squib::Deck.new(cards: data['name'].size, layout: 'card_layout.yml', width:750, height: 1050) do #larger
#Squib::Deck.new(cards: data['name'].size, layout: 'card_layout.yml') do

  background color: 'white'

  rect layout: 'name'
  rect layout: 'tier'
  rect layout: 'artwork'
  rect layout: 'descriptor'
  rect layout: 'text'
  rect layout: 'info'

  png file: data['artwork'], layout: 'artwork'
  #png file: '..\artwork\Warlock_Frame_default.png'
  text str: data['name'], layout: 'name'
  text str: data['tier'], layout: 'tier'
  text str: data['descriptor'], layout: 'descriptor'
  text str: data['text'], layout: 'text'
  text str: data['info'], layout: 'info'

  rect layout: 'inside'

  #choose output directory
  $direc = Tk.chooseDirectory
  #save_png prefix: 'output_sorceries_', dir: $direc
  save_sheet prefix: 'output_sorceries_full_', dir: $direc
  #save_pdf file: 'output_sorceries.pdf', dir: $direc

end

#card BACKSIDE
Squib::Deck.new(cards: data['name'].size, layout: 'card_layout.yml', width: 750, height: 1050) do
  rect layout: 'border', fill_color:'white'

  png file: '..\artwork\Warlock_Logo_default.png', layout: 'back_logo'

  #save_png prefix: 'output_test_backside_', dir: $direc
  save_sheet file: 'output_test_full_', dir: $direc
  #save_pdf file: 'output_test.pdf', dir: $direc

end
