class ClientMailer < ApplicationMailer
  # default from: 'info@appsgenii.com'
  def send_email(client_id, template_id)
    @template     = Template.find_by_id(template_id)
    @client       = Client.find_by_id(client_id)
    @html_content = content_setting(@template.html, @client)
    mail(:to => @client.email, :subject => @template.subject, :from => @template.from)
  end
  
  def content_setting(html, client)
    html = html.gsub("{{EMAIL}}", client.email)
    html = html.gsub("{{FIRST_NAME}}", client.first_name)
    html = html.gsub("{{LAST_NAME}}",  client.last_name)
    html = html.gsub("{{COMPANY}}", client.company)
    html = html.gsub("{{PHONE}}", client.phone)
    html
  end
end
