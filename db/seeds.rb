require 'httparty'

def fetch_all_card_data
  all_cards_data = []

  page = 1
  loop do
    response = HTTParty.get("https://api.scryfall.com/cards/search?q=format%3Apremodern&page=#{page}")

    if response.code == 200
      response_data = response.parsed_response['data']
      all_cards_data.concat(response_data)
      page += 1
    else
      puts "Failed to fetch card data from the Scryfall API. Error code: #{response.code}"
      break
    end
  end

  all_cards_data
end

cards_data = fetch_all_card_data

if cards_data.present?
  cards_data.each do |card_data|
    if card_data['legalities'].present? && card_data['legalities']['premodern'] == 'legal'
      image_uris = card_data['image_uris']

      if image_uris.present? && image_uris['normal'].present?
        card = Card.find_or_initialize_by(name: card_data['name'])

        if card.new_record?
          card.update!(
            mana_cost: card_data['mana_cost'],
            image: image_uris['normal'],
            card_type: card_data['type_line'],
            cmc: card_data['cmc'],
            colors: card_data['colors'],
            set_name: card_data['set_name'],
            rarity: card_data['rarity']
          )
          puts "Created card: #{card.name}"
        else
          puts "Card already exists: #{card.name}"
        end
      else
        puts "Missing image URI for card: #{card_data['name']}"
      end
    end
  end
else
  puts 'No card data available from the Scryfall API.'
end
