Given("I outline our dbs policy") do
  fill_in 'Outline your DBS policy in 50 words or less.', with: 'policy details'
end

Given("I choose {string} from the {string}") do |option, field|
  choose option, from: field
end

Given("I provide details") do
  fill_in 'Provide detail', with: 'Candidates need to be good'
end
