require 'CSV'

namespace :data_parser do
  desc "Parse raw data for inspection actions"
  task parse_actions: :environment do
    Action.destroy_all
    actions = []
    CSV.open('/Users/macadocious/Downloads/dohmh_restaurant-inspections_002/Action.txt') do |csv|
      csv.each do |row|
        if row[0].match(/2010/)
          actions << { code: row[2].strip, description: row[3] == "" ? "N/A" : row[3] }
        end
      end
    end
    Action.create(actions)
  end

  desc "TODO"
  task parse_cuisines: :environment do
    Cuisine.destroy_all
    cuisines = []
    CSV.open('/Users/macadocious/Downloads/dohmh_restaurant-inspections_002/Cuisine.txt', encoding: 'windows-1251:utf-8') do |csv|
      csv.each do |row|
        if row[0].match(/\d{2}/)
          cuisines << { code: row[0].strip, description: row[1].strip }
        end
      end
    end
    Cuisine.create(cuisines)
  end

  desc "TODO"
  task parse_violations: :environment do
    Violation.destroy_all
    violations = []
    CSV.open('/Users/macadocious/Downloads/dohmh_restaurant-inspections_002/Violation.txt', encoding: 'windows-1251:utf-8') do |csv|
      csv.each do |row|
        if row[0].match(/2010/)
          violation = {
            code: row[3],
            critical_violation: row[2] == "Y" ? true : false,
            description: row[4].strip
          }
          violations << violation
        end
      end
    end
    Violation.create(violations)
  end

  desc "TODO"
  task parse_restaurant: :environment do
  end

end
