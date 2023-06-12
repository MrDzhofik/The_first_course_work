class Kur < ApplicationRecord
    establish_connection "other".to_sym
end
