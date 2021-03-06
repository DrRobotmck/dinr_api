
namespace :data_parser do
  desc "Parse raw data for inspection actions"
  task parse_actions: :environment do
    Action.destroy_all
    actions = []
    CSV.open("#{ENV['FILE_ROOT']}/Action.txt", encoding: 'windows-1251:utf-8') do |csv|
      # map? scope?
      csv.each do |row|
        if row[0].match(/2010/)
          actions << { code: row[2].strip, description: row[3] == "" ? "N/A" : row[3] }
        end
      end
    end
    Action.create(actions)
  end

  desc "Parse raw data for cuisine types"
  task parse_cuisines: :environment do
    Cuisine.destroy_all
    cuisines = []
    CSV.open("#{ENV['FILE_ROOT']}/Cuisine.txt", encoding: 'windows-1251:utf-8') do |csv|
      csv.each do |row|
        if row[0].match(/\d{2}/)
          cuisines << { code: row[0].strip, description: row[1].strip }
        end
      end
    end
    Cuisine.create(cuisines)
  end

  desc "Parse raw data for restaurant violations"
  task parse_violations: :environment do
    Violation.destroy_all
    unsanitized_lines = []
    violation_file = File.open("#{ENV['FILE_ROOT']}/Violation.txt", encoding: 'windows-1251:utf-8')
    violation_file.each_line("\r\n") do |line|
      if line.match(/2008-07-01/)
        unsanitized_lines.push(line)
      end
    end
    violations = unsanitized_lines.map do |line|
      split_line = line.split("\",\"")
      split_line[4] = split_line[4].match("\"\"") ? split_line[4].gsub("\"", "'") : split_line[4]
      compiled_violation = {
        code: split_line[3],
        critical_violation: split_line[2] == "Y" ? true : false,
        description: split_line[4]
      }
    end
    Violation.create(violations)
  end

  desc "Parse raw data for restaurant and inspection information"
  task parse_restaurant: :environment do
    Restaurant.destroy_all
    Inspection.destroy_all
    sanitized_lines = []
    restaurant_file = File.open("#{ENV['FILE_ROOT']}/WebExtract.txt", encoding: 'windows-1251:utf-8')
    restaurant_file.each_with_index("\r\n") do |line, index|
      sanitized_lines << line.split("\",\"").map{|column| column.gsub("\"","")}
    end
    sanitized_lines.each_with_index do |row, index|
      next if index == 0
      current_restaurant = Restaurant.find_by(camis: row[0])
      unless current_restaurant
        current_restaurant = Restaurant.create({
          camis: row[0],
          dba: row[1].gsub("\"", ""),
          building_number: row[3].strip,
          street_address: row[4].strip,
          zip_code: row[5],
          phone_number: row[6],
          current_grade: row[12],
          grade_date: row[13]
        })
      end
      current_restaurant.boro = Boro.find_by(identifier: row[2])
      current_restaurant.cuisine = Cuisine.find_by(code: row[7])
      inspection = Inspection.find_or_create_by({date_inspected: row[8], score: row[11]})
      Action.find_by(code: row[9]).inspections.push(inspection)
      violation = Violation.find_by(code: row[10])
      inspection.violations.push(violation) if violation
      current_restaurant.inspections.push(inspection)
      current_restaurant.save
    end
  end

  desc "Fix violations"
  task fix_violations: :environment do
    all_violations = Violation.all
    all_violations.each do |violation|
      violation.description = violation.description.gsub("\"", "")
      violation.save
    end
  end

end
