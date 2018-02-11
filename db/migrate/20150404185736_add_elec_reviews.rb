class AddElecReviews < ActiveRecord::Migration
  def up
  	require 'nokogiri'
	doc = Nokogiri::XML(File.open("negative.review") )
	pname=[]
	doc.xpath("/reviews/review/product_name").each do |record|
		pname<<record.text
   	end
	helpful=[]
	doc.xpath("/reviews/review/helpful").each do |record|
		helpful<<record.text
   	end
	rating=[]
	doc.xpath("/reviews/review/rating").each do |record|
		rating<<record.text
   	end
	revtext=[]
	doc.xpath("/reviews/review/review_text").each do |record|
		revtext<<record.text
   	end
   	doc = Nokogiri::XML(File.open("positive.review") )
   	doc.xpath("/reviews/review/product_name").each do |record|
		pname<<record.text
   	end
	doc.xpath("/reviews/review/helpful").each do |record|
		helpful<<record.text
   	end
	doc.xpath("/reviews/review/rating").each do |record|
		rating<<record.text
   	end
	doc.xpath("/reviews/review/review_text").each do |record|
		revtext<<record.text
   	end
   	
   	pt="electronics"
	for i in 0..1999

		p=pname[i]
		if ! p.valid_encoding?
  			p = p.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
		end
		#p=p.encode("UTF-8")
		h=helpful[i]
		if ! h.valid_encoding?
  			h = h.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
		end
		
		#h=h.encode("UTF-8")
		r=rating[i]
		#r=r.encode("UTF-8")
		if ! r.valid_encoding?
  			r = r.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
		end
		
		rt=revtext[i]
		#rt=rt.encode("UTF-8")
		if ! rt.valid_encoding?
  			rt = rt.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
		end
		if i<1000
			Review.create  product_name: p, product_type: pt,helpful: h,rating: r,review_text: rt, positive: false
		else
			Review.create  product_name: p, product_type: pt,helpful: h,rating: r,review_text: rt, positive: true
		end
	end
	

  end
  def down
  end
end
