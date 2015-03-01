class NewProjectForm < Form

  attr_accessor :name, :description, :project
  def initialize(options = {})
    super(options)
    initialize_communities(options[:communities])
    self.project = Project.new()
  end

  def submit(attrs)
    # separate our parameters for building referrential objects
    project_params = attrs[:project]
    reward_params = attrs[:project][:rewards_attributes]

    # create initial project object
    self.project = Project.new(
      name: project_params[:name],
      description: project_params[:description],
      completion_date: DateTime.new(project_params["completion_date(1i)"].to_i, project_params["completion_date(2i)"].to_i, project_params["completion_date(3i)"].to_i),
      initiator_id: user.id,
      target_amount: project_params["target_amount"],
      open: true
      )

    # add communities to project
    Community.active.each do |community|
      project.communities << community if attrs["community_#{community.id}"] == "true"
    end

    # get geo community ids
    processed_geo_params = []
    attrs[:geo_community].each do |data|
        if data.has_key? "city" and not data["city"].blank?
            processed_geo_params << data["city"]
        elsif data.has_key? "country" and not data["country"].blank?
            processed_geo_params << data["country"]
        else
            processed_geo_params << :WORLD
        end
    end
    geo_ids = GeoInfo::remove_redundancies(processed_geo_params)
    self.project.geo_communities_str = geo_ids.map(&:to_s).join(',')

    # build reward levels for project
    if reward_params.present?
      reward_params.each do |reward|
        reward = reward[1] # this is being created as a two item array, just grab the reward params
        self.project.rewards << Reward.create(
            reward_level: reward[:reward_level],
            description: reward[:description],
            project_id: self.project
          ) if (reward[:reward_level].present? && reward[:description].present?)
      end
    end

    self.project.save!
  end
end
