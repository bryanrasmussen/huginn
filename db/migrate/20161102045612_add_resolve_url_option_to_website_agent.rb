class AddResolveUrlOptionToWebsiteAgent < ActiveRecord::Migration[5.0]
  def up
    Agents::WebsiteAgent.find_each do |agent|
      keys = agent.event_keys
      if keys.nil? || keys.include?('url')
        agent.options['resolve_url'] = true
      end
      agent.save!(validate: false)
    end
  end

  def down
    Agents::WebsiteAgent.find_each do |agent|
      if agent.options.delete('resolve_url')
        agent.save!(validate: false)
      end
    end
  end
end
