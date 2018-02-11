require 'libsvm'

require 'rubygems'
require 'fast_stemmer'
class ClassifierController < ApplicationController
  def classify_helpful
  	@eligible_reviews=Review.all
    #@eligible_reviews=Review.where(:use_for_train => true )
    i = 0
    @train_reviews = []
    while i < 60
      random_review = @eligible_reviews.sample
      @train_reviews<<random_review 
      i = i + 1
    end
    j = 0
    @test_reviews =[]
    while j < 30
      random_review = @eligible_reviews.sample
      @test_reviews<<random_review 
      j = j + 1
    end
    # the above part deals with generating a set of  
    documents = []
    @train_reviews.each do |r|
    if r.is_helpful
      documents<< [ 1, r.review_text ] 
    else
      documents<< [ 0, r.review_text ] 
    end 
    end
    sword=[]
    dictionary = documents.map(&:last).map(&:split).flatten.uniq
    dictionary = dictionary.map { |x| x.gsub(/\?|,|\.|\-/,'') }
    dictionary.each do |d|
      puts d
      sword=d.stem
      puts sword
    end
    training_set = []
    documents.each do |doc|
      features_array = dictionary.map { |x| doc.last.include?(x) ? 1 : 0 }
      training_set << [doc.first, Libsvm::Node.features(features_array)]
    end
    problem = Libsvm::Problem.new
    parameter = Libsvm::SvmParameter.new
    parameter.cache_size = 1 # in megabytes
    parameter.eps = 0.001
    parameter.c = 10
    problem.set_examples(training_set.map(&:first), training_set.map(&:last))
    model = Libsvm::Model.train(problem, parameter)
    test_set=[]
    counter=0
    @test_reviews.each do |tr|
      test_set<<[1,tr.review_text]
      test_document = test_set[counter].last.split.map{ |x| x.gsub(/\?|,|\.|\-/,'') }
      doc_features = dictionary.map{|x| test_document.include?(x) ? 1 : 0 }
      pred = model.predict(Libsvm::Node.features(doc_features))
      puts "Predicted #{pred==1 ? 'helpful' : 'not helpful'}"
      counter=counter+1
    end
  end

  def classify_positive
  	@eligible_reviews=Review.all
  	#@eligible_reviews=Review.where(:use_for_train => true )
    i = 0
    @train_reviews = []
    while i < 60
      random_review = @eligible_reviews.sample
      @train_reviews<<random_review 
      i = i + 1
    end
    j = 0
    @test_reviews =[]
    while j < 30
      random_review = @eligible_reviews.sample
      @test_reviews<<random_review 
      j = j + 1
    end
    # the above part deals with generating a set of  
    documents = []
    @train_reviews.each do |r|
    if r.positive
      documents<< [ 1, r.review_text ] 
    else
      documents<< [ 0, r.review_text ] 
    end 
    end
    sword=[]
    dictionary = documents.map(&:last).map(&:split).flatten.uniq
    dictionary = dictionary.map { |x| x.gsub(/\?|,|\.|\-/,'') }
    dictionary.each do |d|
      puts d
      sword=d.stem
      puts sword
    end
    training_set = []
    documents.each do |doc|
      features_array = dictionary.map { |x| doc.last.include?(x) ? 1 : 0 }
      training_set << [doc.first, Libsvm::Node.features(features_array)]
    end
    problem = Libsvm::Problem.new
    parameter = Libsvm::SvmParameter.new
    parameter.cache_size = 1 # in megabytes
    parameter.eps = 0.001
    parameter.c = 10
    problem.set_examples(training_set.map(&:first), training_set.map(&:last))
    model = Libsvm::Model.train(problem, parameter)
    test_set=[]
    counter=0
    @test_reviews.each do |tr|
      test_set<<[1,tr.review_text]
      test_document = test_set[counter].last.split.map{ |x| x.gsub(/\?|,|\.|\-/,'') }
      doc_features = dictionary.map{|x| test_document.include?(x) ? 1 : 0 }
      pred = model.predict(Libsvm::Node.features(doc_features))
      puts "Predicted #{pred==1 ? 'positive' : 'negative'}"
      counter=counter+1
    end
  end
end
