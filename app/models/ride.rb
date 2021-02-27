class Ride < ActiveRecord::Base
    belongs_to :user
    belongs_to :attraction

    def take_ride
        if too_poor || too_short
            # join the values of the two, disarding either if false
            ["Sorry.", too_poor, too_short].collect { |failure| failure if !!failure == true }.compact.join(" ")
        else
            self.user.tickets -= self.attraction.tickets
            self.user.happiness += self.attraction.happiness_rating
            self.user.nausea += self.attraction.nausea_rating
            self.user.save
            "Thanks for riding the #{self.attraction.name}!"
        end
    end

    def too_poor
        self.user.tickets < self.attraction.tickets ? "You do not have enough tickets to ride the #{self.attraction.name}." : false
    end

    def too_short
        self.user.height < self.attraction.min_height ? "You are not tall enough to ride the #{self.attraction.name}." : false 
    end
end
