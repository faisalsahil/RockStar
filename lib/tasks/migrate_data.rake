task :migrate_data => :environment do
  class User1 < OtherConnection
    self.table_name = 'users'
  end

  class Project1 < OtherConnection
    self.table_name = 'projects'
  end

  class Category1 < OtherConnection
    self.table_name = 'categories'
  end

  class Endpoint < ApplicationRecord
    self.table_name = 'endpoints'
  end

  class EndPoint1 < OtherConnection
    self.table_name = 'end_points'
  end

  class UserProject1 < OtherConnection
    self.table_name = 'user_projects'
  end

  class Role < OtherConnection
  end

  # OK

  puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  puts User1.count
  puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  roles = ['administrator', 'user']
  roles.each do |role|
    Role.create!(name: role)
  end

  puts "Roles Created"

  Project.all.each do |project|
    Project1.create!(name: project.project_title, project_status: project.project_status)
  end
  puts "Project Created"

  Category.all.each do |category|
    Category1.create!(name: category.category_title, project_id: category.project_id)
  end
  puts "Category Created"

  Endpoint.all.each do |endpoint|
    EndPoint1.create!(name: endpoint.endpoint_name, url: endpoint.endpoint_url, method: endpoint.endpoint_method, request: endpoint.endpoint_json_request, response: endpoint.endpoint_json_response, notes: endpoint.endpoint_notes, category_id: endpoint.category_id, is_active: endpoint.endpoint_is_active)
  end
  puts "EndPoints Created"

  # UserProject.all.each do |project|
  #   UserProject1.create!(user_id: project.user_id, project_id: project.project_id, access_status: 1)
  # end


end