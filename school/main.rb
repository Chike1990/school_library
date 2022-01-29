# rubocop:disable Metrics\CyclomaticComplexity, Metrics/MethodLength

require './person'
require './rental'
require './student'
require './book'
require './teacher'

class Library
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_all_books
    if @books.empty?
      puts 'The Book List is empty. To create a new book, click 4'
      return
    end
    @books.each do |book|
      print "Title: #{book.title.capitalize}, Author: #{book.author.capitalize}\n"
    end
  end

  def list_all_people
    if @people.empty?
      puts 'Your Library is empty. To add library users click 3'
      return
    end
    @people.each do |person|
      print "[#{person.class.name}] Name: #{person.name.capitalize}, ID: #{person.id}, Age: #{person.age}\n"
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '

    option = gets.chomp

    case option
    when '1'
      print 'Age: '
      age = gets.chomp
      print 'Name: '
      name = gets.chomp
      print 'Has parent permission? [Y/N]: '
      permission_resp = gets.chomp
      parent_permission = permission_resp.downcase == 'y'

      student = Student.new(age, name, parent_permission)
      @people.push(student)

      puts "Library user created successfuly\n"
    when '2'
      print 'Age: '
      age = gets.chomp
      print 'Name: '
      name = gets.chomp
      print 'Specialization: '
      specialization = gets.chomp

      teacher = Teacher.new(age, name, specialization)
      @people.push(teacher)

      puts "Library user created successfuly\n"

    else
      puts 'Please choose number 1 or 2'
      nil
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp.capitalize
    print 'Author: '
    author = gets.chomp.capitalize

    book = Book.new(title, author)
    @books << book

    puts "Library book created successfully\n"
  end

  def create_rental
    if @people.empty? && @books.empty?
      puts 'You have not recorded any rentals yet'
      return
    end
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, i|
      print "#{i}) Title: #{book.title}, Author: #{book.author}\n"
    end

    book_index = gets.chomp.to_i
    book = @books[book_index]

    puts 'Select a person from the following list by number (not ID)'
    @people.each_with_index do |person, i|
      print "#{i}) [#{person.class}] Name: #{person.name.capitalize}, ID: #{person.id}, Age: #{person.age}\n"
    end

    person_index = gets.chomp.to_i
    person = @people[person_index]

    print "\nDate: "

    date = gets.chomp

    rental = Rental.new(date, person, book)
    @rentals << rental

    puts "Rental created successfully\n"
  end

  def list_all_rental
    print 'ID of person: '
    id = gets.chomp.to_i

    puts 'Rentals: '

    rentals = @rentals.select { |rental| rental.person.id == id }

    if rentals.empty?
      puts 'No rentals found'
      return
    end

    rentals.each do |rental|
      print "Date: #{rental.date}, Book \'#{rental.book.title}\' by #{rental.book.author}\n"
    end
  end
end

def main
  response = nil

  app = Library.new

  puts "Welcome to OOP School Library App!\n\n "

  while response != '7'
    puts 'Please choose an option by entering a number :'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'

    response = gets.chomp

    puts "\n"

    case response
    when '1'
      app.list_all_books
    when '2'
      app.list_all_people
    when '3'
      app.create_person
    when '4'
      app.create_book
    when '5'
      app.create_rental
    when '6'
      app.list_all_rental
    when '7'
      puts 'Thanks for visiting OOP School Library app today!'
    else
      puts '❌ Choose an other number (from 1 to 6) if you want to exit choose 7'
    end
    puts "\n"

  end
end

main

# rubocop:enable Metrics\CyclomaticComplexity, Metrics/MethodLength
