class ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def mark_eligible_reviews
	reviews=Review.where(:product_type =>"electronics")
	reviews.each do |r|
		r1=r.helpful.split
		hvotes=r1[0].to_i
		tvotes=r1[2].to_i
		if tvotes>0
			if hvotes < ( tvotes / 2 ) #unhelpful
				degree = ( tvotes - hvotes) / tvotes
			else #helpful
				degree = hvotes / tvotes
 			end 
			if degree > 0.7 && tvotes > 3
				r.use_for_train = true
			else
				r.use_for_train = false
			end 
		end
		r.save #persist to database
	end
  end

  def mark_helpful_reviews
	reviews=Review.where(:product_type =>"electronics")
	reviews.each do |r|
		r1=r.helpful.split
		hvotes=r1[0].to_i
		tvotes=r1[2].to_i
		if tvotes>0
			if hvotes < ( tvotes / 2 ) #unhelpful
				degree = ( tvotes - hvotes) / tvotes
			else #helpful
				degree = hvotes / tvotes
 			end 
			if degree > 0.499
				r.is_helpful = true
			else
				r.is_helpful = false
			end 
		end
		r.save #persist to database
	end
  end
end
